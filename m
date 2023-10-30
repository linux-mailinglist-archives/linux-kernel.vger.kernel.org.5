Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADEF7DB746
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjJ3KBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjJ3KA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:00:57 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9223F1BD2;
        Mon, 30 Oct 2023 03:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGEHgQJgORQuflSP8kgtGTFYDwhug6SCRZWfPwIvilVhlubIWWmqpPPr2PKPikE/cdBVxQbwBredGrqCUwXGKv1vcZ8ICsKxw0CWjHLaR3b2uRxqPjBIkfCes9kvJJYlwq7jRzUn26k1hm7fLnqxygnb4EBKDfAqoXhYCeN9GCVj/kry7v22F3ehJgPg5BOzHeylIUKcIupuXts8k4zJ5QeuX9/UYuq3mRriC3/X7Xm032tagc7Nh0YAFvVOp7tCPhUXTts+BxwEEHfIFsSIjwmN2N06nKpjo3dFcFGW35ATbDMw9N7ujPvkzW7sIPtQ8q790VaxFWAkP6//jwW51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCSVpQUTvwH8Yu42nuqPrmpsN8acGA6PQ7FPdBaJoxs=;
 b=CeUxuVnSHjcVQqJnqqaOoky4uzwUWeT6PJvYryakOjtlSQ8QxdMG28QKO4yLXhv6msL25Lu+LOg2GtTSuL31excxOYjxjxB9LSWriJ8DmEeO2Qi7E5Fl1cBS0nNlWhNNCVqwzRevsjCVjZ2MnmhDxJXFD4rV+JRs/GQRe3rAG5S6yMs34lRfk3UDVsnZT01UnGQwg5gR3IHsJNPeuu7ZvRmKF2UxwrEKfVrrcG2o4nFdOQ0HEuiLcCHfXzzJ3OvAKFU9K3UDUk/GNleRld2bR2KifBSQXGbo8YHuUWZ0nwCOOmydAGO7+If2l6MglVe5VEupW8p1pVzHK6609gdImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCSVpQUTvwH8Yu42nuqPrmpsN8acGA6PQ7FPdBaJoxs=;
 b=BVMdpC+XB3yRXytQ4zZhPTU817NjOyzvHnMDyHHvBAYd4TCn3SQgOJ2aoC5a4Kyinh+xwaUndNSR2IqIWj6+OjKLd5GlddBtOuvukgyLGOSjQ7h8WE3x9oTwpA41ukDZMajcwg4G24kU1cdrEZp85QlJ2S39NCDCtMJz12uNWXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAXPR04MB8141.eurprd04.prod.outlook.com (2603:10a6:102:1bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Mon, 30 Oct
 2023 10:00:25 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351%4]) with mapi id 15.20.6954.016; Mon, 30 Oct 2023
 10:00:25 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v7 10/11] firmware: imx: enclave-fw: add handling for save/restore IMEM region
