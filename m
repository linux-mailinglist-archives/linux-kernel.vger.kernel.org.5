Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B2777BE6B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjHNQx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjHNQxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:53:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C223F93
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:06 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so11560855a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692031985; x=1692636785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTLyzq+CmYuG8lZJh8FVcULeSIxdJ4wT6H5hFMK4AT4=;
        b=Cy/W9ediaC92BmUoZDnV6sFV7w/w0LrUaqS+v5c58J8ageRRvDP+iy9C/MHIS7NJ2x
         l5yZShCpACglXYNEIkr9Xstqo6716Juyaw40Dd2ckjIJ4D53xLvkfunbH+BSoMLkzQUW
         bQJI24WJBAtiyED4+zuejY7xc6S3JRsdjw6WZVBxswfZjLSw5s0NvjV5AfUnXdWyjk+x
         X5K0M6hh2UEfUWjyiZod6V0UUDzLha98sZJyuKA5WPHPnybZjrMYsxd6HTQ0+7woxOis
         TaTO5LFTFnJtPtEKzfpZz8BmAGzXT7bdq9snSfHSZ/+ghBgPPGQ2bYGfZw/SCoWzQ6h7
         h5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692031985; x=1692636785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTLyzq+CmYuG8lZJh8FVcULeSIxdJ4wT6H5hFMK4AT4=;
        b=ZhWaaeaKz8N2U9himFysPbiCbQ8wuGTnIDHGoSEQav8sxF1FCAJSVO31Fv332ZLoz+
         HqKQkypjwWpgG0E19U7Gz2CEviknBG3YPOFRWzqsk1eNjyd6ZPHXCee6QaYi3hE9NJZl
         E3imYsE4QrNE1pQ1FN9OZdn5EyoObcvVcoJpItBIMKuJzT+xh5mWGJ1Tisc9L2pjN0bP
         6w1ctbZVjOzA1xpwUtP9CfB2QaHCCiZi+cKhyBtCMD++xin48U/7cHDZZkgVxLhn3oz9
         lJgBiQaIpl8iUtzBJq437lxKRbDn1ft6NX1KimOwP4wXS82fdwnGuL7SDK+RSH/9ISrT
         b6EQ==
X-Gm-Message-State: AOJu0YyGVMjHY9p5oPab/67tP2Tt3gGPTiwsx2RTcFcDFoqVQtJhjpC7
        e74lGl6OZt+ocLQ5X1JtlivCpw==
X-Google-Smtp-Source: AGHT+IEHTMjIrPdI9MHUkNHSZa/vi5MU/Y8hoBnQpzFzc3o1ZwZmwwO/9v7NB6AIrbBUmtj2IxQqtQ==
X-Received: by 2002:a05:6402:26c6:b0:522:ab20:368a with SMTP id x6-20020a05640226c600b00522ab20368amr15458190edd.13.1692031985405;
        Mon, 14 Aug 2023 09:53:05 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:04 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/22] nvmem: rockchip-efuse: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 14 Aug 2023 17:52:36 +0100
Message-Id: <20230814165252.93422-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank.li@vivo.com>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/rockchip-efuse.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index e4579de5d014..4004c5bece42 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -267,8 +267,7 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 	if (!efuse)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	efuse->base = devm_ioremap_resource(dev, res);
+	efuse->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(efuse->base))
 		return PTR_ERR(efuse->base);
 
-- 
2.25.1

