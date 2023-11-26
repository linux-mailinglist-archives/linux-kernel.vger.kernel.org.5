Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096C97F90BB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 02:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjKZBx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 20:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjKZBxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 20:53:52 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F81C6;
        Sat, 25 Nov 2023 17:53:58 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40838915cecso22031875e9.2;
        Sat, 25 Nov 2023 17:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700963637; x=1701568437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6/qmHve1L25MiRLoatLwS+Zmpj0CqjsbvwNeXg845w=;
        b=kx1nTZWxMd/kGgWm8ONOiFZKEPxDg4SQGw1u1qnRzFPK1j4TfVc4W6DoErQXt+2ORX
         U3PsVqSkk9ULkI1nnXtEFyQ/w/lQMT441dhU93/yyFQRqEyUvDpjB5MhUpCt7iuoB/ev
         WEuvLw8aVuSUAE3blItgwLo6wO+KmvwogCgkQNuXLKjwmXG/4yT3E0Uvdwh30Vfv4DIP
         kpVxvDA0sS5QWok48t8ew4GUyeqTu8ppgjVaOL4bBo7K4qeDBji0cbRagpIKUZxeoxsU
         vLBbEY7uP0y0PbNDl6fKqTqXJ9HkQC5jMtdwKj8W677cAR/LQXIAtTmJOBgw3+f5Vk1e
         GVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700963637; x=1701568437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6/qmHve1L25MiRLoatLwS+Zmpj0CqjsbvwNeXg845w=;
        b=PsV2Pz3oBL5oFenUaiCVTRs60FBe2dO4HQdtZSO0gkMdO5nVQCJxT5zIxw2ZeJGP0F
         pfYGzcXdKvTdX4lpRvBZPYE/q89O9ZDt4piEFbtVvQ1RBIdXdIscnUlAKpxkSd+PBd2j
         LCLpWHbLvpO1/tWjuiKhY2bH5s2RlxM4ZVdEKWhnAEolwas6GWdSihttt/8P7Pa3NfF2
         cWL1gDVr9vix1rh+YZfy81BmrTIhiokGOeWTe561+lI9laIBmMHO3IAQvMko9r6g69V6
         RxlQOb5A1LHPFoQpI2ztcUBNoCXyIiVOow1ru6DxVLELt0qHgZ9t2f+42nmRuTTUeiYN
         DNNQ==
X-Gm-Message-State: AOJu0Yy9vvk46WwnbUfQHYFN0eEHq5j8eJhZH6KL3H2XlEQEUgMevKaT
        aY8W1lyAdqfDdPCz5Fxo4yo=
X-Google-Smtp-Source: AGHT+IGFPIhYuPbdoh4RQpznTFaMlEGRX1LxY1xuT3XNZe5QH9o+8Q9NhKq9xrZp6+5zj8BaO1AVEA==
X-Received: by 2002:a05:600c:3306:b0:40b:36d3:ce0a with SMTP id q6-20020a05600c330600b0040b36d3ce0amr1961117wmp.16.1700963636826;
        Sat, 25 Nov 2023 17:53:56 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id p34-20020a05600c1da200b00406408dc788sm9875344wms.44.2023.11.25.17.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 17:53:56 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [net-next PATCH RFC v3 3/8] net: phy: add support for shared priv data size for PHY package in DT
Date:   Sun, 26 Nov 2023 02:53:41 +0100
Message-Id: <20231126015346.25208-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126015346.25208-1-ansuelsmth@gmail.com>
References: <20231126015346.25208-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for defining shared data size for PHY package defined in DT.

A PHY driver has to define the value .phy_package_priv_data_size to make
the generic OF PHY package function alloc priv data in the shared struct
for the PHY package.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_device.c | 7 ++++++-
 include/linux/phy.h          | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f416f7434697..87f06b4ecbfe 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3178,6 +3178,7 @@ static int of_phy_package(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
 	struct device_node *package_node;
+	int shared_priv_data_size;
 	u32 base_addr;
 	int ret;
 
@@ -3194,8 +3195,12 @@ static int of_phy_package(struct phy_device *phydev)
 	if (of_property_read_u32(package_node, "reg", &base_addr))
 		return -EINVAL;
 
+	shared_priv_data_size = 0;
+	if (phydev->drv->phy_package_priv_data_size)
+		shared_priv_data_size = phydev->drv->phy_package_priv_data_size;
+
 	ret = devm_phy_package_join(&phydev->mdio.dev, phydev,
-				    base_addr, 0);
+				    base_addr, shared_priv_data_size);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 80a4adaeb817..c4e6d0b3a86c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -884,6 +884,8 @@ struct phy_led {
  * @flags: A bitfield defining certain other features this PHY
  *   supports (like interrupts)
  * @driver_data: Static driver data
+ * @phy_package_priv_data_size: Size of the priv data to alloc
+ *   for shared struct of PHY package.
  *
  * All functions are optional. If config_aneg or read_status
  * are not implemented, the phy core uses the genphy versions.
@@ -901,6 +903,7 @@ struct phy_driver {
 	const unsigned long * const features;
 	u32 flags;
 	const void *driver_data;
+	unsigned int phy_package_priv_data_size;
 
 	/**
 	 * @soft_reset: Called to issue a PHY software reset
-- 
2.40.1

