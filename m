Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F2C75DC7F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjGVM0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGVM0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:26:43 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F779E67
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXuNFmm/su7wKEDYHSirc5eGs0CksZhLiN3XA1QpliE2Std7u6nwWJS82BtGMy6ty9t1UyFy1N7w9xGYsWDroMmnu/q72uN+20l2Knize5qxYI0RwvPXoUbMfJKTUe3PgWQBFXYUmmb37Nue6iCGlwdVw0ewUEE4yrxm24xhk+M72u3l0YKAjv0X4m0uLI/53X1EXli3bHNo0yb3YEZZ6rO/LNVGMya2qZzzdS6o54QExtelf9SsPRxlUD2X5O1xau6vCjq1oZ/wsYSRS+hEMvlKI/kH5sAn62Z7zr+fVugdtVr1XieLcd+sy5EwhNDjPK2uswWUJHFRbobZta3jYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eXsJHj1jKik5zS42sb9oDfVAHK3/hCH/diRSXT4zP4=;
 b=R0CT/QTzn7SBsMd+JG8DAkG1VDpfxH1+R37mLVAJYf8ClaSHqf3bgMtOh3Lcxzt8ruSyD0V3PTMlaxge9eOkwVWQ6fKVlVyzbY3aI2HrsIiyQ+i3mpM6nOJCCPucOI/0GlyxIPABe3y3tl1DUoFIFL3gybz2rHd9rDGZM9gHlde3YPU9KdoQ1+fO7wYVInHOaxlkouGtpnSRnpxUrfnIx0BySGRr2YRBIuwfh5TgEVwZHdwHih14yQfUetWJOb34gdEfD9eTTXCfBaGraZzhd7OFVNFr3VEiaPUmjU4uFv+dCefqc5ptAxDnMMvu1xQJISIrGHSv3930hSylqg8iTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eXsJHj1jKik5zS42sb9oDfVAHK3/hCH/diRSXT4zP4=;
 b=GomxHV5s4SGCeHCMakbDXFhcdeGAj1w4EiAAf2pyfmzjwXc3dWfj+WwD8A4sdQb9YQuZwblfBrloUmeF6FxIfbZuy16u7Lp+u9WnqdcgXMIqT9r6cax30xzZXHtyj4wv5fCMjdwLJcd6qn3oM31rzKlF4xxz61Qvse7C2FY+8x8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9461.eurprd04.prod.outlook.com (2603:10a6:102:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sat, 22 Jul
 2023 12:26:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.029; Sat, 22 Jul 2023
 12:26:39 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/8] firmware: imx: scu: change init level to subsys_initcall_sync
