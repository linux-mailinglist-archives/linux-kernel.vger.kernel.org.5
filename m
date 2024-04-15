Return-Path: <linux-kernel+bounces-145934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165C38A5CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CC3283621
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E64157491;
	Mon, 15 Apr 2024 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U9DsdJj6"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AF1156F4B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713216578; cv=none; b=JlkAKBWHsW8KU2G1JZtd61ltGb0LonMSuopF2rrI484/p9L5aH1LVr81Oqv10KzCp0nidiJwxt/JZNpY2mCqK56a5SxNTmDZXsBdlroHKpXal7GfyWYPNYkysl/yJIby3fD4TVbBWJyXxdih9KCNtqmlB5tlmpM3S03TsJExDlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713216578; c=relaxed/simple;
	bh=wRzkoeM6izLth76xabB3423FrZn8Vm+DOCcwDXcNbOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t5F2D2JPahN1x4t2PaDnY8qdEuvCKNPrRbuWDRfCTYpfR3GMsiZOi2/6E9KaHPKuHgw8/OKMdctaD8wM7BDsWea1kAdIEklz50ugIEP8aeM5SC4kulxguVhxUItZK6menxp9CabBCIS6kayr8T1gbdXREetIZLSgtZEYNGeJeXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U9DsdJj6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61890f3180aso43866307b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713216574; x=1713821374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWnJ31RAOiIsD4AZ7h9ip2gzbbUemOLkRWGv/kx/CW8=;
        b=U9DsdJj6YNqpvmhok4rzUZ4kYhujU4omV3ROuol0tg4XzvxRlBn3IUGLaqtNedKw+N
         nroY9imcGpjs9aIfMiFCraaUSRwZ2DtC67KFSHrQJOofXd75BCA5jTWf50FEqiJMEhJK
         OtRCSD0oHFWLzfPIEb76HbcnIDUpHfc31z22/H+eui1V9TgMuG66RHXFJXPZhL9dF1Wf
         N8tLLxlLTr13ZD+gyHjIFB9xrpIaLRTtFgojHcD0mlx9Cokdqjt7Lvgb1V8XbQ+lLqG4
         0VfgyQwzRWaNWmnB8+HigDe1koO1QLwBKO6L+M/FoPoLULqRKsT+A3Ed+9jSA71b8PP/
         om4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713216574; x=1713821374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWnJ31RAOiIsD4AZ7h9ip2gzbbUemOLkRWGv/kx/CW8=;
        b=Pk73p9JzmiIn3yVKZ8bWDOCFGDRn6skTy/W0BObgB7DPlfQn0w8d1W+7zSlGvlcaVs
         wrJ8e3bvcBVGPkMIfdYs+ay2ym0B+GqZfajKJuFkLJj3ue/lYH8aoiPeYpuoaUI/BEVL
         g7MZd7I3hT8h2hSxGFQEeBbCKtahquDbnwxnYfIjFEfxAQM7ZcYlIm0c7Zw+EFXrS0Up
         S4l67Shxknb3YB9hrTQp41awbFvKRv3kEKXA5vaCEjF9W1ZJSQMifUJbWmlbLTh/zdQv
         xHwPG3io2aaA/AC6Rvwa0EPYD1QjAWKENYikLTfHtoshWA6AGnNrCOOlNEYjR6us1z9Q
         lzog==
X-Forwarded-Encrypted: i=1; AJvYcCV2ENryBCnaO+Db2tgGOuUQ/Hivpq+OSNt436eHJ+lahUS3E9P8OvHj111xNKgIVnzRS8T0gcnS643TR8wNrqg6/8/kjfyZ4xq+VMjD
X-Gm-Message-State: AOJu0YwIZUKjyixbXxaWKh4RbLp1inR4Z6Jg2adquvZtOi8di/Lfa2Nw
	4FUxn5AQZK81RGoQLKhKw0JTmJgkhKV5dniBlU7Japp7gNg2FPtQvkAKJ0Y+8hwlgrFgdFoOpVQ
	DcQ==
X-Google-Smtp-Source: AGHT+IE3/b7TziIFxD/Ow4GbbODncedy/vFF/TWvAxQy9bhIZvb4XcWZNu7Rfwpscf/cD7lGXstn93e74+8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:ef02:0:b0:61a:d420:3b3e with SMTP id
 y2-20020a0def02000000b0061ad4203b3emr805971ywe.5.1713216574591; Mon, 15 Apr
 2024 14:29:34 -0700 (PDT)
Date: Mon, 15 Apr 2024 14:29:32 -0700
In-Reply-To: <Zh2EQVj5bC0z5R90@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328171949.743211-1-leobras@redhat.com> <ZgsXRUTj40LmXVS4@google.com>
 <ZhAAg8KNd8qHEGcO@tpad> <ZhAN28BcMsfl4gm-@google.com> <a7398da4-a72c-4933-bb8b-5bc8965d96d0@paulmck-laptop>
 <ZhQmaEXPCqmx1rTW@google.com> <Zh2EQVj5bC0z5R90@tpad>
