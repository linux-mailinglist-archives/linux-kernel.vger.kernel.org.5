Return-Path: <linux-kernel+bounces-131375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 345368986E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DDC31C26275
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFFE126F0F;
	Thu,  4 Apr 2024 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdQRIMBu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587DF83CA5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232814; cv=none; b=bm2If7sJ1GUMUPv2Ed5Vf0Ne1nHbKdVpsd73oeeibCi5Ik7IrNT4YyHSVhNfPSMdfKI4+KZycoAZT6A0ACQzmAOR4/kAmDj26HtcEyXWSYuTKnc/WMzKHK069vdpOHQhWe8HmwagL9wZXNvMRrIC5I3rYl0r1knX3GbSiGfO+z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232814; c=relaxed/simple;
	bh=rv5j84CNhgN6YnOmG6qLlZw/uEMRxjzm29RBSrTLips=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAFrSjpnnhRmrpaAWOl6mem1E/UWr/31qL69h+Nv5G1kI6GArlUA8PMw/C6SRalY3qFVTx23VhMg6ngx55TRk/KUuQeH8jPoZJCCXd2s8xtU4f2StUcJWi7fT1ecL32u0nooSWGIuP/Yvxg++QSP3IPYSOxPnJdltUAIxdvnnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WdQRIMBu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712232811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k7aZk0zNpBL9u8fV7aiCz2c4ESN3OsOrx4HHzO8rsqY=;
	b=WdQRIMBuIrFptg9YVeetsRbtBEK6DwWXnK/i3S9KEAL84k1o6br3c1jNkoW+cGMQnzmOYL
	x6b5BOdSOzKLHv2sI1S1q7H/QwH4fk5H5XltfIj0SIxyfOMsUlkYhYpBUCMU7gbikOnH4M
	h8daXI2i7Py1Hi4QUCqMzphvvOtvhis=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-3rcjkS8bMYy-IdehsYcUeQ-1; Thu, 04 Apr 2024 08:13:29 -0400
X-MC-Unique: 3rcjkS8bMYy-IdehsYcUeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AB5781A264;
	Thu,  4 Apr 2024 12:13:29 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 399A3202451F;
	Thu,  4 Apr 2024 12:13:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: michael.roth@amd.com,
	isaku.yamahata@intel.com
Subject: [PATCH v5 05/17] KVM: SEV: publish supported VMSA features
Date: Thu,  4 Apr 2024 08:13:15 -0400
Message-ID: <20240404121327.3107131-6-pbonzini@redhat.com>
In-Reply-To: <20240404121327.3107131-1-pbonzini@redhat.com>
References: <20240404121327.3107131-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Compute the set of features to be stored in the VMSA when KVM is
initialized; move it from there into kvm_sev_info when SEV is initialized,
and then into the initial VMSA.

The new variable can then be used to return the set of supported features
to userspace, via the KVM_GET_DEVICE_ATTR ioctl.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../virt/kvm/x86/amd-memory-encryption.rst    | 12 ++++++++++
 arch/x86/include/uapi/asm/kvm.h               |  9 +++++--
 arch/x86/kvm/svm/sev.c                        | 24 +++++++++++++++++--
 arch/x86/kvm/svm/svm.c                        |  1 +
 arch/x86/kvm/svm/svm.h                        |  2 ++
 5 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/kvm/x86/amd-memory-encryption.rst b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
index 84335d119ff1..2ea648e4c97a 100644
--- a/Documentation/virt/kvm/x86/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
@@ -425,6 +425,18 @@ issued by the hypervisor to make the guest ready for execution.
 
 Returns: 0 on success, -negative on error
 
