Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01637B0410
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjI0M1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjI0M1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:27:34 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC831AD;
        Wed, 27 Sep 2023 05:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYiqvjiRu5eOCNtKm3f7SRCs9Yk71/RD5yjgdUAHZqbWFsdsh89uVgYGQSugUvzyJUugXvp6n9Sr6e68rIa76jQE9wO313KW9QBZJ9kN1lugwU/p4T5UiLHZXb2RuN4tojs1qKKjshhVoRaJXYMehnm7lfCbqTKUFMWBW8cKPRRlU9G2TDaOGj/NuNhJjR2w2iSN1R/pbim/ZTl2CBn+wC0F62VpWhpNCrLPuUJ6+478VyJLb4p5Agb/ipox0Qgnhhm9DGmFmU9f+qk5ic0MG6/UCD7Y6vn/gHsdKdFIM9qeiwD7qp02YQ9kiN0lzStCuRhX2bVCENysh/4Eobv2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPdk9tpDk8gF9CSpSdzRlpIkHY9v/04YuY0kfVQW9WE=;
 b=aUNBj+rbKj6frLpr3LF4+4e/R3TyeNKXO1bKk3IhOLYNdWoNJtpc2/tdflbWkkh8vhDeonr6yNvuoXUlSEIsBDN4XhAAquIrCfRIikG4yBFjk21P6tgRVSOlpzQ5uh6GJ4zRiOvGtQdISk6Z1WcwZpPl6grjxs3FO2uDlyHQdneVJW0e7tTr0lQl2dEzNMrL6pPI3QlzGC2+0CR1fHQ6/mXg0D8us/prmTI2BgQ3MXI/S/9WwWgumZTtBrwRaJ/BKHNID3Td2YPcKutTEOipqRl+BC+l0EbojWoRs3L82IaZFgzEbmolOkQVV+D4nKPpr6sRCW0pjo/2BhVgelS2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPdk9tpDk8gF9CSpSdzRlpIkHY9v/04YuY0kfVQW9WE=;
 b=HUIM4zi4mGKgyqCf7eWtneO9IAv2WiOx5PlBTJFx4D6F/iNbMwxmEmimU9FELv57pxbY5XlYCckboRpzkIOFLyR0QhxZYeJhbrnh/PYWjFM9iyiu7nnNP2B2xssUCWhJZdySNhzxIqGixmMekQZvWa6XjvbiJuVssOLvD60pZdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8181.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 12:27:20 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 12:27:20 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v6 10/11] firmware: imx: enclave-fw: add handling for save/restore IMEM region
