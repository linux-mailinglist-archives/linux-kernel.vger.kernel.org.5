Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCDD769103
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGaJBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjGaJA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:00:58 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D2E10F0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZP7FRmU69y5rLZa2uKgILCigLsJjajAGAcfcmvVMhsVqvo4Fz4xmWGwvKXJ9Q5QkqbyIU1BBYyUgnmIpaBBPqCnZ77y6CypyVBxjRThN6WK/eIMgyH/nMvgeKk0zCMohez3NOMtfFjzdz9DAayRE8elYiQ13yKqck5LzTQYNasuTv9Z0phM9lmcjRACsnOKtbmfmaWG58o/tG7ls0r3tDRpFpHeg6Q2AHQzPCNjqNaWdd21yHgvOg2o3/jgxgB8Y5tFMX1sBR9TTdCv24vq7TQ2UAzyZBhUJDUEHlQQzpY1Pt7WbDLAGsiOZ+so9zldR4qWH7YsjW10Jg0xhz1Gnmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rAd508ifHoA0An7ui7Mgs5JacaZLYV2a17LbZu3sU0=;
 b=JPdvwSQP3cVPjC4kIFVORj7bxjaK6efr9jnpfNwfYC+8Z2+mxYbYzTcS4TKs6LfBnxjZSHQqzQ2+Ax3mCNoy4B4hikM/p7Da2XdV3cXlR2MasjRVc2Ih382PfsTgflddSx8B02c/379580nCmEhkkVLYbg42MlvqngJ2NG7lmA+S3HO9CpRudrgS9b1Kvf6FtJLfh8bJ56fevTDzZ+6TkAuJBw1wAS4KlIvif0AxIXhhljW8edQMSN7XV4ltYc4XQMekvEADA9YFPEMm6AWh6xRR+w9GJCmeby4R7TLF+hN5p/hyP1/JdkC4zhuLCX4+8HzC6uVXg3XpySzPgP8B8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rAd508ifHoA0An7ui7Mgs5JacaZLYV2a17LbZu3sU0=;
 b=UgSR2/I9+7UA+kg7Se8/5uOp5738ZVNkuWWhuniZMVRsbjygS/T81WKymEJPXnVZG0+AcCv2LGRo5BdLsiC2puE/hNZdP6Waj+zfpYf1NOLKFMHCt26m7AeKeDBuNVrZy9V5Kgo8H8e81cB3OHgc5AWFvbILiYVLd5WGs6BBAjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8229.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 09:00:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 09:00:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 5/9] firmware: imx: scu: use EOPNOTSUPP
