Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B3079BD7F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbjIKWVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244022AbjIKSq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:46:28 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10E1125;
        Mon, 11 Sep 2023 11:46:23 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so81355461fa.2;
        Mon, 11 Sep 2023 11:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694457982; x=1695062782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TBr4EN5rldaZkHvkd2rnKKqYjv2Um5C+H0942voyCA=;
        b=HiHPzOiQPoEKiFNMSgeA9fR8GW2TvD4hcfaDPSuQJX/Mqqfv9zdDbyTYHhQ9RDs1+Q
         QtLGK+IRb10HIuVxDQNs56obVPwSwNzz4nT7uE9EqRaLVtmTJqoKvU+g9iISqp/7M1Su
         aIQNjvK6Ahn80SL6lXNzWNyrT6Ys92u5lgkGEy8odbYo6d3geNslWIS6w//uCB4m6TwJ
         tXEOgCGazS/9y+RLs+o41E15tnwutPUSGPNmSYidOF8qwVHk51fWtOmGVKQxOunBjRkU
         FHdr7CywQns3DQlpSqiNWGJh652rNa8WqbPUVOecuSq0zi4sx4yH/Yep2wYFjUwZo+ZT
         MfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694457982; x=1695062782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TBr4EN5rldaZkHvkd2rnKKqYjv2Um5C+H0942voyCA=;
        b=aAPq70oJCv/Y5gnKqWBXJBr9Tu048fZVQ5mRgeepwuZnzV0iKQ427FKcPVbbQuwSaw
         YUg52PaLB31sNW9Z0Z0FtPsMqdshLsDhliVJ5xVYCqbY8xlcnL4vmhR0QKsXqNE9trsY
         EojN6yBM6RmNs2H/AhqqmoMVfgBHiSRcwPfglwPWwVYqHi0jmgSEYQLEH4t7rRgw+fj4
         VuB2CQpx6YubPNhX9JTpZusniAOB5U4brH3mPlKRpGNx03dat61EqHf/HIdZemj3Qp5k
         76H9GmiVXgdiyhPMg48Kh2RtKYjszCWcFdZU4oPq3vUDXsylHDnjc2daGT5/e233q1a/
         ALqQ==
X-Gm-Message-State: AOJu0YxzrhYbNB0xQS7NdDbWKLPeC78NxzbecFoHVo7tN7k+GneZHX6X
        oVpoDNpgZBx817K6J23ZnQA=
X-Google-Smtp-Source: AGHT+IEFtUwssM3Wz0EWQngKzY2DsMzQtci8zO+mdro+nrwGTnYM5m/LPUyRsxrerapH+WT+2kbMfQ==
X-Received: by 2002:a2e:980e:0:b0:2bc:dd96:147d with SMTP id a14-20020a2e980e000000b002bcdd96147dmr9353782ljj.28.1694457981836;
        Mon, 11 Sep 2023 11:46:21 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906135000b009a9f00bdf8dsm5733764ejb.191.2023.09.11.11.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 11:46:21 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] media: cedrus: Fix clock/reset sequence
Date:   Mon, 11 Sep 2023 20:46:12 +0200
Message-ID: <20230911184612.1754373-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to H6 user manual, resets should always be de-asserted before
clocks are enabled. This is also consistent with vendor driver.

Fixes: d5aecd289bab ("media: cedrus: Implement runtime PM")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../staging/media/sunxi/cedrus/cedrus_hw.c    | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
index b696bf884cbd..32af0e96e762 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -172,12 +172,12 @@ int cedrus_hw_suspend(struct device *device)
 {
 	struct cedrus_dev *dev = dev_get_drvdata(device);
 
-	reset_control_assert(dev->rstc);
-
 	clk_disable_unprepare(dev->ram_clk);
 	clk_disable_unprepare(dev->mod_clk);
 	clk_disable_unprepare(dev->ahb_clk);
 
+	reset_control_assert(dev->rstc);
+
 	return 0;
 }
 
@@ -186,11 +186,18 @@ int cedrus_hw_resume(struct device *device)
 	struct cedrus_dev *dev = dev_get_drvdata(device);
 	int ret;
 
+	ret = reset_control_reset(dev->rstc);
+	if (ret) {
+		dev_err(dev->dev, "Failed to apply reset\n");
+
+		return ret;
+	}
+
 	ret = clk_prepare_enable(dev->ahb_clk);
 	if (ret) {
 		dev_err(dev->dev, "Failed to enable AHB clock\n");
 
-		return ret;
+		goto err_rst;
 	}
 
 	ret = clk_prepare_enable(dev->mod_clk);
@@ -207,21 +214,14 @@ int cedrus_hw_resume(struct device *device)
 		goto err_mod_clk;
 	}
 
-	ret = reset_control_reset(dev->rstc);
-	if (ret) {
-		dev_err(dev->dev, "Failed to apply reset\n");
-
-		goto err_ram_clk;
-	}
-
 	return 0;
 
-err_ram_clk:
-	clk_disable_unprepare(dev->ram_clk);
 err_mod_clk:
 	clk_disable_unprepare(dev->mod_clk);
 err_ahb_clk:
 	clk_disable_unprepare(dev->ahb_clk);
+err_rst:
+	reset_control_assert(dev->rstc);
 
 	return ret;
 }
-- 
2.42.0

