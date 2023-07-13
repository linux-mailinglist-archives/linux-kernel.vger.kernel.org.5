Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FB8752BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjGMUuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbjGMUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:50:06 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD7D2D68;
        Thu, 13 Jul 2023 13:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ha7SX5fTPOkyuyYqQDPYaZDDwHVt4rpFXsLzEtBGR54ILCXjnQVihJivM65dnv0JEgC/0UxowIVoaGNSgaeXPnoYEOtjgcaopAk4jREHwfcGG516aIAvxqTe0fX1sdJe1N8TupwiG+2FNX+FwSQBwSdOuIPZE5J1AhB6wkh+rqz/77PI+1c1bH1H9nwHaZUcBNVpBAseUC1fpMIW4FrVjhGlMgHc1/xX35a3+u0YjDdeVimAd1+cdGj3eQJUkWUwgHZ97QMcC4or4RgstkDLjlv/SAUnChYbbqNED6+GbrMJaLElWziK5GrcUQMYb7DprxY4gitH+wndjN3yFApkpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EA4jMpLY3coHVia3Tv8eCKYtQkwpOwQUZGr5m/3lt6w=;
 b=fRtHwyFcBt/ltvZAkXIPaYrfFxW+eSA0Pb1PV/RoMSDZRmV/NxqPsF0PpUJQ2HJMpitdAC9begMYXKVioPVJt5X7tERD7cuhxbYAFiBTJIoA+miJdX8gdmpC7umORU9I4Ct+jp5xxlX56e8ucPAvBiqLHxiXTq91v1ptGFOe+4y73Snm1fRmi5CU/8iQ5qC2H3UdY8B78zUEJgBeZdbvKmCsgID8bMUL3QFH7moDup6KHGNaKF6i8TRancaqqCqbyxTRWbFwpsLW4d+haWfmejWf2KrCig7tbAWUU/9QcEEvKGx2TFpij8MejI8iSXSWy0Qb4Sit7VZuqCYYHu1urg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA4jMpLY3coHVia3Tv8eCKYtQkwpOwQUZGr5m/3lt6w=;
 b=R4gYaJkwAoD3uYnqsBK21Cz86AMV319Lk98Y8YBmu8w1BYAB3YNMB6Hxw970pH5iuFrOipGSl17h2mzJnW7g9dJcwGp0ukqh4S6zju4YAm2rskSsdIAv73mU/jrb52jL2eLlz5s+IYrUzVi6sZahP8gjBXMBk0A2JxYB8kLk0Hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB9731.eurprd04.prod.outlook.com (2603:10a6:20b:654::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 20:50:01 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c479:12c5:ce68:5e45]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c479:12c5:ce68:5e45%3]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 20:50:01 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH v2 3/3] arm64: dts: imx8qm-mek: delete A72 thermal zone
