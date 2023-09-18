Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154687A48E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241796AbjIRLyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241794AbjIRLyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:54:17 -0400
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CBA115;
        Mon, 18 Sep 2023 04:53:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00716367-0.000217502-0.992619;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.Ui7aPee_1695038001;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Ui7aPee_1695038001)
          by smtp.aliyun-inc.com;
          Mon, 18 Sep 2023 19:53:29 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        wangweidong.a@awinic.com, herve.codina@bootlin.com,
        shumingf@realtek.com, 13916275206@139.com, ryans.lee@analog.com,
        linus.walleij@linaro.org, ckeepax@opensource.cirrus.com,
        povik+lin@cutebit.org, arnd@arndb.de,
        harshit.m.mogalapalli@oracle.com, u.kleine-koenig@pengutronix.de,
        yang.lee@linux.alibaba.com, liweilei@awinic.com,
        yijiangtao@awinic.com, trix@redhat.com, colin.i.king@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/5] ASoC: codecs: Add code for bin parsing compatible with aw87390
Date:   Mon, 18 Sep 2023 19:52:53 +0800
Message-ID: <20230918115255.33171-4-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918115255.33171-1-wangweidong.a@awinic.com>
References: <20230918115255.33171-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

Add aw87390 compatible code to the aw88395_lib.c file
so that it can parse aw87390's bin file
Modify function return value
Remove the fade-enable property because other properties
already implement thi functionality.
Modify the transmission method of parameters.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88395/aw88395.c        |  9 ++---
 sound/soc/codecs/aw88395/aw88395.h        |  2 +-
 sound/soc/codecs/aw88395/aw88395_device.c | 47 ++++++-----------------
 sound/soc/codecs/aw88395/aw88395_device.h |  6 +--
 sound/soc/codecs/aw88395/aw88395_lib.c    | 25 +++++++-----
 sound/soc/codecs/aw88395/aw88395_reg.h    |  1 +
 6 files changed, 35 insertions(+), 55 deletions(-)

