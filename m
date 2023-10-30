Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23447DB764
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjJ3KDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjJ3KBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:01:05 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB221FEE;
        Mon, 30 Oct 2023 03:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCjxFxfCej/ZCXwdxqeP8OXiPVqGT23LT1toKowrT5+n2adHBO662J+fepxYCMU8gyG+fiL1MNtqsuEasBVmJ73BLebqCl3xymG/OC5V6K2KbkbZ4u0qQpgpgrdNVm2JPQq25jm7I7ZweyVqwj4YpiVH+C9dE5uMCWVx7fP/6hoHK5VIkjR4vbc8XIP9ODzjBvw0v0l0IrulIWEXUci/ZfVK2hB1d7k44MNrpq9mTe6vbC2LvqQpsUHAwwlju2CVAICkQxeJIECbAmPOOrnJnbwHta4RvCOnOq52kqnBb4O78Dr/fROxJmvJD8p/uiJiIFW6Hq7FSr2R3LOPQ9g5xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ObzQh9GOHKEmnVwv7n7JF0opDF23pACxFYpMpHPC9s=;
 b=PmiidqRyVWdtFijlXG86YRHatxoI3PJ1/xYdWU9tYKegulXyvNuIuxoJgh6iaW+mcoErSKYlaJNNM0eY1WJ6DDTtfunDusHLAYAnhYCgpCKRVEfwOyCnoLWupB2nEIDoJuQxfgJKpGMU0Fn2tBWLa4z0dF9yHI7MDXdaoMyuLNjx+sSLPQfPyIg4iEVGDM5kGUvNHrwaBcZFQbF8J5MATfGOeQ7o0ENklMTRo1yhutbajNHyV0cL7gccacECwMR6rkN+ZPwAKjObPgjDr/cBVyE3bpUfac28KGkvT/jriPZHZL+fh4YGITEVu4jhWKoySlNULrbjAP05W0+6j/+WxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ObzQh9GOHKEmnVwv7n7JF0opDF23pACxFYpMpHPC9s=;
 b=rCSH2Vh9cNjLvtjdYR9CjOVw8DFSNCUrApk8WoyUGUGXNl3Gw+9oUS6GOdq/6fgIfN2HLYbVTJQ8EdDynbc8/CJA/z9XWjTVCFejQhVqaV7W4tYadM87iCDEOjhmSpLnEWr9Ju5/yAO8AF9YHYuDmKGm2jsHbOSJ9oNeMkI6Qd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Mon, 30 Oct
 2023 10:00:19 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351%4]) with mapi id 15.20.6954.016; Mon, 30 Oct 2023
 10:00:19 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v7 09/11] firmware: imx: enable trng
