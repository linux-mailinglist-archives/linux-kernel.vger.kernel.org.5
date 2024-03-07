Return-Path: <linux-kernel+bounces-96308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBFA8759FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C0328372B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE8713DB83;
	Thu,  7 Mar 2024 22:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Gcra6qU1"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57460135A5C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 22:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849363; cv=none; b=TlUrbSUzA+Hx4LwijsFmHPLkwICGLchbcd0yZIiC/kyoWOLHS4YFYexpK/YT6e7mxJ+3NvRDrrUw7uokdLzo9V8v3aCryHQHgQW6Ea72JmT/9P3KJ14jtu6pBJldRFngiRRxxWvb+sBhq6eA4KzRaadP0uLw+WVz8rpMhSkk5cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849363; c=relaxed/simple;
	bh=vAdzToPuFiadhjRdva57YN1++dXHRx9iIG159uvmnjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byfwH1pTEGaKzEJ9r+0G0h6NrhZYeIgDIwsNT2rJefmyuOnWx9VLo7h4qumpnki8hPMKSMgP0G7izHwvkhqd6fHKfrsu4GTUNGmD1Xp+CNUCSXCMKJorFSoU3Prh6PJviArWmCI/Qi5eDbQZAmrez4Zo1ODzhAC/+1XHvxSSRL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Gcra6qU1; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d29111272eso21567151fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 14:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709849359; x=1710454159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NHQ32W6RSonxIEcKP3PBr7hrs/PAKBaa81snIL3bs2U=;
        b=Gcra6qU1KWW/G10wxjjQS0igLApkpii1YRm0p2GA4hZX+Sp3WsSRfmBGua9ICdbyxE
         +Kqo1Lb7v3It0xlzKgHEZ1eo7d7A5a6DQ3f/c20tWzOQXQzth7MO3yXRdGfIECL3qlYs
         6sXNYTP4ci6u4pZZPTBCBrFp+dv3819Pt8eT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709849359; x=1710454159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHQ32W6RSonxIEcKP3PBr7hrs/PAKBaa81snIL3bs2U=;
        b=ughQiJkQao+uwWAhri2LUhXk1uIttWnAKDfO/mtP+C6j4ONRt/ytcZp7InYcfUlrwA
         TiYg623yj3CNLkq+E394AzIQ2bEKoM3+UOeeU384hcTI3bqE1xZwoFrUh1m9udjK9xmU
         HxbMDxlGuGxm/RGQeCfKDTFNvmjDy/HX8b71gzlWnIJoyV34yOSnvdq+AO4X9OEHAp5a
         vgAX0m43Xd8ASUZsPStNl2DMp6enVejSlPWhWkpaS8xEncXW0ROx3ENpOU/2t3DnxJCW
         GtcbUX61IyRpxuCOO2HpBCS0GLbcvG23TAQK42daB6emJq3Z8RmJeupYR3TqGL00ggpy
         rVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOc09n/upkjLsUwGzLGI7H+nlt61BNwelaWXyNiw76dtHUQ3QJQRWhpBDHi6RHJbSvMcgPMV0X/xcpmoiG9k8fWb2kUSor7kIczVNK
X-Gm-Message-State: AOJu0YxRuUBA2CczqmtYs6whqVDz/jiZijPnWcV17Z5GBJuSLou3vqbo
	MpnfqDbjsUeDe0bGoA3vYh7cQgskppo33PS08eiVQ2QaN7oSK53popT1gkkig4jBsttw4INC5wF
	eIgCY8g==
X-Google-Smtp-Source: AGHT+IFAVns8os4EU5kGnFYmbjdlDRoFrGfDrQM3rl0rckLv7PV6IOy5yRQUbcq+TKqNV5/5LmQWFA==
X-Received: by 2002:a2e:9b43:0:b0:2d2:3fac:5fdc with SMTP id o3-20020a2e9b43000000b002d23fac5fdcmr2725552ljj.10.1709849358721;
        Thu, 07 Mar 2024 14:09:18 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id x25-20020a05651c105900b002d10dcacde3sm3088755ljm.66.2024.03.07.14.09.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 14:09:18 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5131c48055cso1631209e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 14:09:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmPvG2K6LL6RGGInd5QgnHC0wJxuCeED3Ki2zbF1rgFZYPBUpaN32ldZpzFEzqOYMHXDKlYhWqQYgEbyZLIhJ2XwrVx6EdyDGHvFED
