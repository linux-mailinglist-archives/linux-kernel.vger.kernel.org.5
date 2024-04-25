Return-Path: <linux-kernel+bounces-159364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B608B2DB7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B7C1C21CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E302C16D9D1;
	Thu, 25 Apr 2024 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcuOsJve"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB89215AAA1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714088403; cv=none; b=frwhBm8z7OzACIbjwYn0JVRM49F5MWxYp9zrUn0kR+1UOqd7C3e6XJUDiaI61IF2vYLuW2YXxWbRjUJKu3lxmIaORuZEzhuRiypFRhOUJfsYwO6kbkOw5wnVMjRRpk+yIFvuq7l9KeyKP800S1OeUNeeqKb+oKYPrVwxu1fpz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714088403; c=relaxed/simple;
	bh=DLVkwBnctplZYeJO9Qab+V58q04REYulWvztmTUqov8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BJtBRe5VdPOYWoxFv/to2SP/mRxs0jhMePeDYZDFQYsEHNy8iLRnIdsLz8TS/H3zvrRNpkNNM8HMDm9ZhDVO2K7/4QHwOwN6NGHtjHZH5AytERfi4u/wDr/a3Ly4X515B6VtFY/SPp88nVeIl9/1fXShnrU+cUWtGNvMX825rz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZcuOsJve; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de59ff8af0bso1127552276.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714088400; x=1714693200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Sm/Nwd+keDoiSkXA1rIahABfNZCZE+Lf5pqQeKGPdBA=;
        b=ZcuOsJveV75fB1Zou3pkyUN36or78CgcQ7Wf8wbJVYbhUIUcZAiu9xzWBGho3cbXci
         bqfEuHzoPCU73X5dzsL7E7YH3dwz1GAxWnn+cOjXEca1etOX4WHkU1kmiyOi/kNRDMTc
         uB2nRbcGAPR7ABtOWwTb3wMiQs+UnwnAbxWhnLAMebYkeM+K42xhN8It0ebALZSEx6c6
         azRdpvx2jBFa2tBtlGhJUw1E4Joa5y3CX0bKDrpS5c0+Mbw1tGG6upEhtG9PAqkdtaAy
         VY8vNwp4GxdshMdAbBjGLe5aLuXalf9NTKMk+/w2aPjC2zSOYSem+Ma7PAKWLQk3VaP8
         WDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714088400; x=1714693200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sm/Nwd+keDoiSkXA1rIahABfNZCZE+Lf5pqQeKGPdBA=;
        b=bfrib4eQxLk2ItFnJ5rTPuPYfxaM4U3m6BGCzSxxSYfoNPf8ipzHrjIHWC8Ko2Na6i
         hpPFxalb4D0W9eMX4M65XQ0HwhRMBfTbdWAJ6JCbEmIstda3Msyp4OnNX0xYbnbnKP9A
         j7R40GZiCBtkhoOLCF6n8UVlXEicpFYNSjITWoicFkY+2cx4Ds41Yq6VkFWcZAquoWa6
         HAkb/wyCIc1o7e/zrlcy7bX8GFWb7+OBRM891vqpl3U4uRrrJ9b94laDgtsZN/5Hra7m
         s9EW24zxKZioHJGtVVDqvIw1MgDqOevDVIcpk77JmxliJ+ajiBhq75h12t5XrEyMOIuH
         CNjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNhy7QqOdwsRLY3iAVBEjjLHvmx1s2/FPC8MnRscVwmCYFy7MgKqI5lnEK1S+SU2n16PaybXJzsIpH3Fgtatl7vWi9EWaPs6vP+TZw
X-Gm-Message-State: AOJu0Yz0pI9w96RD3Es9BJ2HYXEelkJDhzMu80ZmoqBblFcy9gVUL4Jo
	LHeKVpd++eFTssI0xc6hbnDJVwV8GxfrUCKbtyilnqcT48Q90sbdtwB1Vvb28YA7YCnBG+b8cT7
	OIQ==
X-Google-Smtp-Source: AGHT+IHIvZeFy21VU3fyWm++MnV/Yc8tN9Aqs+7NCcUu4vlBSWU6oOWLy+cGUYar2HfcaZIONOO3XrHzrQw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:18cd:b0:dc6:b813:5813 with SMTP id
 ck13-20020a05690218cd00b00dc6b8135813mr126526ybb.9.1714088399909; Thu, 25 Apr
 2024 16:39:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Apr 2024 16:39:50 -0700
In-Reply-To: <20240425233951.3344485-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425233951.3344485-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240425233951.3344485-4-seanjc@google.com>
Subject: [PATCH 3/4] KVM: Register cpuhp and syscore callbacks when enabling hardware
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Register KVM's cpuhp and syscore callback when enabling virtualization
in hardware instead of registering the callbacks during initialization,
and let the CPU up/down framework invoke the inner enable/disable
functions.  Registering the callbacks during initialization makes things
more complex than they need to be, as KVM needs to be very careful about
handling races between enabling CPUs being onlined/offlined and hardware
being enabled/disabled.