+Device attribute API
+====================
+
+Attributes of the SEV implementation can be retrieved through the
+``KVM_HAS_DEVICE_ATTR`` and ``KVM_GET_DEVICE_ATTR`` ioctls on the ``/dev/kvm``
+device node, using group ``KVM_X86_GRP_SEV``.
+
+Currently only one attribute is implemented:
+
+* ``KVM_X86_SEV_VMSA_FEATURES``: return the set of all bits that
+  are accepted in the ``vmsa_features`` of ``KVM_SEV_INIT2``.
+
 Firmware Management
 ===================
 
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index ef11aa4cab42..b7dc515f4c27 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -457,8 +457,13 @@ struct kvm_sync_regs {
 
 #define KVM_STATE_VMX_PREEMPTION_TIMER_DEADLINE	0x00000001
 
-/* attributes for system fd (group 0) */
-#define KVM_X86_XCOMP_GUEST_SUPP	0
+/* vendor-independent attributes for system fd (group 0) */
+#define KVM_X86_GRP_SYSTEM		0
+#  define KVM_X86_XCOMP_GUEST_SUPP	0
+
+/* vendor-specific groups and attributes for system fd */
+#define KVM_X86_GRP_SEV			1
+#  define KVM_X86_SEV_VMSA_FEATURES	0
 
 struct kvm_vmx_nested_state_data {
 	__u8 vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5d41f27a8af5..5055935dfd1d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -46,6 +46,7 @@ module_param_named(sev_es, sev_es_enabled, bool, 0444);
 /* enable/disable SEV-ES DebugSwap support */
 static bool sev_es_debug_swap_enabled = false;
 module_param_named(debug_swap, sev_es_debug_swap_enabled, bool, 0444);
+static u64 sev_supported_vmsa_features;
 
 static u8 sev_enc_bit;
 static DECLARE_RWSEM(sev_deactivate_lock);
@@ -603,8 +604,8 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	save->xss  = svm->vcpu.arch.ia32_xss;
 	save->dr6  = svm->vcpu.arch.dr6;
 
-	if (sev_es_debug_swap_enabled) {
-		save->sev_features |= SVM_SEV_FEAT_DEBUG_SWAP;
+	if (sev_supported_vmsa_features) {
+		save->sev_features = sev_supported_vmsa_features;
 		pr_warn_once("Enabling DebugSwap with KVM_SEV_ES_INIT. "
 			     "This will not work starting with Linux 6.10\n");
 	}
@@ -1843,6 +1844,21 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	return ret;
 }
 
+int sev_dev_get_attr(u32 group, u64 attr, u64 *val)
+{
+	if (group != KVM_X86_GRP_SEV)
+		return -ENXIO;
+
+	switch (attr) {
+	case KVM_X86_SEV_VMSA_FEATURES:
+		*val = sev_supported_vmsa_features;
+		return 0;
+
+	default:
+		return -ENXIO;
+	}
+}
+
 int sev_mem_enc_ioctl(struct kvm *kvm, void __user *argp)
 {
 	struct kvm_sev_cmd sev_cmd;
@@ -2275,6 +2291,10 @@ void __init sev_hardware_setup(void)
 	if (!sev_es_enabled || !cpu_feature_enabled(X86_FEATURE_DEBUG_SWAP) ||
 	    !cpu_feature_enabled(X86_FEATURE_NO_NESTED_DATA_BP))
 		sev_es_debug_swap_enabled = false;
+
+	sev_supported_vmsa_features = 0;
+	if (sev_es_debug_swap_enabled)
+		sev_supported_vmsa_features |= SVM_SEV_FEAT_DEBUG_SWAP;
 }
 
 void sev_hardware_unsetup(void)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e7f47a1f3eb1..450535d6757f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5026,6 +5026,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
+	.dev_get_attr = sev_dev_get_attr,
 	.mem_enc_ioctl = sev_mem_enc_ioctl,
 	.mem_enc_register_region = sev_mem_enc_register_region,
 	.mem_enc_unregister_region = sev_mem_enc_unregister_region,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ec8ca7d92cf1..1c6601a9cbbf 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -692,6 +692,7 @@ void __init sev_set_cpu_caps(void);
 void __init sev_hardware_setup(void);
 void sev_hardware_unsetup(void);
 int sev_cpu_init(struct svm_cpu_data *sd);
+int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
 extern unsigned int max_sev_asid;
 #else
 static inline struct page *snp_safe_alloc_page(struct kvm_vcpu *vcpu) {
@@ -704,6 +705,7 @@ static inline void __init sev_set_cpu_caps(void) {}
 static inline void __init sev_hardware_setup(void) {}
 static inline void sev_hardware_unsetup(void) {}
 static inline int sev_cpu_init(struct svm_cpu_data *sd) { return 0; }
+static inline int sev_dev_get_attr(u32 group, u64 attr, u64 *val) { return -ENXIO; }
 #define max_sev_asid 0
 #endif
 
-- 
2.43.0



