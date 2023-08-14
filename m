Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE9977BE6A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjHNQx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjHNQxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:53:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E158A93
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so7239431e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692031983; x=1692636783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdkkmV6nq5U7tVfZF2s5PeWdkkjnYEakbCHbg4X7pw0=;
        b=EbQfyg6zAfwoMfaRuzNKonLuAgjCslWdN5R6OK1CfEX9N2yfyoMB5lXfzBRhzzXOeS
         EB2PLjAqTzwdCyrH3hu7MNZMnRi5ocZulCVK59wulxshW+spFDe7p9sly5bHz3vPyty8
         2L9BztSlDQI86wg4lO8AVuaWAh/4JeeMdxLTovg7Q/foFlQ2fpmbQNKVlWmPNZ3x5LT7
         cR2iZLRIvI5UA4zXXpLzLv+XjWVgIPOAU8Bc5KhfI+7w+Jp8fOIaUeUvLUOAK6PKPmET
         +q3PoPbD0vEKBXErpuZdK7RE3fM74F7V3n78Vh33ye7Rx9m/R6+cCjdpOPxN3QGKyg9q
         k29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692031983; x=1692636783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdkkmV6nq5U7tVfZF2s5PeWdkkjnYEakbCHbg4X7pw0=;
        b=BIrTgiPJE7kKL3M93ppHW3EvAxvYoK4d0ibtab+6CKuyRFetiMZZx9KMYe/ElUQX74
         3eqYyDmDuoG2L0I1+7NDUPAmL3TRABfIw3BNG0krf1krsOGS+94y1EwprwWz9+wAT24h
         MEreoOzClpS9ckenRqTVsTrpiTgie8sqXIpXQW6oTV/r5aSAtZk90Yu6ZYLVDYY+DBJ/
         2IoK5i82pzdZSfPQ/ZV5PamnDiGYUkU2Sm8c4NwxqMQlKuBmcdWrZ4Y53266k8TPW0TM
         UIsnn5gc1gIRNLDwiiO+/7mMETst8jg9Jf6oGx5IsFfdLUO0mpreYN7N+LAk9Dw7SLyc
         ttng==
X-Gm-Message-State: AOJu0Yw1eKAuEB8S8YUcMhN7uSb3Gqw9AMXNrMzfn+xEEWa6Jhf8HHh5
        g1Ee1Xutc3v/wu39cSlgdGHjCw==
X-Google-Smtp-Source: AGHT+IF0ooO2fSVeqT0BsksCk/HD1CGNhYzTUX94x18nkmEIoT/PFlLsy8VNs17gEHiBQUPM/K2p9Q==
X-Received: by 2002:a05:6512:203c:b0:4fd:fabf:b923 with SMTP id s28-20020a056512203c00b004fdfabfb923mr6089819lfs.14.1692031983121;
        Mon, 14 Aug 2023 09:53:03 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:02 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/22] nvmem: lpc18xx_otp: Convert to devm_platform_ioremap_resource()
Date:   Mon, 14 Aug 2023 17:52:34 +0100
Message-Id: <20230814165252.93422-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
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

