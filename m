Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3267DB757
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjJ3KC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjJ3KA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:00:59 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03A3D7B;
        Mon, 30 Oct 2023 03:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1NkYfdtxQ5xtWE+EBP2iW90bSp/yMc+d7R2Ys5xqWqGXVN6NfS5hCrVmCziuVL8Aw7S1ATbNHcYlh2bpWdr+lIOWhvCyxCEjwj5XbgLhRB4F1K3C5cI+wVeEOLHNWAWenp8cSOvZb6geRIX2WQSNENbjIfT18YMWWqNCJ8hHdQS+8ZsccT6nANBxSUe+lux3Z4Vh3+qrykRZDBTPiUvp4DDQoVIEXdIQjoKfhEsnH4K4825LvZ4regv4w4vHk0PFvvrnRtBM6VYFQfbO687Ud0bFbyWrkc/wHd0AjU11OUu/sO5unrzPWDxgn4nLme+1RKqu0iA2KilM+6t6coirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vgm8y7ATuZJ1awfg9Mv/pgp7xz4V7XqFF429jBVPLKc=;
 b=MKapxhdhfwHvNN2lxVOTVAYwnHt5e9yxbnOz5PVYreEgHzewMRZkOJxYa85CiLXUlKQK2TOVWx3QXCFhFeV0hhE45rFswUAMu42bQWRM5RfAYrQhwpLjKPIdUSS/RE4K4QTZjvf/s57nrVwaDoa5kg8rKju1usHF3ESuX4UMvbobJBQNIqQa//4KETBOnwuEU5k7Ac3e1E18ZxEqwTaUWB4n5deHy/GBLN9W6YzqTi6f8V+eM1zvLcGsWlozaMaAtiVzJ9xY9Sm5EROwI43Cp1M+xggPxP3qfAszRie4GKMjKQIfS3JDCY0daW5DjwwHwzED4+anTqwtuD0rz9bSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vgm8y7ATuZJ1awfg9Mv/pgp7xz4V7XqFF429jBVPLKc=;
 b=XMbMfRNUjpw7CsDQP0P+DtnwsD1ye0vTvDwaOvAv548Vsm5xk/JwBdt/lxStJv1JiJRVTD9IpgZ1s+sVQHG3odmQ13rZtDzmCfO8czGk1Hwxtyiiudi4+UalFLjztckzLT8/qozVpE3a+TxVA5/D8B9VEZYZ+gVz5/maLDlwpfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Mon, 30 Oct
 2023 10:00:13 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351%4]) with mapi id 15.20.6954.016; Mon, 30 Oct 2023
 10:00:13 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v7 08/11] firmware: imx: init-fw api exchange on imx93
