Return-Path: <linux-kernel+bounces-55465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE19C84BD07
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5371C22716
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC565134BA;
	Tue,  6 Feb 2024 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bDr0CUys"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA43DDCF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244913; cv=none; b=iaUZMg8giGNaAJspkn/AvCutNmPiVyh/mNsDNAIXPuR6cG9T2GwJfsMULOHR7jSMHFjjQGeK7pJ1DmOMSxHsHwZe5nq2rlCjQE/KXU5Ua4XtrbG+HSw1ChrA9/RbfJbrW3yMjzGTMxRAlWurtFBbZY3OmCEla+IQN0oDWuFNHls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244913; c=relaxed/simple;
	bh=pcDXerDpSTpTS6QdIQIk2K3utU2iCr7Kw6sfneAblwY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VlPU6Hlyz7U4tehFPp9gJJlVvqK1lU3/NS2jpiO4/Bpxtgz9IRV/TPcbglcNuwRKJWqSDp7spmjJ1Ns2y1P0I7j4cYWKYbMu9e/TJSs29Y/wrN9jyrA2GQO75lk1KlW4/O+5ak3rCc8nrTEZ5ZdmFzuK2M1Wk+g7CNKvIOJn3uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bDr0CUys; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ecfd153ccfso102176157b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707244910; x=1707849710; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IEE6qJdSMo8xFvCuiSc+eHX6FTHMr/QDzym6H5ZgNGk=;
        b=bDr0CUysbmudDLrc9UHoFSaFaz47O5SdHKKuvFvWDNeQU7mmtKQWLvAyeH1TciEBsi
         AhER0h76Pyn0J2y3+h0z/DKtenx1QGCJbeXwnEi1l8WNKvIp5NYYeyTdgmW5cfTf7gnY
         MVPUP4MkQGOYtB6ZdvjXb47SyDMDjgrb2DOLu861Sf9kzqD8Cfe7TysgU4j0quqq7TaS
         KTKx0JLOkGFeyK+FG0Q3zNAKDdWSNXPfoa2qZc+E+tlbImQ52lcV3QtcgYf3oxv7cMFy
         Wd+IJfMnNTJmS98KI5Ag/K8asrkIZVTJXabQmM7btq7x77pwYUndugXbu18XHATTe7c6
         cWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707244910; x=1707849710;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEE6qJdSMo8xFvCuiSc+eHX6FTHMr/QDzym6H5ZgNGk=;
        b=f9krz887Fgew4SI6vhz2WTC+jPlob8dm7rZTJLWCdR/lW44yzC9P0H9i70FfEw9MPH
         r3e0kL2OafidYY3t0l8PlPqedeSqrvZiG1a2mOX0CVwdsAMi9A6R2FTs/LHf0avws8Ue
         1ZsPTxB/B6WtioXmnyoA9jJTX2qjxM4Iik75SXT7KHiQOHxPkxWTRF9seB3/xbmePqIH
         CrBdIFatZNpv5MRYpM9mr63G9mbko+kqrnTlE+bVI1o3OKQ1THOjjp5HsVczrsX6WISv
         kvV865UgbXnwaE8KJjW1ERXyME1FNQuLCDu70BXiLncrI6VLCDcd9HtOIL6fY3jobHEr
         WC3g==
X-Gm-Message-State: AOJu0YyR1R7i7f8DiIVWhucCxszNyfiO8vP6QuAXW0/Cj26QgmPZBh7O
	ysIQ5Qge+7LnoQJj/j3944Vl5C2HvAb2pC9FGauOS+IESB+RRAHbSdlUZZAYzDYyVh0C6mGNx9q
	G5g==
X-Google-Smtp-Source: AGHT+IHsH3rouT3UpTQZgoFPfC7QqzgRexlF674+2jygpINAzRlkLpujcVDIK4MZYuB8WyONvvalK5ySXqI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:98d8:0:b0:5e5:e1e2:31f with SMTP id
 p207-20020a8198d8000000b005e5e1e2031fmr509433ywg.6.1707244910578; Tue, 06 Feb
 2024 10:41:50 -0800 (PST)
