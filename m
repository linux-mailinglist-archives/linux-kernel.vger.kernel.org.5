Return-Path: <linux-kernel+bounces-108547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A64E880C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F9D1C22721
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4972222338;
	Wed, 20 Mar 2024 07:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="doPrtrAi"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2082.outbound.protection.outlook.com [40.107.241.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE262208B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920055; cv=fail; b=OW7sxiE+hD9zJvcWH+/SfwdTynOLenmW0Pmu7SA9dbba6HmnyUuVQh909t3d0X2i1dArRF3KfDqHwfkNTxeTARbCElEjuSIlvCwAj3gsHAEQxk7eQqmtkoUAvXE/BA6nYXS//MDojEOa5NVA7XlBi3c3UA3omeUZcFj+ehTNtKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920055; c=relaxed/simple;
	bh=WY7mIU9YtsSl9roUgukGjb3lFUJIKHCeAVbk70ClbJY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IxUjGhq0rn0iYiveBU+3ODEBusjlMyxHNJTsJmVMUbKbFVxeT6nv1iHEQUrgRSlryoJYgpjJxdRTjkjKRBddjQLwRYJlNDA1yLXCWLOPxOaV7iSPCDpz5WqQuYOqxt94GyTe8h62AjKG1PwY4KdPg/ii8da/hA4v1rz1BHHf9j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=doPrtrAi; arc=fail smtp.client-ip=40.107.241.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS48Df6ky6zXfaTQXTahQVnZP+3GYbSMSb9gN82F0YA0X/UwgyqnIBU3Qu2G6zJdoW99P+NFVS+2ntJUUidPAa4Lis81flxl85NAXIQD2D4KFRMyQErvTzFmsmC9008+UH7fPZ2oUlKYcUKBij6IGUSja9Xq5wyo9Y6HQSAVwPHYFIFeadbVkrTMRdC2C6yNWlcwMXD5PcYjF8l49S528Xh0wvmTzxKGGUv0ZRyIwPmtkVIFu1AoVsfol0L8f7Q15NOviDtu2ALTSEHEGMPu6UGkkomIRpuf7AeU+ZqeufVMRU9uSwA1Oa3FCsO2osy/uPGuSMM6LXMvWTBPGKsVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEa2Os3lBXfToh4/Rzbn0rgApqcEl7SpEz7tztXzlpY=;
 b=Fr1FtXjbnIJ1692pvzlXD3wwU+uXn0KMYj7Juu1UMfcVywY+7QViHcJJKur82BJH3PUpDUNYMFv+nrpBH2RG2YXPN7W7LiKWac47NcKApAVx/MBRXMU0EoXKXaXMnnMFYyVdZbYml7sEdtge3TjP1TyZN9ViMjg4C3Pc8Xy+AQgLNw1MTY6dhu9VbLVYrlmhuGOI+PRhrbO0c4l/9KMyAdeZpQZtP5NF3HXwzMJ5/XZWDn8TTla2RQMuq/s7Xy7f5OJ54uHz96tluVi7SKRPB0Pm5Yux7bTBQJdXLq6w0wJVuHDys8vwcyRzKWRSNeINtzEEtzedP6I+6CuNTrgbaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEa2Os3lBXfToh4/Rzbn0rgApqcEl7SpEz7tztXzlpY=;
 b=doPrtrAiwuAVsMm8Inrpz9TT5395DcDDeBdwC7EaVUDHGrdyBHfmzFK3EbTCv+ZKD+3FynGhGQwneV74Xd94ICDShdPlFFJy4WXPpZpI06fgGe+lvvF3j0x6p08mbSkmz+X/+O1TyBk1whXjQIUY649slB6fKLNCwFQqe9T0BqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7724.eurprd04.prod.outlook.com (2603:10a6:10:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 07:34:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Wed, 20 Mar 2024
 07:34:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] firmware: arm_scmi: perf: print domain name in error path
Date: Wed, 20 Mar 2024 15:42:13 +0800
Message-Id: <20240320074213.1615888-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: c343ac1b-21a4-499d-9469-08dc48b021e2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9GORvsCN4fpnITEnxdH8oa0bSGRq1SahOyw6Lvw2m9XD8g0odL1PG9bgSRGLRqPBujIVQpzLPwGISw7ieEMlhH3Ri+ncctCc8/E6CtscFEXn58K6klkqQDfs8Y6XGvBWSBP1gcu++AZSVbOOYVQ7wk8JyVpgTnQi5R4Ci22HWkzGz5NcI9r1sSBG7v/EnLVZighBBHnYkf8mmxv+idFol37U1Pazxn4mZOubX1ZdRkI1I+lYb+87YQ4iaThAvTFXqZvA0kXq1W6/mdTgNh0v2yB4TtMffB6VbAXjBi9lqPTTppw9A+FVL/D4hbQFxb//Rr4XxPvCh5mTBWULH4yBhZhpBO76ZeuL1acUk+DxBtgvo4apOtjtcyuNATtuk3kNF51sjhIDJV9mtjNYc2PjOkWj8Ax3c5TPiAkVJmn/HcOtGEFlh9zmtVDZ5oRmPBu2qU1cKazx48jus1yNaOIH2rYYN4wq2vdZWCVAPz8gP/qhMCD89hpPofXwyrLV+Rd3Gs9M6xJurWHf1lgZmYhkvUC+NKD1jQpMws/9DTmPrjoyth8WHQQA7PzLiLPR6NN/3LN4mGfpdOXYA1PgEqSiehr19ahVmwsYlrzafJARElyC2dUQvLL36uMjMEmGFlvA7yOoBp7xSVydlfM9eMfvRkzvQV9JVil2gqpjl/MeAn2qI9z3xiCPZ6C54gMtw5N2ZU1d7PxUYIoo+Xsi51ZxuoqgXMcBkw8YjCo+tMjiE9o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cLh2idBxTLcKyvQjz+ThmEplwmfHpkVg3h2haRl32SK8f15x3Hsi4JgnKGpo?=
 =?us-ascii?Q?zJs1VOEow7uxCf/et1YTzY0M/NshAax1CG51ekmrGNCbZRwkOJulOJRfiTTS?=
 =?us-ascii?Q?CmFwYjuY4Ep97ncV7qM6cH29qJk+NK2QNUhtk8cUkVv+o0/HbKBglGo66BbP?=
 =?us-ascii?Q?M197lOAJbWi6OpXoaWMYEkrypUq2Wa0ADEp57FVrychiYHCGlUER08XIRxgs?=
 =?us-ascii?Q?nrQicvuekrEc9lT/owVR62cUvtZGM6MIIFIg71y5nufyA9wwE87G2bjIuia5?=
 =?us-ascii?Q?XFJK5Sr/aimpxpCx3Oj4ugR7aJuo1JlTERP4o2OIthfw6tjuBPs9F/pp4RxO?=
 =?us-ascii?Q?7f9NFdc5kEX0clu/k3f3tFWjnSvaRx40+Bfu2cD2kDl0AANPGZTTrEIMr8GI?=
 =?us-ascii?Q?ejZq/QuC/53vPzjv5VL4VJDbhGwkT3f3McUVJbHYyY/YT+lbw1yeHR+oDfAx?=
 =?us-ascii?Q?a+On99vCgf+rL7Jy/D1anevvzisweFBwXekViOc11+0n9OYhsF6sYiwHHkCG?=
 =?us-ascii?Q?OhYIm0VMmk1ipt381uctGi9dUrmMm+sZu5556FNBq3i3+8VMa/s1CIWNrtes?=
 =?us-ascii?Q?yFJ4Ls7ptOQ5Lw0nfdxmP749Bpppgg92590d0rfXkHB17onhJR9GOYLfy4Dh?=
 =?us-ascii?Q?fb0fGg37f4FV9dbiDCRfHHNdsyRCUeMfVfZktpc+mWZtr61OdPEVhlyb8txh?=
 =?us-ascii?Q?Z12JHg4qKyk0cE0szAC74qeeW5bF5/l8/oaI5JPd/k34W4Rq3emKOQrAHmm6?=
 =?us-ascii?Q?FKnaHJI8lrMEzVpu84GUOloKNEuLZjjeqM/oIc2/3MgJ5ukoVeQ3JXNcVtWI?=
 =?us-ascii?Q?b5l5+N5tyXIP/O8F0kPJTBJQZYtJlGVH3mjs/kqL8Dl6klgrHMoY0ds0e3y4?=
 =?us-ascii?Q?UunGsM7Q0YZKgGxhxcb0ias9h7HBA01qNbwGFCjSxEU96HMG99NTd+DfsBJL?=
 =?us-ascii?Q?DBjP5d1+561o9rd36g6jL6g9VbtPHO5uvQCTis22hVTQZ2zyfrgU+aPr1I6h?=
 =?us-ascii?Q?yH9D5uAYV3pxNkZq0jDXpErZlA4eG43baSW7Kq6GnYiW+DAe6ez3Rfq+sjkj?=
 =?us-ascii?Q?Y27ouTIZx5KSFOTlCrO2EgcoUse3x2B8u7BylX+RMBN9tSy07d8/T70KJBB4?=
 =?us-ascii?Q?U75EZkaYfsOfc8vnez61OBcH2TS81yHg4ypRdFkYiqLVQZC5y1UMCM0nY/yH?=
 =?us-ascii?Q?Z3kkHocHxMIAeRmCA010eVfFoXrxr1WUzMe5+Rm/qoLFBw719P5vV3+z/xXY?=
 =?us-ascii?Q?8Scvf1GzpSqjfer904w40fZQ4h2t35GHBopBPRiMttwdKeWNKj9gi+dSN3RA?=
 =?us-ascii?Q?p1ROt7/4Svk3rNXuTOD2OjWW+8KfCA0x9HazWC5vm+gJl+x7fI127tNPF7HY?=
 =?us-ascii?Q?jyPz8kQB/p2wKzUhdOrtRrLsIALitx+IYMpF9ujRiVK0FTz2TPcfVl+G8yc0?=
 =?us-ascii?Q?aziQ4E6gww01Mw0KyiPx2i55M7Y8ihjv0+K00hq9czByKE3wdyRsk0xiVeDX?=
 =?us-ascii?Q?JEN4nopzq5DGADxOVQXO/yoCXXMRncCYQsdQaCBreQK7VJHYcCOVfGYzDCaB?=
 =?us-ascii?Q?vl4UrvOobTGliNm2ed7bbopjQYO745PvtSbUyaa4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c343ac1b-21a4-499d-9469-08dc48b021e2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 07:34:10.1673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fn9ISYZvPTBQOwsgCeXnVjJZ4PT0KwG55orYWG1HovAbY7HYtNonuewoUF/cEuRdochGIgnR9Wr+gY+pKy9AoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7724

From: Peng Fan <peng.fan@nxp.com>

It would be easier to locate the problem if domain name is printed out.
And including a coding style update.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/perf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 345fff167b52..e98ca6d15b0c 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -79,7 +79,7 @@ struct scmi_msg_resp_perf_domain_attributes {
 	__le32 rate_limit_us;
 	__le32 sustained_freq_khz;
 	__le32 sustained_perf_level;
-	    u8 name[SCMI_SHORT_NAME_MAX_SIZE];
+	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 };
 
 struct scmi_msg_perf_describe_levels {
@@ -387,8 +387,8 @@ process_response_opp(struct device *dev, struct perf_dom_info *dom,
 
 	ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
 	if (ret)
-		dev_warn(dev, "Failed to add opps_by_lvl at %d - ret:%d\n",
-			 opp->perf, ret);
+		dev_warn(dev, "Failed to add opps_by_lvl at %d for %s- ret:%d\n",
+			 opp->perf, dom->info.name, ret);
 }
 
 static inline void
@@ -405,8 +405,8 @@ process_response_opp_v4(struct device *dev, struct perf_dom_info *dom,
 
 	ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
 	if (ret)
-		dev_warn(dev, "Failed to add opps_by_lvl at %d - ret:%d\n",
-			 opp->perf, ret);
+		dev_warn(dev, "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
+			 opp->perf, dom->info.name, ret);
 
 	/* Note that PERF v4 reports always five 32-bit words */
 	opp->indicative_freq = le32_to_cpu(r->opp[loop_idx].indicative_freq);
-- 
2.37.1


