Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD94080FB33
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378091AbjLLXRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378005AbjLLXRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:17:17 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0E1E9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:17:20 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-58df5988172so3954849eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702423040; x=1703027840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZjoMoZfbLgYK7cJaZ0EBpgFOBwo/12832X2C7MVeuk=;
        b=AlrxvD/tb29EN8sl2PtfN9xifrh6UOw7clLmq9lNivZ0Dqs8vq6wKTn2zeYOFUlILc
         S2dBS4mxoSJBA6Mnery4qzDfMCUCRxK7Lq3zZ5kcRuALSUm2rvHG++KypBTac2ckuM29
         WDhFPLbF8fT6+rp94pGR1suK8Ep6uwTY1MrPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423040; x=1703027840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZjoMoZfbLgYK7cJaZ0EBpgFOBwo/12832X2C7MVeuk=;
        b=wZvsGyuDlq26+TzwCYVrr/kFhIJ660LFqGKtGQRSkXqjiFNpJfET/lL2+MAlnud4Tz
         KbSgtMoEBEyH6ZkCm4xK8lXl/0wGcx25zigbXuUqmY5pF3lhM+EAGdInGT72UdIDLHvW
         IdhsgauzASBSPubjzhPrCyS23F6uH0M1eC/t6gu+mmwIrv4XHwWIxUt6lvKeC+H18brU
         ptlUtosm2I4w215Gy55zZIYyx0O+wY2NoUReO3fYIg3Eu1jAhyY7oviMc5FwsG8qiX+d
         QHoswuT4tblaFVLb2/6DGeZci1+Sl6y+07Q7oFILS9fpYNFNDM7jYDPMtoWY+umuaNDx
         ur3Q==
X-Gm-Message-State: AOJu0YzdryhpYR/4cHsjY5FDCBY+YmLfd3asXguT/pi1rac4iNCgTC7D
        Dnsv0PD7n6Rpv/VI/0RsnWEZqQ==
X-Google-Smtp-Source: AGHT+IGRI96+S8G+Wu1lZ2r1WtnFErIwHP6EFRT0QHSV6FRdjptIOjAkrTcn5HdK1GH4IA0qfPmw5g==
X-Received: by 2002:a05:6358:7296:b0:170:17eb:2039 with SMTP id w22-20020a056358729600b0017017eb2039mr9338350rwf.34.1702423039955;
        Tue, 12 Dec 2023 15:17:19 -0800 (PST)
Received: from localhost (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.gmail.com with UTF8SMTPSA id z17-20020aa785d1000000b006ce5bb61a5fsm8749920pfn.3.2023.12.12.15.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 15:17:19 -0800 (PST)
From:   jeffxu@chromium.org
To:     akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Cc:     jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org, deraadt@openbsd.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v3 09/11] mseal: add MAP_SEALABLE to mmap()
Date:   Tue, 12 Dec 2023 23:17:03 +0000
Message-ID: <20231212231706.2680890-10-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231212231706.2680890-1-jeffxu@chromium.org>
References: <20231212231706.2680890-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Xu <jeffxu@chromium.org>

The MAP_SEALABLE flag is added to the flags field of mmap().
When present, it marks the map as sealable. A map created
without MAP_SEALABLE will not support sealing; In other words,
mseal() will fail for such a map.

Applications that don't care about sealing will expect their
behavior unchanged. For those that need sealing support, opt-in
by adding MAP_SEALABLE when creating the map.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 include/linux/mm.h                     | 52 ++++++++++++++++++++++++--
 include/linux/mm_types.h               |  1 +
 include/uapi/asm-generic/mman-common.h |  1 +
 mm/mmap.c                              |  2 +-
 mm/mseal.c                             |  7 +++-
 5 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 50dda474acc2..6f5dba9fbe21 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -267,6 +267,17 @@ extern unsigned int kobjsize(const void *objp);
 	MM_SEAL_PROT_PKEY | \
 	MM_SEAL_DISCARD_RO_ANON)
 
+/* define VM_SEALABLE in vm_seals of vm_area_struct. */
+#define VM_SEALABLE	_BITUL(31)
+
+/*
+ * VM_SEALS_BITS_ALL marks the bits used for
+ * sealing in vm_seals of vm_area_structure.
+ */
+#define VM_SEALS_BITS_ALL ( \
+	MM_SEAL_ALL | \
+	VM_SEALABLE)
+
 /*
  * PROT_SEAL_ALL is all supported flags in mmap().
  * See include/uapi/asm-generic/mman-common.h.
@@ -3330,9 +3341,17 @@ static inline void mm_populate(unsigned long addr, unsigned long len) {}
 
 #ifdef CONFIG_MSEAL
 /*
- * return the valid sealing (after mask).
+ * return the valid sealing (after mask), this includes sealable bit.
  */
 static inline unsigned long vma_seals(struct vm_area_struct *vma)