Date:   Mon, 30 Oct 2023 15:28:48 +0530
Message-Id: <20231030095849.3456820-11-pankaj.gupta@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|PAXPR04MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 1984cfd1-084f-465d-1df9-08dbd92f097f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X5vLDXdQ8qr8iA+/NWSUfwoU5nXBzXIfwzMuMVHJPGcV7AUaGHV+8pDxJCP2EVT1wE9gI2l84AOSfFmFm3Qrjw7549MAO9encOgs2V12FVlEc+y2TKvBoLPs60Agfc2scWzUOQa5z7wNaV31t3zRGcawFEk1OtnOf5vcFXPa5hxlxSjUxHmMaAlUAiMogPcp5ePIL03+XMkWVJJE3PXcUtxXa+f9QCaWs61OZFQrBKxyWvNzefq3hr/Bs6fpTTmGFThaM8HD6lsDr94oB4qI1KrB6y44V+oKeT9aA1NhUw6lVxS+hXUXKdE1Pk88fZCEXn9oPDog/VdNlo6b+FOR8vyRqHcPuS1j7l1AA/iX5m1cTUOt6EYjtjbA8rXm3GnBX8Dv0bmCF42QZXvf9ICYhdbQeZ8XXX/Tv39gGCO67vGtPF9PW+9BufY8NlK/GtGruXy7PW2M688LEsdR21qaWU20rCGGE5tt+fOsqZtrJnpgEcwNoaENgEs25L10JlDt4HBS/fEjz90OYdu2rXrEIcjEEs+ThZwGsItA1DmNARg+9Zj8ZraVvG8jeBqUS6tnXJTRkN1+cxgW815JED2szFyHMNJvNo/+8+ze2HsuDSJq7MK8QkjHwhSvPmbrWoftEXBovVPVq+FGiuwLm0VpoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6512007)(6666004)(52116002)(6506007)(83380400001)(36756003)(26005)(316002)(66556008)(66476007)(478600001)(6636002)(6486002)(1076003)(38100700002)(86362001)(66946007)(2616005)(41300700001)(38350700005)(8676002)(921008)(4326008)(8936002)(44832011)(7416002)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bCc9YmPCt0E/oElRm8ozlGTJgZyh+kFM1BYDANIVFIm0IoFWAnNSd6Il/fGo?=
 =?us-ascii?Q?G0FXAGLF/fNq4suCkhrcvMY/t7kZ+GF9+WmNtuN4knPhED8otp+cyJ4ZckRZ?=
 =?us-ascii?Q?cUpITdzuewuNcI3DIzNuC2htqX0ZEjispaOgEhgrDkW/tjnL5qMjeIYoCGSg?=
 =?us-ascii?Q?8ah1LcpYlT5/IERpJOosXXOTh5BgnBjzOGrHawM+PSJ+8B3lBvdCYUKTSMW6?=
 =?us-ascii?Q?5zao08Lshcy5kS65NBVJP8pqIEjmkMmmE0wRXDQOPAG3xXLzdjrQ5QRhbkXx?=
 =?us-ascii?Q?Jd8xwxE4rJcR35SbqgSPyOCQEf3uGIK5c+5uSxJIgzsAfgQuaugs/MPImxVF?=
 =?us-ascii?Q?Wj7qnOFpsVJIJw3oK/nX0LwzlcpR2XFkhLglJSji338352ZFm/pPk8sqiRNa?=
 =?us-ascii?Q?R17LMbPto2mdQeTNkAZSbi9CMEV7I5lvp3OhLbvLGmB5QwGTIuUJKTtm95Om?=
 =?us-ascii?Q?FMCCkZZbz+VQ2e4UZXz1yLl8i3Lx7fBajFiS1JMZ22wkxd5JbhtQwwDD1PBI?=
 =?us-ascii?Q?4z7LeTYVHf+jV8lhNb96Nfln+khDtxF7RiiVoQFalPpSIKTnewLnkYJRDNwW?=
 =?us-ascii?Q?rY590DOxMJqkq8Zcz5oO2cxVxmGn+bm+uqXhgwnxkjDgmtAklpFA0l9C7ahV?=
 =?us-ascii?Q?z4PFkKndSajsab3j2O1LGyF+Ptk4lVmhH1q/FbnIMWI010x2EhsqtgOhFMoG?=
 =?us-ascii?Q?7ow+FrWSBTkv2k9IUTR/iC9gpzfykFd6BtEDucJE1g86pOQbRmUm+qa5jnxT?=
 =?us-ascii?Q?BYbllsIpP8krxSs6C8skCXnkFI5Q3NE1tBOGX2WATYFEbizwBtDkgGvh3l8I?=
 =?us-ascii?Q?CbjJv6QTATxAKxwUxdpELbQcfqNMzX9VHxV2qq1s5hFzSTqkQ1+D6mP2vwgI?=
 =?us-ascii?Q?mqi7DanZ57kjZLw/5t5GqQHCKUi/IfD+vkWEl1BP7BMkiBTlxlsXdJ4OYvKy?=
 =?us-ascii?Q?37fKg1VlGtHi7RzERNYlN4NcI27hY00Cb+iPFah/Q9KFqn14GAL0ay4jzhgD?=
 =?us-ascii?Q?tU6pvZZPQfmRQyfOJWxZNzL9uE3iWHQd5i8bmtHKXzn8B5fMDCdtjDNRIh+W?=
 =?us-ascii?Q?4EmiNLg2kLNEvlIO8e7G1+Lm0Asx7XZh0BF3K4/pJ0/77KtDKQVSDnW0CNZR?=
 =?us-ascii?Q?X1niz1qBpmKJeUxpSnO3xAUjt94QF1AV7slmUFDYNq9iBd8WIIEAUxqpE6Uv?=
 =?us-ascii?Q?QvdJl9KBRuOR3fpbpHngtx/paYJxl1ERXRs0qf4F84Ku6P8n5pO/TTzfpCKb?=
 =?us-ascii?Q?eqVXsjmb2KZOLRIntBE03hCUCWnq4CZS4KshLnFE4conULkZRYIsl96rqu5t?=
 =?us-ascii?Q?WFIbnxmP0oZxtpI798oLWPQqPCyth6RzJRdMJ3EoJa5/CTQ13pSzHsSxOm0C?=
 =?us-ascii?Q?fBcMpY9g4cMgdlUKMHUCowuYIbGA8Dm8Rgec+7zgsV8cBD5jE4UFCiWQGm4B?=
 =?us-ascii?Q?SlTlnbnHNSxBj5EFjKz+6Q66QCL3V7Ttidmni0OR3TI/JBxgrS+ccwt6pqri?=
 =?us-ascii?Q?NDqSyOHuor8BazGR7czPYF8q68ORkilTaLMZMx6iYWVlI5A65BTTRsy5X4MN?=
 =?us-ascii?Q?EFgp4bn3MxiC143no1o3WNuCS/prNahu86Purdqh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1984cfd1-084f-465d-1df9-08dbd92f097f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 10:00:25.2234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fosGC3gJihoxd5mBwjPfxZmD+CfAmYY3fojSwFzb2HoukxYLAAgSx3OwHINXpp1McGIBfwDBgC6yi6H0kN2qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some IMEM region is lost during kernel power down. Due to this,
