Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907FF791796
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbjIDMxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbjIDMxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:53:22 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B69B133
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 05:53:17 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bd0bc8b429so23155311fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 05:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693831995; x=1694436795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcdMAtJ/96PrXya+0e5Sbf6hgUTYeQFcEw0XjtRkkjI=;
        b=DImyGWSEh7MAqNsBwO7BAkw0LzmXQkJG0bLtYQI8OjoyCX5qTb5mYW/KFGHcXvmaDz
         7OWTjXSux4qVWg99+fpXNKFuml313639ZvxzCZ/EHR7/seRoGgeAGiSt6BzXIw4nBqoW
         xoHrmnZg+rex9PLHQviPa4Y0ER8UL7+ZnTqsCzGnp3UhZTUdUeerOR4JZZaQr2V5EdFp
         Wgs74z2l8NbsvdMddp+BBYh6qWEQRxe1cM3mtJmBWfVpH6MrjD1jz1YUQcEQv48bk7+Q
         mZQ0wZ/VgtTbEkBXTTc5cySonpgDAjZ+4GwxaLxbTkf0kBsTOwwJ23AfQc5+TZUZiDrz
         lo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693831995; x=1694436795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcdMAtJ/96PrXya+0e5Sbf6hgUTYeQFcEw0XjtRkkjI=;
        b=ZMYwYISWCqXn6PLg6ZsrK2VIIfstq0jckh8R+oH4sQBqJGFLDGZlNiyhdWUgFqBpDW
         SV40hxcTQP6E9Xnw0X0jA+F5QEdngLEaD+zQeiqeuor3sP4feEtZiRqOah56nntVWlB1
         dxklEHXyCu1j5mO5uDTowFxndsvKAkZWFGK4+6+a5eeb0X90WHih8bB6wiCK2hGoBdBn
         70yRBtchqMa/gSxwL7AwzIlTXe5fMHpX/mzeZZ7LkT4z3rEHNK1xRznjVpbwh+RUO4Fg
         aIa0TydKtFh1gmtjbYAWpD0ClURTJYbu3CXX8CFxHFgopY0WrOEwS5JiRZathrcz7DNp
         saOQ==
X-Gm-Message-State: AOJu0YwWUPuzLfqFexWz6HZi9QFmiwlB9UUPqXqT1XBPfOdCYGpQfCJm
        b0LUU/wz4G0aT9zSTlCnKn7UQA==
X-Google-Smtp-Source: AGHT+IG+IKozlREFCQEbj74bmVespE1/xtZEdZuQpHNEFNgn7WF+fZZfZIdBKK6LnlVIH7lASmji4A==
X-Received: by 2002:ac2:5e2f:0:b0:500:7696:200 with SMTP id o15-20020ac25e2f000000b0050076960200mr5945462lfg.59.1693831995105;
        Mon, 04 Sep 2023 05:53:15 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id r14-20020a056402034e00b00523d2a1626esm5836842edw.6.2023.09.04.05.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 05:53:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     wangweidong.a@awinic.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] ASoC: aw88395: drop undocumented and unused sound-channel property
Date:   Mon,  4 Sep 2023 14:53:09 +0200
Message-Id: <20230904125309.43350-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904125309.43350-1-krzysztof.kozlowski@linaro.org>
References: <20230904125309.43350-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Devicetree sound-channel property was never accepted and is not
allowed by bindings.  It is not used by any upstream user, thus
considering that it was never documented, should be dropped.

Even though it does not look like from the diff, the property is not
actually used by the driver, because once set, it is read only in loops
depending on ddt_num (prof_hdr->ddt_num, cfg_hdr->ddt_num).  The
variable ddt_num is never set and is always 0, so the loops do not have
any iteration.  Dropping sound-channel and ddt_num-related loops allows
to drop empty functions which in turn drop quite a lot of code.  This
entire code was not possible to execute.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware... but feature removed here could not work
according if conforming to documented interface.
---
 sound/soc/codecs/aw88261.c                   |  13 -
 sound/soc/codecs/aw88395/aw88395_data_type.h |   1 -
 sound/soc/codecs/aw88395/aw88395_device.c    |  21 -
 sound/soc/codecs/aw88395/aw88395_device.h    |   1 -
 sound/soc/codecs/aw88395/aw88395_lib.c       | 788 -------------------
 5 files changed, 824 deletions(-)

diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index a5de7c704e73..e0527ce2f83e 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -1171,17 +1171,6 @@ static void aw88261_hw_reset(struct aw88261 *aw88261)
 	usleep_range(AW88261_1000_US, AW88261_1000_US + 10);
 }
 
