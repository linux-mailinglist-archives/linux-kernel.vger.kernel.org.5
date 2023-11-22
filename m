Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5427F41A2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjKVJ3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjKVJ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:29:45 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2115.outbound.protection.outlook.com [40.107.212.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FD69D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:29:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8TJsLuph98IcU3hPomrl9oeoPm58jX5q7aty1zWSj5cqt4lhkSGsQO/vFHWVWDXw7Ayluips3y86r+SU9fNb/b8lJTstSI3X+yOkjKQHbSAhJKQMudb/zp7y+MYUrX2CxKwkO8/G3HuD2r4Ec07vld1Jp6WBYHWmEMKwMge1M2iwWv8TyPlOc7Sf4Wvf8cCDKzmNb7yu2LPCxYQ6ekH04nx0uS7JKHxf2uATvSnbm6Qizt2HQ/hURW1hYXyP0QwL5j6aAEn/y7YvUWozxShfQphtMHUvL/2I8GecWJkCDL9nkzvEQhPP8r4LQXgyd/JT1CWIpvDeSs++rBdF6fDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+DWlggQhCfDusBUkGypzmxAR/FoqzJEi9ZprSfUN0I=;
 b=Le1RtiOAQIbPpiZE+wG6UHEhueHts9mGg6xgGiHsHuJiuEglJ6eCqQy8gSwna7LQrsSF3NhgEwyr8fikwDfphVmpaRPDBjpOTy28ppWITIvTVS5KKLzw+9+fMmQ7YGiYtkemEugo113V0IMDHU9X7cRddcLMIPvndbTi+u30DnkwVd0dk5UDVqzy2ZJ11Qvnp7gAAbyzmR7h1t5miw6wpP83IHC4ScJqN8FVQhni2YKKEcxftqg1VNGQKSxpCzgWXh42313GABvIwKrU2Vg102hUhGg7l5Ht5s1FylC6VbU51Ru/qty8kYJWwj1xTGvm2J/S7eT0B12UCQQGl55roQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+DWlggQhCfDusBUkGypzmxAR/FoqzJEi9ZprSfUN0I=;
 b=i36imAqF9Jc6ZepsxaSZxOLPdeOmXwh5ZsHqg+M6ikZTdzi7UQ7SiLzBWfO4DKasOfe7JIqCspmXVUWkU3F9TJVGBVdeGrpMkw32g9FE6i7I2DGeZZ7Pkt/O/SVcyvFv5taCyWJJvA9yXKVI52YooqPwZ6T1Z4GuO3l+U4qzwp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 CO1PR01MB6760.prod.exchangelabs.com (2603:10b6:303:f2::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.18; Wed, 22 Nov 2023 09:29:39 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 09:29:39 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     catalin.marinas@arm.com
Cc:     will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        robh@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
        patches@amperecomputing.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH 1/4] extable: add __sort_main_extable
Date:   Wed, 22 Nov 2023 17:28:52 +0800
Message-Id: <20231122092855.4440-2-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231122092855.4440-1-shijie@os.amperecomputing.com>
References: <20231122092855.4440-1-shijie@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:610:e5::12) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|CO1PR01MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 4328448c-3e67-4d2e-65f5-08dbeb3d8ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXVusi7mRcgn1LjazqDbgUtZJpzUm7XH0suVrfiIuxoewpf5UO02ntrPTec4uZYGom57iDIlu7b/KwyBRf+IcD95jGXD+RGM5PLpIkat6O9ZMCfJ47uJT2h9Xul5GTP1sgwQKKqybuRNBCmMIKJkp89l5NE06U79wjVzzeHfufpmCn+lJU0dhKFjhNLbFK3RZvfRID5nZ/f2JPdt8t4OQovv/tAfHP9SXSO0613sGNfGpv25KfmZcvO9oMi0WBkEIqilBRH6MpanDXY3zUZ6NPWXgdD5stHghQD11kjN9Fp0lf5fEtQ8A042P1z8diFS8BgVUtDFgZNMD727ZIWCfuWz006oC+sJCTGjEGElWvVlm9Jq1FgixJTI008DurhPr5Izqpwk42G5e69jB7983csbAgFmA9sZbI9AlTcG3ni6Wz5qgY8wcNb3EhZt1Kdxe8sbhyLNWiS4gxDN90LDZ+cRemctdcZg4JEE29PYney4vAMpYz2K6Aqz2Rt9mN8QHOoe6HRfF57PQsr+LYLz2N4dNyKKwzu/ogYvIMTUJ5zP4YRlTPVPno1am9pEUXhsgOdHxGBcI1mDcrXkrp+XDiw8iCB5xlJKj51OazM93tcaXIk0IGXeeqNSLIzOI3Hr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(2906002)(86362001)(7416002)(5660300002)(38350700005)(6512007)(2616005)(1076003)(26005)(478600001)(83380400001)(6486002)(107886003)(6506007)(52116002)(6666004)(38100700002)(66946007)(316002)(4326008)(8676002)(66556008)(8936002)(6916009)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1RzdCUcNKvGfBTKrBp3ZcMNl4wK3wN/7GIMULMm5NbO5JORCcQ6te1WUy6KI?=
 =?us-ascii?Q?kCEUFYGMpTa3Gup7JWRBvrsgj5bnx1zIdoROZEVxupD7W54y5X721nNp9dCz?=
 =?us-ascii?Q?An9Ye968Dt8ZyfiLYwO+EfmN7O5NHNuSHB04qlk62fWxVRvbHQLXDo02xbgv?=
 =?us-ascii?Q?EbQPRD0S1PLNZ7DIWKMElrX+GPMofr0N1graSLBkp2VJgUS2lyCX5cjyhvVa?=
 =?us-ascii?Q?ZIqI+3sISLJGD2SkB61J7eX06cKvCBaUXkEIWOEZQkXW/DBi/uILBsHPOUgS?=
 =?us-ascii?Q?YQYaYGVpt5ZKCdsfiKSVWoLyIflNY7iGDs9yLBqy7sjAIevTJ2wfAi+I3wPT?=
 =?us-ascii?Q?BmhoO3qeBCQZc2q0vUNuhlFYFFhM7b/72RqRlr82hauhnjwVY0/4mOGWJLaR?=
 =?us-ascii?Q?/ocJg+G2IO24JJSnYxQ1WxRprbRTFtiDgT6byBUN4WKSoV6oRWiR2ur/vKNx?=
 =?us-ascii?Q?WfWL+BK44MG6IA1Ke6zkb7t8S1UTZdvuaHL6rGvIBgvGH4Y85+AMSa5HqAX/?=
 =?us-ascii?Q?9a0rQPERS7AZysZ/MUib6l92VKNBLmUEkF8rTCPCavqWSLarcd+FTuSjlSsZ?=
 =?us-ascii?Q?b0rejPKQSKjX53g+0P3NKXV/ArhD16xvS44Q/lH5VzkIAdzhsRKvDWAHJgSc?=
 =?us-ascii?Q?YmTFMyhBEi/wajxnNWt/6UnjEIS5m0trrgtqicc1XtwFFqQHO7BbaqwyyraB?=
 =?us-ascii?Q?ttnc2sE7yci+Wrr6nvroXas5RSCBAde0URPAXJZk6TLQbEbCS8dmh+zEllQB?=
 =?us-ascii?Q?ABImfIT52YOW7p/FeN2lznVa9PK6MmFlKVaQzJZ3UOEFV5a9r8+ZGVnduYxP?=
 =?us-ascii?Q?yw061gPVGHMfQE2nBf9a2X3gQGz4jKTDNPBxY16+gA7VdJKCTch5RE8a2MWS?=
 =?us-ascii?Q?1yhXbFK9LyW+YRF8WVOSr/zTr697aQx51aHjekTZSpNvmsBkc/PS9qN1N4Zf?=
 =?us-ascii?Q?tb1JIssKmQ/wdUwmdEeYV5QcBuwPsQo1n2qDkJedLnarAF+VxdXuMCiuaMOu?=
 =?us-ascii?Q?2diqHPh22ZOYDwpS9CaLgFRBcwZAd7ZYXaUXmYOU02ZQ0OM4JXHdAKrg39yd?=
 =?us-ascii?Q?y4GX7wf6IHEXS9rsuLEIfXE5EPnPMNv0MeJd+7D/WOXrByFnV8HKE+eKUTv3?=
 =?us-ascii?Q?LADa5WRV5erm567e+V4U4bu2o0v/H0AX7Ucw5nAfxUEanKFIKIRtbLyNyCSr?=
 =?us-ascii?Q?BGUhDkjeJbzcWJ9Ohd3TbNFmGBWFD0NZOfqLyvmwy6k1Nedne1HoKMA0zXtJ?=
 =?us-ascii?Q?VBk2bT7qloxENkyrdCRWj2EuaeaoML9hCKkByqDzabWyeDCP/fZDfYW06gW9?=
 =?us-ascii?Q?QpYAhIgWLnFpx2LIlC2mRL3nNzxeqzu2T18sa0oV/qoBLoOWaJ7yEMu5Pieb?=
 =?us-ascii?Q?qS27bxKq++e/zuXdmeHJwrcfEUZEdDAC2JCMTf1cmsFIuWfldJAawt8swsew?=
 =?us-ascii?Q?AZqgwYed8SNVYTbf6U36i15oi66reTUBlkmY3+fXYO5lnNIGYPhVLp9m308t?=
 =?us-ascii?Q?sZ5p96iYoF9rhIHir9xuPDisoLQCTh20JC33n0HBDsh8eV2Q27scazuHSMjd?=
 =?us-ascii?Q?YoPGhPwSs+99+71JHjhM9xvR45XExwDbPjji4CCyCLTbqSUqu/fA+FJMtn5n?=
 =?us-ascii?Q?X3FQHNq8htA89jyRhDaoWr8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4328448c-3e67-4d2e-65f5-08dbeb3d8ccc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:29:39.3289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVqP2sfgyoJ+rHBDZmyM0sHtwgQoqZNVe6RPXNnmlVy5THcXWkK89pnAlVC8y7cWZ8MRxbTMSfaMKMhkmTSrFjsYOaQuXTOVGKYf/GjnCF9gpFg/U28sVygqdaP/TeJ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6760
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AmpereOne chip(arm64) may change the kernel exception table at
boot time, so it needs to sort the kernel extable table during
the kernel boot.

