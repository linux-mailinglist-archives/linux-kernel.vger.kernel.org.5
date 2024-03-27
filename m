Return-Path: <linux-kernel+bounces-120251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A677D88D4DE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360D21F31640
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B180021A04;
	Wed, 27 Mar 2024 03:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K13lhMkH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D23C3DAC10
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711508698; cv=none; b=a58hPUkT+mJxuTn1cHWFNlswvIpbBPzs/gHTeVYMLuv2IwZOYQ1ZtKEe/9vh+bCqaKsa388LEIse8skzAhZo5EmS2239Ze9xMqE22Z4Z4Ie0xw/Ic/xG6uw5fnpAbCaliU8qO18zd+NXo525SzySEAhVDXF53S2xT0D2TMb09jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711508698; c=relaxed/simple;
	bh=kR8fUxWXM+3ENmSr00PtrCkEV5zpvYvRMSKTX82LZjM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IkTCiLlRdBZfwKun1EaLpZVX7hU1bALpdYCW80aBA2nzYcmK7nUOG7nSCo1STWyLfGqSoIqyl0cZaitCol92Xe7D0M5W9P91OSOSR73iEO/f2bHyNyTWfjDbNTruDnzg2hnbPqCJWruFwfoveb+PJndNNY0Crw+q2v+VM7kvi3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K13lhMkH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711508697; x=1743044697;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kR8fUxWXM+3ENmSr00PtrCkEV5zpvYvRMSKTX82LZjM=;
  b=K13lhMkHqghrKgNytf3JX8wv8Xa84gMZHnzn/4oLne5P2QAJwH0Ge1yt
   GPM2WIap2+7uX2zQzUJs2yBsW+7jEWAB4xpofkBnCLQeaJLKjYPi1kWOj
   ISs9YaYe5eUFsFPIsWlKpAlzIB70kYpnNDh1wMw0ChdfRVzjEDsIY4k0F
   96MAk/4JpBWpAEIQUwUroHdmMk4C0NMDCtjJlVsossu68C4i7Qd3Trojz
   1pcRsl0k1WATD8VTVlN/ZKl4RaOKx6+BPvc6tfdQW7zV7INcXNjNQ9ysk
   PJhq9Kzu4Fs0I/qjFlq5D63aUnfUSEsoWxYhgVvctjPeEwczwDnujDO0t
   Q==;
X-CSE-ConnectionGUID: p61hJh50RNe2f6Cq6M8HFA==
X-CSE-MsgGUID: dpacHrKbQWGary+/XeqwKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6485185"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="6485185"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 20:04:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="20707443"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by fmviesa003.fm.intel.com with ESMTP; 26 Mar 2024 20:04:51 -0700
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
Subject: [PATCH v3] x86/tsc: Use topology_max_packages() to get package number
Date: Wed, 27 Mar 2024 10:51:05 +0800
Message-Id: <20240327025105.2861341-1-feng.tang@intel.com>
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
to disable the watchdog for TSC, and 'nr_online_nodes' was chosen due
to it is available in early boot phase before registering 'tsc-early'
clocksource, where all non-boot CPUs are not brought up yet.

Dave and Rui pointed out there are many cases in which 'nr_online_nodes'
is cheated and not accurate, like:

* numa emulation (numa=fake=8 etc.)
* numa=off
* platforms with CPU-less HBM nodes, CPU-less Optane memory nodes.
* SNC (sub-numa cluster) mode enabled
* 'maxcpus=' cmdline setup, where chopped CPUs could be onlined later
* 'nr_cpus=', 'possible_cpus=' cmdline setup, where chopped CPUs can
  not be onlined after boot

Thomas' recent patchset of refactoring x86 topology code improves
topology_max_packages(), by making it more accurate and available in
early boot phase, which works well in most of the above cases.

The only exceptions are 'nr_cpus=' and 'possible_cpus=' setup.  And
the reason is, during topology setup, the boot CPU iterates through
all enumerated APIC ids and either accepts or rejects the APIC id.
For accepted ids, it figures out which bits of the id map to the
package number.  It tracks which package numbers have been seen in a
bitmap.  topology_max_packages() just returns the number of bits set
in that bitmap.

'nr_cpus=' and 'possible_cpus=' can cause more APIC ids to be rejected
and can artificially lower the number of bits in the package bitmap
and thus topology_max_packages().  This means that, for example, a
system with 8 physical packages might reject all the CPUs on 6 of those
packages and be left with only 2 packages and 2 bits set in the package
bitmap. It needs the TSC watchdog, but would disable it anyway.  This
isn't ideal, but this only happens for debug-oriented options. This is
fixable by tracking the package numbers for rejected CPUs.  But it's
not worth the trouble for debugging.

So use topology_max_packages() to replace nr_online_nodes().

Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
Closes: https://lore.kernel.org/lkml/a4860054-0f16-6513-f121-501048431086@intel.com/
Signed-off-by: Feng Tang <feng.tang@intel.com>
---

Hi all,

For warning about possible compromise due to 'nr_cpus=' and 'possible_cpus=',
one alternative is to check whether these has been setup in cmdline inside
tsc.c and warn there.

Changelog:

  Since v2:
  * Use 'pr_info' to replace 'pr_warn' which could panic system
    if 'panic_on_warn=1' kcmdline parameter is on (Waiman)

  Since v1:
  * Use Dave's detailed elaboration about 'nr_cpus=', 'possible_cpus='
    possibly compromising '__max_logical_packages' in commit log
  * Fix typos and inaccuracy (Rui and Longman)


 arch/x86/kernel/cpu/topology.c | 5 ++++-
 arch/x86/kernel/tsc.c          | 7 ++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 3259b1d4fefe..9db66597388e 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -460,8 +460,11 @@ void __init topology_init_possible_cpus(void)
 	pr_info("Num. threads per package: %3u\n", __num_threads_per_package);
 
 	pr_info("Allowing %u present CPUs plus %u hotplug CPUs\n", assigned, disabled);
-	if (topo_info.nr_rejected_cpus)
+	if (topo_info.nr_rejected_cpus) {
 		pr_info("Rejected CPUs %u\n", topo_info.nr_rejected_cpus);
+		if (__max_logical_packages <= 4)
+			pr_info("TSC might be buggered due to the rejected CPUs\n");
+	}
 
 	init_cpu_present(cpumask_of(0));
 	init_cpu_possible(cpumask_of(0));
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 5a69a49acc96..d00f88f16eb1 100644
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
+	 *  - not more than four packages
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


