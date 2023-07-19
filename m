Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A175758AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 03:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGSBMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 21:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjGSBMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 21:12:02 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54D61BCF;
        Tue, 18 Jul 2023 18:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyG5TfTZnzmXZbhP4oNgjrMZY332MmdmE+FmuRwKo2wBX5z8qf0OQ5NCAg2qDl42NX4lpMXGoogNbc+MvMO4q4/EVa5wkKcFWFhuUryapklouOPV/JGh86btr7meBr+d/ERfrnBO5Etuq30pD7s7UGBzGwdOrVXS4E3rCt8JzmaLE4zA8b3YBuk1y3Nfo7XyY5K5No9b61ebeSic5JETLKkCvhLiHMA0sZQ0BSCi8DLaMgqpVCrEpMgHbwePyCK7aGJFsW4oGjBylwUboPmlYsaf5siKJ2UYL8Hi3OMpk9+NIXuK8gAVxg1+6+75HgLmlqFo7ecvBTN7Nr4+Rl3iNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wcF9zFZNpBVDma/sd1rfbuadC8esQz307gzkbSEj6A=;
 b=h2s2GsLjqoMgZsnrdm3A/RWpPrCxtuetEGKDp+ohSuCxIfR/pS6mI2bH9Pa6JLHVhaOIy1Cd4hYHyGv+/RW/T+1Overuuo0TDW6proc+gafqcUdt6gYCQxnXn1lBmMyfFz1UY8KEPnQ2TZ+y5rTEA53M8wbERe+A5R111y+SNUHBYnNqD6zrAJitU3gXu+3LofOwLSbYiRBpGXxJbRYQxBw9wWL89J4awItO8ACC1p24EhivMVmRuA+iofP+pwuRJeucyeXB2Jgg2qjbbzpxnv/zLqtP9tPg7hgo3r07nEXm3CQ9SXo03Mt3wo4p2o8Cw1wcJ/EvJM4PjoqMwyHYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wcF9zFZNpBVDma/sd1rfbuadC8esQz307gzkbSEj6A=;
 b=GTroljH/Vr+rgZUDvY3IO3lTR+SYn2f4Xq3Aumme+q44BMwcIleLe9QdKPhWdvs8m7QWT8vizUfHPcujs2cgzcDTjssdvlRcQS+K3y7ZkwKn06L383HpD0HGlrhhWjieqzwZq1Q94KK5Zq8blhdkclE4PUvodVTARYdscv7Bs6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7558.eurprd04.prod.outlook.com (2603:10a6:20b:23c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 01:11:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 01:11:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] thermal/of: accessing potential uninitialized value
