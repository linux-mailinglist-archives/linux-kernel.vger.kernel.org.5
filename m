Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972A87C861D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjJMMtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjJMMtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:49:14 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F94EDC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:49:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so1946739f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697201350; x=1697806150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHWz+2cENNJo8soalNrQC54X+UbYVE7Vc57ND+OacnA=;
        b=rNrz0wIb7Fqj12fcI5xJMlNvLEtnjr6eiYnHgNiT0Ezf1x7xvIqSEFYHnxxB951euK
         qmxRGImx/yGIKW/XF8UaBZGQqt4Z5jLUTqBUpP9O+txCiYeg5x4Sy7XJgjVpXG6sYLrL
         N8mwAFUVNvlVcsMwLljcU98JggaiiaPza0pzL4cHXe/PHRrIfd3Hof0rIxy57Mmjmxxa
         lj02y/bJ5NPo0LDDjS62LHxPWIRgIpErlUkCesoKaJ6vvjzdDax1ET7EJlYXZyySgvzb
         379cpDeIDgu4C3XJSsoJtMT0wGv2a1r9bq89dDCRXeFlTbJBybPN8kOpENs8U2DdSVbZ
         qQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697201350; x=1697806150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHWz+2cENNJo8soalNrQC54X+UbYVE7Vc57ND+OacnA=;
        b=w4RKzQUBAKqBRR4a+MHz2EihFj0VLQEVlJRRp2t3zFqUhEV+Q9QngRLWkMVslRivop
         +KDOQHKZy423mZFy3z0UqZwJj4lUuprgpd8KtJ2YzsCF8o3TYlhrt2Mj7imcNZ5XrBmx
         Ab07ztfhwM9iP+/XVwFrVCN6SOugSVndBhQqI5jnILfMN2IlBc02ZwCmImgQv9542FDE
         4CS6gaPbM2x9RlNgSf0slFnZc0kiDsTS6Vrgh23YrAI0ZGhs0DW28KEBNpqbO/YMD/S2
         Df/Cfn0URHCYcvp2fPm+VRktdV4dPE3zz6GSIrrB0qjMhSRnD1mJdl1bUm/Z2HIxy8mx
         PQoQ==
X-Gm-Message-State: AOJu0YwSJcWq9rO7wL6nDpwZhs92Oj063nB5194+GGrIAPcO44Kl9ggk
        uM0xUjU+IfdWcIeeak0NT1vlimD6e8IQWg7jTFw0Ig==
X-Google-Smtp-Source: AGHT+IFdKyNswXgqV8YyUSFLJ9/VNa34tD0bTm2EbMeuZXnHOdakJpYme7AEsOScRGQ8ZyexXwZwSA==
X-Received: by 2002:a5d:5b1b:0:b0:329:6e92:8d73 with SMTP id bx27-20020a5d5b1b000000b003296e928d73mr20970919wrb.67.1697201350545;
        Fri, 13 Oct 2023 05:49:10 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id w16-20020adf8bd0000000b0032d81837433sm8035438wra.30.2023.10.13.05.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:49:09 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] nvmem: imx: correct nregs for i.MX6ULL
Date:   Fri, 13 Oct 2023 13:49:04 +0100
Message-Id: <20231013124904.175782-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231013124904.175782-1-srinivas.kandagatla@linaro.org>
References: <20231013124904.175782-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=836; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=ZrAY4rsNvvzr6wfGA3iwhJUERadtqpuGBRNuscN7mxE=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlKTzAhXBlQ+Dta0l39iaO903eTrn2W777na+lJ q72yBAE9EaJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZSk8wAAKCRB6of1ZxzRV N6FBB/97p16dSnWV9TvdWHNK+y6+YHumuxBv5Gi25/7AjdWywVUCH8MV/2a99fwqvsaeZtueSoZ vbcXJTCKx6ZLoJZcLnKZzCBa5PSquj3NfvLJS+29ae7N0ShjAQKu9tMr5imOLFLSvk39unqwimv 6h+8HCvchYoPhBY1nREpsnhg8EdNKsSerls/JdFtOEeCiC32yi9t4q4PVhuNBlOnIg+b5igleoJ wMBc6eBVbii+BF0bMc/5Y9+L+c7Y9O7EwwEGrNC48LD+2vjPgajWIpy16rrGXMVIXKTW3Vu9CLx wNxGu10u2NEqlza8riM68YWuk3tGnxXyUKnd1pWrHmSWoqH9
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
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

From: Peng Fan <peng.fan@nxp.com>

The nregs for i.MX6ULL should be 80 per fuse map, correct it.

Fixes: ffbc34bf0e9c ("nvmem: imx-ocotp: Implement i.MX6ULL/ULZ support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 921afe114a2c..e8b6f194925d 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -519,7 +519,7 @@ static const struct ocotp_params imx6ul_params = {
 };
 
 static const struct ocotp_params imx6ull_params = {
-	.nregs = 64,
+	.nregs = 80,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
-- 
2.25.1

