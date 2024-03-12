Return-Path: <linux-kernel+bounces-100894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B8A879EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155DC1F233DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205C4143C6F;
	Tue, 12 Mar 2024 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyJOLy9p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461B71448E6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282551; cv=none; b=rbGMc9p5TP3JNXLTAap5lKtk0UJAAW+tHgFNUqvv+TfXJnpu587/95DhK+/OhGXzOsuGJbvHQW3TuQRtBqDjWiAQtH6k0NZpjAlvXMfv2ZvwXdquVqb7C6SJ7IOdUK4Co9bZJ30yzm9xsw9rO1eHmgRmic5isgv3S9LbLt/irU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282551; c=relaxed/simple;
	bh=DqX79GXBAG2/j46/SZGgINNlJjEl0m3V0W63EM+RdAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k78BSFm8ZyDMAng6E/1MEsnQUEREG7AORKT2w11gevwDlqvk2aL4Q/YQT026O9Vn5XABoBobCs2DUWoBYKxOH6jiF4qoQLmAn115jIlcdU2oFR88INe3Xvj4E8K2bwXQj5Gtwo0gJLtqCV9W0Dc3DsWzoG+5L0Q3kfDH+vQryVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyJOLy9p; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710282549; x=1741818549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DqX79GXBAG2/j46/SZGgINNlJjEl0m3V0W63EM+RdAU=;
  b=eyJOLy9pry3ZnXbUhxW2Sx4lpHv+Lhs8nQg73Ni2LZacxHn4fh3H22Ny
   emcMvD9HBw9SDeCJXvXyqs+JGKzzTGYlk2mzYmD2bK13O1Mgqk7bO31SD
   MohS3G978Z+EXEEkYVwDeHMNFWARbXufA1xblVTBokwaeBHyKFu/ZolgY
   CX4XQhZYcRjTyHk8f/AqtWEFADf5AU3lucqM2rqpt4JfltV2YVNcjD0GU
   E1zQ01yTLMgVt/dlp4LCojJK8qu+QPJMqlBgAJQQb2z6j/f/H44mW+Ip4
   sDHEeYw6V4pbkhP+nCPZnnnLTmcYUujrorWvH9/kQIXSaWxsCiR+6yrkE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5192057"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5192057"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16356874"
Received: from gargayus-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.255.231.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:04 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	broonie@kernel.org,
	dave.hansen@linux.intel.com,
	debug@rivosinc.com,
	hpa@zytor.com,
	keescook@chromium.org,
	kirill.shutemov@linux.intel.com,
	luto@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	x86@kernel.org,
	christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rick.p.edgecombe@intel.com
Subject: [PATCH v3 09/12] mm: Take placement mappings gap into account
Date: Tue, 12 Mar 2024 15:28:40 -0700
Message-Id: <20240312222843.2505560-10-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
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

Use the start_gap field to find a space that includes the guard gap for
the new mapping. Take care to not interfere with the alignment.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v3:
 - Spelling fix in comment

v2:
 - Remove VM_UNMAPPED_START_GAP_SET and have struct vm_unmapped_area_info
   initialized with zeros (in another patch). (Kirill)
 - Drop unrelated space change (Kirill)
 - Add comment around interactions of alignment and start gap step
   (Kirill)
---
 include/linux/mm.h |  1 +
 mm/mmap.c          | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d91cde79aaee..deade7be00d0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3418,6 +3418,7 @@ struct vm_unmapped_area_info {
 	unsigned long high_limit;
 	unsigned long align_mask;
 	unsigned long align_offset;
+	unsigned long start_gap;
 };
 
 extern unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info);
diff --git a/mm/mmap.c b/mm/mmap.c
index b889c79d11bd..634e706fd97e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1582,7 +1582,7 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 
 	/* Adjust search length to account for worst case alignment overhead */
-	length = info->length + info->align_mask;
+	length = info->length + info->align_mask + info->start_gap;
 	if (length < info->length)
 		return -ENOMEM;
 
@@ -1594,7 +1594,13 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 	if (mas_empty_area(&mas, low_limit, high_limit - 1, length))
 		return -ENOMEM;
 
-	gap = mas.index;
+	/*
+	 * Adjust for the gap first so it doesn't interfere with the
+	 * later alignment. The first step is the minimum needed to
+	 * fulill the start gap, the next steps is the minimum to align
+	 * that. It is the minimum needed to fulill both.
+	 */
+	gap = mas.index + info->start_gap;
 	gap += (info->align_offset - gap) & info->align_mask;
 	tmp = mas_next(&mas, ULONG_MAX);
 	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
@@ -1633,7 +1639,7 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
-	length = info->length + info->align_mask;
+	length = info->length + info->align_mask + info->start_gap;
 	if (length < info->length)
 		return -ENOMEM;
 
-- 
2.34.1


