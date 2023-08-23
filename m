Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF017851C1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjHWHhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbjHWHhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:37:36 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2087.outbound.protection.outlook.com [40.107.14.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C1310C3;
        Wed, 23 Aug 2023 00:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWJ57fqv5sbgXvD/hCpI6eKHt5PLeQeaut19GLmk7OIxCpWXlSXnKb26WH7oTcOz8kDaICCffYjXcUDUVjo4MwlKB64SBNRJWy3VieveF21YjewLVB6VHnoOkHGXq3Rr0/G68lUD7zfjoaONPDi35x+azqmIBg6izu8EovH5fCqdPzHr6RNaote0+oewccx1XMvIWckyp06R9J0RXJVAEriGnQxNguLM7AkXjpEsbEWSt2SjIgg35bj6ZbG6jQBUWXrHhCgiLG/I4VGtDu+Au/NsIA8/QtMDik0JrXbIlsZPY8bpMjCpkd0tvDoQ4OsmU0MfZYC4ae9vb+nqSOzCUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/F4+c46ViuInHSSnHp75hx98JoDBOQH6vo2Q07qR6k=;
 b=GzU9/FeeJ7iHKI163dY98LqtFdiFbncSWcUG6Vb/0kAWtMK3ZcV/m1jzgbzrsP8Ma4YaldgPQuy+jkDTdphacZFn7Nx/Jkv99nqXxgXCE8emmHYp9zU4InqPqBQUQxVHI2cAEIZOXwDfGqTOoGYMXKvvCp+jYx7HNEYIpmfAKqpbqbD8xxlHN2O7qRj6Ch0t4cCIkMpY4K4jdwOHi5LSsdUn9ZGxzGlZmDyMTHiiDWfOF7Yt9YlT5m9GiWMjcQvboT3J+HyvvNIsVERpYgTGZ/van2z+DxopZsO0o6dMetggUKnDKkYgeeRXrG7M2KVUhnkwR8xDNHdndOfAJ7ejcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/F4+c46ViuInHSSnHp75hx98JoDBOQH6vo2Q07qR6k=;
 b=o69UeKx0nAKwz8Byb1jswRkLu1/6lzlHEdfC19MSjqo4U9MwewbM5P3I0uRLFbORUP4QYhstfsQOCLiUHoM9gQvdX93yKVtG6qlUjfVqV7CL0JUvywsj7svoOToK7KtZ9640cQu4xC8SN+90oyrSGGbi7M3xSNcwpA7C3NLZWUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS1PR04MB9504.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 23 Aug
 2023 07:35:54 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 07:35:54 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v5 10/11] firmware: imx: enclave api to read-common-fuses
