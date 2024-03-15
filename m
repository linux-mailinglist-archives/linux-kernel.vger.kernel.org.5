Return-Path: <linux-kernel+bounces-104360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DDA87CC98
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E96E282E69
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF9E1BC2C;
	Fri, 15 Mar 2024 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VnkNyYeS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384518E02
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502802; cv=none; b=QG1Jb5vzc+TG6394GhhxV6ZhvEaEZTYHHrowWxY41q7vsoq6gPZp3aMGpmKBTV1ZwLLNn9J+Y5DafFVA/4+oG3PwM1noAI6lwQiCeAOzPYW/7NtoJpzW9OPHDEW2mF5OTbfgsHeZdVJPsy5wZSZ2ps5lBZldcSbtmfwC41bVQbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502802; c=relaxed/simple;
	bh=wkNXFHOmMSUpzPN8vyUJJ1bQa4AdHQML5T2k87ME4qQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hPxpmmugYDOG5Ij/jh6eN4DlztBUTT77QFOu3h4UkewM354TYeZf6gfxKCb6xpBrvjBfDfEEHsRZyYMPvkdvvgDueM0XGcrLjHYYev0MoXDZOQ/XLEYRQdjcsxD0OKDez8wjWRuBjDSRwbMJD/hDpIm0QViwQRqUdZJ3Hy9XnpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VnkNyYeS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710502800; x=1742038800;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wkNXFHOmMSUpzPN8vyUJJ1bQa4AdHQML5T2k87ME4qQ=;
  b=VnkNyYeSA8PqYyxKliD5IS5K3Fw7hlEINdZV7sEJRwOXTQxQKrbfUhLX
   rTAkUCuK8U037Zcj5gPAifRuTa/Jjm2Eyeo7E1B/P6XCxbZt02OO4NrXz
   V4crvsi9f0jdDZdIZfuLQiDI743sVJ8DXNKzoi3JFts19WQkLv/TIxc7t
   YLhzfYkDG29cX5TKM12cIwaj3+M0Ejscjkw9C6WLHLaIq8yAA3tuKs0Jy
   kjm0SH+PtxPrlim1SELmbduhwqX17W4q7R7BM4I/vokndNvhozI4OJrqx
   goFbCMV9a4pPGu9tDWqVvVcbjUWvhSJsc/9EZWv6n/OMOrpY4iBFLe7pU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5223024"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5223024"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 04:39:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="17240311"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by fmviesa004.fm.intel.com with ESMTP; 15 Mar 2024 04:39:56 -0700
From: Feng Tang <feng.tang@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	x86@kernel.org,
	paulmck@kernel.org,
	rui.zhang@intel.com,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] x86/tsc: Use topology_max_packages() to get package number
Date: Fri, 15 Mar 2024 19:26:06 +0800
Message-Id: <20240315112606.2248284-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
on qualified platorms") was introduced to solve problem that
sometimes TSC clocksource is wrongly judged as unstable by watchdog
like 'jiffies', HPET, etc.

In it, the hardware package number is a key factor for judging whether
to disable the watchdog for TSC, and 'nr_online_nodes' was chosen as
an estimation due to it is needed in early boot phase before
registering 'tsc-early' clocksource, where all none-boot CPUs are not
brought up yet.

Dave and Rui pointed out there are many cases in which 'nr_online_nodes'
is not accurate, like:

* numa emulation (numa=fake=8 etc.)
* numa=off
* platforms with CPU-less HBM nodes, CPU-less Optane memory nodes.
* SNC (sub-numa cluster) mode enabled
* 'nr_cpus=', 'possible_cpus=' 'maxcpus=' kernel cmdline parameter setup

Thomas' recent patchset of refactoring x86 topology code introduces
topology_max_package(), which works well in most of the above cases.
The only exceptions are 'nr_cpus=' and 'possible_cpus=' setup, which
sets up the 'nr_cpu_ids' and rejects the rest of the CPUs, and may
cause topology_max_package() less than the real package number, but
it's fine as it is rarely used debug option, and logical package
number really matters in this check. So use the more accurate
topology_max_package() to replace nr_online_nodes().

Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
Closes: https://lore.kernel.org/lkml/a4860054-0f16-6513-f121-501048431086@intel.com/
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/x86/kernel/tsc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 5a69a49acc96..87e7c0e89db1 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1252,15 +1252,12 @@ static void __init check_system_tsc_reliable(void)
 	 *  - TSC which does not stop in C-States
 	 *  - the TSC_ADJUST register which allows to detect even minimal
 	 *    modifications
-	 *  - not more than two sockets. As the number of sockets cannot be
-	 *    evaluated at the early boot stage where this has to be
-	 *    invoked, check the number of online memory nodes as a
-	 *    fallback solution which is an reasonable estimate.
+	 *  - not more than four sockets.
 	 */
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
 	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
-	    nr_online_nodes <= 4)
+	    topology_max_packages() <= 4)
 		tsc_disable_clocksource_watchdog();
 }
 
-- 
2.34.1


