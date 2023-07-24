Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E481C75EC48
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGXHMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjGXHMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:12:09 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1080139;
        Mon, 24 Jul 2023 00:12:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqI/3+nlJDIjKf7I5cCQwBTVCTiM4Y/0GGokmQnx5mR3I+IgkVyswgjR/+XlCKjWpQuQ4UMi61a2DnUsl24vTjsJ7saLzxLvckIK/QzJo8NbFk3toGo9SQ17cGvrr2cOiJnaxXDMf28dWlwIufjJpRWKM8WyNeQvnF6JlbtQoK519JVwn0kWKN9AK8LaIMfaOhfKbilgLxwRaj1VXTKzcIq4Kn2Va1UqqTrVDq1KcIACqxv4eh9zV0pBcxcM5oEaVIAuLqDCy4VIb8YE2M7FrMCXcKvrBIGgpOPNoZx6szgB/I1dBxVAXPS7d/4eqOP6uxxoAlglYJE5h6V+RPmiZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5YVifBkDbrDwj57HmtUQ4hsDXAzljRU7zOVccAyGgc=;
 b=VjltN5s4uwyImbvP6pSxct2XoWt7vqYFEeN+fmq3oscIpqumLgeA20/jDGcCrNO3ALS9kYi6QYFqRh6BZDSBXb5GhZIoDE+cPRZdXcsk5tWC35G6VByngg7lyYzlb1DhTHGPaidDr9I3sWeZhoxklhOVSv+0sk7TuhXdu94fNc78IN4S7vwXQev9m6pdSXm0yYfTIZmQQIjMst9lHkN8dCVQSH443Mf0X/95zUWlTt+ODkPMC2Y+rCY/vHE+WC4t/YTXEGvsQsPU4BcEc20bDDWhtOBEkRh60krcHRF0T6w/JxtZBeBPRb6sONadLSZg/giiIYm9JOBCsRqyGADytQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5YVifBkDbrDwj57HmtUQ4hsDXAzljRU7zOVccAyGgc=;
 b=AI3aOvr//DTwxgpipE64gtG7Amcp/erCV7I0aBfOU1fKT95TD3oiAYyAS3k+vOsRxMwteYf2YUxg/a2/AyHlggfn17kkFIjMVlmKVNvPZ6i6p0gQeQW6w6qMp5snLlE9gsyXprIwjS5e4jsF/R15HffZafw2JD0LjlrO1dvdFZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 07:12:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 07:12:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/2] thermal/of: accessing potential uninitialized value
