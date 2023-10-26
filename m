Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D92F7D858C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345438AbjJZPHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345388AbjJZPGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:06:37 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C48B129;
        Thu, 26 Oct 2023 08:06:34 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39Q5GUrh011654;
        Thu, 26 Oct 2023 10:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=rCtU+23iYhcqMYCBAuByfGZ6QMb+FTNaY4bVaU6dOEs=; b=
        gnXeRITUMh5bwbnUTjFumddLoJUgJcfbF3BQ9H+d2W62HErM0Df8y5hQe05dk4V2
        NsUQchloXHv3fFCxVE0n0N7+zMa01IFzWW6cR5kd1rPTEjBh3VKHn0dv4vMVZm3j
        U5TdmtnrU2843evXxKaUExjVzXBd4s+z9ipZfiGHj4zpQEZQfej0yavDIzGRAIw8
        p2Km3RJKFExpi3nhiFU8Tw/dL4eiNWdr7XbQAjV5OWfTGX2+P/n+6QojYzxnulaJ
        RnvLAB4Wl0c71HT5mS42jnCa6qeR4tNdrnWbBDTaQQtvwwlvs7neAZRn5dfmEcVF
        lXop0MkAp1wLDRMG5lSyCA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3tvc1x94k9-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 10:06:14 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 26 Oct
 2023 16:06:08 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Thu, 26 Oct 2023 16:06:08 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.177])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3D25F2A1;
        Thu, 26 Oct 2023 15:06:08 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Mark Brown" <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 4/8] ALSA: hda: cs35l41: Run boot process during resume callbacks
Date:   Thu, 26 Oct 2023 16:05:54 +0100
Message-ID: <20231026150558.2105827-5-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
References: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: uRqba9iLnbG5eomcHmDQNPytZqJWl7HG
X-Proofpoint-ORIG-GUID: uRqba9iLnbG5eomcHmDQNPytZqJWl7HG
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During initial probe, after reset is asserted for the first time, the
driver goes through a boot process to ensure the amp is ready to be
used. This involves verifying a boot flag, as well as verifying the
chip ids.

This is necessary since it is possible for the amp to have been fully
reset by the system suspend calls.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 105 ++++++++++++++++++++++++------------
 1 file changed, 72 insertions(+), 33 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 1ac721085fb5..e787788c1be2 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -730,6 +730,34 @@ static int cs35l41_hda_channel_map(struct device *dev, unsigned int tx_num, unsi
 				    rx_slot);
 }
 
