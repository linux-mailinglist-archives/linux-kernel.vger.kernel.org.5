Return-Path: <linux-kernel+bounces-78624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A311861607
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5BB1C23D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A5083CDB;
	Fri, 23 Feb 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EBi6SxAQ"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D921682868;
	Fri, 23 Feb 2024 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702775; cv=none; b=pFmFeQIbeKKdaDpH2g2/ExUaB6sHZp1TRdI4ZGki0ksbwRybYdKdpatK5gkoLwaQc1YbpzamS6JkmwvFT/FinsBoqJF4PcvC9/5PpF1gUojLqEItkrRHpdziuPcN9nEw0AibNo7B4yLLaqi8h7iZ5rW21BoxU0B30uJ6h5ceAEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702775; c=relaxed/simple;
	bh=RT7qpWzJFfzHL4mTZL7HdWKVbImVss1n/jGqmMOOrF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J332L4yLugBI8Fbj2XPW/tODyfj1NHYJi+stDZck8wJRYaqtNXGjKaOoeVBpiidk5Sdgvjra7fGx+oTF1CWSuYlUl0bnYc09IAIGdbL6D2jmmDI6VwQbNFcIIXz4CjCbrD6MWI6PrLOM+5F6nUV1ojPh74n/k2RrgYThGhEYG0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=EBi6SxAQ; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N8gUBV005505;
	Fri, 23 Feb 2024 09:39:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=/9AX2gejBB9ddU1dH6qsGvwcxt45T/fZXG9ID816eBM=; b=
	EBi6SxAQAp/lZop75epG1kYfKRK83m6493BQI7ba+YMNrQtsPPuxvPwYdaNeCnlX
	ZCKoCS3aWVD5fgnVWrRtO/PbIbXL60ofu6cjM0a9JiKSKFkrescKgXec1OB+Fy+/
	vjRpmn5s4dq8zysK8yUmXcTEyjLjaQIqUQddtaKCUk5Iit3GtOrQPSM0YsCYhgQC
	CfXQLHFQhNW2UQdcT1s+/ZQcOYzO+B8EVn9yTNttJ2e8MigshS/UqEHe2aT0dU6p
	mKlF5zXQ8GzaPZwyUkw3ePycL18WFMO2gDk3C8Jt63LIgNzPm9KEhNJLTX+NgZJM
	9fwzq6PvmXlsRupEl/brww==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wd205m5pe-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 09:39:14 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 15:39:10 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Fri, 23 Feb 2024 15:39:10 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6E16B820257;
	Fri, 23 Feb 2024 15:39:10 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v2 4/6] ASoC: cs35l56: Apply amp calibration from EFI data
Date: Fri, 23 Feb 2024 15:39:08 +0000
Message-ID: <20240223153910.2063698-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223153910.2063698-1-rf@opensource.cirrus.com>
References: <20240223153910.2063698-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gmc7pLkI-qu8SCGe2isoKhg_Am9my50Y
X-Proofpoint-GUID: gmc7pLkI-qu8SCGe2isoKhg_Am9my50Y
X-Proofpoint-Spam-Reason: safe

If there are factory calibration settings in EFI, extract the
settings and write them to the firmware calibration controls.

This must be done after any firmware or coefficients have been
downloaded to the amp.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-sdw.c | 20 ++++++++++++++++
 sound/soc/codecs/cs35l56.c     | 44 +++++++++++++++++++++++++++++++---
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs35l56-sdw.c b/sound/soc/codecs/cs35l56-sdw.c
index ab960a1c171e..eaa4c706f3a2 100644
--- a/sound/soc/codecs/cs35l56-sdw.c
+++ b/sound/soc/codecs/cs35l56-sdw.c
@@ -161,6 +161,20 @@ static const struct regmap_bus cs35l56_regmap_bus_sdw = {
 	.val_format_endian_default = REGMAP_ENDIAN_BIG,
 };
 
