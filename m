Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAAF7D6A10
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343527AbjJYL1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbjJYL1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:27:02 -0400
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5619D19B;
        Wed, 25 Oct 2023 04:26:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0798378|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00838696-0.000239165-0.991374;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=26;RT=26;SR=0;TI=SMTPD_---.V7r.pEQ_1698233203;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.V7r.pEQ_1698233203)
          by smtp.aliyun-inc.com;
          Wed, 25 Oct 2023 19:26:50 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, wangweidong.a@awinic.com,
        herve.codina@bootlin.com, shumingf@realtek.com,
        rf@opensource.cirrus.com, arnd@arndb.de, 13916275206@139.com,
        ryans.lee@analog.com, linus.walleij@linaro.org,
        ckeepax@opensource.cirrus.com,
        ajye_huang@compal.corp-partner.google.com, fido_max@inbox.ru,
        liweilei@awinic.com, yijiangtao@awinic.com, trix@redhat.com,
        colin.i.king@gmail.com, dan.carpenter@linaro.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/3] ASoC: codecs: Add code for bin parsing compatible with aw88399
Date:   Wed, 25 Oct 2023 19:26:24 +0800
Message-ID: <20231025112625.959587-3-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025112625.959587-1-wangweidong.a@awinic.com>
References: <20231025112625.959587-1-wangweidong.a@awinic.com>
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

Add aw88399 compatible code to the aw88395_lib.c file
so that it can parse aw88399's bin file.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88395/aw88395_lib.c | 3 +++
 sound/soc/codecs/aw88395/aw88395_reg.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/codecs/aw88395/aw88395_lib.c b/sound/soc/codecs/aw88395/aw88395_lib.c
index a0a429ca9768..9ebe7c510109 100644
--- a/sound/soc/codecs/aw88395/aw88395_lib.c
+++ b/sound/soc/codecs/aw88395/aw88395_lib.c
@@ -705,6 +705,7 @@ static int aw_dev_load_cfg_by_hdr(struct aw_device *aw_dev,
 
 	switch (aw_dev->chip_id) {
 	case AW88395_CHIP_ID:
+	case AW88399_CHIP_ID:
 		ret = aw88395_dev_cfg_get_valid_prof(aw_dev, all_prof_info);
 		if (ret < 0)
 			goto exit;
@@ -794,6 +795,7 @@ static int aw_get_dev_scene_count_v1(struct aw_device *aw_dev, struct aw_contain
 
 	switch (aw_dev->chip_id) {
 	case AW88395_CHIP_ID:
+	case AW88399_CHIP_ID:
 		for (i = 0; i < cfg_hdr->ddt_num; ++i) {
 			if ((cfg_dde[i].data_type == ACF_SEC_TYPE_MULTIPLE_BIN) &&
 			    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
@@ -836,6 +838,7 @@ static int aw_get_default_scene_count_v1(struct aw_device *aw_dev,
 
 	switch (aw_dev->chip_id) {
 	case AW88395_CHIP_ID:
+	case AW88399_CHIP_ID:
 		for (i = 0; i < cfg_hdr->ddt_num; ++i) {
 			if ((cfg_dde[i].data_type == ACF_SEC_TYPE_MULTIPLE_BIN) &&
 			    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
diff --git a/sound/soc/codecs/aw88395/aw88395_reg.h b/sound/soc/codecs/aw88395/aw88395_reg.h
index d0a273387313..ede7deab6a9c 100644
--- a/sound/soc/codecs/aw88395/aw88395_reg.h
+++ b/sound/soc/codecs/aw88395/aw88395_reg.h
@@ -95,6 +95,7 @@
 #define AW88395_TM_REG			(0x7C)
 
 enum aw88395_id {
+	AW88399_CHIP_ID = 0x2183,
 	AW88395_CHIP_ID = 0x2049,
 	AW88261_CHIP_ID = 0x2113,
 	AW87390_CHIP_ID = 0x76,
-- 
2.41.0

