Return-Path: <linux-kernel+bounces-82208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D38E868096
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E703292570
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96907132498;
	Mon, 26 Feb 2024 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZr3WyDE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C32C131E3C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974604; cv=none; b=CA5SIDSE8QVMHQ/cEpGGm1kJdiV/+gKalx/ryv3Z6ETpq/ssyiMU24xfcPZAbvoYGdxLm82yM6ydff5aBBpesA2aEmtuygXH4dSjDrCzPYYy+PD7X5gj3MB+hWiLW3ABn+nevVW9zZ1lp6L92uYlGVssElu6szwucPsdB7he+Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974604; c=relaxed/simple;
	bh=U3F9hHxdfZ7A6mCry7GoiZtnuJCP/wXQbUGWHcLnyx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kF9ODpnBxB+lQljNPn29vva66zZBvKBlYf2hBEK0HZEzbaaP+x2UhF09SfK9vSj3pxRkJZvb32B4sM+OYgBbMj0/X3CzG0buVkXH2tNPmksfsWEppjMrH0QKAqYjRDFCaRqCZM/9TkOeSrlpG6sf5rGqYdKCOnmguCa/z0dkLoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZr3WyDE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708974603; x=1740510603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U3F9hHxdfZ7A6mCry7GoiZtnuJCP/wXQbUGWHcLnyx0=;
  b=jZr3WyDERrAyY/xBfwcsOm7udIKEXcLZQIXVvXpkOb+fXQ2tduZ8yLCP
   Jy/l5vfDm5tHia8AOgqu/Dwn9paTGvM/51ToDFboZEizHA/XFCTAdOj41
   IMZzZLWSH2kvJ540UgkQOmcjcgOcfE5mp2NFbF/NUZVyH5TZi7UuXHRO1
   3Ih8A04OF8r/Nb/wUeTRr796EUUL2KYxWEtJQ66i3urYTEuMh3JrXSGLJ
   wT8IxCTuNyS7Is+tdgRFKpjb16edsm7+wXPiDU1rbvY0gWvm1w2SdG+4t
   Dd+Tl1aR5jqQyhUcaZpAVPpI+WPactiXygL7fC8fBphG0JA7Ba1VWcesj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14721395"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="14721395"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:10:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6911463"
Received: from bdmirand-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.3.213])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:10:02 -0800
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
Subject: [PATCH v2 6/9] mm: Take placement mappings gap into account
Date: Mon, 26 Feb 2024 11:09:48 -0800
Message-Id: <20240226190951.3240433-7-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226190951.3240433-1-rick.p.edgecombe@intel.com>
References: <20240226190951.3240433-1-rick.p.edgecombe@intel.com>
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
index a091181ef65a..19fc1eb86b9a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3406,6 +3406,7 @@ struct vm_unmapped_area_info {
 	unsigned long high_limit;
 	unsigned long align_mask;
 	unsigned long align_offset;
+	unsigned long start_gap;
 };
 
 extern unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info);
diff --git a/mm/mmap.c b/mm/mmap.c
index 33af683a643f..3d7642eb84ea 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1574,7 +1574,7 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 
 	/* Adjust search length to account for worst case alignment overhead */
-	length = info->length + info->align_mask;
+	length = info->length + info->align_mask + info->start_gap;
 	if (length < info->length)
 		return -ENOMEM;
 
@@ -1586,7 +1586,13 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 	if (mas_empty_area(&mas, low_limit, high_limit - 1, length))
 		return -ENOMEM;
 
-	gap = mas.index;
+	/*
+	 * Adjust for the gap first so it doesn't interfere with the
+	 * later alignment. The first step is the minimum needed to
+	 * fufill the start gap, the next steps is the minimum to align
+	 * that. It is the minimum needed to fufill both.
+	 */
+	gap = mas.index + info->start_gap;
 	gap += (info->align_offset - gap) & info->align_mask;
 	tmp = mas_next(&mas, ULONG_MAX);
 	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
@@ -1625,7 +1631,7 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
-	length = info->length + info->align_mask;
+	length = info->length + info->align_mask + info->start_gap;
 	if (length < info->length)
 		return -ENOMEM;
 
-- 
2.34.1