+static int cs35l56_sdw_set_cal_index(struct cs35l56_private *cs35l56)
+{
+	int ret;
+
+	/* SoundWire UniqueId is used to index the calibration array */
+	ret = sdw_read_no_pm(cs35l56->sdw_peripheral, SDW_SCP_DEVID_0);
+	if (ret < 0)
+		return ret;
+
+	cs35l56->base.cal_index = ret & 0xf;
+
+	return 0;
+}
+
 static void cs35l56_sdw_init(struct sdw_slave *peripheral)
 {
 	struct cs35l56_private *cs35l56 = dev_get_drvdata(&peripheral->dev);
@@ -168,6 +182,12 @@ static void cs35l56_sdw_init(struct sdw_slave *peripheral)
 
 	pm_runtime_get_noresume(cs35l56->base.dev);
 
+	if (cs35l56->base.cal_index < 0) {
+		ret = cs35l56_sdw_set_cal_index(cs35l56);
+		if (ret < 0)
+			goto out;
+	}
+
 	regcache_cache_only(cs35l56->base.regmap, false);
 
 	ret = cs35l56_init(cs35l56);
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 2c1313e34cce..23da9b96d8a7 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -23,6 +23,7 @@
 #include <linux/soundwire/sdw.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <sound/cs-amp-lib.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -802,16 +803,44 @@ static struct snd_soc_dai_driver cs35l56_dai[] = {
 	}
 };
 
+static int cs35l56_write_cal(struct cs35l56_private *cs35l56)
+{
+	int ret;
+
+	if (cs35l56->base.secured || !cs35l56->base.cal_data_valid)
+		return -ENODATA;
+
+	ret = wm_adsp_run(&cs35l56->dsp);
+	if (ret)
+		return ret;
+
+	ret = cs_amp_write_cal_coeffs(&cs35l56->dsp.cs_dsp,
+				      &cs35l56_calibration_controls,
+				      &cs35l56->base.cal_data);
+
+	wm_adsp_stop(&cs35l56->dsp);
+
+	if (ret == 0)
+		dev_info(cs35l56->base.dev, "Calibration applied\n");
+
+	return ret;
+}
+
 static void cs35l56_reinit_patch(struct cs35l56_private *cs35l56)
 {
 	int ret;
 
 	/* Use wm_adsp to load and apply the firmware patch and coefficient files */
 	ret = wm_adsp_power_up(&cs35l56->dsp, true);
-	if (ret)
+	if (ret) {
 		dev_dbg(cs35l56->base.dev, "%s: wm_adsp_power_up ret %d\n", __func__, ret);
-	else
-		cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_REINIT);
+		return;
+	}
+
+	cs35l56_write_cal(cs35l56);
+
+	/* Always REINIT after applying patch or coefficients */
+	cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_REINIT);
 }
 
 static void cs35l56_patch(struct cs35l56_private *cs35l56, bool firmware_missing)
@@ -874,6 +903,9 @@ static void cs35l56_patch(struct cs35l56_private *cs35l56, bool firmware_missing
 			  CS35L56_FIRMWARE_MISSING);
 	cs35l56->base.fw_patched = true;
 
+	if (cs35l56_write_cal(cs35l56) == 0)
+		cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_REINIT);
+
 err_unlock:
 	mutex_unlock(&cs35l56->base.irq_lock);
 err:
@@ -1356,6 +1388,7 @@ int cs35l56_common_probe(struct cs35l56_private *cs35l56)
 
 	init_completion(&cs35l56->init_completion);
 	mutex_init(&cs35l56->base.irq_lock);
+	cs35l56->base.cal_index = -1;
 	cs35l56->speaker_id = -ENOENT;
 
 	dev_set_drvdata(cs35l56->base.dev, cs35l56);
@@ -1457,6 +1490,10 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	if (ret)
 		return ret;
 
+	ret = cs35l56_get_calibration(&cs35l56->base);
+	if (ret)
+		return ret;
+
 	if (!cs35l56->base.reset_gpio) {
 		dev_dbg(cs35l56->base.dev, "No reset gpio: using soft reset\n");
 		cs35l56->soft_resetting = true;
@@ -1541,6 +1578,7 @@ EXPORT_NS_GPL_DEV_PM_OPS(cs35l56_pm_ops_i2c_spi, SND_SOC_CS35L56_CORE) = {
 
 MODULE_DESCRIPTION("ASoC CS35L56 driver");
 MODULE_IMPORT_NS(SND_SOC_CS35L56_SHARED);
+MODULE_IMPORT_NS(SND_SOC_CS_AMP_LIB);
 MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
 MODULE_AUTHOR("Simon Trimmer <simont@opensource.cirrus.com>");
 MODULE_LICENSE("GPL");
-- 
2.30.2


