Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFE2785946
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbjHWN26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbjHWN2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:28:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE2610E9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52a0856b4fdso4410879a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797282; x=1693402082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7+Juus+8zqjM8rfjV+O0dsXAjzoK79gT3GVbXmTpDs=;
        b=f/OS82njBWBdgjIHgh5CYk9Wyq435ZWYdjB8fTwxHV9UQCOrhL2n+bL0lsRsDt2omJ
         rtz9BeJeWnp1WNl3pWWi+htInU54Zi9EIluX6jbygguKWVdRmXrJutiRDLuSU8OABcE9
         VAjMq2+jNJ9r/mFnBy428gZq7QJwV8Mas9a2hsSa+HixESG5/jwYK/eEnX5tfVZ4yZLl
         IqvQ0IDHSFvFez6WhlTDAPPdYCdjIu35mtRhGaBVPw8jwffTDIrk3iWP9sYT9YcLt0+O
         kZgIcvWiBiqS6lrwXPxMfGo2UnBTcfeLIYCeLYPqFMVE9VRipHhn9wftT73GzgPPCdQv
         eVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797282; x=1693402082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7+Juus+8zqjM8rfjV+O0dsXAjzoK79gT3GVbXmTpDs=;
        b=kv3MJLQoLg7jLIQF9HK+7gDk6mqaW8itrVKDtC4y3MX6dadpEOBa/dbLlMMg+YOH/3
         zN8rYCUv7IXHKZDu7TgLGa69tb2Xc3dmOCp836UrovsI9Yj24Dik4Y47VOcukjdLk8Ds
         hfZUF2WrlMdJc11XPtK6eeu2AQI4Bu/CesgGeQfwHlqLOKd6dnjb3L/qC/FpegYKY1UX
         QZo7aVROGUkB7G+eW7nXcOw0bdducR+Ld9EKblrR5rO31MsuW31YpX4I9n+xPgFRoCgc
         v7GWB6CornTZKg+z/Aw+OmSrRjXULqJRjw1zFf+h3wcMNpwtEq0xYL6D7K1RwxsMCka/
         j4mw==
X-Gm-Message-State: AOJu0YwQhfC1dlce+VGwGiXcN4d/9seghnr8nDKf0zGg43m5u290fkb0
        hXFk9u/2P6Sc2l4pA36sM7xm2g==
X-Google-Smtp-Source: AGHT+IFSKaBiXsjJAeH4T330Cy6Y6pnBntML1jLkkFkBXYEa/BEeD1Agtb/3j8cCXIcJtPgp249tOw==
X-Received: by 2002:a17:907:2cce:b0:9a1:7919:d3d3 with SMTP id hg14-20020a1709072cce00b009a17919d3d3mr9431365ejc.51.1692797282574;
        Wed, 23 Aug 2023 06:28:02 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:28:02 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 07/22] nvmem: stm32-romem: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 23 Aug 2023 14:27:29 +0100
Message-Id: <20230823132744.350618-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=930; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=Sat4PP2jm9xkJbYBPWUMQjgLQidXOau0bZgpXW1N90Q=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glGKxxqlenS1+Ul1M8H72dawiZUppVbeGAng 6FHz5Kl9PeJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJRgAKCRB6of1ZxzRV N718B/wJVUUhjmgoYvuCkAV0nAnNhysTSKob7FfjGyC4xkjTtjPz2iBgndJPKbe5JrYfnfOsivg 1jrMorpiauDnmkNaF3OHwi0W/eRyPtgMbPXBIY1H+1b6g71Pjm0gKLLSNK+2fy9zjMXR6e7bBRt zJJM0DTQ2S0lfPzJ59mSSvaBOTl50NhOT0rHgj82HLz+/p7r/hbthCH+dSqDkT3w/1ggo0Z9jue VPQEftuJO6OUy1+HsL3vck2QxO3+Is7Bg+5UVD12UKyWuMn8bAVvdMn97Uo5dlnCZm7wEV32fLb vZwqSEh46fxFXItYJeBNxeNFfUEaNqn7B3ejGIgLJHJ5CWn1
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

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/stm32-romem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index 38d0bf557129..0f84044bd1ad 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -196,8 +196,7 @@ static int stm32_romem_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, res);
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-- 
2.25.1

