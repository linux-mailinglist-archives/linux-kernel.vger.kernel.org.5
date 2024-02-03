Return-Path: <linux-kernel+bounces-50905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AAC84801A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3B028AADF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9300E134B9;
	Sat,  3 Feb 2024 04:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afX2aAjk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F6E1118E;
	Sat,  3 Feb 2024 04:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933049; cv=none; b=RAoWzbenFhp0TUS7L+AK/iTtMhU5xqZbefBd6PRZP1Ty7iXf8289f/Syxcf87fyzuIO6XUpYLxcHIHswjlQE3pOR1uY9Wx5Zj/nxvmeRkIG7hUWR4d4mpE47imXS+TGhLnPGEW7Lhk8mtrM2gE6Kx+08YdUIPTQzJuRE4LSeOnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933049; c=relaxed/simple;
	bh=tPRApoSMpWENCgHFmpqWBaJZ2dE2sWiZiCQc9GL+JjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NrudZEWEGeH0VPhKDZ1pdvpcflhlgzBFB/XxzGJID4kw/yxsSybB3nZsyyRxt2Z5mi7+oBdeLVbaBEUbvVpJDa10sDixR1K6LencxNjLyNfSDwXRsyLgEyHlEOr6cv+SnC73Vm2ooGYwrGheZ41ueJyy0jq9rTcKB+WhXVQU1IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=afX2aAjk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706933048; x=1738469048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=tPRApoSMpWENCgHFmpqWBaJZ2dE2sWiZiCQc9GL+JjM=;
  b=afX2aAjkOfwaueMyp9j7cKzUj3/E96MvypnEnOTkMe+aiu30OowaQioX
   WFKImsflvZT5OerpcbVRexIhfphsXKicAIi/wcVt/RJaHxMLG03j2n/We
   p7+jBQLo4SqvMMvzYQKVh4U3+LpPxYoQJ4GizlQptdumx/HHeITAenzpz
   o06qDd4/y5vZScYGVZ/wowgy6fZwEcFGXMXTS9QUtXsISR/f4CFim3CKA
   m7t2aYnpHLXu6UcFxnCX3Rb5KePGwT2Zt+NIA5P3MQY/Q/cIjgtPz8Pq0
   y5T6fRunNGBk1pOoh1yvpu6FnK1dL6lQGei28QjYNOBcmJRBCygFaaI8h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="4181425"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4181425"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 20:04:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823382525"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="823382525"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2024 20:04:05 -0800
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
Subject: [PATCH 7/9] x86/cpufeatures: Add feature bit for HRESET
Date: Fri,  2 Feb 2024 20:05:13 -0800
Message-Id: <20240203040515.23947-8-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The HRESET instruction isolates the classification of individual
tasks when they run sequentially on the same logical processor. It resets
the classification history that the logical processor maintains.

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
 arch/x86/include/asm/msr-index.h   | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 8104f4791abd..3b42479c049d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -326,6 +326,7 @@
 #define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
 #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
+#define X86_FEATURE_HRESET		(12*32+22) /* Hardware history reset instruction */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
 #define X86_FEATURE_LAM			(12*32+26) /* Linear Address Masking */
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index d74932a0778d..65b1bfb9c304 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1155,6 +1155,9 @@
 
 #define MSR_IA32_HW_FEEDBACK_CHAR       0x17d2
 
+/* Hardware History Reset  */
+#define MSR_IA32_HW_HRESET_ENABLE	0x17da
+
 /* x2APIC locked status */
 #define MSR_IA32_XAPIC_DISABLE_STATUS	0xBD
 #define LEGACY_XAPIC_DISABLED		BIT(0) /*
-- 
2.25.1


