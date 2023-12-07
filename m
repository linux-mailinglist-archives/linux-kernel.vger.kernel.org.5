Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA99D80863A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378750AbjLGJaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378687AbjLGJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:29:41 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D503710FE;
        Thu,  7 Dec 2023 01:29:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5qr6HBBp9rwJvItyI4xddNCmf771rqQQbxprqBIovFSjcio1oUI0mWdcxYjpV3Rao7bD+foaRtIyqxp/OOgZUX8GAaxY8+MmS5n/CBgRnvcRfP/JOrmCMmb8DW2K8ZZLUVr19oJ9iEiNAtp7rznSTku0AM+a0Z0IUVBvEMESczd4ATjWLLJzOe9bcGfFUjmiB4I5ri+KR4GnXuoq/feMUzIfQr0RHXcFqOW/DGLXdBpSbwOIcuzAYae1XztP9xl3NegC55TcsbnmNahGHtlHXstNwjQ1TS6RRHjePgQMYWqqAk8Fgra33D230HB0zokFlNEhaqK2Ibsgd+4HrGHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKFyWYwRsPDybajJJJMPHDw8F5fI/OSd+WrPnE1fbGE=;
 b=VDo6I73QNldfcn5ACFOeG+uP2RLz4WbP10zv07dyXWFzSnaKZI+hFW6oouHrrzRd64vLJgLCEvDDBTSGQiQ1DK1K/3A+YfCP804Wao/oIF1N1Ciiu4ng7L34bEBhjsT4eonETFe5zmhGl+Exh1PDQt8BSnXrISBrYWQZ5yhSmGotIUiOhyGIIv1zdoRsPVCONajU8wm1c5XYR9PH9zn0SmBI4ETGl8/pYW02aJcX9oDp5+sgTSeihRcmXo7SGvXcpaE9pNadGZC4DQzBOQyCCf9DryDUwya1XwVRkpk5wtajymDJ0eTlWzielPyuUkAYXRF6GvAudzDMW1Ex5tIJzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKFyWYwRsPDybajJJJMPHDw8F5fI/OSd+WrPnE1fbGE=;
 b=lAxoKmZ3ZYplzUunjtcUdWNElcnZlYYX4pilaSjktM571swPSgFLiKeJCUMRTrets42sZsC010qQYjDHJPzTz+2KEjNa++t13GQMd1lRmlTeO4zDLYhTK/bore4rME9sfybbDz4UhSsM1ItfsVAk32Vow37fJNZR2HxP8ksC86w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7286.eurprd04.prod.outlook.com (2603:10a6:10:1aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.26; Thu, 7 Dec
 2023 09:29:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7046.015; Thu, 7 Dec 2023
 09:29:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, ranjani.vaidyanathan@nxp.com,
        glen.wienecke@nxp.com, nitin.garg_3@nxp.com, chuck.cannon@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/2] clk: scmi: support state_ctrl_forbidden
