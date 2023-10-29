Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871CA7DAA99
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 04:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjJ2Dla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 23:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2Dl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 23:41:27 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44019C0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 20:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtEKz87uCHSBRuHC+gsms4EY0GzZ7Z5zT7MwJ1xwr31u0ngt+BWNS23wCJxcEHQqNgAjgdjwkhrrTDhyNnzw8WdfaPC4lh4kMEr0QK/ijICwIAQFP5Aa1cabux34uwQNqhqpdZBpwcYd4CwG1kF7YZlR+gaGS2peqv3O7EdbGNGF5f0ccVsPPl2/bxDNbgotJDeJxpFFnKdpn+Zpw/IphA63BYg4n+mamNpBCW83qR8DbJqDjq87DukfzrwJyz6AJMTy1elhkbJYuulKwcdcDsxG6fd0vpGg5o0FHH5ypTRg6lwp/1jG4rGv3nLqGc+1IHmj4EFu7StH8XGBZF0Fag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ExxpjrZqr9AEf2SuDcZDpjC8ld+uOPhsjJ7Ar+c2nw=;
 b=H0TIFvqqYmrSE0hMGUn6jHsl8cRsQVzbFI640ygyWrQlhmW0xxl+RKGi0e2gPYHSs2zVm2p+ORtlpAmYkiCkA+tJkS5iSwp4HXOMe2SHmTJz7CktMvZeW+gFxNl6jrp1iKQh+aYOsmztX8YaWjxfZDQyg1aL2CJIuOcZ/BxAsiNTn1JPUCm2INpvQKB+A68500QKL0XD9lduIceMOZv4PH9D9MwtuUooAWSGZIgIyzImGv+oYqcnR37D3Gnss7WthE2+7FfQjZS3LvQ1HRW+DYJPSvO4rHqtrWetU8VVag8gpDOkHVQ6hxa8gPAs4wdn+SwXXhCM1BEMNr/QkaDlzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ExxpjrZqr9AEf2SuDcZDpjC8ld+uOPhsjJ7Ar+c2nw=;
 b=UgHQU45AiG4S0GbU41Zz3ktZO2r+iNYQCZfqkYowwZkfD8sXM2UmePC97ofjGk/4hh9h9LYOuREdaj2+RuRKj8Un0F41Mus23OWnzTeusJ5/XgRRhWnPk1LAJ7oTP8xnDxtZyhfje3unznvYFrY8Q6phqPq1o4dwe6X3ss4XGO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.14; Sun, 29 Oct
 2023 03:41:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4%4]) with mapi id 15.20.6933.011; Sun, 29 Oct 2023
 03:41:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     m.felsch@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] soc: imx8mp: support 128 bits UID
