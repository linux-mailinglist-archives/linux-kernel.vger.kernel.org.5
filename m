Return-Path: <linux-kernel+bounces-100896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BB5879EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A351C2225A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2881145B27;
	Tue, 12 Mar 2024 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwiEAiAQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2437F145640
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282552; cv=none; b=guA7oj2MdunL1wW5MTjYD/oWir+rCfqaTNZAd8/g0qE5ApoThYYDlGujmMent42WDR7PW6V1LvvOlZ5/MJr3MZOzvbxfouXVsD690f2pzYaSN5tQG3uBChd01ShCW7jUoDJT3ZCLm39AJbogfDiYg6E25Nbf5Oom3pTAM7BVclI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282552; c=relaxed/simple;
	bh=TSd5WZe/p2AZRhCNpPLqqksEWjeny0UmWfCVRjzSme8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUp9dCoauY4FRo1+B10rvDaj3qidYapuv3aERZ38SEV83YI+6YiMvfcBVIEjCbAiayvQUQKYGNJ3MU/fltpz7nbaMHJyTOpH2NVXVwPhI5HAf/5XU0DXYhrlQOEp7t3VdluRIZE3qtkUE/i0rOfarXT2G1EKMLby+SoApH3wuFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwiEAiAQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710282551; x=1741818551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TSd5WZe/p2AZRhCNpPLqqksEWjeny0UmWfCVRjzSme8=;
  b=CwiEAiAQxiaaJgzmACJGOaxq1ebSWc5WxWBMGXe+DlDRHvjVdF8Gzpti
   Mkot/mlUV7LV0qGejLkSCuAKMsb5YnKWckjHDEAtrihVzjE2yjBt6HfDC
   apcaMzguMx+ZO0VJsEhtcXMFCOYG7DzNezR8mDAICZjcmp9rvSKk9T55I
   vkTkneF0MvJ9l3FUJK6gz7LnzxrMPd9fkXzg8dbzN80R9kIUU6MyJfYAR
   r7mE8AVDmMEG0+A3cWdUG7qNNURCTpMcQw2C553SO5WqJicdaKEICuPOz
   vz0QKGWpdZc3xcxUoxgBBwA0Jn9tBYEWJQcAeP6GMxmXMi1AR5haahScH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5192088"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5192088"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16356883"
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
Subject: [PATCH v3 11/12] x86/mm: Care about shadow stack guard gap during placement
Date: Tue, 12 Mar 2024 15:28:42 -0700
Message-Id: <20240312222843.2505560-12-rick.p.edgecombe@intel.com>
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

Now that the vm_flags is passed into the arch get_unmapped_area()'s, and
vm_unmapped_area() is ready to consider it, have VM_SHADOW_STACK's get
guard gap consideration for scenario 2.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/sys_x86_64.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index d6fbc4dd08ef..964cb435710e 100644
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
 unsigned long
 arch_get_unmapped_area_vmflags(struct file *filp, unsigned long addr, unsigned long len,
 		       unsigned long pgoff, unsigned long flags, vm_flags_t vm_flags)
@@ -148,6 +156,7 @@ arch_get_unmapped_area_vmflags(struct file *filp, unsigned long addr, unsigned l
 	info.low_limit = begin;
 	info.high_limit = end;
 	info.align_offset = pgoff << PAGE_SHIFT;
+	info.start_gap = stack_guard_placement(vm_flags);
 	if (filp) {
 		info.align_mask = get_align_mask();
 		info.align_offset += get_align_bits();
@@ -197,6 +206,7 @@ arch_get_unmapped_area_topdown_vmflags(struct file *filp, unsigned long addr0,
 		info.low_limit = PAGE_SIZE;
 
 	info.high_limit = get_mmap_base(0);
+	info.start_gap = stack_guard_placement(vm_flags);
 
 	/*
 	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
-- 
2.34.1


