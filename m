Return-Path: <linux-kernel+bounces-96354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2021D875AE4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C072B22819
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EDC3D965;
	Thu,  7 Mar 2024 23:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="WJwRndHN"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2130.outbound.protection.outlook.com [40.107.243.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8550843AC4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709853009; cv=fail; b=F37jiZiuU5HQTGn74Z6zCQvxulJUPg/QHafaw1J8PRcMky+bR8qUiKD0ctXH8PLo0OlP+rmJs5FcRtMbRzakRisZjDhU6Tl7aKYropgVXp8czijwp8DgVhv2eE7Ao2WUhNQsw98vyoPXlMh4/auo12FH7NiGhUbasid+4o078KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709853009; c=relaxed/simple;
	bh=79lWWl58juwqwx779ZYQruEb7kptpHx1GoxF8spvYKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HAy48Rc7cFyh34HBqukbJ/Ov6L9QUZmyKsk9omu030Emu5GNwkSS/NyyEju+rRVRTKeZQf0YVLKkmu7Vy9E+xiH8g38BglHKQJHBSLo8mQKYsiSU2ufqQMmUYeT++xp/2eTwT7NrneZF9Jy+9JEKlcocMy0QuQfYlxJrz/+m6k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=WJwRndHN; arc=fail smtp.client-ip=40.107.243.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+yhcpa0v7wGPpPoxfhxvXRnUQh1FNNQU93zKHepp8ItqmomFbI+u1rpJJHgy02osVsTnX9/SKh18N7hU9RRny/PtEN+EOJK8A2/OMN7mGLmyhhD6q1kR2F7XyaJvxFc4E5zseJLP1kol9neBzhKFyUyx3IHGbfVyr82aojMUW010G0tjDlUBnSxZxIA6xPYdXM0JgCaNLyknAeeIWfIyMb5ibA/SqQWJ23VkR+Zb7sPWgiAKNgZ0ss83kTDlVPu4ZyyuJmNE6rLqrMNkFA9tGum5Pcwm+ouWjV42aLmitO+gPw8hBkU2I4bjEMR0Hyn9O7I9e+07a36C4Nw6txSTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yz9PQEvFfwG6wVXiBGYiS73jbjIkADRgYDz8OtJmYoM=;
 b=jOqIdda4OrQbWTsjSQuoETlAcjxKgnRguKiVDltYWqeL9pmitnitw+qk6yUGdR42sFIxkp56vsYGwLFzPzUXbL+vYX2wf/EVWGHjwO0bDZDMH1CAV584R4+lfHV+uuU7beEYp26S8W+ToHYmZm5pJ1xkmCBXiW8N8jY+t9IAEtLK5qJSdjdSNaW03IY2XR4u2CXUIKYcArUeDmfzj+BDuDbt+h0/X+vH8uI6FWnYd6mslLhnZXZ/jFm7v/og3KYtAg0HZSH1LRlLwG+yN6vRWhH1UH3wK7p+Y9LWfhDdO6Nu1SUkQAtXCdImOhOgYZTfJ8m8IqH+oNc03DlG8BVy6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yz9PQEvFfwG6wVXiBGYiS73jbjIkADRgYDz8OtJmYoM=;
 b=WJwRndHNBEaiJz6AA0tyhCvYvzrrGisVqZo7PsOwSBH3L9WuBq4nki7hQhrPG8o+nmGrtljFiIEHtt8WspBvPOGM+XwigNo2tg632ACKZunrUrxRHvUuAAfe9e5qncG54cZ+dnUWsV5ZTpMg4DHy3wGoG+Hxdf54mnxdxKegswg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL0PR01MB4226.prod.exchangelabs.com (2603:10b6:208:49::30) by
 BL3PR01MB7116.prod.exchangelabs.com (2603:10b6:208:33b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.27; Thu, 7 Mar 2024 23:10:05 +0000
Received: from BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26]) by BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 23:10:05 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] perf/arm-cmn: Enable support for tertiary match group
Date: Thu,  7 Mar 2024 15:09:29 -0800
Message-ID: <20240307230929.6233-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307230929.6233-1-ilkka@os.amperecomputing.com>
References: <20240307230929.6233-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:610:b2::32) To BL0PR01MB4226.prod.exchangelabs.com
 (2603:10b6:208:49::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4226:EE_|BL3PR01MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb123db-7ca0-4f9d-b3b3-08dc3efbb9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jOQtDABqmR9uIgWGtPO0Q3SqDtAVee7QHs6ZaC8EJN2o2opehU+naT90MKnEgzwXDFWtoX4TfZ0UchIc1FyP8OUnxSW98qqfSn4d+V0ywCPAt3iEZvaUz5soc/1pfC2IEW03RTWZ3eh3c7wc+jy2prLWpnWIWQbWrexfeK4KdMwVQtKtMmjL9yTgflOjQROjo8hUKo0AxvApEgugwv7I0PvXZknv8M4JubC2U0G/RYyolO3et51RozsmL8XK4C1dJxIhjY4JgD9cjmahrN67HM10SnkrRJi95VNU3ydOq4OzKFQf90rCLkN4sEJmT5qepJ67I97d8BiQdUiuOt7554oP8Lq8KBuA9aw+9Sxiwn7OKWCL9dDHomvAF2L5adk35gnkHfaM/X7RTjcVBx3MySAW4NS11blX/dgrRPU3fUHl/f5httEYRPhU6H0jrJEOtzMnFusrvgHYlcSgOcCLp8LNJRpxegGnt5TfcL7c79FbWtHtSHVSh0azA2kK8KFyKTm1zMntK4gT3X7T9gGEMzqI8vyRXHhvHj9vv4T6xbUirY5J/3MYgizlEMfZHv8vRaZzUgQsSLrkxEyLRiKBoeCVcAGVo1FAZYt09HJfX8DUKZXFo0Bn6Ahi5VI7cIe3y2qFueqtkOR+FcS/VdmgRdJcMmAdwHjgzbE/R8++sdy33KuQaKk5Lz9LyFE++itD//VKQQrOuh310PGBtE1QxReyguZv3awMG80zbAxvkdc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4226.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9nvlRhMR1pricGk1g5+nC6ET+hQo8yN9gXsaQCMlYQfwzpEGr0qGmu25nAfK?=
 =?us-ascii?Q?RjEPZcqoWo/2upxBMiRidyN27+HWNDwaAuJkY3Sh9F7PR1CEXvm5IGShePfh?=
 =?us-ascii?Q?fC8lxzCVsnNHtOGoivf4WjwtD/hvJ9T0Xwm3Yk4+PgGBDZOApww2eVLf0Tiw?=
 =?us-ascii?Q?mL1lAPReYyM46gxH0cIwop1wC420d8ndorRqTtO/Emcs3Q2RkYY+LtLSewOw?=
 =?us-ascii?Q?lcF2c9YWFaxUIM3Rzj48Pd5cixG/3a4rZiFHDSjo8Cz0/hEBipA4EVUG3385?=
 =?us-ascii?Q?6BmaIBEJUa+e0MMVPalnJYAFUJ32vp7y29l/2PqyQssZv9SV3//vDuTwyPCe?=
 =?us-ascii?Q?Qfj+EKnbwkeYSxE/8jZYYho7y1PDEFRov0wm6o1mrEB/iPLo2mwpjT8EMPKc?=
 =?us-ascii?Q?EoreCh1M1gialF80XswJjSMAfdd5O0RRzeg22F3OsE/Yguf77VXW6a3Ggdk/?=
 =?us-ascii?Q?KfHv3btAnlch1BEQo7HFx5uxSyt0vErnvc4996caD8+kxp95xWQAix2XK40I?=
 =?us-ascii?Q?5X7XllFrQYRlAgUK9Z7TzJHksINrOfYkyMnnjKVtim1SW5WUkLqA6Y7bVqax?=
 =?us-ascii?Q?FDowCPOr4LsPLtJfKWvGPktUdCxAySrcC02oLnJbttskOOuS6qIi5CPbNLVD?=
 =?us-ascii?Q?P0Rgjufxy5BTyZkrcKLi38WnTmdEzOshjukQPEmyiLc+415jOfG7K3NxGB7p?=
 =?us-ascii?Q?mqoIJbOOOmMdSP/ghghqLP3Z0bnJoen6198GtXE56Lv0ITD6sFtA9KBXhPAV?=
 =?us-ascii?Q?0OtYM2jqhFLOZvPToePy6IS9FHvYMGNt69AwplZ7yyJyIgWRgTAyNx7YUbwP?=
 =?us-ascii?Q?g+DYJ40cRVQ7037MWzwYtm53azgwucyVq5Y9o5T7NGH8s9PdA3chQ8YNiowR?=
 =?us-ascii?Q?OvtjJzD2nr6eTST8wMhTjocnKH/WoLc8sXWn/MMIvIdt5F2wvajXpRaif+EU?=
 =?us-ascii?Q?dMavBkMyHcoHIgaaIT0vPSPIhD6BcueCm1dlqxMjlyHHVc+OxQc8PbY1Poua?=
 =?us-ascii?Q?g6xnmSqrtiSc/0Pov4glZIlIAu/PIpGECv7TSAk2CThQ9SBO+RCo65R8Sbbr?=
 =?us-ascii?Q?fGv5EgDQfD195iN/QKi/KV65p2CdLcp/stE4e/9+m81xCRV10Yg2DNU2eYvl?=
 =?us-ascii?Q?w7QJISeBr8Tgp1uceuv0I9qlwKtGfz/Qf4N3XmbxR/VT5FW7lA1uTJNqWyMv?=
 =?us-ascii?Q?+LFHFPURN5C9Zw9pvyXMPF31+d5t1H7MDRLH8Z6Su9D+h5FuZO7fAfUDuF1W?=
 =?us-ascii?Q?HPmshNy2WXDBj1AfNDbTC41ggaJ1H1R1J8Q/OB2dr62hrp8h65MqhFIMcPud?=
 =?us-ascii?Q?2lNcrekFuFKyuROZvxoHaE/xHtDK/7T5TQNyAI8db0Up6NHjDz9Ro0Zg7PvP?=
 =?us-ascii?Q?fjh4LfYsMyn0CBtQCO1CW+C0XLgg1bFUzDHZZs5hi1Rlo/x1WArYczorAMc+?=
 =?us-ascii?Q?wuNy7sov0/ihluZSinfp3AeK6Lxi++/ntjsva4ja6Ehc+QwASfpVkuXcVhWF?=
 =?us-ascii?Q?N46JHMiYunnlT4fTWAu28bLcYlsCNfzVhAueZE4xllDJH++fEUdFgJteD6ix?=
 =?us-ascii?Q?NbBPi0qkDePfPBybiB02sPLIgp34+J3kzkvPmaQ24FJ21O1eOWA4dugIRAL5?=
 =?us-ascii?Q?fsWervbOFTxMRjzqy75FGtQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb123db-7ca0-4f9d-b3b3-08dc3efbb9d6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4226.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 23:10:05.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/OLTt8qYmRLHp2ovRFi/AtIIxIRRn4okPTc5dQcHUNqv1G7Gg8dbv7sDpeyxRPwGPtiio0kCiQtcgPCj4PmLIWv0B5zs5XyyT2r1mD3bpqxjSXB8lO9+ZoIB+2KdWIm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7116

Add support for tertiary match group.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm-cmn.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 29d46e0cf1cd..4a4cbda94907 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -174,9 +174,8 @@
 #define CMN_CONFIG_WP_COMBINE		GENMASK_ULL(30, 27)
 #define CMN_CONFIG_WP_DEV_SEL		GENMASK_ULL(50, 48)
 #define CMN_CONFIG_WP_CHN_SEL		GENMASK_ULL(55, 51)
-/* Note that we don't yet support the tertiary match group on newer IPs */
-#define CMN_CONFIG_WP_GRP		BIT_ULL(56)
-#define CMN_CONFIG_WP_EXCLUSIVE		BIT_ULL(57)
+#define CMN_CONFIG_WP_GRP		GENMASK_ULL(57, 56)
+#define CMN_CONFIG_WP_EXCLUSIVE		BIT_ULL(58)
 #define CMN_CONFIG1_WP_VAL		GENMASK_ULL(63, 0)
 #define CMN_CONFIG2_WP_MASK		GENMASK_ULL(63, 0)
 
@@ -1389,7 +1388,7 @@ static void arm_cmn_claim_wp_idx(struct arm_cmn *cmn,
 	set_bit(2 * xp_idx + (wp_idx & 1), hw->wp_cfg);
 }
 
-static u32 arm_cmn_wp_config(struct perf_event *event)
+static u32 arm_cmn_wp_config(struct perf_event *event, int wp_idx)
 {
 	u32 config;
 	u32 dev = CMN_EVENT_WP_DEV_SEL(event);
@@ -1399,6 +1398,10 @@ static u32 arm_cmn_wp_config(struct perf_event *event)
 	u32 combine = CMN_EVENT_WP_COMBINE(event);
 	bool is_cmn600 = to_cmn(event->pmu)->part == PART_CMN600;
 
+	/* CMN-600 supports only primary and secondary matching groups */
+	if (is_cmn600)
+		grp &= 1;
+
 	config = FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_DEV_SEL, dev) |
 		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_CHN_SEL, chn) |
 		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_GRP, grp) |
