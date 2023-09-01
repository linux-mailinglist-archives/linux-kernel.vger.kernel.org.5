Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541BD78FEE5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349969AbjIAOUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbjIAOUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:20:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D249E10FC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693578013; x=1725114013;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1XNYUl552swnrGYwrYKn5loiY613doKUeRV7E+fL+48=;
  b=eo7Oj3N6jMlGzANcSdW8Mhih6Qpkc03FKMx/ttBC9uasLIGZN/U05M4m
   SxPQiRV59Sdu8v7doRjGawfD/Lk5GHDCOON8aACQuSJy+Egc6WXhM31GS
   PCmSgYXIq6vBNVZ/+eEkhNDcvi2+qzIKVUhao9HqUDj5deTKgnFb8ki1B
   D4e2ALynpatGk1CynduUGJsMG/q2DzEdTPAp4ld1W2dcqrZQx92m64g/g
   aTaYXWHUlnFDebr8khdrxddfT1xVnOVpOfPtqo+EhP8PgGEEDg7/Y4uXY
   /NChciR1cyglIAzu1jw/pAzIEL0+mQg/mqAG5miHHzl0ehTSJLAi87dLV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="361254928"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="361254928"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 07:20:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="986702542"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="986702542"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga006.fm.intel.com with ESMTP; 01 Sep 2023 07:20:12 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Yunying Sun <yunying.sun@intel.com>
Subject: [PATCH] perf/x86/uncore: Correct the number of CHAs on EMR
Date:   Fri,  1 Sep 2023 07:20:28 -0700
Message-Id: <20230901142028.298051-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The MSR UNC_CBO_CONFIG, which was used to detect the number of CHAs on
SPR, is broken on EMR XCC. It always returns 0.

Roll back to the discovery method, which can give the correct number for
this case.

Fixes: 38776cc45eb7 ("perf/x86/uncore: Correct the number of CHAs on SPR")
Reported-by: Stephane Eranian <eranian@google.com>
Reported-by: Yunying Sun <yunying.sun@intel.com>
Tested-by: Yunying Sun <yunying.sun@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index d49e90dc04a4..c41d7d46481c 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6475,7 +6475,9 @@ void spr_uncore_cpu_init(void)
 	type = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
 	if (type) {
 		rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
-		type->num_boxes = num_cbo;
+		/* The MSR doesn't work on the EMR XCC. Roll back to the discovery method. */
+		if (num_cbo)
+			type->num_boxes = num_cbo;
 	}
 	spr_uncore_iio_free_running.num_boxes = uncore_type_max_boxes(uncore_msr_uncores, UNCORE_SPR_IIO);
 }
-- 
2.35.1

