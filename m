Return-Path: <linux-kernel+bounces-118294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BF788B755
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5AF71F3F8A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4EB12B168;
	Tue, 26 Mar 2024 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kN0ZnWiG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745A912AAEC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419450; cv=none; b=m3HEYJJnlk5NiZBs7tZRmv2sUa+59hUNA5S8MvR+n1xC51Ogw7bPB25vSmnwsR7rS/M5Dzc2ZE27mH0W0e/eFC1RDJ6CintP81ga4L2Pn2iPiJAdAorZtCogiq9YtKULnmwcavQpPhXw3fycWOMX5qcnmU5ncizjNLxzkVBCMxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419450; c=relaxed/simple;
	bh=uO697Q/RqZjisoLPzX7dc/TQTP+f7eWP95gfUGD1wX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJ/AvYSxXhBGR13yxkxle7efysOfvCcbGFNirx2xWreqglVBY058c8bSgS28B7cYil0BhcNyNAw1nCdN7sPZ9DYw480lPRP60adMOYidYI6nSn3/qs8dHHfloBO5umZYYp3f6q4bE+3mb6FCgPrtVbkQ/ypvU3W7RYQ7qv0niIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kN0ZnWiG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711419448; x=1742955448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uO697Q/RqZjisoLPzX7dc/TQTP+f7eWP95gfUGD1wX8=;
  b=kN0ZnWiGKB4j4TJILGXH/XyZ5+/aBPgbrcxUGJW5ve6UugBCLMBON1Or
   uWQW0zkKfue1oe8ASnFo8H2+3v41ulzT57MMKuB9Ic9DLqDdCHXdpZ7gf
   eyWTckmmBPocK5ECxzNZsZ7OtwXgwFPZ+uiHKMoFKY2smvm0tOx0sXv2x
   oze26M1EGCX/MbeE8o8s1wm/NVBh+2A37pFiZP8OuWpIKN35dE2roLGs+
   qAy5MWfSJ9P2xMH2cvdQf6aE0TUkLceNZgdSf1E3Ejps0IB/ZduXxPQXn
   FjiagO2ZTwD+UvVRWAQvqY31euXgab0nmCMSyCYIay+fKvjqboXKJGUmu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6564376"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6564376"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20489913"
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
Subject: [PATCH v4 12/14] x86/mm: Implement HAVE_ARCH_UNMAPPED_AREA_VMFLAGS
Date: Mon, 25 Mar 2024 19:16:54 -0700
Message-Id: <20240326021656.202649-13-rick.p.edgecombe@intel.com>
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

Add x86 arch implementations of arch_get_unmapped_area_vmflags/_topdown()
so future changes can allow the guard gap of type of vma being placed to
be taken into account. This will be used for shadow stack memory.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v3:
 - Commit log grammar

v2:
 - Remove unnecessary added extern
---
 arch/x86/include/asm/pgtable_64.h |  1 +
 arch/x86/kernel/sys_x86_64.c      | 25 ++++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 7e9db77231ac..3c4407271d08 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -245,6 +245,7 @@ extern void cleanup_highmap(void);
 
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+#define HAVE_ARCH_UNMAPPED_AREA_VMFLAGS
 
 #define PAGE_AGP    PAGE_KERNEL_NOCACHE
 #define HAVE_PAGE_AGP 1
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 96b9d29aead0..75966afb6251 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -113,8 +113,8 @@ static void find_start_end(unsigned long addr, unsigned long flags,
 }
 
 unsigned long
-arch_get_unmapped_area(struct file *filp, unsigned long addr,
-		unsigned long len, unsigned long pgoff, unsigned long flags)
+arch_get_unmapped_area_vmflags(struct file *filp, unsigned long addr, unsigned long len,
+		       unsigned long pgoff, unsigned long flags, vm_flags_t vm_flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -149,9 +149,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 }
 
 unsigned long
-arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
-			  const unsigned long len, const unsigned long pgoff,
-			  const unsigned long flags)
+arch_get_unmapped_area_topdown_vmflags(struct file *filp, unsigned long addr0,
+			  unsigned long len, unsigned long pgoff,
+			  unsigned long flags, vm_flags_t vm_flags)
 {
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
@@ -220,3 +220,18 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	 */
 	return arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
 }
+
+unsigned long
+arch_get_unmapped_area(struct file *filp, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	return arch_get_unmapped_area_vmflags(filp, addr, len, pgoff, flags, 0);
+}
+
+unsigned long
+arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr,
+			  const unsigned long len, const unsigned long pgoff,
+			  const unsigned long flags)
+{
+	return arch_get_unmapped_area_topdown_vmflags(filp, addr, len, pgoff, flags, 0);
+}
-- 
2.34.1


