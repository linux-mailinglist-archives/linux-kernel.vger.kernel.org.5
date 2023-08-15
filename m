Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A690977CF78
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbjHOPpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238188AbjHOPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:44:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04ED10DC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:44:55 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68879fc4871so16830b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692114295; x=1692719095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmLPugTGz1sgSy2J/v99Dk0J3o8zfc9d+fDcwlxsiEo=;
        b=hPdGnKSUgljhFqFsgGLQzZfUk5Zd5v3vXX+lFx5n/q9s02AfGmaHSqc010GOa/OM3f
         aNaofPdOvBFPFjUmGdt3gDNvOc1wV1TJoZpvyVHeBIsK21QCzXmvuoygHnn6HnbssZcB
         EsnO0+NmyNRllTqEzVtLDpy5CY61OZisnow1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692114295; x=1692719095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmLPugTGz1sgSy2J/v99Dk0J3o8zfc9d+fDcwlxsiEo=;
        b=S0vCnZi7GLEmD48ccHR+F4Y4XTanPllw69UX20BYLN6HPf/bbHck/U1sfLsq6Li6/K
         A5lAYwC91hzkb474Ev5dGR7itZUX1we6mTW9F6Yc3amYTPB81BF10XnFVtQOegBb8xyi
         VKcHLFRfz7m3nQm2owf7QPNqw4JXtcU2R8CF3JT58lePz+9VheGdc10UhCvQcNCJlwPY
         m2uGaBC0wYDVgx1fxpmznNFY4mNzfzESfLMMwZUunnhCwmnW2zZ7of8pIZ6QR3zbleOD
         GFdPiBv8f4traeKkwLJGy2Hioe+Qz4nIKJaxLXJB65O6U0u2COCXsXvIoA6pQxrK6JLC
         jmqw==
X-Gm-Message-State: AOJu0Yx/RcWIuDtW4nhga+hY7BfR75NVwldjovMFUHL8+AeEElGzXFh+
        6XZY9vII+mKk+ofFy3RocPNR+A==
X-Google-Smtp-Source: AGHT+IFGfwXqvhlQgK3dZJYanVm1WhEoRWmNzCEnvvClZuT/nup6kWHRH9gSZE0NGJjts8ZfBG+bbA==
X-Received: by 2002:a05:6a00:1a50:b0:668:73f5:dce0 with SMTP id h16-20020a056a001a5000b0066873f5dce0mr12705130pfv.29.1692114295080;
        Tue, 15 Aug 2023 08:44:55 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:40cf:3807:f8c8:2d76])
        by smtp.gmail.com with ESMTPSA id n13-20020aa78a4d000000b0065e154bac6dsm9431247pfa.133.2023.08.15.08.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 08:44:54 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        "Miquel Raynal )" <miquel.raynal@bootlin.com>,
        "Richard Weinberger )" <richard@nod.at>,
        "Vignesh Raghavendra )" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 2/4] mtd: spi-nor: sfdp: read disable-quad-mode property
Date:   Tue, 15 Aug 2023 23:31:53 +0800
Message-ID: <20230815154412.713846-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230815154412.713846-1-hsinyi@chromium.org>
References: <20230815154412.713846-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some flash devices, eg. gd25lq64c, enable quad mode by default after
spi_nor_parse_bfpt(). However, the systems using these flash devices may
required the quad mode to be turned off to use write protection or to
avoid a potential short issue[1].

Add a disable-quad-mode property in devicetree that system can use it to
override the quad mode status parsed from BFPT.

[1]https://www.elm-tech.com/ja/products/spi-flash-memory/gd25lq64/gd25lq64.pdf
page 13

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/mtd/spi-nor/core.c    | 5 +++++
 drivers/mtd/spi-nor/core.h    | 1 +
 drivers/mtd/spi-nor/debugfs.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 614960c7d22cc..dcf4ff46c37ae 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2847,6 +2847,11 @@ static void spi_nor_init_flags(struct spi_nor *nor)
 	if (of_property_read_bool(np, "no-wp"))
 		nor->flags |= SNOR_F_NO_WP;
 
+	if (of_property_read_bool(np, "disable-quad-mode")) {
+		nor->flags |= SNOR_F_DISABLE_QUAD;
+		nor->params->quad_enable = NULL;
+	}
+
 	if (flags & SPI_NOR_SWP_IS_VOLATILE)
 		nor->flags |= SNOR_F_SWP_IS_VOLATILE;
 
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 9217379b9cfef..b06bd97668f3a 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -133,6 +133,7 @@ enum spi_nor_option_flags {
 	SNOR_F_RWW		= BIT(14),
 	SNOR_F_ECC		= BIT(15),
 	SNOR_F_NO_WP		= BIT(16),
+	SNOR_F_DISABLE_QUAD	= BIT(17),
 };
 
 struct spi_nor_read_command {
diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
index 6e163cb5b478c..c17451ae0931a 100644
--- a/drivers/mtd/spi-nor/debugfs.c
+++ b/drivers/mtd/spi-nor/debugfs.c
@@ -28,6 +28,7 @@ static const char *const snor_f_names[] = {
 	SNOR_F_NAME(RWW),
 	SNOR_F_NAME(ECC),
 	SNOR_F_NAME(NO_WP),
+	SNOR_F_NAME(DISABLE_QUAD),
 };
 #undef SNOR_F_NAME
 
-- 
2.41.0.694.ge786442a9b-goog