Date:   Mon, 31 Jul 2023 17:04:45 +0800
Message-Id: <20230731090449.2845997-6-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ae984465-13f6-4b1f-9c6e-08db91a491ec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g13ijqHHFTzpSFmZd9Na0az0et4kWWKVlpOcCIUw7YCdWnPksUqi2jFqdz/6Ba/cGa/XayUidXVBvDd2Ovb6UDtMsBrXq9W4SnH4RykQrC9oQugXu7ShxwGzpKPm+7xFjYnQnGVu2qxNDeuv2IEV0Unv9q2o5rKBC70tz7eDtdptGfDT1Z5wysT16GhDAC2OVRsNe+WazxUmHhZat2HCz2Iv3wWYqdXz/tH9RnPBNCHwOtj8nE3dYiCIJm0y3cXJUro3e7r8S8I9xA0r3cV42w8urqc3cF2NsicHAvcbPHNcx76kpq/OyDhInq4W3HSbiAgg44stlOtx1qUIJA4fj8lY95yJIXBQPzvj93JoXtYV4/0KUi/WZxTif4vM1un7wWzK8poRP/z3/0CT9aK2z3I8oRoMqjjc8yYe3XdzQW5+vrhPUbP2zMMXybrzJ+q87mNVIHeLB/6O44yy3zbmc11DpCQ7qKfrNGkQZNApifCC1ovzFFt7llOLVOY9GK12VFSzabHCQEY5xZocz3cYpLo8dfLm8hjm8n7/hTovO1fNnCvBZY0OI/EPYksTtwJGRz/r9TuIM35JG1/sDH2FJwMAOYqBw05f4c1hULxzGeWfPrXbCs7dNSPLRF7C3Q/d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(6512007)(6486002)(52116002)(2616005)(6506007)(1076003)(26005)(83380400001)(186003)(66946007)(66556008)(38350700002)(41300700001)(86362001)(66476007)(316002)(4326008)(5660300002)(8676002)(8936002)(38100700002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ZY+aA6QrU9wnwd9NQ1s2pisz6yal/LQqxjuXHqw/tgqPr3Ck7PLj1+bcWdn?=
 =?us-ascii?Q?C2zMekeQBZUwMF/VRHGN1mBzIEUrM+OzTROR1TpAgB0icV3wUMYg9i3uAvdE?=
 =?us-ascii?Q?JxR6NFFwRpGoH34h+8Hk/BccklHiNPHFrrw0BQosqMadCM10zubtlyGTFQDH?=
 =?us-ascii?Q?QqyroGzgzvOAY97AhvPHrb2TqI/PL3SAWX3xUpfmRaomI96LHqaB/2TPEpLC?=
 =?us-ascii?Q?RmjSwhGmiz1/LRycnrH0C2kLs2jG59coNWwXBXUAGOZMhSlpwm8gk2YlKYnr?=
 =?us-ascii?Q?qTMMRAKnAPzYPpCmJ5HeiV11+t8d6pOXHN0m93qtbmn/4n3bsysYBEq2UpVJ?=
 =?us-ascii?Q?GIiiRTVMRB46vJ5m8Qky1DTgFIqKoK90a6lc1eZUMCb/Zxd+I35UAysLLnvv?=
 =?us-ascii?Q?SFZhyl+7XK+obykmlxnJrIgN3TCfL9SQTjVSxWgQUnZLlN7090wjhHsQTEvC?=
 =?us-ascii?Q?WI0LJvX3cuQadAtgcKtoSke3W6RyjvS9a4Xp8kbV4l9uRqAQvrnSkLmlb0Cl?=
 =?us-ascii?Q?TfW6Fl3PzR3TdRgmaOBw2yqthIUqU69bx2y0sl7ftYtUQTGy+iu0wfRsavD3?=
 =?us-ascii?Q?MlOMx90pdYEfJOivqhA7ifTB0uIPqaRicZAdV1jzfqJ5QVOjEgjx4rl05dzw?=
 =?us-ascii?Q?RpdAEYUXDUVSFrQ7gFzCEW5RBuWmA30rV6u6kjWYZp8oCLJbS6EsSrOFRgUb?=
 =?us-ascii?Q?ntldLlt1H57ebRPvHbw+RrEGyoDbP28q2sVTvhilGhUNAUjpUicsZ0XDIb28?=
 =?us-ascii?Q?hxRmqN+k1jFsjkKAZxlqk6VmdClv/1Tydu8/106/d/Ma2lc9Wgjg0Tz8rrD5?=
 =?us-ascii?Q?7101lk4Hxv8q+whPzJ0zelgspdLvf0fSrdUW86vZ7muR2rSXFt81+0kBhu/N?=
 =?us-ascii?Q?ED7WjS6xmAw/fOvg2TkQYT03XRKTTmgyUZHM5NII72ivpy4gm5LT9FSqzncc?=
 =?us-ascii?Q?37rsA1n1nGO5qmqC9LTs7Bmc7YAfZyE4aMSUMV7Ykg+AVLRq/B6+JCBa7p9f?=
 =?us-ascii?Q?u4d0T5+0htGeorDvbqEM/4Gwk7GRT+oArSj8xVIKIA9R1xyJIOXCbBV1XXoB?=
 =?us-ascii?Q?5G7qLmEUOFwGOWIY6jugQnrWhYoYUDU/cG+/e8LqbBm9Gs0e+vT8Nm6H5dSy?=
 =?us-ascii?Q?rnub3CFV85B+48souxUsjqb7Xh+8Ae/cwmE2Os2MDco+uehO5njjzP0a81dK?=
 =?us-ascii?Q?cvtiLR3Ov9HD4/6RYkyH28BzhraqzsrucnolT7MZS657CiKV3lXTyV060DaO?=
 =?us-ascii?Q?t3jq/WHFfv6fFOYj+NuS/Bw+8aenip6ptxFuHsgW2BOTT7zJRZwSa0OmJHQN?=
 =?us-ascii?Q?UVRIhjhgsOIeNl7jGw/I6ja5qvDeiW8NEeRc7HtY5uBIt5xLus18krF+xlgM?=
 =?us-ascii?Q?g519wQ3TLxHdzyRNT/u9TzZMceCcUT7RVgwob8HTliWaB6KYMLiAmN7n9TyJ?=
 =?us-ascii?Q?49EyH+WVUz+8yYlC2OXMdncB7pWw2y9L0V8lEDD7CLsYjn41lfm6o3MIhU2p?=
 =?us-ascii?Q?4O0gX/f2g6e92OPjQPT4KMKWRGAWOqMKDUDYwipNgqnF+xwgOWlIY0N9VDf3?=
 =?us-ascii?Q?mZwmSpHu8e/sWubYUTqkzXDG9Pgmdy5IiR4Ih59A?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae984465-13f6-4b1f-9c6e-08db91a491ec
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:00:21.5224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kASZT/C5hDe4vcwFRXy7FxAk9jDTlpDkz3vt1UohweJKXMc/iPq/FJH4U3JswHTvM7GGuoQRd7ZhpbmP6T32A==
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

EOPNOTSUPP is preferred than ENOTSUPP.

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

