Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6924D791795
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjIDMxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjIDMxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:53:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED8F133
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 05:53:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52a40cf952dso1867751a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 05:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693831993; x=1694436793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aIqjpwdpePVdstex42t0FFh/Z9QtmxZMAevrmET3IHI=;
        b=hGRygKBMr3CVxqSN9jhsYGxjW0nQrJOjMvGWgaLZwBXy//mQolWdxPrACBHe+epi1R
         ajiAUUSp9Lr4IdSQonpPDDu6RfQrqFLLmvBJewa+Vk6qQmU6jPThNUYQhMnbURtKkGq4
         U0/FihE742fx1uoBUgTob8JYHU73EFamsoe1Nrh9fiS/okwHj0tKPpdEdf+ykfeoPK1G
         ZrEmMghlpcdodncw979x/lv7AAx20vpIsO5N9h84Qbpt3lyOkUsOqLmRKrCXlT7H4Ymp
         HrGebqO0bq87N2hp6UD5DL05I2NDScKrvARIX5Xa8i9qPgfNSJiXh/mo2mI5LdkcPgzc
         Qmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693831993; x=1694436793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIqjpwdpePVdstex42t0FFh/Z9QtmxZMAevrmET3IHI=;
        b=BlNgAkXuAQS1K2omchWk5Mup96jFr4WOECiP8oJ6RH3FiMK06BrT3zWy0dK3WGonRa
         H/G3YFbKz1h0bU28UvRPoG7fo+oSK/vfS5Hf5oKPa2QPBMdnaDpd50s96YtOXuNAAEw3
         ktv37KonwDG07d1GyYRLKY/lfMZCZQtsUDqHEtDFakTZqUeu0JG7cO7evXBdchoOq1ec
         p1NWKlWWe9Gg3rEAg0ENtAizTqJMA3fR23c+BgX0rlnja/2/4a3l4B7YnrgppZUPCzBh
         2GFyBk9gRbz6QNsldirGX9idNsuMCXEuA/FVF//aM7EiUfqdMJjYVDZz7eLsHIGwz4fC
         l5Lw==
X-Gm-Message-State: AOJu0YyBFVzdMSZe95ApYrt+x2p94D2ANvtDLuOI8S9iOYrtWiuS1L7o
        Nwx66p86yEHEzf5Bj9Ghz1EILQ==
X-Google-Smtp-Source: AGHT+IE63vfGdjyiQibNH3OTDuowtAqYlhktHoq0Mw4veIgoS2PhJ5UEmLUJzaEqGF81uazSSSFxRg==
X-Received: by 2002:a05:6402:2d1:b0:522:580f:8c75 with SMTP id b17-20020a05640202d100b00522580f8c75mr6774905edx.17.1693831992817;
        Mon, 04 Sep 2023 05:53:12 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id r14-20020a056402034e00b00523d2a1626esm5836842edw.6.2023.09.04.05.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 05:53:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     wangweidong.a@awinic.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] ASoC: aw88261: drop undocumented, fake sync-flag property
Date:   Mon,  4 Sep 2023 14:53:07 +0200
Message-Id: <20230904125309.43350-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The Devicetree sync-flag property was never accepted and is not allowed
by bindings.  It is not used by any upstream user, thus considering that
it was never documented, should be dropped.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware... but feature removed here could not work
according if conforming to documented interface.
---
 sound/soc/codecs/aw88261.c | 22 ++++------------------
 sound/soc/codecs/aw88261.h |  2 --
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index a697b5006b45..a5de7c704e73 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -633,28 +633,17 @@ static int aw88261_dev_stop(struct aw_device *aw_dev)
 	return 0;
 }
 
-static int aw88261_reg_update(struct aw88261 *aw88261, bool force)
+static int aw88261_reg_update(struct aw88261 *aw88261)
 {
 	struct aw_device *aw_dev = aw88261->aw_pa;
 	int ret;
 
-	if (force) {
-		ret = regmap_write(aw_dev->regmap,
-					AW88261_ID_REG, AW88261_SOFT_RESET_VALUE);
-		if (ret)
-			return ret;
-
+	if (aw_dev->prof_cur != aw_dev->prof_index) {
 		ret = aw88261_dev_fw_update(aw88261);
 		if (ret)
 			return ret;
 	} else {
-		if (aw_dev->prof_cur != aw_dev->prof_index) {
-			ret = aw88261_dev_fw_update(aw88261);
-			if (ret)
-				return ret;
-		} else {
-			ret = 0;
-		}
+		ret = 0;
 	}
 
 	aw_dev->prof_cur = aw_dev->prof_index;
@@ -667,7 +656,7 @@ static void aw88261_start_pa(struct aw88261 *aw88261)
 	int ret, i;
 
 	for (i = 0; i < AW88261_START_RETRIES; i++) {
-		ret = aw88261_reg_update(aw88261, aw88261->phase_sync);
+		ret = aw88261_reg_update(aw88261);
 		if (ret) {
 			dev_err(aw88261->aw_pa->dev, "fw update failed, cnt:%d\n", i);
 			continue;
@@ -1187,13 +1176,10 @@ static void aw88261_parse_channel_dt(struct aw88261 *aw88261)
 	struct aw_device *aw_dev = aw88261->aw_pa;
 	struct device_node *np = aw_dev->dev->of_node;
 	u32 channel_value = AW88261_DEV_DEFAULT_CH;
-	u32 sync_enable = false;
 
 	of_property_read_u32(np, "sound-channel", &channel_value);
-	of_property_read_u32(np, "sync-flag", &sync_enable);
 
 	aw_dev->channel = channel_value;
-	aw88261->phase_sync = sync_enable;
 }
 
 static int aw88261_init(struct aw88261 **aw88261, struct i2c_client *i2c, struct regmap *regmap)
diff --git a/sound/soc/codecs/aw88261.h b/sound/soc/codecs/aw88261.h
index 4f3dbf438510..ab9e3c52ecb6 100644
--- a/sound/soc/codecs/aw88261.h
+++ b/sound/soc/codecs/aw88261.h
@@ -452,8 +452,6 @@ struct aw88261 {
 	int frcset_en;
 	unsigned int mute_st;
 	unsigned int amppd_st;
-
-	unsigned char phase_sync;
 };
 
 #endif
-- 
2.34.1