-static void aw88261_parse_channel_dt(struct aw88261 *aw88261)
-{
-	struct aw_device *aw_dev = aw88261->aw_pa;
-	struct device_node *np = aw_dev->dev->of_node;
-	u32 channel_value = AW88261_DEV_DEFAULT_CH;
-
-	of_property_read_u32(np, "sound-channel", &channel_value);
-
-	aw_dev->channel = channel_value;
-}
-
 static int aw88261_init(struct aw88261 **aw88261, struct i2c_client *i2c, struct regmap *regmap)
 {
 	struct aw_device *aw_dev;
@@ -1214,12 +1203,10 @@ static int aw88261_init(struct aw88261 **aw88261, struct i2c_client *i2c, struct
 	aw_dev->prof_info.prof_desc = NULL;
 	aw_dev->prof_info.count = 0;
 	aw_dev->prof_info.prof_type = AW88395_DEV_NONE_TYPE_ID;
-	aw_dev->channel = 0;
 	aw_dev->fw_status = AW88261_DEV_FW_FAILED;
 	aw_dev->fade_step = AW88261_VOLUME_STEP_DB;
 	aw_dev->volume_desc.ctl_volume = AW88261_VOL_DEFAULT_VALUE;
 	aw_dev->volume_desc.mute_volume = AW88261_MUTE_VOL;
-	aw88261_parse_channel_dt(*aw88261);
 
 	return ret;
 }
diff --git a/sound/soc/codecs/aw88395/aw88395_data_type.h b/sound/soc/codecs/aw88395/aw88395_data_type.h
index e7aa56178b36..c8cf2933fdc8 100644
--- a/sound/soc/codecs/aw88395/aw88395_data_type.h
+++ b/sound/soc/codecs/aw88395/aw88395_data_type.h
@@ -79,7 +79,6 @@ struct aw_cfg_hdr {
 	char version[CFG_VERSION_MAX];
 	u32 author_id;
 	u32 ddt_size;
-	u32 ddt_num;
 	u32 hdr_offset;
 	u32 hdr_version;
 	u32 reserved[3];
diff --git a/sound/soc/codecs/aw88395/aw88395_device.c b/sound/soc/codecs/aw88395/aw88395_device.c
index 19422fc9017d..f791d1ddd88a 100644
--- a/sound/soc/codecs/aw88395/aw88395_device.c
+++ b/sound/soc/codecs/aw88395/aw88395_device.c
@@ -1563,25 +1563,6 @@ int aw88395_dev_init(struct aw_device *aw_dev, struct aw_container *aw_cfg)
 }
 EXPORT_SYMBOL_GPL(aw88395_dev_init);
 
-static void aw88395_parse_channel_dt(struct aw_device *aw_dev)
-{
-	struct device_node *np = aw_dev->dev->of_node;
-	u32 channel_value;
-	int ret;
-
-	ret = of_property_read_u32(np, "sound-channel", &channel_value);
-	if (ret) {
-		dev_dbg(aw_dev->dev,
-			"read sound-channel failed,use default 0");
-		aw_dev->channel = AW88395_DEV_DEFAULT_CH;
-		return;
-	}
-
-	dev_dbg(aw_dev->dev, "read sound-channel value is: %d",
-			channel_value);
-	aw_dev->channel = channel_value;
-}
-
 static int aw_dev_init(struct aw_device *aw_dev)
 {
 	aw_dev->chip_id = AW88395_CHIP_ID;
@@ -1590,12 +1571,10 @@ static int aw_dev_init(struct aw_device *aw_dev)
 	aw_dev->prof_info.prof_desc = NULL;
 	aw_dev->prof_info.count = 0;
 	aw_dev->prof_info.prof_type = AW88395_DEV_NONE_TYPE_ID;
-	aw_dev->channel = 0;
 	aw_dev->fw_status = AW88395_DEV_FW_FAILED;
 
 	aw_dev->fade_step = AW88395_VOLUME_STEP_DB;
 	aw_dev->volume_desc.ctl_volume = AW88395_VOL_DEFAULT_VALUE;
-	aw88395_parse_channel_dt(aw_dev);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/aw88395/aw88395_device.h b/sound/soc/codecs/aw88395/aw88395_device.h
index caf730753167..6fe71e7e635b 100644
--- a/sound/soc/codecs/aw88395/aw88395_device.h
+++ b/sound/soc/codecs/aw88395/aw88395_device.h
@@ -143,7 +143,6 @@ struct aw_device {
 	unsigned char dsp_crc_st;
 	u16 chip_id;
 
-	unsigned int channel;
 	unsigned int fade_step;
 
 	struct i2c_client *i2c;
diff --git a/sound/soc/codecs/aw88395/aw88395_lib.c b/sound/soc/codecs/aw88395/aw88395_lib.c
index 8ee1baa03269..7148289dade6 100644
--- a/sound/soc/codecs/aw88395/aw88395_lib.c
+++ b/sound/soc/codecs/aw88395/aw88395_lib.c
@@ -24,130 +24,6 @@ static char *profile_name[AW88395_PROFILE_MAX] = {
 
 static int aw_parse_bin_header(struct aw_device *aw_dev, struct aw_bin *bin);
 
-static int aw_check_sum(struct aw_device *aw_dev, struct aw_bin *bin, int bin_num)
-{
-	unsigned char *p_check_sum;
-	unsigned int sum_data = 0;
-	unsigned int check_sum;
-	unsigned int i, len;
-
-	p_check_sum = &(bin->info.data[(bin->header_info[bin_num].valid_data_addr -
-						bin->header_info[bin_num].header_len)]);
-	len = bin->header_info[bin_num].bin_data_len + bin->header_info[bin_num].header_len;
-	check_sum = le32_to_cpup((void *)p_check_sum);
-
-	for (i = 4; i < len; i++)
-		sum_data += *(p_check_sum + i);
-
-	dev_dbg(aw_dev->dev, "%s -- check_sum = %p, check_sum = 0x%x, sum_data = 0x%x",
-					__func__, p_check_sum, check_sum, sum_data);
-	if (sum_data != check_sum) {
-		dev_err(aw_dev->dev, "%s. CheckSum Fail.bin_num=%d, CheckSum:0x%x, SumData:0x%x",
-				__func__, bin_num, check_sum, sum_data);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int aw_check_data_version(struct aw_device *aw_dev, struct aw_bin *bin, int bin_num)
-{
-	if (bin->header_info[bin_num].bin_data_ver < DATA_VERSION_V1 ||
-		bin->header_info[bin_num].bin_data_ver > DATA_VERSION_MAX) {
-		dev_err(aw_dev->dev, "aw_bin_parse Unrecognized this bin data version\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int aw_check_register_num(struct aw_device *aw_dev, struct aw_bin *bin, int bin_num)
-{
-	struct bin_header_info temp_info = bin->header_info[bin_num];
-	unsigned int check_register_num, parse_register_num;
-	unsigned char *p_check_sum;
-
-	p_check_sum = &(bin->info.data[(temp_info.valid_data_addr)]);
-
-	parse_register_num = le32_to_cpup((void *)p_check_sum);
-	check_register_num = (bin->header_info[bin_num].bin_data_len - CHECK_REGISTER_NUM_OFFSET) /
-				(bin->header_info[bin_num].reg_byte_len +
-				bin->header_info[bin_num].data_byte_len);
-	dev_dbg(aw_dev->dev, "%s,parse_register_num = 0x%x,check_register_num = 0x%x\n",
-				__func__, parse_register_num, check_register_num);
-	if (parse_register_num != check_register_num) {
-		dev_err(aw_dev->dev, "%s parse_register_num = 0x%x,check_register_num = 0x%x\n",
-				__func__, parse_register_num, check_register_num);
-		return -EINVAL;
-	}
-
-	bin->header_info[bin_num].reg_num = parse_register_num;
-	bin->header_info[bin_num].valid_data_len = temp_info.bin_data_len - VALID_DATA_LEN;
-	bin->header_info[bin_num].valid_data_addr = temp_info.valid_data_addr + VALID_DATA_ADDR;
-
-	return 0;
-}
-
-static int aw_check_dsp_reg_num(struct aw_device *aw_dev, struct aw_bin *bin, int bin_num)
-{
-	struct bin_header_info temp_info = bin->header_info[bin_num];
-	unsigned int check_dsp_reg_num, parse_dsp_reg_num;
-	unsigned char *p_check_sum;
-
-	p_check_sum = &(bin->info.data[(temp_info.valid_data_addr)]);
-
-	parse_dsp_reg_num = le32_to_cpup((void *)(p_check_sum + PARSE_DSP_REG_NUM));
-	bin->header_info[bin_num].reg_data_byte_len =
-			le32_to_cpup((void *)(p_check_sum + REG_DATA_BYTP_LEN));
-	check_dsp_reg_num = (bin->header_info[bin_num].bin_data_len - CHECK_DSP_REG_NUM) /
-				bin->header_info[bin_num].reg_data_byte_len;
-	dev_dbg(aw_dev->dev, "%s bin_num = %d, parse_dsp_reg_num = 0x%x, check_dsp_reg_num = 0x%x",
-					__func__, bin_num, check_dsp_reg_num, check_dsp_reg_num);
-	if (parse_dsp_reg_num != check_dsp_reg_num) {
-		dev_err(aw_dev->dev, "aw_bin_parse check dsp reg num error\n");
-		dev_err(aw_dev->dev, "%s parse_dsp_reg_num = 0x%x, check_dsp_reg_num = 0x%x",
-					__func__, check_dsp_reg_num, check_dsp_reg_num);
-		return -EINVAL;
-	}
-
-	bin->header_info[bin_num].download_addr = le32_to_cpup((void *)p_check_sum);
-	bin->header_info[bin_num].reg_num = parse_dsp_reg_num;
-	bin->header_info[bin_num].valid_data_len = temp_info.bin_data_len - DSP_VALID_DATA_LEN;
-	bin->header_info[bin_num].valid_data_addr = temp_info.valid_data_addr +
-								DSP_VALID_DATA_ADDR;
-
-	return 0;
-}
-
-static int aw_check_soc_app_num(struct aw_device *aw_dev, struct aw_bin *bin, int bin_num)
-{
-	struct bin_header_info temp_info = bin->header_info[bin_num];
-	unsigned int check_soc_app_num, parse_soc_app_num;
-	unsigned char *p_check_sum;
-
-	p_check_sum = &(bin->info.data[(temp_info.valid_data_addr)]);
-
-	bin->header_info[bin_num].app_version = le32_to_cpup((void *)p_check_sum);
-	parse_soc_app_num = le32_to_cpup((void *)(p_check_sum + PARSE_SOC_APP_NUM));
-	check_soc_app_num = bin->header_info[bin_num].bin_data_len - CHECK_SOC_APP_NUM;
-	dev_dbg(aw_dev->dev, "%s bin_num = %d, parse_soc_app_num=0x%x, check_soc_app_num = 0x%x\n",
-					__func__, bin_num, parse_soc_app_num, check_soc_app_num);
-	if (parse_soc_app_num != check_soc_app_num) {
-		dev_err(aw_dev->dev, "%s parse_soc_app_num=0x%x, check_soc_app_num = 0x%x\n",
-					__func__, parse_soc_app_num, check_soc_app_num);
-		return -EINVAL;
-	}
-
-	bin->header_info[bin_num].reg_num = parse_soc_app_num;
-	bin->header_info[bin_num].download_addr = le32_to_cpup((void *)(p_check_sum +
-								APP_DOWNLOAD_ADDR));
-	bin->header_info[bin_num].valid_data_len = temp_info.bin_data_len - APP_VALID_DATA_LEN;
-	bin->header_info[bin_num].valid_data_addr = temp_info.valid_data_addr +
-								APP_VALID_DATA_ADDR;
-
-	return 0;
-}
-
 static void aw_get_single_bin_header(struct aw_bin *bin)
 {
 	memcpy((void *)&bin->header_info[bin->all_bin_parse_num], bin->p_addr, DATA_LEN);
@@ -244,340 +120,6 @@ static int aw_parse_bin_header(struct aw_device *aw_dev, struct aw_bin *bin)
 	}
 }
 
-static int aw_check_bin_header_version(struct aw_device *aw_dev, struct aw_bin *bin)
-{
-	unsigned int header_version;
-
-	header_version = le32_to_cpup((void *)(bin->p_addr + HEADER_VERSION_OFFSET));
-	dev_dbg(aw_dev->dev, "aw_bin_parse header_version 0x%x\n", header_version);
-
-	switch (header_version) {
-	case HEADER_VERSION_V1:
-		return aw_parse_bin_header(aw_dev, bin);
-	default:
-		dev_err(aw_dev->dev, "aw_bin_parse Unrecognized this bin header version\n");
-		return -EINVAL;
-	}
-}
-
-static int aw_parsing_bin_file(struct aw_device *aw_dev, struct aw_bin *bin)
-{
-	int ret = -EINVAL;
-	int i;
-
-	if (!bin) {
-		dev_err(aw_dev->dev, "aw_bin_parse bin is NULL\n");
-		return ret;
-	}
-	bin->p_addr = bin->info.data;
-	bin->all_bin_parse_num = 0;
-	bin->multi_bin_parse_num = 0;
-	bin->single_bin_parse_num = 0;
-
-	ret = aw_check_bin_header_version(aw_dev, bin);
-	if (ret < 0) {
-		dev_err(aw_dev->dev, "aw_bin_parse check bin header version error\n");
-		return ret;
-	}
-
-	for (i = 0; i < bin->all_bin_parse_num; i++) {
-		ret = aw_check_sum(aw_dev, bin, i);
-		if (ret < 0) {
-			dev_err(aw_dev->dev, "aw_bin_parse check sum data error\n");
-			return ret;
-		}
-		ret = aw_check_data_version(aw_dev, bin, i);
-		if (ret < 0) {
-			dev_err(aw_dev->dev, "aw_bin_parse check data version error\n");
-			return ret;
-		}
-		if (bin->header_info[i].bin_data_ver == DATA_VERSION_V1) {
-			switch (bin->header_info[i].bin_data_type) {
-			case DATA_TYPE_REGISTER:
-				ret = aw_check_register_num(aw_dev, bin, i);
-				break;
-			case DATA_TYPE_DSP_REG:
-				ret = aw_check_dsp_reg_num(aw_dev, bin, i);
-				break;
-			case DATA_TYPE_SOC_APP:
-				ret = aw_check_soc_app_num(aw_dev, bin, i);
-				break;
-			default:
-				bin->header_info[i].valid_data_len =
-						bin->header_info[i].bin_data_len;
-				ret = 0;
-				break;
-			}
-			if (ret < 0)
-				return ret;
-		}
-	}
-
-	return 0;
-}
-
-static int aw_dev_parse_raw_reg(unsigned char *data, unsigned int data_len,
-		struct aw_prof_desc *prof_desc)
-{
-	prof_desc->sec_desc[AW88395_DATA_TYPE_REG].data = data;
-	prof_desc->sec_desc[AW88395_DATA_TYPE_REG].len = data_len;
-
-	prof_desc->prof_st = AW88395_PROFILE_OK;
-
-	return 0;
-}
-
-static int aw_dev_parse_raw_dsp_cfg(unsigned char *data, unsigned int data_len,
-		struct aw_prof_desc *prof_desc)
-{
-	if (data_len & 0x01)
-		return -EINVAL;
-
-	swab16_array((u16 *)data, data_len >> 1);
-
-	prof_desc->sec_desc[AW88395_DATA_TYPE_DSP_CFG].data = data;
-	prof_desc->sec_desc[AW88395_DATA_TYPE_DSP_CFG].len = data_len;
-
-	prof_desc->prof_st = AW88395_PROFILE_OK;
-
-	return 0;
-}
-
-static int aw_dev_parse_raw_dsp_fw(unsigned char *data,	unsigned int data_len,
-		struct aw_prof_desc *prof_desc)
-{
-	if (data_len & 0x01)
-		return -EINVAL;
-
-	swab16_array((u16 *)data, data_len >> 1);
-
-	prof_desc->sec_desc[AW88395_DATA_TYPE_DSP_FW].data = data;
-	prof_desc->sec_desc[AW88395_DATA_TYPE_DSP_FW].len = data_len;
-
-	prof_desc->prof_st = AW88395_PROFILE_OK;
-
-	return 0;
-}
-
-static int aw_dev_prof_parse_multi_bin(struct aw_device *aw_dev, unsigned char *data,
-				unsigned int data_len, struct aw_prof_desc *prof_desc)
-{
-	struct aw_bin *aw_bin;
-	int ret;
-	int i;
-
-	aw_bin = devm_kzalloc(aw_dev->dev, data_len + sizeof(struct aw_bin), GFP_KERNEL);
-	if (!aw_bin)
-		return -ENOMEM;
-
-	aw_bin->info.len = data_len;
-	memcpy(aw_bin->info.data, data, data_len);
-
-	ret = aw_parsing_bin_file(aw_dev, aw_bin);
-	if (ret < 0) {
-		dev_err(aw_dev->dev, "parse bin failed");
-		goto parse_bin_failed;
-	}
-
-	for (i = 0; i < aw_bin->all_bin_parse_num; i++) {
-		switch (aw_bin->header_info[i].bin_data_type) {
-		case DATA_TYPE_REGISTER:
-			prof_desc->sec_desc[AW88395_DATA_TYPE_REG].len =
-					aw_bin->header_info[i].valid_data_len;
-			prof_desc->sec_desc[AW88395_DATA_TYPE_REG].data =
-					data + aw_bin->header_info[i].valid_data_addr;
-			break;
-		case DATA_TYPE_DSP_REG:
-			if (aw_bin->header_info[i].valid_data_len & 0x01) {
-				ret = -EINVAL;
-				goto parse_bin_failed;
-			}
-
-			swab16_array((u16 *)(data + aw_bin->header_info[i].valid_data_addr),
-					aw_bin->header_info[i].valid_data_len >> 1);
-
-			prof_desc->sec_desc[AW88395_DATA_TYPE_DSP_CFG].len =
-					aw_bin->header_info[i].valid_data_len;
-			prof_desc->sec_desc[AW88395_DATA_TYPE_DSP_CFG].data =
-					data + aw_bin->header_info[i].valid_data_addr;
-			break;
-		case DATA_TYPE_DSP_FW:
-		case DATA_TYPE_SOC_APP:
-			if (aw_bin->header_info[i].valid_data_len & 0x01) {
-				ret = -EINVAL;
-				goto parse_bin_failed;
-			}
-
-			swab16_array((u16 *)(data + aw_bin->header_info[i].valid_data_addr),
-					aw_bin->header_info[i].valid_data_len >> 1);
-
-			prof_desc->fw_ver = aw_bin->header_info[i].app_version;
-			prof_desc->sec_desc[AW88395_DATA_TYPE_DSP_FW].len =
-					aw_bin->header_info[i].valid_data_len;
-			prof_desc->sec_desc[AW88395_DATA_TYPE_DSP_FW].data =
-					data + aw_bin->header_info[i].valid_data_addr;
-			break;
-		default:
-			dev_dbg(aw_dev->dev, "bin_data_type not found");
-			break;
-		}
-	}
-	prof_desc->prof_st = AW88395_PROFILE_OK;
-	ret =  0;
-
-parse_bin_failed:
-	devm_kfree(aw_dev->dev, aw_bin);
-	return ret;
-}
-
-static int aw_dev_parse_reg_bin_with_hdr(struct aw_device *aw_dev,
-			uint8_t *data, uint32_t data_len, struct aw_prof_desc *prof_desc)
-{
-	struct aw_bin *aw_bin;
-	int ret;
-
-	aw_bin = devm_kzalloc(aw_dev->dev, data_len + sizeof(*aw_bin), GFP_KERNEL);
-	if (!aw_bin)
-		return -ENOMEM;
-
-	aw_bin->info.len = data_len;
-	memcpy(aw_bin->info.data, data, data_len);
-
-	ret = aw_parsing_bin_file(aw_dev, aw_bin);
-	if (ret < 0) {
-		dev_err(aw_dev->dev, "parse bin failed");
-		goto parse_bin_failed;
-	}
-
-	if ((aw_bin->all_bin_parse_num != 1) ||
-		(aw_bin->header_info[0].bin_data_type != DATA_TYPE_REGISTER)) {
-		dev_err(aw_dev->dev, "bin num or type error");
-		goto parse_bin_failed;
-	}
-
-	if (aw_bin->header_info[0].valid_data_len % 4) {
-		dev_err(aw_dev->dev, "bin data len get error!");
-		goto parse_bin_failed;
-	}
-
-	prof_desc->sec_desc[AW88395_DATA_TYPE_REG].data =
-				data + aw_bin->header_info[0].valid_data_addr;
-	prof_desc->sec_desc[AW88395_DATA_TYPE_REG].len =
-				aw_bin->header_info[0].valid_data_len;
-	prof_desc->prof_st = AW88395_PROFILE_OK;
-
-	devm_kfree(aw_dev->dev, aw_bin);
-	aw_bin = NULL;
-
-	return 0;
-
-parse_bin_failed:
-	devm_kfree(aw_dev->dev, aw_bin);
-	aw_bin = NULL;
-	return ret;
-}
-
-static int aw_dev_parse_data_by_sec_type(struct aw_device *aw_dev, struct aw_cfg_hdr *cfg_hdr,
-			struct aw_cfg_dde *cfg_dde, struct aw_prof_desc *scene_prof_desc)
-{
-	switch (cfg_dde->data_type) {
-	case ACF_SEC_TYPE_REG:
-		return aw_dev_parse_raw_reg((u8 *)cfg_hdr + cfg_dde->data_offset,
-				cfg_dde->data_size, scene_prof_desc);
-	case ACF_SEC_TYPE_DSP_CFG:
-		return aw_dev_parse_raw_dsp_cfg((u8 *)cfg_hdr + cfg_dde->data_offset,
-				cfg_dde->data_size, scene_prof_desc);
-	case ACF_SEC_TYPE_DSP_FW:
-		return aw_dev_parse_raw_dsp_fw(
-				(u8 *)cfg_hdr + cfg_dde->data_offset,
-				cfg_dde->data_size, scene_prof_desc);
-	case ACF_SEC_TYPE_MULTIPLE_BIN:
-		return aw_dev_prof_parse_multi_bin(
-				aw_dev, (u8 *)cfg_hdr + cfg_dde->data_offset,
-				cfg_dde->data_size, scene_prof_desc);
-	case ACF_SEC_TYPE_HDR_REG:
-		return aw_dev_parse_reg_bin_with_hdr(aw_dev, (u8 *)cfg_hdr + cfg_dde->data_offset,
-				cfg_dde->data_size, scene_prof_desc);
-	default:
-		dev_err(aw_dev->dev, "%s cfg_dde->data_type = %d\n", __func__, cfg_dde->data_type);
-		break;
-	}
-
-	return 0;
-}
-
-static int aw_dev_parse_dev_type(struct aw_device *aw_dev,
-		struct aw_cfg_hdr *prof_hdr, struct aw_all_prof_info *all_prof_info)
-{
-	struct aw_cfg_dde *cfg_dde =
-		(struct aw_cfg_dde *)((char *)prof_hdr + prof_hdr->hdr_offset);
-	int sec_num = 0;
-	int ret, i;
-
-	for (i = 0; i < prof_hdr->ddt_num; i++) {
-		if ((aw_dev->i2c->adapter->nr == cfg_dde[i].dev_bus) &&
-		    (aw_dev->i2c->addr == cfg_dde[i].dev_addr) &&
-		    (cfg_dde[i].type == AW88395_DEV_TYPE_ID) &&
-		    (cfg_dde[i].data_type != ACF_SEC_TYPE_MONITOR)) {
-			if (cfg_dde[i].dev_profile >= AW88395_PROFILE_MAX) {
-				dev_err(aw_dev->dev, "dev_profile [%d] overflow",
-							cfg_dde[i].dev_profile);
-				return -EINVAL;
-			}
-
-			ret = aw_dev_parse_data_by_sec_type(aw_dev, prof_hdr, &cfg_dde[i],
-					&all_prof_info->prof_desc[cfg_dde[i].dev_profile]);
-			if (ret < 0) {
-				dev_err(aw_dev->dev, "parse failed");
-				return ret;
-			}
-			sec_num++;
-		}
-	}
-
-	if (sec_num == 0) {
-		dev_dbg(aw_dev->dev, "get dev type num is %d, please use default", sec_num);
-		return AW88395_DEV_TYPE_NONE;
-	}
-
-	return AW88395_DEV_TYPE_OK;
-}
-
-static int aw_dev_parse_dev_default_type(struct aw_device *aw_dev,
-		struct aw_cfg_hdr *prof_hdr, struct aw_all_prof_info *all_prof_info)
-{
-	struct aw_cfg_dde *cfg_dde =
-		(struct aw_cfg_dde *)((char *)prof_hdr + prof_hdr->hdr_offset);
-	int sec_num = 0;
-	int ret, i;
-
-	for (i = 0; i < prof_hdr->ddt_num; i++) {
-		if ((aw_dev->channel == cfg_dde[i].dev_index) &&
-		    (cfg_dde[i].type == AW88395_DEV_DEFAULT_TYPE_ID) &&
-		    (cfg_dde[i].data_type != ACF_SEC_TYPE_MONITOR)) {
-			if (cfg_dde[i].dev_profile >= AW88395_PROFILE_MAX) {
-				dev_err(aw_dev->dev, "dev_profile [%d] overflow",
-					cfg_dde[i].dev_profile);
-				return -EINVAL;
-			}
-			ret = aw_dev_parse_data_by_sec_type(aw_dev, prof_hdr, &cfg_dde[i],
-					&all_prof_info->prof_desc[cfg_dde[i].dev_profile]);
-			if (ret < 0) {
-				dev_err(aw_dev->dev, "parse failed");
-				return ret;
-			}
-			sec_num++;
-		}
-	}
-
-	if (sec_num == 0) {
-		dev_err(aw_dev->dev, "get dev default type failed, get num[%d]", sec_num);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int aw88261_dev_cfg_get_valid_prof(struct aw_device *aw_dev,
 				struct aw_all_prof_info all_prof_info)
 {
@@ -689,16 +231,6 @@ static int aw_dev_load_cfg_by_hdr(struct aw_device *aw_dev,
 	if (!all_prof_info)
 		return -ENOMEM;
 
-	ret = aw_dev_parse_dev_type(aw_dev, prof_hdr, all_prof_info);
-	if (ret < 0) {
-		goto exit;
-	} else if (ret == AW88395_DEV_TYPE_NONE) {
-		dev_dbg(aw_dev->dev, "get dev type num is 0, parse default dev");
-		ret = aw_dev_parse_dev_default_type(aw_dev, prof_hdr, all_prof_info);
-		if (ret < 0)
-			goto exit;
-	}
-
 	switch (aw_dev->chip_id) {
 	case AW88395_CHIP_ID:
 		ret = aw88395_dev_cfg_get_valid_prof(aw_dev, *all_prof_info);
@@ -749,286 +281,18 @@ static int aw_dev_create_prof_name_list_v1(struct aw_device *aw_dev)
 	return 0;
 }
 
-static int aw_get_dde_type_info(struct aw_device *aw_dev, struct aw_container *aw_cfg)
-{
-	struct aw_cfg_hdr *cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
-	struct aw_cfg_dde_v1 *cfg_dde =
-		(struct aw_cfg_dde_v1 *)(aw_cfg->data + cfg_hdr->hdr_offset);
-	int default_num = 0;
-	int dev_num = 0;
-	unsigned int i;
-
-	for (i = 0; i < cfg_hdr->ddt_num; i++) {
-		if (cfg_dde[i].type == AW88395_DEV_TYPE_ID)
-			dev_num++;
-
-		if (cfg_dde[i].type == AW88395_DEV_DEFAULT_TYPE_ID)
-			default_num++;
-	}
-
-	if (dev_num != 0) {
-		aw_dev->prof_info.prof_type = AW88395_DEV_TYPE_ID;
-	} else if (default_num != 0) {
-		aw_dev->prof_info.prof_type = AW88395_DEV_DEFAULT_TYPE_ID;
-	} else {
-		dev_err(aw_dev->dev, "can't find scene");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int aw_get_dev_scene_count_v1(struct aw_device *aw_dev, struct aw_container *aw_cfg,
-						unsigned int *scene_num)
-{
-	struct aw_cfg_hdr *cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
-	struct aw_cfg_dde_v1 *cfg_dde =
-		(struct aw_cfg_dde_v1 *)(aw_cfg->data + cfg_hdr->hdr_offset);
-	unsigned int i;
-	int ret;
-
-	switch (aw_dev->chip_id) {
-	case AW88395_CHIP_ID:
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
-	}
-
-	return ret;
-}
-
-static int aw_get_default_scene_count_v1(struct aw_device *aw_dev,
-						struct aw_container *aw_cfg,
-						unsigned int *scene_num)
-{
-	struct aw_cfg_hdr *cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
-	struct aw_cfg_dde_v1 *cfg_dde =
-		(struct aw_cfg_dde_v1 *)(aw_cfg->data + cfg_hdr->hdr_offset);
-	unsigned int i;
-	int ret;
-
-	switch (aw_dev->chip_id) {
-	case AW88395_CHIP_ID:
-		for (i = 0; i < cfg_hdr->ddt_num; ++i) {
-			if ((cfg_dde[i].data_type == ACF_SEC_TYPE_MULTIPLE_BIN) &&
-			    (aw_dev->chip_id == cfg_dde[i].chip_id) &&
-			    (aw_dev->channel == cfg_dde[i].dev_index))
-				(*scene_num)++;
-		}
-		ret = 0;
-		break;
-	case AW88261_CHIP_ID:
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
-	}
-
-	return ret;
-}
-
-static int aw_dev_parse_scene_count_v1(struct aw_device *aw_dev,
-							struct aw_container *aw_cfg,
-							unsigned int *count)
-{
-	int ret;
-
-	ret = aw_get_dde_type_info(aw_dev, aw_cfg);
-	if (ret < 0)
-		return ret;
-
-	switch (aw_dev->prof_info.prof_type) {
-	case AW88395_DEV_TYPE_ID:
-		ret = aw_get_dev_scene_count_v1(aw_dev, aw_cfg, count);
-		break;
-	case AW88395_DEV_DEFAULT_TYPE_ID:
-		ret = aw_get_default_scene_count_v1(aw_dev, aw_cfg, count);
-		break;
-	default:
-		dev_err(aw_dev->dev, "unsupported prof_type[%x]", aw_dev->prof_info.prof_type);
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
-static int aw_dev_parse_data_by_sec_type_v1(struct aw_device *aw_dev,
-							struct aw_cfg_hdr *prof_hdr,
-							struct aw_cfg_dde_v1 *cfg_dde,
-							int *cur_scene_id)
-{
-	struct aw_prof_info *prof_info = &aw_dev->prof_info;
-	int ret;
-
-	switch (cfg_dde->data_type) {
-	case ACF_SEC_TYPE_MULTIPLE_BIN:
-		ret = aw_dev_prof_parse_multi_bin(aw_dev, (u8 *)prof_hdr + cfg_dde->data_offset,
-					cfg_dde->data_size, &prof_info->prof_desc[*cur_scene_id]);
-		if (ret < 0) {
-			dev_err(aw_dev->dev, "parse multi bin failed");
-			return ret;
-		}
-		prof_info->prof_desc[*cur_scene_id].prf_str = cfg_dde->dev_profile_str;
-		prof_info->prof_desc[*cur_scene_id].id = cfg_dde->dev_profile;
-		(*cur_scene_id)++;
-		break;
-	case ACF_SEC_TYPE_HDR_REG:
-		ret =  aw_dev_parse_reg_bin_with_hdr(aw_dev,
-				(uint8_t *)prof_hdr + cfg_dde->data_offset,
-				cfg_dde->data_size, &prof_info->prof_desc[*cur_scene_id]);
-		if (ret < 0) {
-			dev_err(aw_dev->dev, "parse reg bin with hdr failed");
-			return ret;
-		}
-		prof_info->prof_desc[*cur_scene_id].prf_str = cfg_dde->dev_profile_str;
-		prof_info->prof_desc[*cur_scene_id].id = cfg_dde->dev_profile;
-		(*cur_scene_id)++;
-		break;
-	default:
-		dev_err(aw_dev->dev, "unsupported SEC_TYPE [%d]", cfg_dde->data_type);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int aw_dev_parse_dev_type_v1(struct aw_device *aw_dev,
-		struct aw_cfg_hdr *prof_hdr)
-{
-	struct aw_cfg_dde_v1 *cfg_dde =
-		(struct aw_cfg_dde_v1 *)((char *)prof_hdr + prof_hdr->hdr_offset);
-	int cur_scene_id = 0;
-	unsigned int i;
-	int ret;
-
-	for (i = 0; i < prof_hdr->ddt_num; i++) {
-		if ((aw_dev->i2c->adapter->nr == cfg_dde[i].dev_bus) &&
-		    (aw_dev->i2c->addr == cfg_dde[i].dev_addr) &&
-		    (aw_dev->chip_id == cfg_dde[i].chip_id)) {
-			ret = aw_dev_parse_data_by_sec_type_v1(aw_dev, prof_hdr,
-							&cfg_dde[i], &cur_scene_id);
-			if (ret < 0) {
-				dev_err(aw_dev->dev, "parse failed");
-				return ret;
-			}
-		}
-	}
-
-	if (cur_scene_id == 0) {
-		dev_err(aw_dev->dev, "get dev type failed, get num [%d]", cur_scene_id);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int aw_dev_parse_default_type_v1(struct aw_device *aw_dev,
-		struct aw_cfg_hdr *prof_hdr)
-{
-	struct aw_cfg_dde_v1 *cfg_dde =
-		(struct aw_cfg_dde_v1 *)((char *)prof_hdr + prof_hdr->hdr_offset);
-	int cur_scene_id = 0;
-	unsigned int i;
-	int ret;
-
-	for (i = 0; i < prof_hdr->ddt_num; i++) {
-		if ((aw_dev->channel == cfg_dde[i].dev_index) &&
-			(aw_dev->chip_id == cfg_dde[i].chip_id)) {
-			ret = aw_dev_parse_data_by_sec_type_v1(aw_dev, prof_hdr,
-							&cfg_dde[i], &cur_scene_id);
-			if (ret < 0) {
-				dev_err(aw_dev->dev, "parse failed");
-				return ret;
-			}
-		}
-	}
-
-	if (cur_scene_id == 0) {
-		dev_err(aw_dev->dev, "get dev default type failed, get num[%d]", cur_scene_id);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int aw_dev_parse_by_hdr_v1(struct aw_device *aw_dev,
-		struct aw_cfg_hdr *cfg_hdr)
-{
-	int ret;
-
-	switch (aw_dev->prof_info.prof_type) {
-	case AW88395_DEV_TYPE_ID:
-		ret = aw_dev_parse_dev_type_v1(aw_dev, cfg_hdr);
-		break;
-	case AW88395_DEV_DEFAULT_TYPE_ID:
-		ret = aw_dev_parse_default_type_v1(aw_dev, cfg_hdr);
-		break;
-	default:
-		dev_err(aw_dev->dev, "prof type matched failed, get num[%d]",
-			aw_dev->prof_info.prof_type);
-		ret =  -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
 static int aw_dev_load_cfg_by_hdr_v1(struct aw_device *aw_dev,
 						struct aw_container *aw_cfg)
 {
-	struct aw_cfg_hdr *cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
 	struct aw_prof_info *prof_info = &aw_dev->prof_info;
 	int ret;
 
-	ret = aw_dev_parse_scene_count_v1(aw_dev, aw_cfg, &prof_info->count);
-	if (ret < 0) {
-		dev_err(aw_dev->dev, "get scene count failed");
-		return ret;
-	}
-
 	prof_info->prof_desc = devm_kcalloc(aw_dev->dev,
 					prof_info->count, sizeof(struct aw_prof_desc),
 					GFP_KERNEL);
 	if (!prof_info->prof_desc)
 		return -ENOMEM;
 
-	ret = aw_dev_parse_by_hdr_v1(aw_dev, cfg_hdr);
-	if (ret < 0) {
-		dev_err(aw_dev->dev, "parse hdr failed");
-		return ret;
-	}
-
 	ret = aw_dev_create_prof_name_list_v1(aw_dev);
 	if (ret < 0) {
 		dev_err(aw_dev->dev, "create prof name list failed");
@@ -1074,13 +338,9 @@ EXPORT_SYMBOL_GPL(aw88395_dev_cfg_load);
 
 static int aw_dev_check_cfg_by_hdr(struct aw_device *aw_dev, struct aw_container *aw_cfg)
 {
-	unsigned int end_data_offset;
 	struct aw_cfg_hdr *cfg_hdr;
-	struct aw_cfg_dde *cfg_dde;
 	unsigned int act_data = 0;
 	unsigned int hdr_ddt_len;
-	unsigned int i;
-	u8 act_crc8;
 
 	cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
 	/* check file type id is awinic acf file */
@@ -1097,10 +357,7 @@ static int aw_dev_check_cfg_by_hdr(struct aw_device *aw_dev, struct aw_container
 	}
 
 	/* check data size */
-	cfg_dde = (struct aw_cfg_dde *)((char *)aw_cfg->data + cfg_hdr->hdr_offset);
 	act_data += hdr_ddt_len;
-	for (i = 0; i < cfg_hdr->ddt_num; i++)
-		act_data += cfg_dde[i].data_size;
 
 	if (act_data != aw_cfg->len) {
 		dev_err(aw_dev->dev, "act_data[%d] not equal to file size[%d]!",
@@ -1108,37 +365,14 @@ static int aw_dev_check_cfg_by_hdr(struct aw_device *aw_dev, struct aw_container
 		return -EINVAL;
 	}
 
-	for (i = 0; i < cfg_hdr->ddt_num; i++) {
-		/* data check */
-		end_data_offset = cfg_dde[i].data_offset + cfg_dde[i].data_size;
-		if (end_data_offset > aw_cfg->len) {
-			dev_err(aw_dev->dev, "ddt_num[%d] end_data_offset[%d] overflow size[%d]",
-				i, end_data_offset, aw_cfg->len);
-			return -EINVAL;
-		}
-
-		/* crc check */
-		act_crc8 = crc8(aw_crc8_table, aw_cfg->data + cfg_dde[i].data_offset,
-							cfg_dde[i].data_size, 0);
-		if (act_crc8 != cfg_dde[i].data_crc) {
-			dev_err(aw_dev->dev, "ddt_num[%d] act_crc8:0x%x != data_crc:0x%x",
-				i, (u32)act_crc8, cfg_dde[i].data_crc);
-			return -EINVAL;
-		}
-	}
-
 	return 0;
 }
 
 static int aw_dev_check_acf_by_hdr_v1(struct aw_device *aw_dev, struct aw_container *aw_cfg)
 {
-	struct aw_cfg_dde_v1 *cfg_dde;
-	unsigned int end_data_offset;
 	struct aw_cfg_hdr *cfg_hdr;
 	unsigned int act_data = 0;
 	unsigned int hdr_ddt_len;
-	u8 act_crc8;
-	int i;
 
 	cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
 
@@ -1156,10 +390,7 @@ static int aw_dev_check_acf_by_hdr_v1(struct aw_device *aw_dev, struct aw_contai
 	}
 
 	/* check data size */
-	cfg_dde = (struct aw_cfg_dde_v1 *)((char *)aw_cfg->data + cfg_hdr->hdr_offset);
 	act_data += hdr_ddt_len;
-	for (i = 0; i < cfg_hdr->ddt_num; i++)
-		act_data += cfg_dde[i].data_size;
 
 	if (act_data != aw_cfg->len) {
 		dev_err(aw_dev->dev, "act_data[%d] not equal to file size[%d]!",
@@ -1167,25 +398,6 @@ static int aw_dev_check_acf_by_hdr_v1(struct aw_device *aw_dev, struct aw_contai
 		return -EINVAL;
 	}
 
-	for (i = 0; i < cfg_hdr->ddt_num; i++) {
-		/* data check */
-		end_data_offset = cfg_dde[i].data_offset + cfg_dde[i].data_size;
-		if (end_data_offset > aw_cfg->len) {
-			dev_err(aw_dev->dev, "ddt_num[%d] end_data_offset[%d] overflow size[%d]",
-				i, end_data_offset, aw_cfg->len);
-			return -EINVAL;
-		}
-
-		/* crc check */
-		act_crc8 = crc8(aw_crc8_table, aw_cfg->data + cfg_dde[i].data_offset,
-									cfg_dde[i].data_size, 0);
-		if (act_crc8 != cfg_dde[i].data_crc) {
-			dev_err(aw_dev->dev, "ddt_num[%d] act_crc8:0x%x != data_crc 0x%x",
-				i, (u32)act_crc8, cfg_dde[i].data_crc);
-			return -EINVAL;
-		}
-	}
-
 	return 0;
 }
 
-- 
2.34.1

