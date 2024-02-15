Return-Path: <linux-kernel+bounces-67821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDE485716C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C10281B56
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E10114D44C;
	Thu, 15 Feb 2024 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PVh08EVe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6108014AD24
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038887; cv=none; b=SO827y/gPA8hQVS/H/XetiTszVnvIa17ITCCoOSkHjo9dOT4zEViHsj/O4UQIDxpUExUcLlJceia502JT8as+7aRx3YoHah3IPNCGraAXG/LVAFtrB5yOUAdAZKbnRlVH885DIUuKaTs3re2H5135sKd3iKY9tT57IFofLMBo+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038887; c=relaxed/simple;
	bh=fQLzGTXW5Y/EBT0eWnQYJ+GT+r/+mVoQa4wR7CvVXl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqK7ZWSOf56zozTbSD4G3ID/AAGKr/+LVfoefbuJwgPdvcYyhrUKAtuhGritUXQ/cQXskQSJMReG7utUqc5Sv/P8WhejOnz2u7uIo4c/nrz3KudXwhgYFrpbE72O36muAS6NlzIPKoVoX8oVPL5Kqohe/qWhnNJjfu7xJYaW/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PVh08EVe; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708038885; x=1739574885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fQLzGTXW5Y/EBT0eWnQYJ+GT+r/+mVoQa4wR7CvVXl4=;
  b=PVh08EVezN8JnrhzLkbq0lM+KeuoNBnEybXTIw8rqwcf5mwgy9AVdhxE
   vyRjbcM8wg1LqUif4GKWl6o3aQyK25+ji/te3cLD/K8kbvVe+eA4l25yf
   g4gVQQZeHdXVY5FINTevT6rbZAXB/Gi7sIPhoVQZGJUnVG/xKRpTsGDGq
   +GP5+HtTCHH0mzmEped4jGp3lcpD2Ye+Icd2mbsf+A45ed+UzZ9HbOhrY
   CxEzJFfOfzM3bVzrcYVUkGHGxcQDJ0b3Nzrpgh1YQpFWklZdOuKfH7156
   7MHa+aHKiioT6vPPN+n+TQaKy9m57yl/FQqbPxD0rX149sCtWFpXiy34u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2066396"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2066396"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 15:14:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912250207"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912250207"
Received: from yshin-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.209.95.133])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 15:14:41 -0800
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
Subject: [RFC PATCH 7/8] x86/mm: Care about shadow stack guard gap during placement
Date: Thu, 15 Feb 2024 15:13:31 -0800
Message-Id: <20240215231332.1556787-8-rick.p.edgecombe@intel.com>
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

Now that the vm_flags is passed into the arch get_unmapped_area()'s, and
vm_unmapped_area() is ready to consider it, have VM_SHADOW_STACK's get
guard gap consideration for scenario 2.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/sys_x86_64.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index f92780cf9662..3b78fdc235fc 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -119,6 +119,14 @@ static void find_start_end(unsigned long addr, unsigned long flags,
 		*end = task_size_64bit(addr > DEFAULT_MAP_WINDOW);
 }
 
+static inline unsigned long stack_guard_placement(vm_flags_t vm_flags)
+{
+	if (vm_flags & VM_SHADOW_STACK)
+		return PAGE_SIZE;
+
+	return 0;
+}
+
 extern unsigned long
 arch_get_unmapped_area_vmflags(struct file *filp, unsigned long addr, unsigned long len,
 		       unsigned long pgoff, unsigned long flags, vm_flags_t vm_flags)
@@ -144,12 +152,13 @@ arch_get_unmapped_area_vmflags(struct file *filp, unsigned long addr, unsigned l
 			return addr;
 	}
 
-	info.flags = 0;
+	info.flags = VM_UNMAPPED_START_GAP_SET;
 	info.length = len;
 	info.low_limit = begin;
 	info.high_limit = end;
 	info.align_mask = 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
+	info.start_gap = stack_guard_placement(vm_flags);
 	if (filp) {
 		info.align_mask = get_align_mask();
 		info.align_offset += get_align_bits();
@@ -191,7 +200,7 @@ arch_get_unmapped_area_topdown_vmflags(struct file *filp, unsigned long addr0,
 	}
 get_unmapped_area:
 
-	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN | VM_UNMAPPED_START_GAP_SET;
 	info.length = len;
 	if (!in_32bit_syscall() && (flags & MAP_ABOVE4G))
 		info.low_limit = SZ_4G;
@@ -199,6 +208,7 @@ arch_get_unmapped_area_topdown_vmflags(struct file *filp, unsigned long addr0,
 		info.low_limit = PAGE_SIZE;
 
 	info.high_limit = get_mmap_base(0);
+	info.start_gap = stack_guard_placement(vm_flags);
 
 	/*
 	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
-- 
2.34.1