Date:   Wed, 19 Jul 2023 09:16:36 +0800
Message-Id: <20230719011636.2893238-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230719011636.2893238-1-peng.fan@oss.nxp.com>
References: <20230719011636.2893238-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 43abe8bb-7fc1-46bc-ab20-08db87f52573
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fl1tUCSK3pMZBMfD5YQWZ0nuQjld1eS4oSFBwxGsXIxQf0nunZXt83adyt1IA4tPeKMQFmY1dJm0LjGh8d4FDEfR5Jx536yRzNlAqiJmnAbwgwT25db7qWJo08/5j1yV6+9ER7G4MN88fYQ6JfCPbN0d60mZvbkxXs6UgMGdD1WFQx20720yXsh+sScn0rzbEnPGSys3Czg5RBk7lgCS8JRC37Gfrwggww78Z12qJeTNlDZlDkGSwSPePdEO8xYLXEhiMA1Q1w6qKNLXMrNkcONP1bVxfVze5XMPEJzIhJNXQQPMGdUxRDNRlRy/ypfpkJOLU81QsLnC7CV6CYEIm+QSX4XrmvNZF1ypA3a7pW0+jHbmkQKdkPPqHZgOe6VV4EeJScUnoNH0mMcD5h2d3xOyGVxI82GzPAAXkE65SI9JmyjZFS8fcfILChY8UQoQRqpRkxfrEhwigg/zgSfJMZAmIcuO6h6wAUwb0pjyl7qcVhOucWuFjxhX9dr5MjuUWbKnYl8l+MnLIkBMs6OSuLgoZrmcLCEqNP8xccZvojVQrmLKvDxEQOoa02HSCvL5RNdIsA+gSNz4YL8NQn5JYPBud96AqZHVHoveWryb75aAWO9hgUfV9NobRfNg6Xzp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(1076003)(478600001)(6666004)(52116002)(6486002)(83380400001)(6506007)(26005)(6512007)(186003)(2906002)(8936002)(41300700001)(66946007)(4326008)(66556008)(8676002)(316002)(5660300002)(38100700002)(38350700002)(66476007)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9B10e5tbKGTQTZmpJDo9G9DXjWIwDsVAC+gxxnZhFSR1mJsrKXh8a0BLCxM3?=
 =?us-ascii?Q?m5+NpG2EJ2jxmUyDq82E7Yf2ESh13A3wIBw15Ac8odMEV7+/Wugop8aNaSt2?=
 =?us-ascii?Q?jjdHbLffCK/5SXmALL3eHMrh1fqhBKmWUsexfrTgeQS6tG054Tn4Fg+y/4EN?=
 =?us-ascii?Q?5id3gGi2yaQnZV8iqmMdj5N/Tv6ljw98W/EOIo6n4/99+MXbVjjMr5td7jVm?=
 =?us-ascii?Q?TUW4o2ELm0im7YDhgCD1HAyYmaWKCk87TWY3iiBtlbZmctTN88IHSeHsOirv?=
 =?us-ascii?Q?Mdz9i8NEgb7N9HQWqQZP4feH/1zykzSmI7EhRT+/XIEq9ghYbBMimxpidE1l?=
 =?us-ascii?Q?SEQJC7LafypEzhoi6qaUVrb2ffMXtjTKnNwSOstvoB5V6DuMCvQr0YO/CYUv?=
 =?us-ascii?Q?lWSy44r+An1QyT4E8Vkwzk1jRQtoHMpZga16MTroOQ4CvJ1EuZl3ka0dtaUa?=
 =?us-ascii?Q?E32FtXflHTpa21hz1HwczolkvyUbzmWnQY1NGTGexIuMGFiqF8KLys3gQD8y?=
 =?us-ascii?Q?XD6N9wN7QXiQvSHTFfIXC/5YPB4DcMGwBG66OxtDlgf3PXU0lUtkqpUxsTO9?=
 =?us-ascii?Q?uw0hZesz+9XcgitDNW39TW4SUsjRJazTK9A0Ckmta576k5wcSfgj/hbRvAW3?=
 =?us-ascii?Q?EcOtrTDhLJXhSOyC2DD0EgsRCE6hCJPdA+sI1planEbdVu5tEwKiZ6U//Tpr?=
 =?us-ascii?Q?v1p6zCP75Hrk3tZszOs+49hlWD0jh15SUFbJzHYE+uxU6bWQs5j4X7Rovs1P?=
 =?us-ascii?Q?z6Ac3NtfKcRi84dPQydpi2/oEz+A6oUesdeWUOkGAjJsmh4JtOikUUONe6ih?=
 =?us-ascii?Q?CU4mcA1rDLO6d+oQSaoA0zCOuSygvR6IvvGQXOCUgBVtu1x4Ka6TFY5uNM7l?=
 =?us-ascii?Q?R+gCUVkpXh2b5O2S8HIPNlJJeOS/IQc119Yu1KoUqtBq7k5vgugUYyBynmjO?=
 =?us-ascii?Q?98lbyNSFuPWSvH/uCyU+Y6grRw5MK+h3aJlfGKSvWAYk90NMyTNYSj/n5eYP?=
 =?us-ascii?Q?KGWczKso1YUSA5FeAdu5VNIc1T1YcBDxP/TVw1m5+pDVnsMUnkOfF9HcIqtV?=
 =?us-ascii?Q?dJ2XgOvPiZdk6x5XvRwZxRDa7eR6k54UUJ4NlpvOvnpELAiEajkeVhCc/SkU?=
 =?us-ascii?Q?Pt6JuuMsBMDnShoY4TOpA4hN4NnI0uGZ2v+yJ+gTpCMV5IDtEQOvNUuDfhw4?=
 =?us-ascii?Q?FQbXJcYM/BFHhCuWM29UlCS1y7z3etEOg+V3xTlLwcCAMIZbnt0Ec5KvzboP?=
 =?us-ascii?Q?Rq39iFkn1nM/BBKRApvde0nEVzQ7GEvCwMWjkpYlCFDPHSZn+KQdp2batENt?=
 =?us-ascii?Q?fdoCACLV1+so+R/Tldo8IGuVU6eDUwkrRsIc9GACfkIoN/M2ReZv61vn1jtT?=
 =?us-ascii?Q?MdkLw48GCiPyCfCWjG227ArnqsNkEVImwsB2lFE+cSPjdEVwAmiRiXjK098G?=
 =?us-ascii?Q?4dShqUYvnYXfTRdxITxfZGEYL5Tglvw8o8Szw2JW/DEz5EzatN3Ops5d5DNK?=
 =?us-ascii?Q?aSOSxMQ3wAzjAKRiER8OC0D8afcS/WSFgrvAt399blkyY+oi0o673I+c0A0Y?=
 =?us-ascii?Q?7wp/fM2Jz1PXQMbjhJwGzk258rR6uTZD9HIFxv5X?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43abe8bb-7fc1-46bc-ab20-08db87f52573
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 01:11:56.9944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssBIZlmKjz5Nz90G4rZuQqAjUu5JomSdWrJ37NaPcT7NjvH/LerbSsO/zKg2+NAtorvKenSGIIHiqA+b73c3oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7558
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/thermal/thermal_of.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 6fb14e521197..021327fb434f 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -298,13 +298,13 @@ static int __thermal_of_unbind(struct device_node *map_np, int index, int trip_i
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
@@ -331,13 +331,13 @@ static int __thermal_of_bind(struct device_node *map_np, int index, int trip_id,
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