Message-ID: <Zh2cPJ-5xh72ojzu@google.com>
Subject: Re: [RFC PATCH v1 0/2] Avoid rcu_core() if CPU just left guest vcpu
From: Sean Christopherson <seanjc@google.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Leonardo Bras <leobras@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 15, 2024, Marcelo Tosatti wrote:
> On Mon, Apr 08, 2024 at 10:16:24AM -0700, Sean Christopherson wrote:
> > On Fri, Apr 05, 2024, Paul E. McKenney wrote:
> > > Beyond a certain point, we have no choice.  How long should RCU let
> > > a CPU run with preemption disabled before complaining?  We choose 21
> > > seconds in mainline and some distros choose 60 seconds.  Android chooses
> > > 20 milliseconds for synchronize_rcu_expedited() grace periods.
> > 
> > Issuing a warning based on an arbitrary time limit is wildly different than using
> > an arbitrary time window to make functional decisions.  My objection to the "assume
> > the CPU will enter a quiescent state if it exited a KVM guest in the last second"
> > is that there are plenty of scenarios where that assumption falls apart, i.e. where
> > _that_ physical CPU will not re-enter the guest.
> > 
> > Off the top of my head:
> > 
> >  - If the vCPU is migrated to a different physical CPU (pCPU), the *old* pCPU
> >    will get false positives, and the *new* pCPU will get false negatives (though
> >    the false negatives aren't all that problematic since the pCPU will enter a
> >    quiescent state on the next VM-Enter.
> > 
> >  - If the vCPU halts, in which case KVM will schedule out the vCPU/task, i.e.
> >    won't re-enter the guest.  And so the pCPU will get false positives until the
> >    vCPU gets a wake event or the 1 second window expires.
> > 
> >  - If the VM terminates, the pCPU will get false positives until the 1 second
> >    window expires.
> > 
> > The false positives are solvable problems, by hooking vcpu_put() to reset
> > kvm_last_guest_exit.  And to help with the false negatives when a vCPU task is
> > scheduled in on a different pCPU, KVM would hook vcpu_load().
> 
> Hi Sean,
> 
> So this should deal with it? (untested, don't apply...).

Not entirely.  As I belatedly noted, hooking vcpu_put() doesn't handle the case
where the vCPU is preempted, i.e. kvm_sched_out() would also need to zero out
kvm_last_guest_exit to avoid a false positive.  Going through the scheduler will
note the CPU is quiescent for the current grace period, but after that RCU will
still see a non-zero kvm_last_guest_exit even though the vCPU task isn't actively
running.

And snapshotting the VM-Exit time will get false negatives when the vCPU is about
to run, but for whatever reason has kvm_last_guest_exit=0, e.g. if a vCPU was
preempted and/or migrated to a different pCPU.

I don't understand the motivation for keeping the kvm_last_guest_exit logic.  My
understanding is that RCU already has a timeout to avoid stalling RCU.  I don't
see what is gained by effectively duplicating that timeout for KVM.  Why not have
KVM provide a "this task is in KVM_RUN" flag, and then let the existing timeout
handle the (hopefully rare) case where KVM doesn't "immediately" re-enter the guest?

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 48f31dcd318a..be90d83d631a 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -477,6 +477,16 @@ static __always_inline void guest_state_enter_irqoff(void)
>  	lockdep_hardirqs_on(CALLER_ADDR0);
>  }
>  
> +DECLARE_PER_CPU(unsigned long, kvm_last_guest_exit);
> +
> +/*
> + * Returns time (jiffies) for the last guest exit in current cpu
> + */
> +static inline unsigned long guest_exit_last_time(void)
> +{
> +	return this_cpu_read(kvm_last_guest_exit);
> +}
> +
>  /*
>   * Exit guest context and exit an RCU extended quiescent state.
>   *
> @@ -488,6 +498,9 @@ static __always_inline void guest_state_enter_irqoff(void)
>  static __always_inline void guest_context_exit_irqoff(void)
>  {
>  	context_tracking_guest_exit();
> +
> +	/* Keeps track of last guest exit */
> +	this_cpu_write(kvm_last_guest_exit, jiffies);
>  }
>  
>  /*
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index fb49c2a60200..231d0e4d2cf1 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -110,6 +110,9 @@ static struct kmem_cache *kvm_vcpu_cache;
>  static __read_mostly struct preempt_ops kvm_preempt_ops;
>  static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_running_vcpu);
>  
> +DEFINE_PER_CPU(unsigned long, kvm_last_guest_exit);
> +EXPORT_SYMBOL_GPL(kvm_last_guest_exit);
> +
>  struct dentry *kvm_debugfs_dir;
>  EXPORT_SYMBOL_GPL(kvm_debugfs_dir);
>  
> @@ -210,6 +213,7 @@ void vcpu_load(struct kvm_vcpu *vcpu)
>  	int cpu = get_cpu();
>  
>  	__this_cpu_write(kvm_running_vcpu, vcpu);
> +	__this_cpu_write(kvm_last_guest_exit, 0);
>  	preempt_notifier_register(&vcpu->preempt_notifier);
>  	kvm_arch_vcpu_load(vcpu, cpu);
>  	put_cpu();
> @@ -222,6 +226,7 @@ void vcpu_put(struct kvm_vcpu *vcpu)
>  	kvm_arch_vcpu_put(vcpu);
>  	preempt_notifier_unregister(&vcpu->preempt_notifier);
>  	__this_cpu_write(kvm_running_vcpu, NULL);
> +	__this_cpu_write(kvm_last_guest_exit, 0);
>  	preempt_enable();
>  }
>  EXPORT_SYMBOL_GPL(vcpu_put);
> 

