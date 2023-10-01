Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071DE7B453D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 06:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbjJAEeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 00:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjJAEeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 00:34:17 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2068.outbound.protection.outlook.com [40.107.6.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756C6D3;
        Sat, 30 Sep 2023 21:34:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=If52zqE08ntfTPzD2AhZDPdbl2l40W4v0OlG0sLjWqPYif8hlJykRVY7L/h6wrn7uYRlXIIyFtMP8jn6fn7DVnDJ36gpQ0zco7BZ0HA4L9XFiEAw6E5zLzvmXj0RQJj2afUvs2lADglliiXE4x8p4kHyRpmlU+xr5r4gO60clf9lh+HUCYi7pa/TglLSsF0r+Pl8/p4XTPZexMQ+9TM71lIhGL3iZgBYAer4+TFL2UCKSV4NbJbDB6Cm0VPmzkv1RqlohfvHTRnr5eAtEtpOVzqmmhJobn2vZiUklA5HVJPRtHA7wgsFNxak7Nd+0JOmPHtYmVze1uYbC92XBon1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ix9KVBYwnHweBcpYqs+IfJUUWkaBBJmN8RTU5DV6tWM=;
 b=MldFxaelk99wVIII0BTGpTJMlUfEvx6O7wcrkyHSAFxY/KzCY5vDiIS+g647FSpKZzdpwSvvVi90+VnhFAf/l3nwEPXHTXVKJ9U3eMxB7immfeWARyWp0deD2uHoO4h1gaZlBNFjnu+pXOwl0jUTuSMsFiB8zgg6Ji675DUrxF4rVKPBHs8JOmJXZ4qHvdbG9IhROoUCvAAI8ywCobXWLRtcaIF1SlffQkfm/PziX8wv3pZ/wadnEBOZtl0SAf56VPjfZrA0pOf1O4K1aKbTHANBU8izT6TTF1DwqW4qCRAF/pRFwC+wFTOuZYV0j4oTLLdKY57KUb7uzST0ochMZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix9KVBYwnHweBcpYqs+IfJUUWkaBBJmN8RTU5DV6tWM=;
 b=bBfM6wTqiUt6LeYbKT85rvYNeERn8LM7p4v8vwOVWBBhdGxB4hKBGJaDbJNHK7B1iPsG9HGnVmEIR34fk6INoaNzkGR6jg389b99+Q2pr2BDgFDWCQE+4ZEL7vyjFPzTHbUXuaU6+8bj6Q6Ir4zZlZ9yQjXIg/dQLsdKauO1aKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8335.eurprd04.prod.outlook.com (2603:10a6:102:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sun, 1 Oct
 2023 04:34:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 04:34:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sun, 01 Oct 2023 12:38:44 +0800
Subject: [PATCH v3 2/2] clk: scmi: add set/get_parent support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-scmi-clock-v2-v3-2-898bd92d8939@nxp.com>
References: <20231001-scmi-clock-v2-v3-0-898bd92d8939@nxp.com>
In-Reply-To: <20231001-scmi-clock-v2-v3-0-898bd92d8939@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696135135; l=3380;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=GEoaMPEKFPMe5D3pfktJgZun60qYQRSSGhLzuwR/Q7I=;
 b=hXGJDAHx2IW00hotreyGGPQS2C2hOWCV+M/HezUHfTrbBij/tPhOjKhYm0jfWz0D4OMOTwe2Y
 h29ULmzQ0E9Byp5888THqNAq0PbbIrZ/xYLRinCSDkpZLl4HVe6umwC
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: df3154fc-44ec-4322-3735-08dbc237a90e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dgi7+pJcMI61ISw94UKUA6PP7egK2QBjpUqY5YaMtC87Tl3YRZdxhMCjzxSykT0wB5msBr2G0VvZx+RqmQYohKYy6JQ+5NNljYQaTTXOh9qKrmp8+cbsJKowz+7cVfUn6O6HLVWsIbYWzOixT1p0x7V6wooPoLc9Yl1uzp1gJaRZft1nZuDqzMZ5R7CKHaf7qFuah8RZlfGx/CU+gQpRGMLJoxwvFQU/OoJu+WJs5PCcd92wjb7L2kfjqoDpAe62shgqHykvZKDMyQ5ZKDsOFLmDYtTaCZfvMqjGqmh0nMVmaQCAoovodKwt/VwHb68cFrORzGAz4pWt8IH7tHR7EZVaGPJ0I1Ss6MTzockj5j2JVjzBCxubVDhyPUnBvoHDTGjymyPwwWzVpiaKdSydc9dwmF1zivpdxssvwgySDxk5Qqxn/0HUx1z4BSJL4tYirAA5T4bSl4dBT7XzzvqgUUcRfr5tthM1fY3XVLgEsRVXEk9mb/+mPwp+4T2hzLPQqeJj2FHVDKF7sTRCqYXcz9hbSlCmTfc0s5XMzE06RYahkXHneBMM4q3cEIeHdbdyZi3Uc/rM8s/iGE54ldIOU1+WlWZ4LGMiRXWGw5U/PxEmhmA26TyeYN7p+4un87wk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(26005)(38100700002)(86362001)(38350700002)(36756003)(83380400001)(316002)(4326008)(8936002)(8676002)(5660300002)(41300700001)(66476007)(66556008)(66946007)(110136005)(2906002)(6506007)(6666004)(52116002)(9686003)(6512007)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vkp0ZVdxTXc3YzNMSjJjd3Fad3ZncUIvbDNTSEFaaFBvQ2h5N1hQQ2xySUYx?=
 =?utf-8?B?UzdKbnJaQnVseStHZXN1QzRlUG9UOE9mWVZVYTNvczFWTklKbDRJNGFmbncz?=
 =?utf-8?B?SkZNbjVCZ0QvdXU4K0tqWTF0cXUwdGxnWGVjNElPUG5mMEV3QUd4WEg5SDhm?=
 =?utf-8?B?cjV3cFoyTWk2bFhlZm9GbWZzUGFCSDRHV2pqNVpNRmZKVGptLzMwVmtrZkVp?=
 =?utf-8?B?Mi9BYzgrZWMxWVBqOEI3UXNMQkp4YmFpQWoyZXA4amZnRThWRzFGTjRhL3k2?=
 =?utf-8?B?L0ZaRDVoMlc4Tlg0ZTBWWEx0M2hRbURIcDRmS1FHQXdJbE5GSU9kV1FQaVJT?=
 =?utf-8?B?cmw2L3ptK2pkZ3VFMWk5cnorZGpxSEw4TVZtb2hsUDBLdkFzR3hnKzQwaUQx?=
 =?utf-8?B?ektGcVR1bU5RQnZlWGxldmxpZlVoU2daTk1Ob0FoMFkyOHNybktHeDFvcTk1?=
 =?utf-8?B?eUJTSmxYV0I1SVNDRlVha1p3OEZlRUtCSElSTUtGa3JlV3FOcGxhZm5ZVDRv?=
 =?utf-8?B?TERuYllsZHFrMWZnWS9rNFRWVHFETnU3NnBFSkgreWphUzVuZnlJY3FoYXQx?=
 =?utf-8?B?bnVEdzkyRnFZQTBSWklSa0crQlMrbWZUMEM2QXFDSEd0bjZSdnJVTThxdjBy?=
 =?utf-8?B?WE1BVHExcFgvTWFiVWZmeHZPLzVNZVpnTXZvMEtQU294eGRXMHdkYWpFdVNV?=
 =?utf-8?B?WGFSMlpxVlFpQnEybEd1bnJvUVh3OC9USmFicnJMVE1Pc2tlVmxPNzZ6elFJ?=
 =?utf-8?B?NmFpQkNoNHVGYUhzQ2NhcmVmMzVuci9QUnkyWllPSWplNEROYlVQbUYyUStz?=
 =?utf-8?B?Uk9LU3NhSmFHYWp1V0tud1cva2hTbXNGSnR4Uml4M3E1dlZmeUZnRVFxYmMx?=
 =?utf-8?B?T3hvd0toOEl3WHE5anVkdFNGb3RDZldwQnp4Tzd4VUt1K2oxMDJSeEtLNXRX?=
 =?utf-8?B?Q3A1TU5sY0pJb1dib3g2UGRvNndNOTQ1Y0Yvb3NMUDRoQ29iS3B1SjBNaDJQ?=
 =?utf-8?B?NjBYVk5uYnN3b1pOZDRIdC9wL3J5NUJOMzRCV3YzRmQvWEM1MmMzT0Myd2hD?=
 =?utf-8?B?c09KVVlsZ3NJNCtUMk5mWUlxZzRIQWZvb2EzMjhOcjY0T1BDUjVSdlVKSWhl?=
 =?utf-8?B?emNTN3R0WHFtcnN4R1UzZ0dmSjRZcy96N2s5eFpOaTVHaENBMUdrdlBBVTRD?=
 =?utf-8?B?RkZmZVZERmdvNVA4d0U2T0tJYms1azd5UDVRTmREV3dEV2NjM2VYZW5FKzBO?=
 =?utf-8?B?Sisra1ppVFNvRVJ2S0YyRWU3MlRXM0d1dys5Lzcwd3ZRQmF5Q3hSQTJPRi9l?=
 =?utf-8?B?TkpRcjJHUFJTSzdUa2l5a3BnVWJHL1U2RXBJSTdhVU90YkVwcFNpU3FJZ2sz?=
 =?utf-8?B?RThvcDFmRXRyNUZ3b0ZoS21EQ3dTd0llRUU4Zm5RanJsOEdabFgrczcvUWo5?=
 =?utf-8?B?UUNSeENoT1BFWExBcEMzY0ZPTmFrWnVyVExUNlVFcTJFTEs3aStGTDRzeXNK?=
 =?utf-8?B?bFlQajI0RE40YnhUQkgrQnNEMU5PME5ISlVGQnluemhxSVVYeVZRemsxSUxU?=
 =?utf-8?B?dFdBOGdwaDFkMzJFeWIreGpuODlnSVVCakh5TzVUWXd2LzM3bU1VTnRKeGFr?=
 =?utf-8?B?bnY4T2p5WEN4ZVcwSTBPRkNFa2xzN3NIVytMSHR4azlpMmphUlYyVkFTWmx5?=
 =?utf-8?B?TVJaOUgwUTM3UDFFUDZLZUxrRkdEM3JBTG10R09xbTZlWjVXY2FnZDVTN2lw?=
 =?utf-8?B?Q2E3MmdVNTI3bCtRMzdQRVR0Z0pRck5oWXl1WHlMMk9aNzM3T2pjY3V5bnFH?=
 =?utf-8?B?QU5FZVIxMWpxVTUxcnFQOFFVSDFaOWJ3VmFHMXZPV0dielF6b09ybXEyb1ZT?=
 =?utf-8?B?aEJWcmNNZzhadVlDR1JRVTlVMnhTRUtUdDZ5WGdLamJ1YTRLUlNSaEJseGNP?=
 =?utf-8?B?S1pVSVFqcGFIUmZyK2t4S1VUZHlTVjhnTHUrOUZxM05QOVBqYzdRQ25YOXpn?=
 =?utf-8?B?bXMxRHhoS0xmWHQ0ZiszV2dsY2FtZkZhTWJwejdFU1JoUXJESVpWREpWUjlZ?=
 =?utf-8?B?NGM3enYyWHN2U2NiajNwSjI4VzNhRnFkTVRmbXZCdEJUVS9JbEd1TFYvMm4z?=
 =?utf-8?Q?iv60Fa7KtSOb8pDKHViUZZkG0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3154fc-44ec-4322-3735-08dbc237a90e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 04:34:11.9150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJjwHRv0MnDbDl9mrGspn7uWJuPIvI/E+Zp5n38jxD1w5G+OeU8cXju282yu42qbmEK5zGaMP2xZlARPXR2lIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8335
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

SCMI v3.2 adds set/get parent clock commands, so update the clk driver
to support them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-scmi.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 2e1337b511eb..5aaca674830f 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -24,6 +24,7 @@ struct scmi_clk {
 	struct clk_hw hw;
 	const struct scmi_clock_info *info;
 	const struct scmi_protocol_handle *ph;
+	struct clk_parent_data *parent_data;
 };
 
 #define to_scmi_clk(clk) container_of(clk, struct scmi_clk, hw)
@@ -78,6 +79,35 @@ static int scmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	return scmi_proto_clk_ops->rate_set(clk->ph, clk->id, rate);
 }
 
+static int scmi_clk_set_parent(struct clk_hw *hw, u8 parent_index)
+{
+	struct scmi_clk *clk = to_scmi_clk(hw);
+
+	return scmi_proto_clk_ops->parent_set(clk->ph, clk->id, parent_index);
+}
+
+static u8 scmi_clk_get_parent(struct clk_hw *hw)
+{
+	struct scmi_clk *clk = to_scmi_clk(hw);
+	u32 parent_id;
+	int ret;
+
+	ret = scmi_proto_clk_ops->parent_get(clk->ph, clk->id, &parent_id);
+	if (ret)
+		return 0;
+
+	return parent_id;
+}
+
+static int scmi_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	/*
+	 * Suppose all the requested rates are supported, and let firmware
+	 * to handle the left work.
+	 */
+	return 0;
+}
+
 static int scmi_clk_enable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
