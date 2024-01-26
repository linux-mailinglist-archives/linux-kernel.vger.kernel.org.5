Return-Path: <linux-kernel+bounces-40785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8C883E5AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB5CB25904
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1879A4F8AF;
	Fri, 26 Jan 2024 22:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Va6kkDTa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9E2C6A0;
	Fri, 26 Jan 2024 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308730; cv=none; b=OsGy/km+b8B80MjqRWbz9/I1bJUughvRqZ4s2N39GyMNY6OPSkWsZS9MzBy7jhEB9hCx/cr82UwqxRDK1G1+oPv1aazNR1rYqVJkpGfJ0gQ5dAi2OEANGZFIi7vQTJW2hFkodgLvbJwBYczYY+2PNQN4tupxwuT5REfpphF/iqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308730; c=relaxed/simple;
	bh=Hp6f/GZsgmHvqRxAvmLEAtm19UpuDpvz8X+HdHnCBV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoRicdQH+N4bXI9byzocHEb3uHe30XvmUjy74June7vMkC9t1qI6+aDiOFoBQmyHW4Zpd8xXC6SPSabzzSHdU/yXJE120vHbHrgFZSYUU2JePu8EdXahd3P68Iqbancrs+B0b10irQDvuEo+qIbv4Exsy0U+2f4Hw9Kp55cNcBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Va6kkDTa; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706308727; x=1737844727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hp6f/GZsgmHvqRxAvmLEAtm19UpuDpvz8X+HdHnCBV0=;
  b=Va6kkDTalY/i4I3PAXqGbNhqyITuo3ywhwzH9EIzlLDLhC9rEg857OET
   zzzQGp/5D+Xch6ZNSRpydOzF+keQxLVr0t7MDaVCPl17VK5r1ELWooDfS
   +GJQZlfNYnT/9bVdL7iuNqdHbXFTUSsCAhVnikiBYgO0aNtsixK+UDGhr
   04KdPRgELq17PEr8UiPW+f9X+MiVfbwdFGgoF+RjX4if+TFsk7wa1K09U
   +ZZjfAmAv3UcuEbvRoeXDH12NX4yFiTORC1EZ3Ajv9oaCaLHFDzxo8Jp7
   dHA3eXQkuHz5htFIxWOH6Ni4FdjO5aeOBRo9ALdsxPUsApaWO5ZvsG6Av
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9707634"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9707634"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 14:38:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35560245"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 14:38:46 -0800
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v14 0/8] Add support for Sub-NUMA cluster (SNC) systems
Date: Fri, 26 Jan 2024 14:38:29 -0800
Message-ID: <20240126223837.21835-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204185357.120501-1-tony.luck@intel.com>
References: <20231204185357.120501-1-tony.luck@intel.com>
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
Changes since v13:

Rebase to tip x86/cache
	fc747eebef73 ("x86/resctrl: Remove redundant variable in mbm_config_write_domain()")

Applied all Reviewed and Tested tags

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
 arch/x86/kernel/cpu/resctrl/internal.h    |  66 ++--
 arch/x86/kernel/cpu/resctrl/core.c        | 433 +++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  58 +--
 arch/x86/kernel/cpu/resctrl/monitor.c     |  68 ++--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  26 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 149 ++++----
 9 files changed, 629 insertions(+), 282 deletions(-)


base-commit: fc747eebef734563cf68a512f57937c8f231834a
-- 
2.43.0


