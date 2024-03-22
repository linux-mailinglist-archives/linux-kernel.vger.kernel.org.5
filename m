Return-Path: <linux-kernel+bounces-111931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A428872EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686A31C21753
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1A463510;
	Fri, 22 Mar 2024 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Stp1eWWK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D3D634FD;
	Fri, 22 Mar 2024 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711131624; cv=none; b=R+z8hzBhrKCaed7LyHuzgyjmQ9F0mcfcho0EkIEhevjkqDDVrh0z3sycc/QTso5ed5udQEItIRp8SADKX+LHWuTx684iCvgjhJqWXPg3mYich3yODVVJLAxBPtqLbwI9YM6BbjdPzJ2giE4mk3D4xTD6jvOhTIDQyGnZHR+1OBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711131624; c=relaxed/simple;
	bh=zaoJUGsUnomu4sLnNHkQa13VzSoMT7EmbpbB5GpjhMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VOE3e4rDGUKagyq4xKfL2B59Tkalj94QLn7lRRM7M/6/+onPyxCGPorVRxGAUJN6rccREXil12VVFdX1s0XsC2bkqjdk2SuLj1rnnPRe3vtg8JuT60q0kz/mmc7cxMjrZanrKZQQzQZyiXzdi04DK8D7fNVTXEMeIG704Zq2j2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Stp1eWWK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711131624; x=1742667624;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zaoJUGsUnomu4sLnNHkQa13VzSoMT7EmbpbB5GpjhMQ=;
  b=Stp1eWWKfOt1xwGEOFO2ueATFQgh7J6mBLdnODxxlRKpdiQVZ9+isOkQ
   +7RlBn7Mb0+wZAvfYniuTVIHfgXxXwL0mR0nKBThzwPpnEeMGli8ykN7a
   cWm1AJCZdsutHXziiVQHi2LSWYeJBINXJv+lpxMe+ai5pa02UVLC5VMPj
   8jfNRl53GBrPcEYCsN1dmsUye8nd4XJ53RW2jD6H1LlTkSXg0+1mZQk70
   V5MjzJENloN9veDnxkMV3PWLSf3W5FMKnnV+Xmx8O/utNoz9VhVUL7TwC
   oNmTKwQskzBcN6tOaGN5unXKuK/OWb3exXKT8ZNwGY1AQeOy99QsHHT9h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="17339800"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="17339800"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 11:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="15000969"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 11:20:22 -0700
From: Tony Luck <tony.luck@intel.com>
To: linux-doc@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH] Documentation/x86: Document resctrl bandwidth control units are MiB
Date: Fri, 22 Mar 2024 11:20:15 -0700
Message-ID: <20240322182016.196544-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory bandwidth software controller uses 2^20 units rather than
10^6. See mbm_bw_count() which computes bandwidth using the "SZ_1M"
Linux define for 0x00100000.

Update the documentation to use MiB when describing this feature.
It's too late to fix the mount option "mba_MBps" as that is now an
established user interface.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/arch/x86/resctrl.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index a6279df64a9d..3712d81cb50c 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -45,7 +45,7 @@ mount options are:
 	Enable code/data prioritization in L2 cache allocations.
 "mba_MBps":
 	Enable the MBA Software Controller(mba_sc) to specify MBA
-	bandwidth in MBps
+	bandwidth in MiBps
 "debug":
 	Make debug files accessible. Available debug files are annotated with
 	"Available only with debug option".
@@ -526,7 +526,7 @@ threads start using more cores in an rdtgroup, the actual bandwidth may
 increase or vary although user specified bandwidth percentage is same.
 
 In order to mitigate this and make the interface more user friendly,
-resctrl added support for specifying the bandwidth in MBps as well.  The
+resctrl added support for specifying the bandwidth in MiBps as well.  The
 kernel underneath would use a software feedback mechanism or a "Software
 Controller(mba_sc)" which reads the actual bandwidth using MBM counters
 and adjust the memory bandwidth percentages to ensure::
@@ -573,13 +573,13 @@ Memory b/w domain is L3 cache.
 
 	MB:<cache_id0>=bandwidth0;<cache_id1>=bandwidth1;...
 
-Memory bandwidth Allocation specified in MBps
+Memory bandwidth Allocation specified in MiBps
 ---------------------------------------------
 
 Memory bandwidth domain is L3 cache.
 ::
 
-	MB:<cache_id0>=bw_MBps0;<cache_id1>=bw_MBps1;...
+	MB:<cache_id0>=bw_MiBps0;<cache_id1>=bw_MiBps1;...
 
 Slow Memory Bandwidth Allocation (SMBA)
 ---------------------------------------
-- 
2.44.0