diff --git a/sound/soc/codecs/aw88395/aw88395.c b/sound/soc/codecs/aw88395/aw88395.c
index 9dcd75dd799a..77227c8f01f6 100644
--- a/sound/soc/codecs/aw88395/aw88395.c
+++ b/sound/soc/codecs/aw88395/aw88395.c
@@ -175,9 +175,8 @@ static int aw88395_profile_info(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
 	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
-	const char *prof_name;
-	char *name;
-	int count;
+	char *prof_name, *name;
+	int count, ret;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
@@ -196,8 +195,8 @@ static int aw88395_profile_info(struct snd_kcontrol *kcontrol,
 	name = uinfo->value.enumerated.name;
 	count = uinfo->value.enumerated.item;
 
-	prof_name = aw88395_dev_get_prof_name(aw88395->aw_pa, count);
-	if (!prof_name) {
+	ret = aw88395_dev_get_prof_name(aw88395->aw_pa, count, &prof_name);
+	if (ret) {
 		strscpy(uinfo->value.enumerated.name, "null",
 						strlen("null") + 1);
 		return 0;
diff --git a/sound/soc/codecs/aw88395/aw88395.h b/sound/soc/codecs/aw88395/aw88395.h
index 8036ba27f68d..c2a4f0cb8cd5 100644
--- a/sound/soc/codecs/aw88395/aw88395.h
+++ b/sound/soc/codecs/aw88395/aw88395.h
@@ -16,7 +16,7 @@
 
 #define AW88395_DSP_16_DATA_MASK		(0x0000ffff)
 
-#define AW88395_I2C_NAME			"aw88395_smartpa"
+#define AW88395_I2C_NAME			"aw88395"
 
 #define AW88395_RATES (SNDRV_PCM_RATE_8000_48000 | \
 			SNDRV_PCM_RATE_96000)
diff --git a/sound/soc/codecs/aw88395/aw88395_device.c b/sound/soc/codecs/aw88395/aw88395_device.c
index 33eda3741464..fd1f67d5f22f 100644
--- a/sound/soc/codecs/aw88395/aw88395_device.c
+++ b/sound/soc/codecs/aw88395/aw88395_device.c
@@ -297,9 +297,6 @@ static void aw_dev_fade_in(struct aw_device *aw_dev)
 	int fade_step = aw_dev->fade_step;
 	int i;
 
-	if (!aw_dev->fade_en)
-		return;
-
 	if (fade_step == 0 || aw_dev->fade_in_time == 0) {
 		aw_dev_set_volume(aw_dev, fade_in_vol);
 		return;
@@ -320,9 +317,6 @@ static void aw_dev_fade_out(struct aw_device *aw_dev)
 	int fade_step = aw_dev->fade_step;
 	int i;
 
-	if (!aw_dev->fade_en)
-		return;
-
 	if (fade_step == 0 || aw_dev->fade_out_time == 0) {
 		aw_dev_set_volume(aw_dev, AW88395_MUTE_VOL);
 		return;
@@ -1062,10 +1056,6 @@ static int aw_dev_update_reg_container(struct aw_device *aw_dev,
 		aw_dev_set_volume(aw_dev, vol_desc->ctl_volume);
 	}
 
-	/* keep min volume */
-	if (aw_dev->fade_en)
-		aw_dev_set_volume(aw_dev, AW88395_MUTE_VOL);
-
 	aw_dev_get_dsp_config(aw_dev, &aw_dev->dsp_cfg);
 
 	return ret;
@@ -1306,7 +1296,9 @@ int aw88395_dev_fw_update(struct aw_device *aw_dev, bool up_dsp_fw_en, bool forc
 		return -EPERM;
 	}
 
-	prof_name = aw88395_dev_get_prof_name(aw_dev, aw_dev->prof_index);
+	ret = aw88395_dev_get_prof_name(aw_dev, aw_dev->prof_index, &prof_name);
+	if (ret)
+		return ret;
 
 	dev_dbg(aw_dev->dev, "start update %s", prof_name);
 
@@ -1594,37 +1586,19 @@ static void aw88395_parse_channel_dt(struct aw_device *aw_dev)
 	u32 channel_value;
 	int ret;
 
-	ret = of_property_read_u32(np, "sound-channel", &channel_value);
+	ret = of_property_read_u32(np, "awinic,audio-channel", &channel_value);
 	if (ret) {
 		dev_dbg(aw_dev->dev,
-			"read sound-channel failed,use default 0");
+			"read audio-channel failed,use default 0");
 		aw_dev->channel = AW88395_DEV_DEFAULT_CH;
 		return;
 	}
 
-	dev_dbg(aw_dev->dev, "read sound-channel value is: %d",
+	dev_dbg(aw_dev->dev, "read audio-channel value is: %d",
 			channel_value);
 	aw_dev->channel = channel_value;
 }
 
-static void aw88395_parse_fade_enable_dt(struct aw_device *aw_dev)
-{
-	struct device_node *np = aw_dev->dev->of_node;
-	u32 fade_en;
-	int ret;
-
-	ret = of_property_read_u32(np, "fade-enable", &fade_en);
-	if (ret) {
-		dev_dbg(aw_dev->dev,
-			"read fade-enable failed, close fade_in_out");
-		fade_en = AW88395_FADE_IN_OUT_DEFAULT;
-	}
-
-	dev_dbg(aw_dev->dev, "read fade-enable value is: %d", fade_en);
-
-	aw_dev->fade_en = fade_en;
-}
-
 static int aw_dev_init(struct aw_device *aw_dev)
 {
 	aw_dev->chip_id = AW88395_CHIP_ID;
@@ -1639,7 +1613,6 @@ static int aw_dev_init(struct aw_device *aw_dev)
 	aw_dev->fade_step = AW88395_VOLUME_STEP_DB;
 	aw_dev->volume_desc.ctl_volume = AW88395_VOL_DEFAULT_VALUE;
 	aw88395_parse_channel_dt(aw_dev);
-	aw88395_parse_fade_enable_dt(aw_dev);
 
 	return 0;
 }
@@ -1673,7 +1646,7 @@ int aw88395_dev_set_profile_index(struct aw_device *aw_dev, int index)
 }
 EXPORT_SYMBOL_GPL(aw88395_dev_set_profile_index);
 
-char *aw88395_dev_get_prof_name(struct aw_device *aw_dev, int index)
+int aw88395_dev_get_prof_name(struct aw_device *aw_dev, int index, char **prof_name)
 {
 	struct aw_prof_info *prof_info = &aw_dev->prof_info;
 	struct aw_prof_desc *prof_desc;
@@ -1681,12 +1654,14 @@ char *aw88395_dev_get_prof_name(struct aw_device *aw_dev, int index)
 	if ((index >= aw_dev->prof_info.count) || (index < 0)) {
 		dev_err(aw_dev->dev, "index[%d] overflow count[%d]",
 			index, aw_dev->prof_info.count);
-		return NULL;
+		return -EINVAL;
 	}
 
 	prof_desc = &aw_dev->prof_info.prof_desc[index];
 
-	return prof_info->prof_name_list[prof_desc->id];
+	*prof_name = prof_info->prof_name_list[prof_desc->id];
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(aw88395_dev_get_prof_name);
 
diff --git a/sound/soc/codecs/aw88395/aw88395_device.h b/sound/soc/codecs/aw88395/aw88395_device.h
index caf730753167..791c8c106557 100644
--- a/sound/soc/codecs/aw88395/aw88395_device.h
+++ b/sound/soc/codecs/aw88395/aw88395_device.h
@@ -141,6 +141,7 @@ struct aw_device {
 	unsigned char prof_cur;
 	unsigned char prof_index;
 	unsigned char dsp_crc_st;
+	unsigned char dsp_cfg;
 	u16 chip_id;
 
 	unsigned int channel;
@@ -151,9 +152,6 @@ struct aw_device {
 	struct regmap *regmap;
 	char *acf;
 
-	u32 fade_en;
-	unsigned char dsp_cfg;
-
 	u32 dsp_fw_len;
 	u32 dsp_cfg_len;
 	u8 platform;
@@ -183,7 +181,7 @@ int aw88395_dev_fw_update(struct aw_device *aw_dev, bool up_dsp_fw_en, bool forc
 void aw88395_dev_set_volume(struct aw_device *aw_dev, unsigned short set_vol);
 int aw88395_dev_get_prof_data(struct aw_device *aw_dev, int index,
 			struct aw_prof_desc **prof_desc);
-char *aw88395_dev_get_prof_name(struct aw_device *aw_dev, int index);
+int aw88395_dev_get_prof_name(struct aw_device *aw_dev, int index, char **prof_name);
 int aw88395_dev_set_profile_index(struct aw_device *aw_dev, int index);
 int aw88395_dev_get_profile_index(struct aw_device *aw_dev);
 int aw88395_dev_get_profile_count(struct aw_device *aw_dev);
diff --git a/sound/soc/codecs/aw88395/aw88395_lib.c b/sound/soc/codecs/aw88395/aw88395_lib.c
index 8ee1baa03269..a0a429ca9768 100644
--- a/sound/soc/codecs/aw88395/aw88395_lib.c
+++ b/sound/soc/codecs/aw88395/aw88395_lib.c
@@ -452,12 +452,16 @@ static int aw_dev_parse_reg_bin_with_hdr(struct aw_device *aw_dev,
 	if ((aw_bin->all_bin_parse_num != 1) ||
 		(aw_bin->header_info[0].bin_data_type != DATA_TYPE_REGISTER)) {
 		dev_err(aw_dev->dev, "bin num or type error");
+		ret = -EINVAL;
 		goto parse_bin_failed;
 	}
 
-	if (aw_bin->header_info[0].valid_data_len % 4) {
-		dev_err(aw_dev->dev, "bin data len get error!");
-		goto parse_bin_failed;
+	if (aw_dev->chip_id == AW88261_CHIP_ID) {
+		if (aw_bin->header_info[0].valid_data_len % 4) {
+			dev_err(aw_dev->dev, "bin data len get error!");
+			ret = -EINVAL;
+			goto parse_bin_failed;
+		}
 	}
 
 	prof_desc->sec_desc[AW88395_DATA_TYPE_REG].data =
@@ -579,9 +583,9 @@ static int aw_dev_parse_dev_default_type(struct aw_device *aw_dev,
 }
 
 static int aw88261_dev_cfg_get_valid_prof(struct aw_device *aw_dev,
-				struct aw_all_prof_info all_prof_info)
+				struct aw_all_prof_info *all_prof_info)
 {
-	struct aw_prof_desc *prof_desc = all_prof_info.prof_desc;
+	struct aw_prof_desc *prof_desc = all_prof_info->prof_desc;
 	struct aw_prof_info *prof_info = &aw_dev->prof_info;
 	int num = 0;
 	int i;
@@ -621,9 +625,9 @@ static int aw88261_dev_cfg_get_valid_prof(struct aw_device *aw_dev,
 }
 
 static int aw88395_dev_cfg_get_valid_prof(struct aw_device *aw_dev,
-				struct aw_all_prof_info all_prof_info)
+				struct aw_all_prof_info *all_prof_info)
 {
-	struct aw_prof_desc *prof_desc = all_prof_info.prof_desc;
+	struct aw_prof_desc *prof_desc = all_prof_info->prof_desc;
 	struct aw_prof_info *prof_info = &aw_dev->prof_info;
 	struct aw_sec_data_desc *sec_desc;
 	int num = 0;
@@ -701,12 +705,13 @@ static int aw_dev_load_cfg_by_hdr(struct aw_device *aw_dev,
 
 	switch (aw_dev->chip_id) {
 	case AW88395_CHIP_ID:
-		ret = aw88395_dev_cfg_get_valid_prof(aw_dev, *all_prof_info);
+		ret = aw88395_dev_cfg_get_valid_prof(aw_dev, all_prof_info);
 		if (ret < 0)
 			goto exit;
 		break;
 	case AW88261_CHIP_ID:
-		ret = aw88261_dev_cfg_get_valid_prof(aw_dev, *all_prof_info);
+	case AW87390_CHIP_ID:
+		ret = aw88261_dev_cfg_get_valid_prof(aw_dev, all_prof_info);
 		if (ret < 0)
 			goto exit;
 		break;
@@ -799,6 +804,7 @@ static int aw_get_dev_scene_count_v1(struct aw_device *aw_dev, struct aw_contain
 		ret = 0;
 		break;
 	case AW88261_CHIP_ID:
+	case AW87390_CHIP_ID:
 		for (i = 0; i < cfg_hdr->ddt_num; ++i) {
 			if (((cfg_dde[i].data_type == ACF_SEC_TYPE_REG) ||
 			     (cfg_dde[i].data_type == ACF_SEC_TYPE_HDR_REG)) &&
@@ -839,6 +845,7 @@ static int aw_get_default_scene_count_v1(struct aw_device *aw_dev,
 		ret = 0;
 		break;
 	case AW88261_CHIP_ID:
+	case AW87390_CHIP_ID:
 		for (i = 0; i < cfg_hdr->ddt_num; ++i) {
 			if (((cfg_dde[i].data_type == ACF_SEC_TYPE_REG) ||
 			     (cfg_dde[i].data_type == ACF_SEC_TYPE_HDR_REG)) &&
diff --git a/sound/soc/codecs/aw88395/aw88395_reg.h b/sound/soc/codecs/aw88395/aw88395_reg.h
index e7a7c02efaf3..d0a273387313 100644
--- a/sound/soc/codecs/aw88395/aw88395_reg.h
+++ b/sound/soc/codecs/aw88395/aw88395_reg.h
@@ -97,6 +97,7 @@
 enum aw88395_id {
 	AW88395_CHIP_ID = 0x2049,
 	AW88261_CHIP_ID = 0x2113,
+	AW87390_CHIP_ID = 0x76,
 };
 
 #define AW88395_REG_MAX		(0x7D)
-- 
2.41.0

