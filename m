Return-Path: <linux-kernel+bounces-32020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE846835564
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBB61C213F4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C245A364B9;
	Sun, 21 Jan 2024 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iw3pEnFY"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC0E364C8;
	Sun, 21 Jan 2024 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705835091; cv=fail; b=IoHyzqbkV7+sVjt5/AR7UvZRUrqrKfMHaX1Ekd9tjvTDVwaNfm8uPaS/BXVguTFKUAKXc955Q0vnu0pQiJE2OF/6v2r+cyWfIvdVF4JiCRID8oEJqUSql2rOerRhKff77Dk4oo9AfDoanMRIZtqheDB8uQzRm4llHIQQEpmQ0TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705835091; c=relaxed/simple;
	bh=2EgvJ6UvBiZiUCF75KkdPRH9vjwUa1Lie4GgjcbZJ1U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MBP5VqVAN+J2LDi4lyH6QYKvSAmMzTrBCZrjfygzT/DLrS/4TgroLUlfTWnvj1zErcne/isUa9E1ZuoeDuSMfZ+OCnK50H6F1Y+LCfUY9gW+YhwOaFhAIZIGi5VXKzjf7/wFrXDkLzRzLGjW9nMRDCY84PQcupdvJZs+uGe75Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iw3pEnFY; arc=fail smtp.client-ip=40.107.105.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2oOMgmV4ObRL5gYI+veXVV5XtOJztmCHrBl2MadwUCZku1vyIH2gnDEx2XzfnTAUJsIaJRs9v0VTXybhYT5LFsunCpIDiQGGY6cp/hoVdrf7pOq8VIAic8vZGRV1kPGr3rpl9dH5t57Oyd+FraC7H/rXf0V7OGM8h5Y96wgi+a8lp2lVfp+UhC5W5hE8O99ZRRxJBTlaZkVLLG+5T+L/kzY/ClHptGplRj6tNbiW0BVBdYZTQw9PHMBvOjtMlCKxepADmwKlOsBnC3Cu1v4y/tPIJ9R+CUk2+6nCnAE8itzjKSETza09h7p0IBVoinswEnJoJdqVa1cOdSuKuF6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFzU6OySMRlrRwRUAicFQf9y7MQZg5t4kTvYVZT4wek=;
 b=BmP76QkqtWdp6hJxb666t0xo2BUqqTGru4mZn/HjeFwmWTGZhvO5ultfRaBBQyZ896AAMM/OrjtvjgTu2/ikCtcPzIXqqso66RUZ86oU4SHNCjehgJCr4Xnh7SgxUipfNHzNBqgm0njLE+7TgFv8zKfuXe3MwSMPNdRgiWDo793Qt6GAvilKNC6oJS/hwI5CVAi8nbOKhe5poeAKtZpA3M0yo9nBRHju4wr9EO7xpvxUrzwX759YcBku05QuBhXYL85PZQPsuf2Z/H8CTmM+1n3abE0FxnAMUjF6BjFIoF+QnK9nkJkLjl4Qf+sBt7ZG1Yv3meOLV/GqC18wH2drUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFzU6OySMRlrRwRUAicFQf9y7MQZg5t4kTvYVZT4wek=;
 b=iw3pEnFYrJrg7poZExBsVAKLWs5o2jvSUZgmyOit5mp6ye8Syftof9Ln5ouZ1Zo0ET8J4h1RSHlvqynXYelFtjFCW4jp7JuQUMlqeVFJLK4Uu9qYZ1JCsG0SwRCpIIA+7qH6lbngAlWMHSsRQiw6ePywKmdKiwSGB1Uwp1hxsUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAWPR04MB9911.eurprd04.prod.outlook.com (2603:10a6:102:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.29; Sun, 21 Jan
 2024 11:04:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.028; Sun, 21 Jan 2024
 11:04:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 1/2] firmware: arm_scmi: Implement Clock get permissions