@@ -1406,7 +1409,9 @@ static u32 arm_cmn_wp_config(struct perf_event *event)
 	if (exc)
 		config |= is_cmn600 ? CMN600_WPn_CONFIG_WP_EXCLUSIVE :
 				      CMN_DTM_WPn_CONFIG_WP_EXCLUSIVE;
-	if (combine && !grp)
+
+	/*  wp_combine is available only on WP0 and WP2 */
+	if (combine && !(wp_idx & 0x1))
 		config |= is_cmn600 ? CMN600_WPn_CONFIG_WP_COMBINE :
 				      CMN_DTM_WPn_CONFIG_WP_COMBINE;
 	return config;
@@ -1919,12 +1924,14 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 			input_sel = CMN__PMEVCNT0_INPUT_SEL_XP + dtm_idx;
 		} else if (type == CMN_TYPE_WP) {
 			int tmp, wp_idx;
-			u32 cfg = arm_cmn_wp_config(event);
+			u32 cfg;
 
 			wp_idx = arm_cmn_find_free_wp_idx(cmn, dtm, event);
 			if (wp_idx < 0)
 				goto free_dtms;
 
+			cfg = arm_cmn_wp_config(event, wp_idx);
+
 			tmp = dtm->wp_event[wp_idx ^ 1];
 			if (tmp >= 0 && CMN_EVENT_WP_COMBINE(event) !=
 					CMN_EVENT_WP_COMBINE(cmn->dtc[d].counters[tmp]))
-- 
2.43.2


