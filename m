Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14464785941
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbjHWN2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbjHWN2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:28:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EA01738
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bcfe28909so710062366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797277; x=1693402077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8E1H+tqjrcltsTk51oasBteSCGLkUFt3kqgkC3BldPg=;
        b=ZuVHT0KMc8ivisTLMEK34rxybCBl9wotFhaf2j1BjkgZwMyj1arbaztH46E9RuUXKD
         +TP2XF9VqrDP0JoQW9n5oreXGGSwRrfydmsjp/bk3nMTWioT/47oalVhQDjK71+/deVT
         NJ6YcYTdPryGxd+UvHcVKvqlQsySbWchwdAL/kBYjQkagEnTIiejBzGcjzhz/jOob3YW
         j2DfVJB1I5jiZsMbnHPDChhPG9YyU6Ds58W5KzL7lzKtMzEntaF1Dj+QZffmPitj0qjL
         6JUjmcVhabDVWiAHataz7s51a/roz5ZUXexp69qJw1vTYdPZQsxED8P9T0WYRcK4H3vC
         nf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797277; x=1693402077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8E1H+tqjrcltsTk51oasBteSCGLkUFt3kqgkC3BldPg=;
        b=cEQtnSzKhZG6pat9U4y0RCrjyHgdXVc/1cimvASGqkdarOoYb3eV4EKZjFc2av/rY8
         zK12w6ChtWWypn6mpGPgWFgCCUJUsMYk5Rb5sTTc4ArZNC9oGTFlem9fu1NRPOJf13Rj
         IBchsUipySgaIob63tlT4HZYcl2bF8TMKvqSYxd3N3KuKhTCvFDRY5vd+EZOC+bHzeem
         /lgKESufQJZ42HovYEc3te+jdSjQ6eyMJp40WSFSfcwdtj0JIDayIi7k5AfK0H6YmEwY
         /IYwR9cl4kxZoOhyFaDNJldBsCyqECGKeaxWNu0A4UN4DvzJcU7sfRXWdZhIORRlgwjL
         4jAA==
X-Gm-Message-State: AOJu0YxndRJjpkaoAFnVSKr7c8bvd4rASmjk8f7CwVEamr/wkx45CBCr
        9mh4Vpx3b2VgMk3ib4tNy6KMLQ==
X-Google-Smtp-Source: AGHT+IEmF7TRMZUQteycy4kMWA9R6lII8h76RzxwwdSac6FVSJWb/VBh4wbpz0a5ZdwE3iZ4XDeP8A==
X-Received: by 2002:a17:907:2711:b0:9a1:e66e:b69a with SMTP id w17-20020a170907271100b009a1e66eb69amr1026492ejk.21.1692797277086;
        Wed, 23 Aug 2023 06:27:57 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:27:56 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 02/22] nvmem: sunxi_sid: Convert to devm_platform_ioremap_resource()
Date:   Wed, 23 Aug 2023 14:27:24 +0100
Message-Id: <20230823132744.350618-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=VF3ksj9Hqts/lpRAynQlDe1Fc8EzS5Liv1yR/EYi67s=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glDyXBI2jv1y+22dpGVR0kRvLshBnUgOUgAr oJhhhBroLOJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJQwAKCRB6of1ZxzRV N8Y7B/9zX/7JihGutPhP4a2iRgnEL1YFx4a5JlaRq8xnlQumV5rlZ+mYQCo1U/04fJ3O+AL7Y77 BPv7yopIllJAuT6DykO87SkKi2bNcQjpA+PWRlQ9wGcvNEohNMXkwbCxkt7P87xI2USAION+Y3n AGyxr4qw0tKXELe9Txf8Kw+he9Irih/4nn6R2NmQ08YlJOnSUL6m6YdU8/rMPxBQ666bWb6rGu6 b0mwVUdU1nTwjHRYvxVZbr69fmThPwErHdbapkF3UXA3nl8e00vDaGUTkASh4dPT041vneAAjAe fD0hd0mZfUfYV3m4rhC9+ErUE53WRN0Ij3mqUnwikLCpyO7F
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
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index a970f1741cc6..6bfe02ab169a 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -125,7 +125,6 @@ static int sun8i_sid_read_by_reg(void *context, unsigned int offset,
 static int sunxi_sid_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct nvmem_config *nvmem_cfg;
 	struct nvmem_device *nvmem;
 	struct sunxi_sid *sid;
@@ -142,8 +141,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 		return -EINVAL;
 	sid->value_offset = cfg->value_offset;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sid->base = devm_ioremap_resource(dev, res);
+	sid->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sid->base))
 		return PTR_ERR(sid->base);
 
-- 
2.25.1

