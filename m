Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AFE7AE4A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjIZEkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjIZEkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:40:19 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C09997
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:40:13 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3adcec86a8cso4665308b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695703212; x=1696308012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeCQHNN67pQ7pJgPPlVJkQB5FjS2X6XolXrY+Dloy10=;
        b=E9YBVuxJbWHllTVwcaeoClQ6tBw0GPK6czAdtOvYjq9i/nekACITS2iFdN0/GEd2TC
         qfsANRa0RaH/yCQqmO8RPDwcDCYsGwz4PTfJ6SNX4FkZsMIehVD0qjIP10vjmt5844Qw
         DUhmW/cV0JYwBr/sGl0r/wUMdJ6VeaRAW8w3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695703212; x=1696308012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeCQHNN67pQ7pJgPPlVJkQB5FjS2X6XolXrY+Dloy10=;
        b=hR5MSta4WThF3bsu0rHAAbG2S4TNTo0S7dSYGjkpS4W7LZmFxex2ngOKfnlG41Jy3Z
         uC7cfSQ/68gdpD7aFUlfvk77IL7GrJcGq9ahWXgLqHP9yo8bECZpxys/mwkYSeKHzXY9
         uYGmGyd0HwXXz1Gb+bCCiB4sRk77vcFnIEqCNnqaIXI1SQwekYoWKiUFbtuFiaO0kEZy
         3oA0FGHzp69eUacUBrhxRztF7txkA8lFSD8MqV6uElqCsB5S+jHSAY0TpcD9EEjzTOAH
         QC9/QSOsbDcda583jgNf9C4s0qH5KCLQI2WVhm+oRW00JVLx4l6B6+4bSrKVp9LNE67a
         DKqg==
X-Gm-Message-State: AOJu0YynT8up7aksNIgzXzZwmDBLcgAR6A3OtmXkl3C0sriDAIs7iq/K
        u0MgT6wDxQSFQ+J+bTsnYewM1Q==
X-Google-Smtp-Source: AGHT+IHehDzy+dlk1eUDD0RZV2ctyJps9+It45O13YJejel9PHZX4R6qjb0iIyY7nNel3o2UK3jpPg==
X-Received: by 2002:a05:6870:340d:b0:1dc:797a:daf4 with SMTP id g13-20020a056870340d00b001dc797adaf4mr9384807oah.7.1695703212418;
        Mon, 25 Sep 2023 21:40:12 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:ba86:87c4:df1a:be60])
        by smtp.gmail.com with ESMTPSA id p11-20020a63ab0b000000b00563590be25esm8667210pgf.29.2023.09.25.21.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 21:40:11 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH RESEND v3 1/3] regulator: mt6358: Fail probe on unknown chip ID
Date:   Tue, 26 Sep 2023 12:34:46 +0800
Message-ID: <20230926043450.2353320-2-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926043450.2353320-1-wenst@chromium.org>
References: <20230926043450.2353320-1-wenst@chromium.org>
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

The MT6358 and MT6366 PMICs, and likely many others from MediaTek, have
a chip ID register, making the chip semi-discoverable.

The driver currently supports two PMICs and expects to be probed on one
or the other. It does not account for incorrect mfd driver entries or
device trees. While these should not happen, if they do, it could be
catastrophic for the device. The driver should be sure the hardware is
what it expects.

Make the driver fail to probe if the chip ID presented is not a known
one.

Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Fixes: f0e3c6261af1 ("regulator: mt6366: Add support for MT6366 regulator")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/regulator/mt6358-regulator.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index 65fbd95f1dbb..4ca8fbf4b3e2 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -688,12 +688,18 @@ static int mt6358_regulator_probe(struct platform_device *pdev)
 	const struct mt6358_regulator_info *mt6358_info;
 	int i, max_regulator, ret;
 
-	if (mt6397->chip_id == MT6366_CHIP_ID) {
-		max_regulator = MT6366_MAX_REGULATOR;
-		mt6358_info = mt6366_regulators;
-	} else {
+	switch (mt6397->chip_id) {
+	case MT6358_CHIP_ID:
 		max_regulator = MT6358_MAX_REGULATOR;
 		mt6358_info = mt6358_regulators;
+		break;
+	case MT6366_CHIP_ID:
+		max_regulator = MT6366_MAX_REGULATOR;
+		mt6358_info = mt6366_regulators;
+		break;
+	default:
+		dev_err(&pdev->dev, "unsupported chip ID: %d\n", mt6397->chip_id);
+		return -EINVAL;
 	}
 
 	ret = mt6358_sync_vcn33_setting(&pdev->dev);
-- 
2.42.0.515.g380fc7ccd1-goog

