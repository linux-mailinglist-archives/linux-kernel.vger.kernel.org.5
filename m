Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E449B7B0439
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjI0Mce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjI0Mcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:32:31 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DF713A;
        Wed, 27 Sep 2023 05:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fji/Z1ZdeXbylSiMNmKbEomcGIgJxhnlONVIxg5uOKc9WiBf1RRek+YcpIN0V3cRof6AgxvIcMvdZVjLgV/zTvClrE0PeWewip1clPuSMpuWb5KRcG99/xkHsGj1tWPsOGPXMfZ72Wyg3KUHiYWlTrwApLYhk6BUphNUXwhRWIhTJhiPuldTYS6JKVPGV/z9Vfh+quvKH/3xViK6CX/a8cOya+RUCV4SfIApXm8SVPZU9I7AaBsMdtzVatqUWYIVYIgq7QOi3dI4h+2DmWl+DLoT+iUmxoG8GopZqZTmV2a4bAYor3FWbEOFopk87dauICbudq2jJGSrGq1z3pAvDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YK8Ce2sPN4PvhEO31Wk1kFV2ywQ6aCtnoachpsl9dQA=;
 b=nOy/UN6KLKX7YD5FRf6wRKWDJAR8NtLTa8oOptPTUttwBs8EEuVCr1Ctio9OgTgS2I7+4cZcn6XrlXcj9Ds4F7DAGzPtCyZKDpky41TRLT6qpENxdZpBwlwEgRZo8KjTnojpog1Y3RsTOFezdLdP922ha2AJH2fgwkhvnDY6Q1Sj3dIOMEDfszoCM1HlyOPnnXv5uLa8dbvfyCUnE2wLiv5aqJfbhwDlUG81nP5vKc6ng5vgWzBi/Ac/At0wlbzmuouik7toPjvTXUjp+pB/b0zq0gZup69SyD4NI88lInw7e3w6FupPb07Bjr8nazmqGim1bpESZ6zRc3wmvPaYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK8Ce2sPN4PvhEO31Wk1kFV2ywQ6aCtnoachpsl9dQA=;
 b=rgGVqutg8bRsPSS4NR72PIALWF1S2zRvQYnr6Xw8qeJKFZAU6XcafeUmVEEvzw5iOK2Mg7PVhO00q63GuG5djnNs0xiCJdLpPLFOMkTOiSufojEfP5tXGxnk5NpLuZL+O5SF0ECvc83ptPX2/QzFRlnDioduw6EqRwkydy58S+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB9046.eurprd04.prod.outlook.com (2603:10a6:20b:441::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 12:32:23 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 12:32:23 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com,
        horia.geanta@nxp.com, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v6 09/11] firmware: imx: enable trng
