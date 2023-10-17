Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E127CC127
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343799AbjJQKyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343764AbjJQKy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:54:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53A8B0;
        Tue, 17 Oct 2023 03:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697540067; x=1729076067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CsF59PCImykjphA2PkOolYAyOHHmHD5q8E+m9W+1Jkg=;
  b=FepUomsHQnbMlfAvbCYOcGaLEO80nz+ltcFglmfaeTIRWqEQfdb8QLVb
   ZlFhss8jFpU8hKIg4rb2nDo21OepPFpDEbN1gYzARXIN1v94krupYGC1X
   pNLRQw9sBXGMZSeVJLL17tACYhQpW9mfVuHCjguwm55ooyccCqfelBhbb
   g4r70dJEAx8XUvjVTpwWZOkz9ZHjp+ImZN8NtWVrNj9V3xQG3yGbZVmZD
   aNOt1LzxXyq1s83ylgd5DYi1ZPZHOdmfzB9nCWJrJ3cWI1izjB6giCk3Z
   FyS7hWXod5007wRiM0IhL91YBuBmQIExBiIS06vm/hR8My209S6FG8xwa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="366012648"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="366012648"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 03:54:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785445307"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="785445307"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2023 03:54:19 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 275CB312DE;
        Tue, 17 Oct 2023 11:54:17 +0100 (IST)
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
To:     Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        George Cherian <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Coiby Xu <coiby.xu@gmail.com>
Cc:     Brett Creeley <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH net-next v2 04/11] bnxt_en: devlink health: use retained error fmsg API
Date:   Tue, 17 Oct 2023 12:53:34 +0200
Message-Id: <20231017105341.415466-5-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unneeded error checking.

devlink_fmsg_*() family of functions is now retaining errors,
so there is no need to check for them after each call.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-125 (-125)
---
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c | 93 +++++++------------
 1 file changed, 32 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 8b3e7697390f..09254e8a62d0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -104,80 +104,58 @@ static int bnxt_fw_diagnose(struct devlink_health_reporter *reporter,
 	struct bnxt *bp = devlink_health_reporter_priv(reporter);
 	struct bnxt_fw_health *h = bp->fw_health;
 	u32 fw_status, fw_resets;
-	int rc;
 
-	if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
-		return devlink_fmsg_string_pair_put(fmsg, "Status", "recovering");
+	if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
+		devlink_fmsg_string_pair_put(fmsg, "Status", "recovering");
+		return 0;
+	}
 
-	if (!h->status_reliable)
-		return devlink_fmsg_string_pair_put(fmsg, "Status", "unknown");
+	if (!h->status_reliable) {
+		devlink_fmsg_string_pair_put(fmsg, "Status", "unknown");
+		return 0;
+	}
 
 	mutex_lock(&h->lock);
 	fw_status = bnxt_fw_health_readl(bp, BNXT_FW_HEALTH_REG);
 	if (BNXT_FW_IS_BOOTING(fw_status)) {
-		rc = devlink_fmsg_string_pair_put(fmsg, "Status", "initializing");
-		if (rc)
-			goto unlock;
+		devlink_fmsg_string_pair_put(fmsg, "Status", "initializing");
 	} else if (h->severity || fw_status != BNXT_FW_STATUS_HEALTHY) {
 		if (!h->severity) {
 			h->severity = SEVERITY_FATAL;
 			h->remedy = REMEDY_POWER_CYCLE_DEVICE;
 			h->diagnoses++;
 			devlink_health_report(h->fw_reporter,
 					      "FW error diagnosed", h);
 		}
-		rc = devlink_fmsg_string_pair_put(fmsg, "Status", "error");
-		if (rc)
-			goto unlock;
-		rc = devlink_fmsg_u32_pair_put(fmsg, "Syndrome", fw_status);
-		if (rc)
-			goto unlock;
+		devlink_fmsg_string_pair_put(fmsg, "Status", "error");
+		devlink_fmsg_u32_pair_put(fmsg, "Syndrome", fw_status);
 	} else {
-		rc = devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
-		if (rc)
-			goto unlock;
+		devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
 	}
 
