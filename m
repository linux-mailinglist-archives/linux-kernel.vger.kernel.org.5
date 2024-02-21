Return-Path: <linux-kernel+bounces-74224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6457285D14E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865051C238DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DDA3CF52;
	Wed, 21 Feb 2024 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S4ilPUGR"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64173BB55
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500370; cv=none; b=Vl3CjwEjJZnH7pHiAsyAsw0uAUlrxlYiwE8KLsFLNl1Cu+NQ2hSy3w3msP0e1eIhy7GzscZGqEymzJpaNPGiyQjQhmZccLIEeNebQ2rRO+Jo6Vo1TOMLxQCQFQEdxLobgtW9TGArX0ZW6nKo9WwFyoh8jUxEcCsDFh6KMLL3vkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500370; c=relaxed/simple;
	bh=RmD39qkqJabTxcfPE8goq6maOJ/dBePa1bMd43TiM5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4tKDkHtmdvKIk5/yhliGnNaU5ww4Gf7J7w9MFI7VSPc53YDDAyMf8RI1t1EHp0/wAFlYQ1bIuDarynA507nJRT9azssZeWKXuiBBqR5WhfjkDoNmbL/UJ3toZdtd5MyKS2oQB/7T9OouGMa1kCfxLTXN9VMIij76IxpyIZGV1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S4ilPUGR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc1ff697f9so10009175ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708500368; x=1709105168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAR1gp4LGHrNBxZ7QFBatkydzrn+82v+XlkHRa0WTGM=;
        b=S4ilPUGRj9nQpzf1YgsqQip+Qd/oNUXMjF5yq6XvrcScxnqaFY6R1TCZ4avk9oJ/0S
         tjeM38Sm9Tdl9w+/QLmIvpEa6RFm7WyVBdfAmVi40OQQZ2N/P/YOgpXxduAbO+Bz0mv/
         t3qijVPZ7oDFBVJVzxOGy402PW4DqQaIPd+z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708500368; x=1709105168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAR1gp4LGHrNBxZ7QFBatkydzrn+82v+XlkHRa0WTGM=;
        b=GwK99clatZoexIkssyP26gSVrbjVcvC5vTPOvF585wYFEoedSVsHOG7L1VWV+gHh7b
         ZNTRK3nPvqoMR8TMPimK+psaiWR9TEsBsvR354hGfYFCt5PJGhyjO6062fQU1U5TQmry
         1IkYO4Enn+jGTjdMN/IPlIzDsJF9s2G2BNYu5yamF1GX5U9cGwLxYe1oiJPO5Bs4EzTV
         0d+Sb6m6attEJMyHlS/vi0RYdD2ziWAwXC0qoRE3cIMQKgSYuptloatThcMbjmknX33w
         tfTluLOkdEe+zO0QALtdxa6QYQbGvDvXIyKWKy+QRPhy7aepfz056q2IgKfcnoWdU0l8
         BYSw==
X-Forwarded-Encrypted: i=1; AJvYcCWYteQXNh9FNfYYdPhRmdHbTrPObEdgcyPXw6k5I1xptMoWpvTnvuinj3OjqE0vi99netxds7HbkMK8h03GV6MPNhZeICI8GuGlNU36
X-Gm-Message-State: AOJu0YwZ2bdCD40exQA0ad5VGrgSrAhWt7S67BIF5EcjJyfuxOTKfrn0
	yugdphtp5ZLUtStau4OK2s4OCj7tzzKw2Ky0P5F91fnQkzE1E429wiDZnAZEmQ==
X-Google-Smtp-Source: AGHT+IHdtvQBsodduz9CLSKFgksIKCIWU5LuIP9uwj0fDetgXWoLFhmG5AQ84wqvrPWNAgX7BbHlIA==
X-Received: by 2002:a17:903:1105:b0:1d9:8832:f800 with SMTP id n5-20020a170903110500b001d98832f800mr19339736plh.8.1708500368099;
        Tue, 20 Feb 2024 23:26:08 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:b417:5d09:c226:a19c])
        by smtp.gmail.com with UTF8SMTPSA id kr6-20020a170903080600b001da1fae8a73sm603093plb.12.2024.02.20.23.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 23:26:07 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v10 3/8] KVM: mmu: Introduce kvm_follow_pfn()
Date: Wed, 21 Feb 2024 16:25:21 +0900
Message-ID: <20240221072528.2702048-4-stevensd@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240221072528.2702048-1-stevensd@google.com>
References: <20240221072528.2702048-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Stevens <stevensd@chromium.org>

