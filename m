Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15DF7E2A6B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjKFQyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjKFQyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:54:44 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002B8B8;
        Mon,  6 Nov 2023 08:54:40 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50931355d48so6290378e87.3;
        Mon, 06 Nov 2023 08:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699289679; x=1699894479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8elnE1XjhWMPUXqSeSunlp8ee0oj8Ip2PAAjrMBLS9E=;
        b=OIXvVb0D2AaGtjDFI7v93yA6YD/8ymN3zC7BMsTX00g3O8oGj0rzE+vXUFpJGj5LMs
         UcmB8us5HaylHVkbCatbfbUSB7Zi6De13Pw2sKyrgNNoDBUbbKGbIkP8dGBpoQU0qiQq
         a/xZkEiqi2V108IiUmqMiWwhDC6ybFNxfs0BIlN1ncLk8Ny4MzOAO0ktZG7i+OWcwTbX
         mnmGwgNA05lM/kvFsFjFMnSWRpDo4MGDKYeT3c3GkLtpDVUZnsiErFw2HpJMkoPkEW0q
         C7A5r4hG6uts2e3+pZay4mYG+jzazJEDWy5+iHJgMeu1Pif4jwh182NRwJJSJUn3N43c
         n2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699289679; x=1699894479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8elnE1XjhWMPUXqSeSunlp8ee0oj8Ip2PAAjrMBLS9E=;
        b=fLhe4094/oghulAS5FNT6gB7xe2vlId2ylEDqkn9UdWKlf4ByScbDx+ugPp8lqsn4m
         Zospyu33QQBSsvWsekZRKQS5hWYXHynh+QV9ED3Zm2DeREuA9Xtgwe0KY3NjRFyviNbL
         4S6HU6bgqVU5SiBls2ngkj2Lt1DTtuYpK53KeuMljbh0D3EHmA04zF39A0kBuOjMK89M
         Wo9gHeEapp740WsOelhbJZJY+b9VOo+DMJJtGJIa2px7b/UntW49c4iv+4vYSSyDN78r
         0RaTTVkWLM4ETYyVF17iqhV7LJZOW79X+xYoT181/KjTckZQH8jLaf1RV9i9Fn0bGBVC
         BhXw==
X-Gm-Message-State: AOJu0YzHPKNTTkusp1Rsvfxh6XzNnkRJ24/lNp83StF2WB4fkhXe9DWE
        +bdrngytsIR8vn86m1CLKso=
X-Google-Smtp-Source: AGHT+IEG+EysC/stZahdMiOU2j4mPPOR+fDfVS3Lc6TId6QtNZOtXuwrdck4ED20CYnqLnXAo3RqIA==
X-Received: by 2002:a2e:b0ed:0:b0:2bd:19c5:3950 with SMTP id h13-20020a2eb0ed000000b002bd19c53950mr22618653ljl.33.1699289678832;
        Mon, 06 Nov 2023 08:54:38 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id a11-20020a05600c348b00b0040813e14b49sm13182044wmq.30.2023.11.06.08.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 08:54:38 -0800 (PST)
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
Subject: [net-next RFC PATCH v5 1/4] net: phy: aquantia: move to separate directory
Date:   Mon,  6 Nov 2023 17:54:30 +0100
Message-Id: <20231106165433.2746-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Move aquantia PHY driver to separate driectory in preparation for
firmware loading support to keep things tidy.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
---
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

