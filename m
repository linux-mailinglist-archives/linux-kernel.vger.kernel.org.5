Return-Path: <linux-kernel+bounces-67819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999CB85716B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7DB1C21A08
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910D314C59D;
	Thu, 15 Feb 2024 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZFz9HTh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E29114A0BE
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038885; cv=none; b=cb045/qJ6zu+wrCr5cVaqHLljkROJ3BpUoiQVVERDX0FdDWTGBgGvgpr3UFyHpG6sLTsAjDXbOmx5Zq3pKAEKfL7qAc6zGyUAToruQ1WvBfDs7mCcrI4A0vAT/jg+pUwhXa59j2fyht1DS8Dez6nFH3aFP2e8ataRZKgulPAw1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038885; c=relaxed/simple;
	bh=Ib9DRZGDBCSUD4uXPmR+ijcvzy4h1J3AkaOgyP6jQrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlhR5j7cZdmVHU4nxOXRX4SH6QHfiYuRku/AmVqCvQXhUMzFA7LVUp4t/UrziUvFp+0xmLCPns7BIabNk5Hqa75l0ml6cwK6ekmJEP7EjofApmj1DW+rdHTgOayN+JcawQfQPwbssya6+MymRPiYdIXi7FHcTArrgsHNbJrzjNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZFz9HTh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708038884; x=1739574884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ib9DRZGDBCSUD4uXPmR+ijcvzy4h1J3AkaOgyP6jQrA=;
  b=aZFz9HThrAXYgiC93qZAMnKdqWEZXqXnbLivzJoGt6MORRK3hWMLXBBb
   mdYwToFGS83l+1BJsVIb1vz7QYsW3lqm8vbPZ6MbvPlG2AsNv347Kh4fz
   86l86S03256YyZBJU7Ae7P4sgVea75b2YLRXQe/oZ3XhNurn2N6sn1qIu
   nYruggcY+Gz5748T/jpXg259Ve5H1kY1mSws/MWV3CNNTuWf/epzFI1FD
   /U5FB73nXTBvk6/FHRovQ1R71jyXJywfnbGLhoCwSWplc/LhXmO42VE+w
   Eb/f43bAYS1zhnoPOp95vhZtUiZMBpmP1ioK73ngqHKh2EpfOYBl05jHx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2066367"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2066367"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 15:14:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912250200"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912250200"
Received: from yshin-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.209.95.133])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 15:14:40 -0800
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	debug@rivosinc.com,
	broonie@kernel.org,
	kirill.shutemov@linux.intel.com,
	keescook@chromium.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	peterz@infradead.org,
	hpa@zytor.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: rick.p.edgecombe@intel.com
Subject: [RFC PATCH 5/8] mm: Take placement mappings gap into account
Date: Thu, 15 Feb 2024 15:13:29 -0800
Message-Id: <20240215231332.1556787-6-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
References: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When memory is being placed, mmap() will take care to respect the guard
gaps of certain types of memory (VM_SHADOWSTACK, VM_GROWSUP and
VM_GROWSDOWN). In order to ensure guard gaps between mappings, mmap()
needs to consider two things:
 1. That the new mapping isn’t placed in an any existing mappings guard
    gaps.
 2. That the new mapping isn’t placed such that any existing mappings
    are not in *its* guard gaps.

The long standing behavior of mmap() is to ensure 1, but not take any care
around 2. So for example, if there is a PAGE_SIZE free area, and a
mmap() with a PAGE_SIZE size, and a type that has a guard gap is being
placed, mmap() may place the shadow stack in the PAGE_SIZE free area. Then
the mapping that is supposed to have a guard gap will not have a gap to
the adjacent VMA.

For MAP_GROWSDOWN/VM_GROWSDOWN and MAP_GROWSUP/VM_GROWSUP this has not
been a problem in practice because applications place these kinds of
mappings very early, when there is not many mappings to find a space
between. But for shadow stacks, they may be placed throughout the lifetime
of the application.

So define a VM_UNMAPPED_START_GAP_SET flag to specify that a start_gap
field has been set, as most vm_unmapped_area_info structs are not zeroed,
so the added field will often contain garbage. Use
VM_UNMAPPED_START_GAP_SET in unmapped_area/_topdown() to find a space that
includes the guard gap for the new mapping. Take care to not interfere
with the alignment.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/mm.h |  2 ++
 mm/mmap.c          | 21 ++++++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9addf16dbf18..160bb6db7a16 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3393,12 +3393,14 @@ extern unsigned long __must_check vm_mmap(struct file *, unsigned long,
 
 struct vm_unmapped_area_info {
 #define VM_UNMAPPED_AREA_TOPDOWN 1
+#define VM_UNMAPPED_START_GAP_SET 2
 	unsigned long flags;
 	unsigned long length;
 	unsigned long low_limit;
 	unsigned long high_limit;
 	unsigned long align_mask;
 	unsigned long align_offset;
+	unsigned long start_gap;
 };
 
 extern unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info);
diff --git a/mm/mmap.c b/mm/mmap.c
index 936d728ba1ca..1b6c333656f9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1567,14 +1567,17 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
  */
 static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
-	unsigned long length, gap;
+	unsigned long length, gap, start_gap = 0;
 	unsigned long low_limit, high_limit;
 	struct vm_area_struct *tmp;
 
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 
+	if (info->flags & VM_UNMAPPED_START_GAP_SET)
+		start_gap = info->start_gap;
+
 	/* Adjust search length to account for worst case alignment overhead */
-	length = info->length + info->align_mask;
+	length = info->length + info->align_mask + start_gap;
 	if (length < info->length)
 		return -ENOMEM;
 
@@ -1586,7 +1589,7 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 	if (mas_empty_area(&mas, low_limit, high_limit - 1, length))
 		return -ENOMEM;
 
-	gap = mas.index;
+	gap = mas.index + start_gap;
 	gap += (info->align_offset - gap) & info->align_mask;
 	tmp = mas_next(&mas, ULONG_MAX);
 	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
@@ -1619,13 +1622,17 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
  */
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 {
-	unsigned long length, gap, gap_end;
+	unsigned long length, gap, gap_end, start_gap = 0;
 	unsigned long low_limit, high_limit;
 	struct vm_area_struct *tmp;
 
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
+
+	if (info->flags & VM_UNMAPPED_START_GAP_SET)
+		start_gap = info->start_gap;
+
 	/* Adjust search length to account for worst case alignment overhead */
-	length = info->length + info->align_mask;
+	length = info->length + info->align_mask + start_gap;
 	if (length < info->length)
 		return -ENOMEM;
 
@@ -1832,7 +1839,7 @@ unsigned long mm_get_unmapped_area_vmflags(struct mm_struct *mm, struct file *fi
 
 unsigned long
 __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
-		unsigned long pgoff, unsigned long flags, vm_flags_t vm_flags)
+		    unsigned long pgoff, unsigned long flags, vm_flags_t vm_flags)
 {
 	unsigned long (*get_area)(struct file *, unsigned long,
 				  unsigned long, unsigned long, unsigned long)
@@ -1883,7 +1890,7 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 
 unsigned long
 get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
-		unsigned long pgoff, unsigned long flags)
+		  unsigned long pgoff, unsigned long flags)
 {
 	return __get_unmapped_area(file, addr, len, pgoff, flags, 0);
 }
-- 
2.34.1


