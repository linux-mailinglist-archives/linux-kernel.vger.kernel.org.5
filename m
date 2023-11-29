Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143057FD0A6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjK2IZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK2IZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:25:34 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0599319B0;
        Wed, 29 Nov 2023 00:25:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsq4cU1Bwl8YRw2FLj4IMXWZ6ZMK21V1HU0pYxHCBhV8DW6zfKSiqUESVYrYCR8yZlwXBtZONQ4E7DHIrmEOQUQyjbvmxqhV3fvxMKwUv9p2Md0SU92IgcL0Ft/Qf9bsShOb4tCeLLr31DXPG2Z2bzG1KSTXUiUnW/gaoKXeaCuhHVZ4qWYoh0XyZIhYLnI6K41L07DUqK9uh74tFif5WyAYy+ffk/1J+sYtOZ3YLSRjqL2t4it7ux9P98RI2Vr0Me9RIxkaYNW5DJzLGRMxy7lMwH6n0l45Ora1zdKCWDLv2zuega8UIXwRE88tJGoJWgSvMKP/2PUzvAH9bEM+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UV7/tgR+gBCu18hiN+PoPRmFJdt+pzPPC26vW8grSrM=;
 b=kJOC3hs0HiEPK2trLk+Ae4BMX/wSNBKgZuk+OSgepzg7Ly7EGwFw9KM5XP9PLjymjFWNo+WAAdd2lF0NdxKBK29FCs5cld5in6I//NdzACpwF2jKNkgqFHPPBI02RcUYEC5Ow9whuUZWSdInrhpiOnDEco05ZDPo1J9txVzqbf6rY/8Ms1B54blRYXsOXHDG6iy56PRECk5bn2VNkSjKPfVhn/7Q1rJHFfD/sMC7YNfuraKprCrajq6yFf6XfQGlsCFZgLFEJkSlhsWJsbUS92nbVnvz9MrSE113gdB49LkunRabmFELn9a8WrY7O6kZS2jh4cqnNIVMecpsBcs7VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV7/tgR+gBCu18hiN+PoPRmFJdt+pzPPC26vW8grSrM=;
 b=EfaiesOO+DzahHQXX78CJIm59IPGnJb0xzLoTER+BQ122X9SpLYkCZgcgXn/x7b0m3Q3E3WF6Ns/EZNatsJGY1ZXzs0tBV5mF2dyFOY3GX9g6y5RSjilYL/3mJ7cDP9GNIyrqDVPZeCO4EwZkbt+sOse0byVW0X8e3RCZcdt7Bs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB9968.eurprd04.prod.outlook.com (2603:10a6:10:4d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 08:25:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 08:25:34 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, ranjani.vaidyanathan@nxp.com,
        glen.wienecke@nxp.com, nitin.garg_3@nxp.com, chuck.cannon@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] firmware: arm_scmi: clock: implement get permissions