Date:   Mon, 30 Oct 2023 15:28:47 +0530
Message-Id: <20231030095849.3456820-10-pankaj.gupta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5a510030-937e-493c-0c5f-08dbd92f0614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBSPgdPxH6OaRbOSZt16CwD/ZyYxNW/jvj/kbBiHrolJ8+/fFqkFZmooxgDz4brpp6TGRhodMqaE++d+3V+xD/n+/sj6OZEaDAPLLBZv7Tcn6pyESTll+hrn6hbVaWsAXm3jZV7ZdhSSVsi/GGl+3dgJtUwlSM2RqVnkIwleQWb6sW1JnBYr6wBsweZtzQjAvWtwoV1RKbmrzHzi4QDSoiqxqZHwSGaTx04CqGF4yhz4urK4StQMRC5tWV5DnNLXojCh7wvtrqIpqXqxvPY2WWsXeHcnd1CZvENrG+7yL9heCxmYW8QpIvjdrbBcZeVAGPfoXPbLMIbBtfYkOs6CGbRNJCtHKuVPWJb7BuMI4ZQs2eJtJX8swYPHW3KRKy+TBdqL39+jL30p3RStO3GykN0M+lGz9pk2l3/LzAXJ3qb9BUB/ZSQwQ94L1yzoJYsTJv/VYOaWB85PncOk4UIvu/RUuC301cPg9GBTifm7YyJ9Yw3FZiaf4pFOwVZX/sqQr+UzQTDkIhxt0Bi83PxFgbPOJeJbjwijNB42qeuOl2C8IcyKYaG5Q4XdaDQ88UbKlSafDA7DPqMKqer5Qs658l/KDAw4UbwIIABcHWlBfe/sBjFjCf8MFc/g/8b0EhmfJeN9qqGnleZg0B1sEm28AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(478600001)(6666004)(66946007)(6486002)(6506007)(83380400001)(36756003)(38100700002)(66556008)(1076003)(2616005)(66476007)(2906002)(41300700001)(26005)(52116002)(6512007)(44832011)(86362001)(38350700005)(921008)(6636002)(8676002)(30864003)(4326008)(5660300002)(8936002)(316002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RvdY2XbAaVGWpCObIquQDdJMgirRuquFhpkaM5LaqJzvRgRTguneW0xz+A4m?=
 =?us-ascii?Q?CKKa1txZwNlR4z32+SM8TXVH6oAkOEfECTjIdHA4iXHHpx6hg4glAPR4VOMC?=
 =?us-ascii?Q?0s142GpjPLK8kDtMR+KhLJVYFKbmETz0YHLvmoUYSjX4PgoQfAXHUsgvecIB?=
 =?us-ascii?Q?CmKTiZGFMRQYbxLz6aRhK+97wOn1xc5KEo0wuWZDJeDNY7bQ5zOj243yV/dW?=
 =?us-ascii?Q?s2kzBCLjiyX5uChc8x1KAAvF2xcl9ATx0i9lfXTh1TGXmJ1g/GN/osNBrUax?=
 =?us-ascii?Q?/4GZ856itm3BXZK/U0S/hmzXWZe72OmwxX6q5Z8ODb+vrEU4KXHZYYGU3KnO?=
 =?us-ascii?Q?bfTmwpbDOVnlhz9Fi6+Hv6eGFVmpXFbxO365AoktjdBo5CpAYN3dzcjqngT/?=
 =?us-ascii?Q?RxzRmHQA+3MA75OR6IlK8n1cw28lUrjsYZIq0g2C3rw5MG9ZtKCWZ9m2BRXo?=
 =?us-ascii?Q?HLSUTVs14nhebcHreistlu80eyA5fQUWD7tIY7pj73Ao8lkq+EgOTKS0/Hul?=
 =?us-ascii?Q?PHC19GidCyXKrJxJ0WNTeyE3JvO+jL58YXRisSgcNyMiARKHz9NbWcsAVuvI?=
 =?us-ascii?Q?6L6r2vvqWh/gQEd4+/Bc3AzpUOA6f0HtgEepbwaERlkI+X3Qi58bBifmn7rq?=
 =?us-ascii?Q?0fRs4LH76pcQFNGN0o+7C2HikACh+cEqP+OmMcZ2trwiyC7BzZascIzGF5Ae?=
 =?us-ascii?Q?YmqizKwjHBnebAPA2XVVaoWG6aUrdzEEbvqwEEX7hY55uRA6QDtTIBlGWlv6?=
 =?us-ascii?Q?1MySh1mOL/jjgiKpBE1ddhNKg1fwRfz9nVNrjWu5Xv3LR8pIRNVUPB0zf62h?=
 =?us-ascii?Q?Tt8+KsilF1sjbsVYEGYK85S4pOjEcM7bpN1nqUALxIHHnevR4QFn4Qg0R6Iv?=
 =?us-ascii?Q?L+cIDX6OQrYQEgKcJC9gPGsLN3UNsRi3qZWnKsRx/FzvLlND9DuslbYFaWUD?=
 =?us-ascii?Q?F90WhgFn+rsYw+mcRK55TIOaLPwvol2o2CnST0S7YjN9gMzqw4iJkYVe1Ngq?=
 =?us-ascii?Q?VkMwYGpki4QamSWDmXGf6vanTOYmVsyEJOX93+8Fky722v6Sa9tA3Rz3q5x0?=
 =?us-ascii?Q?ZR7/bEKkb3KvYooSiHbj/rj4FbAv2EDxRHKjBc5AfrLNdIPODpLMdEgkiozW?=
 =?us-ascii?Q?OF9DtI8fO7eyIArX+V2j1G+UGGq3vCMbOyJruJ7tMqVSOVVBGyhmLe0GX27T?=
 =?us-ascii?Q?ugbGg7XPsvaIoBqsNiTTtbki/0FAa9RRSikUofJf9zO0ctO1sJF64YSg0M1T?=
 =?us-ascii?Q?OLy8nsKbHKflmtyYqntT1+/yFMFODerrkcInQ5aURtSK4Ss/Bz4JybaacUBb?=
 =?us-ascii?Q?2pXz8X7nj67mTFuWxUUwkzCIwDzyryM0xUqOmFwrAJ+lqb67rUPUeZ6bwpkY?=
 =?us-ascii?Q?njt2SOzS+FBIKH8tfp8wEu9pg1kMBzlSNZvtBchc30iMH4a6LmXdyq1WF3Sm?=
 =?us-ascii?Q?RA7p7akmnajIsEwQTouLEKvLiwvR5r7EvS4egQwfydQBedzDr/Z/I9QeUXiO?=
 =?us-ascii?Q?Ip2rCuLSZiyRTclx4EM45YCxRyQYO9P0E5su3n0JQKA2Ps8IYiu9nr+iCFEU?=
 =?us-ascii?Q?lIHHtUeul/Zc/ZvAsiS9gF37qLL7aBGWDrXfy8Se?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a510030-937e-493c-0c5f-08dbd92f0614
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 10:00:19.5363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFC7oe7chHaRDLbTSKM/Q6CB/76aUmCqVup3gXN+grHd29ZhEPntELyU5dNHvmleejkGMkyjCL3sj4STAN1xNQ==
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

Enabled trng on imx93 platform through enclave fw.

Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/firmware/imx/Kconfig              |   9 ++
 drivers/firmware/imx/Makefile             |   1 +
 drivers/firmware/imx/ele_base_msg.c       | 117 ++++++++++++++++++++++
 drivers/firmware/imx/ele_common.c         |  40 ++++++++
 drivers/firmware/imx/ele_common.h         |   2 +
 drivers/firmware/imx/ele_fw_api.c         |  67 +++++++++++++
 drivers/firmware/imx/ele_fw_api.h         |   6 ++
 drivers/firmware/imx/ele_trng.c           |  47 +++++++++
 drivers/firmware/imx/se_fw.c              |  21 ++++
 include/linux/firmware/imx/ele_base_msg.h |  13 +++
 10 files changed, 323 insertions(+)
 create mode 100644 drivers/firmware/imx/ele_trng.c

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index 2822e5d4b24c..ffc02593293c 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -40,3 +40,12 @@ config IMX_SEC_ENCLAVE
           like base, HSM, V2X & SHE using the SAB protocol via the shared Messaging
           Unit. This driver exposes these interfaces via a set of file descriptors
           allowing to configure shared memory, send and receive messages.
+
+config IMX_ELE_TRNG
+	tristate "i.MX ELE True Random Number Generator"
+	default y
+	select CRYPTO_RNG
+	select HW_RANDOM
+	help
+	  This driver provides kernel-side support for the Random Number generation,
+          through NXP hardware IP for secure-enclave called EdgeLock Enclave.
diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index d61f06a8050a..9018f7824f36 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
 sec_enclave-objs		= se_fw.o ele_common.o ele_base_msg.o ele_fw_api.o
 obj-${CONFIG_IMX_SEC_ENCLAVE}	+= sec_enclave.o
+sec_enclave-${CONFIG_IMX_ELE_TRNG} += ele_trng.o
diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
index 813f769f7bc3..3a3af2321f67 100644
--- a/drivers/firmware/imx/ele_base_msg.c
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -99,3 +99,120 @@ int ele_ping(struct device *dev)
 
 	return ret;
 }
