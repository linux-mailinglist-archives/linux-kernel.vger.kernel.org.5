Return-Path: <linux-kernel+bounces-121950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E971A88EFCF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899A9B2753E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EB81534FB;
	Wed, 27 Mar 2024 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6L4lj6h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E383E152165
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569845; cv=none; b=bUKgx84vwtK1m+aoz4S4Lt7bXz4apoU4NuvEezwESCo6jGDJI5BYudzA0W13LQ8z55Dpc7//TZ0vtSwx1PvVFwR3h1M9LO7D802JhZa8DEeHJLscddLIPZSXgNA/wVwe2+TxLeZeS2VEG96NY0JWmxG8XAwAYstiyovUBfRVAYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569845; c=relaxed/simple;
	bh=pBizMv20GnHsHVh+QUTcQ98Oq3o4gF4fbolEI/aBnQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b1otUuacvWgsYMKTpauoVC7cuC7Sql/Dtuq+T9kLDDgyuQ+8L78Sk0lwQYhjkfoCriFJgS9JWV3VYX6NYj9mvkbsgThZjK/2I3fPSng++SdIIfaEIPqk4vDUuOYV/18kPhqj+YepjWwtDzoUPZJgTPQlVOL8A/x/UVKNcTOWCBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6L4lj6h; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711569843; x=1743105843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pBizMv20GnHsHVh+QUTcQ98Oq3o4gF4fbolEI/aBnQI=;
  b=A6L4lj6hrCZnKrMT6ckeqEFppn1w0PcmsV2JlBThNOd0PTymJUSsLfun
   pyF63SNfXPwUtOxQ5EgTo+Md7YGqOttTCYdn7uHQLy+wyLr9LNcqabGsz
   /Rw2Tor1OPjgB96C1j3IuWDwGpX5GFxacDDMFpy9pfO/mpbpTfJFYb5Zp
   1z2iUnMQKQtwmgI/YPmWYO8NmIs/laulf+tEe9SVPJ8rNSglSDTpLxpbW
   QL+7yTJR1FyDOkmeixJ6CgjrB+LpwXanKqIXTIkt6lYczwLD99/AKj61I
   87ocwpe7OZ4kTdMNKXsy2VkMvVksXHz/rZnMzooAEus1ZBrrWz49n+tL1
   g==;
X-CSE-ConnectionGUID: 2HxSOf7+Q2uKfH9yjSuOQg==
X-CSE-MsgGUID: AS1yb8j4RKmwp1m1QctyGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="18132959"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="18132959"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 13:04:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16246094"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 13:04:01 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH 00/10] Add support for Sub-NUMA cluster (SNC) systems
Date: Wed, 27 Mar 2024 13:03:42 -0700
Message-ID: <20240327200352.236835-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series on top of v6.9-rc1 plus these two patches:

Link: https://lore.kernel.org/all/20240308213846.77075-1-tony.luck@intel.com/

The Sub-NUMA cluster feature on some Intel processors partitions the CPUs
that share an L3 cache into two or more sets. This plays havoc with the
Resource Director Technology (RDT) monitoring features.  Prior to this
patch Intel has advised that SNC and RDT are incompatible.

Some of these CPU support an MSR that can partition the RMID counters in
the same way. This allows monitoring features to be used. With the caveat
that users must be aware that Linux may migrate tasks more frequently
between SNC nodes than between "regular" NUMA nodes, so reading counters
from all SNC nodes may be needed to get a complete picture of activity
for tasks.

Cache and memory bandwidth allocation features continue to operate at
the scope of the L3 cache.

This is a new approach triggered by the discussions that started with
"How can users tell that SNC is enabled?" but then drifted into
whether users of the legacy interface would really get what they
expected when reading from monitor files in the mon_L3_* directories.

During that discussion I'd mentioned providing monitor values for both
the L3 level, and also for each SNC node. That would provide full ABI
compatibility while also giving the finer grained reporting from each
SNC node.

Implementation sets up a new rdt_resource to track monitor resources
with domains for each SNC node. This resource is only used when SNC
mode is detected.

On SNC systems there is a parent-child relationship between the
old L3 resource and the new SUBL3 resource. Reading from legacy
files like mon_data/mon_L3_00/llc_occupancy reads and sums the RMID
counters from all "child" domains in the SUBL3 resource. E.g. on
an SNC3 system:

$ grep . mon_L3_01/llc_occupancy mon_L3_01/*/llc_occupancy
mon_L3_01/llc_occupancy:413097984
mon_L3_01/mon_SUBL3_03/llc_occupancy:141484032
mon_L3_01/mon_SUBL3_04/llc_occupancy:135659520
mon_L3_01/mon_SUBL3_05/llc_occupancy:135954432

So the L3 occupancy shows the total L3 occupancy which is
the sum of the cache occupancy on each of the SNC nodes
that share that L3 cache instance.

Patch 0001 has been salvaged from the previous postings.
All the rest are new.

Signed-off-by: Tony Luck <tony.luck@intel.com>

Tony Luck (10):
  x86/resctrl: Prepare for new domain scope
  x86/resctrl: Add new rdt_resource for sub-node monitoring
  x86/resctrl: Add new "enabled" state for monitor resources
  x86/resctrl: Add pointer to enabled monitor resource
  x86/resctrl: Add parent/child information to rdt_resource and
    rdt_domain
  x86/resctrl: Update mkdir_mondata_subdir() for Sub-NUMA domains
  x86/resctrl: Update rmdir_mondata_subdir_allrdtgrp() for Sub-NUMA
    domains
  x86/resctrl: Mark L3 monitor files with summation flag.
  x86/resctrl: Update __mon_event_count() for Sub-NUMA domains
  x86/resctrl: Determine Sub-NUMA configuration

 include/linux/resctrl.h                   |  20 ++-
 arch/x86/include/asm/msr-index.h          |   1 +
 arch/x86/kernel/cpu/resctrl/internal.h    |  23 ++-
 arch/x86/kernel/cpu/resctrl/core.c        |  76 +++++++---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   3 +-
 arch/x86/kernel/cpu/resctrl/monitor.c     | 136 +++++++++++++++--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   6 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 170 +++++++++++++++++-----
 8 files changed, 364 insertions(+), 71 deletions(-)

-- 
2.44.0


