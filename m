Return-Path: <linux-kernel+bounces-74958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E27C85E079
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796701F2505D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A9B8062B;
	Wed, 21 Feb 2024 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cyQt60MP"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86BD7FBC8;
	Wed, 21 Feb 2024 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527927; cv=none; b=sy3nLoMKmv3FnOmT2FNJYGYeSRynxXLm2S5Hw/Lusl2IliBxasvtjkJKhZdEPn57BjLFK/yshCJgT9bmt0m55F592ybjZUCss59TIEXgBguI3ElrffzgPbqAmR6++Vpgxb0kUdO+eDcCcTF2KhbkjhcP881v1DElBTCjRNVijQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527927; c=relaxed/simple;
	bh=u8i+ZnlB55tkVJL4SKf/DyIo9KYqNTXHQ9mCewQrFTA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIwDmOHbRHkIkTEyT9O6R9T4QtO74/+3y7PgTLt8VXVbCM9NxitNeUubK20w1onP9aaD9zR5QvYeTOtTnHkClzk1WubhPIvJZQPHlFxjue4jdxsKgc0wnwOWGrYgJCwOur08ocE+eet/KkvgO9m+vMIrSceLWexhE1w0KZ4OfM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cyQt60MP; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LCUQsJ011338;
	Wed, 21 Feb 2024 09:05:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=hfJuyJkb/UeH7E/1q9QsoAdADQ7qN6nCp5C5HIbEbi0=; b=
	cyQt60MPolxCa0Xnl9zeUX/+5rkIhEp2JpUq4x6bgDTbx/u+I392COU0wPh+Xuox
	QJDmMGZVO5QkFibyL69MMJENpwREyWKuS2Dvdk4xRiEOb33izezOo3UVVjYpmDgv
	q1HqlcFMAvHB5WGvR1fK3H48XzeC6TQ7Tm/WP1NHYAwjiUAcz6lRVX682jIer9AL
	74Xe5wpswW9tStnTrUbDZciX05VAoDkwsvqrWbqG0NClh84bas1xd3TshRfaBXe7
	32+FPl1XItxZeICl15/CLY35KMR0SCvfwzaga+BECu/GeMtm3f3dK++nSdJdAf6v
	+ac7Y3AvPhoECTIB8iDdRA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wd205h4tk-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 09:05:12 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 15:05:07 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 21 Feb 2024 15:05:07 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 454D2820258;
	Wed, 21 Feb 2024 15:05:07 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 6/9] ASoC: cs35l56: Apply amp calibration from EFI data
Date: Wed, 21 Feb 2024 15:05:04 +0000
Message-ID: <20240221150507.1039979-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240221150507.1039979-1-rf@opensource.cirrus.com>
References: <20240221150507.1039979-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: V0vilrXqH8-PFut6s-PYWXt6VIiO0_CD
X-Proofpoint-GUID: V0vilrXqH8-PFut6s-PYWXt6VIiO0_CD
X-Proofpoint-Spam-Reason: safe

If there are factory calibration settings in EFI, extract the
settings and write them to the firmware calibration controls.

This must be done after any firmware or coefficients have been
downloaded to the amp.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-sdw.c | 20 ++++++++++++++++
 sound/soc/codecs/cs35l56.c     | 43 +++++++++++++++++++++++++++++++---
 2 files changed, 60 insertions(+), 3 deletions(-)

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
index 6dd0319bc843..73cc123db567 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -802,16 +802,44 @@ static struct snd_soc_dai_driver cs35l56_dai[] = {
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
+	ret = cs_amp_write_cal_coeffs(&cs35l56->dsp,
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
@@ -874,6 +902,9 @@ static void cs35l56_patch(struct cs35l56_private *cs35l56, bool firmware_missing
 			  CS35L56_FIRMWARE_MISSING);
 	cs35l56->base.fw_patched = true;
 
+	if (cs35l56_write_cal(cs35l56) == 0)
+		cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_REINIT);
+
 err_unlock:
 	mutex_unlock(&cs35l56->base.irq_lock);
 err:
@@ -1356,6 +1387,7 @@ int cs35l56_common_probe(struct cs35l56_private *cs35l56)
 
 	init_completion(&cs35l56->init_completion);
 	mutex_init(&cs35l56->base.irq_lock);
+	cs35l56->base.cal_index = -1;
 	cs35l56->speaker_id = -ENOENT;
 
 	dev_set_drvdata(cs35l56->base.dev, cs35l56);
@@ -1457,6 +1489,10 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	if (ret)
 		return ret;
 
+	ret = cs35l56_get_calibration(&cs35l56->base);
+	if (ret)
+		return ret;
+
 	if (!cs35l56->base.reset_gpio) {
 		dev_dbg(cs35l56->base.dev, "No reset gpio: using soft reset\n");
 		cs35l56->soft_resetting = true;
@@ -1541,6 +1577,7 @@ EXPORT_NS_GPL_DEV_PM_OPS(cs35l56_pm_ops_i2c_spi, SND_SOC_CS35L56_CORE) = {
 
 MODULE_DESCRIPTION("ASoC CS35L56 driver");
 MODULE_IMPORT_NS(SND_SOC_CS35L56_SHARED);
+MODULE_IMPORT_NS(SND_SOC_CS_AMP_LIB);
 MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
 MODULE_AUTHOR("Simon Trimmer <simont@opensource.cirrus.com>");
 MODULE_LICENSE("GPL");
-- 
2.30.2