+
+/*
+ * ele_get_trng_state() - prepare and send the command to read
+ *                        crypto lib and TRNG state
+ * TRNG state
+ *  0x1		TRNG is in program mode
+ *  0x2		TRNG is still generating entropy
+ *  0x3		TRNG entropy is valid and ready to be read
+ *  0x4		TRNG encounter an error while generating entropy
+ *
+ * CSAL state
+ *  0x0		Crypto Lib random context initialization is not done yet
+ *  0x1		Crypto Lib random context initialization is on-going
+ *  0x2		Crypto Lib random context initialization succeed
+ *  0x3		Crypto Lib random context initialization failed
+ *
+ * returns: csal and trng state.
+ *
+ */
+int ele_get_trng_state(struct device *dev)
+{
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	int ret;
+	unsigned int status;
+
+	ret = imx_se_alloc_tx_rx_buf(priv);
+	if (ret)
+		return ret;
+
+	ret = plat_fill_cmd_msg_hdr(priv,
+				    (struct mu_hdr *)&priv->tx_msg->header,
+				    ELE_GET_TRNG_STATE_REQ,
+				    ELE_GET_TRNG_STATE_REQ_MSG_SZ,
+				    true);
+	if (ret) {
+		pr_err("Error: plat_fill_cmd_msg_hdr failed.\n");
+		goto exit;
+	}
+
+	ret = imx_ele_msg_send_rcv(priv);
+	if (ret)
+		goto exit;
+
+	ret = imx_ele_msg_send_rcv(priv);
+	if (ret < 0)
+		goto exit;
+
+	ret  = validate_rsp_hdr(priv,
+				priv->rx_msg->header,
+				ELE_GET_TRNG_STATE_REQ,
+				ELE_GET_TRNG_STATE_RSP_MSG_SZ,
+				true);
+	if (ret)
+		goto exit;
+
+	status = RES_STATUS(priv->rx_msg->data[0]);
+	if (status != priv->success_tag) {
+		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
+			ELE_GET_TRNG_STATE_REQ, status);
+		ret = -1;
+	} else
+		ret = (priv->rx_msg->data[1] & CSAL_TRNG_STATE_MASK);
+
+exit:
+	imx_se_free_tx_rx_buf(priv);
+
+	return ret;
+}
+
+/*
+ * ele_start_rng() - prepare and send the command to start
+ *                   initialization of the ELE RNG context
+ *
+ * returns:  0 on success.
+ */
+int ele_start_rng(struct device *dev)
+{
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	int ret;
+	unsigned int status;
+
+	ret = imx_se_alloc_tx_rx_buf(priv);
+	if (ret)
+		return ret;
+
+	ret = plat_fill_cmd_msg_hdr(priv,
+				    (struct mu_hdr *)&priv->tx_msg->header,
+				    ELE_START_RNG_REQ,
+				    ELE_START_RNG_REQ_MSG_SZ,
+				    true);
+	if (ret)
+		goto exit;
+
+	ret = imx_ele_msg_send_rcv(priv);
+	if (ret < 0)
+		goto exit;
+
+	ret  = validate_rsp_hdr(priv,
+				priv->rx_msg->header,
+				ELE_START_RNG_REQ,
+				ELE_START_RNG_RSP_MSG_SZ,
+				true);
+	if (ret)
+		goto exit;
+
+	status = RES_STATUS(priv->rx_msg->data[0]);
+	if (status != priv->success_tag) {
+		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
+			ELE_START_RNG_REQ, status);
+		ret = -1;
+	}
+
+exit:
+	imx_se_free_tx_rx_buf(priv);
+
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
index 4410245a19ec..d4b829c19133 100644
--- a/drivers/firmware/imx/ele_common.c
+++ b/drivers/firmware/imx/ele_common.c
@@ -3,6 +3,10 @@
  * Copyright 2023 NXP
  */
 
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/firmware/imx/ele_base_msg.h>
+
 #include "ele_common.h"
 #include "se_fw.h"
 
