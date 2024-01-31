Return-Path: <linux-kernel+bounces-47380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E7844D12
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79821F2E192
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A93947F5B;
	Wed, 31 Jan 2024 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfriaY9p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71C3C497
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743864; cv=none; b=OKWoJKoGBE/lYKwd2PXzc7lz2G7XRj4q/SfjUmZ02IMgpiraWgGumBItehj63qIwYwN6mPx4LQpw4GNDxhtV6JR+3eJtIjJqOZJCFsl3t8CveCyq7+lRzakG+LnkM44WYCm/2DJYs5/X4HS6kxLT5MnIhn2mDcy+IInoDd1hFyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743864; c=relaxed/simple;
	bh=NhyqOTC+iPTISMZZnFTimq/nANv46xw9EN49JJUfr2I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S16XWo+xYGF8v37wfl9SAwoIPKB7bXVJltbo+c/ZZ/KiBVubWlFyQ+K9c3b8Te5X6jo1fYsPC+BZ268bxYbyP5rihlomUPbqQO2IPaxWv2DxH6YIboDox2XAJP3Uf8gcSgjuTIN8GQkgP2UHgxeK7JEIwEzqJKgwSCxQEHlLTao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WfriaY9p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706743861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJvE1SRsR/qR/by5RcNBKVAxpeGKj1Pas8p9l7Jbyao=;
	b=WfriaY9py5pSIHd0Lq0ixWi0ZfS57UvTjmtdgslfpVoVaukOLzy0QfMJyDTsniX6LYfN8S
	TpoQ3522goaGXSDl1Pym4Lo46IyX0VMEzoFDfiyBUm18UXW2dw3ynUceI9LP+qvzaOmcFF
	39e78o/KwpFRMeqCDeH+MlwRaGQK4CE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-P_n42ALDO4CirAnq__DfYA-1; Wed, 31 Jan 2024 18:30:57 -0500
X-MC-Unique: P_n42ALDO4CirAnq__DfYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1ECBF101A526;
	Wed, 31 Jan 2024 23:30:57 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 071C6C2590D;
	Wed, 31 Jan 2024 23:30:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 3/8] KVM: powerpc: move powerpc-specific structs to uapi/asm/kvm.h
Date: Wed, 31 Jan 2024 18:30:51 -0500
Message-Id: <20240131233056.10845-4-pbonzini@redhat.com>
In-Reply-To: <20240131233056.10845-1-pbonzini@redhat.com>
References: <20240131233056.10845-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

While this in principle breaks the appearance of KVM_PPC_* ioctls on architectures
other than powerpc, this seems unlikely to be a problem considering that there are
already many "struct kvm_ppc_*" definitions in arch/powerpc/include/uapi.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/powerpc/include/uapi/asm/kvm.h | 44 +++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h            | 44 -----------------------------
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 9f18fa090f1f..a96ef6b36bba 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -733,4 +733,48 @@ struct kvm_ppc_xive_eq {
 #define KVM_XIVE_TIMA_PAGE_OFFSET	0
 #define KVM_XIVE_ESB_PAGE_OFFSET	4
 
+/* for KVM_PPC_GET_PVINFO */
+
+#define KVM_PPC_PVINFO_FLAGS_EV_IDLE   (1<<0)
+
+struct kvm_ppc_pvinfo {
+	/* out */
+	__u32 flags;
+	__u32 hcall[4];
+	__u8  pad[108];
+};
+
+/* for KVM_PPC_GET_SMMU_INFO */
+#define KVM_PPC_PAGE_SIZES_MAX_SZ	8
+
+struct kvm_ppc_one_page_size {
+	__u32 page_shift;	/* Page shift (or 0) */
+	__u32 pte_enc;		/* Encoding in the HPTE (>>12) */
+};
+
+struct kvm_ppc_one_seg_page_size {
+	__u32 page_shift;	/* Base page shift of segment (or 0) */
+	__u32 slb_enc;		/* SLB encoding for BookS */
+	struct kvm_ppc_one_page_size enc[KVM_PPC_PAGE_SIZES_MAX_SZ];
+};
+
+#define KVM_PPC_PAGE_SIZES_REAL		0x00000001
+#define KVM_PPC_1T_SEGMENTS		0x00000002
+#define KVM_PPC_NO_HASH			0x00000004
+
+struct kvm_ppc_smmu_info {
+	__u64 flags;
+	__u32 slb_size;
+	__u16 data_keys;	/* # storage keys supported for data */
+	__u16 instr_keys;	/* # storage keys supported for instructions */
+	struct kvm_ppc_one_seg_page_size sps[KVM_PPC_PAGE_SIZES_MAX_SZ];
+};
+
+/* for KVM_PPC_RESIZE_HPT_{PREPARE,COMMIT} */
+struct kvm_ppc_resize_hpt {
+	__u64 flags;
+	__u32 shift;
+	__u32 pad;
+};
+
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 9744e1891c16..a5458aeee018 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -810,50 +810,6 @@ struct kvm_enable_cap {
 	__u8  pad[64];
 };
 
-/* for KVM_PPC_GET_PVINFO */
-
-#define KVM_PPC_PVINFO_FLAGS_EV_IDLE   (1<<0)
-
-struct kvm_ppc_pvinfo {
-	/* out */
-	__u32 flags;
-	__u32 hcall[4];
-	__u8  pad[108];
-};
-
-/* for KVM_PPC_GET_SMMU_INFO */
-#define KVM_PPC_PAGE_SIZES_MAX_SZ	8
-
-struct kvm_ppc_one_page_size {
-	__u32 page_shift;	/* Page shift (or 0) */
-	__u32 pte_enc;		/* Encoding in the HPTE (>>12) */
-};
-
-struct kvm_ppc_one_seg_page_size {
-	__u32 page_shift;	/* Base page shift of segment (or 0) */
-	__u32 slb_enc;		/* SLB encoding for BookS */
-	struct kvm_ppc_one_page_size enc[KVM_PPC_PAGE_SIZES_MAX_SZ];
-};
-
-#define KVM_PPC_PAGE_SIZES_REAL		0x00000001
-#define KVM_PPC_1T_SEGMENTS		0x00000002
-#define KVM_PPC_NO_HASH			0x00000004
-
-struct kvm_ppc_smmu_info {
-	__u64 flags;
-	__u32 slb_size;
-	__u16 data_keys;	/* # storage keys supported for data */
-	__u16 instr_keys;	/* # storage keys supported for instructions */
-	struct kvm_ppc_one_seg_page_size sps[KVM_PPC_PAGE_SIZES_MAX_SZ];
-};
-
-/* for KVM_PPC_RESIZE_HPT_{PREPARE,COMMIT} */
-struct kvm_ppc_resize_hpt {
-	__u64 flags;
-	__u32 shift;
-	__u32 pad;
-};
-
 #define KVMIO 0xAE
 
 /* machine type bits, to be used as argument to KVM_CREATE_VM */
-- 
2.39.0



