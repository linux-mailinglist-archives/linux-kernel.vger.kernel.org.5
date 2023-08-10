Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989BC777536
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbjHJKAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbjHJJ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:59:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689902711
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe501e0b4cso6353585e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691661568; x=1692266368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFjv0YOMmIbvyG8xqF6MV8pbiE5lmY0sXRy/BYvrEBo=;
        b=Ixv+70gHE3pXTx6L1vFwOTkx9NxE+MKxfvU8Gye31lmOvdXqpN5Awm3Ohj4Ide3L5P
         kVHLouP2pqOpQTLtumMbA1pccky5zo1J8O9YkNpQl4PK1ba9YtHItke0tuwuxX+O7T6w
         5PYhicbGlowNDu/SF5iBjzJ1FKidEZMEQiXHB8k2avq3zqTohFlL7lfE7rxEdLiHHUvg
         WwkkU17wMdiGUIGBH2i0x/decbBaTqkwBUzk0x6nhoXxHeAYFp5Wr1DqXzL5ZEPXLXiU
         79PaWkoNQVGHJ9QSQEu8tzNAIiMQG7PETG9Zg4zjMxViDZxXr3zrQASAnuhU/MBVsCrd
         Xc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661568; x=1692266368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFjv0YOMmIbvyG8xqF6MV8pbiE5lmY0sXRy/BYvrEBo=;
        b=YritXo1XtHakT4hYW4O/E1iMlGb2DA40YlT2ISA6efKENytcR3wwYheAxw6ZOmKE+R
         5SAPKTeP0Ig+mRhgdDegHlIUN1Xm7QxD7zrzIAHDbO05JCWUu8l67SV1EBgqNgiZNBZJ
         WqYd+PBrOyYeosWj7T9SMbUWPeRXt5Xnmg460CFtnQb0FhPvdfNrTLN3nizkmRmjeSGU
         oLxGWWbXCrhZaeMSZUxOd/H3Fy9U/80YFXLS+IJPX+vMPfNaSXDBZBcn2dmRifg8/kld
         nfxKU72/POHeHvaTDBFX9zB/lGzujrM4xgMTUzcWcM5Kfnr5rzprsZ/+K7EbEh5xAuUw
         G45A==
X-Gm-Message-State: AOJu0YzSbrhaqGoxOWyo+4cw8gu7ovwQOMyR35fj851w2zn+g6EkrVVy
        2o/rMuj3tPIbg3fd4PheGBLlYg==
X-Google-Smtp-Source: AGHT+IGCwl1K+ldtgkSe4CgL2aTR/qcXURd710H4UgjL8wBL0DGcfhLJc5LyBskohd3Gj4g1bUGl5g==
X-Received: by 2002:a05:600c:253:b0:3fe:6f7:60aa with SMTP id 19-20020a05600c025300b003fe06f760aamr1408658wmj.12.1691661568032;
        Thu, 10 Aug 2023 02:59:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id v1-20020adff681000000b00313e2abfb8dsm1610969wrp.92.2023.08.10.02.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:59:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Qiang Yu <yuq825@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lima@lists.freedesktop.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] drm/lima: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:59:23 +0200
Message-Id: <20230810095923.123388-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810095923.123388-1-krzysztof.kozlowski@linaro.org>
References: <20230810095923.123388-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'id' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  lima_drv.c:387:13: error: cast to smaller integer type 'enum lima_gpu_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/lima/lima_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index 10fd9154cc46..884181708de8 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -384,7 +384,7 @@ static int lima_pdev_probe(struct platform_device *pdev)
 	}
 
 	ldev->dev = &pdev->dev;
-	ldev->id = (enum lima_gpu_id)of_device_get_match_data(&pdev->dev);
+	ldev->id = (uintptr_t)of_device_get_match_data(&pdev->dev);
 
 	platform_set_drvdata(pdev, ldev);
 
-- 
2.34.1