Date:   Sat, 22 Jul 2023 20:31:12 +0800
Message-Id: <20230722123119.1966998-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230722123119.1966998-1-peng.fan@oss.nxp.com>
References: <20230722123119.1966998-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0d570d-eb2c-468b-7b17-08db8aaee62c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dkK+yz1e+/JhBrglxEWLvfmmOlRzBJHFu4s7tN4GEc1uICF+RoNbtrEr9d88VWcGoswDZ++s3jJPev+e8IG1huXf7p5ycZ5pWgq/T98wDjs8POztR+3Udt7R0SuKuZDCbU+FxD6Ibtyp/xMDIyybPLv8OJuMgxQOX16+BqLS5Qlj8fDLKASAal7L4fIvNQ/ox0ZZpQRpm8MgYQw4l0Pyrm0MygkQXkn6gn8mFPDWFEZZi5WomM2932bGVodLAilbYVPlAwrnKFC6a+MrlALdlzCWxOyQQ2kGDGIDRBUm69wJRBCnGL4Ra3Mm94xcIKwhlpMgZx4v6dG0fFXdnaSsL34ZhlgoihRCMaR6Wt/Gkzg2QUw4xR4ywewWNALoUr10jPkDLoX+n3w2Av7e1oXbl3ATVhrmANkjksAPb9+rk+zRRmpE/ZTQdALliqmfTSjJXKD4uC463k074i8iIxruxI3I8kOd5Skf5tP/j82l0/mc7hTAq/8dMzQNGL764audcnsqUEj12ZSDzAQWNAdKGpql4oFqEZMKMRnkPl+lX+5008Dn2cBvsZcdbyX5IXDNIkdwBTLaGftgsnQ7xUMs5SwL0k2hiWCD9TyiXj4+e4ckyH1wc5zG0MGTs159cAOf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(38100700002)(38350700002)(2616005)(83380400001)(8936002)(8676002)(5660300002)(478600001)(66556008)(66476007)(4326008)(316002)(66946007)(41300700001)(26005)(186003)(1076003)(6506007)(52116002)(6486002)(6512007)(6666004)(4744005)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LLl5xYvQhSzT0XSdXKNe8EoQUW3iDcWJvli6i16e8qEXYF/sw4betFxHk3uU?=
 =?us-ascii?Q?ibghm8Nmpjrnp/VHVKMfMEybm5eDRB0LuKxilH25hPjkNwkDEGpgT914PYVb?=
 =?us-ascii?Q?X86o5yJyvgEvSo6TBjhY1AKdNHelQu8LRbqAkeHpAItcx3uUg7/SklWWx1HT?=
 =?us-ascii?Q?DjdF20UwD6SKLRhiyJnj58AnFzex37kAzMPmV3GecOg/tvW7cA7arDIt1D8A?=
 =?us-ascii?Q?6i/DZkyMwWmOCfEpUAnJgPMi/7ZFTUjcgybTuwBsppjfWNTsd0ieAZjMncLY?=
 =?us-ascii?Q?9E06ZaEK66exYhERn0C1JUtlIm80AFMl9S6Z5lJR70K4IG8Kjc2xH4i+xLLL?=
 =?us-ascii?Q?VaraDfYEGNvTvebCIQ8QJ3m3T59YUcsg6KDMqt6AtH9O/OYVifbaSnXAYZcx?=
 =?us-ascii?Q?WyvU2w1QDtqH+y5PfPQAAX4KlTSet9pxlJBmsvVtJvdagr3gFn7bP/YQN62a?=
 =?us-ascii?Q?B3rU9MqDTZeae8lBBGH5j9qsRH9nHAjU+gbdzC6b3JZnlcXmemPCCxGO8Ob+?=
 =?us-ascii?Q?8UDj385xAWDUOGtklkX6ud1ICrKZe8EHEKoIy1DQDBFR3z10f6kgaP46AYQI?=
 =?us-ascii?Q?MJrDLPD1ItrAVQd/jzNGTPKlc33l3TLCA+Ot7/DMQYpQ4LnAXU229+MvpCxq?=
 =?us-ascii?Q?9DScLxeuCfQ5spdHfLwU7b5DYJ9g2efVOCnscmu80SkJ+YLwiHeJOypZVbqG?=
 =?us-ascii?Q?UBenMoje56xVDhc9V0MTXSX6hECZS4twaH5u9mCPd63VsfytnXOya4phbfBF?=
 =?us-ascii?Q?Zr+TXNlUGpFcmyeUVzdizEP4vCtcSWhTqivmFH7xvo707tTxZGSKiwB736EP?=
 =?us-ascii?Q?yVIlIvTH45IIFxfWTzh1O36o/8cKEPLcpeAqj/1IeM5rNEopGVhs+6u6ZD7/?=
 =?us-ascii?Q?91n/SJtr5fM2aLUtlAxgEl6roTMBj5L4wBg8rhlR1Udd/XicrW00CyJcq6pf?=
 =?us-ascii?Q?DZ5j1kv0FMtxWpRzSXHfZu1IUynWjJZ4clgXMHmBWz5QzO644nOxqXwK6JUD?=
 =?us-ascii?Q?4RGz+PnPB41OAsCm9Wl8ldJ5+PHFD7uPwtiPpLDWDPQGxcXbs0UvTPPF2HcU?=
 =?us-ascii?Q?/UngUBbxyIS9OC7KYAyKnxuHNLJmyaVzF6CZ9BIqXnpD7gKxr23wMxdQOEF/?=
 =?us-ascii?Q?hV9LSLTFZFmkyfFGYUt6mRDMqTqsF+GLQYnkPsA3Cpu8l8lfemQ64uQMkt/Z?=
 =?us-ascii?Q?sBajCd/fKRggbewXPxMq43uxLbaPA0ckY6oSlu27xsYtKdPzJqzrwO6vB1cD?=
 =?us-ascii?Q?nAIJBqUDH6/pGvXmTcOm3Gml2qGs2coliT/2xsf2FhRxapjwUe20zftazcKz?=
 =?us-ascii?Q?no+ObwMNTxuO65ekY+8vgYNwDH+J14x742xEW3Riluc0y1nTg3PraZDnFKU5?=
 =?us-ascii?Q?bcy/8tiZITYWH7yvK3IlsLuq3w3hJJalqQlMxmP/8h4h46Auk3xkVfiIQJLe?=
 =?us-ascii?Q?9fIBdh0ffxSYwKEhepH3VOkfuMgNwLkqlGfDpY3veeXV01wMWgl/7x6rTokd?=
 =?us-ascii?Q?aBttYL1uSaloia6vqxAloQOuxcrqG+ldnVkaktSE58P0kq1P3tgq9BH7YGlS?=
 =?us-ascii?Q?TNmtGah1vIWHnWbzxnRwf4YY8OEXOjzSKk7vi/C2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0d570d-eb2c-468b-7b17-08db8aaee62c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 12:26:39.6838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyJW+Riw6a0iTUHvgKo9JXSq1d+Ymn/yaqlue3vwrEUNE5fh7Q576j+zV3EMsrju5JPbIWj1FZNfO+JLuKxGEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9461
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Change firmware init level to subsys_initcall_sync to ensure it's
probed before most devices to avoid unnecessary defer probe.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 47db49911e7b..2d24359420d8 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -353,7 +353,12 @@ static struct platform_driver imx_scu_driver = {
 	},
 	.probe = imx_scu_probe,
 };
-builtin_platform_driver(imx_scu_driver);
+
+static int __init imx_scu_driver_init(void)
+{
+	return platform_driver_register(&imx_scu_driver);
+}
+subsys_initcall_sync(imx_scu_driver_init);
 
 MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
 MODULE_DESCRIPTION("IMX SCU firmware protocol driver");
-- 
2.37.1

