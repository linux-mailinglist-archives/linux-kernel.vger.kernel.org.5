Return-Path: <linux-kernel+bounces-107857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5447188029E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0982828565C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B901774A;
	Tue, 19 Mar 2024 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aev290IT"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580DA1171C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866659; cv=none; b=j2/BAhdHyo7+xJpE6er+IOfJ4HLz8gNWq7FooeZb8kSE9sUvo6YvidjTzzf2XWGeVmzBIMcRgAFGmt9iqlFvx9k/K6gIIix3KNVq5Hw2ZQv/anRKSUQfROFq9A3/N0LJrOqUgJ9FBS0QUBF6Bz8J6Mh6DjNGpeJRgxTeQQZV75U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866659; c=relaxed/simple;
	bh=+n/b8fA9MMXRAFLGykf1jkNKxKU7ByBWxVaJX4iqWpY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qR5JBacC2DjA1E2/nSJRfTGepo/Ki+rZtPbkNUyBhKJvjZII0CH0zOJq6NLQUXI8NNroRySHgwxOfHVJNTSAmBISWGLsXYBZhqGP4uVVVQPbvMK2zsSGCXI+lzw4pqnLPzI2DrvC7gmiDXL5m3Ps5Qp75tQTmTfGqx2ivbA1l3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aev290IT; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7cbf3ec6a96so4727539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710866655; x=1711471455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=55tADTKr/fKtx+P9Mx3gQHhaNaSTbLjPsk1QuvUf7uI=;
        b=aev290IT6mqhafhMQ3v+yjsIIJ3f8VQFG0x1rQDANfp2Yc4WuRQxdU7VV6UA/e3ELN
         CYn1BkWx25xosqrjb6uGm0UX/6PAqA9zraIY6Gl5hNqconPRokGpI2beZgttQaXrsxLI
         x8dZGcmBJ7NXPkSqPzQ0yI447UwkOoSrw2AFbb6bQVuElFb4Owpdn1yB43x/P6Arl+vv
         gYfTN0tNEAikzR7s8o1NNwBHdXnq1FzSksEeMe06N6bVm4eAiNdDio/FiUDBK+xGs9An
         rcYkUvUP5baBJV2EZ7YTi4PTDMdyR8v7vot/CPt4JELLj3T3jgsEG72wYxkWQHgfzCHM
         csOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866655; x=1711471455;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55tADTKr/fKtx+P9Mx3gQHhaNaSTbLjPsk1QuvUf7uI=;
        b=kFrmtIAfbBSi9wxVC+PD/2GGYP+mWhke4cAwGgFhkpuJAIPOdVispFrOM7imHIHFl+
         snMA8eXz6kLW4sc5wCdBpVW4n7lgJrzW4yvriJALD7AmmL5LanTq5CtosH9mOtPN5LZJ
         kwTg+d245fJKMUNKUCzZgRhnFwHLS/R82yDTm0b2yVIC4wW6OzaFkq0rx7scG6+YjTcU
         278eKAz0XXc7w+vPrnZ+J9R94cYHmbxCHXiKoviO3fwZjY9TX2CLb975H1+Dd2AHSijB
         8p6GhtU6Wi1+9u/FMJhqPfreiqDMpnkV+k6iKmpTZmKijRKGd1bCop6to4LbzzT47Fu3
         8VEw==
X-Forwarded-Encrypted: i=1; AJvYcCUmHYZYYoE+SRsye2YydEz1YTPg26F1qTekbKsYQxpqT5pGyLivnjZS/4SqaCb/pqBsp8+W5y8/R2hMSSBzh5yR0UKPxkP//au1hP88
X-Gm-Message-State: AOJu0YyZzz0efQhLOeSqhwM9bofEO3d9oIFlaALO/c7/eFX3cLPnAgiN
	6hUNb+EU1s+/zIVlRut2euxe8OPCSzLvQ6Q5twfbAjhZdJuqgpXD+kS2/fkp/xUWOKKpjZHUx6x
	bPQLTnjolM+9l4VkcqybX/Q==
X-Google-Smtp-Source: AGHT+IFRbk7J0ciLHbLLk9I3qhSS1omT3Bl07k9k3e57ZQB+uGmYZ+eVWm/uRTh6ZDfo3t25XVq4gku22P4yF8IxNA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6602:1491:b0:7c8:264d:5e98 with
 SMTP id a17-20020a056602149100b007c8264d5e98mr145907iow.0.1710866655492; Tue,
 19 Mar 2024 09:44:15 -0700 (PDT)