firmware's functionaity cannot work correctly.

Saving encrypted IMEM region in kernel memory during power down,
and restore IMEM region on resume.

Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/firmware/imx/ele_base_msg.c       |  53 ++++++++++
 drivers/firmware/imx/ele_common.c         | 115 ++++++++++++++++++++++
 drivers/firmware/imx/ele_common.h         |   8 ++
 drivers/firmware/imx/se_fw.c              |  36 +++++++
 include/linux/firmware/imx/ele_base_msg.h |  14 +++
 5 files changed, 226 insertions(+)

diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
index 3a3af2321f67..844bb0e54c02 100644
--- a/drivers/firmware/imx/ele_base_msg.c
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -216,3 +216,56 @@ int ele_start_rng(struct device *dev)
 
 	return ret;
 }
+
+int ele_service_swap(struct device *dev,
+		     phys_addr_t addr,
+		     u32 addr_size, u16 flag)
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
+				    ELE_SERVICE_SWAP_REQ,
+				    ELE_SERVICE_SWAP_REQ_MSG_SZ,
+				    true);
+	if (ret)
+		return ret;
+
+	priv->tx_msg->data[0] = flag;
+	priv->tx_msg->data[1] = addr_size;
+	priv->tx_msg->data[2] = ELE_NONE_VAL;
+	priv->tx_msg->data[3] = lower_32_bits(addr);
+	priv->tx_msg->data[4] = plat_add_msg_crc((uint32_t *)&priv->tx_msg[0],
+						 ELE_SERVICE_SWAP_REQ_MSG_SZ);
+	ret = imx_ele_msg_send_rcv(priv);
+	if (ret < 0)
+		return ret;
+
+	ret  = validate_rsp_hdr(priv,
+				priv->rx_msg->header,
+				ELE_SERVICE_SWAP_REQ,
+				ELE_SERVICE_SWAP_RSP_MSG_SZ,
+				true);
+	if (ret)
+		return ret;
+
+	status = RES_STATUS(priv->rx_msg->data[0]);
+	if (status != priv->success_tag) {
+		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
+			ELE_SERVICE_SWAP_REQ, status);
+		ret = -1;
+	} else {
+		if (flag == ELE_IMEM_EXPORT)
+			ret = priv->rx_msg->data[1];
+		else
+			ret = 0;
+	}
+
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
index d4b829c19133..348f7194778f 100644
--- a/drivers/firmware/imx/ele_common.c
+++ b/drivers/firmware/imx/ele_common.c
@@ -45,6 +45,18 @@ void imx_se_free_tx_rx_buf(struct ele_mu_priv *priv)
 		devm_kfree(priv->dev, priv->rx_msg);
 }
 
+uint32_t plat_add_msg_crc(uint32_t *msg, uint32_t msg_len)
+{
+	uint32_t i;
+	uint32_t crc = 0;
+	uint32_t nb_words = msg_len / (uint32_t)sizeof(uint32_t);
+
+	for (i = 0; i < nb_words - 1; i++)
+		crc ^= *(msg + i);
+
+	return crc;
+}
+
 int imx_ele_msg_send_rcv(struct ele_mu_priv *priv)
 {
 	unsigned int wait;
@@ -177,3 +189,106 @@ int ele_do_start_rng(struct device *dev)
 
 	return 0;
 }