@@ -137,3 +141,39 @@ int validate_rsp_hdr(struct ele_mu_priv *priv, unsigned int header,
 
 	return ret;
 }
+
+int ele_do_start_rng(struct device *dev)
+{
+	int ret;
+	int count = ELE_GET_TRNG_STATE_RETRY_COUNT;
+
+	ret = ele_get_trng_state(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get trng state\n");
+		return ret;
+	} else if (ret != ELE_TRNG_STATE_OK) {
+		/* call start rng */
+		ret = ele_start_rng(dev);
+		if (ret) {
+			dev_err(dev, "Failed to start rng\n");
+			return ret;
+		}
+
+		/* poll get trng state API, ELE_GET_TRNG_STATE_RETRY_COUNT times
+		 * or while trng state != 0x203
+		 */
+		do {
+			msleep(10);
+			ret = ele_get_trng_state(dev);
+			if (ret < 0) {
+				dev_err(dev, "Failed to get trng state\n");
+				return ret;
+			}
+			count--;
+		} while ((ret != ELE_TRNG_STATE_OK) && count);
+		if (ret != ELE_TRNG_STATE_OK)
+			return -EIO;
+	}
+
+	return 0;
+}
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
index 284b7f66d8e3..f9e1d949dc6a 100644
--- a/drivers/firmware/imx/ele_common.h
+++ b/drivers/firmware/imx/ele_common.h
@@ -27,4 +27,6 @@ static inline int ele_trng_init(struct device *dev)
 	return 0;
 }
 #endif
