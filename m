Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC4A7CB17C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjJPRkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjJPRka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:40:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6FFA2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697478028; x=1729014028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1vi0FmoGEosyvbhLqwxyW8wHJ0MxzfpdH8PFjiMsJG0=;
  b=FCf2MXlUSy8ZCTH8ADKe/jNjvzDhwSmFIaXK+51byFWC3/opVq30X7W1
   i/cS+gyeUoIATI5AbfGpOWqe1mAYX5fXmy3FzE/vSxtgauroS+RQdpJP+
   NGUeUJTpypkRY9J/mHvnMPnrqJdVY5fT6/GZCyGvRFiLqaLgXuzJHVKtg
   V7JEIZ63fsDBJfPh3Ipfn0t0vqi3rgmEFDItbilkx5hNyFf1hDu4y7d1l
   8H4EvTRRBUrAVSl2vRYRtNFOVIRMIjuAHUCwngo8LS9DQaa4HWGgVc4c0
   vWyzbJTBP8VjI/hZHkm8MV22St1ChmgEfqUVdukMB6uBj/TwbE8t9V+6K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365858563"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="365858563"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:40:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785175364"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="785175364"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2023 10:40:22 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     artem.bityutskiy@linux.intel.com, rui.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/4] perf/x86/intel/cstate: Add Grand Ridge support
Date:   Mon, 16 Oct 2023 10:40:14 -0700
Message-Id: <20231016174014.453169-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231016174014.453169-1-kan.liang@linux.intel.com>
References: <20231016174014.453169-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The same as the Sierra Forest, the Grand Ridge supports core C1/C6 and
module C6. But it doesn't support pkg C6 residency counter.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 4a46ef315284..4b50a3a9818a 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -41,7 +41,7 @@
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
  *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
- *					  MTL,SRF
+ *					  MTL,SRF,GRR
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -52,7 +52,8 @@
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
- *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF
+ *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF,
+ *						GRR
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
@@ -99,7 +100,7 @@
  *			       Scope: Package (physical package)
  *	MSR_MODULE_C6_RES_MS:  Module C6 Residency Counter.
  *			       perf code: 0x00
- *			       Available model: SRF
+ *			       Available model: SRF,GRR
  *			       Scope: A cluster of cores shared L2 cache
  *
  */
@@ -677,6 +678,13 @@ static const struct cstate_model glm_cstates __initconst = {
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
 
+static const struct cstate_model grr_cstates __initconst = {
+	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
+				  BIT(PERF_CSTATE_CORE_C6_RES),
+
+	.module_events		= BIT(PERF_CSTATE_MODULE_C6_RES),
+};
+
 static const struct cstate_model srf_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES),
@@ -739,6 +747,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&glm_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	&srf_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	&grr_cstates),
 
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_cstates),
-- 
2.35.1