Date:   Wed, 29 Nov 2023 16:29:57 +0800
Message-Id: <20231129082957.1319895-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB9968:EE_
X-MS-Office365-Filtering-Correlation-Id: b8bbafd9-5a66-4d40-69fb-08dbf0b4c21f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UGDns7O53E3IFFfuvZIFcLP5MrElMyTPQ7ShLDBs1Gsw7dd/p7pkPeSVUE8zffalpFbegsnLCjl9n0OvGBCOzuY5JGk/WVHVlgK3xWUHsOuAV+ewH86Bfn2A+rgA6ySOdnGXokz/OK5C2ksGzdu45k/XB8ciqPH0mT7kvNQT5nxbiEKiRFdjj1ePV3XXybRmN9XxoVNguR8D/fEiKeU6ArDUuqoFwNf0WLFSpd7LbaSek0lx/0paDqG6YdVP6k6B4ygYeSWccshhb95/lo5gsEKbjxG3ZgV5yskTe+urQGUukaKPmyjrOmJHHEFYDsPh1v1s2MraOFKE+t4hMDngjdOQr3790kILZDLtte9U+sqYTuhvLBt8Ndd78MHfEaNOhjnk4V2ytX5pePH82nT7nb5jYIvvs+nd8JH54zJiLilJ/vQtybOnGMNXh/DOEll0cl1H4eOnssyzDw1EnghgD79Sm8tQWKTwsvSgn5QiyEx7SmJSyZc5EmsAalLvXMD4BksH7WlcWtq74GcsM/vQJp+jYeQigAnmyegSd1gybxUNyMFXYlb/eF+qpfSoZG8/e7w4SzoLsU6zLOEIWGFc7XwZQ2fffVPBy4rfFBc8HKvndAWS38tTONhvw7Iv2E4j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6666004)(6486002)(478600001)(8676002)(38100700002)(4326008)(8936002)(66946007)(316002)(66476007)(86362001)(1076003)(26005)(41300700001)(2616005)(6506007)(66556008)(83380400001)(52116002)(6512007)(38350700005)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dyjjmg157cwq6zQFkMG9j9FSpveO29JD65HwyjWjoFDE0pqEDid2adpW2fwt?=
 =?us-ascii?Q?XD/eVKqhVxOifFB+q/oNel6cIeBoSqXZS2pVbnknnSmSXTwcavtaXGPZgNEk?=
 =?us-ascii?Q?uDVt6eXawnwEuqGVuMPLrdlCcGCO21n6Z0vrZl2y6+YG/i9OB4HlDGjBoIjw?=
 =?us-ascii?Q?c3Dif8vQB0Pv0wZnBmfHnmdKi4E03vs2ji8dO1ZJJjjHb7CU6v6/cPPalWF7?=
 =?us-ascii?Q?0dfahdaZFOdRT1manvGTJHKJehReE/Yh8xg97C0yoQkIrfJuTi9xumxVYFDa?=
 =?us-ascii?Q?Kuju38JhQ8BaNrb8vvOsEcrfREvqqrmTjShHUxKhef0hwbAfyDhL79xFjfUG?=
 =?us-ascii?Q?WJ1xfTh8woJWZ3o3j09gp4vzwLUUmoHWBhQFiErQ9tfy6V+xuSzDSwbmimjt?=
 =?us-ascii?Q?+DLnyeP2XW3VyDUV2IPnPUdXg4lSqTkYg2bUl3fyj5TH2NR30EwgG7HIxFrT?=
 =?us-ascii?Q?+DM0yQVvOtJDJUf5+0UyRyRih941rY/SAedKXvBQWrwc8Qv7JYobn9b2BbTI?=
 =?us-ascii?Q?b7MDQRrZXLAKCi438t807ZMmEQpQCjC2zvnvp0Fyzyg4mK5/vbs33lATzRNq?=
 =?us-ascii?Q?abQPM2/iEL1N6wzF5DD5OfdDnjPvqDdJ8oZm2VNuXWnuei5NIDBiQlahu7us?=
 =?us-ascii?Q?cUVukRkCsVsRo0vHoZh5NHwasvKPo7P8gN1nOnb0hPNv67dHSYVK7z/PZrfM?=
 =?us-ascii?Q?0xZdJ0D9adBtAhTSY368qtvYIsTgKq5aRiZhK3w9bI9kcHDcO0lDnwkYayK7?=
 =?us-ascii?Q?i8TWHSzUzPULyFRgyFV5msOjYzy3pFqhUfhbj/gk/qMdzP3zgsYDt1YY67rT?=
 =?us-ascii?Q?DWd9aYxptxtCckhpNigFe7V4XOkXqPDBOBrmpKRpwyPStyZZJYqEbeqWJNXm?=
 =?us-ascii?Q?HwF31YkV8H7/1rn7atQKJ0N4JR+aJfm2rUoM6RRF3xMAsSHfewDtdDC4giKy?=
 =?us-ascii?Q?ECuYLGuUZsvYB09Q+21E9gaslS3SeAWgcSBFUnIB1v+RL4MFOTHCDsxR9+v2?=
 =?us-ascii?Q?isbKgTFJT4AwQoD4hHhqOmesHZLECId0Y3a6T7jlV6G12CqEC9nMgimJufNT?=
 =?us-ascii?Q?oGDpB5RCANfEukl8PD8eU4el3rQCGoN9ZMNASEOsejGDedP5KhCEuab8LJKQ?=
 =?us-ascii?Q?VYx+zp4q4o8cggjUc0WWe7JpqnspLnho1A447p0boYd38EFKM3QJOsoEyt8W?=
 =?us-ascii?Q?wBwngymNnBNw57T+4B5z9MU3k3hq6iqyHOCIBnPvXIQiXczZgf4SecMRuBqu?=
 =?us-ascii?Q?6kElh0BfPMrnB2xU3My4aUUoNzwVO0YlSCVB2kO9tpoYKJvLDtzabGJbSrvp?=
 =?us-ascii?Q?RIifxR0/+5VqhmqkQdEtcgzEpvG9TNhT79UgRqdWI3KZaYpn+rl4vwrYuMk1?=
 =?us-ascii?Q?VX81wPCWOkQxmFsabj/+mR5kC4VRdU+zce9vIh9lWdkPO9wLEBU6w9WXNpM9?=
 =?us-ascii?Q?HC/cUEwZZgw3NoWmILTWNF06A3RYgQDVCmmAH2zoVaBKNmeO5ERij+FIx+E8?=
 =?us-ascii?Q?xpzGoPnXcueOKLZuUp2MtKxPjPQ31azns9CFLFUxT9v2f4UB1DiK51bw6k8R?=
 =?us-ascii?Q?AAwFNtRe9Cs3lG/Op4aoNiD63HQlyluS5EfUDa4V?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bbafd9-5a66-4d40-69fb-08dbf0b4c21f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 08:25:34.8874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pELZiETpFDqdvN85xGQp5teJdC+z5vNILeE70i1VMBAmUuV0jdFQyYMTOe2hUJCSiLPBanwpPTdnFdcDH1lvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9968
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

