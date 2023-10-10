Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3767BF0DC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441849AbjJJCYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378796AbjJJCYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:24:47 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2058.outbound.protection.outlook.com [40.107.13.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D12CC;
        Mon,  9 Oct 2023 19:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZB5/VDiMayylYRRJLVXl4wl7FhheZ77jhp181RLT6F/M186U0JV2xIOY9gqgtzo4Jiq26buXnpAgrAKU7krBxekAR0PLNaG+XYZu5tffbK1KbaUHOfQlkB1/KEhzEQihFYoDrToiOYP4+RwDKWWr8Gm85uzV8Ns/4kk4dc0eb7gXd9XCYVqXH4zHvrt93j5r9yciN7yZXi5WgCYgz9u93stsOtXmPN1Nu7p8usQcFe7YTnBUYao2Jq5R20mg40lUYUtGFLc3ig1Fxu61CTPYyaAn1IL/S1pJhFmq2srALOmNdAfDe0LfZZpcCroyF4CO5U9hSFEeSvPSVpfL+yyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoAjW5eoSLgPSc157B5Kh7SD3LvMrH0nvp0zsaaGaQ8=;
 b=oR1/1TFrMwek9axtZedtKn/ygbZAJBhCTezFLkLnayAqs80V81ElPdmDRq4QfBCDAqEPXc7Rm+6puFF/882kxzPuy9R/59lH0RpNvpmhhQtVb+w2IZdgz/xvLz/Lt46YUaHBu1ft+2pVW54rrsoWTTDHwCsW3sbKA+ULOsLJR5Q2YQsrxW5/878GwpUtyjcClG5mr1G9qjQWnr12RU6XjLPwwG+tm7c2LeYOEmO8wp4bULfJlQ5VKLwVamEVp3CNx96k03e7GrdypGSaB0+sltAp9OLEJp+6mABNW+kbZBLqZs6xnEa4Su7KKOh1imlXLo9PPB+sD/+JP0aXLaLpHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoAjW5eoSLgPSc157B5Kh7SD3LvMrH0nvp0zsaaGaQ8=;
 b=CIG23enDLgLl65BsFFv+i9onyrDslxiFb0NPxLkWon7tNjvuewzDcWrOGEs/OYttrgtYSx9m1YV9eb+jlb/tYVELRFvnmh5ePU0t/+PJy/lTiFey9m8tAYzfHDLM14FaOovWccHuTbpqt2Fdms+NFu3aYL238KkIOTr7lmBKzms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8731.eurprd04.prod.outlook.com (2603:10a6:20b:43e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 02:24:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Tue, 10 Oct 2023
 02:24:39 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, ranjani.vaidyanathan@nxp.com,
        glen.wienecke@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [RFC] firmware: arm_scmi: clock: add fixed clock attribute support
Date:   Tue, 10 Oct 2023 10:29:11 +0800
Message-Id: <20231010022911.4106863-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0238.apcprd06.prod.outlook.com
 (2603:1096:4:ac::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: 2347dfae-466b-4604-e860-08dbc9380d9a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CrQYWfRaDyOQVxfVk+3a4L+wY6dgtyLtNSkCzAJhlJYNL6t1dSwdoSejrtqCX0batAA4PI9y9tdRKGJQHK3o2u6GeTIJEfdLrLmfie+hHBqf4QPii1wel5i75dj0Df24oQrHzplTQwwjfkHbhhTpolpvqjgLgnfmTUqpCUAUudcQP9usbTaFg4mpB7pe48y4qe0QuVSV13s4lvhOjPefjG5cghGLDKts6DySh+thgBg0kxsTjL6JY0q9Px6pDMjHLKa6Ptq3/VwE95BBc51u3zxIg/HaSLN4GrUKTUMqIGKqTxKR0GVwDjPC3ud7BGkmQOjV93NXJ5k/Tn4/1Yf9CbV8HDiJN+UgPQG4DywykSAx5o4FnETHXn8mPWNvs5K6Hx5U9ojaR5ARkd8Ny/cHtNqohHFd4cZqwYnpkRV2wFhGnvS0SY3edLhfZdM3+1WM8jTA/Bkn7xTmAPqXIHy890NDsPncUEhVbuX1NpP8h0gvcXRGjhqNIMl6YJEHZIJSgP+kXSmqTxYiKJksQMEZCTYKnxKOZ6foScDp92h4fjh2CMO+6NVbd39omDpsfygOyOf3MjXtvfNF982J3IF8+ydKHPHv8wlv6jwJ4GI+H8wacjXa2fwuoWFPXeLZuRCV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6666004)(6506007)(2616005)(1076003)(52116002)(6512007)(86362001)(38350700002)(38100700002)(6486002)(83380400001)(2906002)(478600001)(41300700001)(316002)(8676002)(8936002)(4326008)(26005)(5660300002)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CfOrxQK7NveWC9gEdGLVLVWsNIO8l7dRVJLsEb/ptXlKAvdGKCZfUj9qvKby?=
 =?us-ascii?Q?lNT+LUFh05vga5AQpEzbICf2iMVE9aDThoEiS/pTUi3wigwCHEHGplNz94kJ?=
 =?us-ascii?Q?jMaWb8Bm68H8c64o89tXsdC6RJdUsuerLTboaZ3OSeJ1j8Hamwsl9ST//dtZ?=
 =?us-ascii?Q?YmFpFHADa12Y8lZFyDVV/MbMYnTmbGi8iwAlSZ8zUv0WLK7eztg6jdxAwQ74?=
 =?us-ascii?Q?95AnZdozcnnwH1Cpyy5+A6rvBc99kxrn9/8X//CxvLNwsMcd+ae16FQgfJob?=
 =?us-ascii?Q?gdlyZwjkbLK4UvtlppkDLe6QKxpy8cnifTUprvmWBaaBbG4ayY4qeBeD25OY?=
 =?us-ascii?Q?j7ffa5lO63HntuPMl7b2jrtg3Ou4Q1G8CcOOY/A5WRtGsJa51id2aL93BTds?=
 =?us-ascii?Q?dcYzVRsyGXBxeIK94NgtnAP6Dz0DNAvp0z1mXufGqBrEgVi+l1uBDIAWTLiY?=
 =?us-ascii?Q?3JoLhWKn8VI8SbtcaQWp8skyyg4/AMXsQc5G/9JtFfGhRTTYcbgqjsIkIIWA?=
 =?us-ascii?Q?5DYyATIB43OoSTTPI/7cZYTMfs0u7TBpZWgmvmYxEeh0l+bqZ3tpXqRvSKt2?=
 =?us-ascii?Q?0SQB1gfyuBplcLFZJKBSSK5sVrSSfCqSXyLVid2ImrEbNEIKHu172nNpuMJH?=
 =?us-ascii?Q?ybZPxDTE8pZBNlhZfFck28nGwB5hKmvj7Uwker6bs3XJG9PV99aAob0g26Jr?=
 =?us-ascii?Q?JbiJFQSo2AO7XNoqZQK9gGqz2iyqNLvQmqqypMpWSibFjwPkLpXouKHO6T4L?=
 =?us-ascii?Q?iDYpMSXrSQVnOYhOL6PKO7LFAZTMlObzSQ6+PLtgh9BQxh8Acu3r56XR/Zn0?=
 =?us-ascii?Q?tG9JO/zj51ZaDHytGXj8czSi90yGdHC1D+U/veYRo3kJ74+RmoPBznTtTa1S?=
 =?us-ascii?Q?4hVnzUlj9LvuUfX2Xhm0R9l9K65hLK7s61bNOZ8c/qEMtsZQpcIWVlHD4wVD?=
 =?us-ascii?Q?3J7SmaJGqvBJ8Q6OyvIlz9b/jHPB1PvvqcqO1PrwujHbjUBYNPKcc4WpaFW9?=
 =?us-ascii?Q?aPR/NysHyrgMZaKaOKmZvf3IchijTtPoJg31Mp10SD5D88qY9GJueDr3+w+g?=
 =?us-ascii?Q?sLAu6FI+GteM/EIyUGzxFC1ZsKqLdjoGfYYU6/020qb+v8ozKzfr9357Q5wV?=
 =?us-ascii?Q?RjbRGhslnRVwVLRzGRkWg0PSK8428PwTO7QqKSWZ8f+A+5Ft8jmaVRal23Ey?=
 =?us-ascii?Q?6Y2JxnV9ofgczR714ScarmEsLZF0j7aY1CKsN23vyX3PoD2LXlO2WA+CHUro?=
 =?us-ascii?Q?dDTGDkLglbuWO77VwR+X0mJSYEqmCEQ5A+YhXjNYEpc6pfo0mzX2CsmuwFET?=
 =?us-ascii?Q?sNiD9o5apVc/VsNPHQS92jo729sY6JgPgBvJukXty4oN+lTmtAhtxBjGX1oZ?=
 =?us-ascii?Q?DCr8khH834gUYbIW1eXSfnNVznaKNKJ3pJTlU5QIJ+KdbJpAmwgf6efzCOzL?=
 =?us-ascii?Q?ztVqmI5hJCyg5Jp1DXg1t8Ihs46JO19WebMlamzsIPxFG6l4pPtrWw14Sr4D?=
 =?us-ascii?Q?ialVZeMVdm1/TV+Xktu0jZf/p1diQIVeYJ+0VcOM3BGm0pClrHSY8LoqkOn2?=
 =?us-ascii?Q?Pqo05kJLKE/Iu+CkjAXExJ0G67tyssROICUzEWtr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2347dfae-466b-4604-e860-08dbc9380d9a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 02:24:39.1904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gwge1nJcfuSVLg9ta5Qcxj9L7V6HlKf7j0144k1KbN/FktEuqyekRJV8N3AYM+ih8h0y3z4DbXlt95eanEltw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8731
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There are clocks:
 system critical, not allow linux to disable, change rate
 allow linux to get rate, because some periphals will use the frequency
 to configure periphals.

 So introduce an attribute to indicated FIXED clock

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-scmi.c            | 6 ++++++
 drivers/firmware/arm_scmi/clock.c | 5 ++++-
 include/linux/scmi_protocol.h     | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 8cbe24789c24..a539a35bd45a 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -182,6 +182,10 @@ static const struct clk_ops scmi_clk_ops = {
 	.determine_rate = scmi_clk_determine_rate,
 };
 
+static const struct clk_ops scmi_fixed_rate_clk_ops = {
+	.recalc_rate = scmi_clk_recalc_rate,
+};
+
 static const struct clk_ops scmi_atomic_clk_ops = {
 	.recalc_rate = scmi_clk_recalc_rate,
 	.round_rate = scmi_clk_round_rate,
@@ -293,6 +297,8 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		if (is_atomic &&
 		    sclk->info->enable_latency <= atomic_threshold)
 			scmi_ops = &scmi_atomic_clk_ops;
+		else if (sclk->info->rate_fixed)
+			scmi_ops = &scmi_fixed_rate_clk_ops;
 		else
 			scmi_ops = &scmi_clk_ops;
 
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index ddaef34cd88b..8c52db539e54 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -46,6 +46,7 @@ struct scmi_msg_resp_clock_attributes {
 #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
 #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
 #define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
+#define SUPPORTS_FIXED_RATE_CLOCK(x)		((x) & BIT(27))
 	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 	__le32 clock_enable_latency;
 };
@@ -326,7 +327,9 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 			clk->rate_changed_notifications = true;
 		if (SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(attributes))
 			clk->rate_change_requested_notifications = true;
-		if (SUPPORTS_PARENT_CLOCK(attributes))
+		if (SUPPORTS_FIXED_RATE_CLOCK(attributes))
+			clk->rate_fixed = true;
+		else if (SUPPORTS_PARENT_CLOCK(attributes))
 			scmi_clock_possible_parents(ph, clk_id, clk);
 	}
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index f2f05fb42d28..e068004c151a 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -47,6 +47,7 @@ struct scmi_clock_info {
 	bool rate_discrete;
 	bool rate_changed_notifications;
 	bool rate_change_requested_notifications;
+	bool rate_fixed;
 	union {
 		struct {
 			int num_rates;
-- 
2.37.1

