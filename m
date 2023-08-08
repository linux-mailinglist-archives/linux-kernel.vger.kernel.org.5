Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39035773D2B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjHHQO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjHHQNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:13:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC02D7EC5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:47:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99357737980so848116666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691509633; x=1692114433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie3WcAqbCuJwn+bSe+8uiPLhrE9XYV8epIzLQ3pbcL4=;
        b=vr81aoTYCnVftLlvwc8eEqGW2PKR2AJvxKFAJwSRtDiOD6hSFoy2VjX9y6DAQkvZs+
         /0kChAVrTq8dN3ruHgKOST1WpvDV1XMSjb9M6o3P2kpmPFOqES0AxQ/bZ8MV2l7UXmUT
         huQC/hCpjO9FLTAC9fXDpkQsv6x+yI8EISREb4aX+bZDFGugkTfEIgkwH/clYJ3GswdC
         Ad8/BZsbtoRnwCBWh2Pfm6mugS6Egb8GGTot/IZTxk7dv83Ryeiv+fXpnUMYyqGuFGbC
         ZXWe4hzkzFeznu0hCu5JHfPv4/+pnFvrTe/w4Ff9pHJLADZ7LUcamJP7jB5xtitVIzdP
         SM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509633; x=1692114433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ie3WcAqbCuJwn+bSe+8uiPLhrE9XYV8epIzLQ3pbcL4=;
        b=iMeILgKvIbbWb1BUKh89tJV7+ZfO73tYFo9Pz9TPF9bssGadcgL4GIF7LQITzs/j+P
         TnTN9bdQjDBUgg9enYUFu68C5y4j8KBjUk/qkFNLLmzRYJ40zeo0J5cAwaAy6DAVx9QL
         qZP3jo5zlYqHFJ9NOEqMBG+xGFSUqTGFSOu2e3UH6e0K/LwwNYGMI4Dy8oHjqB/7pE0p
         viz+8GJXTcrOJJiwJ0LsnmxnTYhBx1o0Gbil1aL6nVQQdpyL+xWcRrqxiyq/qbwpiHUc
         amd51iNVn7fGmz0Nvk2vry4TqX24GUeTFFa93CrnLzAjC5Ojb++lTHSxV1VGURnK6EBE
         Cq/w==
X-Gm-Message-State: AOJu0YwbEP4VLr6CmbuYHA+vJmlFM63Qnekic0D3KiB5oYOlKmnwgc7H
        8MAmZXgbYhtUEdBSmqZLRg0K0PIDN6aAy4liaRORUw==
X-Google-Smtp-Source: AGHT+IGUZorkCi64YkQRQ50LyONGuQyCaMkyjeEos2tgFQ6faizt7lG2rcTuyHFQW//RTS5PrFhblA==
X-Received: by 2002:adf:ea11:0:b0:313:f1c8:a968 with SMTP id q17-20020adfea11000000b00313f1c8a968mr8055326wrm.2.1691496185883;
        Tue, 08 Aug 2023 05:03:05 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6a08:bcc0:ae83:e1dc])
        by smtp.gmail.com with ESMTPSA id v8-20020adfe4c8000000b00317046f21f9sm13499726wrm.114.2023.08.08.05.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 05:03:05 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next] net: stmmac: don't create the MDIO bus if there's no mdio node on DT
Date:   Tue,  8 Aug 2023 14:02:54 +0200
Message-Id: <20230808120254.11653-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The stmmac_dt_phy() function that parses the device-tree node of the MAC
and allocates the MDIO and PHY resources misses one use-case: when the
MAC doesn't have a fixed link but also doesn't define its own mdio bus
on the device tree and instead shares the MDIO lines with a different
MAC with its PHY phandle reaching over into a different node.

As this function could also use some more readability, rework it to
handle this use-case and simplify the code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index be8e79c7aa34..91844673df43 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -320,12 +320,14 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 static int stmmac_dt_phy(struct plat_stmmacenet_data *plat,
 			 struct device_node *np, struct device *dev)
 {
-	bool mdio = !of_phy_is_fixed_link(np);
 	static const struct of_device_id need_mdio_ids[] = {
 		{ .compatible = "snps,dwc-qos-ethernet-4.10" },
 		{},
 	};
 
+	if (of_phy_is_fixed_link(np))
+		return 0;
+
 	if (of_match_node(need_mdio_ids, np)) {
 		plat->mdio_node = of_get_child_by_name(np, "mdio");
 	} else {
@@ -340,20 +342,18 @@ static int stmmac_dt_phy(struct plat_stmmacenet_data *plat,
 		}
 	}
 
-	if (plat->mdio_node) {
-		dev_dbg(dev, "Found MDIO subnode\n");
-		mdio = true;
-	}
+	if (!plat->mdio_node)
+		return 0;
 
-	if (mdio) {
-		plat->mdio_bus_data =
-			devm_kzalloc(dev, sizeof(struct stmmac_mdio_bus_data),
-				     GFP_KERNEL);
-		if (!plat->mdio_bus_data)
-			return -ENOMEM;
+	dev_dbg(dev, "Found MDIO subnode\n");
 
-		plat->mdio_bus_data->needs_reset = true;
-	}
+	plat->mdio_bus_data = devm_kzalloc(dev,
+					   sizeof(struct stmmac_mdio_bus_data),
+					   GFP_KERNEL);
+	if (!plat->mdio_bus_data)
+		return -ENOMEM;
+
+	plat->mdio_bus_data->needs_reset = true;
 
 	return 0;
 }
-- 
2.39.2

