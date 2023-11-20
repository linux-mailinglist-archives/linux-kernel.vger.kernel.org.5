Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809A97F0F21
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjKTJdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKTJdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:33:13 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522CE94;
        Mon, 20 Nov 2023 01:33:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xew8easM797R04uzYfNa+vxg/KtYf6a62Eaq7Mba3VBDAv1euEPZ+5aP+1hjoXntkVX+ohTWg/GbKnD9XgLZ2ETjzSy73Q58RCosl5jeHXLWMVoLMrfDR1ecO8vS+lmtqyDfExndZY5rs2BrJGIv184BxNnWEbRvg0SgRyRUl4NfYUQn4zdUCf3b92DjmzbucXz38vMiKDof2f3baGCbkpqKCo8Rtq3+qNH6Gr7g7g+lsynXxHqTi64CvWB+gZmNKS0OZHsW0M1s8Q8oIx/YmPYV4Mamc0cwYyt0SpxYRmPeONjXB6Fw1Wt82R6pT4tQbvIhlgKqOUMFLYlJAC9DtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55lqGfXT1D7SkZI+/fbeZ4iSXeNWCNOkJlMpAeK/k7w=;
 b=PuFtgDYWKHZy9AzfVkGo2GmLWslpH0AZ1rsHF9I7PgCvCkecxfu7JUS7uecxfFhS9O5FyCPbUXc8HX16lPDZ54YB0dXnQVghOhkmAsjpGwdLWoHu+jFK3MPrnTe1C4Rp2wNumSwYJ0gBxylF475+Zq+Kd/jydUwkYUactMCF1M6L+/fyle+JouDy0IBjkASF70D7N90Jn6Eg0odoDum0aTbHmWvVago04Coow52NOPTDRZhr0VbiUDEUrc+MQPUkuS6lWFHMo7Wj1m51CM+P7dg5DRpUriM/XpNJAKgN84ujUvuP0VwvJnEet9q3s59skqmA/0QFqkz2LV8HiaZqeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55lqGfXT1D7SkZI+/fbeZ4iSXeNWCNOkJlMpAeK/k7w=;
 b=VoeiUZJNg9TQXUg8QOqz3I19ViT7vpakNyiqu8jgL0YqPUafZcWMwqf7TwbYQ3iaHjrqCwaBFZ2LTgVctYtDYnkGt/KvmA+8v10NyoC0qw9bYzCs7zAj3Pj/w6mYL24Y+2xk+MtJvS0x8tnJUcWChyFTGYwBmp0x8imzsK/zpU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by PAXPR08MB6592.eurprd08.prod.outlook.com (2603:10a6:102:158::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 09:33:05 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 09:33:05 +0000
From:   Lukas Funke <lukas.funke-oss@weidmueller.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Lukas Funke <lukas.funke@weidmueller.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: phy: Fix potential null pointer access
Date:   Mon, 20 Nov 2023 10:32:54 +0100
Message-Id: <20231120093256.3642327-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0445.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::18) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|PAXPR08MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3e8210-6f11-433a-8c28-08dbe9abb2d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfMEUSp0cBQCXFSaRMgIOzVce54lWFC1iq9ktqdirE2M9RqsozxxSYcK96zIyJYblh47heZVWJ0vDCrYyG2kgGs/6lOhe6mR6SXku4/S6w/WdFZuxexzg4ZoMG7WAj+tBerQnUMj2d2YFbztFe//+sYrYMqK0iDxX8z0jg+llRF4JxGG/HFaDmn2r3/yK0o7ql3Nf30Aq2nAk4cPBZB1qP29LH2qYUPcaZGts8qfUzIMP6SVf3mrA27wAEvuankkAi7hcWzz/qul35QE/QCx78iAji+maxI7htmtqs1wKI7/W9AvEk2nQvEShzBlsmp9rQcuTVymX0yHZwt70Mf1SECV4aRK/acJPEA08qIz6bgDuBRudk/FkrWle7Up9YD6wuiOF2WvtGlzXBflGmGwfCDHl7YqUMoEA+HKHK0dzVBd/C4urHHythnXtoLtJJXLzrFS/pi+exGQqswKoXiXwL8ocUZYNL/nmj62uywTXvSeJoF//E+VUducgE6pmMLlACs5KBQk9djl8a/tpUP5kk9JusLiFlOa2I9pQjPmuSzDpLPL4kLsfce9GW7t8OEVsZoqCkt6EovJvtPwUnvawYZY4GEfwHFVZOy22hZ9bHHu4NaAR9ddRl1dY/aECOv4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB8431.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(41300700001)(8936002)(8676002)(4326008)(5660300002)(4744005)(66476007)(66556008)(66946007)(316002)(110136005)(38100700002)(6512007)(36756003)(52116002)(6506007)(6666004)(86362001)(6486002)(478600001)(83380400001)(38350700005)(26005)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nzwm7PiGmF82ax/8V9OMvEaGqGSFajkogdceNHimL+a29Ji/ZQsIpWNN3kfw?=
 =?us-ascii?Q?q6Q6e0x5rMmhCWgxNp2nmfXF4/Yu1aC22ZZhWU/tirtk63+1ttRnNj4UQuuo?=
 =?us-ascii?Q?cu9/FljTGWkW+oa8gKf8P++4swChcNEZgXygsuKU+ob0uQK/C5z5gNz4PFDi?=
 =?us-ascii?Q?hoJV0rGR58jYT2dW+4e9PiauijbKEGgmgA5NLiQdt56up+dj4OoxxivJ12Dr?=
 =?us-ascii?Q?MLlj2lqkssTNezstP9fbfJ+rh2U7ZAJMpLlB95ZIPr7HRl/Ud5VH5mLFT5PP?=
 =?us-ascii?Q?k5kkvrp3BvGWjJ9txCEh4wiCXySJURNmTTUNp4QiebqFEuiFU5CDKOB9NcxR?=
 =?us-ascii?Q?+4WGhJ3LzatGPnb1jVHvkD9ICqyJerIO9wZG7MDzo8t3ory84yttLA7p5V2H?=
 =?us-ascii?Q?WT0k/dnd4dR2Pm7mYYMpDnXWDNb1A20A7Capiz+V23eoPejz8/tnpF7ofEOP?=
 =?us-ascii?Q?5ISgobmCFtBEi3jIBXXnYmFXMJ82AzfPA4pJT5pMxFkgsTgLZ7DZf4NjJbn6?=
 =?us-ascii?Q?2jAMfIQsN0eYUVI30t8HeW5xbAO/mQyQy974PAegzYNkYuihw0Lbi5ZypIyi?=
 =?us-ascii?Q?B24n2aD635KyYDFDTpdADnHYmoDt2GYmR/v37Jjm4Jb0Q7d+lJYzMjuKNC8J?=
 =?us-ascii?Q?xtig/OGr0U0aExhGvz2vj5Rtt8NVEH/fygTqajNxx1pMbZTKzWTq9MpQnnxq?=
 =?us-ascii?Q?FPaqTzAS5imdW3ow8yf/ZMPlQuqgYDUFBokoBERvlPvwu15u/M6rTAIBA0Da?=
 =?us-ascii?Q?Xm8aEFngvrrsucCq2BO49jn7cILCG3/cR/gBTepWATI8bdzG99sDMJSw7wGG?=
 =?us-ascii?Q?1gKh+fFgazKw7DIo7AAY8qfthT7QvqoWaeOPUf3f9DihdEMJ63yQSp2F6PMX?=
 =?us-ascii?Q?jOFGljsaRtm7GHLDDscSEJsZfVkjSSPu9u4KF3v2t4PuCoY4wGN2gUUSqajc?=
 =?us-ascii?Q?Tggz3Xl17i9q8fHto19zsW9VJSpk2GjT02PzN5rA3QwP9FtCKmwmmzMYyeT/?=
 =?us-ascii?Q?iJKxxfYAXlR3yZHNIUCwEcUnYyaHXMnM4QWkxrQdQOILZFeBvms2bkc8001C?=
 =?us-ascii?Q?xwb5myLnoyqq/oav+NlrVrjMG/vOJw9V6Moe4YQl9IGUxLPrFfSsIwBrI+oV?=
 =?us-ascii?Q?1FJ8VTZa86QFdxPZTAEjTfaqAbA+wlwCiMbL0zfksxN9ZvgrFV6Z0i24MMXX?=
 =?us-ascii?Q?8NpXgfL4YOJ2zgOa+qA319/KsDNhYv33t+dIlsFeaTWNcaTrdtVlixKQdpbN?=
 =?us-ascii?Q?K/9QMI72Y6FP/DAnI/UrcAoJIkLSiOXb73evmSqoJJfu9gJ65FLi7BlhRql9?=
 =?us-ascii?Q?IYpEvuJs7rV4IxrZDprWaH+mpn/Ggn9vKTc9jHoPevr3z/4mMAerN9FhG9zN?=
 =?us-ascii?Q?RnRnxWHltmLZjsr8rcY/MnJUsTX7F4K5B6XYUc1nO7cucmOgPFAMOwdJscaQ?=
 =?us-ascii?Q?fmE25cyvzjpql21aoMQeGfgmwqDaTNBaSOtdg80uQVLSaaZFmZP7eih7sOQo?=
 =?us-ascii?Q?9qpwZQXaBOCumOpJ269MJX6ZVq8tlAty6K32cGn7jO1QkYqvdBgd2tPy6LLv?=
 =?us-ascii?Q?Xi0Ms+/yVNo4MepJ/JkEvVrFMFnVgwG8r9fBD9OFHy0C/YXVXns99JbTPx83?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3e8210-6f11-433a-8c28-08dbe9abb2d1
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 09:33:05.3157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHFPgfTga3niZGM0xJ+aZgzsLNNUNI9OaK/ryzDlHb/8BbrwFEqpLBntHMU5Qkz5XOeCEIIS17Rr34pvO13oRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6592
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Funke <lukas.funke@weidmueller.com>

When there is no driver associated with the phydev, there will be a
nullptr access. The commit checks if the phydev driver is set before
access.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---
 drivers/net/phy/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 1135e63a4a76..4de83e3cab77 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -136,7 +136,7 @@ EXPORT_SYMBOL(phy_print_status);
 static int phy_config_interrupt(struct phy_device *phydev, bool interrupts)
 {
 	phydev->interrupts = interrupts ? 1 : 0;
-	if (phydev->drv->config_intr)
+	if (phydev->drv && phydev->drv->config_intr)
 		return phydev->drv->config_intr(phydev);
 
 	return 0;
-- 
2.30.2

