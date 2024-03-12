Return-Path: <linux-kernel+bounces-100819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61283879D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171E71F21441
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2EA143C57;
	Tue, 12 Mar 2024 21:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4k4VM02"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340F8143747;
	Tue, 12 Mar 2024 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279777; cv=none; b=t2ISqHJBePu3oqG9tFJKBinfe3uEQjzf4ut0NS0MUxEqcjvyS9rTDAHxTBquNifjDktP3Et5Ex6os7E54lmXRSGGSUnRCEBgMMxVNZJL89BEktObyR635+AUnMk/XJSdGWg6LxL/bd+0ox1MxdKKqdkIIr9DjOrMSyLe2hqBbQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279777; c=relaxed/simple;
	bh=rgmxi5u6+E3/+xxSprJzTUYVwc4SV24nXmvybdtGqRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJK88V79UfjanTxsts9Kbfjb9SqpvPMvi8/9MvLP2GhocU+Y6Ar0tDG1Kgz0WchaTTzeiTpJXqWqv4Bp3ixA5HHdGiuuO0GgQh9w97tlVtiqkj9fQaUqiLklHy65rER+1a/TD1t7OBmfhg+wK8sEWUz3lB+F6ksKDsixgWqGVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4k4VM02; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710279775; x=1741815775;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rgmxi5u6+E3/+xxSprJzTUYVwc4SV24nXmvybdtGqRU=;
  b=b4k4VM0204tRScdypyq2Xw6DR9vB45QICe+nfRLuSUJctgbZ2KFSy/JR
   nioy2DYxZKZrLs8HrhWEy2zb79kKreCmZQt9SoUJ6mw8Dvo9AUbRcXLZg
   pSYhhvfHjoJz3Wsw/Zd8dAl7PWRyVAl0txkQ0Te2WuSKc4dtHFypO5FPT
   p1sEZ+Kq6iH3g5a3qHnlaTlU+/XtL0nQ2eR+NKQU9Jt3TgcwGNlZnAmZ0
   XObd91p3f3WdZf7YpgrDirAXUMZPyjii3tPARMeiyHK18mpHJN0hrVX9Y
   9ERLMIyuyMCmCxQMz2DpdhIkwOfZcnKcQcquvW//XcfRygU9LjCk9OdUj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4884767"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4884767"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:42:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12280133"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:42:53 -0700
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
Subject: [PATCH v16 0/9] Add support for Sub-NUMA cluster (SNC) systems
Date: Tue, 12 Mar 2024 14:42:38 -0700
Message-ID: <20240312214247.91772-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Tony Luck <tony.luck@intel.com>

---
Changes since v15: Link: https://lore.kernel.org/all/20240228112935.8087-tony.luck@intel.com/

0) Note that v14 Reviewed/Testing tags have been removed because of the
   extent of refactoring to catch up with upstream. But nothing
   fundamental changed, so everything should look familiar.

1) Refactor to apply on top of Link: https://lore.kernel.org/all/20240308213846.77075-1-tony.luck@intel.com/
   [So base commit is either tip x86/cache, or upstream current merge PLUS
    the two patches in that series]

2) Add patch 9 which adds files showing mappings from domains to CPUs
   Reinette suggested this, James thinks it duplicates information
   that can be gathered from /sys/devices/system/
   Discussion here: Link: https://lore.kernel.org/all/ZetcM9GO2PH6SC0j@agluck-desk3/
   This part is a nice-to-have. I'm fine if just the first eight patches
   are applied without this while the discussion continues.

Tony Luck (9):
  x86/resctrl: Prepare for new domain scope
  x86/resctrl: Prepare to split rdt_domain structure
  x86/resctrl: Prepare for different scope for control/monitor
    operations
  x86/resctrl: Split the rdt_domain and rdt_hw_domain structures
  x86/resctrl: Add node-scope to the options for feature scope
  x86/resctrl: Introduce snc_nodes_per_l3_cache
  x86/resctrl: Sub NUMA Cluster detection and enable
  x86/resctrl: Update documentation with Sub-NUMA cluster changes
  x86/resctrl: Add info files to show mappings from domains to lists of
    cpus

 Documentation/arch/x86/resctrl.rst        |  44 ++-
 include/linux/resctrl.h                   |  85 +++--
 arch/x86/include/asm/msr-index.h          |   1 +
 arch/x86/kernel/cpu/resctrl/internal.h    |  67 ++--
 arch/x86/kernel/cpu/resctrl/core.c        | 428 ++++++++++++++++++----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  56 +--
 arch/x86/kernel/cpu/resctrl/monitor.c     |  70 ++--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  26 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 213 +++++++----
 9 files changed, 718 insertions(+), 272 deletions(-)

-- 
2.44.0


