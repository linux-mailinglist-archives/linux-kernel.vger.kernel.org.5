Return-Path: <linux-kernel+bounces-85624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F276186B862
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EB01F26C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35EC7784C;
	Wed, 28 Feb 2024 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9uyHwzo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909F06FD00;
	Wed, 28 Feb 2024 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149049; cv=none; b=jKwBWH5HWvREMbtUU6IgT44EDXoqVfH6FGOaflsRd+9wcqs3pqB46ODHcPNhllgsfE7gKqP3N4c9DnMsMplc5jqxyuefLWjJOCHJvYN9E47i0apiH73lZya6hhk9oY3BalmMhxDHtHFqzVEiEHDdr8gUUHzUbTACz2gy/2PdbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149049; c=relaxed/simple;
	bh=Zt8rdVP9ferchSPjP8MyEknFNupbw37j1uwmdwWPA+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIIqGuSwhmJJeoRareTXsdY2eCo1JvlONvYWIosbn0iZfS+CHWHweYgno2znRzkysmptisYBXW0VTM0cohtCxemnEVAfhjoKq720WOihbeI3IL9eHvUpTPs2S0AfJawBkgTJ5lBhAHRz25PN3nTJwQFa/yc6Yf9REx9Qr5Q2P6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9uyHwzo; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709149048; x=1740685048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zt8rdVP9ferchSPjP8MyEknFNupbw37j1uwmdwWPA+0=;
  b=n9uyHwzoFUuhesCzQhDLVV1vMY+gvG7OkDP7FbSJbkMPu8n8xWfYwaTU
   BGHWmGbrTkpDSWi7toshf5BWxOXpSvI2IIlvHeT6ppkBj/lWhGkfYbOZD
   Yc5yyiDHuovNEr2QAcoiTGpQYqy6JLrdHw0kMn1txo7lCL0+ZwqaLU5OM
   CSww2MLh9jzvfYdagqtBEWSUoWw5KDMF/h+jmA3+MTuD3qWwymWHGJHIA
   hWpi1O4nTKWK73c7+Bsg1Yrg8B1v+Y5uQKBHkWIHrJB//DKKYi5fj4xd8
   hZ0c4kx9JQ42OpQ6jgwFF1Ruh2GWoe3U2g7BCW52MR2ZppE3dr03xZ2Gq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3495589"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3495589"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:37:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7485407"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:37:21 -0800
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	x86@kernel.org
Cc: Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Drew Fustini <dfustini@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v15 8/8] x86/resctrl: Update documentation with Sub-NUMA cluster changes
Date: Wed, 28 Feb 2024 11:37:03 -0800
Message-ID: <20240228193717.8170-10-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228112935.8087-tony.luck@intel.com>
References: <20240228112215.8044-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With Sub-NUMA Cluster mode enabled the scope of monitoring resources is
per-NODE instead of per-L3 cache. Suffixes of directories with "L3" in
their name refer to Sub-NUMA nodes instead of L3 cache ids.

Users should be aware that SNC mode also affects the amount of L3 cache
available for allocation within each SNC node.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/arch/x86/resctrl.rst | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index a6279df64a9d..15f1cff6ee76 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -366,10 +366,10 @@ When control is enabled all CTRL_MON groups will also contain:
 When monitoring is enabled all MON groups will also contain:
 
 "mon_data":
-	This contains a set of files organized by L3 domain and by
-	RDT event. E.g. on a system with two L3 domains there will
-	be subdirectories "mon_L3_00" and "mon_L3_01".	Each of these
-	directories have one file per event (e.g. "llc_occupancy",
+	This contains a set of files organized by L3 domain or by NUMA
+	node (depending on whether Sub-NUMA Cluster (SNC) mode is disabled
+	or enabled respectively) and by RDT event.  Each of these
+	directories has one file per event (e.g. "llc_occupancy",
 	"mbm_total_bytes", and "mbm_local_bytes"). In a MON group these
 	files provide a read out of the current value of the event for
 	all tasks in the group. In CTRL_MON groups these files provide
@@ -478,6 +478,23 @@ if non-contiguous 1s value is supported. On a system with a 20-bit mask
 each bit represents 5% of the capacity of the cache. You could partition
 the cache into four equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
 
+Notes on Sub-NUMA Cluster mode
+==============================
+When SNC mode is enabled, Linux may load balance tasks between Sub-NUMA
+nodes much more readily than between regular NUMA nodes since the CPUs
+on Sub-NUMA nodes share the same L3 cache and the system may report
+the NUMA distance between Sub-NUMA nodes with a lower value than used
+for regular NUMA nodes.  Users who do not bind tasks to the CPUs of a
+specific Sub-NUMA node must read the "llc_occupancy", "mbm_total_bytes",
+and "mbm_local_bytes" for all Sub-NUMA nodes where the tasks may execute
+to get the full view of traffic for which the tasks were the source.
+
+The cache allocation feature still provides the same number of
+bits in a mask to control allocation into the L3 cache, but each
+of those ways has its capacity reduced because the cache is divided
+between the SNC nodes. The values reported in the resctrl
+"size" files are adjusted accordingly.
+
 Memory bandwidth Allocation and monitoring
 ==========================================
 
-- 
2.43.0


