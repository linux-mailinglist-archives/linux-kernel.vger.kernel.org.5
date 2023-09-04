Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9CC791669
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352860AbjIDLqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343693AbjIDLqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:46:54 -0400
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD5BE6;
        Mon,  4 Sep 2023 04:46:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06717187|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00695684-0.000218789-0.992824;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=24;RT=24;SR=0;TI=SMTPD_---.UXIjstE_1693827998;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.UXIjstE_1693827998)
          by smtp.aliyun-inc.com;
          Mon, 04 Sep 2023 19:46:46 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        wangweidong.a@awinic.com, herve.codina@bootlin.com,
        shumingf@realtek.com, rdunlap@infradead.org, 13916275206@139.com,
        ryans.lee@analog.com, linus.walleij@linaro.org,
        ckeepax@opensource.cirrus.com, yijiangtao@awinic.com,
        liweilei@awinic.com, colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhangjianming@awinic.com
Subject: [PATCH V1 2/3] ASoC: codecs: Add code for bin parsing compatible with aw87390
Date:   Mon,  4 Sep 2023 19:46:20 +0800
Message-ID: <20230904114621.4457-3-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904114621.4457-1-wangweidong.a@awinic.com>
References: <20230904114621.4457-1-wangweidong.a@awinic.com>
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
so that it can parse aw87390's bin file.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88395/aw88395_lib.c | 23 ++++++++++++++---------
 sound/soc/codecs/aw88395/aw88395_reg.h |  1 +
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/aw88395/aw88395_lib.c b/sound/soc/codecs/aw88395/aw88395_lib.c
index 8ee1baa03269..9d561ae27feb 100644
--- a/sound/soc/codecs/aw88395/aw88395_lib.c
+++ b/sound/soc/codecs/aw88395/aw88395_lib.c
@@ -455,9 +455,11 @@ static int aw_dev_parse_reg_bin_with_hdr(struct aw_device *aw_dev,
 		goto parse_bin_failed;
 	}
 
-	if (aw_bin->header_info[0].valid_data_len % 4) {
-		dev_err(aw_dev->dev, "bin data len get error!");
-		goto parse_bin_failed;
+	if (aw_dev->chip_id == AW88261_CHIP_ID) {
+		if (aw_bin->header_info[0].valid_data_len % 4) {
+			dev_err(aw_dev->dev, "bin data len get error!");
+			goto parse_bin_failed;
+		}
 	}
 
 	prof_desc->sec_desc[AW88395_DATA_TYPE_REG].data =
@@ -579,9 +581,9 @@ static int aw_dev_parse_dev_default_type(struct aw_device *aw_dev,
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
@@ -621,9 +623,9 @@ static int aw88261_dev_cfg_get_valid_prof(struct aw_device *aw_dev,
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
@@ -701,12 +703,13 @@ static int aw_dev_load_cfg_by_hdr(struct aw_device *aw_dev,
 
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
@@ -799,6 +802,7 @@ static int aw_get_dev_scene_count_v1(struct aw_device *aw_dev, struct aw_contain
 		ret = 0;
 		break;
 	case AW88261_CHIP_ID:
+	case AW87390_CHIP_ID:
 		for (i = 0; i < cfg_hdr->ddt_num; ++i) {
 			if (((cfg_dde[i].data_type == ACF_SEC_TYPE_REG) ||
 			     (cfg_dde[i].data_type == ACF_SEC_TYPE_HDR_REG)) &&
@@ -839,6 +843,7 @@ static int aw_get_default_scene_count_v1(struct aw_device *aw_dev,
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