Date: Sun, 21 Jan 2024 19:09:00 +0800
Message-Id: <20240121110901.1414856-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
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
X-MS-Office365-Filtering-Correlation-Id: 88b0d7e3-a7de-4b40-fcbf-08dc1a70c6ca
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sER1gpuTaTc3SJ0En46Axn2gF5foO8cN51+NfjvZRYdyM/9dXZ+LTgorSFTIBlVv6E5yvTu1bvxPIR/v4OgcBBNDdeUxcQ+YYnPCzEQtiC4OEBW7PM819+YLF393QSrtYQP8shcj8PLH5Vgqifb9gDx9t8RzipdkyX21PA4pGVrrfheHs8kDIKXJL3U4hjj50azPTqSGMcJl1STuj8GPSJoU8kiLfX3Hq7ctXSgBOnMjUSAcCu83rHZMzg5DBmDfOQ4U7einNzAfIbIc/8zOmITFVwPdR9xuRxhVFoufJQGJKXqPU4P2HMezNbAtvtLonahSv1F/VvTxK6bLhabd0yFHDuSdGh9uoPYk2TryNiMfg1zlUe5ZLX1KVhKKiKDn4bMXiM1pexFQFZAfpxs3i3Ofj4RlgL+33BNiQ3cyZWvWRIt21RpD3Y5utqXsmyI5AsLA9nY/YCcW3CbvzcMkqoxCxclrunpwNGCTcmVnaZIIQTu2XN4zwOAsSBJPeKNeJJ0mgvgyn0pqSsRoG5Lare2Z9/bP+HBT8Ve8AVmEdhSi3bqx7ECe1SydGbVRzLCWJBSnz53x1DngkoMEZ8HXVRPBu8CfORjqV/ky7u5EmmAOHJ778xSJwMBU6GBAbopdEvDngFTNvlKu2h8ybrK/Tw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6512007)(6506007)(1076003)(26005)(52116002)(2616005)(6666004)(86362001)(38100700002)(38350700005)(41300700001)(8936002)(8676002)(966005)(4326008)(6486002)(2906002)(83380400001)(5660300002)(478600001)(316002)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nghsUtV/GffkRJ5/2GMdM9NWvhsAuFgpR5lJK39eaH4LwBq49H9Jb72t9T2w?=
 =?us-ascii?Q?45/fWM9jPo+AbpC3HbcVQE0EFAKe3g6iVMpItl4C6LtdB+XXPLmU9IYKV6ll?=
 =?us-ascii?Q?Dd2c/m5Alfwxkj5Sxs7BBU0c+V+/8G996Zrbs7bEScU8fWVnaNWvFR2cO+1O?=
 =?us-ascii?Q?rh5V2dd4CVojry+EwW3NyaWl0Y8+kLC2DB8eVTCLL+8jYUHx8PVN/T72IxXf?=
 =?us-ascii?Q?oEZW2s8+xUoDzbJtU1UzbfCjuRNtNAJN2WnAPJ8X9lr6rPEFFZ1a8jdvqsDB?=
 =?us-ascii?Q?18LuRTMCHD0+MZkCpv0FKD4C3hk+LujNGt4LhZFlRCmlQtfBakzGRY7DMBn1?=
 =?us-ascii?Q?JWe64HyVD9fA2/wqZQiwM87hfAhngrbRLupF1Nt3rw7gxc7WLUQS1zDHAM4d?=
 =?us-ascii?Q?u3s3S4BXL6uDbyIfXg+tYf+cuuEGjDaM1eyzrfcFs764nPGOmkc1UceilHND?=
 =?us-ascii?Q?svieMgC7N4Xih8s1Y3/A3StvNEk9PiVnFNHfPy2En+Gh9cGyc3aLjq/zBGuK?=
 =?us-ascii?Q?8n3sWCMLto4n6B1Mg/WIg2D+9Os1opvdM8s1pNqZd8IbIVxx+Oo5Xh8VoNl7?=
 =?us-ascii?Q?SUgusQOWWRiNdyvTdY1jNQvSZWsOivg0XVdDQLmK31j7apGeYKPlLuftxB4L?=
 =?us-ascii?Q?+mE7N4rneveg05Aa4ZRWBF544lgH6mw21ZOY5n8ZsmCbeY1+Sjkj+WFcBR+c?=
 =?us-ascii?Q?RECYxj8uT/GCAQQbwfgJUB5oBi8dLNPMm8wdHg0t3TYetWTcVZjv0gYm9CqF?=
 =?us-ascii?Q?moRgUgCBoUP3XZLLQCF8d3zy/8IiB5amnwXbpLhxWqxnKKn2q/mEPEXH9Qyq?=
 =?us-ascii?Q?yAhWI9czoBq351fJ/wEPFWM30FLd3DkqOWHhNc9aOGDhvaGjXX+dK1X9ahNP?=
 =?us-ascii?Q?iTFMTM8WYaaYBWN7OH1CQ9x61mNEmXsBkI0DjDvZ5ISGbjkv1PaxupI+VAaU?=
 =?us-ascii?Q?6bQbr+fc/rEvJOJ2qXAdZnJKTAh31uHct/hLr3YsdBMTb31Meq7Iti8rszEG?=
 =?us-ascii?Q?iPXiAAn7t794vo84KAWoTf3FL6+QE2rxmWQrtEocZpK3XBkTz9Hqs59UA8VF?=
 =?us-ascii?Q?EDDLo0GRZilZfrhg8X7QyNhhg99l8Z9o1iPgOSe04af+gc46nv7mI4EYpuAy?=
 =?us-ascii?Q?fE+Or0AaeD54mu2LXkqdjL1Iqrs1k/oHTzkofulCVWNJEx5aqcV9cHrQ8R+k?=
 =?us-ascii?Q?8vdIXOiOBLlSe492Y/nwyreLbsoZIKnQgSsJWI4rHVqZNyaqZ8gor22UMoqo?=
 =?us-ascii?Q?A+WJNE766MgaOSIXe2wUZjxLxmkv//bg8kL9YcQghc1Z47+AiZVn4cfnkUVX?=
 =?us-ascii?Q?bLZxSRoc2is33dsV/daieRoqNK0Uaz6uLVk+0wFRvg61FbodKPhbJg3lrkw4?=
 =?us-ascii?Q?z0C/w+JKtxHTEZHwn6D4WvvU69dJjMWBYnjpOgeOsjD4aDNjOQezZceDXXJl?=
 =?us-ascii?Q?vmCZLHkIDwrlturyLMFOrxid1Kx55iJ72WNKbv4Vfuy6AphRoT5EeIQuwz8P?=
 =?us-ascii?Q?7o6qT2jMe3i+QTf8MbJ24PXY/IC95vP4bpPUNHjc3VOWoUlzvhs60B273rwz?=
 =?us-ascii?Q?b+Q5PfxJlGOP+dYC5vPtKp+54nZt0wLHXNo954f9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b0d7e3-a7de-4b40-fcbf-08dc1a70c6ca
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 11:04:45.8740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WxUa49YboCcqTckAlwy+k9qpWL9AT51OqEVAF3cuBN2Oe578jVnzi7iVlQVXlto7CzKrZctaJnJ6GeoxNuFag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9911

