Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDCD7A898D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbjITQeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjITQeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:34:11 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3012E5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:34:03 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38K3qoWm031049;
        Wed, 20 Sep 2023 11:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=j/Ptjewaw3A0BXeVbV8OtcU77964m2/KvX903EwV4HE=; b=
        fLtzy4ynr2OM7EIBQ5g/12VWcKkKw9223q4+vt3Ox1w1BQ2hN4jrlkUdVz8XKwIR
        s7RY7npVzMkIkLbTszTEuO7XGlv6MTxzJ0DHM/WAvPfty/UbJNUI3N8WIIVcuLz+
        SHa2ijByGdE4sGTdJawEaYYLt5gkR9c9qIfoq1cH6F0bpd9dYA0OJl+9LhLeV5ME
        p39UMji7M+LMhmO5tJHJAyEi9+qe7J37T4BbEK7KsjP81wbbyK0rwQ4eAI+nF4NR
        97cVe+Vm2Y3Fdkw5RcEJNp4WYWA+cHSHl0AnFKKGg29j2l8RR+UVjKYDS9w8wN7e
        zTqUyQVp3W4HBQTui1V/VA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t59ry5sr2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 11:33:39 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 20 Sep
 2023 17:33:37 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Wed, 20 Sep 2023 17:33:37 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.135])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0698511CD;
        Wed, 20 Sep 2023 16:33:37 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v4 3/4] ALSA: hda: cs35l41: Support mute notifications for CS35L41 HDA
Date:   Wed, 20 Sep 2023 16:54:49 +0100
Message-ID: <20230920155450.576287-4-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920155450.576287-1-sbinding@opensource.cirrus.com>
References: <20230920155450.576287-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6mFPBcAVhjyNmHK_012-eT6R4rcULbJz
X-Proofpoint-ORIG-GUID: 6mFPBcAVhjyNmHK_012-eT6R4rcULbJz
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some laptops require a hardware based mute system, where when a hotkey
is pressed, it forces the amp to be muted.

For CS35L41, when the hotkey is pressed, an acpi notification is sent
to the CS35L41 Device Node. The driver needs to handle this notification
and call a _DSM function to retrieve the mute state.

Since the amp is only muted during playback, the driver will only mute
or unmute if playback is occurring, otherwise it will save the mute
state for when playback starts.

This uses the ACPI Notification mechanism, where a handler has been
registered in the component master, which notifies each amp through
the component binding.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 104 +++++++++++++++++++++++++++++++-----
 sound/pci/hda/cs35l41_hda.h |   3 ++
 2 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index c74faa2ff46c..7b56bceea9e8 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -33,6 +33,9 @@
 #define CAL_AMBIENT_DSP_CTL_NAME	"CAL_AMBIENT"
 #define CAL_DSP_CTL_TYPE		5
 #define CAL_DSP_CTL_ALG			205
+#define CS35L41_UUID			"50d90cdc-3de4-4f18-b528-c7fe3b71f40d"
+#define CS35L41_DSM_GET_MUTE		5
+#define CS35L41_NOTIFY_EVENT		0x91
 
 static bool firmware_autostart = 1;
 module_param(firmware_autostart, bool, 0444);
@@ -520,6 +523,31 @@ static void cs35l41_hda_play_start(struct device *dev)
 
 }
 
+static void cs35l41_mute(struct device *dev, bool mute)
+{
+	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+	struct regmap *reg = cs35l41->regmap;
+
+	dev_dbg(dev, "Mute(%d:%d) Playback Started: %d\n", mute, cs35l41->mute_override,
+		cs35l41->playback_started);
+
+	if (cs35l41->playback_started) {
+		if (mute || cs35l41->mute_override) {
+			dev_dbg(dev, "Muting\n");
+			regmap_multi_reg_write(reg, cs35l41_hda_mute, ARRAY_SIZE(cs35l41_hda_mute));
+		} else {
+			dev_dbg(dev, "Unmuting\n");
+			if (cs35l41->firmware_running) {
+				regmap_multi_reg_write(reg, cs35l41_hda_unmute_dsp,
+						ARRAY_SIZE(cs35l41_hda_unmute_dsp));
+			} else {
+				regmap_multi_reg_write(reg, cs35l41_hda_unmute,
+						ARRAY_SIZE(cs35l41_hda_unmute));
+			}
+		}
+	}
+}
+
 static void cs35l41_hda_play_done(struct device *dev)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
@@ -529,13 +557,7 @@ static void cs35l41_hda_play_done(struct device *dev)
 
 	cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 1,
 			      cs35l41->firmware_running);
-	if (cs35l41->firmware_running) {
-		regmap_multi_reg_write(reg, cs35l41_hda_unmute_dsp,
-				       ARRAY_SIZE(cs35l41_hda_unmute_dsp));
-	} else {
-		regmap_multi_reg_write(reg, cs35l41_hda_unmute,
-				       ARRAY_SIZE(cs35l41_hda_unmute));
-	}
+	cs35l41_mute(dev, false);
 }
 
 static void cs35l41_hda_pause_start(struct device *dev)
@@ -545,7 +567,7 @@ static void cs35l41_hda_pause_start(struct device *dev)
 
 	dev_dbg(dev, "Pause (Start)\n");
 
