Return-Path: <linux-kernel+bounces-106162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A8E87EA0A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC4A282DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169974DA1D;
	Mon, 18 Mar 2024 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMtKch29"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D694DA15
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710768277; cv=none; b=aeu99b7cYBZvv53UD5QLiaR1eU3vfIO34oVvah/9ld3pPYNuD8pEZHJabr9a7RazQAwyf5JA7VYTfH49gGjrBptiM86hj839YZai+78rPIGW3VyJ9rZx4IKmNwUAnqUHyd0lY9IWCxVjhXCYmjUKLq5ruBBlohnyp8KSiwYp0Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710768277; c=relaxed/simple;
	bh=uGFUoH8Waa+J7z1fmC561WGAlEYBZGb45Er8B07BwhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7dbQV/yPfyw437hsMT93MsGUgJgH83YtRYGkj2TD1KDO7EWHGOZB4uRNuK0MOvPff8e2sGHI+7JEXKPlDXwY4p+4srvIpfEZWzRw+uMWts33g9BZJDKKtNJXUQwB4Mx3d48Gc8AullcDR6dMpGd1VHRaGonnHwXWrGRpxRS0d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMtKch29; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710768275; x=1742304275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uGFUoH8Waa+J7z1fmC561WGAlEYBZGb45Er8B07BwhE=;
  b=OMtKch29PXKs7hfHqLHyg/4sjGnMpwJhUGQZLm7DAnFFvHplZT1SrCzY
   /6DAHE3oHOJ0Yjc25E1VQhfg6tAbKxHgh4OEFmS3FfyftrxekcTQz7T63
   zA/561xjUIngvLjgf0vmqCt3a7HuIBuCdK8iTD8yQ0m10NPu0wfVh6zaA
   IXv7HhgDuJy3/uF0APSuN6bQyJnSurw8f5EQNnTPbfg/vDzU5tzdHvLhR
   9+gp8sCuaPnCQhuIx+hzmapS01og2k6XRogIoBF4oeM3uda/PQiZiIznq
   US8/n08CqW01UYSW7PcLhpADlAj0yi03iKaLN32hxqPr1LGZlrvBP5Ck/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="23037998"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="23037998"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 06:24:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="14102868"
Received: from adr-par-inspur1.iind.intel.com ([10.223.93.209])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 06:24:31 -0700
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
Subject: [PATCH v2 3/3] mm/damon: documentation updates
Date: Mon, 18 Mar 2024 18:58:48 +0530
Message-Id: <20240318132848.82686-4-aravinda.prasad@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240318132848.82686-1-aravinda.prasad@intel.com>
References: <20240318132848.82686-1-aravinda.prasad@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch updates the kernel documentation.

Signed-off-by: Aravinda Prasad <aravinda.prasad@intel.com>
---
 Documentation/mm/damon/design.rst | 42 +++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 5620aab9b385..59014ecbb551 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -139,6 +139,48 @@ the interference is the responsibility of sysadmins.  However, it solves the
 conflict with the reclaim logic using ``PG_idle`` and ``PG_young`` page flags,
 as Idle page tracking does.
 
+Profiling enhancement for virtual address space
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For virtual address space tracking, relying on checking Accessed bit(s) only
+at the leaf level of the page table is inefficient. Hardware architectures
+have supported Accessed bit(s) at all levels of the page table tree by
+updating them during the page table walk. Hence, DAMON dynamically
+profiles different levels (PMD/PUD/P4D) of a multi-level page table tree.
+
+DAMON leverages the following key insight: a data page that is accessed
+should also have the Accessed bit set at PMD, PUD, P4D, and PGD entry.
+Similarly, if the Accessed bit in a PGD entry (or a PUD/PMD entry) is
+not set, then none of the data pages under the PGD entry (or PUD/PMD
+entry) subtree are accessed. DAMON profiles Accessed bits at the highest
+possible level of the page table tree to identify the regions that are
+accessed.
+
+For example, consider a region and the sampling address (SA) in the below
+figure. The address range of a PUD entry corresponding to SA is within
+region bounds and hence PUD is picked for checking and setting the
+Accessed bits. However, this not true if P4D is picked for profiling.
+Hence in this case PUD is the highest possible level that can be picked
+for profiling.
+                         .......
+                         + P4D +
+                         .......
+                        /       \
+                       /         \
+                      /           \
+                     /             \
+                    /               \
+                   /  .......        \
+                  /   + PUD +         \
+                 /    .......          \
+                /    /       \          \
+- - - - - +-----*---*--+====+-*------+- -*- - -
+          +            # SA #        +
+          +            #    #        +
+- - - - - +------------+====+--------+- - - - -
+
+          | ----- DAMON region ------|
+
 
 Core Logics
 ===========
-- 
2.21.3


