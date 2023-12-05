Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E442580505C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376423AbjLEKgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbjLEKgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:36:14 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD5B1B1;
        Tue,  5 Dec 2023 02:36:16 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9f413d6b2so33424691fa.1;
        Tue, 05 Dec 2023 02:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701772574; x=1702377374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzWpHNK+8WZxV0Za4rmkABjOws2ounqa1/6k9XNQavs=;
        b=Toqk7lDPeI62bqsG6S+Ts1Hj65j5e5wanw8cW3J/cfIbwX6GYyJj7OE7UyUhKyzP9i
         GnL2oWYJU2pbTKA7LPrJK6fJo6zsrvvbOroTNwUgzxuhviU5jdCNU5EcditTiraFu2Ek
         92330nX91CtfAGUWkSyfEwF7oEHxr9lunYFuVLdHtF3y5txHJb0Q4YWv8pwciYPp8YAO
         VTShj5UZFfmW3Z0omFcL0+PK0FHBaN289CNa6sNYTy43Bb0aS80HKy86sYEW7TqAaquU
         HC0HxnAjMFJsnq8NwXjSwKYjTxnGLXv7x1HMsocv2HsUQvtXQUzxpbmaJ1roq00A0q2z
         YsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701772574; x=1702377374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzWpHNK+8WZxV0Za4rmkABjOws2ounqa1/6k9XNQavs=;
        b=jPELmRDnT0ek8rK3hNM/DcXrDbLNLrhCEK/Tl8OmZ6UUdXRX5UoXvW4wKJJdqaGRh/
         X78aBWItPmjSa+YOINKJYcL2xwspS6A8OrIFyhExDE4wOHTr2BTXVvtSW9iWXcLsBCMM
         r2ircErYC3yX8EZzU7y4PdO7XlxMT43trNs0vDcDOxnD84MBqLRMBZlHmfMF2ZtPx9MJ
         5gReMsO1ejzQ9LCXfkTW2g2wynx4/VZjuXvaj20Y3AejBODmcRvfyR7okrF59HkRVR5f
         fSmt+k+Hxu2TP+0WL6zvMa+nF1J4yh0UtPoKhqUr7MVKWTgJHFtyCY+k6kfs3nnjOb3z
         yTqA==
X-Gm-Message-State: AOJu0YxEKVv4FaxoXhngvnoAZm/j2QikEbRVvQ4/TQb42svQYHqyElEh
        SfNVarEDLGyrDesWHERZmx4DiYApM2JV6g==
X-Google-Smtp-Source: AGHT+IGUtfUmSCuTX2LjP6ZYjajVSxD8N2Lsw/qkhIm5j6xbwj8CD37zCqa+WxpE9jr2rYmSCkIo7Q==
X-Received: by 2002:a05:6512:2803:b0:50b:f8e6:caa2 with SMTP id cf3-20020a056512280300b0050bf8e6caa2mr1274366lfb.31.1701772574341;
        Tue, 05 Dec 2023 02:36:14 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id y23-20020a197517000000b0050aaa716c15sm720366lfe.51.2023.12.05.02.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:36:13 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 07/16] net: pcs: xpcs: Split up xpcs_create() content to sub-functions
Date:   Tue,  5 Dec 2023 13:35:28 +0300
Message-ID: <20231205103559.9605-8-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231205103559.9605-1-fancer.lancer@gmail.com>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
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

As a final preparation before adding the DW XPCS MDIO-device driver
support let's split the xpcs_create() function code up to a set of small
sub-functions. Thus the method implementation will get to look simpler and
turn to be more coherent. Further updates will just touch the new methods
a bit: add platform-specific device info, add device reference clock
getting and enabling.

This update implies the xpcs_create() to call the next static methods:
xpcs_create_data() - create the DW XPCS device descriptor,
xpcs_init_id() - find XPCS ID instance and save it in the device
descriptor,
xpcs_init_iface() - find MAC/PCS interface descriptor and perform
basice initialization specific to it: soft-reset, disable polling.

The update doesn't cause any semantic change but merely makes the code
better looking and ready for adding new features support.

Note in addition to that the xpcs_destroy() is moved to be below the
xpcs_create_mdiodev() function as the driver now implies having the
protagonist-then-antagonist functions definition order.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/pcs/pcs-xpcs.c | 102 +++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 32 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index a53376472394..ea6f56339595 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1365,70 +1365,97 @@ static const struct phylink_pcs_ops xpcs_phylink_ops = {
 	.pcs_link_up = xpcs_link_up,
 };
 
