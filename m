Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9520E7F6276
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346008AbjKWPPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjKWPPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:15:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21CCD47
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=V683QMURL7HKZaNFsMQ4IFqw95Out6ocw2bDd777YLI=; b=ZI2CtvmY2M9XGXAHfTYVxfQnmv
        LDPjvyKukfAES2vzAhrsXJG7rmOFooRxJmCBRfAU7avCz2RugPaTiecsT2/UWAIaJKwSIcvGnEXPX
        0qG/p0ibWMLuuHeApd9XF838NPPgEem+1YPpQTYvmavDA+hjp1aRbyCvtTtBQLTLJz9k94YBP02B0
        kNd840jNtHIQynSWZyGoKp2qWi6IUGhNGgzVVcZK7epmKPnKtxUcOaSd5nXMpaaxdOECtxzNZiq2n
        tePgDTZtYGN0sEzb/UCJ45SZVYeTNi2Mq9kB7S+ZfY/JjUqPBrCgEvGJiAaSjz+HZbD7nQ1x0EIVd
        0o50kP+w==;
Received: from [2a00:23ee:1848:82c:7ec2:e49:1f03:b05] (helo=[IPv6:::1])
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r6BQL-007evV-VB; Thu, 23 Nov 2023 15:15:26 +0000
Date:   Thu, 23 Nov 2023 15:15:20 +0000
From:   David Woodhouse <dwmw2@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_PROVE_RAW_LOCK_NESTING false positive?
User-Agent: K-9 Mail for Android
In-Reply-To: <20231123151345.GB38813@noisy.programming.kicks-ass.net>
References: <99771ef3a4966a01fefd3adbb2ba9c3a75f97cf2.camel@infradead.org> <20231123150119.GA38813@noisy.programming.kicks-ass.net> <1AEB1DFF-1B2B-4B59-A093-C9DBD91C9DD2@infradead.org> <20231123151345.GB38813@noisy.programming.kicks-ass.net>
Message-ID: <6E96F296-665D-4522-9531-914B7B340A89@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 November 2023 15:13:45 GMT, Peter Zijlstra <peterz@infradead=2Eorg> w=
rote:
>On Thu, Nov 23, 2023 at 03:05:15PM +0000, David Woodhouse wrote:
>> On 23 November 2023 15:01:19 GMT, Peter Zijlstra <peterz@infradead=2Eor=
g> wrote:
>> >On Thu, Nov 23, 2023 at 09:00:41AM +0000, David Woodhouse wrote:
>> >> Is this telling me that I'm no longer allowed to take a read_lock() =
in
>> >> a callback for an HRTIMER_MODE_ABS_HARD timer? Is that intentional?
>> >>=20
>> >> If I must, I can probably cope with this by using read_trylock()
>> >> instead=2E The object being locked is a cache, and we opportunistica=
lly
>> >> try to use it from the fast path but fall back to a slow path in
>> >> process context which will revalidate and try again=2E So if someone
>> >> *has* taken the write lock, it's a fairly safe bet that the cache is
>> >> going to be invalidated and we were going to take the slow path anyw=
ay=2E
>> >>=20
>> >> [   62=2E336965] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> [   62=2E336973] [ BUG: Invalid wait context ]
>> >> [   62=2E336992] 6=2E7=2E0-rc1+ #1437 Tainted: G          I      =20
>> >> [   62=2E337001] -----------------------------
>> >> [   62=2E337008] qemu-system-x86/1935 is trying to lock:
>> >> [   62=2E337017] ffffc900018fecc0 (&gpc->lock){=2E=2E=2E=2E}-{3:3}, =
at: kvm_xen_set_evtchn_fast+0xe7/0x460 [kvm]
>> >> [   62=2E337133] other info that might help us debug this:
>> >> [   62=2E337142] context-{2:2}
>> >> [   62=2E337148] 2 locks held by qemu-system-x86/1935:
>> >> [   62=2E337156]  #0: ffff888108f780b0 (&vcpu->mutex){+=2E+=2E}-{4:4=
}, at: kvm_vcpu_ioctl+0x7f/0x730 [kvm]
>> >> [   62=2E337239]  #1: ffffc900018ff2d8 (&kvm->srcu){=2E?=2E+}-{0:0},=
 at: kvm_xen_set_evtchn_fast+0xcd/0x460 [kvm]
>> >> [   62=2E337339] stack backtrace:
>> >> [   62=2E337346] CPU: 7 PID: 1935 Comm: qemu-system-x86 Tainted: G  =
        I        6=2E7=2E0-rc1+ #1437
>> >> [   62=2E337370] Hardware name: Intel Corporation S2600CW/S2600CW, B=
IOS SE5C610=2E86B=2E01=2E01=2E0008=2E021120151325 02/11/2015
>> >> [   62=2E337384] Call Trace:
>> >> [   62=2E337390]  <IRQ>
>> >> [   62=2E337395]  dump_stack_lvl+0x57/0x90
>> >> [   62=2E337407]  __lock_acquire+0x7bb/0xbb0
>> >> [   62=2E337416]  ? __lock_acquire+0x4f0/0xbb0
>> >> [   62=2E337425]  lock_acquire=2Epart=2E0+0xad/0x240
>> >> [   62=2E337433]  ? kvm_xen_set_evtchn_fast+0xe7/0x460 [kvm]
>> >> [   62=2E337512]  ? rcu_is_watching+0xd/0x40
>> >> [   62=2E337520]  ? lock_acquire+0xf2/0x110
>> >> [   62=2E337529]  __raw_read_lock_irqsave+0x4e/0xa0
>> >> [   62=2E337538]  ? kvm_xen_set_evtchn_fast+0xe7/0x460 [kvm]
>> >> [   62=2E337604]  kvm_xen_set_evtchn_fast+0xe7/0x460 [kvm]
>> >> [   62=2E337669]  ? kvm_xen_set_evtchn_fast+0xcd/0x460 [kvm]
>> >> [   62=2E337734]  xen_timer_callback+0x86/0xc0 [kvm]
>> >
>> >xen_timer_callback is HRTIMER_MODE_ABS_HARD, which means it will still
>> >run in IRQ context for PREEMPT_RT=2E
>> >
>> >OTOH read_lock_irqsave() is not a raw spinlock and will be turned into=
 a
>> >blocking lock=2E
>> >
>> >This then gives scheduling from IRQ context, which is somewhat frowned
>> >upon=2E
>> >
>> >Warning is real and valid=2E
>>=20
>>=20
>> =2E=2E=2E or at least will be when PREEMPT_RT turns the read_lock into =
a mutex?=20
>
>Right, this check specifically validates the RT lock nesting rules=2E
>
>> But there is no raw version of read_lock()=2E Can we have one please?
>
>Should be possible, but is somewhat non-trivial, it is very easy to
>create significant latencies with RW locks=2E Definitely not something I'=
m
>going to be able to do in a hurry=2E
>
>Also, I suspect Thomas is going to strongly suggest not going down that
>road and looking if this can be solved differently=2E

That's the "If I must=E2=80=A6" paragraph above=2E I'll hack it up=2E Than=
ks=2E

