Return-Path: <linux-kernel+bounces-165178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA5C8B891C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5231C21DE3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFEF5C603;
	Wed,  1 May 2024 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Pmmg8EE6"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF9448CE0;
	Wed,  1 May 2024 11:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714562302; cv=none; b=At4i6PtlnOcLQSvMFe4Bw+XbfZdUuDwtQNQvfHOtsdccu8WmvEgRcD6vNa2VY0rHey3uhe1jfETcZ/Ehrdd+ohML9ibNoT3Ha4i9nJiG2qEaJiqRgDh+2J7if0W937NVtIHr3OixGGJ5Mscb+OG7uLWGkbaJ2wzGYv0bn7x/TmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714562302; c=relaxed/simple;
	bh=gVtZDWeL0GnKDnv1K0d/qPXgVxF/piULjqvfFsfeBlM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uONMhYh4CaqRoRdPf4Nd2Kt2R2auboW/P79nkC7rWQ2HBtARj9sWdfdlTrWtgra4wgTMGj3hy8jqi1goN7/TSuxP06EHZUtWXWWMo4UZewOdN3kecakcmDkDk+mXq8V38s9NBwDBf/yiVTZlFNVJF0kqhQQFfbVUvLsPduCF1vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Pmmg8EE6; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4417Um2j022501;
	Wed, 1 May 2024 06:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=0
	qg2zDno4xP0F8pSdjIJ1Qbjok+FbP9CVsl5H/bP8FA=; b=Pmmg8EE6t5AwdNNCl
	ZaX3f8kQXvBPyuXt2veLchRouIofE3yusKtreKQ8a64wMNv6We4RE86zs6zhVZzd
	s4dcbVDYvI1RkyHB0wb/TwYuTUaQeLCZdDfBcS0g8RYqT0t8QUo/6viaYQBblnZF
	p8fOnf31vGt6nTb+Veb+dK4KvnhJ7xWePnauubYx3ZJ4ltXWrlAk++3Bly7vwNlF
	mhxekI7S1CQCZZKqPhILDSbxJonImsBbq42v+KJLtt4ft8+srXV89dqk6IZ9C3Jw
	TU1fiHYcK/R8fc2QldbsOsH32Otpz+TbllfCBddi+Vamw8qC6JSjw+M9oBTHYX1h
	cp0FQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xrxry4f6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 06:18:08 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 1 May 2024
 12:18:05 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 1 May 2024 12:18:05 +0100
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.64.231])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 7A0C4820249;
	Wed,  1 May 2024 11:18:05 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: cs35l56: Perform firmware download in the background
Date: Wed, 1 May 2024 12:17:55 +0100
Message-ID: <20240501111755.21231-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3jV06D9VjIG1xtvpJ7uynvOvj50QpCJV
X-Proofpoint-GUID: 3jV06D9VjIG1xtvpJ7uynvOvj50QpCJV
X-Proofpoint-Spam-Reason: safe

It is possible that during system boot when there multiple devices
attempting simultaneous initialization on a slow control bus the
download of firmware and tuning data may take a user perceivable amount
of time.

Adopt a pattern used in the ASoC driver and perform this activity in a
background thread so that interactive performance is not impaired.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda.c | 89 ++++++++++++++++++++++++++++++-------
 sound/pci/hda/cs35l56_hda.h |  4 ++
 2 files changed, 76 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 1a3f84599cb5..042c2407c007 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -13,6 +13,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 #include <sound/core.h>
 #include <sound/cs-amp-lib.h>
 #include <sound/hda_codec.h>
@@ -50,11 +51,19 @@ static const struct reg_sequence cs35l56_hda_dai_config[] = {
 
 };
 
