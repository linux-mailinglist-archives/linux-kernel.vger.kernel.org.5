Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D158E75B018
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjGTNeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjGTNde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:33:34 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB771FD5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:33:04 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36K6Acqb016432;
        Thu, 20 Jul 2023 08:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=Ud/QBJHaAFqyPCB/So8Atv4/aEQFcV6W/YWOD6HpSgY=; b=
        I1wqhfTKKUOwzKpVHLzgGt2KiYujmtkvGCZze+QY2PjtNPLeCiTSqZbnlTMHzeJI
        W9Tisain17c3wcf9QoShKPy+fQdYc4RNeCZnIsxicNE5sEy9n3jDzrwD1HrwagN/
        U4BGqnvmSq7LHHarGCG6vgXVwKPk+euhneaEhHjPHXT8t3cCqhZrJwjmO4e23gke
        jnBJ6J6EywWmqdP5Iv2HTyvdw7amYOgLXDw4ls6Nej94bdEfSaD4zxo78aK8hi64
        CqGgfa5zRzT21IZW/9+zOpOFQiXssXn1y0CHqanwbi1DNAeur7tf3ofgaBJBHwuo
        xFStDMU/t6wP0lrq9Um+xw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3rus6gx5mr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:32:12 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 14:32:09 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Thu, 20 Jul 2023 14:32:09 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.219])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BA1E315B6;
        Thu, 20 Jul 2023 13:32:09 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 03/11] ALSA: hda: cs35l41: Ensure we correctly re-sync regmap before system suspending.
Date:   Thu, 20 Jul 2023 14:31:39 +0100
Message-ID: <20230720133147.1294337-4-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720133147.1294337-1-sbinding@opensource.cirrus.com>
References: <20230720133147.1294337-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xVu4ZQprtLwieDlWeBcu45sp_o6nxplp
X-Proofpoint-GUID: xVu4ZQprtLwieDlWeBcu45sp_o6nxplp
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to properly system suspend, it is necessary to unload the firmware
and ensure the chip is ready for shutdown (if necessary). If the system
is currently in runtime suspend, it is necessary to wake up the device,
and then make it ready. Currently, the wake does not correctly resync
the device, which may mean it cannot suspend correctly. Fix this by
performaing a resync.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 29f1dce45f1dc..f42457147ce47 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -574,21 +574,43 @@ static int cs35l41_hda_channel_map(struct device *dev, unsigned int tx_num, unsi
 				    rx_slot);
 }
 
-static void cs35l41_ready_for_reset(struct cs35l41_hda *cs35l41)
+static int cs35l41_ready_for_reset(struct cs35l41_hda *cs35l41)
 {
+	int ret = 0;
+
 	mutex_lock(&cs35l41->fw_mutex);
 	if (cs35l41->firmware_running) {
 
 		regcache_cache_only(cs35l41->regmap, false);
 
-		cs35l41_exit_hibernate(cs35l41->dev, cs35l41->regmap);
+		ret = cs35l41_exit_hibernate(cs35l41->dev, cs35l41->regmap);
+		if (ret) {
+			dev_warn(cs35l41->dev, "Unable to exit Hibernate.");
+			goto err;
+		}
+
+		/* Test key needs to be unlocked to allow the OTP settings to re-apply */
+		cs35l41_test_key_unlock(cs35l41->dev, cs35l41->regmap);
+		ret = regcache_sync(cs35l41->regmap);
+		cs35l41_test_key_lock(cs35l41->dev, cs35l41->regmap);
+		if (ret) {
+			dev_err(cs35l41->dev, "Failed to restore register cache: %d\n", ret);
+			goto err;
+		}
+
+		if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
+			cs35l41_init_boost(cs35l41->dev, cs35l41->regmap, &cs35l41->hw_cfg);
+
 		cs35l41_shutdown_dsp(cs35l41);
 		cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type);
-
-		regcache_cache_only(cs35l41->regmap, true);
-		regcache_mark_dirty(cs35l41->regmap);
 	}
+err:
+	regcache_cache_only(cs35l41->regmap, true);
+	regcache_mark_dirty(cs35l41->regmap);
+
 	mutex_unlock(&cs35l41->fw_mutex);
+
+	return ret;
 }
 
 static int cs35l41_system_suspend(struct device *dev)
-- 
2.34.1

