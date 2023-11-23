Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8337F624A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345971AbjKWPF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345960AbjKWPFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:05:25 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7EDD53
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=fl5GR417vD/cSR4UbfUqtAuDkNy5kiy8TTtzorZd0Tw=; b=YoGVlDC5MbH/8v0dgwEqiNEqgZ
        6nj3reED/syhNm6A7Gkvq4/EddfDsrwKPeX0c1k7U6mIxrE3PJISPcwd5aPaJHb3bFjgKBZaYrCHo
        ObvxvIZnBAUF5HifaOunmHilKV02IHWLecxvcmKH20H599n2bce7Nv2YBLayGNcQM2Ny/ydnDADBn
        Dw9e8JYT9GZ/ShoPWXqXlWKkl0mUxA7h3uwjOsGMGVYbfzjgo3OjOVjZM3EIWSp8jpeeuIlSBZ4fA
        Ze0jyU1R6KWigyvetamCMaeWta4E5ihqKBSAjYrVEMpoliH97RTKe/oKwgPahWaNk7tXl9eOY9/s4
        2VfQuTCQ==;
Received: from [2a00:23ee:10f0:39bd:a0e:4593:9cf2:5c95] (helo=[IPv6:::1])
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r6BGb-00D4La-1s;
        Thu, 23 Nov 2023 15:05:22 +0000
Date:   Thu, 23 Nov 2023 15:05:15 +0000
From:   David Woodhouse <dwmw2@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_PROVE_RAW_LOCK_NESTING false positive?
User-Agent: K-9 Mail for Android
In-Reply-To: <20231123150119.GA38813@noisy.programming.kicks-ass.net>
References: <99771ef3a4966a01fefd3adbb2ba9c3a75f97cf2.camel@infradead.org> <20231123150119.GA38813@noisy.programming.kicks-ass.net>
Message-ID: <1AEB1DFF-1B2B-4B59-A093-C9DBD91C9DD2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 November 2023 15:01:19 GMT, Peter Zijlstra <peterz@infradead=2Eorg> w=
rote:
>On Thu, Nov 23, 2023 at 09:00:41AM +0000, David Woodhouse wrote:
>> Is this telling me that I'm no longer allowed to take a read_lock() in
>> a callback for an HRTIMER_MODE_ABS_HARD timer? Is that intentional?
>>=20
>> If I must, I can probably cope with this by using read_trylock()
>> instead=2E The object being locked is a cache, and we opportunistically
>> try to use it from the fast path but fall back to a slow path in
>> process context which will revalidate and try again=2E So if someone
>> *has* taken the write lock, it's a fairly safe bet that the cache is
>> going to be invalidated and we were going to take the slow path anyway=
=2E
>>=20
>> [   62=2E336965] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [   62=2E336973] [ BUG: Invalid wait context ]
>> [   62=2E336992] 6=2E7=2E0-rc1+ #1437 Tainted: G          I      =20
>> [   62=2E337001] -----------------------------
>> [   62=2E337008] qemu-system-x86/1935 is trying to lock:
>> [   62=2E337017] ffffc900018fecc0 (&gpc->lock){=2E=2E=2E=2E}-{3:3}, at:=
 kvm_xen_set_evtchn_fast+0xe7/0x460 [kvm]
>> [   62=2E337133] other info that might help us debug this:
>> [   62=2E337142] context-{2:2}
>> [   62=2E337148] 2 locks held by qemu-system-x86/1935:
>> [   62=2E337156]  #0: ffff888108f780b0 (&vcpu->mutex){+=2E+=2E}-{4:4}, =
at: kvm_vcpu_ioctl+0x7f/0x730 [kvm]
>> [   62=2E337239]  #1: ffffc900018ff2d8 (&kvm->srcu){=2E?=2E+}-{0:0}, at=
: kvm_xen_set_evtchn_fast+0xcd/0x460 [kvm]
>> [   62=2E337339] stack backtrace:
>> [   62=2E337346] CPU: 7 PID: 1935 Comm: qemu-system-x86 Tainted: G     =
     I        6=2E7=2E0-rc1+ #1437
>> [   62=2E337370] Hardware name: Intel Corporation S2600CW/S2600CW, BIOS=
 SE5C610=2E86B=2E01=2E01=2E0008=2E021120151325 02/11/2015
>> [   62=2E337384] Call Trace:
>> [   62=2E337390]  <IRQ>
>> [   62=2E337395]  dump_stack_lvl+0x57/0x90
>> [   62=2E337407]  __lock_acquire+0x7bb/0xbb0
>> [   62=2E337416]  ? __lock_acquire+0x4f0/0xbb0
>> [   62=2E337425]  lock_acquire=2Epart=2E0+0xad/0x240
>> [   62=2E337433]  ? kvm_xen_set_evtchn_fast+0xe7/0x460 [kvm]
>> [   62=2E337512]  ? rcu_is_watching+0xd/0x40
>> [   62=2E337520]  ? lock_acquire+0xf2/0x110
>> [   62=2E337529]  __raw_read_lock_irqsave+0x4e/0xa0
>> [   62=2E337538]  ? kvm_xen_set_evtchn_fast+0xe7/0x460 [kvm]
>> [   62=2E337604]  kvm_xen_set_evtchn_fast+0xe7/0x460 [kvm]
>> [   62=2E337669]  ? kvm_xen_set_evtchn_fast+0xcd/0x460 [kvm]
>> [   62=2E337734]  xen_timer_callback+0x86/0xc0 [kvm]
>
>xen_timer_callback is HRTIMER_MODE_ABS_HARD, which means it will still
>run in IRQ context for PREEMPT_RT=2E
>
>OTOH read_lock_irqsave() is not a raw spinlock and will be turned into a
>blocking lock=2E
>
>This then gives scheduling from IRQ context, which is somewhat frowned
>upon=2E
>
>Warning is real and valid=2E


=2E=2E=2E or at least will be when PREEMPT_RT turns the read_lock into a m=
utex? But there is no raw version of read_lock()=2E Can we have one please?

Thanks=2E=2E=2E=2E