Date:   Wed, 27 Sep 2023 23:24:00 +0530
Message-Id: <20230927175401.1962733-11-pankaj.gupta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0d48cedb-f829-4642-3cfd-08dbbf551846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8zPWG3A4NtGoJa8vcdtKKNUHvZYek2KalstZhFwZwRD+GLHzu1wNmTwuo5xlA2PmNLJIl/N7OpA7URXo2Z+nAN/kaSO9+8F35TfUNHG1oHkQI+KkpS05E1ju8RSWXKbmrE0DaEJcTNkJh+qeZr+hcd9mZ/5nILrlY7+B8aIWu6mAUyZAZy9Bex4Oo8tHjTDjTbsILEO/EVb9NEaqKQ+Ay57C5lC3W1+H6uWaXKmT6umfTL7pSSHdyexh7oJwyHrNAJWnKST3IuTluwJN+DDkhFKYk6DtH6DoFcUSild6KfV3HBA6cFCgv7LiHkQg20TNTLl5Bak2c7TK74giu7B54QCVxMTw03ZzSLi8sPl2AEjOQd7pKScTkaGjqyHLcWR7VojK/1XjBREY2wpKus3BJ1Nf3LU0/BYCHbptgvqG4SNpARzz8M7NblcTDHuBfok2ca+nzMtCF+7UymT5mfMimoDC2xYX5X3iPzopllINq2FWItJ64ha+bzuykqalg7oYbvD8vtX4sOTuCW8UnLjFfX98zU8h+CD3/z4Tvg7Hm3WPu6yL3acMHBYzFehC0snvNJiQrYuZq+qrFWhNoaAeolQCjRSjOupEX45m4nA+mm1ZG+zEnjoesNEgMiWJN7EDyk/nPiBiqO2o4gZtnSC3vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(7416002)(5660300002)(316002)(921005)(83380400001)(44832011)(41300700001)(6636002)(30864003)(8676002)(8936002)(36756003)(2616005)(66946007)(4326008)(86362001)(1076003)(6666004)(6486002)(6512007)(52116002)(6506007)(66476007)(66556008)(26005)(2906002)(38350700002)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ORHX//qu97Tm0aPXR32GQ75hJWt1AAVaKAqFrOWhqbi1FjRjz8uXkuaYA9fa?=
 =?us-ascii?Q?e0I/t3+4e4ymnk85I8kBrxNPxOPVr4AnNSNC/nebWIenUMeRgOBteGK0bRyb?=
 =?us-ascii?Q?EwtKhVkZq4DaCHUAguEYpwIzpR8jB51nHpnVIy4TGYwLT8DPBszGBCsQqQom?=
 =?us-ascii?Q?QTbkAHRUgsU05BmmnGSxU2diYnQWKxzw5q4azcfwYNrwgGTDZap0QyGoaTKd?=
 =?us-ascii?Q?PrJFhy9YcvyiWWzxyoXs+LQ+xdnzwmfj2lTIKM3oVFDu9vn9U41qGah8qa/i?=
 =?us-ascii?Q?yGGNv4p2zp6aF6UhjztvCaIrVxN+Y5gWgxvGclhs0715cnacR8v8UuD06qGk?=
 =?us-ascii?Q?lZ+ptHUuKDrUi5QTClnVTgB29Tih0IJ5STYypRU/Ua91NVmliGrLslUNosdP?=
 =?us-ascii?Q?q6UtZkbS45UmtVaGu30NGVwBSe3RIjPtPKBZ2SkWJNgV2EyrkrjELI87Ity8?=
 =?us-ascii?Q?AjBqsrjBcfat/YI4SXbKcMLzosBn7cdvFjR3qeKbOVCEV6/KLe1i2+W8Aohn?=
 =?us-ascii?Q?2JWNdwznszYn4Gmyd+t2NmNRidmescPcoF9HisvFUcSdItBhcinZVXYM07l7?=
 =?us-ascii?Q?fB6idqDRNKxpiufBpWlI2SwtRVA3FdnW6IKmkwnVHjK7K1ggxQbosKTywIUW?=
 =?us-ascii?Q?SPRTLGdYZ4CFvftyxRzaOXonWf48i9WikkgPdIbtG7cgrPu2mkuRP0dNMhnv?=
 =?us-ascii?Q?VowHcXEtAbBy0Wqm7Zax2ANNMs7ChFZUUAixY4PtS7q1nx6eRPjUGRToudUR?=
 =?us-ascii?Q?StvTXv323fctg3tsxD8m6oYI4BthNAGapWTUhyBlKkILm5nj0rbVtuFu9ROP?=
 =?us-ascii?Q?zbnuR0Sa4jwiHpTS8gT5G7i6WP3vw6tL9aaBiAkmPw+CduMK3NrhKU7pCGOb?=
 =?us-ascii?Q?DNBR26GNaE17Kt3rGX1u0hkmgDEfJXjXKAjizXh7WAUl4tQtdgRgANAEZqdb?=
 =?us-ascii?Q?h42FOqDLqEmIhNIWD2lZIdYdd9wZ+ujmL8MJYvY2e0jSyKmQht2ljg8E6IiM?=
 =?us-ascii?Q?OlJNKBZQIfOAcVk+5vrLMG2Ul7zvhS8//B2K0NGEpqdMUgniLssVwGw6GwSH?=
 =?us-ascii?Q?sONM6pUTbuVEACZlswOFOu5wxd8buP2lCKJsQnRED45YspE6B+39iO3FO9Wa?=
 =?us-ascii?Q?Jv3F5w+Qc3SlgtbuH1d8GbEJ5GT+vlzbSgugtE2rH4G2eFCRKeZa/JKFCF36?=
 =?us-ascii?Q?P0UDLOnKrVHJc2EA3jvK7Qw8yWLW2lYttyG1sEhnjXZStbutrI+KW1RE70TA?=
 =?us-ascii?Q?f7FAKCcKBOrj2nBdKtf9m1OOQUBNlOB8Pph50qjQLVvvJVCoiOhuGFnZPgru?=
 =?us-ascii?Q?vhX7Jo8pxYaPHMUXX9ReJnf2M1DAEEhaDI4/+7HpHcqdOXEn5BjSMCzNUING?=
 =?us-ascii?Q?Vm23ipJHiEbwGAT3rkXg3gsjxCU+wRL27I+QW17BWjemyz7AtTEysLzmWIud?=
 =?us-ascii?Q?V7gzCfKP5wB2k8YHT/L7DRslWhp49ThmnoqMyRnt0e3kcwU2OBNstT8z4+i3?=
 =?us-ascii?Q?mQfa8e8DCO+Irc8JgGXII8k0Zn862gnng8ShSGRbwhH6TPk1kEeQe3Lj/kYM?=
 =?us-ascii?Q?plOAz+n2ZvU3IBg66Zg5pz6bAr01uKyLKCIs73EZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d48cedb-f829-4642-3cfd-08dbbf551846
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 12:27:20.5047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LybHu+KvyHmLb40CR6NRfJvEvjBo9VHOG+q9Gh7uXVLvBqzH7j6EW/5A8hpw7siq/zXB98oskWqEdijZyT9asg==
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
 drivers/firmware/imx/se_fw.c              |  44 ++++++++-
 drivers/firmware/imx/se_fw.h              |   8 ++
 include/linux/firmware/imx/ele_base_msg.h |  14 +++
 6 files changed, 240 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