Date:   Sun, 29 Oct 2023 11:45:47 +0800
Message-Id: <20231029034547.3039893-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c140fb-b1ac-43d2-35e5-08dbd830e8c7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIjVYKzyJ8p5N4INM8DqQsaOwo2HH5cQBgqPR1z11TjqnqIqFC2aUvHXZw+x1rRIJ92t0zEL4TdF+Qr6ZDJ+isUPNFlxh7++rYNhJoArRc8Zf3XB9kx9RWzY+m/lzGkJIhm2WXMMWOA4Sthr0qEWECdcCjj5kbsWtkrobZ4F5nkCSuG8vZ14W664ZBSMSNys/cDWhcghMxt1UNsOtcwjB4+SBvo6dPnS0V5y9N4QtKNhMeQdrO5N4GWsrRvloW7THDsoVUfBE2oFgJtqErh5ryEbUjvV2mUonmGfmSunAIXyCwRdp1QQ6kHrxu1KhproWgui6n3pbOfiO87ptFuvqdBw9FrYZjSfiud0v8nLkkdO/+O6utWo4FClNFk05nlO9Y6fJ8acBVjh1/nex0plGBB6Dk2YkCLT04hnQSThSeHlP5BSvFihYQDov/552RrVQbHyk96lVVq4q2OCqif/gXTHz2CuwUURLx4mPgRV5YEC0P9oblokixIbxtJo7MW4qYmZRqV7FK9kVfCzCFtOiX2eosAa2v9vNBpSA3uBx0uy2Fqi5IYeqg57kfcf5yZQNF55ni8P0UFsTZljPEmn73T8tWuZ9FLJIjcpwTq0mU+aG16fieWiCfZ2dd82QjidiQb+75GETLlzB3vDTWMz5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(316002)(66556008)(66476007)(38100700002)(6666004)(52116002)(6506007)(478600001)(6486002)(83380400001)(66946007)(2616005)(6512007)(26005)(1076003)(5660300002)(41300700001)(38350700005)(4326008)(8936002)(8676002)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EjC6lWgzEoMQG3NszKn7mGez11iMDJV0NxlxSxzKjBqZi86ZBGDCY7IEIkNZ?=
 =?us-ascii?Q?hQft4eVbfSMRLruWzL+LeKkLxDjsHBB15/9m2YOOA08ZorDJ8pyUtj+2xrws?=
 =?us-ascii?Q?AItjcce1vXFADrOEuJUh6YXMlMQtBk5KFIViYHF2clsmpXQ0kKCIWwcMjHyy?=
 =?us-ascii?Q?rh5pwE/2BEtn8D6wnReSFT9bTe9Ltb7QC8Yk1Mtsd7Vaj0v1RvEFgXGfrohQ?=
 =?us-ascii?Q?Fw3ievgJ/txAo4E8xlbJiZOJcOSE1hHLhf2RWbjJ93mGETXBz1l74f9BmvpE?=
 =?us-ascii?Q?9GyOlebASRhMbsdW6SgsSpP4bZ3nhrV9LTyBS88MIORzJQ6sHdG0Y7yaurkz?=
 =?us-ascii?Q?H5AmxVM5aKqq/P6VWJ0/fKQ0uX/4Ll+CIInaoYzXxEZbOjMGFIe3mGgn2Bj1?=
 =?us-ascii?Q?o8+dzjk7ufPi4VitEAq7/odRGUVWTA9s40vcxpdP4XnZiwVmmyRxWcVBN45M?=
 =?us-ascii?Q?iQDaezgOsgoxgxQEXGwq12N5KM05jBfRYJ1vh0LdSpZK2bDRS8Pw8DUHBDJs?=
 =?us-ascii?Q?4ci5CJJcV8rFEXr6CSKbe78IQRgi3mJvEXZreJ9eglmXsqWnOkcLH/uvkv50?=
 =?us-ascii?Q?1f7W5DCuVfRJOs6qZpfGqjcpWJUJ1Ay/zGUWZ9G8DaIJGiL9v9g74O3MRKRh?=
 =?us-ascii?Q?u7QouD9kaSXkhXf+HmE0GFFay26mrspFJwqRBBUvdp/jyVh1/dIt4zgtWc6i?=
 =?us-ascii?Q?ItSDB/4UFBvpdwVnG3r7Lio0Qq64AEN1w1tO1iQYxq3zzmbD6RwDzIQvEq1v?=
 =?us-ascii?Q?JoXkJNEEjOb8gtvYxGUuXVK/VddmmbXOpfk9qy7H6SnYBioSohEeVaTVYwHZ?=
 =?us-ascii?Q?tMEiI7LhaeUfoSaE+HqQjN2aaMlsmv2u+9XuMcieNRn34epjzJGTJJukI5WF?=
 =?us-ascii?Q?chgr2LvHw3KfvvpShWfarJ8ewM+3Y0UT939ojrksF7isq3pZCNa+WqHJvAGp?=
 =?us-ascii?Q?RzuWbc/A+NRFoc6duuhbZfhdu42qpmV1LhElasZN/oLD3pHm1c/GW3ejNSV6?=
 =?us-ascii?Q?sDejWXPtBrDckIKZsvkTXkxVwZVyTkr3gshwRSlDwFqe1CT0XAKwGwYNr6gH?=
 =?us-ascii?Q?bLxl4mionma2/Itdz9hfHUiJKGsLKTJSkyZEOyOH3nsLdKBokYRnM/ielvjM?=
 =?us-ascii?Q?WNvGTzOiFn1UTgaButnO7yVZ3DwH4gKTtuZ+QsMCUf6Rb2ZXZ8mJjv6MEkgy?=
 =?us-ascii?Q?MR39OxAT5k8MHLM9YJVfKE9/w3vzHOYNQ8eROyDdzqaod9mAbPy3zYL+2649?=
 =?us-ascii?Q?MBvy3p9iO0cJiY/XCeiHsn2Jcv35pHSq7HvuzbVWujje9PghO+1YzgFQ6RAO?=
 =?us-ascii?Q?NCsRY62MYcqubKWqYYhQWepoCnyxTfgyXq2qeuQJxb5JXrR9fFBfODl5KnUr?=
 =?us-ascii?Q?aXWe8arxyNbgNWSr0p168IwWpb20Pc85i0hjv1jPDDGIODoSUsgW+A5tbMHJ?=
 =?us-ascii?Q?pfViphsd03LT2ME6fx3neoEbsGutTT2smW85RqfkEGxYCw4+0Q0invNTKZLS?=
 =?us-ascii?Q?v5MfGOd+5VgNEb/UuJ+Laz6RZ1Yybwry2pl0ysXKAH0Nju2TUUQGGlAyzi+M?=
 =?us-ascii?Q?M5wxPXMWw4a22HyrQrRgQtX+oQQM9VPEKoDyDiX/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c140fb-b1ac-43d2-35e5-08dbd830e8c7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2023 03:41:18.2932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aENfaeWRigVnj3WQaDOm8NxfigStHsYEAE1XMIVOR94JbJ6YdxQFPJJiCAWrt7J29WETc4dSUhaVL4Ow5WIRlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8465
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Current driver only supports 64bits UID for i.MX8MP, but
i.MX8MP UID is actually 128bits, the high 64bits is at 0xE00.
So update driver to support it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Address Shawn and Macro's comments

 drivers/soc/imx/soc-imx8m.c | 63 +++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index ec87d9d878f3..6ed7889e1902 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -24,6 +24,7 @@
 #define OCOTP_UID_HIGH			0x420
 
 #define IMX8MP_OCOTP_UID_OFFSET		0x10
