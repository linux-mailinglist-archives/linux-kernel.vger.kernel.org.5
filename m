Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF7F7F623D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbjKWPBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346016AbjKWPBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:01:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE4F10C6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=aQX4GZ2xQTBIswHV4ycagVcr5hJoMgvHBapp7TaZec4=; b=emR4qYGwVOgtW2x0kPC5lJ01/b
        SxHlgg9xPt3rjn0UES8VdrESsBRYZjIcD0prLSf5OaQ8ITkaB2tggE0GrMHBPBBwboYzEGDHbhy/c
        x4KntvoDXU3Wj2FOJeCoR1vl3jkKEcdLDoCyCYIM7B87fmDlVHw1iaNVWFnYmxcK15xqs7eaJkbe6
        u+/KFQizWryil8oCFsoe06FZ7VqCnv06gqkMFnyNHWbZ8XjKGkG+PaMpPPwMDVnzqXl6M/8tVcA+z
        0mxky5snWuN3BOeZBbbK2+FBDpmPXedK+WNdp3+ANBgEh2I9BdEEehp/B/eErt7GuOj3Timj2E0oW
        5JEUUCHA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r6BCj-007eFx-64; Thu, 23 Nov 2023 15:01:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10252300427; Thu, 23 Nov 2023 16:01:20 +0100 (CET)
Date:   Thu, 23 Nov 2023 16:01:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_PROVE_RAW_LOCK_NESTING false positive?
Message-ID: <20231123150119.GA38813@noisy.programming.kicks-ass.net>
References: <99771ef3a4966a01fefd3adbb2ba9c3a75f97cf2.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <99771ef3a4966a01fefd3adbb2ba9c3a75f97cf2.camel@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 09:00:41AM +0000, David Woodhouse wrote:
> Is this telling me that I'm no longer allowed to take a read_lock() in
> a callback for an HRTIMER_MODE_ABS_HARD timer? Is that intentional?
>=20
> If I must, I can probably cope with this by using read_trylock()
> instead. The object being locked is a cache, and we opportunistically
> try to use it from the fast path but fall back to a slow path in
> process context which will revalidate and try again. So if someone
> *has* taken the write lock, it's a fairly safe bet that the cache is
> going to be invalidated and we were going to take the slow path anyway.
>=20
> [   62.336965] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   62.336973] [ BUG: Invalid wait context ]
> [   62.336992] 6.7.0-rc1+ #1437 Tainted: G          I      =20
> [   62.337001] -----------------------------
> [   62.337008] qemu-system-x86/1935 is trying to lock:
> [   62.337017] ffffc900018fecc0 (&gpc->lock){....}-{3:3}, at: kvm_xen_set=
_evtchn_fast+0xe7/0x460 [kvm]
> [   62.337133] other info that might help us debug this:
> [   62.337142] context-{2:2}
> [   62.337148] 2 locks held by qemu-system-x86/1935:
> [   62.337156]  #0: ffff888108f780b0 (&vcpu->mutex){+.+.}-{4:4}, at: kvm_=
vcpu_ioctl+0x7f/0x730 [kvm]
> [   62.337239]  #1: ffffc900018ff2d8 (&kvm->srcu){.?.+}-{0:0}, at: kvm_xe=
n_set_evtchn_fast+0xcd/0x460 [kvm]
> [   62.337339] stack backtrace:
> [   62.337346] CPU: 7 PID: 1935 Comm: qemu-system-x86 Tainted: G         =
 I        6.7.0-rc1+ #1437
> [   62.337370] Hardware name: Intel Corporation S2600CW/S2600CW, BIOS SE5=
C610.86B.01.01.0008.021120151325 02/11/2015
> [   62.337384] Call Trace:
> [   62.337390]  <IRQ>
> [   62.337395]  dump_stack_lvl+0x57/0x90
> [   62.337407]  __lock_acquire+0x7bb/0xbb0
> [   62.337416]  ? __lock_acquire+0x4f0/0xbb0
> [   62.337425]  lock_acquire.part.0+0xad/0x240
> [   62.337433]  ? kvm_xen_set_evtchn_fast+0xe7/0x460 [kvm]
> [   62.337512]  ? rcu_is_watching+0xd/0x40
> [   62.337520]  ? lock_acquire+0xf2/0x110
> [   62.337529]  __raw_read_lock_irqsave+0x4e/0xa0
> [   62.337538]  ? kvm_xen_set_evtchn_fast+0xe7/0x460 [kvm]
> [   62.337604]  kvm_xen_set_evtchn_fast+0xe7/0x460 [kvm]
> [   62.337669]  ? kvm_xen_set_evtchn_fast+0xcd/0x460 [kvm]
> [   62.337734]  xen_timer_callback+0x86/0xc0 [kvm]

xen_timer_callback is HRTIMER_MODE_ABS_HARD, which means it will still
run in IRQ context for PREEMPT_RT.

OTOH read_lock_irqsave() is not a raw spinlock and will be turned into a
blocking lock.

This then gives scheduling from IRQ context, which is somewhat frowned
upon.

Warning is real and valid.
