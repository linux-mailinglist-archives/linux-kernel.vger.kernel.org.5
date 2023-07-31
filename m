Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DCF769D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjGaQ6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjGaQ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:57:58 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF04268F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:57:51 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36V5lNJO017071;
        Mon, 31 Jul 2023 11:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=DFQy9O4rVl1fkUzjYQguq6VsjkwR+stb5618BZFSP9g=; b=
        GXj7G97GLpBXmDuPdeCnNCloJ7nG4k+fnNYQtwHw8TdnH2/uXLD9hsZHSGB53SWa
        fR20aHMQoV6yrS4l7oJD9HnPlSGGOngmjg8p1rOfmBadxWBLxvFizVqBR4UzHQYF
        qC5CEAYz+0AuMSMwfKmTjnKAxk2aJpUSeog8CFY1NUC97OLnHzA0hgNjQqSz4WjQ
        nvzlcMcEMZHyXiQvEzuup0ypYx8SfBFdy9mQmBYQqWoMdd6sK6Q3IB1LVI90WJdI
        hJjUmLYAM1dtaPYyzgMZw5vd8Oe/m4LQgDmU6IdcL4NmPuCFcoaqoqwZWNVENpm1
        xLh/DA8ZTOWNl5/uLIWXag==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3s5gk1sg45-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 11:57:36 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 17:57:32 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Mon, 31 Jul 2023 17:57:32 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.107])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3C28C475;
        Mon, 31 Jul 2023 16:57:32 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 7/9] ALSA: hda/cs35l56: Do not download firmware over existing RAM firmware
Date:   Mon, 31 Jul 2023 17:57:24 +0100
Message-ID: <20230731165726.7940-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731165726.7940-1-rf@opensource.cirrus.com>
References: <20230731165726.7940-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VQTKml7zteD00oUvbI_K6i472yRGO6xo
X-Proofpoint-ORIG-GUID: VQTKml7zteD00oUvbI_K6i472yRGO6xo
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A RAM firmware can only be downloaded if the CS35L56 is currently
running from ROM firmware. The driver must not try to overwrite
the RAM if the CS35L56 is already running from that RAM.

Firmware can be downloaded in these two cases:

- The BIOS has already patched the firmware (secured mode).
  In this case the firmware files will only contain tunings that
  are safe to overwrite.

- The CS35L56 is running the built-in ROM firmware.

After a RAM firmware has been downloaded it can only be cleared by
hard resetting CS35L56. Some systems only hard-reset during
power-on and do not give the driver control of hard reset.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 803fa2da9ea4..8f1665d38c92 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -525,6 +525,7 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	const struct firmware *wmfw_firmware = NULL;
 	char *coeff_filename = NULL;
 	char *wmfw_filename = NULL;
+	unsigned int firmware_missing;
 	int ret = 0;
 
 	/* Prepare for a new DSP power-up */
@@ -533,11 +534,28 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 
 	cs35l56->base.fw_patched = false;
 
-	cs35l56_hda_request_firmware_files(cs35l56, &wmfw_firmware, &wmfw_filename,
-					   &coeff_firmware, &coeff_filename);
+	pm_runtime_get_sync(cs35l56->base.dev);
+
+	ret = regmap_read(cs35l56->base.regmap, CS35L56_PROTECTION_STATUS, &firmware_missing);
+	if (ret) {
+		dev_err(cs35l56->base.dev, "Failed to read PROTECTION_STATUS: %d\n", ret);
+		goto err_pm_put;
+	}
+
+	firmware_missing &= CS35L56_FIRMWARE_MISSING;
+
+	/*
+	 * Firmware can only be downloaded if the CS35L56 is secured or is
+	 * running from the built-in ROM. If it is secured the BIOS will have
+	 * downloaded firmware, and the wmfw/bin files will only contain
+	 * tunings that are safe to download with the firmware running.
+	 */
+	if (cs35l56->base.secured || firmware_missing) {
+		cs35l56_hda_request_firmware_files(cs35l56, &wmfw_firmware, &wmfw_filename,
+						   &coeff_firmware, &coeff_filename);
+	}
 
 	mutex_lock(&cs35l56->base.irq_lock);
-	pm_runtime_get_sync(cs35l56->base.dev);
 
 	/*
 	 * When the device is running in secure mode the firmware files can
@@ -596,11 +614,12 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	if (!cs35l56->base.fw_patched)
 		cs_dsp_power_down(&cs35l56->cs_dsp);
 err:
-	pm_runtime_put(cs35l56->base.dev);
 	mutex_unlock(&cs35l56->base.irq_lock);
 
 	cs35l56_hda_release_firmware_files(wmfw_firmware, wmfw_filename,
 					   coeff_firmware, coeff_filename);
+err_pm_put:
+	pm_runtime_put(cs35l56->base.dev);
 
 	return ret;
 }
-- 
2.30.2

