Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0013D7CA099
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjJPH32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPH3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:29:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C808B4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:29:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9be3b66f254so300050666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697441361; x=1698046161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqUJPR82M/GrL4dP6m89n4qgbfjI0fh+82Bf+wW3Bm0=;
        b=h2OD7e/BJSPJ32KmrPH8OY22GesBrjbSRivtAAnqhairiZijzJlpZDQIwT4lfEXIq3
         v4w31zC3Rrny6cfLbYbP5izfVffizhRJ38ax2bl07b2vqEOUMYNgY2doXWLzdypkanQF
         xvmaHWEmsgQTi+PtORa2D1BofgMMuITd0QlOkdbElvq3EwikF/QHSAl/gXEUH/SeW6Pe
         p0hFKz5iMfjvdBeWNtNS4tZ1nw7mF8eFilp3SxGDExWy02HrCJlMkSkPwy6EgHA7jNN8
         4sdUZieJmDdtOWfgo8dDoK8eN+HsP/ovaFimbQ8lJHLkQhjC9ynGQkMoDov3NfXZFK40
         yPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697441361; x=1698046161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqUJPR82M/GrL4dP6m89n4qgbfjI0fh+82Bf+wW3Bm0=;
        b=pa9qnqfoipYSGPfnc81UrwDWJsKpjK51YfKVqvTeNkfRYrF9ffZhmkqDvCAlCp/NUe
         kxMxrdrySwk3bapQAS7TEQpSpYyFnvlQ7BEQ2ADQqzoc/vPd1/k6+l3PqZO8nUPBQtJd
         ITWh5C68CIaOn9LxxvfYkF/EjA4bcJqudVTETaLtSNzrt40WN+Du48oSxwKYKySkK+9w
         Iaqx0CEAy/wjOLzqgojl00OnZywTqVWrMACmIJqmlcmB3/M2cfcy14PMmEF8Xp+n+nIB
         rnTamLSZulBnAxOqHJEK8tEYdw9EsNIfQTjsZlqXzZsB0VPxQAxRTiGOvTtF8Bz8dFFr
         UeEg==
X-Gm-Message-State: AOJu0YzhOZNtRpoB+Xx8xtiLodf3gSJ8ccfDswLsjGna4lh6KfYQs9XH
        rP888qbNLF+TwYl/OEoz5r9VlQ==
X-Google-Smtp-Source: AGHT+IHKAAmAs/xPLBwNLBR/dxRcRGzHtNIhdw2eBqAu5qPkmdZhT8WwNLowzzN4VCvYh6lJBlAutQ==
X-Received: by 2002:a17:906:ef04:b0:9be:16ba:19ab with SMTP id f4-20020a170906ef0400b009be16ba19abmr6175626ejs.29.1697441360797;
        Mon, 16 Oct 2023 00:29:20 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id v3-20020a17090606c300b009b29668fce7sm3480791ejb.113.2023.10.16.00.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:29:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PULL 2/2 PATCH] soc: samsung: exynos-chipid: Convert to platform remove callback returning void
Date:   Mon, 16 Oct 2023 09:29:11 +0200
Message-Id: <20231016072911.27148-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016072911.27148-1-krzysztof.kozlowski@linaro.org>
References: <20231016072911.27148-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.
To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230925095532.1984344-32-u.kleine-koenig@pengutronix.de
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/samsung/exynos-chipid.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 7ba45c4aff97..3fd0f2b84dd3 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -158,13 +158,11 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int exynos_chipid_remove(struct platform_device *pdev)
+static void exynos_chipid_remove(struct platform_device *pdev)
 {
 	struct soc_device *soc_dev = platform_get_drvdata(pdev);
 
 	soc_device_unregister(soc_dev);
-
-	return 0;
 }
 
 static const struct exynos_chipid_variant exynos4210_chipid_drv_data = {
@@ -197,7 +195,7 @@ static struct platform_driver exynos_chipid_driver = {
 		.of_match_table = exynos_chipid_of_device_ids,
 	},
 	.probe	= exynos_chipid_probe,
-	.remove	= exynos_chipid_remove,
+	.remove_new = exynos_chipid_remove,
 };
 module_platform_driver(exynos_chipid_driver);
 
-- 
2.34.1

