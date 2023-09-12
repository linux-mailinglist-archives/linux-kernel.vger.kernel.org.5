Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02FD79D1D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjILNMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjILNMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:12:34 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE52F10CB;
        Tue, 12 Sep 2023 06:12:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqX8nZvX9FKgG6UiTXRyHv2a6QMvmSc1VrFShW1H7MqDxBJgOwLdb3e5TaVRqLZBkq3IURw4YVvGFR5rljASqYLtIqOXxIAZwy4vba9T6F5Zo1gWwUfTaRnYtkCzDksX1t3klEx0OHpZmg3NQMzbRd5i1Ex1RhFviYrSwVi+D1tRN8UN7xKanTkeNVmz8F0BmBmWKTpvPPRTY3bEZA66cIoULoXWgjMKULp6ro/4xr9Bg+Zkd9eBOeyUSjIdaSRKiuv7SFyMMVgin42HjdG8jhlrXH4DjivR+XV4Mk74H2CS8drjsAXOZFspf8An78OSUleDw8Qnajig0WyMrcF/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9507mHfdNM/eyDFA3PaWycSJssmL66yhhy8qnLULgc=;
 b=EBLqQtpWa6+WP4WkvgVSjDB+UPqaOYh80AQJUlRlf/Pjh0oFj+/8dYFI3xIQND2j2vojag2BsxIMWmiFLE8Bz6my19MCtudEmkJPEUXiNr7LK7DQsNpvSiM53DsTOHJUnMAAm+op1Yx3kDQZ+2f9TR+RM8OHY8OyWEQYUY+J9bwsW66g4V0C9qqRYkWcLZiTGxNwrfE1V0VHtxqGMQAKTTCRcUbzyglw2hBN+gLaq6EqLxVvEwHVe8am0QEfrKYAZd6c/REh0EJaTqLWR6lgONZNCLo2CPAfCPC5nL5mJ1NRO47TRcdfMOUsCuYvgmz6/i+oN0zQ5Y15XCNiksDrpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9507mHfdNM/eyDFA3PaWycSJssmL66yhhy8qnLULgc=;
 b=QKltMdT1nsC39a3ljB4N3CZDRVZrJjAo+HfhZHbUCWSLvzShU9EiY6SQsFuR8aDUXAR3rdibZ5NNepFCMyJ+1wys9626JZMM5herLvZDXO25F1ktu1SS1lfPsXiDVINcdsP/0zmsghUZAtQ3eMyauMRA0t2WoiM3Xxp8StYNSCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8645.eurprd04.prod.outlook.com (2603:10a6:10:2dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 13:12:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 13:12:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/4] clk: imx: composite-7ulp: Add some delay before deassert the reset
