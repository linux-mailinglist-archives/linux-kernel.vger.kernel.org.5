Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426A179C75F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjILG75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjILG7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:59:46 -0400
Received: from out28-53.mail.aliyun.com (out28-53.mail.aliyun.com [115.124.28.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E66110E6;
        Mon, 11 Sep 2023 23:59:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06719171|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00178282-0.000151054-0.998066;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.Ud9dp3R_1694501971;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Ud9dp3R_1694501971)
          by smtp.aliyun-inc.com;
          Tue, 12 Sep 2023 14:59:38 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        shumingf@realtek.com, ckeepax@opensource.cirrus.com,
        herve.codina@bootlin.com, wangweidong.a@awinic.com,
        13916275206@139.com, ryans.lee@analog.com,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        fido_max@inbox.ru, povik+lin@cutebit.org, arnd@arndb.de,
        harshit.m.mogalapalli@oracle.com, liweilei@awinic.com,
        yijiangtao@awinic.com, colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/5] ASoC: codecs: Change the aw88261 variable name and i2c driver name
Date:   Tue, 12 Sep 2023 14:58:51 +0800
Message-ID: <20230912065852.347000-5-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912065852.347000-1-wangweidong.a@awinic.com>
References: <20230912065852.347000-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

Change "sound-channel" to "awinic,audio-channel"
Change "aw88261_smartpa" to "aw88261"

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88261.c | 23 ++++++++++++-----------
 sound/soc/codecs/aw88261.h |  2 +-
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index a697b5006b45..d01c3ea1bb7d 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -477,7 +477,7 @@ static int aw88261_dev_reg_update(struct aw88261 *aw88261,
 	return ret;
 }
 
-static char *aw88261_dev_get_prof_name(struct aw_device *aw_dev, int index)
+static int aw88261_dev_get_prof_name(struct aw_device *aw_dev, int index, char **prof_name)
 {
 	struct aw_prof_info *prof_info = &aw_dev->prof_info;
 	struct aw_prof_desc *prof_desc;
@@ -485,12 +485,14 @@ static char *aw88261_dev_get_prof_name(struct aw_device *aw_dev, int index)
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
 
 static int aw88261_dev_get_prof_data(struct aw_device *aw_dev, int index,
@@ -515,8 +517,8 @@ static int aw88261_dev_fw_update(struct aw88261 *aw88261)
 	char *prof_name;
 	int ret;
 
-	prof_name = aw88261_dev_get_prof_name(aw_dev, aw_dev->prof_index);
-	if (!prof_name) {
+	ret = aw88261_dev_get_prof_name(aw_dev, aw_dev->prof_index, &prof_name);
+	if (ret) {
 		dev_err(aw_dev->dev, "get prof name failed");
 		return -EINVAL;
 	}
@@ -818,9 +820,8 @@ static int aw88261_profile_info(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
 	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(codec);
-	const char *prof_name;
-	char *name;
-	int count;
+	char *prof_name, *name;
+	int count, ret;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
@@ -839,8 +840,8 @@ static int aw88261_profile_info(struct snd_kcontrol *kcontrol,
 	name = uinfo->value.enumerated.name;
 	count = uinfo->value.enumerated.item;
 
-	prof_name = aw88261_dev_get_prof_name(aw88261->aw_pa, count);
-	if (!prof_name) {
+	ret = aw88261_dev_get_prof_name(aw88261->aw_pa, count, &prof_name);
+	if (ret) {
 		strscpy(uinfo->value.enumerated.name, "null",
 						strlen("null") + 1);
 		return 0;
@@ -1189,7 +1190,7 @@ static void aw88261_parse_channel_dt(struct aw88261 *aw88261)
 	u32 channel_value = AW88261_DEV_DEFAULT_CH;
 	u32 sync_enable = false;
 
-	of_property_read_u32(np, "sound-channel", &channel_value);
+	of_property_read_u32(np, "awinic,audio-channel", &channel_value);
 	of_property_read_u32(np, "sync-flag", &sync_enable);
 
 	aw_dev->channel = channel_value;
diff --git a/sound/soc/codecs/aw88261.h b/sound/soc/codecs/aw88261.h
index 4f3dbf438510..bd0841fa9b77 100644
--- a/sound/soc/codecs/aw88261.h
+++ b/sound/soc/codecs/aw88261.h
@@ -370,7 +370,7 @@
 #define AW88261_START_RETRIES		(5)
 #define AW88261_START_WORK_DELAY_MS	(0)
 
-#define AW88261_I2C_NAME		"aw88261_smartpa"
+#define AW88261_I2C_NAME		"aw88261"
 
 #define AW88261_RATES (SNDRV_PCM_RATE_8000_48000 | \
 			SNDRV_PCM_RATE_96000)
-- 
2.41.0