X-Received: by 2002:ac2:5f69:0:b0:513:fe6:6003 with SMTP id
 c9-20020ac25f69000000b005130fe66003mr2044316lfc.11.1709849357476; Thu, 07 Mar
 2024 14:09:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <20240306142738.7b66a716@rorschach.local.home> <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
 <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop> <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
 <851dc594-d2ea-4050-b7c6-e33a1cddf3a1@efficios.com> <72b14322-78c1-4479-9c4e-b0e11c1f0d53@paulmck-laptop>
 <bebbed4a-ced1-42c5-865c-dc9dc7857b6c@efficios.com> <c1bb35c4-29af-4a84-8ba7-81ba30639a69@paulmck-laptop>
 <CAHk-=wia769uoyVz3P7yZURhO8NNB7xeOLX07ZM2vWf1nTLYkQ@mail.gmail.com>
 <65a9665e-22d4-4f21-a1cb-7ef1c82ed078@paulmck-laptop> <alpine.DEB.2.22.394.2403072231130.3161@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2403072231130.3161@hadrien>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 7 Mar 2024 14:09:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjq1g4jOhDvGNyvTiBxwhu97+Ymszf3W4i6MS1jqw5=kg@mail.gmail.com>
Message-ID: <CAHk-=wjq1g4jOhDvGNyvTiBxwhu97+Ymszf3W4i6MS1jqw5=kg@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: Julia Lawall <julia.lawall@inria.fr>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Steven Rostedt <rostedt@goodmis.org>, linke li <lilinke99@qq.com>, joel@joelfernandes.org, 
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	qiang.zhang1211@gmail.com, quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 13:40, Julia Lawall <julia.lawall@inria.fr> wrote:
>
> I tried the following:
>
> @@
> expression x;
> @@
>
> *WRITE_ONCE(x,<+...READ_ONCE(x)...+>)
>
> This gave a number of results, shown below.  Let me know if some of them
> are undesirable.

Well, all the ones you list do look like garbage.

That said, quite often the garbage does seem to be "we don't actually
care about the result". Several of them look like statistics.

Some of them look outright nasty, though:

