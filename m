Return-Path: <linux-kernel+bounces-50903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D0C848018
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D1828A8CC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8EA12B9C;
	Sat,  3 Feb 2024 04:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7ZZsHHI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C45110965;
	Sat,  3 Feb 2024 04:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933049; cv=none; b=hZUB5Ock4utN/vL6iNsIK9FypiqKTP1WRwJrlwZlzzKZYfPgE2Nqia2I3CQXfIOZ+gNPVjziBeZGgILH1Ad7KOwbaKcBd4tSzXE2LDybcn+a+saNoUltF51D0Gw/H95aB2t3kiqvDnYG+jmcnXJUAR2ZXXxLt1AZrtrpWN0Xaok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933049; c=relaxed/simple;
	bh=JlsbRLvxWX+gGq/dnjUfG92Wdmp50mFvi0KtQuzOgEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pmC1Kof71kMMHkoLqlQNsgPI5LXiJ06i2T7n/6bwWXk2O6jprJuBeaSgr/TGSHwzj4HSTK+uS5wXNOraRc9lC40mG1E0CFamOqFPnCIs4n+jV18qP8P/H7+EQ+tTekjMpseHcqiOwdd8gQ9gp6g4Maf2a7wLyhWX6XXG2AedQ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7ZZsHHI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706933048; x=1738469048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=JlsbRLvxWX+gGq/dnjUfG92Wdmp50mFvi0KtQuzOgEU=;
  b=h7ZZsHHImybnN36YkxJohrwAnhA2StDdyuOAwEErJTungc/J4LoU59L8
   n1OlfBu/y1U9J+5Vyr12zMbmyCkFJM9irL2fW/MD+R/mzMgsULCGmozLQ
   Rie3J90tuPsChgD7Sak1oJJ6mzoNf7e6IQfdusClhPKBbn05NNPgD8OAW
   nnGKMU2CFkwyKDaq7piRgp33wloWP1cz8L3BRi33iC3/OSpmewGhdci5W
   Sz5JHi04j75zzbzWGoaKGu41klI87UoAsmPtr/TCEfCrDiPcKzIcw8+7F
   RwxEBkYHzwZlWPkvOfBzhc+aatRGRCpqCO8N1sgcw5+xIGhylv8/ZDz2R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="4181421"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4181421"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 20:04:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823382518"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="823382518"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2024 20:04:04 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Zhuocheng Ding <zhuocheng.ding@intel.com>,
	x86@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Zhao Liu <zhao1.liu@linux.intel.com>
Subject: [PATCH 5/9] x86/cpufeatures: Add the Intel Thread Director feature definitions
Date: Fri,  2 Feb 2024 20:05:11 -0800
Message-Id: <20240203040515.23947-6-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Intel Thread Director (ITD) provides hardware resources to classify
the current task. The classification reflects the instructions per cycle of
such current task.

ITD extends the Hardware Feedback Interface table to provide performance
and energy efficiency capabilities for each of the supported classes of
tasks.

Cc: Len Brown <len.brown@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Zhuocheng Ding <zhuocheng.ding@intel.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Patch cherry-picked from the IPC classes patchset.
---
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index fdf723b6f6d0..8104f4791abd 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -360,6 +360,7 @@
 #define X86_FEATURE_HWP_EPP		(14*32+10) /* HWP Energy Perf. Preference */
 #define X86_FEATURE_HWP_PKG_REQ		(14*32+11) /* HWP Package Level Request */
 #define X86_FEATURE_HFI			(14*32+19) /* Hardware Feedback Interface */
+#define X86_FEATURE_ITD			(14*32+23) /* Intel Thread Director */
 
 /* AMD SVM Feature Identification, CPUID level 0x8000000a (EDX), word 15 */
 #define X86_FEATURE_NPT			(15*32+ 0) /* Nested Page Table support */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index e462c1d3800a..2ab036125a56 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -82,6 +82,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_XFD,			X86_FEATURE_XGETBV1   },
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
 	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
+	{ X86_FEATURE_ITD,			X86_FEATURE_HFI       },
 	{}
 };
 
-- 
2.25.1


