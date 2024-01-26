Return-Path: <linux-kernel+bounces-40524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD3183E1E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B87A1F28FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFFF21A0C;
	Fri, 26 Jan 2024 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKRJBr+8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A181200D2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294774; cv=none; b=PNvB5EWxORA7Ow6ucZJN93oeAV5UcgiNwaICAp/d3rUSBcPesstQmakZJmlAGTJiqMoBx5L2NxcdLYiVMtfhnjP9/uphkXDY1vVDbpFCAs0RGfnxlgS0XslR4WhDQpWHvN+mQ98fp7QurXxVsI0rxO9urjiIpt7689lBBSIkLbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294774; c=relaxed/simple;
	bh=Pi1H1v2txq2Pi37UwQSnLaAZAbhT3iyI5PYxgw+NsAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QXLPaCuOWWROvHMK2Br/A2l0MUN0g+IZ+jZ19FhMwPT3tIWy9Rx2iw2kc9hZzVKLuy3Letf4kwxGidcNlTk2E5IMOdcZMZ+RXiBn9gj6fUzz22ZI3IYSuWG/6/CpUydqT6nzYfMwNjGrWSz0/4UxNC0abpz6T0v54kTx/Ksrc28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKRJBr+8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706294771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RKs48FQbd9FNeqPhxajh602gnifp1I14sgFmxWPk/Nc=;
	b=fKRJBr+8bNQtVFEj+trNSokc364pHHzD+UZLBcldOPa0xWBB9rGdt9VEel9aI8YBOEI3DG
	GlcQYH3Cdy7sgglAA9I1HtZEEDwuTPHeOGCA4Lk4q1PNn9OIOeu41CeZisft58eETDKKqM
	2RY7kLcUVxKapyYUsRfNfTV7cfXfvb0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-34_5SqFYMgienixdVjGB9g-1; Fri,
 26 Jan 2024 13:46:03 -0500
X-MC-Unique: 34_5SqFYMgienixdVjGB9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4174A3C100B2;
	Fri, 26 Jan 2024 18:46:03 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1FA36A2E;
	Fri, 26 Jan 2024 18:46:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PATCH v2] KVM: x86: Give a hint when Win2016 might fail to boot due to XSAVES erratum
Date: Fri, 26 Jan 2024 13:46:02 -0500
Message-Id: <20240126184602.2410991-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Since commit b0563468eeac ("x86/CPU/AMD: Disable XSAVES on AMD family 0x17")
kernel unconditionally clears the XSAVES CPU feature bit on Zen1/2 CPUs.

Because KVM CPU caps are initialized from the kernel boot CPU features this
makes the XSAVES feature also unavailable for KVM guests in this case.
At the same time the XSAVEC feature is left enabled.

Unfortunately, having XSAVEC but no XSAVES in CPUID breaks Hyper-V enabled
Windows Server 2016 VMs that have more than one vCPU.

Let's at least give users hint in the kernel log what could be wrong since
these VMs currently simply hang at boot with a black screen - giving no
clue what suddenly broke them and how to make them work again.

Trigger the kernel message hint based on the particular guest ID written to
the Guest OS Identity Hyper-V MSR implemented by KVM.

Defer this check to when the L1 Hyper-V hypervisor enables SVM in EFER
since we want to limit this message to Hyper-V enabled Windows guests only
(Windows session running nested as L2) but the actual Guest OS Identity MSR
write is done by L1 and happens before it enables SVM.

Fixes: b0563468eeac ("x86/CPU/AMD: Disable XSAVES on AMD family 0x17")
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Message-Id: <b83ab45c5e239e5d148b0ae7750133a67ac9575c.1706127425.git.maciej.szmigiero@oracle.com>
[Move some checks before mutex_lock(), rename function. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/hyperv.c           | 50 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/hyperv.h           |  3 ++
 arch/x86/kvm/x86.c              |  4 +++
 4 files changed, 59 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b5b2d0fde579..d271ba20a0b2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1145,6 +1145,8 @@ struct kvm_hv {
 	unsigned int synic_auto_eoi_used;
 
 	struct kvm_hv_syndbg hv_syndbg;
+
+	bool xsaves_xsavec_checked;
 };
 #endif
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 4943f6b2bbee..8a47f8541eab 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1322,6 +1322,56 @@ static bool hv_check_msr_access(struct kvm_vcpu_hv *hv_vcpu, u32 msr)
 	return false;
 }
 
