Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A1D77BE6F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjHNQxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjHNQxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:53:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F44493
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-523476e868dso5903969a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692031988; x=1692636788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdo4aPIJMVIPLemByDptHi3WFRguDIQE8+/EROoyEcs=;
        b=PgtDoxMWE9JpohG8E4jdoZBWMPpDszlhA/akmH2RQHT14Mw6ka93stbss0cnULnZLB
         blt2DP+zmsx3m+DGLIQ9QtRl+UDjTS2FIy4Ibvy5XHmqlbL7qyYsXNArOHZBi44G3RXe
         BUQ7xm18fmWAvRksHDhoFM4pP6KO89v9wXOP6QoWmRhsta0iO514OiRqoCyyqHqgz1T+
         mrKnuWzYBox2aF9fT5xZalBi/WRS0RUP5w+jxIdL2eac5kAjzf6V/5Ft/bzjnIKy4qVQ
         oc54xWm3v5ZL280m0uGhT0eN5LV59x8Ik6qTRaMkwmxU7JLgo4+M9DzLtdyNo38iJoBn
         zRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692031988; x=1692636788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdo4aPIJMVIPLemByDptHi3WFRguDIQE8+/EROoyEcs=;
        b=NpuO1gisZUY6HCsYmqAx5sk2BybT4lL4MxxvTgPDChQSutQ30PchLXxatcXoDpWZyf
         3VUIWb47oD3pn4GiQOn0wmbWQeRORllf2eL5/wHZ2c1Zn+5d/MMDNHTs9lcKgDV4YnIU
         2oZ14Xii1oJsTjgTcqUp/NFZss1u2wjziz8DS/7mg+oCTPbh5kX0tvno4UMkkGeo5f0Y
         qOnpmKDzu3bugz/Zr01vFuevIcSLMEwc+avMLcVYxCmwfnFHrUseqF2MuSXJISumaFGG
         +t2DrT8HLmkBup+adRSncSG4CO5jtBQFncJdbeqvi9AlIS4oylGYpooLp9aMmYPLExH1
         DVWg==
X-Gm-Message-State: AOJu0YxBdOpGnAUquLWl0OUoVuN1Jmh+LScoG0jScF9U1gS0JhfMlb+6
        MKLR2PxxWAtQmRswFP9lTJZSLZMjn/Pp1/Ozmqc=
X-Google-Smtp-Source: AGHT+IEJIF03MSvt8taMToTVtuN5wmoW6XnjnHO495LY9VfL79GTPb+SgIbt67y4Oee1mX58INK8GQ==
X-Received: by 2002:aa7:d390:0:b0:522:30cc:a1f4 with SMTP id x16-20020aa7d390000000b0052230cca1f4mr7913079edq.0.1692031988671;
        Mon, 14 Aug 2023 09:53:08 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:07 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/22] nvmem: uniphier: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 14 Aug 2023 17:52:39 +0100
Message-Id: <20230814165252.93422-10-srinivas.kandagatla@linaro.org>
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
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/uniphier-efuse.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/uniphier-efuse.c b/drivers/nvmem/uniphier-efuse.c
index aca910b3b6f8..0a1dbb80537e 100644
--- a/drivers/nvmem/uniphier-efuse.c
+++ b/drivers/nvmem/uniphier-efuse.c
@@ -41,8 +41,7 @@ static int uniphier_efuse_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, res);
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-- 
2.25.1