+
+int ele_do_start_rng(struct device *dev);
 #endif
diff --git a/drivers/firmware/imx/ele_fw_api.c b/drivers/firmware/imx/ele_fw_api.c
index 55dda9d6531a..d195a920b3ee 100644
--- a/drivers/firmware/imx/ele_fw_api.c
+++ b/drivers/firmware/imx/ele_fw_api.c
@@ -49,3 +49,70 @@ int ele_init_fw(struct device *dev)
 
 	return ret;
 }
+
+/*
+ * ele_get_random() - prepare and send the command to proceed
+ *                    with a random number generation operation
+ *
+ * returns:  size of the rondom number generated
+ */
+int ele_get_random(struct device *dev,
+		   void *data, size_t len)
+{
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	unsigned int status;
+	dma_addr_t dst_dma;
+	u8 *buf;
+	int ret;
+
+	buf = dmam_alloc_coherent(priv->dev, len, &dst_dma, GFP_KERNEL);
+	if (!buf) {
+		dev_err(priv->dev, "Failed to map destination buffer memory\n");
+		return -ENOMEM;
+	}
+
+	ret = imx_se_alloc_tx_rx_buf(priv);
+	if (ret) {
+		ret = -ENOMEM;
+		goto exit1;
+	}
+
+	ret = plat_fill_cmd_msg_hdr(priv,
+				    (struct mu_hdr *)&priv->tx_msg->header,
+				    ELE_GET_RANDOM_REQ, ELE_GET_RANDOM_REQ_SZ,
+				    false);
+	if (ret)
+		goto exit;
+
+	priv->tx_msg->data[0] = 0x0;
+	priv->tx_msg->data[1] = dst_dma;
+	priv->tx_msg->data[2] = len;
+	ret = imx_ele_msg_send_rcv(priv);
+	if (ret < 0)
+		goto exit;
+
+	ret  = validate_rsp_hdr(priv,
+				priv->rx_msg->header,
+				ELE_GET_RANDOM_REQ,
+				ELE_GET_RANDOM_RSP_SZ,
+				false);
+	if (ret)
+		return ret;
+
+	status = RES_STATUS(priv->rx_msg->data[0]);
+	if (status != priv->success_tag) {
+		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
+			ELE_GET_RANDOM_REQ, status);
+		ret = -1;
+	} else {
+		memcpy(data, buf, len);
+		ret = len;
+	}
+
+exit:
+	imx_se_free_tx_rx_buf(priv);
+exit1:
+	dmam_free_coherent(priv->dev, len, buf, dst_dma);
+
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_fw_api.h b/drivers/firmware/imx/ele_fw_api.h
index 21bb35b4041f..70cd8cf5074b 100644
--- a/drivers/firmware/imx/ele_fw_api.h
+++ b/drivers/firmware/imx/ele_fw_api.h
@@ -14,7 +14,13 @@
 #define ELE_INIT_FW_REQ_SZ              0x04
 #define ELE_INIT_FW_RSP_SZ              0x08
 
+#define ELE_GET_RANDOM_REQ		0xCD
+#define ELE_GET_RANDOM_REQ_SZ		0x10
+#define ELE_GET_RANDOM_RSP_SZ		0x08
+
 
 int ele_init_fw(struct device *dev);
+int ele_get_random(struct device *dev, void *data, size_t len);
+int ele_get_hwrng(struct hwrng *rng, void *data, size_t len, bool wait);
 
 #endif /* ELE_FW_API_H */
