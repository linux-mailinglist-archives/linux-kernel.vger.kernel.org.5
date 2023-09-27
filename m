Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C75F7B040D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjI0M1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjI0M1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:27:24 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D071BD;
        Wed, 27 Sep 2023 05:27:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJKr1uyyyPRqtYCeCGWIsxCPDMqNBXHK6AfouzPCh2eNFwR+sBt5BJ9N8I3HJbADXkTSNvWhSj/r1jxZATqrpTizAZrCdFcOtRuA8LFMq4PfajlRVmCX5E+sb/2h7aZxUP2OTCjaxX/bcemUxvW7S6pE45KlbsUon+hyxFJdV0rcOx57OGXIL5oJOSLa4TjEe1sgjjOkPonEVavDu50Ri+orRAgR2nkqoMUqalAWzrtRJPRXXz4kMFuAHoVloyHtG+IbeWl1mDjBq8kOrxqTY9UWuhlIJ2rGpMGOqRc6dUr+o7eaION5Ap6ecY1BMZ0BuB4tU6Pz6ktppU5n/qbp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEGD3lZF5GRjR1fzm9UFSGZLaxgzTzd4wV4SYSR5qAI=;
 b=hnsavzvKmh3CR33T3QzPUQ7wzJe/YMx1PU/ydUyTnozfbo+6Lqb4NILDrkt7dPNrxoDG0i7Sidxcl1AMNm5IWZIEAbKeIPoSnFqt04S4kJlsJKh3cOy7RuG3dd0OsdwRjjmmYEhVR0DJI8eFiBn+efiil7e/TYf8dY1OfjP81XGGeuJJpPyacjcupp6FNTbBUyh8K/Osv0izXqkgqZAFqhjKbC9lIdTLbAk+wvTEjAena1Wpfc3/8KUgwi53J0xuUR4hm3KnlQQzY8ChYcMRiVPqUIQkgbPywaAYQYcup6DVfU+oTrQDeY2ETEbT9Hx5JGplSFOFPsIdd1dEwTjD0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEGD3lZF5GRjR1fzm9UFSGZLaxgzTzd4wV4SYSR5qAI=;
 b=Gm/1A6NvGvDieNb+iecK1lS59nZnFztwFA145esgSNcTACzq1sNuUh6e2s5Dx1A6FSBcqANKYi7CQ9N95g9d4/QHXlzS54tpg+dwF23ax62wPMUCvaOIXhhPQ0azLp9YVN0ZACH5SWWH0R87icVB7v/yeH56VAWVxl4V5xcTuiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8181.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 12:27:10 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 12:27:10 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v6 08/11] firmware: imx: init-fw api exchange on imx93