Date:   Wed, 27 Sep 2023 23:30:16 +0530
Message-Id: <20230927180016.1962817-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 30532fee-f26c-4bdf-7809-08dbbf55cce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Iv3uoogVPs2aAgAMIgUPDZFKrD9HwQAn01SIb8C2dSc5cTW8n2oiCJtghSpu7d35gqeSUaEW7jTpxRd0RGanXVuhsKqkB15ts3+DVNNFfn0DVU/Bd2vcXkhfMmbjyLQs0OxF09pZM2vP6MaWCoXt834/3AdUnxhQZEX6hGcyN9J40EMWvg2mGGxM6d3I38CtF36JTIfuDw/kRS5AC9okBJhcO+/RUeZfNzpZpC7vIbKC39f8bP8cNoRQyQX240U9tajsrKjr/OGIScVOXi9cfxxThEtYWub73tQW1pj5acVXPk/UD2hfL8JR/DrTsfu4Cd5OPukiK3AgKq2wlz/6uiWM8RXQoakn/WYX40jX/4dO8Jh43Bpfr+rQFrIjTlFe8rexRTW2zzA/XbQSlFL1l4oEYuVLp/vlfpUKI+4aGUezm6zmfKbhd/lMveQTL5UgimhV/hhMy4sKxIl8XWxwrlNhhNTOJsE52VW/elo2nChBJeb7A/87zVdP9i4J2MYsmjX37RRF1cvmy5XI8GeQOL7nR7Q6TlHY8TV4aZY6ka8m6/0BR2oqJscS59b3h97InbwXG/WA9iRjF66OiecNzcEYe8mHWWHILzelViIa8PkV4QM/F9Ez7uMyyB6kiHT6QQBAdaR+IbtgJDIGlFOog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(66476007)(66946007)(66556008)(5660300002)(41300700001)(316002)(44832011)(8936002)(8676002)(4326008)(2906002)(7416002)(30864003)(38100700002)(38350700002)(478600001)(26005)(52116002)(2616005)(921005)(1076003)(86362001)(6506007)(6666004)(83380400001)(6512007)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QbRuQ3iypGVGn0DTu/+jfQbfNTEn6XjAxnEA48+X+eOpwVCGY8o+KYstonhF?=
 =?us-ascii?Q?nGRiT/UYuqz1h+bTgYljqFvFAyJIIZE2bIzZIYzCeYf92BpnIhLRH9yHGo9x?=
 =?us-ascii?Q?ZlE31uoZQwnGeCYfpjo02F0SbhFZfW4oJQAvoU0+3vGke7xK+grdxvp7yye5?=
 =?us-ascii?Q?YDnswqdepsDEnSmrAvseLW17fGQaCSm1EDf/I3vTk9RPLetQ7dqKe8vRVU9l?=
 =?us-ascii?Q?nAPnza2wCBsTWMdg5JnITMrThPlSziriRRonGo/hSFPGkIhjRkaSScmwbcQf?=
 =?us-ascii?Q?B9hvdCmw1/hp7RTHWPXVjPXtL12D5Av6bcjfrX6AEqfByboa0j1pPuBDBgKI?=
 =?us-ascii?Q?qZuzQyPDVRe/LNmNcwaI6QLbMmftYzGPgC7iOPSPDlXVzxwdjF+U+HXzpJNL?=
 =?us-ascii?Q?Oif59BKS+antxfte8SKf740BRUQHD/J2RfmOLb9SOep12F2LyGy/kTznvA1h?=
 =?us-ascii?Q?GBY0cQncG8I9ViXdwQn0Sr7Fr2qyqL0Lg9RZgcwkf90Qdk+mDKk/lJ7XB/nH?=
 =?us-ascii?Q?wTeBieJiatYVO7bewNKQvF0AxbKSq9a5u8+CcahPAQD/PX+ODlILsGq1ewBm?=
 =?us-ascii?Q?26waa9AgvPU83vPfannjE85Q91AVs7ce7ZdmFc1PiCGIIYGB3eHqt6m5Stq1?=
 =?us-ascii?Q?6rvzBsrWoXuADHOOrbh5U57AkNUU0i6PNDEhCHHSIhLoOslUQrva1STcAXrj?=
 =?us-ascii?Q?cN6n5b2AKxk0x2O9lI83kD51+7Ze5osqy7Wo/bmXrz6l7j5mvOCDJTisnY8/?=
 =?us-ascii?Q?I0oAQard1PwIQiTMEhXVWFe7ZKxbLgM2sDcJEXTZV3UW1BuXbdT+AdNLkDEt?=
 =?us-ascii?Q?2DsWOpts4N0EiTZF6vfcZeNKqiwen+s+Cpauhe+wRWL9Mq6qErBiwhZZUPiw?=
 =?us-ascii?Q?sqlw+a+R2SVxzJP6l+rZ/aV/mgmKsFBf/X8oNN8yQb4u+uRjloAe7sdsuUp/?=
 =?us-ascii?Q?awxoIgq94jHpnxQlYpWTAYXAiVPhZZ7Ww3g+jqSh5jTpbZqr/42NsuOVQYNI?=
 =?us-ascii?Q?1KoSvZYZpWZ4O1Lv4LF6Agpskq4za0Os34Tkn9DrKZYW7tt7DyR2vmfPuHDM?=
 =?us-ascii?Q?wxR8EZ/iTCEWUBC3ndpDEL+8q6hgUlbSisIqGwK6hDw51HPg9kaFJW0N1pM0?=
 =?us-ascii?Q?6tSlVPCT172ZdQ9cNvjOEGngNMp/dvZl0Fq1GsPqLkofV64f3P9sStO2GivG?=
 =?us-ascii?Q?ESiDF0Z5MelrlHfEXcAXheYOAMLyaLJrhA7YHc7j7NXOYpUBly8pROSqlbmd?=
 =?us-ascii?Q?75CvsC7UGotdW5XlFjFkOtp7n/rELTtU1wvOmOt7ferhZRFb+nFwkIfzcT0U?=
 =?us-ascii?Q?5qPEd18u7UJkpUfT8HcHN6kHlFsbwcx+afkWz3PKHLwoURLbfFifz0S61uWO?=
 =?us-ascii?Q?VyMdzyqxEUSF+j7f4aa1ktXRZioWJHH7uz91r2EPUastcL1weSPPJWMb/2b/?=
 =?us-ascii?Q?dTf7c8cqIaq5GTuWq13UDC0fqUibxG7iCHE/zs7PU2lWP/4t1CVBiY6eAEfS?=
 =?us-ascii?Q?KAlM+7kmwzXMFCTz4a4neA4QEHq40Pty+LgSA+Z4/dSdSCS/UDAiNL2le46M?=
 =?us-ascii?Q?tuMlBfw+1tP0rhI0uW7AVPpw5ON7VjF3dm/knvEy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30532fee-f26c-4bdf-7809-08dbbf55cce8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 12:32:23.7095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LK02t1Tx4Bk2ch5sqOa2FGvcK3Jmvcf1Y2Y3KO2M7NywhokqK/ftURM5GBL3ZTrcv07CJQsEUks/InPhRhpyNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9046
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
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
 drivers/firmware/imx/se_fw.c              |  23 ++++-
 include/linux/firmware/imx/ele_base_msg.h |  13 +++
 10 files changed, 324 insertions(+), 1 deletion(-)
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
index c225cdc016be..b2ac00b3ac7d 100644
--- a/drivers/firmware/imx/se_fw.c
+++ b/drivers/firmware/imx/se_fw.c
@@ -20,10 +20,10 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/delay.h>
 #include <linux/sys_soc.h>
 
 #include "se_fw.h"