Date:   Thu,  7 Dec 2023 17:33:45 +0800
Message-Id: <20231207093345.581048-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231207093345.581048-1-peng.fan@oss.nxp.com>
References: <20231207093345.581048-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0191.apcprd04.prod.outlook.com
 (2603:1096:4:14::29) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBAPR04MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 46838e3a-0833-465a-fb42-08dbf70703a2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1K428Dn3ZX/7nRmLr5gkrliKKdmzsSWMiLaxxh0qHP+m9T11rdKsGcIdlqNTfOd3h540z4wVSRELRisMu/WYom73WxhpBL3d9tri+/bf2IGLkqj9mOrtS72AQBdmgp09NWMmYAoMZxxeTL6SPnVeyF9Jxs5hPJ3PoLwMDP/VzMqG7bWISxjfR1VeN8dJbRuDe+HJMcCtFyjI3UemNK8VDYQMeP991d7SowGvBw+rb5GjFaYpbtGeQYJbnliBLyxC5019deTsdov9rAmTGrYyxlgci9Y//ElUags7GAE6CtrWHFaHwEV7/CgXLN9H545cgUFKxVeMqSHWPCmP9i0g9NQjTuD/8d5fWQLOpB78NZ+0iS6XOVKh6LAxzaVpSpAi0J9/DWADITVNywU477wj3p9clT/m/pPNIUAQfB3XDSGEjCbJ+c8Plz1u+xPei1i5L0I7vBZPyByYJuyUD+aMvy3hKCUqCboOHyCzBRLQLGIycMV4/fhP0lM/yAI+0qXJNxpOqbULgiCMV8SAtQI/Q5ppb5PGVsauatqKrUbD0+To5FJf4sKjU1CRZxd7yL9VvXLogeMIUYtGiiIRQxMs00OdBbnux8bKK1WSs4Ngv59XWmjb29Go4nL2JtVM9TWaFmqDNZRfjW42n9ycRNOaCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6512007)(1076003)(2616005)(38350700005)(316002)(26005)(83380400001)(66946007)(66556008)(66476007)(6486002)(478600001)(6506007)(52116002)(6666004)(5660300002)(38100700002)(2906002)(41300700001)(86362001)(8936002)(4326008)(8676002)(21443003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oP94Zwglqi7DNHenhzEVOfyE+e3cWkBMdZOpqHAy329uv9n32HX55VK7p33m?=
 =?us-ascii?Q?Uka9zDUhl0kIcOFq/WFdd84Q6XNWJPIDdOXPeN3pvWu8Np3rzMukSzHGxnj5?=
 =?us-ascii?Q?QiGb/maBcNSQBUzMa8iEYRQVwokCj5AaKgClbMM7RPrZ34rw3Zy1UVQ9JKpO?=
 =?us-ascii?Q?4BEjjWnfEYKcQlDtsjti8ZI1uXMbc2XMMmOsCsvJxLl+//GzUSoWzVvRnY9L?=
 =?us-ascii?Q?OW9LCMMwCKFcEglBnsExpnymZHDM3xLBZfAlW2zh3XiFy97wUL/cLihwgRyq?=
 =?us-ascii?Q?0Pg/50/CU0BQMbKBhwhYEel6OiaabJzhnQVqw9b0fzOPSAMWz4OCTuYCBaM0?=
 =?us-ascii?Q?DNZMspWB29WrUUVEHBij21iyuIhXYhNlvLcacBz7UtIWyjruaDhPLEaFxMfS?=
 =?us-ascii?Q?eZY4xGfUufy9kqVrFnvjwxLMVTRwdexA5Dsj5tplIlclJQhOcYyOu+eiRGAz?=
 =?us-ascii?Q?a0/RjytdTpdp14uOE/FDEDGlHYX2vPtQRuJal68XnxT5sLBVFRXdjaPuS/Sk?=
 =?us-ascii?Q?Td081osYDkT7C8UBhc2en73KVknT5aDbFCjecFrIsj6CAAKUA67FGgxJkHtk?=
 =?us-ascii?Q?6LojrzsiSlKf6dePEz/vaGq4Tk/lw9lpapO68x6bCkcCml+I6XXLioasGRd1?=
 =?us-ascii?Q?THJMyfO49KKH6ZpshgVZI/f/hORnxkaDSwPOBARV5xb1ETI8I9nnhQhpe2nK?=
 =?us-ascii?Q?alPJRQ4NqhL2nGWyb1f65fa9KVBi92H+OD8A4Ud03/ORBf5yvy/zdtMRXJF3?=
 =?us-ascii?Q?rpJbI3aLFFPEgA5NPQiM6xWEDj9+ULr2FShFwxGrSgHvlqdxM4xUXnCDpOWn?=
 =?us-ascii?Q?gC/LHZg4sOkIV8uJx6o71AXc4a9QiPCS2s5tM824oSPkjUntc7FwUyTdg+Zz?=
 =?us-ascii?Q?XTRN5c5fD08CL2Gxu85SzdffX3FGgqgIUf7vpEPsacLy0eqqBkH+4ToiaBXt?=
 =?us-ascii?Q?jougOBNWXZigkib1fLYsRY0ghvAibcTwfnEDFLon+XQzeIgZb7db5xjjCj49?=
 =?us-ascii?Q?rCeT0np06eHdi7rUa230NJIrQJmv8BbZLrjGLWMfNontBUL4aQxPbiwbRiXZ?=
 =?us-ascii?Q?EHnXf5xkHegHguV878+2aA1zvzFZ7Mqlwa7dr2ycXq1YXkmgdITBb1ONlGfO?=
 =?us-ascii?Q?AtfKU0fxBqRavHEliX4Npw+MJn+tsozSvEKZvhPWlCldsuI2XXvSJrzCFZIB?=
 =?us-ascii?Q?fBJM6Z1DA1EMzcSPk6JkEktnESBVFRBg6WvKVZy3VqgBekAYsMSQcvT8H/sw?=
 =?us-ascii?Q?cfd2kHa4IufdPXilIAFdSMPyKvBrB/fCdpaudYS3Tp3TDtoV3hrxg9CwAupO?=
 =?us-ascii?Q?k22kSiCjJXy+1jlXlHHbxtk28cjVNEQPraHnd5G0mJuVAbHhZMh5etSMjj5u?=
 =?us-ascii?Q?7NTNdRt0UpHKI34j0quM5nxlHJwYUaE08tMmDi7rQwyc6dtcRxba63ueFmTI?=
 =?us-ascii?Q?jY8GesLJbqiDZ0z3H0WTpWqHgCTKUoOeCbGP+597Kf3J7kSzuEVS2Hz7k321?=
 =?us-ascii?Q?2/RZMf6YsB0S5+ivR8BU2s/hwWayfD32zPbFIgogFKWBOuUZb5jEYP8wvLwO?=
 =?us-ascii?Q?0V9GmWV/cGJkK3b2uLZGlcsZ0VG8ZGWCRJ6cExdX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46838e3a-0833-465a-fb42-08dbf70703a2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 09:29:30.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X428y4+gSGFPSFHtgF985RESeM7s5ch1I9Alfg/a07oe3BRmPJqUYT5vgsa8grE/Dr5GK84AZ/CIx68FpHw3Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7286
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

Some clocks may exported to linux, while those clocks are not allowed
to configure by Linux. For example:

SYS_CLK1-----
             \
	     --MUX--->MMC1_CLK
             /
SYS_CLK2-----

MMC1 needs set parent, so SYS_CLK1 and SYS_CLK2 are exported to Linux,
then the clk propagation will touch SYS_CLK1 or SYS_CLK2.
So we need bypass the failure for SYS_CLK1 or SYS_CLK2 when enable
the clock of MMC1.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 New. Take Cristian's suggestion

 drivers/clk/clk-scmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 8cbe24789c24..1d809813eabd 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -119,8 +119,14 @@ static int scmi_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *r
 static int scmi_clk_enable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
+	int ret;
+
+	ret = scmi_proto_clk_ops->enable(clk->ph, clk->id, NOT_ATOMIC);
 
-	return scmi_proto_clk_ops->enable(clk->ph, clk->id, NOT_ATOMIC);
+	if (ret == -EACCES && clk->info->state_ctrl_forbidden)
+		return 0;
+
+	return ret;
 }
 
 static void scmi_clk_disable(struct clk_hw *hw)
-- 
2.37.1

