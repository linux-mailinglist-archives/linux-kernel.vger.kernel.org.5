Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216C179DE8B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbjIMDTB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 23:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbjIMDS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:18:59 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25761724;
        Tue, 12 Sep 2023 20:18:54 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 0EF318159;
        Wed, 13 Sep 2023 11:18:53 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Sep
 2023 11:18:52 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Sep
 2023 11:18:50 +0800
From:   Joshua Yeong <joshua.yeong@starfivetech.com>
To:     <pgaj@cadence.com>, <miquel.raynal@bootlin.com>
CC:     <alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Joshua Yeong <joshua.yeong@starfivetech.com>
Subject: [PATCH v2 1/1] i3c: master: cdns: Fix reading status register
Date:   Wed, 13 Sep 2023 11:17:45 +0800
Message-ID: <20230913031743.11439-2-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913031743.11439-1-joshua.yeong@starfivetech.com>
References: <20230913031743.11439-1-joshua.yeong@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBIR_DEPTH and CMDR_DEPTH should read from status0 instead of status1.

Cc: stable@vger.kernel.org
Fixes: 603f2bee2c54 ("i3c: master: Add driver for Cadence IP")
Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 drivers/i3c/master/i3c-master-cdns.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 49551db71bc9..8f1fda3c7ac5 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -191,7 +191,7 @@
 #define SLV_STATUS1_HJ_DIS		BIT(18)
 #define SLV_STATUS1_MR_DIS		BIT(17)
 #define SLV_STATUS1_PROT_ERR		BIT(16)
-#define SLV_STATUS1_DA(x)		(((s) & GENMASK(15, 9)) >> 9)
+#define SLV_STATUS1_DA(s)		(((s) & GENMASK(15, 9)) >> 9)
 #define SLV_STATUS1_HAS_DA		BIT(8)
 #define SLV_STATUS1_DDR_RX_FULL		BIT(7)
 #define SLV_STATUS1_DDR_TX_FULL		BIT(6)
@@ -1623,13 +1623,13 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	/* Device ID0 is reserved to describe this master. */
 	master->maxdevs = CONF_STATUS0_DEVS_NUM(val);
 	master->free_rr_slots = GENMASK(master->maxdevs, 1);
+	master->caps.ibirfifodepth = CONF_STATUS0_IBIR_DEPTH(val);
+	master->caps.cmdrfifodepth = CONF_STATUS0_CMDR_DEPTH(val);

 	val = readl(master->regs + CONF_STATUS1);
 	master->caps.cmdfifodepth = CONF_STATUS1_CMD_DEPTH(val);
 	master->caps.rxfifodepth = CONF_STATUS1_RX_DEPTH(val);
 	master->caps.txfifodepth = CONF_STATUS1_TX_DEPTH(val);
-	master->caps.ibirfifodepth = CONF_STATUS0_IBIR_DEPTH(val);
-	master->caps.cmdrfifodepth = CONF_STATUS0_CMDR_DEPTH(val);

 	spin_lock_init(&master->ibi.lock);
 	master->ibi.num_slots = CONF_STATUS1_IBI_HW_RES(val);
--
2.25.1