Date:   Wed, 23 Aug 2023 13:03:29 +0530
Message-Id: <20230823073330.1712721-11-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS1PR04MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b438b6-d46c-4e09-9f12-08dba3ab957d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sTO5mY9+gmxFWO802CHNyrpTj1d7CjRXf/w6Q0mTFKY9uPY5Brcx5d9utbjhTH8BJv0zu8Xh83fvwv1CSceRB63CaHSZzIs5gpeDr24uUwPzT/ntUQ05mO1mHYezmA6wMrRbE2nvnWwR7C+gRaPx1SEremAjnO6YQHWCgFWS5bBQpdz+bM1GAmN3+JwNzVvgkHLmD/Vq8MjOUP3E9Y82Fu9dpU4JiDNWRE7wyxguaQyWLXv6IVXbo4F1Zq65LLSVWdC8Uhrp+MCvwhNpZOQHR0y8KlCbljcMWkWiN7Xw/WkrCDnz2ZWE8aSjmI5CQV88naWGt2Verh19jYItzYocm+kVeDD7WAidhksKcWIzrC6oGa3FCtnOlFp1tXW4CC9aDu2qlBQ07IMR9qD4Xh2iWQ+BXkLzbMcgJkTJgCvugsFHWWhF943vOxf0NcOiT/Y4/QQcmkL/ODzfhShHHb5HnbZb9TrhrgLg0V6n38JBm1A4wT6CMIz2LYk7uxQpsRHuz8t65M97S0ZC7XkY0i28zggyfHG/qIyIh5yYoJKjDnN4j8hKI3s9yGt41SSuqd03ylyftCJmVRZY9Aq+AxPPAWtuyIfFDqLbCJwT123HPYxlVKuB6/b/EQ5w5robBkOdg6VsXSHGbFPIbSvPktsRaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(1800799009)(186009)(451199024)(36756003)(86362001)(921005)(66476007)(66946007)(66556008)(316002)(41300700001)(6636002)(478600001)(38100700002)(38350700002)(6486002)(6512007)(6666004)(6506007)(52116002)(26005)(1076003)(8676002)(2616005)(2906002)(5660300002)(7416002)(44832011)(4326008)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oG4pVSLFzaWZqMIqi4rN2VXY4D3L9TNRALLB2L94tVXhHFx3Uunr28mSlEoU?=
 =?us-ascii?Q?7ftOIonkLbOmKaeK1Y3mTajyrLoWaLb39HwH5udPlC/fwxsdMlVSlEf3FMkf?=
 =?us-ascii?Q?eNVUL8yeCPG1XU0EWkfqNMZk8G5nnwZda73YPFk+SdnE62B6ROcBXG0X07yT?=
 =?us-ascii?Q?JW/LUwGwT9jHKpCIXIrqD3DyF9U1ES0Lc+oD2v/SDlpZq/sr47WZKbDN3UVk?=
 =?us-ascii?Q?vlpv9PM4PFiOvtFOHO2YT5NxBQoRiPAsy/MfZ8+8FKCVtdDZbIJbBZVIc74i?=
 =?us-ascii?Q?/C4cfWAq8we5ZeV6zV6o/4/zvnph7zF9F2fc5mQHutOubOC1El8N/YbJ0O/w?=
 =?us-ascii?Q?WaRVroSgDvKyzsYJJRFXTyspRaLJFAoGlCvvOPKNHX40MEfjzqhgQueRCuZ8?=
 =?us-ascii?Q?nxBxt8r3fZDCOpyZsxP/a1fHvvtaMQKeaUjB6DTYBxfc0gqZTxg5WeJHGLoK?=
 =?us-ascii?Q?fMhTTGdSKyzZQDz/GKnga+6MA4bFaiCCzqgif5TGIdkwuab5d0xIz0fVbmTN?=
 =?us-ascii?Q?URXjyVUDXvQcW+24txiSP7Ffl2u1DL5ykQzu6+JQ2zX3j8nVRzcjIQNQi96R?=
 =?us-ascii?Q?xNMjwcicakisQQNPGft/iJRgFWu69tiysE2RY+ffFTjHxYk7kd1SAVZal9Gm?=
 =?us-ascii?Q?QucPj1EBTwBPyBkEIjONeVepFh5UFn3w03wlyRTn0zJuAVLHkDdfcot8oUpf?=
 =?us-ascii?Q?5VmkVW59XaDahmlM/btm6ZFkbJZTtgKsSMXhk0M85lVnueucjzuMbemL1QBC?=
 =?us-ascii?Q?2mkQaQRv+lMR4bDrFwIWTFK/g34C4ghm9XROqTqtsaNgEBwRaD7CFbSVAwfv?=
 =?us-ascii?Q?OYccO7YpPlVXTw5mowyX9xoHybpEFKl08vR8c0QGtBq81TaRT1wYMtpED/Zu?=
 =?us-ascii?Q?pqi42Qny0vzx5GfapvmnLU3dTI3VAu91cKJ5oJxXP3DFP6NzzeraAx1S77fN?=
 =?us-ascii?Q?zddtVRA9mtljQVyB8HiGfrNFxLZPzbxzMUv0Ig2Jpk05jB1rt7An4qNPjLB9?=
 =?us-ascii?Q?9ayGUOcu6eAPSyua508RSliRBSxsLxNEkSnU2OBmNaniIgCpjQZMu6mpmQLR?=
 =?us-ascii?Q?oekklvOy43nspKAzGzDcePLVN0YUq9xROu6OSZMRlMQmon0LeeIVRusZWshr?=
 =?us-ascii?Q?L3J9FwonPMVgXXGpQ9H3cv1MHZeCra2iwSCk6fT7YjBzwk1jUG/EdNUYw2Zs?=
 =?us-ascii?Q?Uz9H/Rhx31V2LE8rku/SmRM4qrhDlsBL0W5g5dNH/8E4pmrBgCkSUOTuS8Co?=
 =?us-ascii?Q?YsXbmVeo3z3gK9y/F1At45N/sImmSGaQuhfM6YaFFDQswpOpfbBaqJ3F/j0R?=
 =?us-ascii?Q?uAiHYTLtvqvR0o/EuyusN1uAB/TO3MHjEkWxPUlLxfYCUsBSSjKwfMPrVUR4?=
 =?us-ascii?Q?N7jLi9txtCh6vMPyo4Icy5Ptqha1y79CQcOqOrruSNVQMrILlzLMKSflmIsp?=
 =?us-ascii?Q?V0liwjLUqo7cP8h3bJumg0EJ4XDOmmt/0g4RfN3KpFrXOLG8xR/5ASu90uTe?=
 =?us-ascii?Q?AcopiaLYWjnNuGVIxEV1rV7CZrj+f/2wrzaFvJIaTOHK9qI9AtO8DC/29QON?=
 =?us-ascii?Q?97Q3nWWLnNM6Fk9WaDQPbnapKM6rxt/W/NuDpup+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b438b6-d46c-4e09-9f12-08dba3ab957d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:35:54.8146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owgsOOg/cQY9kbStP5Uq9feHQsU5LNcb6w3KPOHLZR04gQTdWRuRoy4MWTLkz27QgCOPANeHhJ+gdJe3tPas8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9504
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added an API to read the common fuses only accessible to
enclave-firmware.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/firmware/imx/ele_base_msg.c       | 80 +++++++++++++++++++++++
 include/linux/firmware/imx/ele_base_msg.h |  7 ++
 2 files changed, 87 insertions(+)

diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
index b19ab8abeeb8..9785fcdcc29d 100644
--- a/drivers/firmware/imx/ele_base_msg.c
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -190,3 +190,83 @@ int ele_service_swap(struct device *dev,
 
 	return -EINVAL;
 }
+
+static int read_otp_uniq_id(struct ele_mu_priv *priv, u32 *value)
+{
+	unsigned int tag, command, size, ver, status;
+
+	tag = MSG_TAG(priv->rx_msg.header);
+	command = MSG_COMMAND(priv->rx_msg.header);
+	size = MSG_SIZE(priv->rx_msg.header);
+	ver = MSG_VER(priv->rx_msg.header);
+	status = RES_STATUS(priv->rx_msg.data[0]);
+
+	if (tag == priv->rsp_tag &&
+	    command == ELE_READ_FUSE_REQ &&
+	    size == ELE_READ_FUSE_RSP_MSG_SZ &&
+	    ver == ELE_BASE_API_VERSION &&
+	    status == priv->success_tag) {
+		value[0] = priv->rx_msg.data[1];
+		value[1] = priv->rx_msg.data[2];
+		value[2] = priv->rx_msg.data[3];
+		value[3] = priv->rx_msg.data[4];
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int read_fuse_word(struct ele_mu_priv *priv, u32 *value)
+{
+	unsigned int tag, command, size, ver, status;
+
+	tag = MSG_TAG(priv->rx_msg.header);
+	command = MSG_COMMAND(priv->rx_msg.header);
+	size = MSG_SIZE(priv->rx_msg.header);
+	ver = MSG_VER(priv->rx_msg.header);
+	status = RES_STATUS(priv->rx_msg.data[0]);
+
+	if (tag == priv->rsp_tag &&
+	    command == ELE_READ_FUSE_REQ &&
+	    size == ELE_READ_FUSE_REQ_MSG_SZ &&
+	    ver == ELE_BASE_API_VERSION &&
+	    status == priv->success_tag) {
+		value[0] = priv->rx_msg.data[1];
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+int read_common_fuse(struct device *dev,
+		     uint16_t fuse_id, u32 *value)
+{
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	int err;
+
+	err = plat_fill_cmd_msg_hdr(priv,
+				    (struct mu_hdr *)&priv->tx_msg.header,
+				    ELE_READ_FUSE_REQ, 8);
+	if (err) {
+		pr_err("Error: plat_fill_cmd_msg_hdr failed.\n");
+		return err;
+	}
+
+	priv->tx_msg.data[0] = fuse_id;
+	err = imx_ele_msg_send_rcv(priv);
+	if (err < 0)
+		return err;
+
+	switch (fuse_id) {
+	case OTP_UNIQ_ID:
+		err = read_otp_uniq_id(priv, value);
+		break;
+	default:
+		err = read_fuse_word(priv, value);
+		break;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(read_common_fuse);
+
diff --git a/include/linux/firmware/imx/ele_base_msg.h b/include/linux/firmware/imx/ele_base_msg.h
index 6fbea7a8d7c9..99a135c21f56 100644
--- a/include/linux/firmware/imx/ele_base_msg.h
+++ b/include/linux/firmware/imx/ele_base_msg.h
@@ -47,6 +47,13 @@
 #define ELE_IMEM_EXPORT			0x1
 #define ELE_IMEM_IMPORT			0x2
 
+#define ELE_READ_FUSE_REQ		0x97
+#define ELE_READ_FUSE_RSP_MSG_SZ	0x07
+#define ELE_READ_FUSE_REQ_MSG_SZ	0x03
+
+#define OTP_UNIQ_ID			0x01
+#define OTFAD_CONFIG			0x2
+
 #define ELE_BASE_API_VERSION		0x6
 
 int ele_get_info(struct device *dev, phys_addr_t addr, u32 data_size);
-- 
2.34.1

