Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DA7785944
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjHWN2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbjHWN2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:28:46 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A15E74
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99de884ad25so753068466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797280; x=1693402080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ9qlAUbePlsiqKNAw2XCXfpwKOzQlpZ5FRE6WrsgJU=;
        b=B39oYujJbKD+0HoWpcgl6v92MkV5ZEPg2AnRVVSQlnirR5PwAQkOb4HGyhScGqtZEg
         AE3zaRkEXygH7LJ9/hJdYz+wyAGJu4I1sNIR5+D0BX46WaE7HWluqZ05K7dZIM+8FDn4
         OKrlPPtly2HAM66qfA7utxoUYi7WSoV7i/JMxid+MeepBGltlPcS6I+/rHgh0PKUetWA
         GmJsHqF8XcpebHJgfmiz4a9QyinAGOotkxqEN+0th91KnKP5CIdOrXRkkh32acz0aYzx
         UiWR0/ITnozKOzxR5TV9oUd8juj+IlPmthJXtrR/xcNHfoLyyA8GGLe0esgOV9Omo3II
         SRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797280; x=1693402080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ9qlAUbePlsiqKNAw2XCXfpwKOzQlpZ5FRE6WrsgJU=;
        b=S/YeQEbU22vbeU1WNH2AEqYKS0wnZPD4rlDZBa3ZnXe8sXZcEMg+rcOfBOPHn9sdX/
         yr08sFhonhYoKMAUsmVuFQfzr7fYWWvnwz1kzjTjyism72ACQd47of3Z5DTHk5TmkPOf
         nNPVj4YPgDvMi4qrYpWzqez+KIsCt7coGPLh5SSYngnORV2Twoak/LugDSvVWbUREjSR
         j5fCowe5pAOm/Qh9SkcVy/Gvd20Ot/hPwzWU0ycX5Y1+rUxVKZHvXw+hqgjauw4DVuFH
         9zbChtTEjQajHF/Khw4cM4Cz8zCHVYZmg6LUKUpXEkCgd6AhdG4qoD7dC9CbW+SjwCRY
         Fh5A==
X-Gm-Message-State: AOJu0Ywod+pgspTAC5ZKFoHR4GX/hgTtjCW9Z99IebyhUqL+IHhoXQu4
        qY2Voth11Heaw5sIoDNzV6dtBg==
X-Google-Smtp-Source: AGHT+IH/QDbEJOsygJStPLG1S6y/xakB+nnPz+7iF6ReOpopVocOU7UALrfFRbDZu6GZOgLmWzQHnQ==
X-Received: by 2002:a17:906:8477:b0:99c:72c8:bfe1 with SMTP id hx23-20020a170906847700b0099c72c8bfe1mr9914817ejc.38.1692797280605;
        Wed, 23 Aug 2023 06:28:00 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:27:59 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 05/22] nvmem: meson-mx-efuse: Convert to devm_platform_ioremap_resource()
Date:   Wed, 23 Aug 2023 14:27:27 +0100
Message-Id: <20230823132744.350618-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=EFkcO7vPsfe8JLUjVmXKJ1KFD3+kZMWu2vh9nY1/dy0=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glFdYF4PIFMVLxBmEoLGEqaSXis+vnoFPwJj j8F8bc7ehiJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJRQAKCRB6of1ZxzRV NxWoB/0Y83cWexjG5fsxOfLRThr+3Oh+bFBqBQB0NyPljTQM3aAB9m/68qW0sj6XIP/U52QkfXW BCvh3DJVjYC2A2q+qTTaYR4AU14NX4PveiFYy0Jx6vo7CjAZ1MXBHH/DIZTw7DIz3xz3V244+hv p7xDe087HI7Hy5L4H8zfvLSe7S2GHWI69zRcI/YFNfDeILxjgghjopb++bDKtJKS061EyB7wBDu 1/z4Fcvb6WfoTXqsQVSpgUUe0DrzAUWyT7AWt5YksowJpi7x1i86F3LUon/cxQ10wkr9Khhc1z0 iI9dh3yQM064og7LpxlIKAUS7rwtBSLoAuGSwP1qW+2PeMi7
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank.li@vivo.com>

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/meson-mx-efuse.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 13eb14316f46..461e3ad87bcd 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -194,7 +194,6 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 {
 	const struct meson_mx_efuse_platform_data *drvdata;
 	struct meson_mx_efuse *efuse;
-	struct resource *res;
 
 	drvdata = of_device_get_match_data(&pdev->dev);
 	if (!drvdata)
@@ -204,8 +203,7 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 	if (!efuse)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	efuse->base = devm_ioremap_resource(&pdev->dev, res);
+	efuse->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(efuse->base))
 		return PTR_ERR(efuse->base);
 
-- 
2.25.1

