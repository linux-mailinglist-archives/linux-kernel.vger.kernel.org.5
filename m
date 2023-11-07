Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A3A7E49B6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343961AbjKGUVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbjKGUUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:20:49 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088011717
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:20:29 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5aecf6e30e9so82679177b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699388429; x=1699993229; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a2ib+rA4T4utSqnHV+qndOZ+e9EwMCLw6LRU8MPurDQ=;
        b=UYF06aXJeSpvK3/nTxALeIgmnd0m/9ul+VrZoKeDewIsSEJqkBiRqAs/UbYWoUZfW3
         bTkVKEghkat6844l8IaUS4Qe5csmMcNjdXOyxwvndqja6o+6nmC2476dBjc6UMf+3K+O
         YtzTSelKwPYtijur3z+TmHt3O7D9EShzuuYRlXFbvS/7PnY77v7YB4CVRVftyxlNh58/
         2/o84mQSVaJ5ALdYCECn8yNJpRfXlEaJHOtc0O+ueLbejm8wN3OkxJy19R9CHDQiwOn4
         R9NVGh81QzF6thS8qGH+bakiFdqopSUYPg6n+cJcX+EjFGmubyx5BQTGHC2Tw5UDYNrk
         LEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699388429; x=1699993229;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2ib+rA4T4utSqnHV+qndOZ+e9EwMCLw6LRU8MPurDQ=;
        b=NL5Hnt0L3nkFBTQIt99G7WGK4kingT37c6N+BOcDeYhNim7eKMxoHT0XnbuUbqDD+/
         j1Py1UFMFCb/9kkegg6YK5oXqbBPJQKE3L90USa1N1bhcpFarDZs1Lt3WVSj3M1Bu6R0
         rg6CmuPNhtWRCNHnOp2r/W/OF8vMlvJmDLvl45BM11Dq2Ses43KMbIQ0tT7i1+tAZ1TA
         AY9Vji2M9ZPHZZ3RStdhRG6odPFusCgUiu2WCX/PS7qje6n8lc2YMaSVirUPi6frciSV
         qtYfJaIVdgkNKhVRO4PCksImSjn8cgoMhbdWrpaqN5UurVe9Oyi782BZhgDQ1jwwkdpx
         2loQ==
X-Gm-Message-State: AOJu0YwMnQRzo/socyhywsj/QQ1UbMU7X2nn1RD7DE/Fnptl2oAWu4t3
        61XNwIErGZ0s8ckSPdgnhBqV5VWiQcdtcg==
X-Google-Smtp-Source: AGHT+IHHtbOnHl93HG8ZXUVwWTOGVN0m/BXCyF0SZXevfyIsFrPX0M12OPNWezfirtAPs4IcbWCrJMOA0zCGyA==
X-Received: from aghulati-dev.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:18bb])
 (user=aghulati job=sendgmr) by 2002:a81:9182:0:b0:59b:e81f:62ab with SMTP id
 i124-20020a819182000000b0059be81f62abmr294528ywg.7.1699388429222; Tue, 07 Nov
 2023 12:20:29 -0800 (PST)
Date:   Tue,  7 Nov 2023 20:19:56 +0000
In-Reply-To: <20231107202002.667900-1-aghulati@google.com>
Mime-Version: 1.0
References: <20231107202002.667900-1-aghulati@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107202002.667900-9-aghulati@google.com>
Subject: [RFC PATCH 08/14] KVM: VMX: Move shared VMX data structures into VAC
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
Cc:     Anish Ghulati <aghulati@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move vmxarea and current_vmcs into VAC.

Move VPID bitmap into the VAC

TODO: Explain why this data needs to be shared among multiple KVM
modules and moved into VAC.

Signed-off-by: Venkatesh Srinivas <venkateshs@chromium.org>
Signed-off-by: Anish Ghulati <aghulati@google.com>
---
 arch/x86/kvm/vmx/nested.c |  1 +
 arch/x86/kvm/vmx/vac.c    | 47 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vac.h    | 12 ++++++++++
 arch/x86/kvm/vmx/vmx.c    | 41 +++++-----------------------------
 arch/x86/kvm/vmx/vmx.h    |  2 --
 5 files changed, 65 insertions(+), 38 deletions(-)
 create mode 100644 arch/x86/kvm/vmx/vac.h

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index c5ec0ef51ff7..5c6ac7662453 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -14,6 +14,7 @@
 #include "pmu.h"
 #include "sgx.h"
 #include "trace.h"
+#include "vac.h"
 #include "vmx.h"
 #include "x86.h"
 #include "smm.h"
