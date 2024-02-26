Return-Path: <linux-kernel+bounces-82211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1439C868099
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DEF1C28822
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5514F132C3E;
	Mon, 26 Feb 2024 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7dIZYyv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ADB132471
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974606; cv=none; b=UQr+I1zK560AZXV9jMPVyqYnCkLTw02J9Y8S+ZNsrJMBQEe3O3ij0g+GTXylnv4iHTVerNKKrICsqRKAMwzRl0JIU015mfznH18tB1WjR/XyGUAXDzyhEdSDYuhefDmxz6+CskIJu9sp2lP4/Y9vzfiMinUOs6iSbjryOw0BIaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974606; c=relaxed/simple;
	bh=PSY3c+TQ2hmITdUufmc9vn7rLXvDTbUQjAaHGocBj3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNd0cij0p/U+jMygqLr7PbIVdjPvzMU+puju+5FnanPAOebfXHfEB5QKEZTkLbC298WyKkg0S+n6So92ZFAJWBgPKQMnsgCGugXi/ws2sAs5PF+kSiqJcsaZKHNE8VsesiKIBZHFpmlwpZ75O4aaQ6aZWjVaZpuByrzcTbJxatc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7dIZYyv; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708974605; x=1740510605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PSY3c+TQ2hmITdUufmc9vn7rLXvDTbUQjAaHGocBj3w=;
  b=U7dIZYyvQs6leiB/kfmBlgVEpXV2Jm6XErpvbeC7L41jFPfx6PS9QnIR
   fLIMP6pKIfwD0lduKPDGrYOtzg87LMKciaLhFaybzLaAC9jxHgTFV10O+
   oeEkbx2bUaKoaIaVoOToYOu6tm7HH3d2ea9uRMzcIaFXbhdam7t09oJhz
   CVBomgBoDW20o3xaukFmNJZAJT1VpPoTCTBcnUXosoH3jH9ocgg6fasGf
   OXAHK97VOoXHx37HVlaWl5zNEBkBD2l7gaSe4pDCaQO2TgGCmIZXEeq1l
   05+iWI99ns2M++fLqfnqA657ygey2ftUwKpdHz2NGET+8qyl46ngwXtNE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14721420"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="14721420"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:10:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6911471"
Received: from bdmirand-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.3.213])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:10:03 -0800
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
Subject: [PATCH v2 8/9] x86/mm: Care about shadow stack guard gap during placement
Date: Mon, 26 Feb 2024 11:09:50 -0800
Message-Id: <20240226190951.3240433-9-rick.p.edgecombe@intel.com>
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

Now that the vm_flags is passed into the arch get_unmapped_area()'s, and
vm_unmapped_area() is ready to consider it, have VM_SHADOW_STACK's get
guard gap consideration for scenario 2.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/sys_x86_64.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 95cb9efc47fb..f44afb3345db 100644
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
@@ -150,6 +158,7 @@ arch_get_unmapped_area_vmflags(struct file *filp, unsigned long addr, unsigned l
 	info.high_limit = end;
 	info.align_mask = 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
+	info.start_gap = stack_guard_placement(vm_flags);
 	if (filp) {
 		info.align_mask = get_align_mask();
 		info.align_offset += get_align_bits();
@@ -199,6 +208,7 @@ arch_get_unmapped_area_topdown_vmflags(struct file *filp, unsigned long addr0,
 		info.low_limit = PAGE_SIZE;
 
 	info.high_limit = get_mmap_base(0);
+	info.start_gap = stack_guard_placement(vm_flags);
 
 	/*
 	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
-- 
2.34.1


