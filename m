Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F599767D8C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjG2JOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjG2JOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:14:20 -0400
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A86E55B6;
        Sat, 29 Jul 2023 02:13:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00156891-6.88847e-05-0.998362;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.U3WkWlv_1690621953;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.U3WkWlv_1690621953)
          by smtp.aliyun-inc.com;
          Sat, 29 Jul 2023 17:12:36 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        wangweidong.a@awinic.com, shumingf@realtek.com,
        ryans.lee@analog.com, 13916275206@139.com,
        herve.codina@bootlin.com, ckeepax@opensource.cirrus.com,
        doug@schmorgal.com, fido_max@inbox.ru, povik+lin@cutebit.org,
        liweilei@awinic.com, yijiangtao@awinic.com, colin.i.king@gmail.com,
        trix@redhat.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhangjianming@awinic.com
Subject: [PATCH V3 2/5] ASoC: codecs: Add code for bin parsing compatible with aw88261
Date:   Sat, 29 Jul 2023 17:12:20 +0800
Message-ID: <20230729091223.193466-3-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230729091223.193466-1-wangweidong.a@awinic.com>
References: <20230729091223.193466-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

Add aw88261 compatible code to the aw88395_lib.c file
so that it can parse aw88261's bin file.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88395/aw88395_lib.c | 193 ++++++++++++++++++++++---
 sound/soc/codecs/aw88395/aw88395_reg.h |   1 +
 2 files changed, 177 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/aw88395/aw88395_lib.c b/sound/soc/codecs/aw88395/aw88395_lib.c
index 05bcf49da857..695ddbc2fa76 100644
--- a/sound/soc/codecs/aw88395/aw88395_lib.c
+++ b/sound/soc/codecs/aw88395/aw88395_lib.c
@@ -11,6 +11,7 @@
 #include <linux/i2c.h>
 #include "aw88395_lib.h"
 #include "aw88395_device.h"
+#include "aw88395_reg.h"
 
 #define AW88395_CRC8_POLYNOMIAL 0x8C
 DECLARE_CRC8_TABLE(aw_crc8_table);
@@ -429,6 +430,53 @@ static int aw_dev_prof_parse_multi_bin(struct aw_device *aw_dev, unsigned char *
 	return ret;
 }
 