+static void cs35l56_hda_wait_dsp_ready(struct cs35l56_hda *cs35l56)
+{
+	/* Wait for patching to complete */
+	flush_work(&cs35l56->dsp_work);
+}
+
 static void cs35l56_hda_play(struct cs35l56_hda *cs35l56)
 {
 	unsigned int val;
 	int ret;
 
+	cs35l56_hda_wait_dsp_ready(cs35l56);
+
 	pm_runtime_get_sync(cs35l56->base.dev);
 	ret = cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_PLAY);
 	if (ret == 0) {
@@ -180,6 +189,8 @@ static int cs35l56_hda_mixer_get(struct snd_kcontrol *kcontrol,
 	unsigned int reg_val;
 	int i;
 
+	cs35l56_hda_wait_dsp_ready(cs35l56);
+
 	regmap_read(cs35l56->base.regmap, kcontrol->private_value, &reg_val);
 	reg_val &= CS35L56_ASP_TXn_SRC_MASK;
 
@@ -203,6 +214,8 @@ static int cs35l56_hda_mixer_put(struct snd_kcontrol *kcontrol,
 	if (item >= CS35L56_NUM_INPUT_SRC)
 		return -EINVAL;
 
+	cs35l56_hda_wait_dsp_ready(cs35l56);
+
 	regmap_update_bits_check(cs35l56->base.regmap, kcontrol->private_value,
 				 CS35L56_INPUT_MASK, cs35l56_tx_input_values[item],
 				 &changed);
@@ -227,6 +240,8 @@ static int cs35l56_hda_posture_get(struct snd_kcontrol *kcontrol,
 	unsigned int pos;
 	int ret;
 
+	cs35l56_hda_wait_dsp_ready(cs35l56);
+
 	ret = regmap_read(cs35l56->base.regmap, CS35L56_MAIN_POSTURE_NUMBER, &pos);
 	if (ret)
 		return ret;
@@ -248,6 +263,8 @@ static int cs35l56_hda_posture_put(struct snd_kcontrol *kcontrol,
 	    (pos > CS35L56_MAIN_POSTURE_MAX))
 		return -EINVAL;
 
+	cs35l56_hda_wait_dsp_ready(cs35l56);
+
 	ret = regmap_update_bits_check(cs35l56->base.regmap,
 				       CS35L56_MAIN_POSTURE_NUMBER,
 				       CS35L56_MAIN_POSTURE_MASK,
@@ -291,6 +308,8 @@ static int cs35l56_hda_vol_get(struct snd_kcontrol *kcontrol,
 	int vol;
 	int ret;
 
+	cs35l56_hda_wait_dsp_ready(cs35l56);
+
 	ret = regmap_read(cs35l56->base.regmap, CS35L56_MAIN_RENDER_USER_VOLUME, &raw_vol);
 
 	if (ret)
@@ -323,6 +342,8 @@ static int cs35l56_hda_vol_put(struct snd_kcontrol *kcontrol,
 	raw_vol = (vol + CS35L56_MAIN_RENDER_USER_VOLUME_MIN) <<
 		  CS35L56_MAIN_RENDER_USER_VOLUME_SHIFT;
 
+	cs35l56_hda_wait_dsp_ready(cs35l56);
+
 	ret = regmap_update_bits_check(cs35l56->base.regmap,
 				       CS35L56_MAIN_RENDER_USER_VOLUME,
 				       CS35L56_MAIN_RENDER_USER_VOLUME_MASK,
@@ -539,8 +560,9 @@ static void cs35l56_hda_release_firmware_files(const struct firmware *wmfw_firmw
 	kfree(coeff_filename);
 }
 
-static void cs35l56_hda_add_dsp_controls(struct cs35l56_hda *cs35l56)
+static void cs35l56_hda_create_dsp_controls_work(struct work_struct *work)
 {
+	struct cs35l56_hda *cs35l56 = container_of(work, struct cs35l56_hda, control_work);
 	struct hda_cs_dsp_ctl_info info;
 
 	info.device_name = cs35l56->amp_name;
@@ -566,7 +588,7 @@ static void cs35l56_hda_apply_calibration(struct cs35l56_hda *cs35l56)
 		dev_info(cs35l56->base.dev, "Calibration applied\n");
 }
 
-static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
+static void cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 {
 	const struct firmware *coeff_firmware = NULL;
 	const struct firmware *wmfw_firmware = NULL;
@@ -574,15 +596,27 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	char *wmfw_filename = NULL;
 	unsigned int preloaded_fw_ver;
 	bool firmware_missing;
-	int ret = 0;
+	bool add_dsp_controls_required = false;
+	int ret;
 
-	/* Prepare for a new DSP power-up */
+	/*
+	 * Prepare for a new DSP power-up. If the DSP has had firmware
+	 * downloaded previously then it needs to be powered down so that it
+	 * can be updated and if hadn't been patched before then the controls
+	 * will need to be added once firmware download succeeds.
+	 */
 	if (cs35l56->base.fw_patched)
 		cs_dsp_power_down(&cs35l56->cs_dsp);
+	else
+		add_dsp_controls_required = true;
 
 	cs35l56->base.fw_patched = false;
 
-	pm_runtime_get_sync(cs35l56->base.dev);
+	ret = pm_runtime_resume_and_get(cs35l56->base.dev);
+	if (ret < 0) {
+		dev_err(cs35l56->base.dev, "Failed to resume and get %d\n", ret);
+		return;
+	}
 
 	/*
 	 * The firmware can only be upgraded if it is currently running
@@ -606,7 +640,6 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	 */
 	if (!coeff_firmware && firmware_missing) {
 		dev_err(cs35l56->base.dev, ".bin file required but not found\n");
-		ret = -ENOENT;
 		goto err_fw_release;
 	}
 
@@ -657,6 +690,15 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 			  CS35L56_FIRMWARE_MISSING);
 	cs35l56->base.fw_patched = true;
 
+	/*
+	 * Adding controls is deferred to prevent a lock inversion - ALSA takes
+	 * the controls_rwsem when adding a control, the get() / put()
+	 * functions of a control are called holding controls_rwsem and those
+	 * that depend on running firmware wait for dsp_work() to complete.
+	 */
+	if (add_dsp_controls_required)
+		queue_work(cs35l56->dsp_wq, &cs35l56->control_work);
+
 	ret = cs_dsp_run(&cs35l56->cs_dsp);
 	if (ret)
 		dev_dbg(cs35l56->base.dev, "%s: cs_dsp_run ret %d\n", __func__, ret);
@@ -676,15 +718,19 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 					   coeff_firmware, coeff_filename);
 err_pm_put:
 	pm_runtime_put(cs35l56->base.dev);
+}
 
-	return ret;
+static void cs35l56_hda_dsp_work(struct work_struct *work)
+{
+	struct cs35l56_hda *cs35l56 = container_of(work, struct cs35l56_hda, dsp_work);
+
+	cs35l56_hda_fw_load(cs35l56);
 }
 
 static int cs35l56_hda_bind(struct device *dev, struct device *master, void *master_data)
 {
 	struct cs35l56_hda *cs35l56 = dev_get_drvdata(dev);
 	struct hda_component *comps = master_data;
-	int ret;
 
 	if (!comps || cs35l56->index < 0 || cs35l56->index >= HDA_MAX_COMPONENTS)
 		return -EINVAL;
@@ -698,12 +744,9 @@ static int cs35l56_hda_bind(struct device *dev, struct device *master, void *mas
 	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
 	comps->playback_hook = cs35l56_hda_playback_hook;
 
-	ret = cs35l56_hda_fw_load(cs35l56);
-	if (ret)
-		return ret;
+	queue_work(cs35l56->dsp_wq, &cs35l56->dsp_work);
 
 	cs35l56_hda_create_controls(cs35l56);
-	cs35l56_hda_add_dsp_controls(cs35l56);
 
 #if IS_ENABLED(CONFIG_SND_DEBUG)
 	cs35l56->debugfs_root = debugfs_create_dir(dev_name(cs35l56->base.dev), sound_debugfs_root);
@@ -720,6 +763,9 @@ static void cs35l56_hda_unbind(struct device *dev, struct device *master, void *
 	struct cs35l56_hda *cs35l56 = dev_get_drvdata(dev);
 	struct hda_component *comps = master_data;
 
+	cancel_work_sync(&cs35l56->dsp_work);
+	cancel_work_sync(&cs35l56->control_work);
+
 	cs35l56_hda_remove_controls(cs35l56);
 
 #if IS_ENABLED(CONFIG_SND_DEBUG)
@@ -747,6 +793,10 @@ static int cs35l56_hda_system_suspend(struct device *dev)
 {
 	struct cs35l56_hda *cs35l56 = dev_get_drvdata(dev);
 
+	cs35l56_hda_wait_dsp_ready(cs35l56);
+
+	flush_work(&cs35l56->control_work);
+
 	if (cs35l56->playing)
 		cs35l56_hda_pause(cs35l56);
 
@@ -842,11 +892,8 @@ static int cs35l56_hda_system_resume(struct device *dev)
 
 	ret = cs35l56_is_fw_reload_needed(&cs35l56->base);
 	dev_dbg(cs35l56->base.dev, "fw_reload_needed: %d\n", ret);
-	if (ret > 0) {
-		ret = cs35l56_hda_fw_load(cs35l56);
-		if (ret)
-			return ret;
-	}
+	if (ret > 0)
+		queue_work(cs35l56->dsp_wq, &cs35l56->dsp_work);
 
 	if (cs35l56->playing)
 		cs35l56_hda_play(cs35l56);
@@ -964,6 +1011,14 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 	mutex_init(&cs35l56->base.irq_lock);
 	dev_set_drvdata(cs35l56->base.dev, cs35l56);
 
+	cs35l56->dsp_wq = create_singlethread_workqueue("cs35l56-dsp");
+	if (!cs35l56->dsp_wq) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	INIT_WORK(&cs35l56->dsp_work, cs35l56_hda_dsp_work);
+	INIT_WORK(&cs35l56->control_work, cs35l56_hda_create_dsp_controls_work);
+
 	ret = cs35l56_hda_read_acpi(cs35l56, hid, id);
 	if (ret)
 		goto err;
diff --git a/sound/pci/hda/cs35l56_hda.h b/sound/pci/hda/cs35l56_hda.h
index 464e4aa63cd1..d207e4e0d167 100644
--- a/sound/pci/hda/cs35l56_hda.h
+++ b/sound/pci/hda/cs35l56_hda.h
@@ -14,6 +14,7 @@
 #include <linux/firmware/cirrus/cs_dsp.h>
 #include <linux/firmware/cirrus/wmfw.h>
 #include <linux/regulator/consumer.h>
+#include <linux/workqueue.h>
 #include <sound/cs35l56.h>
 
 struct dentry;
@@ -21,6 +22,9 @@ struct dentry;
 struct cs35l56_hda {
 	struct cs35l56_base base;
 	struct hda_codec *codec;
+	struct work_struct dsp_work;
+	struct work_struct control_work;
+	struct workqueue_struct *dsp_wq;
 
 	int index;
 	const char *system_name;
-- 
2.34.1