ARM SCMI Spec 3.2 introduces Clock Get Permission command. This patch
is to add the support. For clock enable/disable, directly return zero
if not allow to config. For rate & parent set, directly return -EACCES
if not allow to set.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/clock.c | 51 +++++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h     |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 98511a3aa367..ebc140f2a3c0 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -25,8 +25,13 @@ enum scmi_clock_protocol_cmd {
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
@@ -46,6 +51,7 @@ struct scmi_msg_resp_clock_attributes {
 #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
 #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
 #define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
+#define SUPPORTS_GET_PERMISSIONS(x)		((x) & BIT(1))
 	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 	__le32 clock_enable_latency;
 };
@@ -281,6 +287,29 @@ static int scmi_clock_possible_parents(const struct scmi_protocol_handle *ph, u3
 	return ret;
 }
 
+static int
+scmi_clock_get_permissions(const struct scmi_protocol_handle *ph, u32 clk_id,
+			   struct scmi_clock_info *clk, u32 *perm)
+{
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, CLOCK_GET_PERMISSIONS,
+				      sizeof(clk_id), sizeof(*perm), &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(clk_id, t->tx.buf);
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*perm = get_unaligned_le32(t->rx.buf);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
 static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 				     u32 clk_id, struct scmi_clock_info *clk,
 				     u32 version)
@@ -307,6 +336,7 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 		if (PROTOCOL_REV_MAJOR(version) >= 0x2)
 			latency = le32_to_cpu(attr->clock_enable_latency);
 		clk->enable_latency = latency ? : U32_MAX;
+		clk->attributes = attributes;
 	}
 
 	ph->xops->xfer_put(ph, t);
@@ -327,6 +357,8 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 			clk->rate_change_requested_notifications = true;
 		if (SUPPORTS_PARENT_CLOCK(attributes))
 			scmi_clock_possible_parents(ph, clk_id, clk);
+		if (SUPPORTS_GET_PERMISSIONS(attributes))
+			scmi_clock_get_permissions(ph, clk_id, clk, &clk->perm);
 	}
 
 	return ret;
@@ -499,6 +531,11 @@ static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
 	struct scmi_xfer *t;
 	struct scmi_clock_set_rate *cfg;
 	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk = ci->clk + clk_id;
+
+	if (SUPPORTS_GET_PERMISSIONS(clk->attributes) &&
+	    !(clk->perm & CLOCK_RATE_CONTROL_ALLOWED))
+		return -EACCES;
 
 	ret = ph->xops->xfer_get_init(ph, CLOCK_RATE_SET, sizeof(*cfg), 0, &t);
 	if (ret)
@@ -585,6 +622,10 @@ scmi_clock_set_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
 	if (parent_id >= clk->num_parents)
 		return -EINVAL;
 
+	if (SUPPORTS_GET_PERMISSIONS(clk->attributes) &&
+	    !(clk->perm & CLOCK_PARENT_CONTROL_ALLOWED))
+		return -EACCES;
+
 	ret = ph->xops->xfer_get_init(ph, CLOCK_PARENT_SET,
 				      sizeof(*cfg), 0, &t);
 	if (ret)
@@ -668,6 +709,11 @@ static int scmi_clock_enable(const struct scmi_protocol_handle *ph, u32 clk_id,
 			     bool atomic)
 {
 	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk = ci->clk + clk_id;
+
+	if (SUPPORTS_GET_PERMISSIONS(clk->attributes) &&
+	    !(clk->perm & CLOCK_STATE_CONTROL_ALLOWED))
+		return 0;
 
 	return ci->clock_config_set(ph, clk_id, CLK_STATE_ENABLE,
 				    NULL_OEM_TYPE, 0, atomic);
@@ -677,6 +723,11 @@ static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id,
 			      bool atomic)
 {
 	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk = ci->clk + clk_id;
+
+	if (SUPPORTS_GET_PERMISSIONS(clk->attributes) &&
+	    !(clk->perm & CLOCK_STATE_CONTROL_ALLOWED))
+		return 0;
 
 	return ci->clock_config_set(ph, clk_id, CLK_STATE_DISABLE,
 				    NULL_OEM_TYPE, 0, atomic);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index f2f05fb42d28..88703b0ce961 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -60,6 +60,8 @@ struct scmi_clock_info {
 	};
 	int num_parents;
 	u32 *parents;
+	u32 attributes;
+	u32 perm;
 };
 
 enum scmi_power_scale {
-- 
2.37.1

