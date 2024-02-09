Return-Path: <linux-kernel+bounces-59810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F2384FC09
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660CB1C23A72
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C4284A32;
	Fri,  9 Feb 2024 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wx+CJldu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2565A79DC0
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503870; cv=none; b=GoqRVi2Y3OypYZj8FywnEz0snEjB00sTQ9usBNa7qs5Q9Qw74CjdsVtf5QeFcOqTN1Z56shZL+O9dFNmPAvA7cwZM9PMwtDdxW4NQxRBNdr5fXrC4LM8+xLnQwaGKgqC1BeDVGJPlUu//ZO4Xo2z4r8IP8GgHYGUjArYWLIGcZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503870; c=relaxed/simple;
	bh=WZ1/d2KR0LuKPt05QHr/o1pwc5Vpxj+JUnn+ez4us+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6v7p08ZfxAtbl0Q16MLkThQztysPzazY2DqskAaWCr860KMswJMR3RARNUOVG4hYD8UuTGg6Izm4+YcCvrOdPXLn1SyjjniX4IZr3VQbPFq/a6vHiiFvF4Fvf/D0xl1JlDjvlG9kiNxzZVEknoxbSxc8htr+zmkDUd20Gbxojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wx+CJldu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707503868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sD8I36BUwxjBu+kOcyWGRMBfaLnGRDzVELraK43EXi4=;
	b=Wx+CJlduY9mFRxeSuh8GGpiLvkdcYg2rTNjAkIF3fpqPu080UYvmxy/6vcRdbN3YhMPMK3
	yYHcH4vC1qCsMDORbxLnHXBl521IUYvnGv9lZ3Uivnu1JDlqAhQLB7fkE2Z/AUW8Hhc1iN
	xX42sONbRKjn21cTJxnjkR71BGWQ8x0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-WpigEx_aPzWAdya9DJAeTQ-1; Fri, 09 Feb 2024 13:37:46 -0500
X-MC-Unique: WpigEx_aPzWAdya9DJAeTQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7BC085A58A;
	Fri,  9 Feb 2024 18:37:45 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 79FAC492BC6;
	Fri,  9 Feb 2024 18:37:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com,
	aik@amd.com,
	isaku.yamahata@intel.com
Subject: [PATCH 08/10] KVM: SEV: define VM types for SEV and SEV-ES
Date: Fri,  9 Feb 2024 13:37:40 -0500
Message-Id: <20240209183743.22030-9-pbonzini@redhat.com>
In-Reply-To: <20240209183743.22030-1-pbonzini@redhat.com>
References: <20240209183743.22030-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virt/kvm/api.rst  |  2 ++
 arch/x86/include/uapi/asm/kvm.h |  2 ++
 arch/x86/kvm/svm/sev.c          | 18 +++++++++++++++++-
 arch/x86/kvm/svm/svm.c          | 11 +++++++++++
 arch/x86/kvm/svm/svm.h          |  2 ++
 arch/x86/kvm/x86.c              |  4 ++++
 6 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 3ec0b7a455a0..bf957bb70e4b 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8790,6 +8790,8 @@ means the VM type with value @n is supported.  Possible values of @n are::
 
   #define KVM_X86_DEFAULT_VM	0
   #define KVM_X86_SW_PROTECTED_VM	1
+  #define KVM_X86_SEV_VM	8
+  #define KVM_X86_SEV_ES_VM	10
 
 9. Known KVM API problems
 =========================
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 6c74db23257e..7c46e96cfe62 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -854,5 +854,7 @@ struct kvm_hyperv_eventfd {
 
 #define KVM_X86_DEFAULT_VM	0
 #define KVM_X86_SW_PROTECTED_VM	(KVM_X86_DEFAULT_VM | __KVM_X86_PRIVATE_MEM_TYPE)
+#define KVM_X86_SEV_VM		8
+#define KVM_X86_SEV_ES_VM	(KVM_X86_SEV_VM | __KVM_X86_PROTECTED_STATE_TYPE)
 
 #endif /* _ASM_X86_KVM_H */
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 712bfbc0028a..acf5c45ef14e 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -260,6 +260,9 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (kvm->created_vcpus)
 		return -EINVAL;
 
+	if (kvm->arch.vm_type != KVM_X86_DEFAULT_VM)
+		return -EINVAL;
+
 	ret = -EBUSY;
 	if (unlikely(sev->active))
 		return ret;
@@ -279,6 +282,7 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 	INIT_LIST_HEAD(&sev->regions_list);
 	INIT_LIST_HEAD(&sev->mirror_vms);
+	sev->need_init = false;
 
 	kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_SEV);
 