+#include "ele_common.h"
 #include "ele_fw_api.h"
 
 #define SOC_ID_OF_IMX8ULP		0x084D
@@ -48,6 +48,9 @@ struct imx_info {
 	uint8_t *pool_name;
 	bool reserved_dma_ranges;
 	bool init_fw;
+	/* platform specific flag to enable/disable the ELE True RNG */
+	bool start_rng;
+	bool enable_ele_trng;
 };
 
 struct imx_info_list {
@@ -76,6 +79,8 @@ static const struct imx_info_list imx8ulp_info = {
 				.pool_name = "fsl,sram",
 				.reserved_dma_ranges = true,
 				.init_fw = false,
+				.start_rng = true,
+				.enable_ele_trng = false,
 			},
 	},
 };
@@ -99,6 +104,8 @@ static const struct imx_info_list imx93_info = {
 				.pool_name = NULL,
 				.reserved_dma_ranges = true,
 				.init_fw = true,
+				.start_rng = true,
+				.enable_ele_trng = true,
 			},
 	},
 };
@@ -1252,9 +1259,23 @@ static int se_fw_probe(struct platform_device *pdev)
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
 	dev_info(dev, "i.MX secure-enclave: %s's mu#%d interface to firmware, configured.\n",
 		info->se_name,
 		priv->ele_mu_id);
+
 	return devm_of_platform_populate(dev);
 
 exit:
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

