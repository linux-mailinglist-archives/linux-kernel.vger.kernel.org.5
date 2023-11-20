Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738407F14CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjKTNvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjKTNvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:51:36 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F2CD4C;
        Mon, 20 Nov 2023 05:51:21 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40806e4106dso10789515e9.1;
        Mon, 20 Nov 2023 05:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700488280; x=1701093080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TooJwdKX/NbwarJe/arvXU+/yWQ/ijJnXp3t5io/O14=;
        b=lR9zlysfLiOA/JebJWYcU0QaVOVjrPpSRo6Qf8eYzGzQ3QV1H2l8+KKsTCzo5mvkP4
         +mDS7PF5tBX0ywO+zPxZLAedhZ5eobXFISp9tCLsqLg9nWBmA1AnkByU3XxdhXsW9orj
         b39TqSZOVh1ZVR/t1ZkEv0m9N5WGBRPUlvHGNzNm26RxLc3E+nmiA6StHBDh9TI+MA0d
         WSG+go6FLtN1UADyF7fdif3jD+gmrZwiyBrHT36WHHFwWR51SoKbrIkL7M6jqTnba6B9
         9n/t2RtBVLtLOHYwPObFwAk/6NREnRqYrwplxutMb/N4M/LiOiUWVSU8VAhZZCNpT2Lg
         mWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488280; x=1701093080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TooJwdKX/NbwarJe/arvXU+/yWQ/ijJnXp3t5io/O14=;
        b=AK8IF78/6+OHrIod9k0D65JltuecX99PDWGdlHsE7MJb+21X+y9PwnG6zr3/zF9KW1
         t4X6Kk/YQus02r1AIi6TAjAnchdEc8OMsMdbU+ORSi8UnOlullotfWRt0dm7BFlfCrKd
         IUjQHTpuE434JkDF/UNRfo73w4tdP9MKUhNkcL9mOjxq/Wdo5vtRqauC/HUwsWsmcW09
         0Dv8efPtZnrCaoZy8jd/g9Oj4vZIXgYpVDiUKOZVdGnrodY5uF6OPzIue64xna1ICNBU
         HDKhPjhO4zBCRSlHLwsz9ylt2GBRKfXGcd+n4LfcwdUrTApOdqn5g53pBkgsUtmRJq2/
         8iiw==
X-Gm-Message-State: AOJu0YxuJYVWtinj20vzWfz9Uly+K1VlgY8Il5zZ/B4ajPj3mtNKaqdC
        QtlDuZPUK6FsYuMC5i16pZo=
X-Google-Smtp-Source: AGHT+IGbR/jLe62wvESEe8CFVjFJBQOHE36zG4blKfXpV72kg2YCPBmafC4MW5hggXNjObGvZiPqSQ==
X-Received: by 2002:a05:600c:1c22:b0:40a:4c6c:c87a with SMTP id j34-20020a05600c1c2200b0040a4c6cc87amr6787606wms.3.1700488279771;
        Mon, 20 Nov 2023 05:51:19 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j33-20020a05600c1c2100b0040772934b12sm18205846wms.7.2023.11.20.05.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:51:19 -0800 (PST)
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
Subject: [net-next RFC PATCH 05/14] net: phy: add support for named global PHY in DT PHY package
Date:   Mon, 20 Nov 2023 14:50:32 +0100
Message-Id: <20231120135041.15259-6-ansuelsmth@gmail.com>
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

Add support for named global PHY in DT PHY package definition.
A phy-package node can provide the property "global-phy-names" to
provide named global PHY to correctly reference the phandle defined in
the global-phys list.

Each PHY driver has to define the .phy_package_global_phy_names list
to verify correct order of named PHY phandle defined in DT with the
expected order in the PHY driver.

If the list is not defined or "global-phy-names" is not defined in
DT, global phy addresses are insered in order defined in the "global-phys"
property.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_device.c | 13 +++++++++++++
 include/linux/phy.h          |  6 +++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 9ff76d84dca0..452fd69e8924 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3198,6 +3198,7 @@ static int of_phy_package(struct phy_device *phydev)
 	struct device_node *node = phydev->mdio.dev.of_node;
 	struct of_phandle_args phy_phandle;
 	struct device_node *package_node;
+	const char *global_phy_name;
 	int i, global_phys_num, ret;
 	int *global_phy_addrs;
 
@@ -3236,6 +3237,18 @@ static int of_phy_package(struct phy_device *phydev)
 		if (ret)
 			goto exit;
 
+		ret = of_property_read_string_index(package_node, "global-phy-names",
+						    i, &global_phy_name);
+		if (!ret && phydev->drv->phy_package_global_phy_names) {
+			const char *name;
+
+			name = phydev->drv->phy_package_global_phy_names[i];
+			if (strcmp(global_phy_name, name)) {
+				ret = -EINVAL;
+				goto exit;
+			}
+		}
+
 		global_phy_addrs[i] = addr;
 	}
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5bf90c49e5bd..5e595a0a43b6 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -892,6 +892,10 @@ struct phy_led {
  * @driver_data: Static driver data
  * @phy_package_global_phy_num: Num of the required global phy
  *   for PHY package global configuration.
+ * @phy_package_global_phy_names: List of global PHY names used
+ *   for PHY package global init. If defined, list is compared
+ *   with DT values to match correct PHY phandle order. List
+ *   last element MUST BE an empty string.
  *
  * All functions are optional. If config_aneg or read_status
  * are not implemented, the phy core uses the genphy versions.
@@ -910,6 +914,7 @@ struct phy_driver {
 	u32 flags;
 	const void *driver_data;
 	unsigned int phy_package_global_phy_num;
+	const char * const *phy_package_global_phy_names;
 
 	/**
 	 * @soft_reset: Called to issue a PHY software reset
@@ -1154,7 +1159,6 @@ struct phy_driver {
 	 */
 	int (*led_hw_control_get)(struct phy_device *dev, u8 index,
 				  unsigned long *rules);
-
 };
 #define to_phy_driver(d) container_of(to_mdio_common_driver(d),		\
 				      struct phy_driver, mdiodrv)
-- 
2.40.1