Date:   Thu, 13 Jul 2023 16:49:31 -0400
Message-Id: <20230713204932.1591255-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713204932.1591255-1-Frank.Li@nxp.com>
References: <20230713204932.1591255-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:180::43) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: 2567555b-920a-4cb1-6472-08db83e2ba02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: psff2XlUyi4fho2sVxL4pMVXz6FZEXG08n0zClpgyZxiQzj13TJgfILe7CRenim3K5gNnzqADIebSR34WFgfqNhlW7L5zoDDiSPLDg02Hqrh96u8BOrAAWKaxa016i9FMIyN9mxkXVeLZmqYB9RrDx2+veS4RM8voiZPtPtWFBR5sHuCqZIKWVawyZI5Ty9rfRcEuaf3t3k6YrZVwHln9f4+PChMbj/x/C4uDvWhxA5CKUh6RGS3uDveiHqKQm0I6j0CQ9iXqhpQ+aDgxwndEx76sYi3FlbK9E2JQ0cHQnI9MFY1MPSnBn192pjNI+gR/KfZFBzTnLT5I9BlJ7d/isUd0lWFHOT5y9dzU3VQ75zaOJ+t8cz27p/T77pSNM76EkaY3Myb4GvUD3rx5UmPcSVM2DJ3jgbxL0TNJ2EOBZG34Si4q8+agOZaR6Efz9E7ONVaVGFZO1Of72krpKtyZsii1DQrbndY93ZanXRsS5rpZwXCJYUAjP2oOy/U3IG9FIjuFGPwosSxMpxoKU9kDsLIxrf9uDTKsP+RJrscF0juIWeVZ+OOh4vwO78yB2eKNjdOhwDsvnhbUjJ0O0P67EZK9oAn2TCk3zbvLeZXLJcqK6aU+Ik+38PdkJ7bfRm0l8ZDWr6/g1IZYZRkp5/WyDzZy7UK7t2fbsp8bZ/pPk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199021)(2906002)(38350700002)(6512007)(38100700002)(921005)(83380400001)(2616005)(1076003)(26005)(186003)(86362001)(5660300002)(6506007)(6666004)(8676002)(36756003)(7416002)(8936002)(4744005)(478600001)(110136005)(52116002)(66556008)(41300700001)(66946007)(66476007)(316002)(4326008)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E8Ln8xxvPIUiqMztdStX+9MaXfpkwGO5QXCV/+QNfIRiKkmyNkpIaWxfeaed?=
 =?us-ascii?Q?fuIakYTf6iMCxC0THA96Xkqo3N4rb21FLgzkczpNiNslhkZ+bq+jtv4/3Ypc?=
 =?us-ascii?Q?8QUGjUlc787oe0RhjxAys5AedeCKjXjvjAIcg4FhbE9aXxge7cc0FG3aYLlJ?=
 =?us-ascii?Q?I67UJZPv4zXnbxqBpyuDz/P77UZLue+rHSM55lU7lbHt8Q4EoeO3kZacgLgj?=
 =?us-ascii?Q?3V+3hsq2XIg8qsWIpKwcMfhT+Rhd5oqEjAvoICKtDy182qDBLYap5Z/O8WSJ?=
 =?us-ascii?Q?0B0pk1FAClU+iNp69CtuqLO3c2AMke1sMSasDOI0g3GjhdWegfBirDh4LLuC?=
 =?us-ascii?Q?LmwkrRWgN3hKuTTeJR+euS59h4TPSyOyxD9FMY65uHIOuOTcghyYK3T5ODh8?=
 =?us-ascii?Q?OYt9FcxwXk/xn7KqFNS0kkn5jLaffjcbvQTDEh+5Ih+Al0eYQurIEaJX0xzv?=
 =?us-ascii?Q?HBq+qQiX2LsReYPlzBO6saHTsUY3ozrZ4rqRdQMo4uVTrA754jKXU7kfCrmO?=
 =?us-ascii?Q?OIEhuDNV0EaJjy+SEL+orYckKKsL3TEsRBKv4ij74Dtu8Uzxe8ij4fZlkfKj?=
 =?us-ascii?Q?5HpivqUswNgZiQmlurkogW9AIpVEpCT6IxloLR2ZEqzFfLWpbmGhcwnrNTHG?=
 =?us-ascii?Q?or8ob4UIblyC7qzoMLFHztx9k7vFkgUThR+E/EwCA/Yl7R2d/U+WytarBUeV?=
 =?us-ascii?Q?mR8lYpXdylHXRH1bqXqYQW/Ioc08SNLSk0ahdUFz0E2Y2XNK1sN+L+w/TKxp?=
 =?us-ascii?Q?8SB8bPU83fz2Up2XodKmfFrL9ByWK8FyZdh2WxoeiS0fgHn1yT/3oS5jzfOQ?=
 =?us-ascii?Q?4tGLBdGJsCI/x6WNkyjeZs07ZLxjFiCgI5GWt+axve612jUuYOa6F/TxpwE5?=
 =?us-ascii?Q?swK9NQbQJSQW3d0k+f75FiNKB5q89mPHCmAxKgKkXdZifNRgaq8Zaxi4YLfC?=
 =?us-ascii?Q?IuTaVidEzfrtel/R/jxikJkoyRvduCGZWMstStrbfU+AgHuQaAksGJul7uKM?=
 =?us-ascii?Q?0PJSBlbbuIeL/XeFbGWvVK6tj5AZTggg8UGTzGOu0H4STSt/aRL52vgnXHj/?=
 =?us-ascii?Q?L8CrqxFAVl5xfpn5DhcIIJxT+gEjDEFkr3nuFTMIL+Q7TWi+Nr2ctT+dgExV?=
 =?us-ascii?Q?TRhwpNNrYBH5WtN91zANn6n8bYpfFNVwqUT/SC++MLeiqU6hIxiqX1i7RrtD?=
 =?us-ascii?Q?UBFeTC83jLZGRLdbbo+tZJLOrzZvXxeHCqa5hh+C8drVxTg4NjQJ3nq++WNl?=
 =?us-ascii?Q?RYiIMDwkgkBHPN8aCBlBQDnth/W3d6k4aCDdYLmqIv6RdXQ2ib6XEbX6ucd8?=
 =?us-ascii?Q?CWtj/A/cXha0UWwX1I0uGEN1bbN5ZiPJlJ33OGxGtwUiYcbr/6mTReh8M+IT?=
 =?us-ascii?Q?Ztr6FpVImwH7nk82ChHRBSWVjewLEoaSvRyKzuZr76OwYVdx+yfHWJZ9tYdZ?=
 =?us-ascii?Q?sLO3ZHX9GEYcepLtcMCZFWnVzH0lzeU5Px2FKd76WOnbrEVS9CL64NNFgbik?=
 =?us-ascii?Q?VGEBIFGj2ieXtHv2WDmiGohb3OjgMFFDjx7tz1LkTSiDXIyEliOwmQh0Ib7K?=
 =?us-ascii?Q?7F7+0ft2Lps4R4Vz33jRqws13HUEJnSuhaJI/8Ew?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2567555b-920a-4cb1-6472-08db83e2ba02
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 20:50:01.2525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuB9zZzLRB54+z4+BmpPetrj4oqSGl47OWc403UM4jNckBFGSIv84NGg4uBQ2U3G1m0ZBlY8Ajep5T0CWakw5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9731
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A72 nodes have been deleted in this DTB. Removes the corresponding
thermal zone to ensure a successful build.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- pass make dtbs_check

 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 607cd6b4e972..0b34cc2250e1 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -22,6 +22,10 @@ cpus {
 		/delete-node/ cpu@101;
 	};
 
+	thermal-zones {
+		/delete-node/ cpu1-thermal;
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x00000000 0x80000000 0 0x40000000>;
-- 
2.34.1

