Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E0E785945
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbjHWN24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbjHWN2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:28:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EE610CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99cce6f7de2so765196366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797281; x=1693402081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTLyzq+CmYuG8lZJh8FVcULeSIxdJ4wT6H5hFMK4AT4=;
        b=BuKGGl5Z5AxzcdbTewz+Vb1xKA4Kfij64gkqKubkEXMfmMdCto9JGw94HjCF+9fDPF
         JMA6grMghZOfVEyb1zFB1ZHSYUZ4gBKsbDG7NRjfmbL9QPZobSf118H4ColT3uZdumRE
         rtkX+XAnLZFGTFnaX5E1xKECJMywrupZJDP85jbe98afxStMgVnlyYAlvSYjBznDrIuh
         0fHkeVqJsLFjsyyAmlw0RfAY3OSQwen/sMj0dXMoyH/bJmt58EiX4NOQ/Wf05kymg3N5
         hH1nC9oKhE1y/zCtaavH8HaEAw4MElv9MHUd384GC1ahzIRwZi+w7RBArQXr7JZT8SyZ
         3gNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797281; x=1693402081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTLyzq+CmYuG8lZJh8FVcULeSIxdJ4wT6H5hFMK4AT4=;
        b=Uwga0hiy5ynq+sTom8hfjtNPB9oD5mZE+oqaQph160u6UkNBtSgpOH6IIgLtoPm5Gy
         kKmxSjx+VQFbxqmDH8bd1qRsNUy9ySKRQAoJmGI6kieyhiEeucC2enjr+eiUyPc9iheI
         FvSV8rwp8b2ezWkMp25Xput+jIRM0CebOyHwG9IzHElKCLRaxP+Cp7S5sJI+dR/6Cir2
         eJQH/tJKkYGBO+Cy/gqsS3KRNq9g7vGLsL9PXaMXiUww0OKCdLFaIg52USwCsSHSFG1N
         pGlyMRwC5GZlJ2lwyMWeUYoR7XONjuYmpeZ9o448bsPH1G+ikAn6vR2H8mlgP0kZaSBc
         xIAw==
X-Gm-Message-State: AOJu0YwinjH3m2Vq6tCrOo/5/DQ9/70okXpBKVk+Dv8q8M9lQjQc7nI8
        hSe/uWar48goMx1+o+TQYHNzJQ==
X-Google-Smtp-Source: AGHT+IEiTSeKeEjd9iqkWG7ZkLw9hJPFwQ63O0CBhMB4n8nJasDdPecoLkMPs63tRX/Af6wC5S4Hvg==
X-Received: by 2002:a17:907:2c48:b0:99d:6b3c:3d40 with SMTP id hf8-20020a1709072c4800b0099d6b3c3d40mr9100257ejc.6.1692797281671;
        Wed, 23 Aug 2023 06:28:01 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:28:01 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 06/22] nvmem: rockchip-efuse: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 23 Aug 2023 14:27:28 +0100
Message-Id: <20230823132744.350618-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=wT2UYdUVSvolFgk3Jn1XmE5iUG1nUKY5ixUGad4ElRE=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glF78Pfsjbqc0hDApYmirQzJpE9Z1l77EsLb fvTGHhFZWOJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJRQAKCRB6of1ZxzRV N0dmB/4hXBEKbH05q8yPShfwUjbwPZHE+G4zcdOEsq0Oud7H0g8T5AV/nuDCGbQVAUaSj/J9ZXN rmTmwXmbCJwMPT8iD8X6DQFybBhgaXUrnfZIAc8eOIBvP6zIyEAhPDY/423OFflbvIG3x7PhJ/Z s4qoNvVzkcYW5vKiQDgN3R/tJNy9KBCIrKHmhDG/Z4fJQ31MwTNAMs0d53+h2g/sCUaGiDXyxLt sdigkOakG4wyz3QmuAOnPzlJHJBn21yoi7jI6y61uPRbZP9R89YjDZoXavPz+M/eomBglFrg5cd +sxMlsPe+5CDUIXhCq4ngwEnLEvh2mz0lcPCjNvtBO4nttbo
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

