Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FCE7B03CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjI0MSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjI0MRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:17:49 -0400
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3428C180;
        Wed, 27 Sep 2023 05:17:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06718864|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00748265-0.000710643-0.991807;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=29;RT=29;SR=0;TI=SMTPD_---.Upkf3t._1695817055;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Upkf3t._1695817055)
          by smtp.aliyun-inc.com;
          Wed, 27 Sep 2023 20:17:43 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, wangweidong.a@awinic.com,
        shumingf@realtek.com, rf@opensource.cirrus.com,
        herve.codina@bootlin.com, arnd@arndb.de, 13916275206@139.com,
        ryans.lee@analog.com, linus.walleij@linaro.org,
        ckeepax@opensource.cirrus.com, doug@schmorgal.com,
        fido_max@inbox.ru, harshit.m.mogalapalli@oracle.com,
        liweilei@awinic.com, yang.lee@linux.alibaba.com,
        u.kleine-koenig@pengutronix.de, yijiangtao@awinic.com,
        dan.carpenter@linaro.org, colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 7/8] ASoC: codecs: Modify the transmission mode of function parameters
Date:   Wed, 27 Sep 2023 20:16:33 +0800
Message-ID: <20230927121634.94822-8-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927121634.94822-1-wangweidong.a@awinic.com>
References: <20230927121634.94822-1-wangweidong.a@awinic.com>
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

Change the transmission mode of the "aw88261_dev_get_prof_name"
function parameter

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88261.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index 61179e235fbf..45eaf931a69c 100644
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
-- 
2.41.0