From: Peng Fan <peng.fan@nxp.com>

ARM SCMI Spec 3.2 introduces Clock Get Permission command. This patch
is to add the support. Add three bool entries to scmi_clock_info to
indicate the operation is forbidden or not. If the CLOCK_GET_PERMISSIONS
command is not supported, the three bool variables will default
set to false, otherwise they will be set according to the return result
of CLOCK_GET_PERMISSIONS.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V4:
 Add R-b

V3:
 Rebased on https://lore.kernel.org/linux-arm-kernel/20240110120916.2482603-1-cristian.marussi@arm.com/
 Drop attribute which is no needed
 Use scmi_clock_domain_lookup
 Update patch subject

V2:
 Take Cristian's suggestion, https://lore.kernel.org/all/ZWiqqfQ73tezFmSk@pluto/

 drivers/firmware/arm_scmi/clock.c | 64 +++++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h     |  3 ++
 2 files changed, 67 insertions(+)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 2e4d6479a639..959e48aba1b5 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -28,8 +28,13 @@ enum scmi_clock_protocol_cmd {
 	CLOCK_POSSIBLE_PARENTS_GET = 0xC,
 	CLOCK_PARENT_SET = 0xD,
 	CLOCK_PARENT_GET = 0xE,
+	CLOCK_GET_PERMISSIONS = 0xF,
 };
 