Introduce __sort_main_extable which is used to sort the kernel
exception table.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 include/linux/extable.h | 2 ++
 kernel/extable.c        | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/extable.h b/include/linux/extable.h
index 4ab9e78f313b..ef70ec3633b0 100644
--- a/include/linux/extable.h
+++ b/include/linux/extable.h
@@ -15,6 +15,8 @@ search_extable(const struct exception_table_entry *base,
 void sort_extable(struct exception_table_entry *start,
 		  struct exception_table_entry *finish);
 void sort_main_extable(void);
+void __sort_main_extable(void);
+
 void trim_init_extable(struct module *m);
 
 /* Given an address, look for it in the exception tables */
diff --git a/kernel/extable.c b/kernel/extable.c
index 71f482581cab..0fbe0ccb1c3a 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -32,13 +32,19 @@ extern struct exception_table_entry __stop___ex_table[];
 /* Cleared by build time tools if the table is already sorted. */
 u32 __initdata __visible main_extable_sort_needed = 1;
 
+void __sort_main_extable(void)
+{
+	if (&__stop___ex_table > &__start___ex_table)
+		sort_extable(__start___ex_table, __stop___ex_table);
+}
+
 /* Sort the kernel's built-in exception table */
 void __init sort_main_extable(void)
 {
 	if (main_extable_sort_needed &&
 	    &__stop___ex_table > &__start___ex_table) {
 		pr_notice("Sorting __ex_table...\n");
-		sort_extable(__start___ex_table, __stop___ex_table);
+		__sort_main_extable();
 	}
 }
 
-- 
2.40.1

