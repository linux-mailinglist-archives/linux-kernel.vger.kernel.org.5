Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DD8785943
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbjHWN2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbjHWN2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:28:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8441010D7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99cce6f7de2so765189066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797279; x=1693402079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdkkmV6nq5U7tVfZF2s5PeWdkkjnYEakbCHbg4X7pw0=;
        b=OBqd6qgOhgu08BPnbnKGw/UaobZObve24GnIjtZ66p5tFwkArdQo9Ew5hI7sKZ+hva
         GXcP8CV2V4f4lCGXaP9HB9mMibjm+rYSRjhK9j9XqOrQ3DQgIisjNkVToCLZLzUBAwbB
         XyJHAgpj16qbPOqNZ5YXzZP3743WVMifG6475J9+XUjvKFG4VehTk5vtCnQ1l1ea68Ld
         r2JDgSemqYwv1Fc3/u3Ty8Z+zy1QpCyARE4HiRWsNAO8CdliGFNt6+djtdwTOZiR2bPz
         57wA9pYV0EF86rhkwvzcU5OU6CQTL00V/ciYwF/Nfw/ekHajWt7ehHVcq9sxhnJwYLoO
         hHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797279; x=1693402079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdkkmV6nq5U7tVfZF2s5PeWdkkjnYEakbCHbg4X7pw0=;
        b=O6uDfg+iqTcaXb7yXAcqg8cWDiMa07Oq9YN/3kvef9aFWHTy2zmLEOU4adWFju8dsG
         ZjOYZNHgUgwMYtkiNGsv6mnG7Nz60Y4iX4Cxstt4If1Ltc0EyDqUQtHAPYp2JFdtmdj5
         t43egBfru1oxEFF2QCzSYG55iYbxAbpwp36qZEJ6iLolRcurk+0fvEXWUebc3vU81u2A
         ALGSCG/qbZoXCXqfEgR+PF8JIqW0YGX/sc6985rrn7n/YySPhep8CTRhMDGqI6jxbnnM
         UYmYuwPjMjYgUt1/wSfrdD/+ClCsByCgO2DOj8o/Y6hpsVsCNpDpA8esnV7pnC4y3+f7
         Ec4w==
X-Gm-Message-State: AOJu0YxnFXCR5nngUh/9cZekDQjtFLZDxNRWC3Tj+CasWeMvGC8nkDEt
        TT9vNS7gaZ/K9L+K4fFcBXbesQ==
X-Google-Smtp-Source: AGHT+IHK8+R5PusvcSPX/jD1tzMHDNF/1JV9qOuQy6kbwUFDxTAeXZkznyV2vTLzQNkqUAu+9OO3rA==
X-Received: by 2002:a17:907:7818:b0:99e:8e:d41a with SMTP id la24-20020a170907781800b0099e008ed41amr10110894ejc.52.1692797279187;
        Wed, 23 Aug 2023 06:27:59 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:27:58 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 04/22] nvmem: lpc18xx_otp: Convert to devm_platform_ioremap_resource()
Date:   Wed, 23 Aug 2023 14:27:26 +0100
Message-Id: <20230823132744.350618-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=53m+MbmQzl1a+7Ovb+ifFrlKMTvSGu6kSEdM+pYJRPI=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glEA2dP0/Im9ecTV94Sm/GPELxvcSkljo1Uc T1KOc35nsyJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJRAAKCRB6of1ZxzRV N6Y8B/4l6WgaYWoUCIYC7lTPLNg1FukRHbkqBJki9f3Z+ZD9B3In4ph2uB4IyMmlyGhYQZNN/gf hpaqTpc1DIclGJLJR02YfycupPnA/9wW6gqzzO2Xxuxx+BnpEPXLViuHj5N6orYmpkZKFxpVHwt ElKbmFaCGTw8qbH7g/6w/iv1/XRXTk+vAOMHz94XPX+Ys7sW33JvAjjgeMrut6RjebZ1SrBlCua fkJJc2dNoyKzM9kCxXH1nFM7lI+WGLKQ1GYBkV45Z+6f5VXesOiBwZY68wvM1hkb77kh1/PXgJd dSVnnFIL0YF/KRKSGAmR5DMqEjkI+NwBtIRHeefHzciNR3fZ
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
 drivers/nvmem/lpc18xx_otp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/lpc18xx_otp.c b/drivers/nvmem/lpc18xx_otp.c
index 16c92ea85d49..8faed05e3cbe 100644
--- a/drivers/nvmem/lpc18xx_otp.c
+++ b/drivers/nvmem/lpc18xx_otp.c
@@ -68,14 +68,12 @@ static int lpc18xx_otp_probe(struct platform_device *pdev)
 {
 	struct nvmem_device *nvmem;
 	struct lpc18xx_otp *otp;
-	struct resource *res;
 
 	otp = devm_kzalloc(&pdev->dev, sizeof(*otp), GFP_KERNEL);
 	if (!otp)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	otp->base = devm_ioremap_resource(&pdev->dev, res);
+	otp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(otp->base))
 		return PTR_ERR(otp->base);
 
-- 
2.25.1

