Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2F0785949
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbjHWN3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjHWN24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:28:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618191707
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c4923195dso730633766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797285; x=1693402085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdo4aPIJMVIPLemByDptHi3WFRguDIQE8+/EROoyEcs=;
        b=AIWZU/hOQl5KrLh/K8yfBcr41SQ6QHBTiVo/hqicqirZ5qbhlaD/Svt8XnC9RU6qei
         gFiixIdsoGK9PvcdZEn7OXBAydgoda611UPPfY1hFUJqMbBeMHG1b32VSZpZ6XYatjy/
         6zpmi70x+BldfmJ8ZJpOaOT+GHnHYzzG55Nb67sKkYuUGyVMlplxsAV8naLX00LOaC5k
         DuxIN1AEA6/myTQ5T3ZJMnzV2byrdZWHGHS6+r1efXo6thlau4Cv0nUb6LYfNYHReREJ
         flRb6lMHkGyaDTRVMt+E3/BlhWFMzU+hW6pg+3BL+rvbtXp410fD6lG+sHVvDdDAN3xa
         1qBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797285; x=1693402085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdo4aPIJMVIPLemByDptHi3WFRguDIQE8+/EROoyEcs=;
        b=LFp8bli1pfvS3mokBCfgyjhunSRCiXXVJwcOIhGu2mSJm736F2HDTHJvJIkiA11G0V
         VnBUdfR5VtZ7AhbtkqTIWcVLIhKOqm96VZsTfZLyiYf9snP02rDnhXuy+pU4+rW/pka8
         597JHTkm/G60b7TGiSgR5r8K6iaTQRZpGR85DSu0YE7hETwxgOzjUcMgFtQcONr+b81N
         5jb/2h/j/o8/49o5Iv80rhFaX+0e7U5DYGcsd0jdAaf2fSEG2BqS5Qik/M4bFochBGdT
         RFQgmLlWcJzZrSYHRTJrP9dv4BTd+iaZeNPal72GV66jHIF+JMh5a+pCYs6PrDGcpPEO
         zC2A==
X-Gm-Message-State: AOJu0YwYFkHFPWd7d2wZjzWfYwqCXJtSDKSmtkpZ5bZrToEwDzm6yQHT
        qlbmo61a96OiWUALcnuw1oJ4XtSJnjEflee9Gy0=
X-Google-Smtp-Source: AGHT+IGgRrz6E5LLSG1f4+zRsJi6dKZlNoYZS0D/g/1obhyKC4WozaQlbqD0LB3maRk387O2XLRqJA==
X-Received: by 2002:a17:906:5392:b0:9a1:debe:6b9b with SMTP id g18-20020a170906539200b009a1debe6b9bmr1336223ejo.35.1692797284993;
        Wed, 23 Aug 2023 06:28:04 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:28:04 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 09/22] nvmem: uniphier: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 23 Aug 2023 14:27:31 +0100
Message-Id: <20230823132744.350618-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=pkriy7pXhcec4sN1z/FJ6a+cx+QVy/VxYh2NlcKlu5o=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glH0hzffnM3PWIecpyEiiXht9+a58ZeZB6Zv qpGJkOR67SJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJRwAKCRB6of1ZxzRV N4X3B/4qt0Y3ryTL/232T0dwOL9FsNl6hyGv/i1VC7UmPpBJvan7hLJdBIuv8+YZdnDk47yA9Nv 4MHWXiODD+aJQNY5p3SbyKBqMZ1wErclRBtSql8Zt/iXjGhAxcn0UrhJD7VobsqM/rjru1IVPKO TSu2jHFc/+/KOiiErGrX3xOK3p8k5Y6yLYfIUMHNkcJURk1vL7y+qApS98DUpY2VKLiSOl27ym1 /DZjzX64VUu8vKAIKpFjM67v7K45tZiFZb3vdTvQ5UjJuCKG+kELgKnP5occA5HtsEKsthjrWCf x4R5rapiUoSIbHZ4vUXz2RYVDYGnVrNuuNQop4+xSMYEd6L5
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

