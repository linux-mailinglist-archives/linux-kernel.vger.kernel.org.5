Return-Path: <linux-kernel+bounces-147506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F7D8A7561
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A407E1F226EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8D713A869;
	Tue, 16 Apr 2024 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+RvFzXx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E0E139D0C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713298783; cv=none; b=RCIAuVEgZNS42wOMy2bYQIX4sWjq0t5vWwsBUC0nFLu8LvsgA1w2kDhl55w2Cw007ON9dkmiqgr4D8/VndGP0lcwJOhTyTmXHgdzN2DZEK3+/EVMdpaw7NP49vg8tm/Wmq24zKqagucZf+8/xl9bCzklhUPyIfytOuXz8NfYneo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713298783; c=relaxed/simple;
	bh=YjX/06cQ6ZQ25fZLpkb7Kj2DDn9st6yNe4LsYowwFIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fM5ulEwM+rxhe4/nMPM41mqvaw855sI9pa7osMx07niRHPpZ8FSLQaCrFjkDoe74X+H2YSkwJzq2mrRrkbK2Y1iLoDiajgBvePFFXhaCYNjqKLHggsBxaItuepl7TYcZi0xQYNg/tStzUlquC81cAJW0y+0AJV0h/7lJWXFnBZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+RvFzXx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713298780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RpANWCnoonzcuXE3SFnF5+HA6HkatDPoVc2CRFiWCW8=;
	b=M+RvFzXx6Ahjd7cCyPgRFWKS+uLi2Hee3SGSIC4L7cCu5Qhkm/ZOfvxQXV+Fuw3HUFLZGy
	DnSJ9e0iGR9oAL8Uh5CLHvZz2epYGRpVFlu4ozJo/dh9gN1Z/vkX7kMpLXeQi0s5NNuudI
	fN612ptMaVwzimE2VQ5x5ya0GTxybcc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-e2XdyAs-Mgapr8S3DEfO-A-1; Tue,
 16 Apr 2024 16:19:39 -0400
X-MC-Unique: e2XdyAs-Mgapr8S3DEfO-A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B26083C000AE;
	Tue, 16 Apr 2024 20:19:38 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8281018209F;
	Tue, 16 Apr 2024 20:19:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: isaku.yamahata@intel.com,
	xiaoyao.li@intel.com,
	binbin.wu@linux.intel.com,
	chao.gao@intel.com
Subject: [PATCH v2 09/10] KVM: x86/mmu: Use PFERR_GUEST_ENC_MASK to indicate fault is private
Date: Tue, 16 Apr 2024 16:19:34 -0400
Message-ID: <20240416201935.3525739-10-pbonzini@redhat.com>
In-Reply-To: <20240416201935.3525739-1-pbonzini@redhat.com>
References: <20240416201935.3525739-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

SEV-SNP defines PFERR_GUEST_ENC_MASK (bit 34) in page-fault error bits to
represent the guest page is encrypted.  Use the bit to designate that the
page fault is private and that it requires looking up memory attributes.

The vendor kvm page fault handler should set PFERR_GUEST_ENC_MASK bit based
on their fault information.  It may or may not use the hardware value
directly or parse the hardware value to set the bit.

Based on a patch by Isaku Yamahata.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 2 ++
 arch/x86/kvm/mmu/mmu.c          | 9 +++++++++
 arch/x86/kvm/mmu/mmu_internal.h | 2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9f92bdb78504..7c73952b6f4e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -264,6 +264,7 @@ enum x86_intercept_stage;
 #define PFERR_SGX_BIT 15
 #define PFERR_GUEST_FINAL_BIT 32
 #define PFERR_GUEST_PAGE_BIT 33
+#define PFERR_GUEST_ENC_BIT 34
 #define PFERR_IMPLICIT_ACCESS_BIT 48
 
 #define PFERR_PRESENT_MASK	BIT(PFERR_PRESENT_BIT)
@@ -275,6 +276,7 @@ enum x86_intercept_stage;
 #define PFERR_SGX_MASK		BIT(PFERR_SGX_BIT)
 #define PFERR_GUEST_FINAL_MASK	BIT_ULL(PFERR_GUEST_FINAL_BIT)
 #define PFERR_GUEST_PAGE_MASK	BIT_ULL(PFERR_GUEST_PAGE_BIT)
+#define PFERR_GUEST_ENC_MASK	BIT_ULL(PFERR_GUEST_ENC_BIT)
 #define PFERR_IMPLICIT_ACCESS	BIT_ULL(PFERR_IMPLICIT_ACCESS_BIT)
 
 #define PFERR_NESTED_GUEST_PAGE (PFERR_GUEST_PAGE_MASK |	\
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 00eef18ca1ae..33aea47dce8b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5793,6 +5793,7 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 {
 	int r, emulation_type = EMULTYPE_PF;
 	bool direct = vcpu->arch.mmu->root_role.direct;
+	struct kvm *kvm = vcpu->kvm;
 
 	/*
 	 * IMPLICIT_ACCESS is a KVM-defined flag used to correctly perform SMAP
@@ -5808,6 +5809,14 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 	if (WARN_ON_ONCE(!VALID_PAGE(vcpu->arch.mmu->root.hpa)))
 		return RET_PF_RETRY;
 
+	/*
+	 * There is no vendor code that can set PFERR_GUEST_ENC_MASK for
+	 * software-protected VMs.  Compute it here.
+	 */
+	if (kvm->arch.vm_type == KVM_X86_SW_PROTECTED_VM &&
+	    kvm_mem_is_private(kvm, cr2_or_gpa >> PAGE_SHIFT))
+		error_code |= PFERR_GUEST_ENC_MASK;
+
 	r = RET_PF_INVALID;
 	if (unlikely(error_code & PFERR_RSVD_MASK)) {
 		r = handle_mmio_page_fault(vcpu, cr2_or_gpa, direct);
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 49b428cca04e..7c2ba50cec68 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -290,6 +290,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		.present = err & PFERR_PRESENT_MASK,
 		.rsvd = err & PFERR_RSVD_MASK,
 		.user = err & PFERR_USER_MASK,
+		.is_private = vcpu->kvm->arch.has_private_mem && (err & PFERR_GUEST_ENC_MASK),
 		.prefetch = prefetch,
 		.is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault),
 		.nx_huge_page_workaround_enabled =
@@ -298,7 +299,6 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		.max_level = KVM_MAX_HUGEPAGE_LEVEL,
 		.req_level = PG_LEVEL_4K,
 		.goal_level = PG_LEVEL_4K,
-		.is_private = kvm_mem_is_private(vcpu->kvm, cr2_or_gpa >> PAGE_SHIFT),
 	};
 	int r;
 
-- 
2.43.0