Introduce kvm_follow_pfn(), which will replace __gfn_to_pfn_memslot().
This initial implementation is just a refactor of the existing API which
uses a single structure for passing the arguments. The arguments are
further refactored as follows:

 - The write_fault and interruptible boolean flags and the in
   parameter part of async are replaced by setting FOLL_WRITE,
   FOLL_INTERRUPTIBLE, and FOLL_NOWAIT respectively in a new flags
   argument.
 - The out parameter portion of the async parameter is now a return
   value.
 - The writable in/out parameter is split into a separate.
   try_map_writable in parameter and writable out parameter.
 - All other parameter are the same.

Upcoming changes will add the ability to get a pfn without needing to
take a ref to the underlying page.

Signed-off-by: David Stevens <stevensd@chromium.org>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 include/linux/kvm_host.h |  18 ++++
 virt/kvm/kvm_main.c      | 191 +++++++++++++++++++++------------------
 virt/kvm/kvm_mm.h        |   3 +-
 virt/kvm/pfncache.c      |  10 +-
 4 files changed, 131 insertions(+), 91 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7e7fd25b09b3..290db5133c36 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -97,6 +97,7 @@
 #define KVM_PFN_ERR_HWPOISON	(KVM_PFN_ERR_MASK + 1)
 #define KVM_PFN_ERR_RO_FAULT	(KVM_PFN_ERR_MASK + 2)
 #define KVM_PFN_ERR_SIGPENDING	(KVM_PFN_ERR_MASK + 3)
+#define KVM_PFN_ERR_NEEDS_IO	(KVM_PFN_ERR_MASK + 4)
 
 /*
  * error pfns indicate that the gfn is in slot but faild to
@@ -1209,6 +1210,23 @@ unsigned long gfn_to_hva_memslot_prot(struct kvm_memory_slot *slot, gfn_t gfn,
 void kvm_release_page_clean(struct page *page);
 void kvm_release_page_dirty(struct page *page);
 
+struct kvm_follow_pfn {
+	const struct kvm_memory_slot *slot;
+	gfn_t gfn;
+	/* FOLL_* flags modifying lookup behavior. */
+	unsigned int flags;
+	/* Whether this function can sleep. */
+	bool atomic;
+	/* Try to create a writable mapping even for a read fault. */
+	bool try_map_writable;
+
+	/* Outputs of kvm_follow_pfn */
+	hva_t hva;
+	bool writable;
+};
+
+kvm_pfn_t kvm_follow_pfn(struct kvm_follow_pfn *kfp);
+
 kvm_pfn_t gfn_to_pfn(struct kvm *kvm, gfn_t gfn);
 kvm_pfn_t gfn_to_pfn_prot(struct kvm *kvm, gfn_t gfn, bool write_fault,
 		      bool *writable);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6f37d56fb2fc..575756c9c5b0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2791,8 +2791,7 @@ static inline int check_user_page_hwpoison(unsigned long addr)
  * true indicates success, otherwise false is returned.  It's also the
  * only part that runs if we can in atomic context.
  */
