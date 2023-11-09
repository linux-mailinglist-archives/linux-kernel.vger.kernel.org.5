Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C757E66E8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjKIJh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjKIJhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:37:24 -0500
Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205F32712;
        Thu,  9 Nov 2023 01:37:20 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00220234-2.48532e-05-0.997773;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.VJJFKQh_1699522631;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.VJJFKQh_1699522631)
          by smtp.aliyun-inc.com;
          Thu, 09 Nov 2023 17:37:17 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, wangweidong.a@awinic.com, liweilei@awinic.com,
        yijiangtao@awinic.com, trix@redhat.com, dan.carpenter@linaro.org,
        colin.i.king@gmail.com, herve.codina@bootlin.com,
        nathan@kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: Modify the bin file parsing method
Date:   Thu,  9 Nov 2023 17:37:07 +0800
Message-ID: <20231109093708.13155-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

Modify the aw88395_lib file so that the bin file
parsing is no longer related to the chip id of the chip.
Adopt the bin file data type "prof_data_type" as the
differentiation between different chip bin file
parsing methods.

Since the chip id macro for the aw88399 is no longer
defined in aw88395_reg.h, define the chip id
for the aw88399 in aw88399.h

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88395/aw88395_device.h |   1 +
 sound/soc/codecs/aw88395/aw88395_lib.c    | 124 +++++++---------------
 sound/soc/codecs/aw88395/aw88395_reg.h    |   3 -
 sound/soc/codecs/aw88399.c                |   1 -
 sound/soc/codecs/aw88399.h                |   1 +
 5 files changed, 42 insertions(+), 88 deletions(-)

diff --git a/sound/soc/codecs/aw88395/aw88395_device.h b/sound/soc/codecs/aw88395/aw88395_device.h
index 791c8c106557..0f750f654f3e 100644
--- a/sound/soc/codecs/aw88395/aw88395_device.h
+++ b/sound/soc/codecs/aw88395/aw88395_device.h
@@ -146,6 +146,7 @@ struct aw_device {
 
 	unsigned int channel;
 	unsigned int fade_step;
+	unsigned int prof_data_type;
 
 	struct i2c_client *i2c;
 	struct device *dev;
diff --git a/sound/soc/codecs/aw88395/aw88395_lib.c b/sound/soc/codecs/aw88395/aw88395_lib.c
index 9ebe7c510109..f25f6e0d4428 100644
--- a/sound/soc/codecs/aw88395/aw88395_lib.c
+++ b/sound/soc/codecs/aw88395/aw88395_lib.c
@@ -11,7 +11,6 @@
 #include <linux/i2c.h>
 #include "aw88395_lib.h"
 #include "aw88395_device.h"
-#include "aw88395_reg.h"
 
 #define AW88395_CRC8_POLYNOMIAL 0x8C
 DECLARE_CRC8_TABLE(aw_crc8_table);
@@ -456,14 +455,6 @@ static int aw_dev_parse_reg_bin_with_hdr(struct aw_device *aw_dev,
 		goto parse_bin_failed;
 	}
 
-	if (aw_dev->chip_id == AW88261_CHIP_ID) {
-		if (aw_bin->header_info[0].valid_data_len % 4) {
-			dev_err(aw_dev->dev, "bin data len get error!");
-			ret = -EINVAL;
-			goto parse_bin_failed;
-		}
-	}
-
 	prof_desc->sec_desc[AW88395_DATA_TYPE_REG].data =
 				data + aw_bin->header_info[0].valid_data_addr;
 	prof_desc->sec_desc[AW88395_DATA_TYPE_REG].len =
@@ -528,7 +519,7 @@ static int aw_dev_parse_dev_type(struct aw_device *aw_dev,
 							cfg_dde[i].dev_profile);
 				return -EINVAL;
 			}
-
+			aw_dev->prof_data_type = cfg_dde[i].data_type;
 			ret = aw_dev_parse_data_by_sec_type(aw_dev, prof_hdr, &cfg_dde[i],
 					&all_prof_info->prof_desc[cfg_dde[i].dev_profile]);
 			if (ret < 0) {
@@ -564,6 +555,7 @@ static int aw_dev_parse_dev_default_type(struct aw_device *aw_dev,
 					cfg_dde[i].dev_profile);
 				return -EINVAL;
 			}