Date:   Wed, 27 Sep 2023 23:23:58 +0530
Message-Id: <20230927175401.1962733-9-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
References: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9a3fa7-d716-4534-4401-08dbbf55122f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xP0cMzLP9hYA9unte3bBgIVt6CFEBblsClsHBJ0FHMgx9yMo3WfMNbvxXTjHGFAsylekAvCGl4WpvPPraxR55Ijn7228lw8cTeyKxDa4LQKl9biXGCk3oVLGbabQzmGGV+Lzzd/SaSwzQV/bUASLxULGI9Om2NdPpmt6vK4iLRyRc5VgWcL3ZM6YLzcb3fAnmJocl16bM/x5ZGoSHSPOWbU5rcUTgEJ/4ufR8/ZA82JnDSEaBMk0ZHRtuuDY/Y99LH3vEc/CNEu0EwrMSt1hG8Opxi6uSeRxcnzRbtvqyjfe7CHYAM7fSA0JJfbR+dp2b1faruwzQdFEQdpZMDFR1HNhdIY38Z5DHLg5KRexg7bZd1APDALN1I341Ig7sWjFpCqNodQAyfvJQGwAYXaCtce1nG6EKvX7nCc0chT7R0p6NEfZK5TnCnJVHCBUJ3OCUWeJnIJ1crmkEtx9DBBmUzfaZSgp8/6GC+jvvQJPNPaZkJch4K9qMDDRO2WTulIdGrq2e3WXrejtT6AhIUpAY3ziIpsg4T8appPAld9p14qKTm5TP/OFsYqXeZi0ckpnS0c/U9dQ5YegeVNSzdI2jAIMKWK4nogH5gCjUvWI1SG5nwbPsIwSxfFOyJaBb5vfTVsndp7l0p76W2p0MlFYVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(7416002)(5660300002)(316002)(921005)(83380400001)(44832011)(41300700001)(6636002)(8676002)(8936002)(36756003)(2616005)(66946007)(4326008)(86362001)(1076003)(6666004)(6486002)(6512007)(52116002)(6506007)(66476007)(66556008)(26005)(2906002)(38350700002)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MO3eQzogVYcndQ5ZWdIP9HIRzY/ZlEYPpLXEnewe+9A68CCUShkajP9yQ/HC?=
 =?us-ascii?Q?ITJa+JzHlmjc/9X5dzIBwXrltAjyyXFmUkDu3zZSYD/TqS+l/iBYvTTiBlWV?=
 =?us-ascii?Q?Sj0+MZo0/mQ/nYrtxQsQ/QgYgpYRlfI7KaoL63rTbg+PlOTZ78QDBHkM0K20?=
 =?us-ascii?Q?qEeGfb48rpZPzgSGtADqYsfsmARLqCz2ml3+8aAmqCcbw+cNw/si3lICC0QP?=
 =?us-ascii?Q?+NNssgkZ0fn8AlokSX9FgxfeYMstdnodPZlxwHU3cOkT461XDlHpMjurXt3s?=
 =?us-ascii?Q?36pHH6S5+eYkcsQo7+M5VH4TNLprs5xs0saKE3w1UQiLjqw4wdndLXFM33uy?=
 =?us-ascii?Q?cxnVLYFOwwLERRTWXxU6hmCcmt/Q3OyqbJNMbSg6gz1h/1B1IooERFXm+MRN?=
 =?us-ascii?Q?Q+oF0camDx9sMC0GFVMNDc5uei9mkMFjUFNtS/vhXerriAX/BDszzAT/ALG2?=
 =?us-ascii?Q?CuWF8Z8hfuia8VmaarJvmvpjLx92JhN9A+h4pCpyOCYhyO8MpB1+oCKQFWt4?=
 =?us-ascii?Q?d7h3GBxpThFPUzLNtF4X+ElHBcYdr19VHbgRR3n9G74Xpg3JRNfwTXGMCbh1?=
 =?us-ascii?Q?SdiF0NNBZJbcJlD0FP87dMlGoRJqc3oOL+Ppgn/u6mvgYlx3KD4/KfzpNKP7?=
 =?us-ascii?Q?NreMnOA3ymLSxiQ0/9pNC924ngqDXQWO57dzoe62lJ6NtgT21nzFbEueCxnI?=
 =?us-ascii?Q?7fWZJIqj4rlRSdc6TpZH3WFIf+H4Qku8QtypLUMTYUefsDUxS1j8hsbGfBzh?=
 =?us-ascii?Q?1IAmSdDzzwARCiS7VtD75zkTjF5W5u4pKHxYCKw0GLeghbDviiFFCvllFsn3?=
 =?us-ascii?Q?bg3e0mcdp1pzsK/feF/k/mAQZlLkk1QbI9ZVlsAFhsYvtFFa/sb4+0RqRqmY?=
 =?us-ascii?Q?a6Ih8NhIN0MJLVkCgcRFEARUsc75MwpinC86KNKbtqpNm9yLM2cRX0P/v3AH?=
 =?us-ascii?Q?97FvKgy6OwrpCqOHkA26AfqR0HJKSCJlKhffyi0fYPiExZ6rQifuGQ1d0RL+?=
 =?us-ascii?Q?BNOV0Ll54A+FcJCsNnOvEVPdJE+w/4sM3K+gGXouJzQN4dBsrdfuAYvLtctR?=
 =?us-ascii?Q?5tXEHwcEwjK4oBUhbfbCq2XjQB2S8Z9k7U37uQjkuKRbaQKaS0db/2c6jrzE?=
 =?us-ascii?Q?kXMzkvaw4a6f+QnIQcLmZRahbTJqm7Kq0H1I07rTDPwglD6HGKiVHLhEwSDX?=
 =?us-ascii?Q?mN1KjYF1MRDzI9qNRQrGV8tBoViUk7Lkcd1B8B35VHVlAzbRFS60vnsD/Hae?=
 =?us-ascii?Q?AVJkAYv+OvJx4uN2zDmTV3uqwUGTm3nsHxLXec1G0IikCJLKgYJe8M5gvzZU?=
 =?us-ascii?Q?I5QLsLFVg6m0dPHTdhkoT4Z+tV+GkVzs62e0rVhH6s43wgzrzaL+fqfHQmWZ?=
 =?us-ascii?Q?baGmGI/cff7pxoPDy1lQUOzzWFoEM09z7dvD1XXA4HYvESejxk1ttUh9CgXJ?=
 =?us-ascii?Q?ZlNycZ8BBmCEJmYDWhySb78TyMkLo3H5PMbKuiCy+xO4aapcomHCrlgLbZXf?=
 =?us-ascii?Q?GKi7ibim4L8wWcnuRIV9IeKeRnJetaJJZZnHLC7h0jdjqR2O1ZvZ0Jm+opq8?=
 =?us-ascii?Q?eunU3Ja6rH4qmcaojKR+JjxIGNEooQMGSASK0zgj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9a3fa7-d716-4534-4401-08dbbf55122f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 12:27:10.2999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YmnUd6/LppK9ZiWrFZAaMSWaYzEwAa60Jigh8oVQar1RXbnNfEM76pkU1OzWxg73Rj/Nx/6AygpAWNuqS4ckA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8181
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On imx93 platforms, exchange init-fw message with enclave's firmware
is to be done.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/firmware/imx/Makefile     |  2 +-
 drivers/firmware/imx/ele_fw_api.c | 51 +++++++++++++++++++++++++++++++
 drivers/firmware/imx/ele_fw_api.h | 20 ++++++++++++
 drivers/firmware/imx/se_fw.c      | 13 +++++++-
 4 files changed, 84 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/imx/ele_fw_api.c
 create mode 100644 drivers/firmware/imx/ele_fw_api.h

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 77ec0f922788..d61f06a8050a 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
-sec_enclave-objs		= se_fw.o ele_common.o ele_base_msg.o
+sec_enclave-objs		= se_fw.o ele_common.o ele_base_msg.o ele_fw_api.o
 obj-${CONFIG_IMX_SEC_ENCLAVE}	+= sec_enclave.o