+{
+	return (vma->vm_seals & VM_SEALS_BITS_ALL);
+}
+
+/*
+ * return the enabled sealing type (after mask), without sealable bit.
+ */
+static inline unsigned long vma_enabled_seals(struct vm_area_struct *vma)
 {
 	return (vma->vm_seals & MM_SEAL_ALL);
 }
@@ -3342,9 +3361,14 @@ static inline void update_vma_seals(struct vm_area_struct *vma, unsigned long vm
 	vma->vm_seals |= vm_seals;
 }
 
+static inline bool is_vma_sealable(struct vm_area_struct *vma)
+{
+	return vma->vm_seals & VM_SEALABLE;
+}
+
 static inline bool check_vma_seals_mergeable(unsigned long vm_seals1, unsigned long vm_seals2)
 {
-	if ((vm_seals1 & MM_SEAL_ALL) != (vm_seals2 & MM_SEAL_ALL))
+	if ((vm_seals1 & VM_SEALS_BITS_ALL) != (vm_seals2 & VM_SEALS_BITS_ALL))
 		return false;
 
 	return true;
@@ -3384,9 +3408,15 @@ static inline unsigned long convert_mmap_seals(unsigned long prot)
  * check input sealing type from the "prot" field of mmap().
  * for CONFIG_MSEAL case, this always return 0 (successful).
  */
-static inline int check_mmap_seals(unsigned long prot, unsigned long *vm_seals)
+static inline int check_mmap_seals(unsigned long prot, unsigned long *vm_seals,
+	unsigned long flags)
 {
 	*vm_seals = convert_mmap_seals(prot);
+	if (*vm_seals)
+	/* setting one of MM_SEAL_XX means the map is sealable. */
+		*vm_seals |= VM_SEALABLE;
+	else
+		*vm_seals |= (flags & MAP_SEALABLE) ? VM_SEALABLE:0;
 	return 0;
 }
 #else
@@ -3395,6 +3425,16 @@ static inline unsigned long vma_seals(struct vm_area_struct *vma)
 	return 0;
 }
 
+static inline unsigned long vma_enabled_seals(struct vm_area_struct *vma)
+{
+	return 0;
+}
+
+static inline bool is_vma_sealable(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 static inline bool check_vma_seals_mergeable(unsigned long vm_seals1, unsigned long vm_seals2)
 {
 	return true;
@@ -3426,11 +3466,15 @@ static inline void update_vma_seals(struct vm_area_struct *vma, unsigned long vm
  * check input sealing type from the "prot" field of mmap().
  * For not CONFIG_MSEAL, if SEAL flag is set, it will return failure.
  */
-static inline int check_mmap_seals(unsigned long prot, unsigned long *vm_seals)
+static inline int check_mmap_seals(unsigned long prot, unsigned long *vm_seals,
+	unsigned long flags)
 {
 	if (prot & PROT_SEAL_ALL)
 		return -EINVAL;
 
+	if (flags & MAP_SEALABLE)
+		return -EINVAL;
+
 	return 0;
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 052799173c86..c9b04c545f39 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -691,6 +691,7 @@ struct vm_area_struct {
 	/*
 	 * bit masks for seal.
 	 * need this since vm_flags is full.
+	 * We could merge this into vm_flags if vm_flags ever get expanded.
 	 */
 	unsigned long vm_seals;		/* seal flags, see mm.h. */
 #endif
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index bf503962409a..57ef4507c00b 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -47,6 +47,7 @@
 
 #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
 					 * uninitialized */
+#define MAP_SEALABLE	0x8000000	/* map is sealable. */
 
 /*
  * Flags for mlock
diff --git a/mm/mmap.c b/mm/mmap.c
index 6da8d83f2e66..6e35e2070060 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1235,7 +1235,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (flags & MAP_FIXED_NOREPLACE)
 		flags |= MAP_FIXED;
 
-	if (check_mmap_seals(prot, &vm_seals) < 0)
+	if (check_mmap_seals(prot, &vm_seals, flags) < 0)
 		return -EINVAL;
 
 	if (!(flags & MAP_FIXED))
diff --git a/mm/mseal.c b/mm/mseal.c
index 294f48d33db6..5d4cf71b497e 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -121,9 +121,13 @@ bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start, unsigned long
  */
 static bool can_add_vma_seals(struct vm_area_struct *vma, unsigned long newSeals)
 {
+	/* if map is not sealable, reject. */
+	if (!is_vma_sealable(vma))
+		return false;
+
 	/* When SEAL_MSEAL is set, reject if a new type of seal is added. */
 	if ((vma->vm_seals & MM_SEAL_SEAL) &&
-	    (newSeals & ~(vma_seals(vma))))
+	    (newSeals & ~(vma_enabled_seals(vma))))
 		return false;
 
 	/*
@@ -185,6 +189,7 @@ static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
  * 2> end is part of a valid vma.
  * 3> No gap (unallocated address) between start and end.
  * 4> requested seal type can be added in given address range.
+ * 5> map is sealable.
  */
 static int check_mm_seal(unsigned long start, unsigned long end,
 			 unsigned long newtypes)
-- 
2.43.0.472.g3155946c3a-goog

