Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D677F14D0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjKTNv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjKTNvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:51:38 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC00D78;
        Mon, 20 Nov 2023 05:51:26 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50aab0ca90aso1754615e87.0;
        Mon, 20 Nov 2023 05:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700488285; x=1701093085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJJcNZQjoxDpL64YJUPbX5zAdxkULtiEGewpt5HLNRQ=;
        b=lNI38QJY+hLhb05yxNU8aMXdbP1ccm/A0KKezhus2NmfKLnTP4uHCMNTI6LLwd7DSp
         nn5rlkvXOjpv/CXXgEb66R0q2leOEKyYbOa46FQUPzt3PCgPy9hdQf9RqPlrl+NEKATz
         o6N9Vetc2vlV3NLSNZv8nTdQAZKRo40kKIcHjuTjU2WOG3mBFf171uDNFSppiSilg7Uw
         62c/gg+Qje3XFS5+euq2MScISJff7hfxVum1pVEcQ7dgH6ix+LekQ085hs6KiOmEZxmN
         nMtjN2dcVNekncsvx69VxkfEjz+LE+3l0ci67Wn+AbcUZbinAhBXSqmG0+dWqMU9vzS9
         pQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488285; x=1701093085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJJcNZQjoxDpL64YJUPbX5zAdxkULtiEGewpt5HLNRQ=;
        b=lEf3HYlrB5hMDVRormqdUBwGzfCuAbV8zOwui9bPvUyuJpRuczIW9dhgQjtJo4m7Ca
         L8HE6rc5K6wa/BXF1DEMo4nGtqlY+ppez1GQO1vJkuFrtCP/OifWMIIVCiqzxNM0VK3e
         zo1Pkmj0AjLe1DcagFzGf0X2rcnHb4rw9JWAzYNZGMB9WqEiXhRf1Y0OPjJrwa1RNGNf
         u9AZ4ltiOygEb+EWooBDH7MkaaugkV1N/BHCSGH3y0oXOWplJfC+iWW/2IP/6UNetqr0
         kfk978w+4ujgPHo7Xj5n37D9TjwtpZvwgvOMl+P4dJRzCIdr5dgAx3EiWgzN8M2F5EGD
         VhmA==
X-Gm-Message-State: AOJu0Yw8zyQpUBc/5bg1DpHUFE8JYLn47eZ5qvLQKy7Gp/JaiorfiNz+
        AiLeCqHpO9FQOJaD33+N/Zo=
X-Google-Smtp-Source: AGHT+IHEV5yAbedHXZPHvi496M5AnmqBvoItl/mLTRfObKuQHz0eqFU2KUnKLxPwW2KQ8CFk9bb54A==
X-Received: by 2002:a2e:7302:0:b0:2c5:ee7:b322 with SMTP id o2-20020a2e7302000000b002c50ee7b322mr6395660ljc.18.1700488284849;
        Mon, 20 Nov 2023 05:51:24 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j33-20020a05600c1c2100b0040772934b12sm18205846wms.7.2023.11.20.05.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:51:24 -0800 (PST)
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
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [net-next RFC PATCH 08/14] net: phy: add support for PHY package interface mode
Date:   Mon, 20 Nov 2023 14:50:35 +0100
Message-Id: <20231120135041.15259-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231120135041.15259-1-ansuelsmth@gmail.com>
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
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

Some PHY in PHY package supports running only at a specific mode for
each PHY in the package. Add support for enforcing this special thing a
verify consistency with the requested mode to prevent misconfiguration.

To set the PHY package mode, simply set "phy-mode" in the phy-package
node. Each PHY on init will verify if the requested mode match the one
set for the PHY package and will return -EINVAL if this is not true.

If PHY package doesn't specify any mode, it's assumed that PHY in the
package doesn't have such limitation.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_device.c | 37 ++++++++++++++++++++++++++++++++++++
 include/linux/phy.h          |  6 ++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0b7ba6995929..73af4197a7af 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -25,6 +25,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_net.h>
 #include <linux/netdevice.h>
 #include <linux/phy.h>
 #include <linux/phylib_stubs.h>
@@ -1225,8 +1226,17 @@ static int phy_poll_reset(struct phy_device *phydev)
 
 int phy_init_hw(struct phy_device *phydev)
 {
+	phy_interface_t package_interface;
 	int ret = 0;
 
+	/* Validate we are requesting consistent mode if we
+	 * are in a PHY package and the PHY package requires a
+	 * specific mode.
+	 */
+	ret = phy_package_get_mode(phydev, &package_interface);
+	if (!ret && phydev->interface != package_interface)
+		return -EINVAL;
+
 	/* Deassert the reset signal */
 	phy_device_reset(phydev, 0);
 
@@ -1776,6 +1786,32 @@ void phy_package_leave(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(phy_package_leave);
 
+/**
+ * phy_package_get_mode - get PHY interface mode for PHY package
+ * @phydev: target phy_device struct
+ * @interface: phy_interface_t pointer where to save the PHY package mode
+ *
+ * Gets PHY interface mode for the shared data of the PHY package.
+ * Returns 0 and updates @interface with the PHY package value, or -ENODEV
+ * if PHY is not in PHY package or -EINVAL if a PHY package interface mode
+ * is not set.
+ */
+int phy_package_get_mode(struct phy_device *phydev, phy_interface_t *interface)
+{
+	struct phy_package_shared *shared = phydev->shared;
+
+	if (!shared)
+		return -ENODEV;
+
+	if (shared->package_interface == PHY_INTERFACE_MODE_NA)
+		return -EINVAL;
+
+	*interface = shared->package_interface;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(phy_package_get_mode);
+
 static void devm_phy_package_leave(struct device *dev, void *res)
 {
 	phy_package_leave(*(struct phy_device **)res);
@@ -3270,6 +3306,7 @@ static int of_phy_package(struct phy_device *phydev)
 		goto exit;
 
 	phydev->shared->np = package_node;
+	of_get_phy_mode(package_node, &phydev->shared->package_interface);
 
 exit:
 	kfree(global_phy_addrs);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 1849fc637196..8af0a8a72b88 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -341,6 +341,11 @@ struct mdio_bus_stats {
 struct phy_package_shared {
 	/* With PHY package defined in DT this points to the PHY package node */
 	struct device_node *np;
+	/* PHY package interface
+	 * If defined, each PHY of the package MUST have the interface
+	 * set to the PHY package.
+	 */
+	phy_interface_t package_interface;
 	/* addrs list pointer */
 	/* note that this pointer is shared between different phydevs.
 	 * It is allocated and freed automatically by phy_package_join() and
@@ -2014,6 +2019,7 @@ int phy_ethtool_nway_reset(struct net_device *ndev);
 int phy_package_join(struct phy_device *phydev, int *addrs, size_t addrs_num,
 		     size_t priv_size);
 void phy_package_leave(struct phy_device *phydev);
+int phy_package_get_mode(struct phy_device *phydev, phy_interface_t *interface);
 int devm_phy_package_join(struct device *dev, struct phy_device *phydev,
 			  int *addrs, size_t addrs_num, size_t priv_size);
 
-- 
2.40.1