+
+#ifdef CONFIG_PM_SLEEP
+int save_imem(struct device *dev)
+{
+	int ret;
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+
+	/* EXPORT command will save encrypted IMEM to given address,
+	 * so later in resume, IMEM can be restored from the given
+	 * address.
+	 *
+	 * Size must be at least 64 kB.
+	 */
+	ret = ele_service_swap(dev,
+			       priv->imem.phyaddr,
+			       ELE_IMEM_SIZE,
+			       ELE_IMEM_EXPORT);
+	if (ret < 0)
+		dev_err(dev, "Failed to export IMEM\n");
+	else
+		dev_info(dev,
+				"Exported %d bytes of encrypted IMEM\n",
+				ret);
+
+	return ret;
+}
+
+int restore_imem(struct device *dev,
+		 uint8_t *pool_name)
+{
+	int ret;
+	u32 imem_state;
+	u32 *get_info_buf = NULL;
+	phys_addr_t get_info_phyaddr = 0;
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+
+	get_info_phyaddr
+		= pool_name ? get_phy_buf_mem_pool(dev,
+						   pool_name,
+						   &get_info_buf,
+						   DEVICE_GET_INFO_SZ)
+			    : 0x0;
+
+	if (!get_info_buf) {
+		dev_err(dev, "Unable to alloc sram from sram pool\n");
+		return -ENOMEM;
+	}
+
+	ret = ele_do_start_rng(dev);
+	if (ret)
+		goto exit;
+
+	/* get info from ELE */
+	ret = ele_get_info(dev, get_info_phyaddr, ELE_GET_INFO_READ_SZ);
+	if (ret) {
+		dev_err(dev, "Failed to get info from ELE.\n");
+		goto exit;
+	}
+
+	/* Get IMEM state, if 0xFE then import IMEM */
+	imem_state = (get_info_buf[ELE_IMEM_STATE_WORD]
+			& ELE_IMEM_STATE_MASK) >> 16;
+	if (imem_state == ELE_IMEM_STATE_BAD) {
+		/* IMPORT command will restore IMEM from the given
+		 * address, here size is the actual size returned by ELE
+		 * during the export operation
+		 */
+		ret = ele_service_swap(dev,
+				       priv->imem.phyaddr,
+				       priv->imem.size,
+				       ELE_IMEM_IMPORT);
+		if (ret) {
+			dev_err(dev, "Failed to import IMEM\n");
+			goto exit;
+		}
+	} else
+		goto exit;
+
+	/* After importing IMEM, check if IMEM state is equal to 0xCA
+	 * to ensure IMEM is fully loaded and
+	 * ELE functionality can be used.
+	 */
+	ret = ele_get_info(dev, get_info_phyaddr, ELE_GET_INFO_READ_SZ);
+	if (ret) {
+		dev_err(dev, "Failed to get info from ELE.\n");
+		goto exit;
+	}
+
+	imem_state = (get_info_buf[ELE_IMEM_STATE_WORD]
+			& ELE_IMEM_STATE_MASK) >> 16;
+	if (imem_state == ELE_IMEM_STATE_OK)
+		dev_info(dev, "Successfully restored IMEM\n");
+	else
+		dev_err(dev, "Failed to restore IMEM\n");
+
+exit:
+	if (pool_name && get_info_buf)
+		free_phybuf_mem_pool(dev, pool_name,
+				get_info_buf, DEVICE_GET_INFO_SZ);
+
+	return ret;
+}
+#endif
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
index f9e1d949dc6a..e1979b555b58 100644
--- a/drivers/firmware/imx/ele_common.h
+++ b/drivers/firmware/imx/ele_common.h
@@ -9,6 +9,7 @@
 
 #include "se_fw.h"
 
+uint32_t plat_add_msg_crc(uint32_t *msg, uint32_t msg_len);
 int imx_ele_msg_send_rcv(struct ele_mu_priv *priv);
 void imx_se_free_tx_rx_buf(struct ele_mu_priv *priv);
 int imx_se_alloc_tx_rx_buf(struct ele_mu_priv *priv);
@@ -29,4 +30,11 @@ static inline int ele_trng_init(struct device *dev)
 #endif
 
 int ele_do_start_rng(struct device *dev);
+
+#ifdef CONFIG_PM_SLEEP
+int save_imem(struct device *dev);
+int restore_imem(struct device *dev,
+		 uint8_t *pool_name);
 #endif