> --- /home/julia/linux/net/netfilter/nf_tables_api.c
> +++ /tmp/nothing/net/netfilter/nf_tables_api.c
> @@ -10026,8 +10026,6 @@ static unsigned int nft_gc_seq_begin(str
>         unsigned int gc_seq;
>
>         /* Bump gc counter, it becomes odd, this is the busy mark. */
> -       gc_seq = READ_ONCE(nft_net->gc_seq);
> -       WRITE_ONCE(nft_net->gc_seq, ++gc_seq);

The above is garbage code, and the comment implies that it is garbage
code that _should_ be reliable.

> diff -u -p /home/julia/linux/fs/xfs/xfs_icache.c /tmp/nothing/fs/xfs/xfs_icache.c
> --- /home/julia/linux/fs/xfs/xfs_icache.c
> +++ /tmp/nothing/fs/xfs/xfs_icache.c
> @@ -2076,8 +2076,6 @@ xfs_inodegc_queue(
>         cpu_nr = get_cpu();
>         gc = this_cpu_ptr(mp->m_inodegc);
>         llist_add(&ip->i_gclist, &gc->list);
> -       items = READ_ONCE(gc->items);
> -       WRITE_ONCE(gc->items, items + 1);

In contrast, this is also garbage code, but the only user of it seems
to be a heuristic, so if 'items' is off by one (or by a hundred), it
probably doesn't matter.

The xfs code is basically using that 'items' count to decide if it
really wants to do GC or not.

This is actually a case where having a "UNSAFE_INCREMENTISH()" macro
might make sense.

That said, this is also a case where using a "local_t" and using
"local_add_return()" might be a better option. It falls back on true
atomics, but at least on x86 you probably get *better* code generation
for the "incrementish" operation than you get with READ_ONCE ->
WRITE_ONCE.


> diff -u -p /home/julia/linux/kernel/rcu/tree.c /tmp/nothing/kernel/rcu/tree.c
> --- /home/julia/linux/kernel/rcu/tree.c
> +++ /tmp/nothing/kernel/rcu/tree.c
> @@ -1620,8 +1620,6 @@ static void rcu_gp_fqs(bool first_time)
>         /* Clear flag to prevent immediate re-entry. */
>         if (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) {
>                 raw_spin_lock_irq_rcu_node(rnp);
> -               WRITE_ONCE(rcu_state.gp_flags,
> -                          READ_ONCE(rcu_state.gp_flags) & ~RCU_GP_FLAG_FQS);
>                 raw_spin_unlock_irq_rcu_node(rnp);

This smells bad to me. The code is holding a lock, but apparently not
one that protects gp_flags.

And that READ_ONCE->WRITE_ONCE sequence can corrupt all the other flags.

Maybe it's fine for some reason (that reason being either that the
ONCE operations aren't actually needed at all, or because nobody
*really* cares about the flags), but it smells.

> @@ -1882,8 +1880,6 @@ static void rcu_report_qs_rsp(unsigned l
>  {
>         raw_lockdep_assert_held_rcu_node(rcu_get_root());
>         WARN_ON_ONCE(!rcu_gp_in_progress());
> -       WRITE_ONCE(rcu_state.gp_flags,
> -                  READ_ONCE(rcu_state.gp_flags) | RCU_GP_FLAG_FQS);
>         raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(), flags);

Same field, same lock held, same odd smelly pattern.

> -       WRITE_ONCE(rcu_state.gp_flags,
> -                  READ_ONCE(rcu_state.gp_flags) | RCU_GP_FLAG_FQS);
>         raw_spin_unlock_irqrestore_rcu_node(rnp_old, flags);

. and again.

> --- /home/julia/linux/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
> +++ /tmp/nothing/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
> @@ -80,8 +80,6 @@ static int cn23xx_vf_reset_io_queues(str
>                                 q_no);
>                         return -1;
>                 }
> -               WRITE_ONCE(reg_val, READ_ONCE(reg_val) &
> -                          ~CN23XX_PKT_INPUT_CTL_RST);
>                 octeon_write_csr64(oct, CN23XX_VF_SLI_IQ_PKT_CONTROL64(q_no),
>                                    READ_ONCE(reg_val));

I suspect this is garbage that has been triggered by the usual
mindless "fix the symptoms, not the bug" as a result of a "undefined
behavior report".

>> --- /home/julia/linux/kernel/kcsan/kcsan_test.c
> +++ /tmp/nothing/kernel/kcsan/kcsan_test.c
> @@ -381,7 +381,6 @@ static noinline void test_kernel_change_
>                 test_var ^= TEST_CHANGE_BITS;
>                 kcsan_nestable_atomic_end();
>         } else
> -               WRITE_ONCE(test_var, READ_ONCE(test_var) ^ TEST_CHANGE_BITS);

Presumably this is intentionally testing whether KCSAN notices these
things at all.

> diff -u -p /home/julia/linux/arch/s390/kernel/idle.c /tmp/nothing/arch/s390/kernel/idle.c
>         /* Account time spent with enabled wait psw loaded as idle time. */
> -       WRITE_ONCE(idle->idle_time, READ_ONCE(idle->idle_time) + idle_time);
> -       WRITE_ONCE(idle->idle_count, READ_ONCE(idle->idle_count) + 1);
>         account_idle_time(cputime_to_nsecs(idle_time));

This looks like another "UNSAFE_INCREMENTISH()" case.

> --- /home/julia/linux/mm/mmap.c
> +++ /tmp/nothing/mm/mmap.c
> @@ -3476,7 +3476,6 @@ bool may_expand_vm(struct mm_struct *mm,
>
>  void vm_stat_account(struct mm_struct *mm, vm_flags_t flags, long npages)
>  {
> -       WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm)+npages);

As does this.

> diff -u -p /home/julia/linux/fs/xfs/libxfs/xfs_iext_tree.c /tmp/nothing/fs/xfs/libxfs/xfs_iext_tree.c
>  static inline void xfs_iext_inc_seq(struct xfs_ifork *ifp)
>  {
> -       WRITE_ONCE(ifp->if_seq, READ_ONCE(ifp->if_seq) + 1);
>  }

Ugh. A sequence count that is "incrementish"? That smells wrong to me.
But I didn't go look at the users. Maybe it's another case of "we
don't *actually* care about the sequence count".

>
> +++ /tmp/nothing/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
> @@ -379,8 +379,6 @@ static int cn23xx_reset_io_queues(struct
>                                 q_no);
>                         return -1;
>                 }
> -               WRITE_ONCE(reg_val, READ_ONCE(reg_val) &
> -                       ~CN23XX_PKT_INPUT_CTL_RST);
> ....
> -               WRITE_ONCE(d64, READ_ONCE(d64) &
> -                                       (~(CN23XX_PKT_INPUT_CTL_RING_ENB)));
> -               WRITE_ONCE(d64, READ_ONCE(d64) | CN23XX_PKT_INPUT_CTL_RST);