-static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
-				   phy_interface_t interface)
+static struct dw_xpcs *xpcs_create_data(struct mdio_device *mdiodev)
 {
 	struct dw_xpcs *xpcs;
-	u32 xpcs_id;
-	int i, ret;
 
 	xpcs = kzalloc(sizeof(*xpcs), GFP_KERNEL);
 	if (!xpcs)
 		return ERR_PTR(-ENOMEM);
 
 	xpcs->mdiodev = mdiodev;
+	xpcs->pcs.ops = &xpcs_phylink_ops;
+	xpcs->pcs.neg_mode = true;
+	xpcs->pcs.poll = true;
+
+	return xpcs;
+}
+
+static void xpcs_free_data(struct dw_xpcs *xpcs)
+{
+	kfree(xpcs);
+}
+
+static int xpcs_init_id(struct dw_xpcs *xpcs)
+{
+	u32 xpcs_id;
+	int i, ret;
 
 	xpcs_id = xpcs_get_id(xpcs);
 
 	for (i = 0; i < ARRAY_SIZE(xpcs_id_list); i++) {
 		const struct xpcs_id *entry = &xpcs_id_list[i];
-		const struct xpcs_compat *compat;
 
 		if ((xpcs_id & entry->mask) != entry->id)
 			continue;
 
 		xpcs->id = entry;
 
-		compat = xpcs_find_compat(entry, interface);
-		if (!compat) {
-			ret = -ENODEV;
-			goto out;
-		}
+		break;
+	}
 
-		ret = xpcs_dev_flag(xpcs);
-		if (ret)
-			goto out;
+	if (!xpcs->id)
+		return -ENODEV;
 
-		xpcs->pcs.ops = &xpcs_phylink_ops;
-		xpcs->pcs.neg_mode = true;
+	ret = xpcs_dev_flag(xpcs);
+	if (ret < 0)
+		return ret;
 
-		if (xpcs->dev_flag != DW_DEV_TXGBE) {
-			xpcs->pcs.poll = true;
+	return 0;
+}
 
-			ret = xpcs_soft_reset(xpcs, compat);
-			if (ret)
-				goto out;
-		}
+static int xpcs_init_iface(struct dw_xpcs *xpcs, phy_interface_t interface)
+{
+	const struct xpcs_compat *compat;
 
-		return xpcs;
+	compat = xpcs_find_compat(xpcs->id, interface);
+	if (!compat)
+		return -EINVAL;
+
+	if (xpcs->dev_flag == DW_DEV_TXGBE) {
+		xpcs->pcs.poll = false;
+		return 0;
 	}
 
-	ret = -ENODEV;
+	return xpcs_soft_reset(xpcs, compat);
+}
+
+static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
+				   phy_interface_t interface)
+{
+	struct dw_xpcs *xpcs;
+	int ret;
+
+	xpcs = xpcs_create_data(mdiodev);
+	if (IS_ERR(xpcs))
+		return xpcs;
+
+	ret = xpcs_init_id(xpcs);
+	if (ret)
+		goto out;
+
+	ret = xpcs_init_iface(xpcs, interface);
+	if (ret)
+		goto out;
+
+	return xpcs;
 
 out:
-	kfree(xpcs);
+	xpcs_free_data(xpcs);
 
 	return ERR_PTR(ret);
 }
 
-void xpcs_destroy(struct dw_xpcs *xpcs)
-{
-	if (xpcs)
-		mdio_device_put(xpcs->mdiodev);
-	kfree(xpcs);
-}
-EXPORT_SYMBOL_GPL(xpcs_destroy);
-
 struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
 				    phy_interface_t interface)
 {
@@ -1455,4 +1482,15 @@ struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
 }
 EXPORT_SYMBOL_GPL(xpcs_create_mdiodev);
 
+void xpcs_destroy(struct dw_xpcs *xpcs)
+{
+	if (!xpcs)
+		return;
+
+	mdio_device_put(xpcs->mdiodev);
+
+	xpcs_free_data(xpcs);
+}
+EXPORT_SYMBOL_GPL(xpcs_destroy);
+
 MODULE_LICENSE("GPL v2");
-- 
2.42.1

