Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3167E116F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 23:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjKDWys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 18:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjKDWyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 18:54:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69501FB
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 15:54:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5079f6efd64so4053209e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 15:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699138482; x=1699743282; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=peHB8fc0FpN3X8Q1SVuag/CxFROBwBEcNoz37/Mm90k=;
        b=ZLWqBfYzAmE38SJpIxyif1VHRPaTcs5RlI6LdhYhATQP4/ciXKGZTffRCetlnmRUDj
         mXF5QTf/Y58lqU4FjjKVuWqf+6skai1oJthpy77JBeiOCX8Exsj/0OItkvnwB1A2vYLO
         a78YhFUlWVVG6OwJ6EjtbopmzDBi+/caDW+WslQSO0A3O2WbObVpuuWC+Qx3YKb/NQDy
         XY19Slo/QPRySmH222w8AKqLGDrr0ZsFH07CG4xEpT89lh8MsA3geNLw2nztF7i2A6g9
         2jU7JXZDXhgj5F6kf9Yi9Ef+5mIs0e2kQRFK2evj2tSbcYUTNR9tePMYg8+S9+3t/T6o
         zx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699138482; x=1699743282;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=peHB8fc0FpN3X8Q1SVuag/CxFROBwBEcNoz37/Mm90k=;
        b=aMEtaHZr/g5CqS165Th3lpfj3f+BzDjE5hLEP2aQEW8Wcf8D0Vmr96l+ia1E1XM/V3
         Xj8r9cSTC5+fOGYXRV5BBEsokgw8/lno8JBVmnW9MIp2oLdCEa/tIP4+4SgD0nYNJokG
         r5i/Pkjo4dEio8zRJ75XeF6CpKxoetiTzAs1cJ8V9Zo+6z8kR5QbPvg7P/HKz/ed4blR
         aqHiCVINRAxd//4RWMmzJurks2kA7Xi3hR/TzZ0Mq/BNmMYqqLdW13ilJkubYhpVpqcO
         sQtaA2eZqTKfkUKuHeYnGt4ual5uTdfwMy2pkJKd5sHOvjk8pJYj2fPuAaWmzkv0KJra
         S3PQ==
X-Gm-Message-State: AOJu0YypLpH6CzaNh9ErRw1FJo7xmP9AHKVu81w6/2oRYnsvQBXd9RrJ
        F7/+ls6LZpCUQKPhgJgAeHivVw==
X-Google-Smtp-Source: AGHT+IGMyhDbi0MXWxg8Y2O739hVKH5rXBA+6sBAE+ljJ0M/r/SxM+jvKkFtWAgkaG1Okc0rIyzA6Q==
X-Received: by 2002:a19:430e:0:b0:507:96c7:eb1a with SMTP id q14-20020a19430e000000b0050796c7eb1amr18075662lfa.54.1699138482336;
        Sat, 04 Nov 2023 15:54:42 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id eo28-20020a056512481c00b005079a3c872esm636475lfb.240.2023.11.04.15.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 15:54:41 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 04 Nov 2023 23:54:40 +0100
Subject: [PATCH] RFC: Do not enable the v1 uAPI by default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231104-no-y-uapi1-default-v1-1-f60d318b6fbe@linaro.org>
X-B4-Tracking: v=1; b=H4sIAK/LRmUC/x3MTQqAIBBA4avIrBvwj4iuEi1EpxoIE60oorsnL
 b/Few8UykwFevFAppMLb7FCNQL84uJMyKEatNRGKWkwbnjj4RIrDDS5Y93Rammpa720zkANU6a
 Jr386jO/7AZOZOZ1kAAAA
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been two years since we introduced the v2 uAPI and
the major consumer libgpiod is at v2.1.

What about discouraging the old uAPI?

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 913948876c93..65c9914ee3fa 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -85,7 +85,7 @@ config GPIO_CDEV
 
 config GPIO_CDEV_V1
 	bool "Support GPIO ABI Version 1"
-	default y
+	default n
 	depends on GPIO_CDEV
 	help
 	  Say Y here to support version 1 of the GPIO CDEV ABI.
@@ -93,8 +93,6 @@ config GPIO_CDEV_V1
 	  This ABI version is deprecated.
 	  Please use the latest ABI for new developments.
 
-	  If unsure, say Y.
-
 config GPIO_GENERIC
 	depends on HAS_IOMEM # Only for IOMEM drivers
 	tristate

---
base-commit: e392ea4d4d00880bf94550151b1ace4f88a4b17a
change-id: 20231103-no-y-uapi1-default-4204e86c04a3

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