diff --git a/drivers/firmware/imx/ele_fw_api.c b/drivers/firmware/imx/ele_fw_api.c
new file mode 100644
index 000000000000..55dda9d6531a
--- /dev/null
+++ b/drivers/firmware/imx/ele_fw_api.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2023 NXP
+ */
+
+#include <linux/dma-mapping.h>
+
+#include "ele_common.h"
+#include "ele_fw_api.h"
+
+int ele_init_fw(struct device *dev)
+{
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	unsigned int status;
+	int ret;
+
+	ret = imx_se_alloc_tx_rx_buf(priv);
+	if (ret)
+		return ret;
+
+	ret = plat_fill_cmd_msg_hdr(priv,
+				    (struct mu_hdr *)&priv->tx_msg->header,
+				    ELE_INIT_FW_REQ, ELE_INIT_FW_REQ_SZ,
+				    false);
+	if (ret)
+		goto exit;
+
+	ret = imx_ele_msg_send_rcv(priv);
+	if (ret < 0)
+		goto exit;
+
+	ret  = validate_rsp_hdr(priv,
+				priv->rx_msg->header,
+				ELE_INIT_FW_REQ,
+				ELE_INIT_FW_RSP_SZ,
+				false);
+	if (ret)
+		goto exit;
+
+	status = RES_STATUS(priv->rx_msg->data[0]);
+	if (status != priv->success_tag) {
+		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
+			ELE_INIT_FW_REQ, status);
+		ret = -1;
+	}
+
+exit:
+	imx_se_free_tx_rx_buf(priv);
+
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_fw_api.h b/drivers/firmware/imx/ele_fw_api.h
new file mode 100644
index 000000000000..21bb35b4041f
--- /dev/null
+++ b/drivers/firmware/imx/ele_fw_api.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2023 NXP
+ */
+
+#ifndef ELE_FW_API_H
+#define ELE_FW_API_H
+
+#include <linux/hw_random.h>
+
+#define MESSAGING_VERSION_7		0x7
+
+#define ELE_INIT_FW_REQ                 0x17
+#define ELE_INIT_FW_REQ_SZ              0x04
+#define ELE_INIT_FW_RSP_SZ              0x08
+
+
+int ele_init_fw(struct device *dev);
+
+#endif /* ELE_FW_API_H */
diff --git a/drivers/firmware/imx/se_fw.c b/drivers/firmware/imx/se_fw.c
index e47ad4b6ba54..c225cdc016be 100644
--- a/drivers/firmware/imx/se_fw.c
+++ b/drivers/firmware/imx/se_fw.c
@@ -24,6 +24,7 @@
 #include <linux/sys_soc.h>
 
 #include "se_fw.h"
+#include "ele_fw_api.h"
 
 #define SOC_ID_OF_IMX8ULP		0x084D
 #define SOC_ID_OF_IMX93			0x9300
@@ -46,6 +47,7 @@ struct imx_info {
 	uint8_t *mbox_rx_name;
 	uint8_t *pool_name;
 	bool reserved_dma_ranges;
+	bool init_fw;
 };
 
 struct imx_info_list {
@@ -73,6 +75,7 @@ static const struct imx_info_list imx8ulp_info = {
 				.mbox_rx_name = "rx",
 				.pool_name = "fsl,sram",
 				.reserved_dma_ranges = true,
+				.init_fw = false,
 			},
 	},
 };
@@ -95,8 +98,9 @@ static const struct imx_info_list imx93_info = {
 				.mbox_rx_name = "rx",
 				.pool_name = NULL,
 				.reserved_dma_ranges = true,
+				.init_fw = true,
 			},
-		},
+	},
 };
 
 static const struct of_device_id se_fw_match[] = {
@@ -1228,6 +1232,13 @@ static int se_fw_probe(struct platform_device *pdev)
 		priv->flags |= RESERVED_DMA_POOL;
 	}
 
+	if (info->init_fw) {
+		/* start initializing ele fw */
+		ret = ele_init_fw(dev);
+		if (ret)
+			dev_err(dev, "Failed to initialize ele fw.\n");
+	}
+
 	if (info->socdev) {
 		ret = imx_soc_device_register(dev, info);
 		if (ret) {
-- 
2.34.1

