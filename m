Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486ED794393
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbjIFTIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjIFTIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:08:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4143E59;
        Wed,  6 Sep 2023 12:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694027320; x=1725563320;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WKPmR5sUcVInlzOsBWGN0yyVHkQ64GK5zzE2PBLyes0=;
  b=Zeqm5uXvun+N3h/oJeKG8By0AO9DwDSPPVCwaBz1NgtEvbOs/R2srC8O
   OlIGIXN/CX2nhficS72+8Lktze09Qg1mgJDyTt+7w9FQJqeJFqwhYYtiE
   BhZYo0gF1EGZEXb6DI0izhFRrmq3ZjoMeuUnsL7ddMHAs8lhZNA5LYzCD
   rHlKOwqvVxYoMhrAraxC571c8qUNCbJK3ps6POxfQw1Oevr6dXUsuwv9Z
   TMnh1f2io7IdOeRvqNstkBiO8ExOJciehXI89Ncqj7zaL/E1FdyfVWwAd
   +OkC4FsZfEYfNKn5CZ0X32+d3mNroQkXRB5hoJzJFaP3+poSCE6UzKTxg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="374551075"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="374551075"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 12:08:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="735181564"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="735181564"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga007.jf.intel.com with ESMTP; 06 Sep 2023 12:08:27 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, sumeet.r.pawnikar@intel.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] powercap: intel_rapl: Fix invalid setting of Power Limit 4
Date:   Wed,  6 Sep 2023 12:08:16 -0700
Message-Id: <20230906190816.2966001-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
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

System runs at minimum performance, once powercap RAPL package domain
enabled flag is changed from 1 to 0 to 1. 

Setting RAPL package domain enabled flag to 0, results in setting of
power limit 4 (PL4) MSR 0x601 to 0. This implies disabling PL4 limit.
The PL4 limit controls the peak power. So setting 0, results in some
undesirable performance, which depends on hardware implementation.

Even worse, when the enabled flag is set to 1 again. This will set PL4
MSR value to 0x01, which means reduce peak power to 0.125W. This will
force system to run at the lowest possible performance on every PL4
supported system.

Setting enabled flag should only affect the "enable" bit, not other
bits. Here it is changing power limit.

This is caused by a change which assumes that there is an enable bit in
the PL4 MSR like other power limits. Although PL4 enable/disable bit is
present with TPMI RAPL interface, it is not present with the MSR
interface.

There is a rapl_primitive_info defined for non existent PL4 enable bit
and then it is used with the commit 9050a9cd5e4c ("powercap: intel_rapl:
Cleanup Power Limits support") to enable PL4. This is wrong, hence remove
this rapl primitive for PL4. Also in the function
rapl_detect_powerlimit(), PL_ENABLE is used to check for the presence of
power limits. Replace PL_ENABLE with PL_LIMIT, as PL_LIMIT must be
present. Without this change, PL4 controls will not be available in the
sysfs once rapl primitive for PL4 is removed.

Fixes: 9050a9cd5e4c ("powercap: intel_rapl: Cleanup Power Limits support")
Suggested-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc: stable@vger.kernel.org # v6.5+
---
v2
- Remove RAPL primitive for PL4 instead as suggedted by Rui
- Replace PL_ENABLE with PL_LIMIT for domain detect
- Update change log and header

 drivers/powercap/intel_rapl_common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 5c2e6d5eea2a..40a2cc649c79 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -658,8 +658,6 @@ static struct rapl_primitive_info rpi_msr[NR_RAPL_PRIMITIVES] = {
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
 	[PL2_CLAMP] = PRIMITIVE_INFO_INIT(PL2_CLAMP, POWER_LIMIT2_CLAMP, 48,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[PL4_ENABLE] = PRIMITIVE_INFO_INIT(PL4_ENABLE, POWER_LIMIT4_MASK, 0,
-				RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT, 0),
 	[TIME_WINDOW1] = PRIMITIVE_INFO_INIT(TIME_WINDOW1, TIME_WINDOW1_MASK, 17,
 			    RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
 	[TIME_WINDOW2] = PRIMITIVE_INFO_INIT(TIME_WINDOW2, TIME_WINDOW2_MASK, 49,
@@ -1458,7 +1456,7 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
 			}
 		}
 
-		if (rapl_read_pl_data(rd, i, PL_ENABLE, false, &val64))
+		if (rapl_read_pl_data(rd, i, PL_LIMIT, false, &val64))
 			rd->rpl[i].name = NULL;
 	}
 }
-- 
2.34.1

