Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878FA7AB2BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjIVNbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbjIVNbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:31:38 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC050E8;
        Fri, 22 Sep 2023 06:31:31 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 42B7E864E9;
        Fri, 22 Sep 2023 15:31:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1695389490;
        bh=QyQZgh18+AEb/uaLubc8YIM3M5wmKXPg7nTWgiyLM4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YF9fD0pHpL8SzSJrY0vT0DlLryhTyO9TWcsO+cSbleew31hHs4n70XTC6hlHSMjXM
         Wp+eHma85e4U8x7uqlrdLY5qGEyNGd0Mps0H1hzJDLUjYzv4+QVY2tPkhrD9rhxqnE
         gG/ehkZ1zVsRtME3MYXeKIojg3nC/73O23dGXmUP169hVFM6BtBR+b1cPeBFzL5TvZ
         ZYKC1Gw10lHYZgpgW0TQX28tYkd0FTOsDw3F88NEOVXcbD19hw3hMWxCBzuMeT00bf
         t1yxkYGZDux6yrVBHbuS4wNB51OG4MQ10QHrY/i//rOC+wFrm2c3tlBxhIxq5v8tyj
         nq3mVbBhQvmmw==
From:   Lukasz Majewski <lukma@denx.de>
To:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Lukasz Majewski <lukma@denx.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v6 net-next 4/5] net: dsa: microchip: move REG_SW_MAC_ADDR to dev->info->regs[]
Date:   Fri, 22 Sep 2023 15:31:07 +0200
Message-Id: <20230922133108.2090612-5-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230922133108.2090612-1-lukma@denx.de>
References: <20230922133108.2090612-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Defining macros which have the same name but different values is bad
practice, because it makes it hard to avoid code duplication. The same
code does different things, depending on the file it's placed in.
Case in point, we want to access REG_SW_MAC_ADDR from ksz_common.c, but
currently we can't, because we don't know which kszXXXX_reg.h to include
from the common code.

Remove the REG_SW_MAC_ADDR_{0..5} macros from ksz8795_reg.h and
ksz9477_reg.h, and re-add this register offset to the dev->info->regs[]
array.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Lukasz Majewski <lukma@denx.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Changes for v5:
- New patch
Changes for v6:
- None
---
 drivers/net/dsa/microchip/ksz8795_reg.h | 7 -------
 drivers/net/dsa/microchip/ksz9477_reg.h | 7 -------
 drivers/net/dsa/microchip/ksz_common.c  | 2 ++
 drivers/net/dsa/microchip/ksz_common.h  | 1 +
 4 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795_reg.h b/drivers/net/dsa/microchip/ksz8795_reg.h
index d33db4f86c64..3c9dae53e4d8 100644
--- a/drivers/net/dsa/microchip/ksz8795_reg.h
+++ b/drivers/net/dsa/microchip/ksz8795_reg.h
@@ -323,13 +323,6 @@
 	((addr) + REG_PORT_1_CTRL_0 + (port) *	\
 		(REG_PORT_2_CTRL_0 - REG_PORT_1_CTRL_0))
 
-#define REG_SW_MAC_ADDR_0		0x68
-#define REG_SW_MAC_ADDR_1		0x69
-#define REG_SW_MAC_ADDR_2		0x6A
-#define REG_SW_MAC_ADDR_3		0x6B
-#define REG_SW_MAC_ADDR_4		0x6C
-#define REG_SW_MAC_ADDR_5		0x6D
-
 #define TABLE_EXT_SELECT_S		5
 #define TABLE_EEE_V			1
 #define TABLE_ACL_V			2
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/microchip/ksz9477_reg.h
index 504e085aab52..f3a205ee483f 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -153,13 +153,6 @@
 #define SW_DOUBLE_TAG			BIT(7)
 #define SW_RESET			BIT(1)
 
-#define REG_SW_MAC_ADDR_0		0x0302
-#define REG_SW_MAC_ADDR_1		0x0303
-#define REG_SW_MAC_ADDR_2		0x0304
-#define REG_SW_MAC_ADDR_3		0x0305
-#define REG_SW_MAC_ADDR_4		0x0306
-#define REG_SW_MAC_ADDR_5		0x0307
-
 #define REG_SW_MTU__2			0x0308
 #define REG_SW_MTU_MASK			GENMASK(13, 0)
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 173ad8f04671..6c31d51410e3 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -364,6 +364,7 @@ static const struct ksz_dev_ops lan937x_dev_ops = {
 };
 
 static const u16 ksz8795_regs[] = {
+	[REG_SW_MAC_ADDR]		= 0x68,
 	[REG_IND_CTRL_0]		= 0x6E,
 	[REG_IND_DATA_8]		= 0x70,
 	[REG_IND_DATA_CHECK]		= 0x72,
@@ -492,6 +493,7 @@ static u8 ksz8863_shifts[] = {
 };
 
 static const u16 ksz9477_regs[] = {
+	[REG_SW_MAC_ADDR]		= 0x0302,
 	[P_STP_CTRL]			= 0x0B04,
 	[S_START_CTRL]			= 0x0300,
 	[S_BROADCAST_CTRL]		= 0x0332,
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index d180c8a34e27..07c7723dbc37 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -212,6 +212,7 @@ enum ksz_chip_id {
 };
 
 enum ksz_regs {
+	REG_SW_MAC_ADDR,
 	REG_IND_CTRL_0,
 	REG_IND_DATA_8,
 	REG_IND_DATA_CHECK,
-- 
2.20.1

