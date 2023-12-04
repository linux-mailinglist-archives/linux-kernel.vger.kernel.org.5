Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D0F803746
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346142AbjLDOou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345919AbjLDOoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:44:24 -0500
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD25D3;
        Mon,  4 Dec 2023 06:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:To:From;
        bh=fKHZy1P7fkYaIEsNWnxT7alxmY5kA8rJvoQ6llGl/0E=; b=NzUeana0Bu7GNX2SaXVbc7Eh+x
        yYhdfYa77y7kCatwccEuHOkoaeQgCDW4VyJrvpBprBsnP15EJNT3OTOZC+bvBbt6Rx/cIFMnuDt2Z
        j2r3dBae6l4r6U3gEpGmCl3QTh4cLgJqtlur/3/g1VufHV0jC5+XCCORQZMmnerZ8mII=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <paul@xen.org>)
        id 1rAABB-0003fy-Ff; Mon, 04 Dec 2023 14:44:13 +0000
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=REM-PW02S00X.ant.amazon.com)
        by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <paul@xen.org>)
        id 1rAABB-00088g-6R; Mon, 04 Dec 2023 14:44:13 +0000
From:   Paul Durrant <paul@xen.org>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Durrant <paul@xen.org>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v10 08/19] KVM: pfncache: allow a cache to be activated with a fixed (userspace) HVA
Date:   Mon,  4 Dec 2023 14:43:23 +0000
Message-Id: <20231204144334.910-9-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204144334.910-1-paul@xen.org>
References: <20231204144334.910-1-paul@xen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Durrant <pdurrant@amazon.com>

Some pfncache pages may actually be overlays on guest memory that have a
fixed HVA within the VMM. It's pointless to invalidate such cached
mappings if the overlay is moved so allow a cache to be activated directly
with the HVA to cater for such cases. A subsequent patch will make use
of this facility.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>

v9:
 - Pass both GPA and HVA into __kvm_gpc_refresh() rather than overloading
   the address paraneter and using a bool flag to indicated what it is.

v8:
 - Re-worked to avoid messing with struct gfn_to_pfn_cache.
---
 include/linux/kvm_host.h | 20 +++++++++++++++++++-
 virt/kvm/pfncache.c      | 35 +++++++++++++++++++++++++++--------
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6097f076a7b0..8120674b87b0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1345,6 +1345,22 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm);
  */
 int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len);
 
+/**
+ * kvm_gpc_activate_hva - prepare a cached kernel mapping and HPA for a given HVA.
+ *
+ * @gpc:          struct gfn_to_pfn_cache object.
+ * @hva:          userspace virtual address to map.
+ * @len:          sanity check; the range being access must fit a single page.
+ *
+ * @return:       0 for success.
+ *                -EINVAL for a mapping which would cross a page boundary.
+ *                -EFAULT for an untranslatable guest physical address.
+ *
+ * The semantics of this function are the same as those of kvm_gpc_activate(). It
+ * merely bypasses a layer of address translation.
+ */
+int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long hva, unsigned long len);
+
 /**
  * kvm_gpc_check - check validity of a gfn_to_pfn_cache.
  *
@@ -1399,7 +1415,9 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc);
 static inline void kvm_gpc_mark_dirty(struct gfn_to_pfn_cache *gpc)
 {
 	lockdep_assert_held(&gpc->lock);
-	mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
+
+	if (gpc->gpa != KVM_XEN_INVALID_GPA)
+		mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
 }
 
 void kvm_sigset_activate(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 97eec8ee3449..c2a2d1e145b6 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -209,11 +209,13 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 	return -EFAULT;
 }
 
-static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
+static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
 			     unsigned long len)
 {
 	struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
-	unsigned long page_offset = offset_in_page(gpa);
+	unsigned long page_offset = (gpa != KVM_XEN_INVALID_GPA) ?
+		offset_in_page(gpa) :
+		offset_in_page(uhva);
 	bool unmap_old = false;
 	unsigned long old_uhva;
 	kvm_pfn_t old_pfn;
@@ -246,9 +248,15 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
 	old_khva = (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
 	old_uhva = PAGE_ALIGN_DOWN(gpc->uhva);
 
-	/* Refresh the userspace HVA if necessary */
-	if (gpc->gpa != gpa || gpc->generation != slots->generation ||
-	    kvm_is_error_hva(gpc->uhva)) {
+	if (gpa == KVM_XEN_INVALID_GPA) {
+		gpc->gpa = KVM_XEN_INVALID_GPA;
+		gpc->uhva = PAGE_ALIGN_DOWN(uhva);
+
+		if (gpc->uhva != old_uhva)
+			hva_change = true;
+	} else if (gpc->gpa != gpa ||
+		   gpc->generation != slots->generation ||
+		   kvm_is_error_hva(gpc->uhva)) {
 		gfn_t gfn = gpa_to_gfn(gpa);
 
 		gpc->gpa = gpa;
@@ -319,7 +327,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
 
 int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
 {
-	return __kvm_gpc_refresh(gpc, gpc->gpa, len);
+	return __kvm_gpc_refresh(gpc, gpc->gpa, gpc->uhva, len);
 }
 
 void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
@@ -332,7 +340,8 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
 	gpc->uhva = KVM_HVA_ERR_BAD;
 }
 
-int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
+static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
+			      unsigned long len)
 {
 	struct kvm *kvm = gpc->kvm;
 
@@ -353,7 +362,17 @@ int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
 		gpc->active = true;
 		write_unlock_irq(&gpc->lock);
 	}
-	return __kvm_gpc_refresh(gpc, gpa, len);
+	return __kvm_gpc_refresh(gpc, gpa, uhva, len);
+}
+
+int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
+{
+	return __kvm_gpc_activate(gpc, gpa, KVM_HVA_ERR_BAD, len);
+}
+
+int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long uhva, unsigned long len)
+{
+	return __kvm_gpc_activate(gpc, KVM_XEN_INVALID_GPA, uhva, len);
 }
 
 void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
-- 
2.39.2