-	regmap_multi_reg_write(reg, cs35l41_hda_mute, ARRAY_SIZE(cs35l41_hda_mute));
+	cs35l41_mute(dev, true);
 	cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 0,
 			      cs35l41->firmware_running);
 }
@@ -1073,6 +1095,53 @@ static int cs35l41_create_controls(struct cs35l41_hda *cs35l41)
 	return 0;
 }
 
+static bool cs35l41_dsm_supported(acpi_handle handle, unsigned int commands)
+{
+	guid_t guid;
+
+	guid_parse(CS35L41_UUID, &guid);
+
+	return acpi_check_dsm(handle, &guid, 0, BIT(commands));
+}
+
+static int cs35l41_get_acpi_mute_state(struct cs35l41_hda *cs35l41, acpi_handle handle)
+{
+	guid_t guid;
+	union acpi_object *ret;
+	int mute = -ENODEV;
+
+	guid_parse(CS35L41_UUID, &guid);
+
+	if (cs35l41_dsm_supported(handle, CS35L41_DSM_GET_MUTE)) {
+		ret = acpi_evaluate_dsm(handle, &guid, 0, CS35L41_DSM_GET_MUTE, NULL);
+		mute = *ret->buffer.pointer;
+		dev_dbg(cs35l41->dev, "CS35L41_DSM_GET_MUTE: %d\n", mute);
+	}
+
+	dev_dbg(cs35l41->dev, "%s: %d\n", __func__, mute);
+
+	return mute;
+}
+
+static void cs35l41_acpi_device_notify(acpi_handle handle, u32 event, struct device *dev)
+{
+	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+	int mute;
+
+	if (event != CS35L41_NOTIFY_EVENT)
+		return;
+
+	mute = cs35l41_get_acpi_mute_state(cs35l41, handle);
+	if (mute < 0) {
+		dev_warn(cs35l41->dev, "Unable to retrieve mute state: %d\n", mute);
+		return;
+	}
+
+	dev_dbg(cs35l41->dev, "Requesting mute value: %d\n", mute);
+	cs35l41->mute_override = (mute > 0);
+	cs35l41_mute(cs35l41->dev, cs35l41->mute_override);
+}
+
 static int cs35l41_hda_bind(struct device *dev, struct device *master, void *master_data)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
@@ -1114,6 +1183,14 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 	comps->playback_hook = cs35l41_hda_playback_hook;
 	comps->pre_playback_hook = cs35l41_hda_pre_playback_hook;
 	comps->post_playback_hook = cs35l41_hda_post_playback_hook;
+	comps->acpi_notify = cs35l41_acpi_device_notify;
+	comps->adev = cs35l41->dacpi;
+
+	comps->acpi_notifications_supported = cs35l41_dsm_supported(acpi_device_handle(comps->adev),
+		CS35L41_DSM_GET_MUTE);
+
+	cs35l41->mute_override = cs35l41_get_acpi_mute_state(cs35l41,
+						acpi_device_handle(cs35l41->dacpi)) > 0;
 
 	mutex_unlock(&cs35l41->fw_mutex);
 
@@ -1387,8 +1464,8 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 		return -ENODEV;
 	}
 
+	cs35l41->dacpi = adev;
 	physdev = get_device(acpi_get_first_physical_node(adev));
-	acpi_dev_put(adev);
 
 	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
 	if (IS_ERR(sub))
@@ -1498,6 +1575,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	hw_cfg->valid = false;
 	hw_cfg->gpio1.valid = false;
 	hw_cfg->gpio2.valid = false;
+	acpi_dev_put(cs35l41->dacpi);
 put_physdev:
 	put_device(physdev);
 
@@ -1601,10 +1679,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	if (ret)
 		goto err;
 
-	ret = regmap_multi_reg_write(cs35l41->regmap, cs35l41_hda_mute,
-				     ARRAY_SIZE(cs35l41_hda_mute));
-	if (ret)
-		goto err;
+	cs35l41_mute(cs35l41->dev, true);
 
 	INIT_WORK(&cs35l41->fw_load_work, cs35l41_fw_load_work);
 	mutex_init(&cs35l41->fw_mutex);
@@ -1641,6 +1716,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	if (cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type))
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 	gpiod_put(cs35l41->reset_gpio);
+	acpi_dev_put(cs35l41->dacpi);
 	kfree(cs35l41->acpi_subsystem_id);
 
 	return ret;
@@ -1660,6 +1736,8 @@ void cs35l41_hda_remove(struct device *dev)
 
 	component_del(cs35l41->dev, &cs35l41_hda_comp_ops);
 
+	acpi_dev_put(cs35l41->dacpi);
+
 	pm_runtime_put_noidle(cs35l41->dev);
 
 	if (cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type))
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index b93bf762976e..ce3f2bb6ffd0 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -10,6 +10,7 @@
 #ifndef __CS35L41_HDA_H__
 #define __CS35L41_HDA_H__
 
+#include <linux/acpi.h>
 #include <linux/efi.h>
 #include <linux/regulator/consumer.h>
 #include <linux/gpio/consumer.h>
@@ -70,6 +71,8 @@ struct cs35l41_hda {
 	bool halo_initialized;
 	bool playback_started;
 	struct cs_dsp cs_dsp;
+	struct acpi_device *dacpi;
+	bool mute_override;
 };
 
 enum halo_state {
-- 
2.34.1