Intel TDX support will require KVM to enable virtualization during KVM
initialization, i.e. will add another wrinkle to things, at which point
sorting out the potential races with kvm_usage_count would become even
more complex.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 170 +++++++++++++++-----------------------------
 1 file changed, 56 insertions(+), 114 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 10dad093b7fb..ad1b5a9e86d4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5490,7 +5490,7 @@ EXPORT_SYMBOL_GPL(kvm_rebooting);
 static DEFINE_PER_CPU(bool, hardware_enabled);
 static int kvm_usage_count;
 
-static int __hardware_enable_nolock(void)
+static int hardware_enable_nolock(void)
 {
 	if (__this_cpu_read(hardware_enabled))
 		return 0;
@@ -5505,34 +5505,18 @@ static int __hardware_enable_nolock(void)
 	return 0;
 }
 
-static void hardware_enable_nolock(void *failed)
-{
-	if (__hardware_enable_nolock())
-		atomic_inc(failed);
-}
-
 static int kvm_online_cpu(unsigned int cpu)
 {
-	int ret = 0;
-
 	/*
 	 * Abort the CPU online process if hardware virtualization cannot
 	 * be enabled. Otherwise running VMs would encounter unrecoverable
 	 * errors when scheduled to this CPU.
 	 */
-	mutex_lock(&kvm_lock);
-	if (kvm_usage_count)
-		ret = __hardware_enable_nolock();
-	mutex_unlock(&kvm_lock);
-	return ret;
+	return hardware_enable_nolock();
 }
 