+#define IMX8MP_OCOTP_UID_HIGH		0xe00
 
 /* Same as ANADIG_DIGPROG_IMX7D */
 #define ANADIG_DIGPROG_IMX8MM	0x800
@@ -31,9 +32,11 @@
 struct imx8_soc_data {
 	char *name;
 	u32 (*soc_revision)(void);
+	bool uid_128bit;
 };
 
 static u64 soc_uid;
+static u64 soc_uid_h;
 
 #ifdef CONFIG_HAVE_ARM_SMCCC
 static u32 imx8mq_soc_revision_from_atf(void)
@@ -101,8 +104,6 @@ static void __init imx8mm_soc_uid(void)
 	void __iomem *ocotp_base;
 	struct device_node *np;
 	struct clk *clk;
-	u32 offset = of_machine_is_compatible("fsl,imx8mp") ?
-		     IMX8MP_OCOTP_UID_OFFSET : 0;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
 	if (!np)
@@ -118,12 +119,52 @@ static void __init imx8mm_soc_uid(void)
 
 	clk_prepare_enable(clk);
 
-	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + offset);
+	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
 	soc_uid <<= 32;
-	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
+	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
 
 	clk_disable_unprepare(clk);
 	clk_put(clk);
+
+	iounmap(ocotp_base);
+	of_node_put(np);
+}
+
+static void __init imx8mp_soc_uid(void)
+{
+	void __iomem *ocotp_base;
+	struct device_node *np;
+	struct clk *clk;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-ocotp");
+	if (!np)
+		return;
+
+	ocotp_base = of_iomap(np, 0);
+	if (!ocotp_base) {
+		WARN_ON(!ocotp_base);
+		return;
+	}
+
+	clk = of_clk_get_by_name(np, NULL);
+	if (IS_ERR(clk)) {
+		WARN_ON(IS_ERR(clk));
+		return;
+	}
+
+	clk_prepare_enable(clk);
+
+	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + IMX8MP_OCOTP_UID_OFFSET);
+	soc_uid <<= 32;
+	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + IMX8MP_OCOTP_UID_OFFSET);
+
+	soc_uid_h = readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_HIGH + 0x10);
+	soc_uid_h <<= 32;
+	soc_uid_h |= readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_HIGH);
+
+	clk_disable_unprepare(clk);
+	clk_put(clk);
+
 	iounmap(ocotp_base);
 	of_node_put(np);
 }
@@ -146,7 +187,11 @@ static u32 __init imx8mm_soc_revision(void)
 	iounmap(anatop_base);
 	of_node_put(np);
 
-	imx8mm_soc_uid();
+
+	if (of_machine_is_compatible("fsl,imx8mp"))
+		imx8mp_soc_uid();
+	else
+		imx8mm_soc_uid();
 
 	return rev;
 }
@@ -169,6 +214,7 @@ static const struct imx8_soc_data imx8mn_soc_data = {
 static const struct imx8_soc_data imx8mp_soc_data = {
 	.name = "i.MX8MP",
 	.soc_revision = imx8mm_soc_revision,
+	.uid_128bit = true,
 };
 
 static __maybe_unused const struct of_device_id imx8_soc_match[] = {
@@ -222,7 +268,12 @@ static int __init imx8_soc_init(void)
 		goto free_soc;
 	}
 
-	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
+	if (data->uid_128bit)
+		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX%016llX",
+							soc_uid_h, soc_uid);
+	else
+		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
+
 	if (!soc_dev_attr->serial_number) {
 		ret = -ENOMEM;
 		goto free_rev;
-- 
2.37.1