index 3a3af2321f67..473388357dea 100644
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
+	priv->tx_msg->data[4] = plat_add_msg_crc((uint32_t *)&priv->tx_msg,
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
index b2ac00b3ac7d..bae8c265bc9f 100644
--- a/drivers/firmware/imx/se_fw.c
+++ b/drivers/firmware/imx/se_fw.c
@@ -51,6 +51,7 @@ struct imx_info {
 	/* platform specific flag to enable/disable the ELE True RNG */
 	bool start_rng;
 	bool enable_ele_trng;
+	bool imem_mgmt;
 };
 
 struct imx_info_list {
@@ -81,6 +82,7 @@ static const struct imx_info_list imx8ulp_info = {
 				.init_fw = false,
 				.start_rng = true,
 				.enable_ele_trng = false,
+				.imem_mgmt = true,
 			},
 	},
 };
@@ -106,6 +108,7 @@ static const struct imx_info_list imx93_info = {
 				.init_fw = true,
 				.start_rng = true,
 				.enable_ele_trng = true,
+				.imem_mgmt = false,
 			},
 	},
 };
@@ -209,7 +212,7 @@ static void ele_mu_rx_callback(struct mbox_client *c, void *msg)
 
 }
 
-static phys_addr_t get_phy_buf_mem_pool(struct device *dev,
+phys_addr_t get_phy_buf_mem_pool(struct device *dev,
 					char *mem_pool_name,
 					u32 **buf,
 					uint32_t size)
@@ -231,7 +234,7 @@ static phys_addr_t get_phy_buf_mem_pool(struct device *dev,
 	return gen_pool_virt_to_phys(mem_pool, (ulong)*buf);
 }
 
-static void free_phybuf_mem_pool(struct device *dev,
+void free_phybuf_mem_pool(struct device *dev,
 				 char *mem_pool_name,
 				 u32 *buf,
 				 uint32_t size)
@@ -1063,6 +1066,17 @@ static int se_probe_cleanup(struct platform_device *pdev)
 		priv->flags &= (~RESERVED_DMA_POOL);
 	}
 
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
 	if (priv->ctxs) {
 		for (i = 0; i < priv->max_dev_ctx; i++) {
 			if (priv->ctxs[i])
@@ -1272,6 +1286,18 @@ static int se_fw_probe(struct platform_device *pdev)
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
 	dev_info(dev, "i.MX secure-enclave: %s's mu#%d interface to firmware, configured.\n",
 		info->se_name,
 		priv->ele_mu_id);
@@ -1295,17 +1321,31 @@ static int se_fw_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int se_fw_suspend(struct device *dev)
 {
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	const struct of_device_id *of_id = of_match_device(se_fw_match, dev);
+	struct imx_info *info = (of_id != NULL) ? (struct imx_info *)of_id->data
+						: NULL;
+
+	if (info && info->imem_mgmt)
+		priv->imem.size = save_imem(dev);
+
 	return 0;
 }
 
 static int se_fw_resume(struct device *dev)
 {
 	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	const struct of_device_id *of_id = of_match_device(se_fw_match, dev);
+	struct imx_info *info = (of_id != NULL) ? (struct imx_info *)of_id->data
+						: NULL;
 	int i;
 
 	for (i = 0; i < priv->max_dev_ctx; i++)
 		wake_up_interruptible(&priv->ctxs[i]->wq);
 
+	if (info && info->imem_mgmt)
+		restore_imem(dev, info->pool_name);
+
 	return 0;
 }
 #endif
diff --git a/drivers/firmware/imx/se_fw.h b/drivers/firmware/imx/se_fw.h
index 25906f40daef..c7123c9233ca 100644
--- a/drivers/firmware/imx/se_fw.h
+++ b/drivers/firmware/imx/se_fw.h
@@ -141,4 +141,12 @@ struct ele_mu_priv {
 	struct ele_imem_buf imem;
 };
 
+phys_addr_t get_phy_buf_mem_pool(struct device *dev,
+				 char *mem_pool_name,
+				 u32 **buf,
+				 uint32_t size);
+void free_phybuf_mem_pool(struct device *dev,
+			  char *mem_pool_name,
+			  u32 *buf,
+			  uint32_t size);
 #endif
diff --git a/include/linux/firmware/imx/ele_base_msg.h b/include/linux/firmware/imx/ele_base_msg.h
index 3ca4b47e4c4e..a7de50fdf8f4 100644
--- a/include/linux/firmware/imx/ele_base_msg.h
+++ b/include/linux/firmware/imx/ele_base_msg.h
@@ -45,9 +45,23 @@
 #define ELE_GET_TRNG_STATE_RETRY_COUNT	0x5
 #define CSAL_TRNG_STATE_MASK		0x0000ffff
 
+#define ELE_SERVICE_SWAP_REQ		0xDF
+#define ELE_SERVICE_SWAP_REQ_MSG_SZ	0x24
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