diff --git a/arch/x86/kvm/vmx/vac.c b/arch/x86/kvm/vmx/vac.c
index 4aabf16d2fc0..7b8ade0fb97f 100644
--- a/arch/x86/kvm/vmx/vac.c
+++ b/arch/x86/kvm/vmx/vac.c
@@ -1,2 +1,49 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <asm/percpu.h>
+#include <linux/percpu-defs.h>
+
+#include "vac.h"
+
+
+static DEFINE_PER_CPU(struct vmcs *, vmxarea);
+
+DEFINE_PER_CPU(struct vmcs *, current_vmcs);
+
+void vac_set_vmxarea(struct vmcs *vmcs, int cpu)
+{
+	per_cpu(vmxarea, cpu) = vmcs;
+}
+
+struct vmcs *vac_get_vmxarea(int cpu)
+{
+	return per_cpu(vmxarea, cpu);
+}
+
+static DECLARE_BITMAP(vmx_vpid_bitmap, VMX_NR_VPIDS);
+static DEFINE_SPINLOCK(vmx_vpid_lock);
+
+int allocate_vpid(void)
+{
+	int vpid;
+
+	if (!enable_vpid)
+		return 0;
+	spin_lock(&vmx_vpid_lock);
+	vpid = find_first_zero_bit(vmx_vpid_bitmap, VMX_NR_VPIDS);
+	if (vpid < VMX_NR_VPIDS)
+		__set_bit(vpid, vmx_vpid_bitmap);
+	else
+		vpid = 0;
+	spin_unlock(&vmx_vpid_lock);
+	return vpid;
+}
+
+void free_vpid(int vpid)
+{
+	if (!enable_vpid || vpid == 0)
+		return;
+	spin_lock(&vmx_vpid_lock);
+	__clear_bit(vpid, vmx_vpid_bitmap);
+	spin_unlock(&vmx_vpid_lock);
+}
diff --git a/arch/x86/kvm/vmx/vac.h b/arch/x86/kvm/vmx/vac.h
new file mode 100644
index 000000000000..46c54fe7447d
--- /dev/null
+++ b/arch/x86/kvm/vmx/vac.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <asm/vmx.h>
+
+#include "../vac.h"
+#include "vmcs.h"
+
+void vac_set_vmxarea(struct vmcs *vmcs, int cpu);
+
+struct vmcs *vac_get_vmxarea(int cpu);
+int allocate_vpid(void);
+void free_vpid(int vpid);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7fea84a17edf..407e37810419 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -60,6 +60,7 @@
 #include "pmu.h"
 #include "sgx.h"
 #include "trace.h"
+#include "vac.h"
 #include "vmcs.h"
 #include "vmcs12.h"
 #include "vmx.h"
@@ -455,17 +456,12 @@ noinline void invept_error(unsigned long ext, u64 eptp, gpa_t gpa)
 			ext, eptp, gpa);
 }
 
-static DEFINE_PER_CPU(struct vmcs *, vmxarea);
-DEFINE_PER_CPU(struct vmcs *, current_vmcs);
 /*
  * We maintain a per-CPU linked-list of VMCS loaded on that CPU. This is needed
  * when a CPU is brought down, and we need to VMCLEAR all VMCSs loaded on it.
  */
 static DEFINE_PER_CPU(struct list_head, loaded_vmcss_on_cpu);
 
-static DECLARE_BITMAP(vmx_vpid_bitmap, VMX_NR_VPIDS);
-static DEFINE_SPINLOCK(vmx_vpid_lock);
-
 struct vmcs_config vmcs_config __ro_after_init;
 struct vmx_capability vmx_capability __ro_after_init;
 
@@ -2792,7 +2788,7 @@ static int kvm_cpu_vmxon(u64 vmxon_pointer)
 static int vmx_hardware_enable(void)
 {
 	int cpu = raw_smp_processor_id();
-	u64 phys_addr = __pa(per_cpu(vmxarea, cpu));
+	u64 phys_addr = __pa(vac_get_vmxarea(cpu));
 	int r;
 
 	if (cr4_read_shadow() & X86_CR4_VMXE)
@@ -2921,8 +2917,8 @@ static void free_kvm_area(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		free_vmcs(per_cpu(vmxarea, cpu));
-		per_cpu(vmxarea, cpu) = NULL;
+		free_vmcs(vac_get_vmxarea(cpu));
+		vac_set_vmxarea(NULL, cpu);
 	}
 }
 
@@ -2952,7 +2948,7 @@ static __init int alloc_kvm_area(void)
 		if (kvm_is_using_evmcs())
 			vmcs->hdr.revision_id = vmcs_config.revision_id;
 
-		per_cpu(vmxarea, cpu) = vmcs;
+		vac_set_vmxarea(vmcs, cpu);
 	}
 	return 0;
 }
@@ -3897,31 +3893,6 @@ static void seg_setup(int seg)
 	vmcs_write32(sf->ar_bytes, ar);
 }
 
-int allocate_vpid(void)
-{
-	int vpid;
-
-	if (!enable_vpid)
-		return 0;
-	spin_lock(&vmx_vpid_lock);
-	vpid = find_first_zero_bit(vmx_vpid_bitmap, VMX_NR_VPIDS);
-	if (vpid < VMX_NR_VPIDS)
-		__set_bit(vpid, vmx_vpid_bitmap);
-	else
-		vpid = 0;
-	spin_unlock(&vmx_vpid_lock);
-	return vpid;
-}
-
-void free_vpid(int vpid)
-{
-	if (!enable_vpid || vpid == 0)
-		return;
-	spin_lock(&vmx_vpid_lock);
-	__clear_bit(vpid, vmx_vpid_bitmap);
-	spin_unlock(&vmx_vpid_lock);
-}
-
 static void vmx_msr_bitmap_l01_changed(struct vcpu_vmx *vmx)
 {
 	/*
@@ -8538,8 +8509,6 @@ static __init int hardware_setup(void)
 	kvm_caps.has_bus_lock_exit = cpu_has_vmx_bus_lock_detection();
 	kvm_caps.has_notify_vmexit = cpu_has_notify_vmexit();
 
-	set_bit(0, vmx_vpid_bitmap); /* 0 is reserved for host */
-
 	if (enable_ept)
 		kvm_mmu_set_ept_masks(enable_ept_ad_bits,
 				      cpu_has_vmx_ept_execute_only());
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 476119670d82..03b11159fde5 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -376,8 +376,6 @@ struct kvm_vmx {
 
 void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
 			struct loaded_vmcs *buddy);
-int allocate_vpid(void);
-void free_vpid(int vpid);
 void vmx_set_constant_host_state(struct vcpu_vmx *vmx);
 void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu);
 void vmx_set_host_fs_gs(struct vmcs_host_state *host, u16 fs_sel, u16 gs_sel,
-- 
2.42.0.869.gea05f2083d-goog