@@ -1814,7 +1818,8 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	if (ret)
 		goto out_fput;
 
-	if (sev_guest(kvm) || !sev_guest(source_kvm)) {
+	if (kvm->arch.vm_type != source_kvm->arch.vm_type ||
+	    sev_guest(kvm) || !sev_guest(source_kvm)) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
@@ -2135,6 +2140,7 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	mirror_sev->asid = source_sev->asid;
 	mirror_sev->fd = source_sev->fd;
 	mirror_sev->es_active = source_sev->es_active;
+	mirror_sev->need_init = false;
 	mirror_sev->handle = source_sev->handle;
 	INIT_LIST_HEAD(&mirror_sev->regions_list);
 	INIT_LIST_HEAD(&mirror_sev->mirror_vms);
@@ -3192,3 +3198,13 @@ void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
 
 	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, 1);
 }
+
+bool sev_is_vm_type_supported(unsigned long type)
+{
+	if (type == KVM_X86_SEV_VM)
+		return sev_enabled;
+	if (type == KVM_X86_SEV_ES_VM)
+		return sev_es_enabled;
+
+	return false;
+}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 392b9c2e2ce1..87541c84d07e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4087,6 +4087,11 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
 
 static int svm_vcpu_pre_run(struct kvm_vcpu *vcpu)
 {
+	struct kvm_sev_info *sev = &to_kvm_svm(vcpu->kvm)->sev_info;
+
+	if (sev->need_init)
+		return -EINVAL;
+
 	return 1;
 }
 
@@ -4888,6 +4893,11 @@ static void svm_vm_destroy(struct kvm *kvm)
 
 static int svm_vm_init(struct kvm *kvm)
 {
+	if (kvm->arch.vm_type) {
+		struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+		sev->need_init = true;
+	}
+
 	if (!pause_filter_count || !pause_filter_thresh)
 		kvm->arch.pause_in_guest = true;
 
@@ -4914,6 +4924,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vcpu_free = svm_vcpu_free,
 	.vcpu_reset = svm_vcpu_reset,
 
+	.is_vm_type_supported = sev_is_vm_type_supported,
 	.vm_size = sizeof(struct kvm_svm),
 	.vm_init = svm_vm_init,
 	.vm_destroy = svm_vm_destroy,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 864c782eaa58..63be26d4a024 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -79,6 +79,7 @@ enum {
 struct kvm_sev_info {
 	bool active;		/* SEV enabled guest */
 	bool es_active;		/* SEV-ES enabled guest */
+	bool need_init;		/* waiting for SEV_INIT2 */
 	unsigned int asid;	/* ASID used for this guest */
 	unsigned int handle;	/* SEV firmware handle */
 	int fd;			/* SEV device fd */
@@ -696,6 +697,7 @@ void sev_es_vcpu_reset(struct vcpu_svm *svm);
 void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
 void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_area *hostsa);
 void sev_es_unmap_ghcb(struct vcpu_svm *svm);
+bool sev_is_vm_type_supported(unsigned long type);
 
 /* vmenter.S */
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c89ddaa1e09f..dfc66ee091a1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4795,6 +4795,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = BIT(KVM_X86_DEFAULT_VM);
 		if (kvm_is_vm_type_supported(KVM_X86_SW_PROTECTED_VM))
 			r |= BIT(KVM_X86_SW_PROTECTED_VM);
+		if (kvm_is_vm_type_supported(KVM_X86_SEV_VM))
+			r |= BIT(KVM_X86_SEV_VM);
+		if (kvm_is_vm_type_supported(KVM_X86_SEV_ES_VM))
+			r |= BIT(KVM_X86_SEV_ES_VM);
 		break;
 	default:
 		break;
-- 
2.39.0