+int cs35l41_verify_id(struct cs35l41_hda *cs35l41, unsigned int *regid, unsigned int *reg_revid)
+{
+	unsigned int mtl_revid, chipid;
+	int ret;
+
+	ret = regmap_read(cs35l41->regmap, CS35L41_DEVID, regid);
+	if (ret) {
+		dev_err_probe(cs35l41->dev, ret, "Get Device ID failed\n");
+		return ret;
+	}
+
+	ret = regmap_read(cs35l41->regmap, CS35L41_REVID, reg_revid);
+	if (ret) {
+		dev_err_probe(cs35l41->dev, ret, "Get Revision ID failed\n");
+		return ret;
+	}
+
+	mtl_revid = *reg_revid & CS35L41_MTLREVID_MASK;
+
+	chipid = (mtl_revid % 2) ? CS35L41R_CHIP_ID : CS35L41_CHIP_ID;
+	if (*regid != chipid) {
+		dev_err(cs35l41->dev, "CS35L41 Device ID (%X). Expected ID %X\n", *regid, chipid);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int cs35l41_ready_for_reset(struct cs35l41_hda *cs35l41)
 {
 	int ret = 0;
@@ -827,6 +855,30 @@ static int cs35l41_system_suspend(struct device *dev)
 	return ret;
 }
 
+static int cs35l41_wait_boot_done(struct cs35l41_hda *cs35l41)
+{
+	unsigned int int_status;
+	int ret;
+
+	ret = regmap_read_poll_timeout(cs35l41->regmap, CS35L41_IRQ1_STATUS4, int_status,
+				       int_status & CS35L41_OTP_BOOT_DONE, 1000, 100000);
+	if (ret) {
+		dev_err(cs35l41->dev, "Failed waiting for OTP_BOOT_DONE\n");
+		return ret;
+	}
+
+	ret = regmap_read(cs35l41->regmap, CS35L41_IRQ1_STATUS3, &int_status);
+	if (ret || (int_status & CS35L41_OTP_BOOT_ERR)) {
+		dev_err(cs35l41->dev, "OTP Boot status %x error\n",
+			int_status & CS35L41_OTP_BOOT_ERR);
+		if (!ret)
+			ret = -EIO;
+		return ret;
+	}
+
+	return 0;
+}
+
 static int cs35l41_system_resume(struct device *dev)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
@@ -847,6 +899,14 @@ static int cs35l41_system_resume(struct device *dev)
 
 	usleep_range(2000, 2100);
 
+	regcache_cache_only(cs35l41->regmap, false);
+
+	ret = cs35l41_wait_boot_done(cs35l41);
+	if (ret)
+		return ret;
+
+	regcache_cache_only(cs35l41->regmap, true);
+
 	ret = pm_runtime_force_resume(dev);
 	if (ret) {
 		dev_err(dev, "System Resume Failed: Unable to runtime resume: %d\n", ret);
@@ -908,6 +968,7 @@ static int cs35l41_runtime_suspend(struct device *dev)
 static int cs35l41_runtime_resume(struct device *dev)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+	unsigned int regid, reg_revid;
 	int ret = 0;
 
 	dev_dbg(cs35l41->dev, "Runtime Resume\n");
@@ -929,6 +990,10 @@ static int cs35l41_runtime_resume(struct device *dev)
 		}
 	}
 
+	ret = cs35l41_verify_id(cs35l41, &regid, &reg_revid);
+	if (ret)
+		goto err;
+
 	/* Test key needs to be unlocked to allow the OTP settings to re-apply */
 	cs35l41_test_key_unlock(cs35l41->dev, cs35l41->regmap);
 	ret = regcache_sync(cs35l41->regmap);
@@ -941,6 +1006,8 @@ static int cs35l41_runtime_resume(struct device *dev)
 	if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
 		cs35l41_init_boost(cs35l41->dev, cs35l41->regmap, &cs35l41->hw_cfg);
 
+	dev_dbg(cs35l41->dev, "CS35L41 Resumed (%x), Revision: %02X\n", regid, reg_revid);
+
 err:
 	mutex_unlock(&cs35l41->fw_mutex);
 
@@ -1660,7 +1727,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int irq,
 		      struct regmap *regmap)
 {
-	unsigned int int_sts, regid, reg_revid, mtl_revid, chipid, int_status;
+	unsigned int regid, reg_revid;
 	struct cs35l41_hda *cs35l41;
 	int ret;
 
@@ -1701,41 +1768,13 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 
 	usleep_range(2000, 2100);
 
-	ret = regmap_read_poll_timeout(cs35l41->regmap, CS35L41_IRQ1_STATUS4, int_status,
-				       int_status & CS35L41_OTP_BOOT_DONE, 1000, 100000);
-	if (ret) {
-		dev_err_probe(cs35l41->dev, ret, "Failed waiting for OTP_BOOT_DONE\n");
-		goto err;
-	}
-
-	ret = regmap_read(cs35l41->regmap, CS35L41_IRQ1_STATUS3, &int_sts);
-	if (ret || (int_sts & CS35L41_OTP_BOOT_ERR)) {
-		dev_err_probe(cs35l41->dev, ret, "OTP Boot status %x error\n",
-			      int_sts & CS35L41_OTP_BOOT_ERR);
-		ret = -EIO;
-		goto err;
-	}
-
-	ret = regmap_read(cs35l41->regmap, CS35L41_DEVID, &regid);
-	if (ret) {
-		dev_err_probe(cs35l41->dev, ret, "Get Device ID failed\n");
-		goto err;
-	}
-
-	ret = regmap_read(cs35l41->regmap, CS35L41_REVID, &reg_revid);
-	if (ret) {
-		dev_err_probe(cs35l41->dev, ret, "Get Revision ID failed\n");
+	ret = cs35l41_wait_boot_done(cs35l41);
+	if (ret)
 		goto err;
-	}
-
-	mtl_revid = reg_revid & CS35L41_MTLREVID_MASK;
 
-	chipid = (mtl_revid % 2) ? CS35L41R_CHIP_ID : CS35L41_CHIP_ID;
-	if (regid != chipid) {
-		dev_err(cs35l41->dev, "CS35L41 Device ID (%X). Expected ID %X\n", regid, chipid);
-		ret = -ENODEV;
+	ret = cs35l41_verify_id(cs35l41, &regid, &reg_revid);
+	if (ret)
 		goto err;
-	}
 
 	ret = cs35l41_test_key_unlock(cs35l41->dev, cs35l41->regmap);
 	if (ret)
-- 
2.34.1