Date:   Mon, 24 Jul 2023 15:16:46 +0800
Message-Id: <20230724071646.2744900-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724071646.2744900-1-peng.fan@oss.nxp.com>
References: <20230724071646.2744900-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: a26c39ec-7f44-4d71-33ef-08db8c1548fd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ywdauVCFAlQE7siJP0W3Yk1Mx4ScIkqBt/e7zYxZuZEJHHopj0J7ZltoI2zkKm1aRvjEgj8IUUdckP+MaaDBwYjZG1xOIHOr+lhwKHLvnjJc9UIRwv1Bld4Uwq3N45LRqqsMjKUUHSG78efzQU6e6PMGkWBQaBYM/Ew0txG2yYwkhWEX7JaWXpNBG1exG3FX6G0EzU31++Igmv7I59E21329fE7gq4kcX7+eHiWdWUaB/G6JgWDn2NlgVUadG+qLXL4nzg65hd5rzIkJXDGhqLMWI2L6ZIUtgiFm8StivTrAt5TF+6jfADHoR3rgNV8kREBUUPBBS/LwvSq2kaAshoY2Wy3v5gfnknrrPywFjfvr+ffAHRsZq+KFaWTdA5YEiZY8aXznWg7+z/al6ME3RFMYe3vMBuNylrKcf2nHXdV5iHH/zAYTybqfIaBTP7cVHUYi9tMfyPGuIhhEtiDJtkAkZfxEHaWjt2pILFQHezaUSsLEGNxhat63PZqMjNPyyFj1ESuabBZhCdmLLwY5pzZIb8M/I+Ou0fKtAmASaLY9LAMqZzbFk3xo4LrUp4O/xZ3f3W8Qxw5p5ImHiQ/zDzFmw5M2L2nEzntqX2pk9dxaKupf32h9cEWznjEUEqB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199021)(6666004)(6486002)(52116002)(38100700002)(38350700002)(26005)(4326008)(66476007)(66556008)(66946007)(6512007)(478600001)(316002)(86362001)(2906002)(83380400001)(2616005)(8676002)(8936002)(41300700001)(6506007)(1076003)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?twhaKdRGsJVl2/dH3kkmgZdVh2grE5hhtUa2O/3UIGlc88UWNDrKNMCEdS5K?=
 =?us-ascii?Q?u2Fp6R1IdSneO1z4MEry9wi/mM2JRa6Of85tzaToz3BkWeee5mc3mdl7SNfz?=
 =?us-ascii?Q?qaCCNej79kLiMDsYS3NeMmWgkptucuT7EiMksVsAi+U0MOz5d2M6jv9kZsOa?=
 =?us-ascii?Q?cWMt7QXaSOe2TjvtM2wQ6z2LpKGE6faHT6q5T/gy5oFp1la3I1i+oXWd5zz3?=
 =?us-ascii?Q?NexAzkiB8yxQiVQ86B7mXAAFkbolojPYZqMCmoH8LLoG1sGVZKBabZhLx6GV?=
 =?us-ascii?Q?7a/mjYsPN5AiMWZI0hU4KI3UOIdOFszQP960lasmS8K7hM7Qozv3OkklQox2?=
 =?us-ascii?Q?vujfQ7EDCJjg3eZRjYHYcx+JCwWJv5/wnualjwf4a7rouJtPZlZOjJLpmu9H?=
 =?us-ascii?Q?xIcb7tE1A3HI74OcF/crfeLwujhKmNAzLlZZkr5diBwS0Ws7LwiRe3kxRx8t?=
 =?us-ascii?Q?l/FuI45d+7Kn41/HSCxtjT2FBYfhugYmx1Gx+Wv20/cXeP7vMGeZqetgh6sf?=
 =?us-ascii?Q?3/jtakvN9st1L7xbimXp8AgECn+Z57sRdOswUVVeA4yRBgY7QYwqc7nDzNa1?=
 =?us-ascii?Q?Hm55YjJ6AFepzVkcAez5GGAbaBZO3gKTag4hYexIf4igbeUYkYyrEaOuKlgZ?=
 =?us-ascii?Q?IysIWxFEVxQr+pfZneFRTrm+aD1CdlBHsHGe0mXl2/BAS0/M8I6fte9Rortq?=
 =?us-ascii?Q?DVeS3d200suo28wDEd4+4Q6dZQrWBpW5phkHac+53Pf6ryn2s0/8fRzaahT2?=
 =?us-ascii?Q?rbKRBzwvFgq2EapDsQejlVIXwKk8UT9oL99Hz52fdTizQdnV4tqP1HsEage1?=
 =?us-ascii?Q?Z1Mpyq1nq6Vbv3uE4r17bat18xPwhsiEMuI66ZDFcgVb9+pMBTnLDRyAWHO5?=
 =?us-ascii?Q?YPoJkA13wdsltglye2+gdAyiGeTwE97WEptCXM+irZ/X4LqOcvyGd8eF2NxS?=
 =?us-ascii?Q?czR2Qt8nme5kCpj9V/Gx+4dUoE41Rrlx/yDPbzvD/Af69GD09Fpcm70EeY3H?=
 =?us-ascii?Q?aowJ6g7K7j2Bw6ACKzCcHI0azPcTadaz0VZoOxnBHnSBtSb1FrGOAr3JVUQl?=
 =?us-ascii?Q?omV/L96HgJliMl721tYKYn/Rzon1y8a/D72K2bVSHJ847YhhTFGOnDbDgoXd?=
 =?us-ascii?Q?L1N1GYjOun8jmnQDh5rWmaAVZXd8rRFRpq+xN8mqp/N80exuCibL9MghRW41?=
 =?us-ascii?Q?eEwLczwscmbs0ZZjCPdcCopy0ecMr1r04if3JGun6gzkY/ZEEyNiFkkvHmyU?=
 =?us-ascii?Q?PDHpi7knAva+p7l3ESZdpbHiKxyWVvNDQSD+Ld88TvdiQQinrN8xM1bHJWZR?=
 =?us-ascii?Q?uT48yF/axZN5MHl5t0eUeyv0CM2XfKaON+DjWotmcnMZOFyf/axn3DUD6SGS?=
 =?us-ascii?Q?2iXe6LaF4xiQhVHtUk5j69Loy9/+3bVVmiXIkfvalXh1H8jjXHnF8CLy0N/e?=
 =?us-ascii?Q?3GCc35Yd3DV9YUSCbD5n6FrnvayrjYXZrCzgVXKliJHR7qOqQFmI47kwToCC?=
 =?us-ascii?Q?8oTPU8ukUdbe3bQ5T5cfMHvnPzDKVGAO+GCjwBdeCuBdYr4vehXTR3YcoFuf?=
 =?us-ascii?Q?T9mfUqlxNSoKFGLPfjd7+ZuzyK6nTq7BHq6Kz273?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26c39ec-7f44-4d71-33ef-08db8c1548fd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:12:05.1298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X08AwmVH6jBMBzjvtY+F76LkP9JAj1N0tB2pR7zQD1TnNIg5uu2HhOSoSvIlIDNFeRBM39wrM+Hosbdrmd4nwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8567
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

If of_parse_phandle_with_args returns failure, the cooling_spec.np is
uninitialized. So move of_node_put below the return value check to avoid
accessing uninitialized value.

Addresses-Coverity: 25772185 ("Uninitialized pointer read")
Addresses-Coverity: 25772845 ("Uninitialized pointer read")
Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/thermal/thermal_of.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 330690a3a208..4ca905723429 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -291,13 +291,13 @@ static int __thermal_of_unbind(struct device_node *map_np, int index, int trip_i
 	ret = of_parse_phandle_with_args(map_np, "cooling-device", "#cooling-cells",
 					 index, &cooling_spec);
 
-	of_node_put(cooling_spec.np);
-
 	if (ret < 0) {
 		pr_err("Invalid cooling-device entry\n");
 		return ret;
 	}
 
+	of_node_put(cooling_spec.np);
+
 	if (cooling_spec.args_count < 2) {
 		pr_err("wrong reference to cooling device, missing limits\n");
 		return -EINVAL;
@@ -324,13 +324,13 @@ static int __thermal_of_bind(struct device_node *map_np, int index, int trip_id,
 	ret = of_parse_phandle_with_args(map_np, "cooling-device", "#cooling-cells",
 					 index, &cooling_spec);
 
-	of_node_put(cooling_spec.np);
-
 	if (ret < 0) {
 		pr_err("Invalid cooling-device entry\n");
 		return ret;
 	}
 
+	of_node_put(cooling_spec.np);
+
 	if (cooling_spec.args_count < 2) {
 		pr_err("wrong reference to cooling device, missing limits\n");
 		return -EINVAL;
-- 
2.37.1

