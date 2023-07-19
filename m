Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AE27591CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjGSJmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGSJl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:41:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6466EC;
        Wed, 19 Jul 2023 02:41:57 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso66756805e9.1;
        Wed, 19 Jul 2023 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689759716; x=1692351716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ixaTxzjFOHscIQGmxusBKHchuIyMDACMTLX++Se+JnI=;
        b=ckllDYYu+bz4UV90hxuPR/52h6pw7gpf8W9MvYfvNSke/uA+cT0AOaW/vn6+Zn/kJ2
         xaDcdRM3s27C9l5E4yjujw29j1nhpLTbgvu7MI93NxLtCEVp0PEQZcEgjaMiM1/stjcj
         6oe/v9t8LqQgVLSQQyRcP6/rllJp+WXMpcnxmDpyaoMgDqhq1YAysQd3RpbSPaPV9xXT
         ZC/YGhNTYre0AZ7J5fxA5oX9q69cJVVIo3LHPnRyigIVo9S0bydOHtmric6hvYK/W3Rx
         7T4WLmNz/Z/ooPbqWJCB841JC4arkpeg43gA+5W5+9KZ46nUYthR5+WIRE0tk2/XRQhN
         Shcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689759716; x=1692351716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixaTxzjFOHscIQGmxusBKHchuIyMDACMTLX++Se+JnI=;
        b=kz2IZq6M91PfKhaxW/2ktrCFHtpb1s8WAT5xcTqvV2rGvjlOOKZg7T7BD5ZwD5FzVq
         yNmHzgouiAbQ+5Fvz39x/GNYK8t3xzsaei22i8+DLxIQ5b9N7uC35PUJBG2nMG3zK1os
         KhcrSh39ur3G3ie8pBXgzWcPsrvxzvf78Sd4xztj2vx/Klf+zYlErzKdkDBM/DxMD/90
         Q1QsaWfYLLCX62yD2oslkBccSo2peAbitOjReY4jI3j+r+UftAI2mtqDhfMVuAQY7IUV
         FasAvBxtSVhBKL2Tx+VrEmcb3dPRctZrH3DG1hYaBQ+MSa9Z4BV3JPI3keQS7Pxnou0B
         8Zjg==
X-Gm-Message-State: ABy/qLahPB1xEy2nnaND/rAPFdnyz3tDt4VO1fDkXpDYqkyX5R+hmXjP
        Yqh37Xt1QPMM/DZRrBWecBplh5BWC72I2w==
X-Google-Smtp-Source: APBJJlHClcMn+1QbJOqYjD25fmxUGeUvBGc2RdKd85VwqrcXapo9gNpCkPf+uy1YN63odF7oN6McyQ==
X-Received: by 2002:a1c:7319:0:b0:3fb:d194:8332 with SMTP id d25-20020a1c7319000000b003fbd1948332mr1574342wmb.30.1689759715855;
        Wed, 19 Jul 2023 02:41:55 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id bh17-20020a05600c3d1100b003fbb1ce274fsm6383625wmb.0.2023.07.19.02.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 02:41:55 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: exar: remove unneeded platform_set_drvdata() call
Date:   Wed, 19 Jul 2023 12:39:23 +0300
Message-Id: <20230719093923.17265-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_set_drvdata() was needed when the driver had an explicit
remove function.
That function got removed a while back, so we don't need to keep a pointer
(on 'dev->driver_data') for the private data of the driver anymore.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/gpio/gpio-exar.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index df1bdaae441c..5170fe7599cd 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -217,8 +217,6 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, exar_gpio);
-
 	return 0;
 }
 
-- 
2.34.1

