Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90887690FF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGaJA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjGaJA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:00:28 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E063412D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hh4/Y/ov5Fn1nOUhG8HLGwh0HpU/YJ6TWI/xWUm7044i4/nq6iFRzlyB4vkEQQH3ifC+MBYTSsxbxvXVhL+Hcz7ppj28XxBMmLX5KtetkerpD3TmLZDK8NBy4TuWMm497+AWT2wX+nXML/4BvpGDM/9g5OmjeFWUzSFUuIkTvght6D9dreE2iqZlBUsDC92yKVpzJ4NzGNJNy+8FnLdKCHU9wIYcGHrJ6obfQKLWc596SqUiFuuHoKuQH2cQcr5yisGQXPY7JEWFfzZ3e42Nz4Lb5p5YNXfthethWxozL8Bu9Vj+BW4URlpX2ZmHxlt3yJuFjcjLtomiuf8Kp1rB5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1EaanuMVw3yN21IXzDoO2thxcz5R4f6468cftBXaho=;
 b=XPgHvNQozMR7ycHTwnIKvTE/S7340fVWjLrsqPTtuRcGWWbWccEq9g3qyLm9HkVxMxQBTvDK5QzM3+0tx+gyBXtbjLwaHVcg5SDon7yPJXIYcagnfrBfxDOgWRikqRjM3N3p5D9bmzHmUOWEOoQw9UA6Xyk9AkDmmuAlL5evg1ZoMxsuB3feckX709Kl2+THR2JL4apikv6yRjfmzavSX8nY38YzTEZGVWihd8qIVpMfUZaSKTDI32uzyJv75hLHq/AhUhNIka/iwJH0cd21AiWNvyVqasQNHpM4cbVTbafMpjSLIlyQQ1Oupe1cTYvTBfbyR5mF3llHdX3YDd2rwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1EaanuMVw3yN21IXzDoO2thxcz5R4f6468cftBXaho=;
 b=MBBX0I8rAmEAcrqllDd5KpnjfIkhFDR3mSPtc2w6cSXqSX9hQCNLkj8iM1pu2/BzenI8uxpDgr6r3aCJYj6M394NAwfOoslW5s7IfU4D65i3yYcftr0WRSMSBHTnomNQUcqqsdXpdKf9aAKUTPBMjhn8SAdaSwD8XD/CbbXI85Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8229.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 09:00:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 09:00:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 3/9] firmware: imx: scu: drop return value check
