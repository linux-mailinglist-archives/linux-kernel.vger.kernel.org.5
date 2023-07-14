Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F240075423B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbjGNSHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbjGNSHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:07:02 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DB23C00;
        Fri, 14 Jul 2023 11:06:33 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36EEsO8q013531;
        Fri, 14 Jul 2023 12:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=B
        OxRHechdVLR5k0+UUuRMHYDBE3nu3fbPTbGYx6BRL8=; b=nsU+tywlpG5pgo2Ed
        SKR0pvLcvX6jsqMq/WUlA+o3GMNNhmrQDc/+MM/LG2CHVUzatyr6C1Q2MV3InolO
        2/DB5IZgQcrvyM0Yp9ZkiA5f2GNbgG1h5taqiY669pmWVj5mWh4GUvWpSrMmQ+uI
        JlMy1rNH9tSijC/N1yDFUYNThZ2R6laPMbbELGXCwAL0fDfFj60RyPkgVpZbtcLN
        737AielPTu+xUIHCf9gDmYf0/hCvce2WJOCXOGYlcdv92Zna8X+/2k4TNJmXqZ+G
        oiPSazujzE6I1xNKJS2iFOMR+EBFcLDwUq/5W8b/JmNuBlXrE790sIpv/F6nMhbe
        eFBUw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3rtpuu14yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 12:45:38 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 14 Jul
 2023 18:45:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Fri, 14 Jul 2023 18:45:36 +0100
Received: from ricardo-lws.crystal.cirrus.com (ricardo-lws.ad.cirrus.com [141.131.206.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8B98215B9;
        Fri, 14 Jul 2023 17:45:35 +0000 (UTC)
From:   Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>,
        David Rhodes <drhodes@opensource.cirrus.com>
Subject: [PATCH] power: supply: bq24190: Considers FORCE_20PCT when getting IPRECHG
Date:   Fri, 14 Jul 2023 12:45:29 -0500
Message-ID: <20230714174529.287045-1-rriveram@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6pcGFg4A4HQaluY1_rVFShDbL1dYt0jy
X-Proofpoint-ORIG-GUID: 6pcGFg4A4HQaluY1_rVFShDbL1dYt0jy
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a check of the FORCE_20PCT bit when getting the precharge
current value.

According to the bit description for the FORCE_20PCT bit, when
FORCE_20PCT is true, the precharge current target is 50% of
what is configured in the IPRECHG bit field.

Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Reviewed-by: David Rhodes <drhodes@opensource.cirrus.com>
---
 drivers/power/supply/bq24190_charger.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index ef8235848f56..3f99cb9590ba 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -965,7 +965,7 @@ static int bq24190_charger_get_precharge(struct bq24190_dev_info *bdi,
 		union power_supply_propval *val)
 {
 	u8 v;
-	int ret;
+	int curr, ret;
 
 	ret = bq24190_read_mask(bdi, BQ24190_REG_PCTCC,
 			BQ24190_REG_PCTCC_IPRECHG_MASK,
@@ -973,7 +973,20 @@ static int bq24190_charger_get_precharge(struct bq24190_dev_info *bdi,
 	if (ret < 0)
 		return ret;
 
-	val->intval = ++v * 128 * 1000;
+	curr = ++v * 128 * 1000;
+
+	ret = bq24190_read_mask(bdi, BQ24190_REG_CCC,
+			BQ24190_REG_CCC_FORCE_20PCT_MASK,
+			BQ24190_REG_CCC_FORCE_20PCT_SHIFT, &v);
+	if (ret < 0)
+		return ret;
+
+	/* If FORCE_20PCT is enabled, then current is 50% of IPRECHG value */
+	if (v)
+		curr /= 2;
+
+	val->intval = curr;
+
 	return 0;
 }
 
-- 
2.34.1