More "likely wrong" cases.

> +++ /tmp/nothing/mm/kfence/kfence_test.c
> @@ -501,7 +501,6 @@ static void test_kmalloc_aligned_oob_wri
>          * fault immediately after it.
>          */
>         expect.addr = buf + size;
> -       WRITE_ONCE(*expect.addr, READ_ONCE(*expect.addr) + 1);

Looks like questionable test-code again.

> +++ /tmp/nothing/io_uring/io_uring.c
> @@ -363,7 +363,6 @@ static void io_account_cq_overflow(struc
>  {
>         struct io_rings *r = ctx->rings;
>
> -       WRITE_ONCE(r->cq_overflow, READ_ONCE(r->cq_overflow) + 1);
>         ctx->cq_extra--;

Bah. Looks like garbage, but the kernel doesn't actually use that
value. Looks like a random number generator exposed to user space.
Presumably this is another "statistics, but I don't care enouhg".

> @@ -2403,8 +2402,6 @@ static bool io_get_sqe(struct io_ring_ct
> -                       WRITE_ONCE(ctx->rings->sq_dropped,
> -                                  READ_ONCE(ctx->rings->sq_dropped) + 1);

As is the above.

> +++ /tmp/nothing/security/apparmor/apparmorfs.c
> @@ -596,7 +596,6 @@ static __poll_t ns_revision_poll(struct
>
>  void __aa_bump_ns_revision(struct aa_ns *ns)
>  {
> -       WRITE_ONCE(ns->revision, READ_ONCE(ns->revision) + 1);
>         wake_up_interruptible(&ns->wait);

This looks like somebody copied the RCU / tracing pattern?

> +++ /tmp/nothing/arch/riscv/kvm/vmid.c
> @@ -90,7 +90,6 @@ void kvm_riscv_gstage_vmid_update(struct
>
>         /* First user of a new VMID version? */
>         if (unlikely(vmid_next == 0)) {
> -               WRITE_ONCE(vmid_version, READ_ONCE(vmid_version) + 1);
>                 vmid_next = 1;

Looks bogus and wrong. An unreliable address space version does _not_
sound sane, but who knows.

Anyway, from a quick look, there's a mix of "this is just wrong" and a
couple of "this seems to just want approximate statistics".

Maybe the RCU 'flags' field is using WRITE_ONCE() because while the
spinlock protects the bit changes, there are readers that look at
other bits with READ_ONCE.

That would imply that the READ_ONCE->WRITE_ONCE is just broken garbage
- the WRITE_ONCE() part may be right, but the READ_ONCE is wrong
because the value is stable.

                  Linus

