Return-Path: <linux-kernel+bounces-32021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AB8835566
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7F6FB219C5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B029C364DB;
	Sun, 21 Jan 2024 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WoTEfG89"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163B1364D5;
	Sun, 21 Jan 2024 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705835093; cv=fail; b=vB6QQVnZ8AZSO0TJz1QfCIHWp/mvir18i3I7AP1JPdN3Z3AuDZzxEuBgBiuswtu7oopkE6Bt8TKDgcVDOk7W/eE69JWMp2cDU6wV6Wv0MwNc4mHB+BY1wYra5UDNUL2cRSzOEFXQds7G/R7aNpX213BESatJOsUHWDaZmaL3KQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705835093; c=relaxed/simple;
	bh=EnAccMmy/PJxRgjnRs04VVqr9UtCQKk1HP4iRXf14eQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oDgBr1LFfifyujdgk8hqc/CcAj+3bJDWhlvs44cFrgQLeOzwy3LTkVRkcxqhdX+FCx49Apt7gX1jSKceXm+iY50W+drKwgb6MfdHDNXzp2JjWcofsjndbvmz/Jc9HC149Ypt999Hz1HFDUEAWA5/SMZDKFZBl1yHCsnBaErThsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WoTEfG89; arc=fail smtp.client-ip=40.107.105.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEx1euzvSI7TEjizq4KskorMt5p1t3jHsnhBqw1h1xoajLAioTPfa7WYQIx+bhRMpSj19RUymydZKMS3J6wwAlINTA+Atb8hnSRP9UbPNw3bRLNaSLewX0K9HdontpfLsOgxgkgl9PCIrInTz/g9m9lbaAiSWmtULXPfDoNcV2UixkBPOBENOp4K81QcQeI0/vFHCLzPPCF3aXOQergzwcVcDengA9QQWKRJGa7dUP5UUTFWLcQTZvdO8Fe8O59SszRiC7IVRtuKkW1fxl5yPVIPPCq3krM8vGdYEoMrf8OSUBei5w6Jhsc+UYoPNO6/P/UORiv//g4yAZXrkhuBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAVSOFSF74EDgvKovu6zkzevBG9jq9JEIL0kBjCKxTI=;
 b=MleQvwMgEH32KRflEWpud2YQdisVETdl0z4Pei9vwxxENVu2JqiBtndQOY+2QzNesySnLe15RqBu/rwijDvhqnB9bC4YYZ19N+RvOoSsZ0kX/g85Ouv7rJ8mrLHTwjWQpED8BqX99FPO5moCP68bqgDU2TPFNPN7fNfR2bpQlgxbUiSddZhDyK1HmxKsb9rdYKgwRbog8Jpoa+qKWOJp3iXJYfHPTbrHPZEzF56ERISuXj10EICaOJQCN8pNbY3/jajfZ7M4KbJPAfHL0P/RRrT2CanaBYtcJVAO/HYhp5QVvan83DbNZ4mJdoTI8jRzr3kkqTY54ZFhCeDEVrxU4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAVSOFSF74EDgvKovu6zkzevBG9jq9JEIL0kBjCKxTI=;
 b=WoTEfG89F3j0hQIgB+D1CRIBbtgj4+56T2f5HzZgLEGqy2dit9pyCO8iW5WbNskBTHz3ycD9OlTbYjbfqCvaNdrmrPpCV8ymq5zN29q+0587b5hic5PAcvqYgmI6FUVKGdndFQskc9cGItHVoKk5IoOxRV6xv7EIPAJ1elSE1yo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAWPR04MB9911.eurprd04.prod.outlook.com (2603:10a6:102:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.29; Sun, 21 Jan
 2024 11:04:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.028; Sun, 21 Jan 2024
 11:04:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 2/2] clk: scmi: support state_ctrl_forbidden
