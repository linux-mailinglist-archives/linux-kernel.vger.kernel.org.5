Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CA6777911
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbjHJNGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbjHJNGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:06:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C7026A2;
        Thu, 10 Aug 2023 06:06:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc6bfc4b58so6830595ad.1;
        Thu, 10 Aug 2023 06:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691672766; x=1692277566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yu0+RXr2S4MvxeQNmu1NcD/c8jFJvuQbNcDr/8nKhYI=;
        b=mvkL5E2PVotM+rjp1G+ko5KR+EKPWXBKQk4h3a0qqt/HvFTaVhgWA6PLxU0wOhb6Pq
         S2qikBsKnGUIPu7hOO9kG2KhJRoeXSi7sRnhWkAzJHaSMobZxLxV3/1Sl4Vv7PLkdDG1
         SUggydQvO5reD8kJHNyowOW/hf7egSFjAHBzmLmmvdCju/xwXYT0VqvXnoK8ruMGWnW6
         ul6wiF39L5mAg9m+SdnO/6klfqcYsV718ZkYWC4FBnlhkvHLC5aAKJUqvhSwgnu5n+mm
         dFZdD0WxQ24eGt0oGx7ypaPzFOrtjNuuR03/gQOyx8Kn8Jaq3TswcgT93mGn+acy6aXp
         soug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691672766; x=1692277566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yu0+RXr2S4MvxeQNmu1NcD/c8jFJvuQbNcDr/8nKhYI=;
        b=bx1BkmZakVl4EXzdnF62DCj+ieR/t18ydiqp5Ubn8mAxXD+XlyFdRsH3bnLp/WXDEQ
         idYVPnZ6qZxAzzjHuNCd6TZ5SVqZF+aK0JhvpsymzCIezH3RAJbpNFk4z1sGCJMhvP+L
         rr5O98RKo1+PrhdqUfxLdltbNLmwqKZypuvSbpnr5jmfcz5885R7Vz3GizOBz8iq3wUd
         3lzTvCGGK8Psaeel9zQ9Wz9fqESTh/uNS0QmBPu4YRWYRF1r5xLNErjxhpWPR/BLtGMR
         QfogRpz/HhZ03J7pT/yJMI4YteEsSS69rqTaFIVemgbMWHaBvibIocCvB+gLsOS+k+zP
         SPSQ==
X-Gm-Message-State: AOJu0YxUWt/ncFT7DVfaFS8NmAbZp5GD1ZX2z7u2FcKqUnX1cRPICIR3
        UG+f9Cv8Ice7wITVLrNQnCA=
X-Google-Smtp-Source: AGHT+IHBMTYk7Cy1rw/ils4wjf31OPgZv6xAbp1PZXZ8GoiLulv2zz8hU+aeGynxHxSfg0/Fxw+j6Q==
X-Received: by 2002:a17:903:191:b0:1b8:af7f:6331 with SMTP id z17-20020a170903019100b001b8af7f6331mr2050532plg.55.1691672765844;
        Thu, 10 Aug 2023 06:06:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1057:1bce:4dc8:d063:71b0:bea])
        by smtp.gmail.com with ESMTPSA id s15-20020a17090a880f00b00267fbd521dbsm3350790pjn.5.2023.08.10.06.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:06:05 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v3] gpio: gpio-imx-scu: Use ARRAY_SIZE for array length
Date:   Thu, 10 Aug 2023 18:36:00 +0530
Message-Id: <20230810130600.25616-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

Use of macro ARRAY_SIZE to calculate array size minimizes
the redundant code and improves code reusability.
This fixes warnings reported by Coccinelle:
drivers/gpio/gpio-imx-scu.c:106:32-33: WARNING: Use ARRAY_SIZE

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
---
v1->v2
ARRAY_SIZE calculates array length, so changed
gc->ngpio = ARRAY_SIZE(scu_rsrc_arr)/sizeof(unsigned int) to
gc->ngpio = ARRAY_SIZE(scu_rsrc_arr)

v2->v3
added linux/kernel.h containing ARRAY_SIZE definition

---
 drivers/gpio/gpio-imx-scu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-imx-scu.c b/drivers/gpio/gpio-imx-scu.c
index e190bde5397d..13baf465aedf 100644
--- a/drivers/gpio/gpio-imx-scu.c
+++ b/drivers/gpio/gpio-imx-scu.c
@@ -6,6 +6,7 @@
  * to control the PIN resources on SCU domain.
  */
 
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/gpio/driver.h>
 #include <linux/platform_device.h>
@@ -103,7 +104,7 @@ static int imx_scu_gpio_probe(struct platform_device *pdev)
 	gc = &priv->chip;
 	gc->base = -1;
 	gc->parent = dev;
-	gc->ngpio = sizeof(scu_rsrc_arr)/sizeof(unsigned int);
+	gc->ngpio = ARRAY_SIZE(scu_rsrc_arr);
 	gc->label = dev_name(dev);
 	gc->get = imx_scu_gpio_get;
 	gc->set = imx_scu_gpio_set;
-- 
2.25.1

