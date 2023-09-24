Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEEC7ACB9C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjIXT0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjIXT0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:26:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123D9FB
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:26:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ad810be221so635099066b.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695583577; x=1696188377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFf1cGltxf8drTRitrLUgd7Y0FznH+yCbskJSQDkt2Q=;
        b=DZhOtr5jdCqctyv2RQkA/Pf11FbJKVVQG+oykz40ViA+0ytUCDykLUY0lbChQYNXBC
         ChptrjhuLCVY1atSVFfZZNGuupHXND97VolFC3cKtwe3Hne5x+dINvcdT0r2R7GNCyxC
         qukF7Pk9LambNvqKYseRyc5M1dF2H9dPcprR9eI6O1QBe/8pL8U+WAOoH0TlOxoza3RF
         +iUfqs+62Nx3Ua9v4aubaGimsOcT2QYkA9DxLOME+eNLq2QiUiGJeNqnf9S1Rzbm6ze6
         fUnYFOo5gIHOYhzBPIfDTH4hS3Id4BMTnRT8p882I1/FXJyWbjpcKRSYAh5tkSoqbcwg
         d1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695583577; x=1696188377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFf1cGltxf8drTRitrLUgd7Y0FznH+yCbskJSQDkt2Q=;
        b=XHbqvwzzv426+J6iiwUmBUsd00LkQNwqJHIS1yNiFoWuhu4N5C8/tm1bWLzR8znh30
         hBeHseBWEDSCCqve04RVwMWSYAZptslF8w1SSGlN9v7ybRV16uxky8t3RY32Ia2TyH0I
         5vR4hJUf5OjoL9e7Y3k+0dRd/E7qbyQOYDcg6FdIE39+wjmhEDzFyfOZnziHVb0UhuOh
         VKmElUjZQj/VIst3ZgDw3SMTa87qXSMO/I4vyS519Mr0x9aLrNcXBn3thg7sEG/7Yk4D
         jk28CpTeb9vJuQsk34BGFlzzRaVf/NtGU0VUVG+cmNqfsZZ8Sk4F8/Ee2subvDWVzc3b
         jsWQ==
X-Gm-Message-State: AOJu0YxDIYi7FBwkIBXVopOIMjNz7qnk8e+TIaxJMK4NKR4/aiuuTNS4
        470YtJM1Zo134IpNNdJ0iMw=
X-Google-Smtp-Source: AGHT+IGAhle5kDIIp4WuTj01RyhcLxUc0q31fsjC0IfkTvI/FNrLn/S5IoePIuTCGmzEdhew1ZtvcA==
X-Received: by 2002:a17:906:210a:b0:9a3:c4f4:12de with SMTP id 10-20020a170906210a00b009a3c4f412demr4134394ejt.37.1695583577533;
        Sun, 24 Sep 2023 12:26:17 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709063a1500b0099d0c0bb92bsm5317632eje.80.2023.09.24.12.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:26:17 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     airlied@gmail.com, daniel@ffwll.ch, samuel@sholland.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 5/7] drm/sun4i: dw-hdmi: Split driver registration
Date:   Sun, 24 Sep 2023 21:26:02 +0200
Message-ID: <20230924192604.3262187-6-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924192604.3262187-1-jernej.skrabec@gmail.com>
References: <20230924192604.3262187-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to register two drivers in same place. Using macro
lowers amount of boilerplate code.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c  | 27 +-------------------------
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h  |  2 --
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c |  3 ++-
 3 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 93831cdf1917..d93e8ff71aae 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -378,32 +378,7 @@ static struct platform_driver sun8i_dw_hdmi_pltfm_driver = {
 		.of_match_table = sun8i_dw_hdmi_dt_ids,
 	},
 };
-
-static int __init sun8i_dw_hdmi_init(void)
-{
-	int ret;
-
-	ret = platform_driver_register(&sun8i_dw_hdmi_pltfm_driver);
-	if (ret)
-		return ret;
-
-	ret = platform_driver_register(&sun8i_hdmi_phy_driver);
-	if (ret) {
-		platform_driver_unregister(&sun8i_dw_hdmi_pltfm_driver);
-		return ret;
-	}
-
-	return ret;
-}
-
-static void __exit sun8i_dw_hdmi_exit(void)
-{
-	platform_driver_unregister(&sun8i_dw_hdmi_pltfm_driver);
-	platform_driver_unregister(&sun8i_hdmi_phy_driver);
-}
-
-module_init(sun8i_dw_hdmi_init);
-module_exit(sun8i_dw_hdmi_exit);
+module_platform_driver(sun8i_dw_hdmi_pltfm_driver);
 
 MODULE_AUTHOR("Jernej Skrabec <jernej.skrabec@siol.net>");
 MODULE_DESCRIPTION("Allwinner DW HDMI bridge");
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index 18ffc1b4841f..21e010deeb48 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -194,8 +194,6 @@ struct sun8i_dw_hdmi {
 	struct reset_control		*rst_ctrl;
 };
 
-extern struct platform_driver sun8i_hdmi_phy_driver;
-
 static inline struct sun8i_dw_hdmi *
 encoder_to_sun8i_dw_hdmi(struct drm_encoder *encoder)
 {
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 489ea94693ff..f917a979e4a4 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -729,10 +729,11 @@ static int sun8i_hdmi_phy_probe(struct platform_device *pdev)
 	return 0;
 }
 
-struct platform_driver sun8i_hdmi_phy_driver = {
+static struct platform_driver sun8i_hdmi_phy_driver = {
 	.probe  = sun8i_hdmi_phy_probe,
 	.driver = {
 		.name = "sun8i-hdmi-phy",
 		.of_match_table = sun8i_hdmi_phy_of_table,
 	},
 };
+module_platform_driver(sun8i_hdmi_phy_driver);
-- 
2.42.0