+			aw_dev->prof_data_type = cfg_dde[i].data_type;
 			ret = aw_dev_parse_data_by_sec_type(aw_dev, prof_hdr, &cfg_dde[i],
 					&all_prof_info->prof_desc[cfg_dde[i].dev_profile]);
 			if (ret < 0) {
@@ -582,7 +574,7 @@ static int aw_dev_parse_dev_default_type(struct aw_device *aw_dev,
 	return 0;
 }
 
-static int aw88261_dev_cfg_get_valid_prof(struct aw_device *aw_dev,
+static int aw_dev_cfg_get_reg_valid_prof(struct aw_device *aw_dev,
 				struct aw_all_prof_info *all_prof_info)
 {
 	struct aw_prof_desc *prof_desc = all_prof_info->prof_desc;
@@ -624,7 +616,7 @@ static int aw88261_dev_cfg_get_valid_prof(struct aw_device *aw_dev,
 	return 0;
 }
 
-static int aw88395_dev_cfg_get_valid_prof(struct aw_device *aw_dev,
+static int aw_dev_cfg_get_multiple_valid_prof(struct aw_device *aw_dev,
 				struct aw_all_prof_info *all_prof_info)
 {
 	struct aw_prof_desc *prof_desc = all_prof_info->prof_desc;
@@ -703,26 +695,20 @@ static int aw_dev_load_cfg_by_hdr(struct aw_device *aw_dev,
 			goto exit;
 	}
 
-	switch (aw_dev->chip_id) {
-	case AW88395_CHIP_ID:
-	case AW88399_CHIP_ID:
-		ret = aw88395_dev_cfg_get_valid_prof(aw_dev, all_prof_info);
-		if (ret < 0)
-			goto exit;
+	switch (aw_dev->prof_data_type) {
+	case ACF_SEC_TYPE_MULTIPLE_BIN:
+		ret = aw_dev_cfg_get_multiple_valid_prof(aw_dev, all_prof_info);
 		break;
-	case AW88261_CHIP_ID:
-	case AW87390_CHIP_ID:
-		ret = aw88261_dev_cfg_get_valid_prof(aw_dev, all_prof_info);
-		if (ret < 0)
-			goto exit;
+	case ACF_SEC_TYPE_HDR_REG:
+		ret = aw_dev_cfg_get_reg_valid_prof(aw_dev, all_prof_info);
 		break;
 	default:
-		dev_err(aw_dev->dev, "valid prof unsupported");
+		dev_err(aw_dev->dev, "unsupport data type\n");
 		ret = -EINVAL;
 		break;
 	}
-
-	aw_dev->prof_info.prof_name_list = profile_name;
+	if (!ret)
+		aw_dev->prof_info.prof_name_list = profile_name;
 
 exit:
 	devm_kfree(aw_dev->dev, all_prof_info);
@@ -791,39 +777,23 @@ static int aw_get_dev_scene_count_v1(struct aw_device *aw_dev, struct aw_contain
 	struct aw_cfg_dde_v1 *cfg_dde =
 		(struct aw_cfg_dde_v1 *)(aw_cfg->data + cfg_hdr->hdr_offset);
 	unsigned int i;
-	int ret;
 
-	switch (aw_dev->chip_id) {
-	case AW88395_CHIP_ID:
-	case AW88399_CHIP_ID:
-		for (i = 0; i < cfg_hdr->ddt_num; ++i) {
-			if ((cfg_dde[i].data_type == ACF_SEC_TYPE_MULTIPLE_BIN) &&
-			    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
-			    (aw_dev->i2c->adapter->nr == cfg_dde[i].dev_bus) &&
-			    (aw_dev->i2c->addr == cfg_dde[i].dev_addr))
-				(*scene_num)++;
-		}
-		ret = 0;
-		break;
-	case AW88261_CHIP_ID:
-	case AW87390_CHIP_ID:
-		for (i = 0; i < cfg_hdr->ddt_num; ++i) {
-			if (((cfg_dde[i].data_type == ACF_SEC_TYPE_REG) ||
-			     (cfg_dde[i].data_type == ACF_SEC_TYPE_HDR_REG)) &&
-			    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
-			    (aw_dev->i2c->adapter->nr == cfg_dde[i].dev_bus) &&
-			    (aw_dev->i2c->addr == cfg_dde[i].dev_addr))
-				(*scene_num)++;
-		}
-		ret = 0;
-		break;
-	default:
-		dev_err(aw_dev->dev, "unsupported device");
-		ret = -EINVAL;
-		break;
+	for (i = 0; i < cfg_hdr->ddt_num; ++i) {
+		if (((cfg_dde[i].data_type == ACF_SEC_TYPE_REG) ||
+		     (cfg_dde[i].data_type == ACF_SEC_TYPE_HDR_REG) ||
+		     (cfg_dde[i].data_type == ACF_SEC_TYPE_MULTIPLE_BIN)) &&
+		    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
+		    (aw_dev->i2c->adapter->nr == cfg_dde[i].dev_bus) &&
+		    (aw_dev->i2c->addr == cfg_dde[i].dev_addr))
+			(*scene_num)++;
 	}
 
-	return ret;
+	if ((*scene_num) == 0) {
+		dev_err(aw_dev->dev, "failed to obtain scene, scenu_num = %d\n", (*scene_num));
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 static int aw_get_default_scene_count_v1(struct aw_device *aw_dev,
@@ -834,37 +804,23 @@ static int aw_get_default_scene_count_v1(struct aw_device *aw_dev,
 	struct aw_cfg_dde_v1 *cfg_dde =
 		(struct aw_cfg_dde_v1 *)(aw_cfg->data + cfg_hdr->hdr_offset);
 	unsigned int i;
-	int ret;
 
-	switch (aw_dev->chip_id) {
-	case AW88395_CHIP_ID:
-	case AW88399_CHIP_ID:
-		for (i = 0; i < cfg_hdr->ddt_num; ++i) {
-			if ((cfg_dde[i].data_type == ACF_SEC_TYPE_MULTIPLE_BIN) &&
-			    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
-			    (aw_dev->channel == cfg_dde[i].dev_index))
-				(*scene_num)++;
-		}
-		ret = 0;
-		break;
-	case AW88261_CHIP_ID:
-	case AW87390_CHIP_ID:
-		for (i = 0; i < cfg_hdr->ddt_num; ++i) {
-			if (((cfg_dde[i].data_type == ACF_SEC_TYPE_REG) ||
-			     (cfg_dde[i].data_type == ACF_SEC_TYPE_HDR_REG)) &&
-			    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
-			    (aw_dev->channel == cfg_dde[i].dev_index))
-				(*scene_num)++;
-		}
-		ret = 0;
-		break;
-	default:
-		dev_err(aw_dev->dev, "unsupported device");
-		ret = -EINVAL;
-		break;
+
+	for (i = 0; i < cfg_hdr->ddt_num; ++i) {
+		if (((cfg_dde[i].data_type == ACF_SEC_TYPE_MULTIPLE_BIN) ||
+		     (cfg_dde[i].data_type == ACF_SEC_TYPE_REG) ||
+		     (cfg_dde[i].data_type == ACF_SEC_TYPE_HDR_REG)) &&
+		    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
+		    (aw_dev->channel == cfg_dde[i].dev_index))
+			(*scene_num)++;
 	}
 
-	return ret;
+	if ((*scene_num) == 0) {
+		dev_err(aw_dev->dev, "failed to obtain scene, scenu_num = %d\n", (*scene_num));
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 static int aw_dev_parse_scene_count_v1(struct aw_device *aw_dev,
diff --git a/sound/soc/codecs/aw88395/aw88395_reg.h b/sound/soc/codecs/aw88395/aw88395_reg.h
index ede7deab6a9c..e64f24e97150 100644
--- a/sound/soc/codecs/aw88395/aw88395_reg.h
+++ b/sound/soc/codecs/aw88395/aw88395_reg.h
@@ -95,10 +95,7 @@
 #define AW88395_TM_REG			(0x7C)
 
 enum aw88395_id {
-	AW88399_CHIP_ID = 0x2183,
 	AW88395_CHIP_ID = 0x2049,
-	AW88261_CHIP_ID = 0x2113,
-	AW87390_CHIP_ID = 0x76,
 };
 
 #define AW88395_REG_MAX		(0x7D)
diff --git a/sound/soc/codecs/aw88399.c b/sound/soc/codecs/aw88399.c
index 54f8457e8497..9fcb805bf971 100644
--- a/sound/soc/codecs/aw88399.c
+++ b/sound/soc/codecs/aw88399.c
@@ -15,7 +15,6 @@
 #include <sound/soc.h>
 #include "aw88399.h"
 #include "aw88395/aw88395_device.h"
-#include "aw88395/aw88395_reg.h"
 
 static const struct regmap_config aw88399_remap_config = {
 	.val_bits = 16,
diff --git a/sound/soc/codecs/aw88399.h b/sound/soc/codecs/aw88399.h
index 4f391099d0f2..97db76055ccf 100644
--- a/sound/soc/codecs/aw88399.h
+++ b/sound/soc/codecs/aw88399.h
@@ -491,6 +491,7 @@
 #define AW88399_CRC_FW_BASE_ADDR		(0x4C0)
 #define AW88399_ACF_FILE			"aw88399_acf.bin"
 #define AW88399_DEV_SYSST_CHECK_MAX		(10)
+#define AW88399_CHIP_ID			0x2183
 
 #define AW88399_I2C_NAME			"aw88399"
 

base-commit: b622d91ca201bf97582e9b09ebbaab005ecee86f
-- 
2.41.0