Date:   Tue, 12 Sep 2023 21:16:48 +0800
Message-Id: <20230912131649.1491378-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230912131649.1491378-1-peng.fan@oss.nxp.com>
References: <20230912131649.1491378-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: 00eb03f7-2db0-4ed0-8def-08dbb391e956
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3zbYlLM8nVrl+gT8fJG6NCqaZ5MlbX6QX6wLaPa5D5LW1Gk/K+9TuaCnPoAVQJWKgA82hmLQq3r49pX1K+JzDEk/87Pbbqd29wNRwEuWkuZN/zoK2cOPXGqH5EytPIdnDT9Fob4U0sjyUzA98uWVUaRhQOBH8SXTim/Kgx3NXpW7n/jlor5P8XCxuVSCUAhqtaZG4I64Z+FMMKNAM8OzqRPTUDdaZ8/SGT9ByF4evVNwxHvT2ad4K+bAtNmKMV8ISN0ndNGz64jfwi4a946h3RGBA8IOQzx7jPdLyUupmeUbBIz+pOnwvCl19vF7ADeDqg8pwEtruQmhp1m5QeWiC1FVqbDMO+VLqWLAV++rH0tVnc94BhJzX0Ey6KLfX6PZS5D7yDiz8FQhFyK0PH2D5BDeemA4Zokf2rQPHvKpvi7GnxX2l5oWHKSrd1idRZgPMMn/jpvvOdVbDufwLHKFcFtDMBg4WLFQb0ABIdoLuUB+4SUVgD9x6zI3RpHC2Ic4chb0N7uJnN6oIHfA+mzW456lx1t4snv8leCZ8dG6oTMawjpRjr/4ipF8hktM3X4XPS3O7BPFVW6N5+QTFWA2YpkwTzdRSWFGSd3GJv2IlQiV5FGSeb3kxyaTaJw65aUx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(186009)(451199024)(1800799009)(5660300002)(8676002)(8936002)(4326008)(83380400001)(6486002)(6666004)(6512007)(6506007)(26005)(1076003)(52116002)(2616005)(478600001)(66946007)(316002)(54906003)(66476007)(41300700001)(66556008)(86362001)(2906002)(38350700002)(38100700002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?722WDg5aG0NY+3ufRqTgTWeq7607yLBAJG0NF5l5wHVj6oYjLo9EfA0C8iwr?=
 =?us-ascii?Q?wBrj7s8/EMBKyJS1n+GZUQYBaUrdKEqqGVzBrRi2Dz3NXFI4tAHfoRan8bOa?=
 =?us-ascii?Q?fMXVeA4QpQLurD3SgPIdOzOoMvYFuoOXQSvquqx07sMzEdA14ZIkwFO+MMPQ?=
 =?us-ascii?Q?zEez3rGys7Ktwe2n2jECyY4i97Ye7LhzgLFvr6fK/Q9SQtuMBJzWliYv5CbZ?=
 =?us-ascii?Q?0ScIqMvI7YxXhiiy0bP23lw9OJyRNikWVWRWG3l/z0ouszNcT7zwfdppsMYn?=
 =?us-ascii?Q?LLjupsnNfrsROO+B+3wQyh6F1nX9Bd/4MKAevFWxyQs82wAyyfCUZCSO9oQR?=
 =?us-ascii?Q?TU+pYdlZhFqIIENFOMVVIQpw9+vcN08r75rSoEKaoRUtWV8EJWQTC2f20JSs?=
 =?us-ascii?Q?tjaEvT6EtJhzAprVhCH/IsMyj1lHRr9HJ7BM6m1nEzfazZGletCRwmlWRQuC?=
 =?us-ascii?Q?3+QYj7Jxb7cCt7UvD3+J+Hxxda4EJPSuttz4Wtx3ZCF9zymXvnt55zCohAlV?=
 =?us-ascii?Q?6WKKsH3mKIMsV6XoGNBJKyJdpWtVFiTt5FhQG9t4MLYJwC69UJMWAgBk+EVA?=
 =?us-ascii?Q?7yCzse6yWkn03PGjXXKR0FAm0TlfmEPNlZNbe8kjIt2UjxG9KMW1DlkPuozj?=
 =?us-ascii?Q?szaOw6qBNW1gnccKwtgpopHz1xODqvCL0T1yU9zRHHtl2vuW/OvKzmETycbF?=
 =?us-ascii?Q?2iMpO/5RA6q/u0Th0fUFZoyd0PFUnhdLD6LqEOlgG0vb94q5cjbpKZBKZi3Z?=
 =?us-ascii?Q?9bxvLuknwQbxTxCPVRuSjbowRELe0nudQ6omZOIJNRktd2SKtlloCV5PfS4/?=
 =?us-ascii?Q?yMM/+VGZwHTR9Cgbgg5f7YzMEtA74jUhPS7J5gCFef2XHYCvpJlMxPL6Oq0U?=
 =?us-ascii?Q?7DYUDpR9NaOda2ZEkDC0JphSXsLm2PsrtE7/4F6eJaCh16tBqizkEnstbDdo?=
 =?us-ascii?Q?nFhMBLZQnO/vYGBKcgSlxDRk5+84DI3rFC2FRFCcKeh2xL42/WEhJCW/0DbD?=
 =?us-ascii?Q?xJBZDYfNQgk6iIzhSdhagol7BHFUYza4AszFZvX4XJMvjAKur4sjh4YktmgB?=
 =?us-ascii?Q?9fAgrPey6PepyAfUYHt+6lbe2dezHIm35HY6auLJmOIsjZdQbHsVYvxPteA0?=
 =?us-ascii?Q?HbO5ir+3PnMqJpALcqhS8SbnnrTrI2DXbc4JBUfAEhxx0pYEnIZFQTKcmM0e?=
 =?us-ascii?Q?yxHpBVfJhKAZa7dzlEKg6zXqt5LVGSRMluKjlMEHJg8Nm426J6YGmsDxvvMW?=
 =?us-ascii?Q?5iFpYmKI14KYWvbUNqFRkgxd3qcW/N8abV7TM4Qp0AwbILhMtgnbECTWIlKK?=
 =?us-ascii?Q?rVeMRVOW2HmL7ZTp/mAsPEgdp62bXQdfJfqdJ1YRfNOJMoSexXddBzqbWErW?=
 =?us-ascii?Q?sXQzyV3C5ApknqB3OKsr4Ki9mGOxMI3Wn2j7nO1qpTuvR2uO1LN5FW3gflaJ?=
 =?us-ascii?Q?cVyE1gHEOcVEyKJqv66M/l41CNQRcBVNZZu5mV71+omOYQS0f2cVCGjlCyZx?=
 =?us-ascii?Q?/UaNNIzAZ4XopfebVWRv+mUHxPsQ6CRvbs4PAeJv2t8/kS4o17hYKY2F0hr0?=
 =?us-ascii?Q?9WSAoYNgGKJYTXZZPUOWdjEnKsYt5wtGAvHHKZ0v?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00eb03f7-2db0-4ed0-8def-08dbb391e956
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 13:12:27.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+kWlRhUiBH8dkcQ5M/RvbhulpPoh0VvcXMmjqWTQLfM0MFocZKP1cX9LXZaGgQaSm4zq+kR7+YdNl7WjAtIrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8645
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

Some of the PCCs on i.MX8ULP have a sw_rst bit to control
the peripheral reset through SW method. For peripherals like GPU
that need sync reset, some delay is necessary befere & after release
the reset to make sure the HW is reset into known status. So add
some delay before & after release reset.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-7ulp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/imx/clk-composite-7ulp.c b/drivers/clk/imx/clk-composite-7ulp.c
index e208ddc51133..715a60f81bce 100644
--- a/drivers/clk/imx/clk-composite-7ulp.c
+++ b/drivers/clk/imx/clk-composite-7ulp.c
@@ -7,6 +7,7 @@
 
 #include <linux/bits.h>
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -35,6 +36,9 @@ static int pcc_gate_enable(struct clk_hw *hw)
 	if (ret)
 		return ret;
 
+	/* wait before release reset */
+	udelay(1);
+
 	spin_lock_irqsave(gate->lock, flags);
 	/*
 	 * release the sw reset for peripherals associated with
@@ -46,6 +50,9 @@ static int pcc_gate_enable(struct clk_hw *hw)
 
 	spin_unlock_irqrestore(gate->lock, flags);
 
+	/* wait sync reset done */
+	udelay(1);
+
 	return 0;
 }
 
-- 
2.37.1