-static void hardware_disable_nolock(void *junk)
+static void hardware_disable_nolock(void *ign)
 {
-	/*
-	 * Note, hardware_disable_all_nolock() tells all online CPUs to disable
-	 * hardware, not just CPUs that successfully enabled hardware!
-	 */
 	if (!__this_cpu_read(hardware_enabled))
 		return;
 
@@ -5543,78 +5527,10 @@ static void hardware_disable_nolock(void *junk)
 
 static int kvm_offline_cpu(unsigned int cpu)
 {
-	mutex_lock(&kvm_lock);
-	if (kvm_usage_count)
-		hardware_disable_nolock(NULL);
-	mutex_unlock(&kvm_lock);
+	hardware_disable_nolock(NULL);
 	return 0;
 }
 
-static void hardware_disable_all_nolock(void)
-{
-	BUG_ON(!kvm_usage_count);
-
-	kvm_usage_count--;
-	if (!kvm_usage_count)
-		on_each_cpu(hardware_disable_nolock, NULL, 1);
-}
-
-static void hardware_disable_all(void)
-{
-	cpus_read_lock();
-	mutex_lock(&kvm_lock);
-	hardware_disable_all_nolock();
-	mutex_unlock(&kvm_lock);
-	cpus_read_unlock();
-}
-
-static int hardware_enable_all(void)
-{
-	atomic_t failed = ATOMIC_INIT(0);
-	int r;
-
-	/*
-	 * Do not enable hardware virtualization if the system is going down.
-	 * If userspace initiated a forced reboot, e.g. reboot -f, then it's
-	 * possible for an in-flight KVM_CREATE_VM to trigger hardware enabling
-	 * after kvm_reboot() is called.  Note, this relies on system_state
-	 * being set _before_ kvm_reboot(), which is why KVM uses a syscore ops
-	 * hook instead of registering a dedicated reboot notifier (the latter
-	 * runs before system_state is updated).
-	 */
-	if (system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF ||
-	    system_state == SYSTEM_RESTART)
-		return -EBUSY;
-
-	/*
-	 * When onlining a CPU, cpu_online_mask is set before kvm_online_cpu()
-	 * is called, and so on_each_cpu() between them includes the CPU that
-	 * is being onlined.  As a result, hardware_enable_nolock() may get
-	 * invoked before kvm_online_cpu(), which also enables hardware if the
-	 * usage count is non-zero.  Disable CPU hotplug to avoid attempting to
-	 * enable hardware multiple times.
-	 */
-	cpus_read_lock();
-	mutex_lock(&kvm_lock);
-
-	r = 0;
-
-	kvm_usage_count++;
-	if (kvm_usage_count == 1) {
-		on_each_cpu(hardware_enable_nolock, &failed, 1);
-
-		if (atomic_read(&failed)) {
-			hardware_disable_all_nolock();
-			r = -EBUSY;
-		}
-	}
-
-	mutex_unlock(&kvm_lock);
-	cpus_read_unlock();
-
-	return r;
-}
-
 static void kvm_shutdown(void)
 {
 	/*
@@ -5646,8 +5562,7 @@ static int kvm_suspend(void)
 	lockdep_assert_not_held(&kvm_lock);
 	lockdep_assert_irqs_disabled();
 
-	if (kvm_usage_count)
-		hardware_disable_nolock(NULL);
+	hardware_disable_nolock(NULL);
 	return 0;
 }
 
@@ -5656,8 +5571,7 @@ static void kvm_resume(void)
 	lockdep_assert_not_held(&kvm_lock);
 	lockdep_assert_irqs_disabled();
 
-	if (kvm_usage_count)
-		WARN_ON_ONCE(__hardware_enable_nolock());
+	WARN_ON_ONCE(hardware_enable_nolock());
 }
 
 static struct syscore_ops kvm_syscore_ops = {
@@ -5665,6 +5579,54 @@ static struct syscore_ops kvm_syscore_ops = {
 	.resume = kvm_resume,
 	.shutdown = kvm_shutdown,
 };
+
+static int hardware_enable_all(void)
+{
+	int r;
+
+	guard(mutex)(&kvm_lock);
+
+	if (kvm_usage_count++)
+		return 0;
+
+	r = cpuhp_setup_state(CPUHP_AP_KVM_ONLINE, "kvm/cpu:online",
+			      kvm_online_cpu, kvm_offline_cpu);
+	if (r)
+		return r;
+
+	register_syscore_ops(&kvm_syscore_ops);
+
+	/*
+	 * Undo virtualization enabling and bail if the system is going down.
+	 * If userspace initiated a forced reboot, e.g. reboot -f, then it's
+	 * possible for an in-flight operation to enable virtualization after
+	 * syscore_shutdown() is called, i.e. without kvm_shutdown() being
+	 * invoked.  Note, this relies on system_state being set _before_
+	 * kvm_shutdown(), e.g. to ensure either kvm_shutdown() is invoked
+	 * or this CPU observes the impending shutdown.  Which is why KVM uses
+	 * a syscore ops hook instead of registering a dedicated reboot
+	 * notifier (the latter runs before system_state is updated).
+	 */
+	if (system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF ||
+	    system_state == SYSTEM_RESTART) {
+		unregister_syscore_ops(&kvm_syscore_ops);
+		cpuhp_remove_state(CPUHP_AP_KVM_ONLINE);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static void hardware_disable_all(void)
+{
+	guard(mutex)(&kvm_lock);
+
+	if (--kvm_usage_count)
+		return;
+
+	unregister_syscore_ops(&kvm_syscore_ops);
+	cpuhp_remove_state(CPUHP_AP_KVM_ONLINE);
+}
 #else /* CONFIG_KVM_GENERIC_HARDWARE_ENABLING */
 static int hardware_enable_all(void)
 {
@@ -6370,15 +6332,6 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	int r;
 	int cpu;
 
-#ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
-	r = cpuhp_setup_state_nocalls(CPUHP_AP_KVM_ONLINE, "kvm/cpu:online",
-				      kvm_online_cpu, kvm_offline_cpu);
-	if (r)
-		return r;
-
-	register_syscore_ops(&kvm_syscore_ops);
-#endif
-
 	/* A kmem cache lets us meet the alignment requirements of fx_save. */
 	if (!vcpu_align)
 		vcpu_align = __alignof__(struct kvm_vcpu);
@@ -6389,10 +6342,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 					   offsetofend(struct kvm_vcpu, stats_id)
 					   - offsetof(struct kvm_vcpu, arch),
 					   NULL);
-	if (!kvm_vcpu_cache) {
-		r = -ENOMEM;
-		goto err_vcpu_cache;
-	}
+	if (!kvm_vcpu_cache)
+		return -ENOMEM;
 
 	for_each_possible_cpu(cpu) {
 		if (!alloc_cpumask_var_node(&per_cpu(cpu_kick_mask, cpu),
@@ -6449,11 +6400,6 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	for_each_possible_cpu(cpu)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
 	kmem_cache_destroy(kvm_vcpu_cache);
-err_vcpu_cache:
-#ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
-	unregister_syscore_ops(&kvm_syscore_ops);
-	cpuhp_remove_state_nocalls(CPUHP_AP_KVM_ONLINE);
-#endif
 	return r;
 }
 EXPORT_SYMBOL_GPL(kvm_init);
@@ -6475,10 +6421,6 @@ void kvm_exit(void)
 	kmem_cache_destroy(kvm_vcpu_cache);
 	kvm_vfio_ops_exit();
 	kvm_async_pf_deinit();
-#ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
-	unregister_syscore_ops(&kvm_syscore_ops);
-	cpuhp_remove_state_nocalls(CPUHP_AP_KVM_ONLINE);
-#endif
 	kvm_irqfd_exit();
 }
 EXPORT_SYMBOL_GPL(kvm_exit);
-- 
2.44.0.769.g3c40516874-goog


