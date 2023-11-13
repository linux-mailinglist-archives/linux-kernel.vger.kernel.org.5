Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722827E942F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjKMBkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKMBkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:40:12 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5459B1FDA;
        Sun, 12 Nov 2023 17:40:08 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32f7abbb8b4so2376676f8f.0;
        Sun, 12 Nov 2023 17:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699839606; x=1700444406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=92mM3S+rftnVoyhzP0G9ontuc5Lmaq8xtKxeNl6NQec=;
        b=FruBOy9iu9m9pEdKBJbLTL/TxRf3j2qiwdiBLnYH8ucOHrsfr+RdUDe2W77o3Xt+yy
         7MSUu7jrvXFBbeskiKAZhJALcziXR7QWTOmmJJa2lAb+t127uy5rUgtYyO1WP8un5nH9
         rTZgvKsJ8E9vKbc9MDzrj9dvU3IzxU03++ibyn/uZD1vOcwbz9V49Jtoqq08705rmX1f
         PSzAYeKYL7Ka/e2QdyC6Ukd7b1UhB9FlG+dP4MSmRRO/9aJTR3irKM6hbxS77BVDQ+li
         c6vxpptiinAuWY3PJmchK2PpSgjGyIFoRnd+5ucyuzNiNiwKToZlnOmEIlc93EZpvgSE
         RvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699839606; x=1700444406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92mM3S+rftnVoyhzP0G9ontuc5Lmaq8xtKxeNl6NQec=;
        b=GNdPRzYT5LbcMnb0OsrXf4CHJbbitMqVv4DUPs/d/i2XegrCrW8+tMQYtsTlqUk5MU
         YtipSlztYyH4g73n4obSDWvUjdlasKBBEROqPKc0NvzduZXBbO7rwLLaHIIcdkXK6gDq
         Lbf08p+LDOWlyGIOkjTDaLBictGwa7fQV+6PhxdwhYUoZ2yOwaBlP6aCGt6b8ijY6opk
         sH3Ue+jr7ixlwaFUGHnVpg+DnF5+6ZChoz/Ftlb0vjaTOLZsWAjtOb9LxAuQFZBO6U36
         yhjufF8WrQHwgq+5bjCyOLRcV5ufllovEQctsC959WSPkTtXTUk7semuQEGuSvt+oa6L
         VjgQ==
X-Gm-Message-State: AOJu0YxwWVKSZ1CJ/PKIMY18+pe/sx/AsqU5xBEpeJ1qb64p6fhLBhWL
        0TbBIUSAUhgRfHrO2V0PnBYr0UgqKGs=
X-Google-Smtp-Source: AGHT+IFZy5wWkuI0ag278wevSMrOe7WuThjmfk9GdaUkjAyc3whMMcsaJmu9a8Vpmt/IXU5OnRQ+kw==
X-Received: by 2002:adf:b651:0:b0:32d:81f7:d6f2 with SMTP id i17-20020adfb651000000b0032d81f7d6f2mr3049869wre.30.1699839606117;
        Sun, 12 Nov 2023 17:40:06 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id d16-20020adfe850000000b0032fb17c65desm4257268wrn.19.2023.11.12.17.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 17:40:05 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next PATCH RFC v7 1/4] net: phy: aquantia: move to separate directory
Date:   Mon, 13 Nov 2023 02:39:57 +0100
Message-Id: <20231113014000.22840-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move aquantia PHY driver to separate driectory in preparation for
firmware loading support to keep things tidy.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes v7:
- Add Reviewed-by tag
Changes v4:
- Keep order for kconfig config
Changes v3:
- Add this patch

 drivers/net/phy/Kconfig                         | 5 +----
 drivers/net/phy/Makefile                        | 6 +-----
 drivers/net/phy/aquantia/Kconfig                | 5 +++++
 drivers/net/phy/aquantia/Makefile               | 6 ++++++
 drivers/net/phy/{ => aquantia}/aquantia.h       | 0
 drivers/net/phy/{ => aquantia}/aquantia_hwmon.c | 0
 drivers/net/phy/{ => aquantia}/aquantia_main.c  | 0
 7 files changed, 13 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/phy/aquantia/Kconfig
 create mode 100644 drivers/net/phy/aquantia/Makefile
 rename drivers/net/phy/{ => aquantia}/aquantia.h (100%)
 rename drivers/net/phy/{ => aquantia}/aquantia_hwmon.c (100%)
 rename drivers/net/phy/{ => aquantia}/aquantia_main.c (100%)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 421d2b62918f..25cfc5ded1da 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -96,10 +96,7 @@ config ADIN1100_PHY
 	  Currently supports the:
 	  - ADIN1100 - Robust,Industrial, Low Power 10BASE-T1L Ethernet PHY
 
-config AQUANTIA_PHY
-	tristate "Aquantia PHYs"
-	help
-	  Currently supports the Aquantia AQ1202, AQ2104, AQR105, AQR405
+source "drivers/net/phy/aquantia/Kconfig"
 
 config AX88796B_PHY
 	tristate "Asix PHYs"
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index c945ed9bd14b..f65e85c91fc1 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -35,11 +35,7 @@ obj-y				+= $(sfp-obj-y) $(sfp-obj-m)
 obj-$(CONFIG_ADIN_PHY)		+= adin.o
 obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
 obj-$(CONFIG_AMD_PHY)		+= amd.o
-aquantia-objs			+= aquantia_main.o
-ifdef CONFIG_HWMON
-aquantia-objs			+= aquantia_hwmon.o
-endif
-obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia.o
+obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia/
 obj-$(CONFIG_AT803X_PHY)	+= at803x.o
 obj-$(CONFIG_AX88796B_PHY)	+= ax88796b.o
 obj-$(CONFIG_BCM54140_PHY)	+= bcm54140.o
diff --git a/drivers/net/phy/aquantia/Kconfig b/drivers/net/phy/aquantia/Kconfig
new file mode 100644
index 000000000000..226146417a6a
--- /dev/null
+++ b/drivers/net/phy/aquantia/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config AQUANTIA_PHY
+	tristate "Aquantia PHYs"
+	help
+	  Currently supports the Aquantia AQ1202, AQ2104, AQR105, AQR405
diff --git a/drivers/net/phy/aquantia/Makefile b/drivers/net/phy/aquantia/Makefile
new file mode 100644
index 000000000000..346f350bc084
--- /dev/null
+++ b/drivers/net/phy/aquantia/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+aquantia-objs			+= aquantia_main.o
+ifdef CONFIG_HWMON
+aquantia-objs			+= aquantia_hwmon.o
+endif
+obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia.o
diff --git a/drivers/net/phy/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
similarity index 100%
rename from drivers/net/phy/aquantia.h
rename to drivers/net/phy/aquantia/aquantia.h
diff --git a/drivers/net/phy/aquantia_hwmon.c b/drivers/net/phy/aquantia/aquantia_hwmon.c
similarity index 100%
rename from drivers/net/phy/aquantia_hwmon.c
rename to drivers/net/phy/aquantia/aquantia_hwmon.c
diff --git a/drivers/net/phy/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
similarity index 100%
rename from drivers/net/phy/aquantia_main.c
rename to drivers/net/phy/aquantia/aquantia_main.c
-- 
2.40.1