Date:   Mon, 30 Oct 2023 15:28:46 +0530
Message-Id: <20231030095849.3456820-9-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030095849.3456820-1-pankaj.gupta@nxp.com>
References: <20231030095849.3456820-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: c50e1b32-1485-4ed8-5cb7-08dbd92f02ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ocwOilMFy3XYs4vttVmpjqepa+LJq8/t7OiaqCsanqlTpjH7Rr3Fi0iaBK4nyatLuvJm4RmoC7KiAsDnSCMijMrnB6d7T7wwEltgfCw6UwNwOJFzwK1DLL2uyzXucM0tKx3P5q6Bh3GuvJ4FEtXSQZWtLBOkSDYngVTPFKPVYuVVejkOWaLNtx7gGFw8k6dWyTfBToyVb7wXMcT15GruRnE35/SVIxHrfaiqSGcQxx2aOeHkvyMzAY5sBSR2GBhl2jVWb32Hw8DiJGXlrotTKWSNGc1sMyUTKYVUYUkmasoyGmelJmk6+7dELvg+YSAL2yr4+8krUucrmPZK2BKHQ1CG7u07CNLNSdV3PaE2WHWNCATrTmVM5btGzBLpYhXR9+oRZsmaLxnVr/tvu+FuyKaRDKxb2qz1N8u0Z7PWGnvuH6hwsaSAvUIAnYxEo122NaHCO3L/rokhGZ5ksbQSFYK7B6Fq7yoI7NqdGyKkBcvsXwsZnUJRKUEc7vQUyjlF7fPvQHkN0xQuvjH9RX48hbTK4+wCESqLWyc3u9uzwfbZ4/SimdqyN0tU4ph1wZiQ+4oZ9Cs2siZbJfSxDFhWAZlnO3XDTU420kz7rp6rb+WMLqizLtFrtv/y4uPBRQi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(478600001)(6666004)(66946007)(6486002)(6506007)(83380400001)(36756003)(38100700002)(66556008)(1076003)(2616005)(66476007)(2906002)(41300700001)(26005)(52116002)(6512007)(44832011)(86362001)(38350700005)(921008)(6636002)(8676002)(4326008)(5660300002)(8936002)(316002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c4832OQrkqFvKOSkp+dfgCGRtF9uUc9DEDlHd1yTFjULWxwKeSBMPvksp235?=
 =?us-ascii?Q?+Oq2iM3hKOhn3t4KbCmukaJJtC+a5xhgzyAHkqGx1ULmeCt5tCjnlSIA/sqQ?=
 =?us-ascii?Q?z4Y90gZVRCU2zxqnaEHO/JHNkI7ApCXE+2p3YhWtaNd/t7riH4I+9yicsMZh?=
 =?us-ascii?Q?YBol/SUfMeIxG8UILSOOh1C7N2A6kr+VVBHIOGsHDeaA5D7lMRQbXXHR8EHa?=
 =?us-ascii?Q?zt+gpGnG03lbi0uSB9vd8ZDbeHrlFWSziMpN3GNGaQkdEHYinh6N2xOYSNJz?=
 =?us-ascii?Q?YGJVux0iyI2oY4SJf6Zl2B4H62zrc1tc8PE9uZpGZHXBPMkYN4j0lwYtnywy?=
 =?us-ascii?Q?q91lVmHEkdbqBFOAkdTR7LLw8gHBkHP/0H2eidX8NxmcbB3ZwwQ+HYjTtp6H?=
 =?us-ascii?Q?P11PJKVbfqsS0FNC3OziLJ3O7yXgZkj8mdBDOW3JLxDbstSs/2vMtXXw/uVC?=
 =?us-ascii?Q?l8PkFIK3YUyWEG5qoU0xcKeZuT16fP7/uoi2+u1gYpctblMYjRX5e2xPc6Qr?=
 =?us-ascii?Q?ta2Uea8eJEyPxzjGUxqsmg9Dmvt/IKiR17/U8JmpGlG5itLQYdzDwrgtMOgk?=
 =?us-ascii?Q?sB5LIJY5vHas0QSxcQvdZPl3nHdKcgQ4tEa5iAw+Q5OUXOYWDgMYHurvHWAt?=
 =?us-ascii?Q?ys1BcLjPpjuemh+G+Q/adxIpoDJVLrIRx9AQNlPgmXP2SgXXwvzLKGhLKhMS?=
 =?us-ascii?Q?pKmXvo5+Amjj+bLFOFjr57exndSQ7q2cDGxeAqCypMba2s7by/PFECNOeeXh?=
 =?us-ascii?Q?LNovs1nsvMtP7eXzHhvtG5xhGzCECyPzKEAJT5KTZ06yR2poZA3zN6yJYb5d?=
 =?us-ascii?Q?scse0NQQlsOlCwWSVolaDZlQgrJ7j5kMybo89Lm9qSWQPASEOCBCA/47JfpW?=
 =?us-ascii?Q?nRP3+7TxdjdpspneCXLYI1Scj8sPSyeDPU/meKiW2YfSpzJYyeQSaHKdU3Tk?=
 =?us-ascii?Q?ekwQI4r5snjem2SpanZONGdK1GCsk7in2YPYvQYr19gGpzNvNPq9Xd85m5dR?=
 =?us-ascii?Q?Le5wnDUBFK78ZksAyyErKdUV2quojacnXWQFJamx4/zyAweljrRDIthXJHv+?=
 =?us-ascii?Q?wKDmA80OUXmIsMDp6fgPT8XcVL/JLq0yxS13qyFh0S4KI+CKN9kDJ+uwqjiI?=
 =?us-ascii?Q?V0YLMMo7T7BExqR12ZjJ8dSX+faqg51nOjYZwkzsuQn6TnChNjqlDA4o9NAg?=
 =?us-ascii?Q?bNPXfrqLKSrvuvfxnKkUp6QmrrnkWb8g+aUEHRUXs+Ptj0sDQ+dMhTsCPKuM?=
 =?us-ascii?Q?KlI4w3XPAEZGctdTwUaxhUoTGm63NJfUup0xzyeyZ5ChBCg8dj/BO5JN6VxM?=
 =?us-ascii?Q?/3RuYe+o0usDiNkNZfSU1y+sQD/L7ap5GK4eaalnfYYeAEJXylYMDcsEZ9GY?=
 =?us-ascii?Q?l1cWr23a16SSzxCGOLKjfH0DpFCWntmm+QXn9rfVw+fYSPN5N/wG16UWzta5?=
 =?us-ascii?Q?iWnG9Jouk0t3wld1wT7JZvLmR9Hd4ZfgBnvj/W+xUES3VJrL983xA/HFZrvN?=
 =?us-ascii?Q?LO2nIyS9brcSJUsuyQvuR9nj0ziw2bggkl9PSPfHpqO8+2GWQgQtK3adEfPR?=
 =?us-ascii?Q?0FFrQKB7fcoHx4Jnr9u6VCC7SgwlI/g3be/D+OQr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50e1b32-1485-4ed8-5cb7-08dbd92f02ca
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 10:00:13.8590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZzc2LcUb+fB0TJomenrO5N3mvfq3b+YnzwUxhBiKXpSgLuc5UZ8ECyZ4Zson+JdiAseMjkrRrS+vcssd7RM+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index fc06e9076d00..92dc8ea58960 100644
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
 				.pool_name = "sram",
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
@@ -1236,6 +1240,13 @@ static int se_fw_probe(struct platform_device *pdev)
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

