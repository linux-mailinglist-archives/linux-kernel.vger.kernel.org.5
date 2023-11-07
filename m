Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5B27E49B9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343881AbjKGUVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343919AbjKGUUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:20:51 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468D710C6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:20:34 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a8ee6a1801so83052767b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699388433; x=1699993233; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VURm3qKFEkUFzQoKppzRo3P8sq2mC6pF6UQMbNFBuGU=;
        b=S1fI+QILCpc7OMYIunVKk6SGSAgd243rL8Lj3ZEB/CjL2SRWRXhvhXUkK3A+0d68yS
         hA64NjlyA3Ewt6lZpWFbcyUdLdCzmBH6r7npStgq+M8/DWYp536IzLyNrjKXM+FL3ZIB
         gmak3PsOo424N4f63KkSO7ObobdFLaZbha0wIpyztWeNJMIANF7W85NBbCszWCoUbhWz
         4N7IVNNKBa8mIBsn1aqgT1M3NAJ1k8Z1PndRtfrAAO5IP9UQ84p1ZEKm/MPwTnQo4h33
         8lFuC8Rpb2MJq+RbvrERdHJzQEjS+rQP3h3BOugmxKTbEDh1eRHENIw1NNmZ4oeAZQx9
         vn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699388433; x=1699993233;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VURm3qKFEkUFzQoKppzRo3P8sq2mC6pF6UQMbNFBuGU=;
        b=vwqV6/zxtXttp1Tgu4ieXG7kMhQrVx4wwGf1kJ6kKQkBmPKXk1E4Y13Zw7ShHwD/NI
         AGeI+THLd86aLvjbUYLEYQp5ET+NsNRUUqRGrGGm2Z5rwjBaGAyTDmqpHz93RAVRRytS
         z8UIT8G0sLHgwhCjqHAnZDw73C3syqPL6G08ENWjHGLcmS5Dtd61p6t1cfK3C+rCKTuz
         hFaKNqeHONkaWBQfow4WYfAh35UDUdfoJ6aIlszorw9SWCm3fpshEH1AgtB670yXVAXx
         YpsiuboUVS1zowPyvhHbTYe5MykZdHXL/kLHJqgzp9629c/fdADrbeXN6dP+ShKHFvtS
         7dlg==
X-Gm-Message-State: AOJu0Yxo2boVK8G5XLqWfW9n6fu3lFPNrRtE64rlEm8omIoJ/8MydQ+6
        FL/WzSIrRWke7dipCSjEa5krNqulgAqdeQ==
X-Google-Smtp-Source: AGHT+IFYlMTykIoHKWEWEDPriu/uKFKRlV6F2t2qSqzBMtA10UXuJ3YvEShZloxNkRDrWSf1n76Juc61Tk6I7w==
X-Received: from aghulati-dev.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:18bb])
 (user=aghulati job=sendgmr) by 2002:a0d:e24b:0:b0:59b:eb63:4beb with SMTP id
 l72-20020a0de24b000000b0059beb634bebmr282724ywe.7.1699388433543; Tue, 07 Nov
 2023 12:20:33 -0800 (PST)
Date:   Tue,  7 Nov 2023 20:19:57 +0000
In-Reply-To: <20231107202002.667900-1-aghulati@google.com>
Mime-Version: 1.0
References: <20231107202002.667900-1-aghulati@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107202002.667900-10-aghulati@google.com>
Subject: [RFC PATCH 09/14] KVM: x86: Move shared KVM state into VAC
From:   Anish Ghulati <aghulati@google.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        peterz@infradead.org, paulmck@kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Venkatesh Srinivas <venkateshs@chromium.org>,
        Anish Ghulati <aghulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Venkatesh Srinivas <venkateshs@chromium.org>

Move kcpu_kick_mask and vm_running_vcpu* from arch neutral KVM code into
VAC.

TODO: Explain why this needs to be moved into VAC.

Signed-off-by: Venkatesh Srinivas <venkateshs@chromium.org>
Signed-off-by: Anish Ghulati <aghulati@google.com>
---
 virt/kvm/kvm_main.c | 6 ++++--
 virt/kvm/vac.c      | 5 +++++
 virt/kvm/vac.h      | 3 +++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fb50deaad3fd..575f044fd842 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -108,7 +108,6 @@ LIST_HEAD(vm_list);
 static struct kmem_cache *kvm_vcpu_cache;
 
 static __read_mostly struct preempt_ops kvm_preempt_ops;
-static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_running_vcpu);
 
 struct dentry *kvm_debugfs_dir;
 EXPORT_SYMBOL_GPL(kvm_debugfs_dir);
@@ -150,7 +149,10 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm);
 static unsigned long long kvm_createvm_count;
 static unsigned long long kvm_active_vms;
 
-static DEFINE_PER_CPU(cpumask_var_t, cpu_kick_mask);
+__weak void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
+						   unsigned long start, unsigned long end)
+{
+}
 
 __weak void kvm_arch_guest_memory_reclaimed(struct kvm *kvm)
 {
diff --git a/virt/kvm/vac.c b/virt/kvm/vac.c
index ff034a53af50..c628afeb3d4b 100644
--- a/virt/kvm/vac.c
+++ b/virt/kvm/vac.c
@@ -6,6 +6,11 @@
 #include <linux/percpu.h>
 #include <linux/mutex.h>
 
+DEFINE_PER_CPU(cpumask_var_t, cpu_kick_mask);
+EXPORT_SYMBOL(cpu_kick_mask);
+
+DEFINE_PER_CPU(struct kvm_vcpu *, kvm_running_vcpu);
+
 #ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
 DEFINE_MUTEX(vac_lock);
 
diff --git a/virt/kvm/vac.h b/virt/kvm/vac.h
index aed178a16bdb..f3e7b08168df 100644
--- a/virt/kvm/vac.h
+++ b/virt/kvm/vac.h
@@ -29,4 +29,7 @@ static inline void hardware_disable_all(void)
 }
 #endif /* CONFIG_KVM_GENERIC_HARDWARE_ENABLING */
 
+DECLARE_PER_CPU(cpumask_var_t, cpu_kick_mask);
+DECLARE_PER_CPU(struct kvm_vcpu *, kvm_running_vcpu);
+
 #endif
-- 
2.42.0.869.gea05f2083d-goog