+#define CLOCK_STATE_CONTROL_ALLOWED	BIT(31)
+#define CLOCK_PARENT_CONTROL_ALLOWED	BIT(30)
+#define CLOCK_RATE_CONTROL_ALLOWED	BIT(29)
+
 enum clk_state {
 	CLK_STATE_DISABLE,
 	CLK_STATE_ENABLE,
@@ -49,6 +54,7 @@ struct scmi_msg_resp_clock_attributes {
 #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
 #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
 #define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
+#define SUPPORTS_GET_PERMISSIONS(x)		((x) & BIT(1))
 	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 	__le32 clock_enable_latency;
 };
@@ -293,6 +299,35 @@ static int scmi_clock_possible_parents(const struct scmi_protocol_handle *ph, u3
 	return ret;
 }
 
+static int
+scmi_clock_get_permissions(const struct scmi_protocol_handle *ph, u32 clk_id,
+			   struct scmi_clock_info *clk)
+{
+	struct scmi_xfer *t;
+	u32 perm;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, CLOCK_GET_PERMISSIONS,
+				      sizeof(clk_id), sizeof(perm), &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(clk_id, t->tx.buf);
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		perm = get_unaligned_le32(t->rx.buf);
+
+		clk->state_ctrl_forbidden = !(perm & CLOCK_STATE_CONTROL_ALLOWED);
+		clk->rate_ctrl_forbidden = !(perm & CLOCK_RATE_CONTROL_ALLOWED);
+		clk->parent_ctrl_forbidden = !(perm & CLOCK_PARENT_CONTROL_ALLOWED);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
 static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 				     u32 clk_id, struct scmi_clock_info *clk,
 				     u32 version)
@@ -339,6 +374,8 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 			clk->rate_change_requested_notifications = true;
 		if (SUPPORTS_PARENT_CLOCK(attributes))
 			scmi_clock_possible_parents(ph, clk_id, clk);
+		if (SUPPORTS_GET_PERMISSIONS(attributes))
+			scmi_clock_get_permissions(ph, clk_id, clk);
 	}
 
 	return ret;
@@ -511,6 +548,14 @@ static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
 	struct scmi_xfer *t;
 	struct scmi_clock_set_rate *cfg;
 	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk;
+
+	clk = scmi_clock_domain_lookup(ci, clk_id);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	if (clk->rate_ctrl_forbidden)
+		return -EACCES;
 
 	ret = ph->xops->xfer_get_init(ph, CLOCK_RATE_SET, sizeof(*cfg), 0, &t);
 	if (ret)
@@ -596,6 +641,9 @@ scmi_clock_set_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
 	if (parent_id >= clk->num_parents)
 		return -EINVAL;
 
+	if (clk->parent_ctrl_forbidden)
+		return -EACCES;
+
 	ret = ph->xops->xfer_get_init(ph, CLOCK_PARENT_SET,
 				      sizeof(*cfg), 0, &t);
 	if (ret)
@@ -679,6 +727,14 @@ static int scmi_clock_enable(const struct scmi_protocol_handle *ph, u32 clk_id,
 			     bool atomic)
 {
 	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk;
+
+	clk = scmi_clock_domain_lookup(ci, clk_id);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	if (clk->state_ctrl_forbidden)
+		return -EACCES;
 
 	return ci->clock_config_set(ph, clk_id, CLK_STATE_ENABLE,
 				    NULL_OEM_TYPE, 0, atomic);
@@ -688,6 +744,14 @@ static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id,
 			      bool atomic)
 {
 	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk;
+
+	clk = scmi_clock_domain_lookup(ci, clk_id);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	if (clk->state_ctrl_forbidden)
+		return -EACCES;
 
 	return ci->clock_config_set(ph, clk_id, CLK_STATE_DISABLE,
 				    NULL_OEM_TYPE, 0, atomic);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 659a8e910bfc..98f8c0a58458 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -47,6 +47,9 @@ struct scmi_clock_info {
 	bool rate_discrete;
 	bool rate_changed_notifications;
 	bool rate_change_requested_notifications;
+	bool state_ctrl_forbidden;
+	bool rate_ctrl_forbidden;
+	bool parent_ctrl_forbidden;
 	union {
 		struct {
 			int num_rates;
-- 
2.37.1


