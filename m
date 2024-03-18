Return-Path: <linux-kernel+bounces-106159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F2987EA02
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467F91C2105E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C1F47A67;
	Mon, 18 Mar 2024 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQIC7C78"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F4B45BFA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710768254; cv=none; b=h/GAmx3hYtxXd02wn1MOal3iDPO9FoFUs5kfgrT6/r0k/ty7um1w7rXqgFuBaHdQivFcKvExnZmJRSX3IBqtmHsXCdFHYhcJ2HaVt9+A3TWUY/5gbJTyE6xiEP/jNCos3ua/3Yr94jgUHJqtlw5y9qQ937sQH+jVlmT7exmQ4TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710768254; c=relaxed/simple;
	bh=6XG9peCgdkVt7DtdGWYG9FGSKJXneNx01xZftM/aGBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IPD3LBZn5EcBSlZy8KoyQHXp8FjX/mwJw7WsZjdmfqwnGGtfv4/uJ5UuxNfUzsvPsS23HC97ZjRgRzBC6pY3/Co5VkY1RwufueAGVLt1fxpe/Wp95F1951zeLxDkUo5v/Azpe5b9cWjR0yIX8O6iNh5HcDlk69yacbzaYFI/pdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQIC7C78; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710768251; x=1742304251;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6XG9peCgdkVt7DtdGWYG9FGSKJXneNx01xZftM/aGBg=;
  b=SQIC7C78MPpopgzSJLdxGAHbY5bFCeXYxRcXpaaagfYhepgSebdRuS3M
   mzOv6siAbVD+sp4oEBNgvFH/4VJBpymTJVFOqcDt5rObr9yE/0a8STY2k
   p3UhKNWwoYrwiTKoC6ZV25ZejpjMzwobcIDvQDX2eAyjE665+r5xgrfCh
   uNreA520xfeSyXZCgKk6JiXrnqew9TsK5rxFjZb2Qd4OxEAanLgU5X3rh
   9o8zyy6qoLVsJwM7q8qUr5iSc7lan9HLsJlGcDA+a6dIgtvLUkNeABniy
   BSXqaSsEVYjf9PVoHx4M9rikqOGcbcEk5g2MhfucZ0qxmCGkDx/TwEq4U
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="23037911"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="23037911"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 06:24:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="14102713"
Received: from adr-par-inspur1.iind.intel.com ([10.223.93.209])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 06:24:07 -0700
From: Aravinda Prasad <aravinda.prasad@intel.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org,
	linux-kernel@vger.kernel.org
Cc: aravinda.prasad@intel.com,
	s2322819@ed.ac.uk,
	sandeep4.kumar@intel.com,
	ying.huang@intel.com,
	dave.hansen@intel.com,
	dan.j.williams@intel.com,
	sreenivas.subramoney@intel.com,
	antti.kervinen@intel.com,
	alexander.kanevskiy@intel.com
Subject: [PATCH v2 0/3] mm/damon: Profiling enhancements for DAMON
Date: Mon, 18 Mar 2024 18:58:45 +0530
Message-Id: <20240318132848.82686-1-aravinda.prasad@intel.com>
X-Mailer: git-send-email 2.21.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DAMON randomly samples one or more pages in every region and tracks
accesses to them using the ACCESSED bit in PTE (or PMD for 2MB pages).
When the region size is large (e.g., several GBs), which is common
for large footprint applications, detecting whether the region is
accessed or not completely depends on whether the pages that are
actively accessed in the region are picked during random sampling.
If such pages are not picked for sampling, DAMON fails to identify
the region as accessed. However, increasing the sampling rate or
increasing the number of regions increases CPU overheads of kdamond.

This patch proposes profiling different levels of the application’s
page table tree to detect whether a region is accessed or not. This
patch set is based on the observation that, when the accessed bit for a
page is set, the accessed bits at the higher levels of the page table
tree (PMD/PUD/PGD) corresponding to the path of the page table walk
are also set. Hence, it is efficient to check the accessed bits at
the higher levels of the page table tree to detect whether a region
is accessed or not. For example, if the access bit for a PUD entry
is set, then one or more pages in the 1GB PUD subtree is accessed as
each PUD entry covers 1GB mapping. Hence, instead of sampling
thousands of 4K/2M pages to detect accesses in a large region, 
sampling at the higher level of page table tree is faster and efficient.

This patch set is based on 6.8-rc5 kernel (commit: f48159f8, mm-unstable
tree)

Changes since v1 [1]
====================

 - Added support for 5-level page table tree
 - Split the patch to mm infrastructure changes and DAMON enhancements
 - Code changes as per comments on v1
 - Added kerneldoc comments

[1] https://lkml.org/lkml/2023/12/15/272
 
Evaluation:

- MASIM benchmark with 1GB, 10GB, 100GB footprint with 10% hot data
  and 5TB with 10GB hot data.
- DAMON: 5ms sampling, 200ms aggregation interval. Rest all
  parameters set to default value.
- DAMON+PTP: Page table profiling applied to DAMON with the above
  parameters.

Profiling efficiency in detecting hot data:

Footprint	1GB	10GB	100GB	5TB
---------------------------------------------
DAMON		>90%	<50%	 ~0%	  0%
DAMON+PTP	>90%	>90%	>90%	>90%

CPU overheads (in billion cycles) for kdamond:

Footprint	1GB	10GB	100GB	5TB
---------------------------------------------
DAMON		1.15	19.53	3.52	9.55
DAMON+PTP	0.83	 3.20	1.27	2.55

A detailed explanation and evaluation can be found in the arXiv paper:
https://arxiv.org/pdf/2311.10275.pdf


Aravinda Prasad (3):
  mm/damon: mm infrastructure support
  mm/damon: profiling enhancement
  mm/damon: documentation updates

 Documentation/mm/damon/design.rst |  42 ++++++
 arch/x86/include/asm/pgtable.h    |  20 +++
 arch/x86/mm/pgtable.c             |  28 +++-
 include/linux/mmu_notifier.h      |  36 +++++
 include/linux/pgtable.h           |  79 ++++++++++
 mm/damon/vaddr.c                  | 233 ++++++++++++++++++++++++++++--
 6 files changed, 424 insertions(+), 14 deletions(-)

-- 
2.21.3