Date: Tue, 19 Mar 2024 16:43:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240319164341.1674863-1-coltonlewis@google.com>
Subject: [PATCH v2] KVM: arm64: Add KVM_CAP to control WFx trapping
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a KVM_CAP to control WFx (WFI or WFE) trapping based on scheduler
runqueue depth. This is so they can be passed through if the runqueue
is shallow or the CPU has support for direct interrupt injection. They
may be always trapped by setting this value to 0. Technically this
means traps will be cleared when the runqueue depth is 0, but that
implies nothing is running anyway so there is no reason to care. The
default value is 1 to preserve previous behavior before adding this
option.

Think about his option as a threshold. The instruction will be trapped
if the runqueue depth is higher than the threshold.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---

v2:
The last version was exclusively a flag to enable unconditional wfx
passthrough but there was feedback to make passthrough/trapping depend
on runqueue depth. I asked the last thread if there were any
preferences for the interface to accomplish this but I figured it's
easier to show code than wait for people telling me what to do.

v1:
https://lore.kernel.org/kvmarm/20240129213918.3124494-1-coltonlewis@google.com/

 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/arm.c              |  7 ++++++-
 include/linux/sched/stat.h        |  1 +
 include/uapi/linux/kvm.h          |  2 +-
 kernel/sched/core.c               | 15 +++++++++++++--
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 21c57b812569..79f461efaa6c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -317,6 +317,7 @@ struct kvm_arch {
 	 * the associated pKVM instance in the hypervisor.
 	 */
 	struct kvm_protected_vm pkvm;
+	u64 wfx_trap_runqueue_depth;
 };

 struct kvm_vcpu_fault_info {
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index a25265aca432..419eed6e1814 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -116,6 +116,9 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		}
 		mutex_unlock(&kvm->slots_lock);
 		break;
+	case KVM_CAP_ARM_WFX_TRAP_RUNQUEUE_DEPTH:
+		kvm->arch.wfx_trap_runqueue_depth = cap->args[0];
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -176,6 +179,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)

 	bitmap_zero(kvm->arch.vcpu_features, KVM_VCPU_MAX_FEATURES);

+	kvm->arch.wfx_trap_runqueue_depth = 1;
 	return 0;

 err_free_cpumask:
@@ -240,6 +244,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_SYSTEM_SUSPEND:
 	case KVM_CAP_IRQFD_RESAMPLE:
 	case KVM_CAP_COUNTER_OFFSET:
+	case KVM_CAP_ARM_WFX_TRAP_RUNQUEUE_DEPTH:
 		r = 1;
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
@@ -456,7 +461,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (kvm_arm_is_pvtime_enabled(&vcpu->arch))
 		kvm_make_request(KVM_REQ_RECORD_STEAL, vcpu);

-	if (single_task_running())
+	if (nr_running_this_cpu() <= vcpu->kvm->arch.wfx_trap_runqueue_depth)
 		vcpu_clear_wfx_traps(vcpu);
 	else
 		vcpu_set_wfx_traps(vcpu);
diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
index 0108a38bb64d..dc1541fcec56 100644
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -18,6 +18,7 @@ extern int nr_threads;
 DECLARE_PER_CPU(unsigned long, process_counts);
 extern int nr_processes(void);
 extern unsigned int nr_running(void);
+extern unsigned int nr_running_this_cpu(void);
 extern bool single_task_running(void);
 extern unsigned int nr_iowait(void);
 extern unsigned int nr_iowait_cpu(int cpu);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index c3308536482b..4c0ebf514c03 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1155,6 +1155,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_MEMORY_ATTRIBUTES 233
 #define KVM_CAP_GUEST_MEMFD 234
 #define KVM_CAP_VM_TYPES 235
+#define KVM_CAP_ARM_WFX_TRAP_RUNQUEUE_DEPTH 236

 #ifdef KVM_CAP_IRQ_ROUTING

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90346..b18f29964648 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5420,7 +5420,7 @@ unsigned int nr_running(void)
 }

 /*
- * Check if only the current task is running on the CPU.
+ * Return number of tasks running on this CPU.
  *
  * Caution: this function does not check that the caller has disabled
  * preemption, thus the result might have a time-of-check-to-time-of-use
@@ -5432,9 +5432,20 @@ unsigned int nr_running(void)
  *
  * - in a loop with very short iterations (e.g. a polling loop)
  */
+unsigned int nr_running_this_cpu(void)
+{
+	return raw_rq()->nr_running;
+}
+EXPORT_SYMBOL(nr_running_this_cpu);
+
+/*
+ * Check if only the current task is running on the CPU.
+ *
+ * Caution: see warning for nr_running_this_cpu
+ */
 bool single_task_running(void)
 {
-	return raw_rq()->nr_running == 1;
+	return nr_running_this_cpu() == 1;
 }
 EXPORT_SYMBOL(single_task_running);

--
2.44.0.291.gc1ea87d7ee-goog