diff --git a/drivers/firmware/imx/ele_trng.c b/drivers/firmware/imx/ele_trng.c
new file mode 100644
index 000000000000..4a7a119ff435
--- /dev/null
+++ b/drivers/firmware/imx/ele_trng.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ELE Random Number Generator Driver NXP's Platforms
+ *
+ * Copyright 2023 NXP
+ */
+
+#include "ele_common.h"
+#include "ele_fw_api.h"
+
+struct ele_trng {
+	struct hwrng rng;
+	struct device *dev;
+};
+
+int ele_trng_init(struct device *dev)
+{
+	struct ele_trng *trng;
+	int ret;
+
+	trng = devm_kzalloc(dev, sizeof(*trng), GFP_KERNEL);
+	if (!trng)
+		return -ENOMEM;
+
+	trng->dev         = dev;
+	trng->rng.name    = "ele-trng";
+	trng->rng.read    = ele_get_hwrng;
+	trng->rng.priv    = (unsigned long)trng;
+	trng->rng.quality = 1024;
+
+	dev_dbg(dev, "registering ele-trng\n");
+
+	ret = devm_hwrng_register(dev, &trng->rng);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "Successfully registered ele-trng\n");
+	return 0;
+}
+
+int ele_get_hwrng(struct hwrng *rng,
+		  void *data, size_t len, bool wait)
+{
+	struct ele_trng *trng = (struct ele_trng *)rng->priv;
+
+	return ele_get_random(trng->dev, data, len);
+}
diff --git a/drivers/firmware/imx/se_fw.c b/drivers/firmware/imx/se_fw.c
index 92dc8ea58960..3638a4fed5e7 100644
--- a/drivers/firmware/imx/se_fw.c
+++ b/drivers/firmware/imx/se_fw.c
@@ -24,6 +24,7 @@
 #include <linux/sys_soc.h>
 
 #include "se_fw.h"
+#include "ele_common.h"
 #include "ele_fw_api.h"
 
 #define SOC_ID_OF_IMX8ULP		0x084D
@@ -48,6 +49,9 @@ struct imx_info {
 	uint8_t *pool_name;
 	bool reserved_dma_ranges;
 	bool init_fw;
+	/* platform specific flag to enable/disable the ELE True RNG */
+	bool start_rng;
+	bool enable_ele_trng;
 };
 
 struct imx_info_list {
@@ -76,6 +80,8 @@ static const struct imx_info_list imx8ulp_info = {
 				.pool_name = "sram",
 				.reserved_dma_ranges = true,
 				.init_fw = false,
+				.start_rng = true,
+				.enable_ele_trng = false,
 			},
 	},
 };
@@ -99,6 +105,8 @@ static const struct imx_info_list imx93_info = {
 				.pool_name = NULL,
 				.reserved_dma_ranges = true,
 				.init_fw = true,
+				.start_rng = true,
+				.enable_ele_trng = true,
 			},
 	},
 };
@@ -1260,6 +1268,19 @@ static int se_fw_probe(struct platform_device *pdev)
 	if (ret)
 		dev_err(dev, "Failed[%d] to ping the fw.\n", ret);
 
+	/* start ele rng */
+	if (info->start_rng) {
+		ret = ele_do_start_rng(dev);
+		if (ret)
+			dev_err(dev, "Failed to start ele rng\n");
+	}
+
+	if (!ret && info->enable_ele_trng) {
+		ret = ele_trng_init(dev);
+		if (ret)
+			dev_err(dev, "Failed to init ele-trng\n");
+	}
+
 	dev_info(dev, "i.MX secure-enclave: %s interface to firmware, configured.\n",
 		info->pdev_name[1]);
 
diff --git a/include/linux/firmware/imx/ele_base_msg.h b/include/linux/firmware/imx/ele_base_msg.h
index 49e3619372be..3ca4b47e4c4e 100644
--- a/include/linux/firmware/imx/ele_base_msg.h
+++ b/include/linux/firmware/imx/ele_base_msg.h
@@ -34,7 +34,20 @@
 #define ELE_PING_REQ_SZ			0x04
 #define ELE_PING_RSP_SZ			0x08
 
+#define ELE_START_RNG_REQ		0xA3
+#define ELE_START_RNG_REQ_MSG_SZ	0x04
+#define ELE_START_RNG_RSP_MSG_SZ	0x08
+
+#define ELE_GET_TRNG_STATE_REQ		0xA4
+#define ELE_GET_TRNG_STATE_REQ_MSG_SZ	0x04
+#define ELE_GET_TRNG_STATE_RSP_MSG_SZ	0x0C
+#define ELE_TRNG_STATE_OK		0x203
+#define ELE_GET_TRNG_STATE_RETRY_COUNT	0x5
+#define CSAL_TRNG_STATE_MASK		0x0000ffff
+
 int ele_get_info(struct device *dev, phys_addr_t addr, u32 data_size);
 int ele_ping(struct device *dev);
+int ele_start_rng(struct device *dev);
+int ele_get_trng_state(struct device *dev);
 
 #endif
-- 
2.34.1

