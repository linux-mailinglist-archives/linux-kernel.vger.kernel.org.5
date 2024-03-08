Return-Path: <linux-kernel+bounces-97610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC83876C75
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A37F1F21F98
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1663B5FB89;
	Fri,  8 Mar 2024 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="av+k5kvs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04935367
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709933939; cv=none; b=m9t4A2+E2ebafnarYsBKy6uxBGTBSXBDNoJekpIpnZaWUOvvOqPPzEmMuWgKdOXv/4CxOnMk/xWro0VPEuHOZRYH68YEA2/zWKKqPUcqNFJMIhPXRLmMNVRCxJoDqJdUh6Rym0nb6V9t+P8SKDLAyfnvtO5pppEwcmEVtkWXf44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709933939; c=relaxed/simple;
	bh=kxNK4cnw8Vs8KnalpAtNlUYJdvIRzgnBC990Rf7n8HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8IGOuDlh9RXt6Hc7b7yIBxJqQmY6ZGLGUX+qFKwpNxi7Pw4jF+W+xvcrStra1Fa+E9h3+bq+TJ/vdto8SogWZ3d3u4oWrRoMdP5Oy6YRe2FNeG9O3G5AioaXYcJ4Ijby17PoiKkr9U+iAxHYqm6NG6nDgU9p1aEnQF7FB42XGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=av+k5kvs; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709933938; x=1741469938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kxNK4cnw8Vs8KnalpAtNlUYJdvIRzgnBC990Rf7n8HM=;
  b=av+k5kvs+cA1aCChvat3PWDem+S7t0K5QhkqF2q3uLq7c2ZY6PywS+TI
   drPOC/VfWtvILWexenneMqMrcI9Ia821LltcvmUZyAUIw5ysrhp2zyvSx
   V/MnybCLHQxeBioUbt9HbOwNWUBKO6b6GF/l/IR7FyfGgcOxPQbDESjkH
   wtbLsu4YBjcLfkpSwwY1K5p07Xj7lwRnuplNWrf6oZGx5+IDu/CZuuOSS
   8d+XijJZ68cL69IvXewnkKJu7v6zSh6D+AJRgAtqKkCc2vis1DE2MYKaS
   fES5rbpy6Wfs7c0yH5Bh2Tt38RBW70N1jG7UqLFd8TbnkU2gLc+Q41ygO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="4811384"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4811384"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 13:38:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="15295078"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 13:38:56 -0800
From: Tony Luck <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 0/2] x86/resctrl: Pass domain to target CPU
Date: Fri,  8 Mar 2024 13:38:44 -0800
Message-ID: <20240308213846.77075-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZdZPht8hY4J9uIOz@agluck-desk3>
References: <ZdZPht8hY4J9uIOz@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reset_all_ctrls() and resctrl_arch_update_domains() use on_each_cpu_mask()
to call rdt_ctrl_update() on potentially one CPU from each domain.

But this means rdt_ctrl_update() needs to figure out which domain to
apply changes to. Doing so requires a search of all domains in a resource,
which can only be done safely if cpus_lock is held. Both callers do hold
this lock, but there isn't a way for a function called on another CPU
via IPI to verify this.

Commit c0d848fcb09d ("x86/resctrl: Remove lockdep annotation that triggers
false positive") removed the incorrect assertions.

Add the target domain to the msr_param structure and
call rdt_ctrl_update() for each domain separately using
smp_call_function_single(). This means that rdt_ctrl_update() doesn't
need to search for the domain and get_domain_from_cpu() can safely assert
that the cpus_lock is held since the remaining callers do not use IPI.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---
Changes since V4: Link: https://lore.kernel.org/all/20240228193717.8170-1-tony.luck@intel.com/

Reinette: Only assign "cpu" once in resctrl_arch_update_domains() [but
see change from James below]

James: Use smp_call_function_any() instead of cpumask_any() +
smp_call_function_single() to avoid unnecessary IPI in both
resctrl_arch_update_domains() and reset_all_ctrls(). This
eliminates a need for the "cpu" local variable.

Tony Luck (2):
  x86/resctrl: Pass domain to target CPU
  x86/resctrl: Simplify call convention for MSR update functions

 arch/x86/kernel/cpu/resctrl/internal.h    |  5 ++-
 arch/x86/kernel/cpu/resctrl/core.c        | 55 +++++++++--------------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 40 ++++-------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 12 +----
 4 files changed, 34 insertions(+), 78 deletions(-)


base-commit: c0d848fcb09d80a5f48b99f85e448185125ef59f
-- 
2.43.0