+
+#endif /*__ELE_COMMON_H__ */
diff --git a/drivers/firmware/imx/se_fw.c b/drivers/firmware/imx/se_fw.c
index 3638a4fed5e7..db992b3cceb9 100644
--- a/drivers/firmware/imx/se_fw.c
+++ b/drivers/firmware/imx/se_fw.c
@@ -52,6 +52,7 @@ struct imx_info {
 	/* platform specific flag to enable/disable the ELE True RNG */
 	bool start_rng;
 	bool enable_ele_trng;
+	bool imem_mgmt;
 };
 
 struct imx_info_list {
@@ -82,6 +83,7 @@ static const struct imx_info_list imx8ulp_info = {
 				.init_fw = false,
 				.start_rng = true,
 				.enable_ele_trng = false,
+				.imem_mgmt = true,
 			},
 	},
 };
@@ -107,6 +109,7 @@ static const struct imx_info_list imx93_info = {
 				.init_fw = true,
 				.start_rng = true,
 				.enable_ele_trng = true,
+				.imem_mgmt = false,
 			},
 	},
 };
@@ -1062,6 +1065,17 @@ static int se_probe_cleanup(struct platform_device *pdev)
 	if (priv->rx_chan)
 		mbox_free_channel(priv->rx_chan);
 
+	/* free the buffer in ele-mu remove, previously allocated
+	 * in ele-mu probe to store encrypted IMEM
+	 */
+	if (priv->imem.buf) {
+		dmam_free_coherent(&pdev->dev,
+				   ELE_IMEM_SIZE,
+				   priv->imem.buf,
+				   priv->imem.phyaddr);
+		priv->imem.buf = NULL;
+	}
+
 	if (priv->flags & RESERVED_DMA_POOL) {
 		of_reserved_mem_device_release(dev);
 		priv->flags &= (~RESERVED_DMA_POOL);
@@ -1281,6 +1295,18 @@ static int se_fw_probe(struct platform_device *pdev)
 			dev_err(dev, "Failed to init ele-trng\n");
 	}
 
+	if (info->imem_mgmt) {
+		/* allocate buffer where ELE store encrypted IMEM */
+		priv->imem.buf = dmam_alloc_coherent(dev, ELE_IMEM_SIZE,
+						     &priv->imem.phyaddr,
+						     GFP_KERNEL);
+		if (!priv->imem.buf) {
+			dev_err(dev,
+				"dmam-alloc-failed: To store encr-IMEM.\n");
+			ret = -ENOMEM;
+			goto exit;
+		}
+	}
 	dev_info(dev, "i.MX secure-enclave: %s interface to firmware, configured.\n",
 		info->pdev_name[1]);
 
@@ -1303,17 +1329,27 @@ static int se_fw_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int se_fw_suspend(struct device *dev)
 {
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	const struct imx_info *info = priv->info;
+
+	if (info && info->imem_mgmt)
+		priv->imem.size = save_imem(dev);
+
 	return 0;
 }
 
 static int se_fw_resume(struct device *dev)
 {
 	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	const struct imx_info *info = priv->info;
 	int i;
 
 	for (i = 0; i < priv->max_dev_ctx; i++)
 		wake_up_interruptible(&priv->ctxs[i]->wq);
 
+	if (info && info->imem_mgmt)
+		restore_imem(dev, info->pool_name);
+
 	return 0;
 }
 #endif
diff --git a/include/linux/firmware/imx/ele_base_msg.h b/include/linux/firmware/imx/ele_base_msg.h
index 3ca4b47e4c4e..f027f687de2e 100644
--- a/include/linux/firmware/imx/ele_base_msg.h
+++ b/include/linux/firmware/imx/ele_base_msg.h
@@ -45,9 +45,23 @@
 #define ELE_GET_TRNG_STATE_RETRY_COUNT	0x5
 #define CSAL_TRNG_STATE_MASK		0x0000ffff
 
+#define ELE_SERVICE_SWAP_REQ		0xDF
+#define ELE_SERVICE_SWAP_REQ_MSG_SZ	0x18
+#define ELE_SERVICE_SWAP_RSP_MSG_SZ	0x0C
+#define ELE_IMEM_SIZE			0x10000
+#define ELE_IMEM_STATE_OK		0xCA
+#define ELE_IMEM_STATE_BAD		0xFE
+#define ELE_IMEM_STATE_WORD		0x27
+#define ELE_IMEM_STATE_MASK		0x00ff0000
+#define ELE_IMEM_EXPORT			0x1
+#define ELE_IMEM_IMPORT			0x2
+
 int ele_get_info(struct device *dev, phys_addr_t addr, u32 data_size);
 int ele_ping(struct device *dev);
 int ele_start_rng(struct device *dev);
 int ele_get_trng_state(struct device *dev);
+int ele_service_swap(struct device *dev,
+		     phys_addr_t addr,
+		     u32 addr_size, u16 flag);
 
 #endif
-- 
2.34.1

