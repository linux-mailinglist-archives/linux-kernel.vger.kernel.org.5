Return-Path: <linux-kernel+bounces-118291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238B988B752
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C921F3F77C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C62012A166;
	Tue, 26 Mar 2024 02:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETk6m2J4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA0312881C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419446; cv=none; b=p+HcUSS+XCYVX9MknMgT9fh/kFVB+sTNMNCTu+1akyOxaax0lrCNfp4Pe+4Rguhp2P6Ih9O1Nd9pjYmFW5yEDlZJscAm9EbJNVAaX0BWUnF8GjUBgp/rO8MvyMc3nWOa26MRu/UiB9yepM27WbGAILd8mLy4qbYH0CTF2E9XhzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419446; c=relaxed/simple;
	bh=sxOpaISc6XsCBcTnaTun5GkWeCaUbW+4JANtdWXac9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdZnbWk5QUtzkZ4mfLGpJk3L9OWwIZTTgDoG58RYr49CrPwQaUXwDLQNXgxKu0+8URAThEu1yINUP/uxCaP4Oi4Gex1jewpWblVcvfQhzoGwqdkD225fn/uAcrxeJXsQCA8MMZIoPBrunIQQNNW+cn2b9FVWKFnrlg/uFversVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETk6m2J4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711419445; x=1742955445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sxOpaISc6XsCBcTnaTun5GkWeCaUbW+4JANtdWXac9M=;
  b=ETk6m2J4GpnzWV5nizrWiKss6f6vTKFVdcy9TBlglh45FMosZRFn6EjP
   BIxIlXdZcOewqb15Qh3wogt7TZK+E+5J9I1EHJPy4NLNU4Xr98/JnTuIg
   F2dxyJKWly2jwFB4MnquHHmhMqC6zSUFi/Jli6mRhiz2RlcwwxlMjfSjt
   eV6xe9w5Cl0GwioSYZjfuAdue8XFsYCyDHhHuzefxmPxuZLc2xxwquGk+
   qhFJMEsAlc04KW7e6+5q58ZOssjivFf9ibEMZbSSGFkUtHfCeewF+LsTk
   +vUcdENqIi9YMak817WKTbmZIJRVQWFcoKNEo53cK1yN+lpQYbezCmV5B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6564362"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6564362"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20489909"
Received: from rpwilson-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.11.187])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:17 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	broonie@kernel.org,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	debug@rivosinc.com,
	hpa@zytor.com,
	keescook@chromium.org,
	kirill.shutemov@linux.intel.com,
	luto@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	x86@kernel.org
Cc: rick.p.edgecombe@intel.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4 11/14] mm: Take placement mappings gap into account
Date: Mon, 25 Mar 2024 19:16:53 -0700
Message-Id: <20240326021656.202649-12-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326021656.202649-1-rick.p.edgecombe@intel.com>
References: <20240326021656.202649-1-rick.p.edgecombe@intel.com>
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
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
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
index 8b13cd891b53..5c7f75edfde1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3438,6 +3438,7 @@ struct vm_unmapped_area_info {
 	unsigned long high_limit;
 	unsigned long align_mask;
 	unsigned long align_offset;
+	unsigned long start_gap;
 };
 
 extern unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info);
diff --git a/mm/mmap.c b/mm/mmap.c
index 609c087bba8e..2d9e7a999774 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1580,7 +1580,7 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 
 	/* Adjust search length to account for worst case alignment overhead */
-	length = info->length + info->align_mask;
+	length = info->length + info->align_mask + info->start_gap;
 	if (length < info->length)
 		return -ENOMEM;
 
@@ -1592,7 +1592,13 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
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
@@ -1631,7 +1637,7 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
-	length = info->length + info->align_mask;
+	length = info->length + info->align_mask + info->start_gap;
 	if (length < info->length)
 		return -ENOMEM;
 
-- 
2.34.1


