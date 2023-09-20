Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F707A766E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjITIy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjITIyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:54:55 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28735B0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:54:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690b8859c46so2117273b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695200088; x=1695804888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b2WIpX8UxaE2eUdENfJEhEi2DvYwtb84UnL6O0SUo1Q=;
        b=cb0GcLKFo9nb7lmnHGsiaO00fulRnqb0ssBv3J/P6Wv0QDC7ZkTfQESsZm3AGmvSSz
         G9jxxvFpUSzgjM1TRdhTrt+PI4HKpGTWcnh87aaaV+2WHx4BDVVBHQsQDk7kOT3PTJcv
         L7DnZDHj9/CAv+nwZTDwmolORGzZcrS0Yv0nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695200088; x=1695804888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2WIpX8UxaE2eUdENfJEhEi2DvYwtb84UnL6O0SUo1Q=;
        b=bJ3lCTKBjgAVWxSC8ABnCjk0NX/3DwY7doYTPS+2e17fA/7TjAKQw9fhI+JGAkDVrp
         /hQq8o5QZWrZdbgdpVjmmGYC5WARD4HcT16FC6FBynn72qZoNvdc6q9/SLQP3HXW55y8
         wG8Z925ci/WdjP6AInSzFQo4EtWECC6WJXpXsPlV1F4OipZt2H9QeMPuCp+2YeUm3oSt
         L/qnxpQagaeNjrTB5rpndgeE4uJGNEirOXfNANi/s5kfcyYuwnW13OkO3zhS1zQn7XgN
         1KaL1acsRFXxp7WO+Y2B+BWaGkp6v1wM4yznJSBTdovmVykpfeVN1zJbjpwD/R5EHT6T
         TNOQ==
X-Gm-Message-State: AOJu0YyXdLi73wrkxChmEpRxcO6JQQ5J4cELa7MBvnnd2JFnloSCHFjJ
        6oLlglLimhGXD4NrXMEsrIL3og==
X-Google-Smtp-Source: AGHT+IHVveuh+lATMhfAR9XUZNF/rqh9RwMphICIzbzgZrWEpzl1FQ9mTUPC9PSsdRJtmJ/PTbRk1w==
X-Received: by 2002:a05:6a20:138c:b0:157:e4c6:765f with SMTP id hn12-20020a056a20138c00b00157e4c6765fmr1744078pzc.36.1695200088426;
        Wed, 20 Sep 2023 01:54:48 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:88b9:ebf4:698b:cf09])
        by smtp.gmail.com with ESMTPSA id li11-20020a170903294b00b001b89466a5f4sm11340455plb.105.2023.09.20.01.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 01:54:48 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2] regulator: mt6358: split ops for buck and linear range LDO regulators
Date:   Wed, 20 Sep 2023 16:53:34 +0800
Message-ID: <20230920085336.136238-1-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buck and linear range LDO (VSRAM_*) regulators share one set of ops.
This set includes support for get/set mode. However this only makes
sense for buck regulators, not LDOs. The callbacks were not checking
whether the register offset and/or mask for mode setting was valid or
not. This ends up making the kernel report "normal" mode operation for
the LDOs.

Create a new set of ops without the get/set mode callbacks for the
linear range LDO regulators.

Fixes: f67ff1bd58f0 ("regulator: mt6358: Add support for MT6358 regulator")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Create a new set of ops for the LDOs, as suggested by Mark
- Patch subject updated to match

 drivers/regulator/mt6358-regulator.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index b9cda2210c33..65fbd95f1dbb 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -43,7 +43,7 @@ struct mt6358_regulator_info {
 	.desc = {	\
 		.name = #vreg,	\
 		.of_match = of_match_ptr(match),	\
-		.ops = &mt6358_volt_range_ops,	\
+		.ops = &mt6358_buck_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
 		.id = MT6358_ID_##vreg,		\
 		.owner = THIS_MODULE,		\
@@ -139,7 +139,7 @@ struct mt6358_regulator_info {
 	.desc = {	\
 		.name = #vreg,	\
 		.of_match = of_match_ptr(match),	\
-		.ops = &mt6358_volt_range_ops,	\
+		.ops = &mt6358_buck_ops,	\
 		.type = REGULATOR_VOLTAGE,	\
 		.id = MT6366_ID_##vreg,		\
 		.owner = THIS_MODULE,		\
@@ -450,7 +450,7 @@ static unsigned int mt6358_regulator_get_mode(struct regulator_dev *rdev)
 	}
 }
 
-static const struct regulator_ops mt6358_volt_range_ops = {
+static const struct regulator_ops mt6358_buck_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 	.map_voltage = regulator_map_voltage_linear,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
@@ -464,6 +464,18 @@ static const struct regulator_ops mt6358_volt_range_ops = {
 	.get_mode = mt6358_regulator_get_mode,
 };
 
+static const struct regulator_ops mt6358_volt_range_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = mt6358_get_buck_voltage_sel,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_status = mt6358_get_status,
+};
+
 static const struct regulator_ops mt6358_volt_table_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_iterate,
-- 
2.42.0.459.ge4e396fd5e-goog