Date: Tue, 6 Feb 2024 10:41:49 -0800
In-Reply-To: <f21ee3bd852761e7808240d4ecaec3013c649dc7.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <f21ee3bd852761e7808240d4ecaec3013c649dc7.camel@infradead.org>
Message-ID: <ZcJ9bXxU_Pthq_eh@google.com>
Subject: Re: [PATCH v3] KVM: x86: Use fast path for Xen timer delivery
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm <kvm@vger.kernel.org>, Paul Durrant <paul@xen.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Sep 30, 2023, David Woodhouse wrote:
> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 40edf4d1974c..75586da134b3 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -134,9 +134,23 @@ static enum hrtimer_restart xen_timer_callback(struct hrtimer *timer)
>  {
>  	struct kvm_vcpu *vcpu = container_of(timer, struct kvm_vcpu,
>  					     arch.xen.timer);
> +	struct kvm_xen_evtchn e;
> +	int rc;
> +
>  	if (atomic_read(&vcpu->arch.xen.timer_pending))
>  		return HRTIMER_NORESTART;
>  
> +	e.vcpu_id = vcpu->vcpu_id;
> +	e.vcpu_idx = vcpu->vcpu_idx;
> +	e.port = vcpu->arch.xen.timer_virq;
> +	e.priority = KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
> +
> +	rc = kvm_xen_set_evtchn_fast(&e, vcpu->kvm);
> +	if (rc != -EWOULDBLOCK) {
> +		vcpu->arch.xen.timer_expires = 0;
> +		return HRTIMER_NORESTART;
> +	}
> +
>  	atomic_inc(&vcpu->arch.xen.timer_pending);
>  	kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
>  	kvm_vcpu_kick(vcpu);
> @@ -146,6 +160,14 @@ static enum hrtimer_restart xen_timer_callback(struct hrtimer *timer)
>  
>  static void kvm_xen_start_timer(struct kvm_vcpu *vcpu, u64 guest_abs, s64 delta_ns)
>  {
> +	/*
> +	 * Avoid races with the old timer firing. Checking timer_expires
> +	 * to avoid calling hrtimer_cancel() will only have false positives
> +	 * so is fine.
> +	 */
> +	if (vcpu->arch.xen.timer_expires)
> +		hrtimer_cancel(&vcpu->arch.xen.timer);
> +
>  	atomic_set(&vcpu->arch.xen.timer_pending, 0);
>  	vcpu->arch.xen.timer_expires = guest_abs;
>  
> @@ -1019,9 +1041,36 @@ int kvm_xen_vcpu_get_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
>  		break;
>  
>  	case KVM_XEN_VCPU_ATTR_TYPE_TIMER:
> +		/*
> +		 * Ensure a consistent snapshot of state is captured, with a
> +		 * timer either being pending, or the event channel delivered
> +		 * to the corresponding bit in the shared_info. Not still
> +		 * lurking in the timer_pending flag for deferred delivery.
> +		 * Purely as an optimisation, if the timer_expires field is
> +		 * zero, that means the timer isn't active (or even in the
> +		 * timer_pending flag) and there is no need to cancel it.
> +		 */
> +		if (vcpu->arch.xen.timer_expires) {
> +			hrtimer_cancel(&vcpu->arch.xen.timer);
> +			kvm_xen_inject_timer_irqs(vcpu);

This has an obvious-in-hindsight recursive deadlock bug.  If KVM actually needs
to inject a timer IRQ, and the fast path fails, i.e. the gpc is invalid,
kvm_xen_set_evtchn() will attempt to acquire xen.xen_lock, which is already held.

Not sure if I sucked at testing before, or if I just got "lucky" on a random run.

 ============================================
 WARNING: possible recursive locking detected
 6.8.0-smp--5e10b4d51d77-drs #232 Tainted: G           O      
 --------------------------------------------
 xen_shinfo_test/250013 is trying to acquire lock:
 ffff938c9930cc30 (&kvm->arch.xen.xen_lock){+.+.}-{3:3}, at: kvm_xen_set_evtchn+0x74/0x170 [kvm]
 
 but task is already holding lock:
 ffff938c9930cc30 (&kvm->arch.xen.xen_lock){+.+.}-{3:3}, at: kvm_xen_vcpu_get_attr+0x38/0x250 [kvm]
 
 other info that might help us debug this:
  Possible unsafe locking scenario:
        CPU0
        ----
   lock(&kvm->arch.xen.xen_lock);
   lock(&kvm->arch.xen.xen_lock);
 
  *** DEADLOCK ***
  May be due to missing lock nesting notation
 2 locks held by xen_shinfo_test/250013:
  #0: ffff9228863f21a8 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x8f/0x5b0 [kvm]
  #1: ffff938c9930cc30 (&kvm->arch.xen.xen_lock){+.+.}-{3:3}, at: kvm_xen_vcpu_get_attr+0x38/0x250 [kvm]
 
 stack backtrace:
 CPU: 128 PID: 250013 Comm: xen_shinfo_test Tainted: G           O       6.8.0-smp--5e10b4d51d77-drs #232
 Hardware name: Google, Inc.                                                       Arcadia_IT_80/Arcadia_IT_80, BIOS 34.30.0 07/27/2023
 Call Trace:
  <TASK>
  dump_stack_lvl+0x69/0xa0
  dump_stack+0x14/0x20
  print_deadlock_bug+0x2af/0x2c0
  __lock_acquire+0x13f7/0x2e30
  lock_acquire+0xd4/0x220
  __mutex_lock+0x6a/0xa60
  mutex_lock_nested+0x1f/0x30
  kvm_xen_set_evtchn+0x74/0x170 [kvm]
  kvm_xen_vcpu_get_attr+0x136/0x250 [kvm]
  kvm_arch_vcpu_ioctl+0x942/0x1130 [kvm]
  kvm_vcpu_ioctl+0x484/0x5b0 [kvm]
  __se_sys_ioctl+0x7a/0xc0
  __x64_sys_ioctl+0x21/0x30
  do_syscall_64+0x82/0x160
  entry_SYSCALL_64_after_hwframe+0x63/0x6b
 RIP: 0033:0x460eab


