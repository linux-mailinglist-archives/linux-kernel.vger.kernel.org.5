Return-Path: <linux-kernel+bounces-46591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 277868441BF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A15B1C238B2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3B982883;
	Wed, 31 Jan 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TUQ5sMjx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F12C80BFC;
	Wed, 31 Jan 2024 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711031; cv=none; b=ur2DvJJYkz7FjAfQHNTNnZQcnHy2Wu7Yj9fwW4U07g4OpJh6qlvLePaBzl8VnRr3mb54/nAS9ORd5i3jGIvlwh8KsGIcTYiPbYopoWlm9SEsKilzFef3b7rQrhi0fIjun1niJtNPeppmF1TTYTXzmD0oX0AR49fU4vF0Br+vQvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711031; c=relaxed/simple;
	bh=ze9vWIEOghvdhXjX52j98Xc6K8ccnY1OjzwxcPEufSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CIK3PrXv28/VJZgDEiDoH6dzJ+gP3fytil/QA/rvXMCCaQXJrzkqvgGtYg6ZNKKUFQwbbBmK5vnqAjdC1p0PYrJ0lA9/SgeeR0Uel502Ep25URBrwRqsdkXV9/YX8LOBFtc8R9G4ppLhbqgwqMYxemlU1CbwKZz+/1aYw8se/So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TUQ5sMjx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706711029; x=1738247029;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ze9vWIEOghvdhXjX52j98Xc6K8ccnY1OjzwxcPEufSM=;
  b=TUQ5sMjxjAaCzlWZvtcDN0mlEw2B1vGg1u/A0h6aacSpadzE3RT0ojXZ
   A/DlMe1Ulq4l05Mu96B5Yhu57a2/fS8FheHJMVA+1Tu4Akzq9Yq31tVzt
   PYpQFTtHB9LpL8FInA9PadvdSw7f31MfuDvRMLSK/GiGumSVyZma8cb1j
   BTDpExxAP+L2xYWNl1Y6FDZpGH7Cx3VuZzUixwTnFCtYbB/VFUZTILGaY
   WIBX37ZumTgJ5GiC66ZTkwzg8Xd/hY/2jIA4dsWR8eY3vavLBgcJk55ef
   JL3I34Tt5KjTnsqp5pic/D/wkmx0+g3Wl8REnDMMbBVRZNnGmcGGCdEWg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10995795"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10995795"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 06:23:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4068676"
Received: from puhongt-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.29.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 06:23:45 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	peterz@infradead.org
Cc: mingo@redhat.com,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 0/5] intel_rapl & perf rapl: combine PMU support
Date: Wed, 31 Jan 2024 22:23:30 +0800
Message-Id: <20240131142335.84218-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is made based on the patch series posted at
https://lore.kernel.org/all/20240131113713.74779-1-rui.zhang@intel.com/

Problem statement
-----------------
MSR RAPL powercap sysfs is done in drivers/powercap/intel_rapl_msr.c.
MSR RAPL PMU is done in arch/x86/events/rapl.c.

They maintain two separate CPU model lists, describing the same feature
available on the same set of hardware. This increases unnecessary
maintenance burden a lot.

Now we need to introduce TPMI RAPL PMU support, which again shares most
of the logic with MSR RAPL PMU.

Solution
--------
Introducing PMU support as part of RAPL framework and remove current MSR
RAPL PMU code.

The idea is that, if a RAPL Package device is registered to RAPL
framework, and is ready for energy reporting and control via powercap
sysfs, then it is also ready for PMU.

So introducing PMU support in RAPL framework that works for all
registered RAPL Package devices. With this, we can remove current MSR
RAPL PMU completely.

Given that MSR RAPL and TPMI RAPL driver won't funtion on the same
platform, the new RAPL PMU can be fully compatible with current MSR RAPL
PMU, including using the same PMU name and events name/id/unit/scale.

For example, on platforms use either MSR or TPMI, use the same command
 perf stat -e power/energy-pkg/ -e power/energy-ram/ -e power/energy-cores/ FOO
to get the energy consumption when the events are in "perf list" output.

Notes
-----
There are indeed some functional changes introduced, due to the
divergency between the two CPU model lists. This includes,
1. Fix BROADWELL_D in intel_rapl driver to use fixed Dram domain energy
   unit.
2. Enable PMU for some Intel platforms, which were missing in
   arch/x86/events/rapl.c. This includes
        ICELAKE_NNPI
        ROCKETLAKE
        LUNARLAKE_M
        LAKEFIELD
        ATOM_SILVERMONT
        ATOM_SILVERMONT_MID
        ATOM_AIRMONT
        ATOM_AIRMONT_MID
        ATOM_TREMONT
        ATOM_TREMONT_D
        ATOM_TREMONT_L
3. Change the logic for enumerating AMD/HYGON platforms
   Previously, it was
        X86_MATCH_FEATURE(X86_FEATURE_RAPL,             &model_amd_hygon)
   And now it is
        X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd)
        X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd)
        X86_MATCH_VENDOR_FAM(HYGON, 0x18, &rapl_defaults_amd)

Any comments/concerns are welcome.

thanks,
rui

----------------------------------------------------------------
Zhang Rui (5):
      powercap: intel_rapl: Sort header files
      powercap: intel_rapl: Add PMU support
      powercap: intel_rapl_tpmi: Enable PMU support for TPMI RAPL
      powercap: intel_rapl: Fix BROADWELL_D
      powercap: intel_rapl_msr: Enable PMU support for MSR RAPL

 arch/x86/events/Kconfig              |   8 -
 arch/x86/events/Makefile             |   1 -
 arch/x86/events/rapl.c               | 871 -----------------------------------
 drivers/powercap/intel_rapl_common.c | 562 +++++++++++++++++++++-
 drivers/powercap/intel_rapl_msr.c    |   2 +
 drivers/powercap/intel_rapl_tpmi.c   |   1 +
 include/linux/intel_rapl.h           |  17 +
 7 files changed, 569 insertions(+), 893 deletions(-)
 delete mode 100644 arch/x86/events/rapl.c