@@ -139,6 +169,9 @@ static const struct clk_ops scmi_clk_ops = {
 	.set_rate = scmi_clk_set_rate,
 	.prepare = scmi_clk_enable,
 	.unprepare = scmi_clk_disable,
+	.set_parent = scmi_clk_set_parent,
+	.get_parent = scmi_clk_get_parent,
+	.determine_rate = scmi_clk_determine_rate,
 };
 
 static const struct clk_ops scmi_atomic_clk_ops = {
@@ -148,6 +181,9 @@ static const struct clk_ops scmi_atomic_clk_ops = {
 	.enable = scmi_clk_atomic_enable,
 	.disable = scmi_clk_atomic_disable,
 	.is_enabled = scmi_clk_atomic_is_enabled,
+	.set_parent = scmi_clk_set_parent,
+	.get_parent = scmi_clk_get_parent,
+	.determine_rate = scmi_clk_determine_rate,
 };
 
 static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
@@ -158,9 +194,10 @@ static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
 
 	struct clk_init_data init = {
 		.flags = CLK_GET_RATE_NOCACHE,
-		.num_parents = 0,
+		.num_parents = sclk->info->num_parents,
 		.ops = scmi_ops,
 		.name = sclk->info->name,
+		.parent_data = sclk->parent_data,
 	};
 
 	sclk->hw.init = &init;
@@ -250,6 +287,17 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		else
 			scmi_ops = &scmi_clk_ops;
 
+		/* Initialize clock parent data. */
+		if (sclk->info->num_parents > 0) {
+			sclk->parent_data = devm_kcalloc(dev, sclk->info->num_parents,
+							 sizeof(*sclk->parent_data), GFP_KERNEL);
+
+			for (int i = 0; i < sclk->info->num_parents; i++) {
+				sclk->parent_data[i].index = sclk->info->parents[i];
+				sclk->parent_data[i].hw = hws[sclk->info->parents[i]];
+			}
+		}
+
 		err = scmi_clk_ops_init(dev, sclk, scmi_ops);
 		if (err) {
 			dev_err(dev, "failed to register clock %d\n", idx);

-- 
2.37.1