+static int aw_dev_parse_reg_bin_with_hdr(struct aw_device *aw_dev,
+			uint8_t *data, uint32_t data_len, struct aw_prof_desc *prof_desc)
+{
+	struct aw_bin *aw_bin;
+	int ret;
+
+	aw_bin = devm_kzalloc(aw_dev->dev, data_len + sizeof(struct aw_bin), GFP_KERNEL);
+	if (!aw_bin)
+		return -ENOMEM;
+
+	aw_bin->info.len = data_len;
+	memcpy(aw_bin->info.data, data, data_len);
+
+	ret = aw_parsing_bin_file(aw_dev, aw_bin);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "parse bin failed");
+		goto parse_bin_failed;
+	}
+
+	if ((aw_bin->all_bin_parse_num != 1) ||
+		(aw_bin->header_info[0].bin_data_type != DATA_TYPE_REGISTER)) {
+		dev_err(aw_dev->dev, "bin num or type error");
+		goto parse_bin_failed;
+	}
+
+	if (aw_bin->header_info[0].valid_data_len % 4) {
+		dev_err(aw_dev->dev, "bin data len get error!");
+		goto parse_bin_failed;
+	}
+
+	prof_desc->sec_desc[AW88395_DATA_TYPE_REG].data =
+				data + aw_bin->header_info[0].valid_data_addr;
+	prof_desc->sec_desc[AW88395_DATA_TYPE_REG].len =
+				aw_bin->header_info[0].valid_data_len;
+	prof_desc->prof_st = AW88395_PROFILE_OK;
+
+	devm_kfree(aw_dev->dev, aw_bin);
+	aw_bin = NULL;
+
+	return 0;
+
+parse_bin_failed:
+	devm_kfree(aw_dev->dev, aw_bin);
+	aw_bin = NULL;
+	return ret;
+}
+
 static int aw_dev_parse_data_by_sec_type(struct aw_device *aw_dev, struct aw_cfg_hdr *cfg_hdr,
 			struct aw_cfg_dde *cfg_dde, struct aw_prof_desc *scene_prof_desc)
 {
@@ -447,6 +495,9 @@ static int aw_dev_parse_data_by_sec_type(struct aw_device *aw_dev, struct aw_cfg
 		return aw_dev_prof_parse_multi_bin(
 				aw_dev, (u8 *)cfg_hdr + cfg_dde->data_offset,
 				cfg_dde->data_size, scene_prof_desc);
+	case ACF_SEC_TYPE_HDR_REG:
+		return aw_dev_parse_reg_bin_with_hdr(aw_dev, (u8 *)cfg_hdr + cfg_dde->data_offset,
+				cfg_dde->data_size, scene_prof_desc);
 	default:
 		dev_err(aw_dev->dev, "%s cfg_dde->data_type = %d\n", __func__, cfg_dde->data_type);
 		break;
@@ -527,7 +578,49 @@ static int aw_dev_parse_dev_default_type(struct aw_device *aw_dev,
 	return 0;
 }
 
-static int aw_dev_cfg_get_valid_prof(struct aw_device *aw_dev,
+static int aw88261_dev_cfg_get_valid_prof(struct aw_device *aw_dev,
+				struct aw_all_prof_info all_prof_info)
+{
+	struct aw_prof_desc *prof_desc = all_prof_info.prof_desc;
+	struct aw_prof_info *prof_info = &aw_dev->prof_info;
+	int num = 0;
+	int i;
+
+	for (i = 0; i < AW88395_PROFILE_MAX; i++) {
+		if (prof_desc[i].prof_st == AW88395_PROFILE_OK)
+			prof_info->count++;
+	}
+
+	dev_dbg(aw_dev->dev, "get valid profile:%d", aw_dev->prof_info.count);
+
+	if (!prof_info->count) {
+		dev_err(aw_dev->dev, "no profile data");
+		return -EPERM;
+	}
+
+	prof_info->prof_desc = devm_kcalloc(aw_dev->dev,
+					prof_info->count, sizeof(struct aw_prof_desc),
+					GFP_KERNEL);
+	if (!prof_info->prof_desc)
+		return -ENOMEM;
+
+	for (i = 0; i < AW88395_PROFILE_MAX; i++) {
+		if (prof_desc[i].prof_st == AW88395_PROFILE_OK) {
+			if (num >= prof_info->count) {
+				dev_err(aw_dev->dev, "overflow count[%d]",
+						prof_info->count);
+				return -EINVAL;
+			}
+			prof_info->prof_desc[num] = prof_desc[i];
+			prof_info->prof_desc[num].id = i;
+			num++;
+		}
+	}
+
+	return 0;
+}
+
+static int aw88395_dev_cfg_get_valid_prof(struct aw_device *aw_dev,
 				struct aw_all_prof_info all_prof_info)
 {
 	struct aw_prof_desc *prof_desc = all_prof_info.prof_desc;
@@ -606,9 +699,22 @@ static int aw_dev_load_cfg_by_hdr(struct aw_device *aw_dev,
 			goto exit;
 	}
 
-	ret = aw_dev_cfg_get_valid_prof(aw_dev, *all_prof_info);
-	if (ret < 0)
-		goto exit;
+	switch (aw_dev->chip_id) {
+	case AW88395_CHIP_ID:
+		ret = aw88395_dev_cfg_get_valid_prof(aw_dev, *all_prof_info);
+		if (ret < 0)
+			goto exit;
+		break;
+	case AW88261_CHIP_ID:
+		ret = aw88261_dev_cfg_get_valid_prof(aw_dev, *all_prof_info);
+		if (ret < 0)
+			goto exit;
+		break;
+	default:
+		dev_err(aw_dev->dev, "valid prof unsupported");
+		ret = -EINVAL;
+		break;
+	}
 
 	aw_dev->prof_info.prof_name_list = profile_name;
 
@@ -679,16 +785,37 @@ static int aw_get_dev_scene_count_v1(struct aw_device *aw_dev, struct aw_contain
 	struct aw_cfg_dde_v1 *cfg_dde =
 		(struct aw_cfg_dde_v1 *)(aw_cfg->data + cfg_hdr->hdr_offset);
 	unsigned int i;
+	int ret;
 
-	for (i = 0; i < cfg_hdr->ddt_num; ++i) {
-		if ((cfg_dde[i].data_type == ACF_SEC_TYPE_MULTIPLE_BIN) &&
-		    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
-		    (aw_dev->i2c->adapter->nr == cfg_dde[i].dev_bus) &&
-		    (aw_dev->i2c->addr == cfg_dde[i].dev_addr))
-			(*scene_num)++;
+	switch (aw_dev->chip_id) {
+	case AW88395_CHIP_ID:
+		for (i = 0; i < cfg_hdr->ddt_num; ++i) {
+			if ((cfg_dde[i].data_type == ACF_SEC_TYPE_MULTIPLE_BIN) &&
+			    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
+			    (aw_dev->i2c->adapter->nr == cfg_dde[i].dev_bus) &&
+			    (aw_dev->i2c->addr == cfg_dde[i].dev_addr))
+				(*scene_num)++;
+		}
+		ret = 0;
+		break;
+	case AW88261_CHIP_ID:
+		for (i = 0; i < cfg_hdr->ddt_num; ++i) {
+			if (((cfg_dde[i].data_type == ACF_SEC_TYPE_REG) ||
+			     (cfg_dde[i].data_type == ACF_SEC_TYPE_HDR_REG)) &&
+			    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
+			    (aw_dev->i2c->adapter->nr == cfg_dde[i].dev_bus) &&
+			    (aw_dev->i2c->addr == cfg_dde[i].dev_addr))
+				(*scene_num)++;
+		}
+		ret = 0;
+		break;
+	default:
+		dev_err(aw_dev->dev, "unsupported device");
+		ret = -EINVAL;
+		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int aw_get_default_scene_count_v1(struct aw_device *aw_dev,
@@ -699,15 +826,35 @@ static int aw_get_default_scene_count_v1(struct aw_device *aw_dev,
 	struct aw_cfg_dde_v1 *cfg_dde =
 		(struct aw_cfg_dde_v1 *)(aw_cfg->data + cfg_hdr->hdr_offset);
 	unsigned int i;
+	int ret;
 
-	for (i = 0; i < cfg_hdr->ddt_num; ++i) {
-		if ((cfg_dde[i].data_type == ACF_SEC_TYPE_MULTIPLE_BIN) &&
-		    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
-		    (aw_dev->channel == cfg_dde[i].dev_index))
-			(*scene_num)++;
+	switch (aw_dev->chip_id) {
+	case AW88395_CHIP_ID:
+		for (i = 0; i < cfg_hdr->ddt_num; ++i) {
+			if ((cfg_dde[i].data_type == ACF_SEC_TYPE_MULTIPLE_BIN) &&
+			    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
+			    (aw_dev->channel == cfg_dde[i].dev_index))
+				(*scene_num)++;
+		}
+		ret = 0;
+		break;
+	case AW88261_CHIP_ID:
+		for (i = 0; i < cfg_hdr->ddt_num; ++i) {
+			if (((cfg_dde[i].data_type == ACF_SEC_TYPE_REG) ||
+			     (cfg_dde[i].data_type == ACF_SEC_TYPE_HDR_REG)) &&
+			    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
+			    (aw_dev->channel == cfg_dde[i].dev_index))
+				(*scene_num)++;
+		}
+		ret = 0;
+		break;
+	default:
+		dev_err(aw_dev->dev, "unsupported device");
+		ret = -EINVAL;
+		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int aw_dev_parse_scene_count_v1(struct aw_device *aw_dev,
@@ -756,6 +903,18 @@ static int aw_dev_parse_data_by_sec_type_v1(struct aw_device *aw_dev,
 		prof_info->prof_desc[*cur_scene_id].id = cfg_dde->dev_profile;
 		(*cur_scene_id)++;
 		break;
+	case ACF_SEC_TYPE_HDR_REG:
+		ret =  aw_dev_parse_reg_bin_with_hdr(aw_dev,
+				(uint8_t *)prof_hdr + cfg_dde->data_offset,
+				cfg_dde->data_size, &prof_info->prof_desc[*cur_scene_id]);
+		if (ret < 0) {
+			dev_err(aw_dev->dev, "parse reg bin with hdr failed");
+			return ret;
+		}
+		prof_info->prof_desc[*cur_scene_id].prf_str = cfg_dde->dev_profile_str;
+		prof_info->prof_desc[*cur_scene_id].id = cfg_dde->dev_profile;
+		(*cur_scene_id)++;
+		break;
 	default:
 		dev_err(aw_dev->dev, "unsupported SEC_TYPE [%d]", cfg_dde->data_type);
 		return -EINVAL;
diff --git a/sound/soc/codecs/aw88395/aw88395_reg.h b/sound/soc/codecs/aw88395/aw88395_reg.h
index e64f24e97150..e7a7c02efaf3 100644
--- a/sound/soc/codecs/aw88395/aw88395_reg.h
+++ b/sound/soc/codecs/aw88395/aw88395_reg.h
@@ -96,6 +96,7 @@
 
 enum aw88395_id {
 	AW88395_CHIP_ID = 0x2049,
+	AW88261_CHIP_ID = 0x2113,
 };
 
 #define AW88395_REG_MAX		(0x7D)
-- 
2.41.0