-	rc = devlink_fmsg_string_pair_put(fmsg, "Severity",
-					  bnxt_health_severity_str(h->severity));
-	if (rc)
-		goto unlock;
+	devlink_fmsg_string_pair_put(fmsg, "Severity",
+				     bnxt_health_severity_str(h->severity));
 
 	if (h->severity) {
-		rc = devlink_fmsg_string_pair_put(fmsg, "Remedy",
-						  bnxt_health_remedy_str(h->remedy));
-		if (rc)
-			goto unlock;
-		if (h->remedy == REMEDY_DEVLINK_RECOVER) {
-			rc = devlink_fmsg_string_pair_put(fmsg, "Impact",
-							  "traffic+ntuple_cfg");
-			if (rc)
-				goto unlock;
-		}
+		devlink_fmsg_string_pair_put(fmsg, "Remedy",
+					     bnxt_health_remedy_str(h->remedy));
+		if (h->remedy == REMEDY_DEVLINK_RECOVER)
+			devlink_fmsg_string_pair_put(fmsg, "Impact",
+						     "traffic+ntuple_cfg");
 	}
 
-unlock:
 	mutex_unlock(&h->lock);
-	if (rc || !h->resets_reliable)
-		return rc;
+	if (!h->resets_reliable)
+		return 0;
 
 	fw_resets = bnxt_fw_health_readl(bp, BNXT_FW_RESET_CNT_REG);
-	rc = devlink_fmsg_u32_pair_put(fmsg, "Resets", fw_resets);
-	if (rc)
-		return rc;
-	rc = devlink_fmsg_u32_pair_put(fmsg, "Arrests", h->arrests);
-	if (rc)
-		return rc;
-	rc = devlink_fmsg_u32_pair_put(fmsg, "Survivals", h->survivals);
-	if (rc)
-		return rc;
-	rc = devlink_fmsg_u32_pair_put(fmsg, "Discoveries", h->discoveries);
-	if (rc)
-		return rc;
-	rc = devlink_fmsg_u32_pair_put(fmsg, "Fatalities", h->fatalities);
-	if (rc)
-		return rc;
-	return devlink_fmsg_u32_pair_put(fmsg, "Diagnoses", h->diagnoses);
+	devlink_fmsg_u32_pair_put(fmsg, "Resets", fw_resets);
+	devlink_fmsg_u32_pair_put(fmsg, "Arrests", h->arrests);
+	devlink_fmsg_u32_pair_put(fmsg, "Survivals", h->survivals);
+	devlink_fmsg_u32_pair_put(fmsg, "Discoveries", h->discoveries);
+	devlink_fmsg_u32_pair_put(fmsg, "Fatalities", h->fatalities);
+	devlink_fmsg_u32_pair_put(fmsg, "Diagnoses", h->diagnoses);
+	return 0;
 }
 
 static int bnxt_fw_dump(struct devlink_health_reporter *reporter,
@@ -203,19 +181,12 @@ static int bnxt_fw_dump(struct devlink_health_reporter *reporter,
 
 	rc = bnxt_get_coredump(bp, BNXT_DUMP_LIVE, data, &dump_len);
 	if (!rc) {
-		rc = devlink_fmsg_pair_nest_start(fmsg, "core");
-		if (rc)
-			goto exit;
-		rc = devlink_fmsg_binary_pair_put(fmsg, "data", data, dump_len);
-		if (rc)
-			goto exit;
-		rc = devlink_fmsg_u32_pair_put(fmsg, "size", dump_len);
-		if (rc)
-			goto exit;
-		rc = devlink_fmsg_pair_nest_end(fmsg);
+		devlink_fmsg_pair_nest_start(fmsg, "core");
+		devlink_fmsg_binary_pair_put(fmsg, "data", data, dump_len);
+		devlink_fmsg_u32_pair_put(fmsg, "size", dump_len);
+		devlink_fmsg_pair_nest_end(fmsg);
 	}
 
-exit:
 	vfree(data);
 	return rc;
 }
-- 
2.40.1

