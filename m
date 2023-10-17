Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2881B7CCBC3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbjJQTGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344121AbjJQTF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:05:56 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FB6FF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:05:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso9427154a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697569553; x=1698174353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVZCqq/chP4rxGDQYZJWg42hg+RWlOex6MbvzquphzE=;
        b=RmXMazZZDs0Ur5xjxAoENWbpeMasww4yoIg6LGi/1JUEczKr3FvY3gGThAis0pU6z7
         x/Y9IgVq/rYMXGL73wwOxduwmWn0yvigZgfY61CuuP94jmRmpUxdxJFJDkniJIilFMF/
         7dUvnpZ5kpXxGlc1x7gkug3rnutpLF8Wfd2Aa95XlezRCRHexnv9P2jcDsV/2lhDDXVz
         XqDtK7P1imr53CxRooKqra4Minpdj3IOv6Vsg2QGL3GkIIylatPTiEhVEJgCXMeaZZsZ
         QnkSc8BOLPoEKOQlec+8a1/psqBNS3q7wWQQ/vCPVrAJi/TS57EoUK71VXUXXBhCKLmN
         wrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569553; x=1698174353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVZCqq/chP4rxGDQYZJWg42hg+RWlOex6MbvzquphzE=;
        b=f+3x6Z9E4PkxAfx79fpckMn11FBvcqEQfoFj8tUpeBEszxejdJdEClfak6tbb29ikQ
         2ZYxEbx6BXGw5lB0VjDBixz/k+YjxiPUaB76jIpmscuFWMAZ8ItohPKvfBr3vLrYKFaC
         dpiwFnqe4Rk0g6aDA9tJCcD2HcC2hHtof9rEF+JtAOQosDmnWKx/+gAlGjQj8Ofh3T+6
         aaN2/kkumCmFSIKh5iF8vb89YEk4CLAqTQk/L6moPFw25IFUoqRye6XohqyV+MJmyCn0
         q9n2qrUoGqthu4vLHAobvJ8FqNPmimudczhV8pJhoibcljWiqLf70WGVki5E1v3dA2UK
         3MAg==
X-Gm-Message-State: AOJu0Yzx0YyvWflMwBd0eMw6N04yUpV3LONDBvifimdrq8wlNmCqmsHg
        VZsoDgWva1jZF13SD5QCoSQInP2wNcTI7aArisQ=
X-Google-Smtp-Source: AGHT+IHj2HuyJALAM/occuP6U4giNRg5GB6Vy2tZcBVRhxnSKtz5iV+Nt8aVKPhjOfSd93WeNRPaAA==
X-Received: by 2002:a50:8719:0:b0:533:9df5:ede with SMTP id i25-20020a508719000000b005339df50edemr2459365edb.14.1697569552825;
        Tue, 17 Oct 2023 12:05:52 -0700 (PDT)
Received: from ryzen9.fritz.box ([2a01:2a8:8f03:b001:fe65:a70:2777:ab31])
        by smtp.gmail.com with ESMTPSA id bq14-20020a056402214e00b00537963f692esm1637990edb.0.2023.10.17.12.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:05:52 -0700 (PDT)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dunlap@infradead.org,
        e.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, ames.lo@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v5 5/5] thermal/drivers/mediatek/lvts_thermal: Update calibration data documentation
Date:   Tue, 17 Oct 2023 21:05:45 +0200
Message-ID: <20231017190545.157282-6-bero@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017190545.157282-1-bero@baylibre.com>
References: <20231017190545.157282-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Update LVTS calibration data documentation for mt8192 and mt8195.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
[bero@baylibre.com: Fix issues pointed out by Nícolas F. R. A. Prado <nfraprado@collabora.com>]
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 31 +++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 487401424951d..15fcf573f5cc5 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -604,7 +604,34 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
  * The efuse blob values follows the sensor enumeration per thermal
  * controller. The decoding of the stream is as follow:
  *
- * stream index map for MCU Domain :
+ * MT8192 :
+ * Stream index map for MCU Domain mt8192 :
+ *
+ * <-----mcu-tc#0-----> <-----sensor#0----->        <-----sensor#1----->
+ *  0x01 | 0x02 | 0x03 | 0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09 | 0x0A | 0x0B
+ *
+ * <-----sensor#2----->        <-----sensor#3----->
+ *  0x0C | 0x0D | 0x0E | 0x0F | 0x10 | 0x11 | 0x12 | 0x13
+ *
+ * <-----sensor#4----->        <-----sensor#5----->        <-----sensor#6----->        <-----sensor#7----->
+ *  0x14 | 0x15 | 0x16 | 0x17 | 0x18 | 0x19 | 0x1A | 0x1B | 0x1C | 0x1D | 0x1E | 0x1F | 0x20 | 0x21 | 0x22 | 0x23
+ *
+ * Stream index map for AP Domain mt8192 :
+ *
+ * <-----sensor#0----->        <-----sensor#1----->
+ *  0x24 | 0x25 | 0x26 | 0x27 | 0x28 | 0x29 | 0x2A | 0x2B
+ *
+ * <-----sensor#2----->        <-----sensor#3----->
+ *  0x2C | 0x2D | 0x2E | 0x2F | 0x30 | 0x31 | 0x32 | 0x33
+ *
+ * <-----sensor#4----->        <-----sensor#5----->
+ *  0x34 | 0x35 | 0x36 | 0x37 | 0x38 | 0x39 | 0x3A | 0x3B
+ *
+ * <-----sensor#6----->        <-----sensor#7----->        <-----sensor#8----->
+ *  0x3C | 0x3D | 0x3E | 0x3F | 0x40 | 0x41 | 0x42 | 0x43 | 0x44 | 0x45 | 0x46 | 0x47
+ *
+ * MT8195 :
+ * Stream index map for MCU Domain mt8195 :
  *
  * <-----mcu-tc#0-----> <-----sensor#0-----> <-----sensor#1----->
  *  0x01 | 0x02 | 0x03 | 0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09
@@ -615,7 +642,7 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
  * <-----mcu-tc#2-----> <-----sensor#4-----> <-----sensor#5-----> <-----sensor#6-----> <-----sensor#7----->
  *  0x13 | 0x14 | 0x15 | 0x16 | 0x17 | 0x18 | 0x19 | 0x1A | 0x1B | 0x1C | 0x1D | 0x1E | 0x1F | 0x20 | 0x21
  *
- * stream index map for AP Domain :
+ * Stream index map for AP Domain mt8195 :
  *
  * <-----ap--tc#0-----> <-----sensor#0-----> <-----sensor#1----->
  *  0x22 | 0x23 | 0x24 | 0x25 | 0x26 | 0x27 | 0x28 | 0x29 | 0x2A
-- 
2.42.0

