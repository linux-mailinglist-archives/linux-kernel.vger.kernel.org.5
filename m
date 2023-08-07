Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C4A772375
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjHGMKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjHGMKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:10:14 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2085.outbound.protection.outlook.com [40.107.13.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B67E70
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOff0QAUBbA1KC76OPblauN5PacJOu7j0Ok1Pg+XawRPP7M/cFZnX2ixOzGFKwJj2pPyxqgz8NjawTsMfdfPSGIaMoxMO5GxjW2ceSgKzdW7iHo6XXDgLlkZKCJASzflvWaHE/W5hbUSLBxMWn11woO9ls/Prz/c5tarnXyw6H2bcd5Xv+JdJrJKt5kJKaIQbP8PLwv9C5qCv77RRudodNwHq3fEvIk3lh+RUJr8sYkHUN9c6h2RcawbnkdB9LHKjhqWXkkckHqHuThkJ8CyJ3jtDv210hhPRfIM4snYqTfvCOJSqo6GjPyz01LwLCX/dVOP4zG6XKPbOLCyUpUQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NS7EdCIQ1rsd6PMCsRTSPY+qUGooCs0ZjoaQAjP6Kdc=;
 b=k4UwIMFrk9y9kUxq8sCMcg7AeXaMJuf5fN6AHil9+El09QwSk8m7476vBdDAmW5HFb8cGWv7cDl9erCfIsSmKuEs/1cJsk2QvAoNoK/SdiGTTu8wwJqDXruTtBZYlqk8+iXR1INjBFQkDZZp4TmqCzQlXZdFkqeRhXYZlwX7UMcvsvJ/tVi1X8cV77nDAyuR6SDyRpm1Fz2xqoV13N2gMJwMXXOfY+NFMKie4FYlQRdb8naQfVbjeqBgH5z2j3gdzJ0P9IukiosZUEy1qPffuFExPoMPcgXO9p3QQEe3klgDnK5O2iALrU+z/BnGkQt1VqTqUjbq8Vvt2uabpUaTew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NS7EdCIQ1rsd6PMCsRTSPY+qUGooCs0ZjoaQAjP6Kdc=;
 b=GS/VAAGTl95inCHrzZMjP3vQfc5TsfjSeQMa1/jlVxKcQwwWdRnqxXWBZliUjonn/IhDsL7Ag/z9BwtP6A1vt+9frAQNfPypzRb6katkSMmvrFiLUy+HfJ+d+/cIdjSWxBEMk9GIwqIgaUOYoWzVbE3kArLQ0xU0k4jFRO223Zc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7261.eurprd04.prod.outlook.com (2603:10a6:800:1a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 12:10:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 12:10:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 4/8] firmware: imx: scu: use EOPNOTSUPP
Date:   Mon,  7 Aug 2023 20:14:28 +0800
Message-Id: <20230807121432.3970610-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230807121432.3970610-1-peng.fan@oss.nxp.com>
References: <20230807121432.3970610-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e1b743-6be6-42a8-f2e6-08db973f3ddc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HlsTw07uDcC9Lrg/kH9aaXaJdDd6lnJ7CIF8G7p4R/AMcEyKzXcYObg/P4yT4ocjqUFEpw2w0+T4ouYbN2+NKR/dNJhAqXgk+Tl+0tmfGFFrWQtffJ4j6bUWUz0vrWqbggAVMb3WZrq9nkpji8dkEoCS76Qdfa4SVTGeBFOZjK4tSbVCrZSUqsqdawoZ19tkpEJE32z8s047LxX5GLvCFPXL3o8OlZam/vG0zjM+JJPKLAmqzBXplSvG9Ly5WTZHtwAnHsjIZd0flQUNTlEwOqXCXYfcqltJSKUyABdPlUW1tMOcLpYPDNpgo4dQFHfk6BbT3nkPSo66AyneLydc+5nrnHSv/lcrBMUae6syMtLZ11DWvJWYDRXt4SxgM8F+tfaHpOhbwclsG3rflPi/qRkFoapWtriyAMoIKugeIFzJvUy78GbRgD6sqZflZHlFFJ1Cn+51T9YnrZ0zpsVLqm6vMgGX4jFA9eaMpyCqrV2+35f/XmkocHgRJ+XBmNBW51eUOECwM1KxzyM0cFiOSGGuBjnB5dsK5lP8EzevUUqshuvmKb2haep3U5m0EMrOlSepoHmLO1MsI7+MF4POvWc2rFTmYBXcaRINjsXQtIDDe1Qn74VpnQOVHBCOKfKk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(1800799003)(186006)(6512007)(26005)(6506007)(1076003)(38350700002)(38100700002)(5660300002)(86362001)(4326008)(2906002)(66476007)(66556008)(66946007)(41300700001)(316002)(8936002)(8676002)(6666004)(52116002)(478600001)(2616005)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ivV3Oz1jJdycx4ssQlzdY2CGWG9uNQosDqLQnxmbEC4Ttvhhxvd0/qXiUl3c?=
 =?us-ascii?Q?93HdS1IHuABjhtKS8qrQfry5QgRaJpuAtIDDnUVYVsxXvQoMx6f8xTGDco6/?=
 =?us-ascii?Q?fKt6SMXiiLlmiQ9U9899pE6y4n2EsrH7NEVRcLcXmJj+kED2+fRLfdiWnzKv?=
 =?us-ascii?Q?5qDlcU5+kQLtDEFye4SuHd75zMrYWSii6yoah3cMdPir8eT8jq1U6WxvAFMg?=
 =?us-ascii?Q?bp6xRYY1Dk5rKFYu+nO/nGFHemZI+M88tl5R5T1kfbrHcIUBhoV7Wewif4s+?=
 =?us-ascii?Q?FVLlgkvBhrw8s61ttB33qM9vwPPhHhmGuztrewdLw3CT5GnLo83ClMpFwHkY?=
 =?us-ascii?Q?K3BXQnCL+k2PeRm9fxoi/AaMYO2FVNoHDQ5UgUHv0GlkX5b/RJawGQkib5xS?=
 =?us-ascii?Q?tuk/RYhbUzJ9GH4f/5xFAl2l9b3a1pMbW9C2d0GNplkomcm1TgzsIfQCdtYl?=
 =?us-ascii?Q?v+L9y/H4u3roL7lCj74ZCfFWRQlLHeHVq0HgzSlKIlz0CT5EuIPOy9MaeC+Y?=
 =?us-ascii?Q?0cZMjnomk+KwiJsx7NtjdeffCZlqsKdxK4B0lhWhHfAV+7bWCYBegHjXYZoZ?=
 =?us-ascii?Q?BUV8hlx+X4c28+Ex53z7k+SwSJyAhsQwuU2J1uMFMGNdTw+BQJPQP0fQc8Ou?=
 =?us-ascii?Q?E7VXFSKV42LqKRFQms1BYfoHbHJH2VqmA/bh15kDrljj6tMXADzNKvSwAhMP?=
 =?us-ascii?Q?gvdM1u4SCKr+zDCirVrhsRMRR32RACCIoK3u4l/c2c3Fs/+YJgdgCurbaZyU?=
 =?us-ascii?Q?8LA6Av6GBCAoJz872jcUX0LCzUrsnD2N3Um/Ddx1FtBtxVLnl3WNeQNxUKJy?=
 =?us-ascii?Q?8OUHOV1+DiYDV02yQB08j6NQBnLyOiag26yrXyylRFBo7LJ544cLgyJo1h6A?=
 =?us-ascii?Q?zApucGHpkjIY4Zz/PDlGdHpuA6PLDcTx1TZCAgD7MuHbZXh+16M8DzVnRme/?=
 =?us-ascii?Q?cR3SbQbPITN52lIim3TCeBCl0hIDAjjC9qKDduumQe0PiMVsCx6rSGGZvnEJ?=
 =?us-ascii?Q?6Iphv5qP2YVqEQHwBEyJsBUGDSx/5c50X1VcILlz5rtVmiTN2sD4NH4DJ+X/?=
 =?us-ascii?Q?d84+If6vSpdDO05+uWPjL5evpyADEa+DR37QPWeQb8R1+K+Dwu2+FaHEUk64?=
 =?us-ascii?Q?NkOp+4wrc3nbV5fUsi5nXoFxtAqdQbxHRM1oDYkKh04ly41634pMDDisFgRf?=
 =?us-ascii?Q?BDnRDbFpur6xmGSXXngbplFdllRI2UF8x1ZcrMC9DHJMM2VxrOoAlBvQZoyv?=
 =?us-ascii?Q?r8NcLdm0DorpLpsSn+rP8X2gWLruH/+iLGNUAphOcVcMHCQcz6dViBjXPNsn?=
 =?us-ascii?Q?3QYdEA+mEGbc1tGt9qixDgA2EcyjPbIuqH7Qz3tGwIgQw4QnHdK7jGg5/xMd?=
 =?us-ascii?Q?egN2PD4ArpdO1whC11PZ5QG/ymMfh/nb59dUFSTwbiZVto48JTignJRnsNBw?=
 =?us-ascii?Q?qZbvnYD4EIYpdQZBZVQYmalnYwEkyjRcCl81nXxGxoyzlPvIQg0BIEzJl8SQ?=
 =?us-ascii?Q?rF4sVtMWYGterfr8n2U20FoCL6GpR+W6Vu8cemP4eNeUpa1kWD8RXL4AdrdU?=
 =?us-ascii?Q?LOXcBST9d+mfSPSR5SoYwruQRLy0Ewo23z4n81vo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e1b743-6be6-42a8-f2e6-08db973f3ddc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 12:10:08.3498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OaIJ2W5dT2SnYBraLSW6Jo/Q6WP1GyNXl1wzZ/vtKtqLIUwtmi7bwbsr+OBDfsFJkAqWqD3iYuxjbHIIm955gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7261
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per checkpatch.pl, "ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP"
So use EOPNOTSUPP to replace ENOTSUPP.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/linux/firmware/imx/sci.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index 5cc63fe7e84d..7fa0f3b329b5 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -25,27 +25,27 @@ int imx_scu_soc_init(struct device *dev);
 #else
 static inline int imx_scu_soc_init(struct device *dev)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int imx_scu_enable_general_irq_channel(struct device *dev)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int imx_scu_irq_register_notifier(struct notifier_block *nb)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int imx_scu_irq_unregister_notifier(struct notifier_block *nb)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 #endif
 #endif /* _SC_SCI_H */
-- 
2.37.1

