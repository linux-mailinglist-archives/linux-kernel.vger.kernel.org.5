Return-Path: <linux-kernel+bounces-85616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E6D86B852
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293961F24E75
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280B415F330;
	Wed, 28 Feb 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxvFWK4X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91515D5CC;
	Wed, 28 Feb 2024 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149042; cv=none; b=keJwmy7OTjeVZsAtj71ag6s/BBSiNPRc9JCLy/RK6kaX7XLXb6G24B8yLYkpIjf2h0mxIJi0L5g1FHoGdR0ZxQxgUBpGg4ELgSudu66FsoCMX+Ik+G1++G3NY4hCFMajf09/0O+6pUaZwyzZ8+38Rsr1FqzOHFjo57iE581RilQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149042; c=relaxed/simple;
	bh=CCNsGpyPB60rmAZbLn5fA0IiWeGHXWTCmie41OkzAKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDJvtVcgWOBMZln3ISzzN0rW85gPQdqUAyHGQRiFaC9GlEkEz2w6qMI76G4Alpl33PoVmlmkwu2dXnc7KIsoO/VPBEMIUPXORGdKjhqcZQmnfhhn/WInujTxk0u+CvC0c/OYNrLiTJ5JwpaGIEM+ImxKZklGE3pnfa2SUnR10kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxvFWK4X; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709149041; x=1740685041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CCNsGpyPB60rmAZbLn5fA0IiWeGHXWTCmie41OkzAKU=;
  b=UxvFWK4XgBNMIVpYWTOol1rSTFFROCcXE1zCU2EL228ja6QoEEJvBTfT
   hVAeih+3LbaUtBC2VcyqPP9AZhx19VDcLZau7h5Xs7gVJcHtihSwQccVx
   eHdzYSoFjbKRDdUbnyJ/6H+Qt/1F+Hu2K2LVg7x0Hrw/BR+qGTzk/Txnu
   bkuJ6nOugzzP0+QvSMV5YHuRjDyy4LMtNtLkZIX1N/7QvgjKjN9tve6TT
   5smW1dYipBPsyYQrULUkU+2y6IAK8e09S4NfdneCSYpDIeo4svKrJ+GyK
   c5TZ2xPbhsfePl41c3QHg8b+9cOozUaaya4OKAH7ZH3DmR3Cp5JfLpHdk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3495491"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3495491"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:37:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7485376"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:37:18 -0800
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
Subject: [PATCH v15 0/8] Add support for Sub-NUMA cluster (SNC) systems
Date: Wed, 28 Feb 2024 11:36:55 -0800
Message-ID: <20240228112935.8087-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228112215.8044-tony.luck@intel.com>
References: <20240228112215.8044-tony.luck@intel.com>
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
Changes since v14: https://lore.kernel.org/all/20240126223837.21835-1-tony.luck@intel.com/

1) Rebase to TIP x86/cache + my 2-patch cleanup

2) Dropped all Reviewed/Tested tags (enough changed in TIP that this
needs looking at, and testing, again).

3) Added ATOM_CRESTMONT_X (Sierra Forest) to list of SNC supporting CPUs.

4) Added a console "INFO" message when SNC detected:
	pr_info("Sub-NUMA cluster detected with %d nodes per L3 cache\n", ret);

Note that my alternate approach posted as v15-RFC
https://lore.kernel.org/all/20240130222034.37181-1-tony.luck@intel.com/
has been abandoned. I'd still like to explore splitting the L3
rdt_resource into separate control/monitor elements, but that
can wait for another series of patches.

Tony Luck (8):
  x86/resctrl: Prepare for new domain scope
  x86/resctrl: Prepare to split rdt_domain structure
  x86/resctrl: Prepare for different scope for control/monitor
    operations
  x86/resctrl: Split the rdt_domain and rdt_hw_domain structures
  x86/resctrl: Add node-scope to the options for feature scope
  x86/resctrl: Introduce snc_nodes_per_l3_cache
  x86/resctrl: Sub NUMA Cluster detection and enable
  x86/resctrl: Update documentation with Sub-NUMA cluster changes

 Documentation/arch/x86/resctrl.rst        |  25 +-
 include/linux/resctrl.h                   |  85 +++--
 arch/x86/include/asm/msr-index.h          |   1 +
 arch/x86/kernel/cpu/resctrl/internal.h    |  67 ++--
 arch/x86/kernel/cpu/resctrl/core.c        | 428 ++++++++++++++++++----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  56 +--
 arch/x86/kernel/cpu/resctrl/monitor.c     |  70 ++--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  26 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 156 ++++----
 9 files changed, 642 insertions(+), 272 deletions(-)

-- 
2.43.0