-static bool hva_to_pfn_fast(unsigned long addr, bool write_fault,
-			    bool *writable, kvm_pfn_t *pfn)
+static bool hva_to_pfn_fast(struct kvm_follow_pfn *kfp, kvm_pfn_t *pfn)
 {
 	struct page *page[1];
 
@@ -2801,14 +2800,12 @@ static bool hva_to_pfn_fast(unsigned long addr, bool write_fault,
 	 * or the caller allows to map a writable pfn for a read fault
 	 * request.
 	 */
-	if (!(write_fault || writable))
+	if (!((kfp->flags & FOLL_WRITE) || kfp->try_map_writable))
 		return false;
 
-	if (get_user_page_fast_only(addr, FOLL_WRITE, page)) {
+	if (get_user_page_fast_only(kfp->hva, FOLL_WRITE, page)) {
 		*pfn = page_to_pfn(page[0]);
-
-		if (writable)
-			*writable = true;
+		kfp->writable = true;
 		return true;
 	}
 
@@ -2819,8 +2816,7 @@ static bool hva_to_pfn_fast(unsigned long addr, bool write_fault,
  * The slow path to get the pfn of the specified host virtual address,
  * 1 indicates success, -errno is returned if error is detected.
  */
-static int hva_to_pfn_slow(unsigned long addr, bool *async, bool write_fault,
-			   bool interruptible, bool *writable, kvm_pfn_t *pfn)
+static int hva_to_pfn_slow(struct kvm_follow_pfn *kfp, kvm_pfn_t *pfn)
 {
 	/*
 	 * When a VCPU accesses a page that is not mapped into the secondary
@@ -2833,32 +2829,24 @@ static int hva_to_pfn_slow(unsigned long addr, bool *async, bool write_fault,
 	 * Note that get_user_page_fast_only() and FOLL_WRITE for now
 	 * implicitly honor NUMA hinting faults and don't need this flag.
 	 */
-	unsigned int flags = FOLL_HWPOISON | FOLL_HONOR_NUMA_FAULT;
+	unsigned int flags = FOLL_HWPOISON | FOLL_HONOR_NUMA_FAULT | kfp->flags;
 	struct page *page;
 	int npages;
 
 	might_sleep();
 
-	if (writable)
-		*writable = write_fault;
-
-	if (write_fault)
-		flags |= FOLL_WRITE;
-	if (async)
-		flags |= FOLL_NOWAIT;
-	if (interruptible)
-		flags |= FOLL_INTERRUPTIBLE;
-
-	npages = get_user_pages_unlocked(addr, 1, &page, flags);
+	npages = get_user_pages_unlocked(kfp->hva, 1, &page, flags);
 	if (npages != 1)
 		return npages;
 
-	/* map read fault as writable if possible */
-	if (unlikely(!write_fault) && writable) {
+	if (kfp->flags & FOLL_WRITE) {
+		kfp->writable = true;
+	} else if (kfp->try_map_writable) {
 		struct page *wpage;
 
-		if (get_user_page_fast_only(addr, FOLL_WRITE, &wpage)) {
-			*writable = true;
+		/* map read fault as writable if possible */
+		if (get_user_page_fast_only(kfp->hva, FOLL_WRITE, &wpage)) {
+			kfp->writable = true;
 			put_page(page);
 			page = wpage;
 		}
@@ -2889,23 +2877,23 @@ static int kvm_try_get_pfn(kvm_pfn_t pfn)
 }
 
 static int hva_to_pfn_remapped(struct vm_area_struct *vma,
-			       unsigned long addr, bool write_fault,
-			       bool *writable, kvm_pfn_t *p_pfn)
+			       struct kvm_follow_pfn *kfp, kvm_pfn_t *p_pfn)
 {
 	kvm_pfn_t pfn;
 	pte_t *ptep;
 	pte_t pte;
 	spinlock_t *ptl;
+	bool write_fault = kfp->flags & FOLL_WRITE;
 	int r;
 
-	r = follow_pte(vma->vm_mm, addr, &ptep, &ptl);
+	r = follow_pte(vma->vm_mm, kfp->hva, &ptep, &ptl);
 	if (r) {
 		/*
 		 * get_user_pages fails for VM_IO and VM_PFNMAP vmas and does
 		 * not call the fault handler, so do it here.
 		 */
 		bool unlocked = false;
-		r = fixup_user_fault(current->mm, addr,
+		r = fixup_user_fault(current->mm, kfp->hva,
 				     (write_fault ? FAULT_FLAG_WRITE : 0),
 				     &unlocked);
 		if (unlocked)
@@ -2913,7 +2901,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 		if (r)
 			return r;
 
-		r = follow_pte(vma->vm_mm, addr, &ptep, &ptl);
+		r = follow_pte(vma->vm_mm, kfp->hva, &ptep, &ptl);
 		if (r)
 			return r;
 	}
@@ -2925,8 +2913,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 		goto out;
 	}
 
-	if (writable)
-		*writable = pte_write(pte);
+	kfp->writable = pte_write(pte);
 	pfn = pte_pfn(pte);
 
 	/*
@@ -2957,38 +2944,28 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 }
 
 /*
- * Pin guest page in memory and return its pfn.
- * @addr: host virtual address which maps memory to the guest
- * @atomic: whether this function can sleep
- * @interruptible: whether the process can be interrupted by non-fatal signals
- * @async: whether this function need to wait IO complete if the
- *         host page is not in the memory
- * @write_fault: whether we should get a writable host page
- * @writable: whether it allows to map a writable host page for !@write_fault
- *
- * The function will map a writable host page for these two cases:
- * 1): @write_fault = true
- * 2): @write_fault = false && @writable, @writable will tell the caller
- *     whether the mapping is writable.
+ * Convert a hva to a pfn.
+ * @kfp: args struct for the conversion
  */
-kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool interruptible,
-		     bool *async, bool write_fault, bool *writable)
+kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp)
 {
 	struct vm_area_struct *vma;
 	kvm_pfn_t pfn;
 	int npages, r;
 
-	/* we can do it either atomically or asynchronously, not both */
-	WARN_ON_ONCE(atomic && async);
+	/*
+	 * FOLL_NOWAIT is used for async page faults, which don't make sense
+	 * in an atomic context where the caller can't do async resolution.
+	 */
+	WARN_ON_ONCE(kfp->atomic && (kfp->flags & FOLL_NOWAIT));
 
-	if (hva_to_pfn_fast(addr, write_fault, writable, &pfn))
+	if (hva_to_pfn_fast(kfp, &pfn))
 		return pfn;
 
-	if (atomic)
+	if (kfp->atomic)
 		return KVM_PFN_ERR_FAULT;
 
-	npages = hva_to_pfn_slow(addr, async, write_fault, interruptible,
-				 writable, &pfn);
+	npages = hva_to_pfn_slow(kfp, &pfn);
 	if (npages == 1)
 		return pfn;
 	if (npages == -EINTR)
@@ -2996,83 +2973,123 @@ kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool interruptible,
 
 	mmap_read_lock(current->mm);
 	if (npages == -EHWPOISON ||
-	      (!async && check_user_page_hwpoison(addr))) {
+	    (!(kfp->flags & FOLL_NOWAIT) && check_user_page_hwpoison(kfp->hva))) {
 		pfn = KVM_PFN_ERR_HWPOISON;
 		goto exit;
 	}
 
 retry:
-	vma = vma_lookup(current->mm, addr);
+	vma = vma_lookup(current->mm, kfp->hva);
 
 	if (vma == NULL)
 		pfn = KVM_PFN_ERR_FAULT;
 	else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
-		r = hva_to_pfn_remapped(vma, addr, write_fault, writable, &pfn);
+		r = hva_to_pfn_remapped(vma, kfp, &pfn);
 		if (r == -EAGAIN)
 			goto retry;
 		if (r < 0)
 			pfn = KVM_PFN_ERR_FAULT;
 	} else {
-		if (async && vma_is_valid(vma, write_fault))
-			*async = true;
-		pfn = KVM_PFN_ERR_FAULT;
+		if ((kfp->flags & FOLL_NOWAIT) &&
+		    vma_is_valid(vma, kfp->flags & FOLL_WRITE))
+			pfn = KVM_PFN_ERR_NEEDS_IO;
+		else
+			pfn = KVM_PFN_ERR_FAULT;
 	}
 exit:
 	mmap_read_unlock(current->mm);
 	return pfn;
 }
 
-kvm_pfn_t __gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn,
-			       bool atomic, bool interruptible, bool *async,
-			       bool write_fault, bool *writable, hva_t *hva)
+kvm_pfn_t kvm_follow_pfn(struct kvm_follow_pfn *kfp)
 {
-	unsigned long addr = __gfn_to_hva_many(slot, gfn, NULL, write_fault);
+	kfp->writable = false;
+	kfp->hva = __gfn_to_hva_many(kfp->slot, kfp->gfn, NULL,
+				     kfp->flags & FOLL_WRITE);
 
-	if (hva)
-		*hva = addr;
-
-	if (addr == KVM_HVA_ERR_RO_BAD) {
-		if (writable)
-			*writable = false;
+	if (kfp->hva == KVM_HVA_ERR_RO_BAD)
 		return KVM_PFN_ERR_RO_FAULT;
-	}
 
-	if (kvm_is_error_hva(addr)) {
-		if (writable)
-			*writable = false;
+	if (kvm_is_error_hva(kfp->hva))
 		return KVM_PFN_NOSLOT;
-	}
 
-	/* Do not map writable pfn in the readonly memslot. */
-	if (writable && memslot_is_readonly(slot)) {
-		*writable = false;
-		writable = NULL;
-	}
+	if (memslot_is_readonly(kfp->slot))
+		kfp->try_map_writable = false;
+
+	return hva_to_pfn(kfp);
+}
+EXPORT_SYMBOL_GPL(kvm_follow_pfn);
+
+kvm_pfn_t __gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn,
+			       bool atomic, bool interruptible, bool *async,
+			       bool write_fault, bool *writable, hva_t *hva)
+{
+	kvm_pfn_t pfn;
+	struct kvm_follow_pfn kfp = {
+		.slot = slot,
+		.gfn = gfn,
+		.flags = 0,
+		.atomic = atomic,
+		.try_map_writable = !!writable,
+	};
+
+	if (write_fault)
+		kfp.flags |= FOLL_WRITE;
+	if (async)
+		kfp.flags |= FOLL_NOWAIT;
+	if (interruptible)
+		kfp.flags |= FOLL_INTERRUPTIBLE;
 
-	return hva_to_pfn(addr, atomic, interruptible, async, write_fault,
-			  writable);
+	pfn = kvm_follow_pfn(&kfp);
+	if (pfn == KVM_PFN_ERR_NEEDS_IO) {
+		*async = true;
+		pfn = KVM_PFN_ERR_FAULT;
+	}
+	if (hva)
+		*hva = kfp.hva;
+	if (writable)
+		*writable = kfp.writable;
+	return pfn;
 }
 EXPORT_SYMBOL_GPL(__gfn_to_pfn_memslot);
 
 kvm_pfn_t gfn_to_pfn_prot(struct kvm *kvm, gfn_t gfn, bool write_fault,
 		      bool *writable)
 {
-	return __gfn_to_pfn_memslot(gfn_to_memslot(kvm, gfn), gfn, false, false,
-				    NULL, write_fault, writable, NULL);
+	kvm_pfn_t pfn;
+	struct kvm_follow_pfn kfp = {
+		.slot = gfn_to_memslot(kvm, gfn),
+		.gfn = gfn,
+		.flags = write_fault ? FOLL_WRITE : 0,
+		.try_map_writable = !!writable,
+	};
+	pfn = kvm_follow_pfn(&kfp);
+	if (writable)
+		*writable = kfp.writable;
+	return pfn;
 }
 EXPORT_SYMBOL_GPL(gfn_to_pfn_prot);
 
 kvm_pfn_t gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn)
 {
-	return __gfn_to_pfn_memslot(slot, gfn, false, false, NULL, true,
-				    NULL, NULL);
+	struct kvm_follow_pfn kfp = {
+		.slot = slot,
+		.gfn = gfn,
+		.flags = FOLL_WRITE,
+	};
+	return kvm_follow_pfn(&kfp);
 }
 EXPORT_SYMBOL_GPL(gfn_to_pfn_memslot);
 
 kvm_pfn_t gfn_to_pfn_memslot_atomic(const struct kvm_memory_slot *slot, gfn_t gfn)
 {
-	return __gfn_to_pfn_memslot(slot, gfn, true, false, NULL, true,
-				    NULL, NULL);
+	struct kvm_follow_pfn kfp = {
+		.slot = slot,
+		.gfn = gfn,
+		.flags = FOLL_WRITE,
+		.atomic = true,
+	};
+	return kvm_follow_pfn(&kfp);
 }
 EXPORT_SYMBOL_GPL(gfn_to_pfn_memslot_atomic);
 
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index ecefc7ec51af..9ba61fbb727c 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -20,8 +20,7 @@
 #define KVM_MMU_UNLOCK(kvm)		spin_unlock(&(kvm)->mmu_lock)
 #endif /* KVM_HAVE_MMU_RWLOCK */
 
-kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool interruptible,
-		     bool *async, bool write_fault, bool *writable);
+kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *foll);
 
 #ifdef CONFIG_HAVE_KVM_PFNCACHE
 void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 2d6aba677830..1fb21c2ced5d 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -144,6 +144,12 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 	kvm_pfn_t new_pfn = KVM_PFN_ERR_FAULT;
 	void *new_khva = NULL;
 	unsigned long mmu_seq;
+	struct kvm_follow_pfn kfp = {
+		.slot = gpc->memslot,
+		.gfn = gpa_to_gfn(gpc->gpa),
+		.flags = FOLL_WRITE,
+		.hva = gpc->uhva,
+	};
 
 	lockdep_assert_held(&gpc->refresh_lock);
 
@@ -182,8 +188,8 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 			cond_resched();
 		}
 
-		/* We always request a writeable mapping */
-		new_pfn = hva_to_pfn(gpc->uhva, false, false, NULL, true, NULL);
+		/* We always request a writable mapping */
+		new_pfn = hva_to_pfn(&kfp);
 		if (is_error_noslot_pfn(new_pfn))
 			goto out_error;
 
-- 
2.44.0.rc0.258.g7320e95886-goog


