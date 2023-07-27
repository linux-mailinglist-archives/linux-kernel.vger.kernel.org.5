Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A1D764433
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjG0DPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjG0DPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:15:47 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2045.outbound.protection.outlook.com [40.107.104.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F551FC0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 20:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTj23D+4jE81gU53wIj71Zccy3ygWsEFOpzjMmETcQ/MCnFwdny5TnZB6mMn0JD4fUPKnYz8hLsDPhnVDeRSwS6qfajxbRMirD6+OerOZ6R9bVbQMXCsAwg3QBPkDez/JiQapV5A6oRfrdoCxjBRqyaSfJGLjDzCP/1if4bEutZ84unWHHgxPqLzTg5TsLXNr9eJYognWvef6kzhjySmSbA/2rSbO6aM70/NBf56xaE7uM5g34hpX3ZAfukLPvPZyyw7wd+Va7n90obhCrVR98x8X0egpoDdC0EOxqtQkDuY11YFpxEMDGeeBl1VARdJ9cWl0+cm5K/K4QkW6ncR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/u7z16T/fN4Bk2hM/Am7krksx/eT0ABj8vAbSv508XE=;
 b=MaXSBwu0SaAVOT2St+a/wFRTYZI7yRAemdlff7IPTbeB4kHduzEjaegkJvyXJUXfVqGH2sC8r9jxwhjpm0T7qjk7CHiwFcfOOVHsLFKH0vIUh5CmUBNQHh1tAjbJb6fxOSGzkxwzEHZV0A3YGmSS8wbB4ZcHuIVTYAWNngZXskFXQnpvhsH5AmTgU1a6pibSadZizLNUC2klawzyjF5Jm/OLRt6hjErYjC5CE+7CB5Md8bJMp2cCPa5Xq8K/j1fX8D6jDYTaCSB9tC2yget9dSifQwZ+ICA79xEdyTToXKTylba3RzCVGEhFaBsqj+0MYswiyVajR6aHYQnsDH8GSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/u7z16T/fN4Bk2hM/Am7krksx/eT0ABj8vAbSv508XE=;
 b=ILE2MPqOqm5/Wvt5lx34k3V7InaZZKIh7RAwLZKn6PAwcOW/e3T3Q/CaWZb//Y3iWHn8y9GEDpUKlvEdtxYTuhdCbxPRffaKLzoJ9KIiHJKekLHwzb3O588Fa478j+EkN2XBFgRUFdGsvxFiUpu8spgtJYb1eHVgkiQ/lNT5+qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by AS4PR04MB9411.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 03:15:42 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::cda8:5cad:29b6:3c96]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::cda8:5cad:29b6:3c96%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 03:15:42 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH 3/3] ASoC: fsl_micfil: Use SET_SYSTEM_SLEEP_PM_OPS to simplify PM
Date:   Thu, 27 Jul 2023 11:14:59 +0800
Message-Id: <20230727031459.571559-4-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727031459.571559-1-chancel.liu@nxp.com>
References: <20230727031459.571559-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0126.apcprd03.prod.outlook.com
 (2603:1096:4:91::30) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|AS4PR04MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c75c314-84d6-4894-d8ee-08db8e4fc2a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OxkcIknpUkSkHLs8bEPRGKn5zwrJ+WhPCmPYJnhwILIJ3j+kDV0gxAPtzTgWe7ry7vq+modBOKlcEbD8c2hkYvoOoXM7E8GnAx7vXHsrpOSTyC3p+Ab/AKNyJ748ABQeNnaDuw66GGGg3SWwFWjOJ3/jE1nBfRnytIA50/gl+wqbHx3qKuG94xeDMf0XUPGyRH2okpKuqGa3rQuTIk++w8a8O1g5sDJwDEKbuM7i19gljsPA96rBmrvuYlVRcnuX6MWOw9cIaunbGJwK91KgacLS+MRrNXKaiWErjMludI52bb5tl2fag97aSy9jftJSVvBgy3ZpcM2X21VngXSi5Gzvv34wgUICPruse/uPmb9rFAS/LV+zHeS8/hyDToOXLyxeNGgkvrRaMfMmHaku1+AxchI1ACWVbI3bL5F9mFyl+JVS/aThRkX+rpk0U+s8v9cPVv7EAtwxKRHHhbLjr01flvb5tvA/W0mdyii5FMH2W4P9fqAAbq/y7bEazmXSF/qr5xBTOLypW+HwzdL4qPGnkICLZIXWRjcPLPm67zJ6Qv8JkDhs8jhq3uscclzlmczrOuGuoI1i/3qZ/V9LASHTbwz27k9OJ0oss9SrKQEdAebCpdZJDjtoTv6/c/t+Ske65jcPxcj2rtvcxHykiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199021)(36756003)(86362001)(921005)(52116002)(2906002)(478600001)(38100700002)(38350700002)(186003)(26005)(1076003)(2616005)(6506007)(41300700001)(7416002)(44832011)(8676002)(6666004)(6512007)(5660300002)(6486002)(66556008)(66946007)(83380400001)(66476007)(4326008)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iNbWqEIPRZKNxX+VtLK7F3fPKg6iqNriIsctzneYRCs5VSmhXw8ynk3hED6g?=
 =?us-ascii?Q?gha6S36Vx2gOWsSO1oJjlLXfFwhmMhXPJt91eL6dvFhK2sTwHmRxeTyVa7T5?=
 =?us-ascii?Q?DgoTADzoIhY0VaE4sTweabfnWouPkTpS5pDduENdPwGDuVxqGdkDmgsWsQnI?=
 =?us-ascii?Q?44QCC/ce0MDxnvfCJd5SVFbIsjeAr0n6xflXo5BYnG6A/eW1+J/pAcyUq/3E?=
 =?us-ascii?Q?Gys6m7avp2TfBQcqSVOZowtdSX0jJmiy9XWtaCIAEYDqSdKGVjLSyM5ZHOi6?=
 =?us-ascii?Q?hiFhVzVrLHebTxCBroz66wJeHNjN62KsPN5PZYibjzJRvO59oExW0e1pbpv1?=
 =?us-ascii?Q?/EZWCCJ8BlWL7yJ12wYr5u5t18myQl0hM/APC9x8kpW16J9A0rMbx2XkjRAm?=
 =?us-ascii?Q?6mxSqQwPTg/mHn3ynCyWlKiMaxO3Kh3HgVb8AxoCtrNP8w+F2wqLRqMICkTd?=
 =?us-ascii?Q?y0roWRXOwvrEYvoOW3qnZBrQ43BrbKUevg4U2owWgsJERiPmJI1be5sbOIYy?=
 =?us-ascii?Q?kCAB/HAdtvY0eonIJOnygbOzmUgbvPkKneNSOBGCDM7EATn2vlLb5BViTrAp?=
 =?us-ascii?Q?nVfHj6nGKtDBMfILiRwT1wjeCNwqSKH1FH6YYCmsk3eZhXe/JCVWSepXb3U0?=
 =?us-ascii?Q?Pezy411DddTUXjJTPoqAe3RcQw+sY8lXso1w6ijFHIuR/4Parpw80fmMhmuQ?=
 =?us-ascii?Q?y7DSkj5B+nJvAFGDJYiGhcoZ8loXrJOu5AT9EcYBhyeb6zkqFA2r5Cs6voLN?=
 =?us-ascii?Q?5p5gBHlOPWc6g112FyAgI977ACu0EcIsWV62SHO44BTxHxD8oFbogN4+qc82?=
 =?us-ascii?Q?p4WyG6XxgnwCeUlFzNa0hMkHLPnAWb5SJw2cphMasyStr6CAaTIpMLRrcr8L?=
 =?us-ascii?Q?ylBzVUg8MFEDGdKQU1qThn+AHN744/k+QrxFsPaCQV57u8+8FR0n9iVJRReU?=
 =?us-ascii?Q?N3q1VtPfVTX47V3157KDpssQq6Yh0C7cn6LwIcm9U8n5ldzn/eCGwTtomwBd?=
 =?us-ascii?Q?cUFapradF2d9mFz19SZ9Fw56BX3QzQGK6HA+v9/FIQll7W2nJj+WXR9vdXdK?=
 =?us-ascii?Q?rHOHyDo/HNV3T5El/S8sv8ncPEypM8JCcyGYHtVgfA4xmKXjBAyqD8BaxJlA?=
 =?us-ascii?Q?O3scRCk4aElJ94gJsxM2fmlqnBEmllvM05o/RsB+bgqmMuxbs2FuHz7nfnPp?=
 =?us-ascii?Q?Xtai+kvT5rsiwR4Ewj4R3kUv2wqlgo88rTk9xgb2x0uOZYUk8zCAeF/pRD5k?=
 =?us-ascii?Q?Hd/4WRtHosNiQ35Q+gnN5wxqrtBRa3ZOmEe1rZLHFGJBVJaYoEEWtTMZFtCT?=
 =?us-ascii?Q?eLRZIMgVhinF/Noi8xWu68ifuMMTcJsmpSGF33k5jmRgdHe8sotTufA+QGYw?=
 =?us-ascii?Q?StFAiD5GiG9bgh4JKz+qFyNdNjYR3ygu3GQKXqokZp2f546K9828VznpUVV9?=
 =?us-ascii?Q?x3kPMigd/NyR23K4rYgmKYeCcXyJ1CB6JxyX7xJGIQqxHszvr8nD0TUYBybb?=
 =?us-ascii?Q?BHpM82UVVMzcy1z6WDsTKGSrsyv+wfIZC+yuthjlkHn7lqVgmoszBzQyXY29?=
 =?us-ascii?Q?+pQQqxr8Pi9+ucUxymjMac5j3i/8U1sY/ZjY2HMW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c75c314-84d6-4894-d8ee-08db8e4fc2a8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 03:15:42.5418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdrtevroYJPhgaKAFEVFRT/YpCs6QNjqEKiEyllnZVW4knh4qW16EDsu1i+Iu0+K0TMu2584htOp9aoJ9G8rMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9411
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SET_SYSTEM_SLEEP_PM_OPS to simplify suspend and resume function.
fsl_micfil_suspend() and fsl_micfil_resume() can be deleted.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 46eda6e8c4b6..6f5f8a886764 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -1297,26 +1297,12 @@ static int fsl_micfil_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused fsl_micfil_suspend(struct device *dev)
-{
-	pm_runtime_force_suspend(dev);
-
-	return 0;
-}
-
-static int __maybe_unused fsl_micfil_resume(struct device *dev)
-{
-	pm_runtime_force_resume(dev);
-
-	return 0;
-}
-
 static const struct dev_pm_ops fsl_micfil_pm_ops = {
 	SET_RUNTIME_PM_OPS(fsl_micfil_runtime_suspend,
 			   fsl_micfil_runtime_resume,
 			   NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(fsl_micfil_suspend,
-				fsl_micfil_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 static struct platform_driver fsl_micfil_driver = {
-- 
2.25.1

