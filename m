Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25AB7A5CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjISIhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISIg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:36:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E89102
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:36:53 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c4194f769fso38405875ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695112613; x=1695717413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AFgJ89zcFrRudWbk8kdaUIQLDil/i3wCbCwtmAyU7YI=;
        b=im6qbHu+ssbrtA4uYEaEV2pz40GiuDaR8fB1qyEYRDpZEfqsq564ss/RYHeRVzsuxU
         tcuWzJpwCJKUS2uHCk2Y2nRiwMTMUSfvHU6tEbzfC8COu0KWP6PhETg51Zr9ZB8S3G5a
         8yFOzrJRpR/jEP09PDe6XMXNGnp/AGwweaX58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695112613; x=1695717413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFgJ89zcFrRudWbk8kdaUIQLDil/i3wCbCwtmAyU7YI=;
        b=ryq8qUcgr18NqqaI87GbjGjzMWQPlEDKDE40QS4m4BwosRIOka9vNaa22IB8bKPtFM
         zhDuBwA3MKR9k/YJ/5A2+WkALr4tOiYYipv84Jp0ANF9JJRd+4AcIuIGelZ7WMRF1Ngm
         tRy/UylBYKJufMsu6opTzulI5eceLKCFRMf0J8jfmc97F1LYjYyEkINonGrPiG9SM5+7
         x4+SHASHqfZcj0QKk+ARk1619sjCbuuLRZnKULpKglrYdNOdLMzdrE8tkk3cJeoQDDgF
         79bIIh+VbDgdUupiYOVtCitkBAKl6/bRAA129f07t514tanJWBTuIGIrZpySfM7HHVNZ
         Dm7A==
X-Gm-Message-State: AOJu0Yxgp8k+N9U1VAvyy6e6DhUeBacFPP6rkfjs/J9i4uII5aBPkGDL
        BiI5p02vxSmJiQOlIaV0p/qhbwZI36+Hx5E8kUo=
X-Google-Smtp-Source: AGHT+IGUM8ymdxjj4POLq8H28T5j0ptbAtl7ppCRBLRUAtI5mr/Ss0hb0+yr4ezvyyOGjEHgf0CnDw==
X-Received: by 2002:a17:90a:e547:b0:268:1355:b03e with SMTP id ei7-20020a17090ae54700b002681355b03emr9292692pjb.38.1695112612649;
        Tue, 19 Sep 2023 01:36:52 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:40a:900d:e731:5a43])
        by smtp.gmail.com with ESMTPSA id n20-20020a17090ade9400b00274b018489asm5508204pjv.1.2023.09.19.01.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:36:52 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] regulator: mt6358: return error for get/set mode op on linear range LDO
Date:   Tue, 19 Sep 2023 16:36:46 +0800
Message-ID: <20230919083647.3909889-1-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buck and linear range (VSRAM_*) regulators share one set of ops.
This set includes support for get/set mode. However this only makes
sense for buck regulators, not LDOs. The callbacks were not checking
whether the register offset and/or mask for mode setting was valid or
not. This ends up making the kernel report "normal" mode operation for
the LDOs.

Instead, make the callbacks return -EINVAL if the mode register mask is
not set, signaling that it is not supported.

Fixes: f67ff1bd58f0 ("regulator: mt6358: Add support for MT6358 regulator")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/mt6358-regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index b9cda2210c33..120c60d40ed4 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -408,6 +408,9 @@ static int mt6358_regulator_set_mode(struct regulator_dev *rdev,
 	const struct mt6358_regulator_info *info = to_regulator_info(rdev->desc);
 	int val;
 
+	if (!info->modeset_mask)
+		return -EINVAL;
+
 	switch (mode) {
 	case REGULATOR_MODE_FAST:
 		val = MT6358_BUCK_MODE_FORCE_PWM;
@@ -433,6 +436,9 @@ static unsigned int mt6358_regulator_get_mode(struct regulator_dev *rdev)
 	const struct mt6358_regulator_info *info = to_regulator_info(rdev->desc);
 	int ret, regval;
 
+	if (!info->modeset_mask)
+		return -EINVAL;
+
 	ret = regmap_read(rdev->regmap, info->modeset_reg, &regval);
 	if (ret != 0) {
 		dev_err(&rdev->dev,
-- 
2.42.0.459.ge4e396fd5e-goog

