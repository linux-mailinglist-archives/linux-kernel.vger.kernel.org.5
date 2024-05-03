Return-Path: <linux-kernel+bounces-168192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E82948BB4EB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175E61C231EC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B936B65194;
	Fri,  3 May 2024 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjJP8naR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D3D250F8
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768425; cv=none; b=stlJs37wUJjIfQuhRhtB00QLCQoXwV8d4hBOVQeMbIPeiizYxD3+5kSybZ9HAD4YyuAbNZBJhPQXbmxTIsONXComN1vOaPyoTopCljix4jZp4AJcZS+rYUm63ZA48D68EbBLxJM1FkueiFNEZoejl9fLSMQkP/GW8DybVvPBuRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768425; c=relaxed/simple;
	bh=qTA6gl03vEuZNwR+0yktOI8EhYVtmjYM4Gw1yRj+4sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJYqIgPFb08NZ0DP3GGK31Q+OyTdUOs7VmaMZwzIc4NDF1QIRGg+pQFMTSLwU8yrX4zLnRUDlMWqjEqhdquT0h/BNg/+c//Orh+j1xbWB+EZfPw/9K+YLy9y5XXQC8XLer/8vM21w7MHw4VHECaepVdRccimXkV5OwnIx2Ct/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjJP8naR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714768423; x=1746304423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qTA6gl03vEuZNwR+0yktOI8EhYVtmjYM4Gw1yRj+4sA=;
  b=MjJP8naRUFD8MpRtHOCAgbsg4pxZ9kLNWhdwOKVh5z53KK5K/ukUGM2A
   uwXmV2JSzIOpsdv3LTR+RxIIi1z/JPiIUps27N5/hWYRANwFQgi1b2raV
   GYqpXnARN5ic/Go4KjWJdpnVh3y2B26WetBNbU2xZ/S4vMm60PQ6IFGK6
   6qEqjQeeWWV+gYsxwHRBbUZzPog05rxo3/c4B5TnoasqOlURqGinS43PV
   Xj+nB8YPYYtBsRhIX3IzVy4J+Xa98gA4bKlgQj7OjVf3utdcnuQf0VEOY
   FuP3Ul3L+DwwqI9VOQFfvRgG897D0ZbjF6ZXqSASljBNLqrLUd6IWl93p
   Q==;
X-CSE-ConnectionGUID: o3iY6SQxSDGrESEQaI/igw==
X-CSE-MsgGUID: Z4hRwXvWTsKqS8lj9/fB5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="21274322"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="21274322"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 13:33:37 -0700
X-CSE-ConnectionGUID: B5kHTAt1QDuB6t/29nEybg==
X-CSE-MsgGUID: Ksg6DLVySU253L98uN1/Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27431835"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 13:33:36 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v17 9/9] x86/resctrl: Update documentation with Sub-NUMA cluster changes
Date: Fri,  3 May 2024 13:33:25 -0700
Message-ID: <20240503203325.21512-10-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503203325.21512-1-tony.luck@intel.com>
References: <20240503203325.21512-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*** This patch needs updating for new files for monitoring ***

With Sub-NUMA Cluster mode enabled the scope of monitoring resources is
per-NODE instead of per-L3 cache. Suffixes of directories with "L3" in
their name refer to Sub-NUMA nodes instead of L3 cache ids.

Users should be aware that SNC mode also affects the amount of L3 cache
available for allocation within each SNC node.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/arch/x86/resctrl.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 627e23869bca..401f6bfb4a3c 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -375,6 +375,10 @@ When monitoring is enabled all MON groups will also contain:
 	all tasks in the group. In CTRL_MON groups these files provide
 	the sum for all tasks in the CTRL_MON group and all tasks in
 	MON groups. Please see example section for more details on usage.
+	On systems with Sub-NUMA (SNC) cluster enabled there are extra
+	directories for each node (located within the "mon_L3_XX" directory
+	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
+	where "YY" is the node number.
 
 "mon_hw_id":
 	Available only with debug option. The identifier used by hardware
@@ -484,6 +488,19 @@ if non-contiguous 1s value is supported. On a system with a 20-bit mask
 each bit represents 5% of the capacity of the cache. You could partition
 the cache into four equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
 
+Notes on Sub-NUMA Cluster mode
+==============================
+When SNC mode is enabled, Linux may load balance tasks between Sub-NUMA
+nodes much more readily than between regular NUMA nodes since the CPUs
+on Sub-NUMA nodes share the same L3 cache and the system may report
+the NUMA distance between Sub-NUMA nodes with a lower value than used
+for regular NUMA nodes.
+The top-level monitoring files in each "mon_L3_XX" directory provide
+the sum of data across all SNC nodes sharing an L3 cache instance.
+Users who bind tasks to the CPUs of a specific Sub-NUMA node can read
+the "llc_occupancy", "mbm_total_bytes", and "mbm_local_bytes" in the
+"mon_sub_L3_YY" directories to get node local data.
+
 Memory bandwidth Allocation and monitoring
 ==========================================
 
-- 
2.44.0