+#define KVM_HV_WIN2016_GUEST_ID 0x1040a00003839
+#define KVM_HV_WIN2016_GUEST_ID_MASK (~GENMASK_ULL(23, 16)) /* mask out the service version */
+
+/*
+ * Hyper-V enabled Windows Server 2016 SMP VMs fail to boot in !XSAVES && XSAVEC
+ * configuration.
+ * Such configuration can result from, for example, AMD Erratum 1386 workaround.
+ *
+ * Print a notice so users aren't left wondering what's suddenly gone wrong.
+ */
+static void __kvm_hv_xsaves_xsavec_maybe_warn(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_hv *hv = to_kvm_hv(kvm);
+
+	/* Check again under the hv_lock.  */
+	if (hv->xsaves_xsavec_checked)
+		return;
+
+	if ((hv->hv_guest_os_id & KVM_HV_WIN2016_GUEST_ID_MASK) !=
+	    KVM_HV_WIN2016_GUEST_ID)
+		return;
+
+	hv->xsaves_xsavec_checked = true;
+
+	/* UP configurations aren't affected */
+	if (atomic_read(&kvm->online_vcpus) < 2)
+		return;
+
+	if (guest_cpuid_has(vcpu, X86_FEATURE_XSAVES) ||
+	    !guest_cpuid_has(vcpu, X86_FEATURE_XSAVEC))
+		return;
+
+	pr_notice_ratelimited("Booting SMP Windows KVM VM with !XSAVES && XSAVEC. "
+			      "If it fails to boot try disabling XSAVEC in the VM config.\n");
+}
+
+void kvm_hv_xsaves_xsavec_maybe_warn(struct kvm_vcpu *vcpu)
+{
+	struct kvm_hv *hv = to_kvm_hv(vcpu->kvm);
+
+	if (!vcpu->arch.hyperv_enabled ||
+	    hv->xsaves_xsavec_checked)
+		return;
+
+	mutex_lock(&hv->hv_lock);
+	__kvm_hv_xsaves_xsavec_maybe_warn(vcpu);
+	mutex_unlock(&hv->hv_lock);
+}
+
 static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 			     bool host)
 {
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 1dc0b6604526..923e64903da9 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -182,6 +182,8 @@ void kvm_hv_setup_tsc_page(struct kvm *kvm,
 			   struct pvclock_vcpu_time_info *hv_clock);
 void kvm_hv_request_tsc_page_update(struct kvm *kvm);
 
+void kvm_hv_xsaves_xsavec_maybe_warn(struct kvm_vcpu *vcpu);
+
 void kvm_hv_init_vm(struct kvm *kvm);
 void kvm_hv_destroy_vm(struct kvm *kvm);
 int kvm_hv_vcpu_init(struct kvm_vcpu *vcpu);
@@ -267,6 +269,7 @@ int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu);
 static inline void kvm_hv_setup_tsc_page(struct kvm *kvm,
 					 struct pvclock_vcpu_time_info *hv_clock) {}
 static inline void kvm_hv_request_tsc_page_update(struct kvm *kvm) {}
+static inline void kvm_hv_xsaves_xsavec_maybe_warn(struct kvm_vcpu *vcpu) {}
 static inline void kvm_hv_init_vm(struct kvm *kvm) {}
 static inline void kvm_hv_destroy_vm(struct kvm *kvm) {}
 static inline int kvm_hv_vcpu_init(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9a89471a613c..bf10a9073a09 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1782,6 +1782,10 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	if ((efer ^ old_efer) & KVM_MMU_EFER_ROLE_BITS)
 		kvm_mmu_reset_context(vcpu);
 
+	if (!static_cpu_has(X86_FEATURE_XSAVES) &&
+	    (efer & EFER_SVME))
+		kvm_hv_xsaves_xsavec_maybe_warn(vcpu);
+
 	return 0;
 }
 
-- 
2.39.1