Date:   Mon, 31 Jul 2023 17:04:43 +0800
Message-Id: <20230731090449.2845997-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
References: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: a31d6047-4fff-46bd-dc72-08db91a48d89
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G811fF9hv3PxqvFGkefcbSko+11XIAHvE5gi5jmjshguwfhaWnHkDdVvs+UV0aqeTPB7hXVKc21SrITp0UxgemFvqJY06/HOibzwEAVWI9Z2iYHBVI7niVYmqJnwtlvW4lq+rSS6rkxBfeVPjTg6d0shfX5ImpVlFzoxdfcIQ1ctpKfI6GRs7cyYGh4lTiZqEtcYAR3tR5uw2mI6S23KEvHWtimaIVNM2RkDaATG7dtxX0DbKhZ03bbAEFh140XeaVQCmhSMXkTvhNcBYu0J2/klVzJ5OOdJPPsWe2iQiPf+62V9pCai5V9awGcoFfB5FDMabGrIHiBAky34dpIqkrQfhwGFlwoy3cGJYuYOQC0ORtiiRDmstoIeJRzMaaZ4HjH958APsSaPyZF/C7wLWj2hUDjVEGITNrSDI8xEVTfLGGwJ2Ghch2PkJnbVESpWZJdKQ9pK4GDYV2GCYkYzRnGXVlibUdUj/WsPNavPKxSyS5CC9ki2UTe1AgLrT/7o98Nl/ffhNSDbjMTWcbeJkkYosD8j6E91UbjmOPbPJaN8VVpqxI8DV2+8vvDxJdwJhy6bKjNi74gkv1CqzF6bBl3Gl3ZdEjAMI31kT2WEtBXx93kfsdyGWg/1NSohoRu4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(6512007)(6486002)(52116002)(2616005)(6506007)(1076003)(26005)(83380400001)(186003)(66946007)(66556008)(38350700002)(41300700001)(86362001)(66476007)(316002)(4326008)(5660300002)(8676002)(8936002)(38100700002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jbanhc4JNpUszJlfjCPansVpCyPWpr2gXmda2clFhsDhg/BSssA9RJV3R3Be?=
 =?us-ascii?Q?qPV4xrMXOe6EAGZ7I0iOXStICh2+W7S9UqUKnltzWyLhBFbBMhrMxwTAFkC8?=
 =?us-ascii?Q?nVkJkCezguH2CP7dCl26gaszvf8qh1b88hVAtGnv+5jB7Y2fYs+HqWJysCQQ?=
 =?us-ascii?Q?2lxkjJt8bWhnWsfLME7mGIMdODA+YYXX2IG3KgtVCZpjWos7SJOn7QF05NDr?=
 =?us-ascii?Q?s3VOg97iLyDFhxFoJM498sDdZ4iJ4Ia0Pnb+N0ZluFXwRfHY//dH2gOVHk8S?=
 =?us-ascii?Q?XmFXdnN2ylPffJxStutTKWAZbCIsjbFPLICd7c/J/yqHcMvS8ljjEyA3gRR2?=
 =?us-ascii?Q?KzvbufLu+w3oxM8cAsGUNM/diNksQ7dVDlUAzX4DA0f1QQLQfzzuLEtDWUuu?=
 =?us-ascii?Q?Cv0OOCsasrNrMlm7n71x29HJlBM2TdtiEjTKuOSwzSvrH7ZFVGUDkmajWxke?=
 =?us-ascii?Q?eWA87IApAflQcD++vkIM3/agqEtdYRRTqx20YvkGCaQ/hOacyNQmSc7oMSr+?=
 =?us-ascii?Q?LPmUi+vkBs4lmSiEtOgi1uKAJMW2AEQ7CiLOSL5smOed16weG2U5NLKC5he5?=
 =?us-ascii?Q?fnSdkkz19lcJ8TD0kHtowwuOZQxXdfMGYl/NeSJefauwduiLhAKNjAxUl5Kl?=
 =?us-ascii?Q?zpdbEA0GYEc6R4oy8loJpfJ1dj1KCsNjQc+bLK/655ZCGtdMR7dOAH/LQLah?=
 =?us-ascii?Q?SezoSBpagQHh6ejkoV0TRGWFVqoDoko0cvlPpImXZYIjkAAfk4VCXbbtMGLm?=
 =?us-ascii?Q?YqXL3ZnWX5RW7V9QjRJCAnWBxXU2YCbS+TwLREriGzb53iheNT8b9pE6Mq1w?=
 =?us-ascii?Q?T1OYJTKnQggTEbBo97eJtXORsVar3NJpD18oxNZwhUAxvRU2HokfN9L9qj/w?=
 =?us-ascii?Q?rNRbY9jkhniCyngtP+upGlyfY2SCB1z2vHamT2gj5iWDILD0IiyDng8b7iXg?=
 =?us-ascii?Q?VqcTUv2ekxEG+COXbLta6M2o2rOWzxWoHpbIiYFjCnUsLeL1QyQNb5JxX6XP?=
 =?us-ascii?Q?ndGpr91JWcVHjyfcWOAGNgHRVDZyorxee0cmxiEJpA+twNWtGXwQwyCQfI1D?=
 =?us-ascii?Q?0UkBG5Z6JuLvKF6+WAM06EyO/HoTD7k60xTw5M4u/UR8AXUZGixGgfajdyoH?=
 =?us-ascii?Q?M45vyWUuNZRMpe7RV0zSTngidj9c3cn77Hg0DqLi1J3uo9AM48QiCsWelme8?=
 =?us-ascii?Q?u2kEfnzU8b8M1/dZdUKw1DlBSFgKsynCWPRxNUQbZhoJAuhUv79HBJlnJkdl?=
 =?us-ascii?Q?bIHWCmPkEuoaJCioiRA4Yl8fte9srs19uxKN+UDqA+R6DQ3ImXkojdJkbyUE?=
 =?us-ascii?Q?wcpWHjguRANO2KfPAfKP3CJtw2qtzL+VnaAJ0N7mwsIF30wcpX8w8eNGILTu?=
 =?us-ascii?Q?i1C7AVspMrI5yW6AIi/7qdO/KoTK6Ba+nkwzVqa4600lpcGunkGO97g817Ag?=
 =?us-ascii?Q?hBJklhVxDTs9Lhsf1usIYElMbv2INmHetbodnAncIPGmm3IW40Wl3jYuS8Lf?=
 =?us-ascii?Q?b3Bk21CofXnJ6172UWBz1UzSxd1lkPH6MBoWDfx8I2teIeJNTRIZhT74QdB9?=
 =?us-ascii?Q?o7IYTlAywdlGKdPeyWsoOg/HR2s3qd/UyiuHhNoT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31d6047-4fff-46bd-dc72-08db91a48d89
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:00:14.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/IfkSp2Hl+Zd/+nNk4X7OuxQKUZDHMScxv/RPmOlGChUuKU/webt2U+vhV7aefzp7qzrtG0uITQ1sE67iSOtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8229
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

For IMX_SC_MISC_FUNC_UNIQUE_ID, the scfw has a return value,
and the imx-scu always return 0. So drop the return value check.

BTW, also initialize msg to 0.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-soc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-soc.c b/drivers/firmware/imx/imx-scu-soc.c
index 2f32353de2c9..ef9103987e76 100644
--- a/drivers/firmware/imx/imx-scu-soc.c
+++ b/drivers/firmware/imx/imx-scu-soc.c
@@ -33,20 +33,15 @@ struct imx_sc_msg_misc_get_soc_uid {
 
 static int imx_scu_soc_uid(u64 *soc_uid)
 {
-	struct imx_sc_msg_misc_get_soc_uid msg;
+	struct imx_sc_msg_misc_get_soc_uid msg = { 0 };
 	struct imx_sc_rpc_msg *hdr = &msg.hdr;
-	int ret;
 
 	hdr->ver = IMX_SC_RPC_VERSION;
 	hdr->svc = IMX_SC_RPC_SVC_MISC;
 	hdr->func = IMX_SC_MISC_FUNC_UNIQUE_ID;
 	hdr->size = 1;
 
-	ret = imx_scu_call_rpc(imx_sc_soc_ipc_handle, &msg, true);
-	if (ret) {
-		pr_err("%s: get soc uid failed, ret %d\n", __func__, ret);
-		return ret;
-	}
+	imx_scu_call_rpc(imx_sc_soc_ipc_handle, &msg, true);
 
 	*soc_uid = msg.uid_high;
 	*soc_uid <<= 32;
-- 
2.37.1