Date: Sun, 21 Jan 2024 19:09:01 +0800
Message-Id: <20240121110901.1414856-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240121110901.1414856-1-peng.fan@oss.nxp.com>
References: <20240121110901.1414856-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAWPR04MB9911:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b8f975-bf79-44b3-4c68-08dc1a70c8fb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cLfiIwS6/tlDffF6T9lTiQ963dzWhYWqaiSMyJXupYBgaJIqJ6496jKgVouXkG9E/UWttlczGy5i3s08HUTEc+UWEIWSjeuLWSx8lcvnQVIoKH2ktcaQRLS5eEMkzOddKnyzqPhiBZ3An0fUGq52lL8OYr1GsRUHyA3xt2G2zz6hqybArieJFKjQvBFyWAJIkuQ+WroescGqPWUBiHas0fj4PB4yG88yF4QEYGUIBFij3i67gcPW/bDdHwSVs9ucBJFg9+kG6VfMW0rUfknJqFPt/TCV1HJ2vmAZwmEWAfkp3H6PBCJ09EO6GPk0ClFjjf4ME9NcGdAz1ut7Wndx0V58C8FjF7cmBIeTwBjDGSuyYyu9RHI3n3bjC0YELE9qzJOUf9qI9Jb1y+7J7TCM7rjBT3XvQDocutL/gewrsX/RxRp83jhTfKzt6DxJHlThg41LWF45VmRl+++wSqNqis/j+uo97WDXTa92hdnhD3v25sLEv63GihfS4worv7EoTOV+fco/ElzUsJ+8HR2VnyAw5sBgvKKia1pw4AzkQflFK06LEn5ye3sdN5TkWUX/Ycen50E9iYE5/0hCWkmlyN8LyTqlfl/PS1leF6+gJhx1MEIGrjwqZDePBJxXiKMGeBVacEFB5DUYDiB9vPIjGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6512007)(6506007)(1076003)(26005)(52116002)(2616005)(6666004)(86362001)(38100700002)(38350700005)(41300700001)(8936002)(8676002)(4326008)(6486002)(2906002)(83380400001)(5660300002)(478600001)(316002)(66556008)(66946007)(66476007)(21443003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gs+xaXSChVHHqWkjr7/THz25znQxgkYiMc9itTtLDWtCQrOm5lU6IHE/YxOm?=
 =?us-ascii?Q?zQC8s57QL/vR9CHareCPE57ZNIvBudJTTiN2T37QSmwcDWM968lmVlTZnPyv?=
 =?us-ascii?Q?GYGdg87bVXbrpI1eNSxnt+y8cQ8NKJwBe8FEHxsxh1n2GzVGTYTv69F8fTxW?=
 =?us-ascii?Q?hHVO2sXG5mqJEW6MqMN4bTcNm/keB/VAebyTgIAX+UilT96I4qdivgJU76pz?=
 =?us-ascii?Q?AhSh5ZwMnwpz0fFXR4Kb4lNr3bx9i3RDxcNFsh8p7Smp+AnExwaQ8ICd8GLj?=
 =?us-ascii?Q?+X9UO9eYzXCXvBWdhAY2zS8qEWKFpjHV5Rpn/Bc1CyEs2t7LelQm2D5Tlz7+?=
 =?us-ascii?Q?84l1d21sTK0kxru3rf0FH92gdv1BfsUUF7jn0Q3lf+e6ICBrBUkVYhC94LIN?=
 =?us-ascii?Q?ggRJeATa970WamgWE2H1+0y8arjBEhIPI9mN5sskC3t58r9uhaUuC8DEf9ub?=
 =?us-ascii?Q?qkF15pUgk0uQx1YGveCzRbpK0du9IPfucHpf8v+KmMfYbsaNK01njnWVaTM7?=
 =?us-ascii?Q?OxERmuEWaYpaHhm4oEXgUgP9sHjljBHhmG4RYbWm44SfDlMB6HeLi/h8W6kB?=
 =?us-ascii?Q?97CRPS0XpHT0j7iyTYy6hoWybKCknCVMTy0KKxR9vzbBRzyjcugOojJs3CHP?=
 =?us-ascii?Q?3Gd6uVAH3FsE07eT9LV9kloa4G46oTuoM1ivqPL4T4r44eoLK51zRvquKVBo?=
 =?us-ascii?Q?dkphifHvsJrpTd3FExt+fo58Tgmxo6WZvPoNGZELinsnQIQF0EM4ps8QPf+u?=
 =?us-ascii?Q?9dXtWQVdFIXecL+kVzAuyJDcfAIlDg1pawvCPD8kC208c8vDoBIADHgAMDPb?=
 =?us-ascii?Q?BOTT+e184YwR6PyeiR3gDagqBXjYwrVmECrsJl4BImrX9AxXj+5y2J2Q4FBH?=
 =?us-ascii?Q?0qapHoqDcPwbZgegmUs/Tm/jSxgTARzglWiNojj2/hSABn0Mt+D+rmBFPOxB?=
 =?us-ascii?Q?9oyUHUi4YJ1Cm3HF9YBH8rAPrRwHTTTurb5viZbGZvTnC2/WOHF9IFSGAe7Q?=
 =?us-ascii?Q?M8sEqEZPY7UAhgf8oiYI9ttwPvozl5q5eyH33mUcMYJ5Wgd/e7FEScjOVj0W?=
 =?us-ascii?Q?nFyZv5EUFr6F2LFia1QnavaDCoPN8kdoHk0I09fiLpP8OaBIBWiGIpbx1Xwf?=
 =?us-ascii?Q?HqD+kKJoZ6D4aleuY/i8TFMhBj5AEgpD41sqPubHih7RYc9/ZE5cmgeoAHnk?=
 =?us-ascii?Q?ZpmLGnfstyppalCrwMmYm71AAY6PAIF9zS2z6Z6zoKDfw3/wkQlHd6O18Sd7?=
 =?us-ascii?Q?R9V/s2WH0kYgUgh6pyKueX9S8stGpNqzexIkSgvr3/ypXsJ0aH8ycobDcM3y?=
 =?us-ascii?Q?4ZR300xM3Acyto3Ye5o1XFUg0zdFLE/13ZvsLSybrBDTEkEkPPv45Dpa/n3a?=
 =?us-ascii?Q?tCYnMWmP98ZrmWObZXHNt1NfD+I0exVb4vUZm6JNWtJQMMEO6kRmeW7IyZ7X?=
 =?us-ascii?Q?3M2ZzKvgfMeWdZssQ5/tu/5z5HtF4CR06r37GAjAhhiqIsJwwrhn9VWuw3P5?=
 =?us-ascii?Q?vEwPBpSHdinGdrvV3lgsDqA3G9gEGdhUR7qpRbqYm4yvgQkHgOD4YvDj6xxP?=
 =?us-ascii?Q?5Us4XRSv2xaTRXyRfClhfz1eHxGTPDIAjIEcDKwn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b8f975-bf79-44b3-4c68-08dc1a70c8fb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 11:04:49.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFeymK1LOabSkZWGs5gch9gYpN7n8d4l0P83BSDa0mOzdnggH/Ixd48HSbMhuO+Lf1aHPI87YjjcGta4mYLZ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9911

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
the clock of MMC1, adding scmi_no_state_ctrl_clk_ops to use software
enable counter, while not calling scmi api.

Co-developed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V4:
 Add scmi_no_state_ctrl_clk_ops per Cristian
 Add Cristian's tag

V3:
 Add check in atomic enable

V2:
 New. Take Cristian's suggestion

 drivers/clk/clk-scmi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 8cbe24789c24..5747b6d651f0 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -194,6 +194,15 @@ static const struct clk_ops scmi_atomic_clk_ops = {
 	.determine_rate = scmi_clk_determine_rate,
 };
 
+static const struct clk_ops scmi_no_state_ctrl_clk_ops = {
+	.recalc_rate = scmi_clk_recalc_rate,
+	.round_rate = scmi_clk_round_rate,
+	.set_rate = scmi_clk_set_rate,
+	.set_parent = scmi_clk_set_parent,
+	.get_parent = scmi_clk_get_parent,
+	.determine_rate = scmi_clk_determine_rate,
+};
+
 static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
 			     const struct clk_ops *scmi_ops)
 {
@@ -290,8 +299,10 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		 * specify (or support) an enable_latency associated with a
 		 * clock, we default to use atomic operations mode.
 		 */
-		if (is_atomic &&
-		    sclk->info->enable_latency <= atomic_threshold)
+		if (sclk->info->state_ctrl_forbidden)
+			scmi_ops = &scmi_no_state_ctrl_clk_ops;
+		else if (is_atomic &&
+			 sclk->info->enable_latency <= atomic_threshold)
 			scmi_ops = &scmi_atomic_clk_ops;
 		else
 			scmi_ops = &scmi_clk_ops;
-- 
2.37.1


