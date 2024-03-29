Return-Path: <linux-kernel+bounces-123966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E4289106A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847C31F23046
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F21B2134B;
	Fri, 29 Mar 2024 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JLWKVD+z"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2099.outbound.protection.outlook.com [40.107.220.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BFA1DFF5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711675971; cv=fail; b=nApMBFLdeJnd3wAN516NPmQ0x2GSufXebRZmNFYNu/P8SS0as5e1c2gWhfpDA5alby20JuVXvpkWQOFK7sYOZPlKpBigodIU8qfkb/PqJFXmlLzk64iFzHMIPQuSr6CzhbezN6HI1t62KCAAJlVZbmIj3ATqJftoNObFGlSoFH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711675971; c=relaxed/simple;
	bh=K+6iYsBxWcbDDXlEpUnzGsArqhTfVz0NnuJHaUAi87o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JabZ1tkmo2/R0IxjXwyB2lIam6h5c9rvgfJ/WLjQIOPH82s9l/JFbWW1pcf5FC5Db4oe2m5CFWH0ZOsjKeowq9/cnldrIFuPXAZGOy+O09FFJPf2HiiACfwVy4BDV0XeKSY0WEcsx2QhCxDvkHswgseZcixX+j8BGFemYifrdnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JLWKVD+z; arc=fail smtp.client-ip=40.107.220.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqITA1LouALJWQmaMV0ViwNFD5ljTXS++aaPmdcyeF15KIoPa81icz77QQ4dTRjA2KTH3eCtv/G9vS1Vg9xyywxFS6glX9QnhAGoc1DJ24Zx5/JKCN3duv0KQLhdtpAXdYuC45oWYsUMG1iUDzaQ1RWEJ3yjdTbiE9+ZkpbJ9PcyEOzwyfM1O+h3NhLGSnBS5g67wmzNZlrh8FfFgWXi/LANGL/UazuWbCRlDaJkdUyWX6W45mLBhm2JtujUPLRrdMHoL1/N5eJC39cZWrsHW9muk7TDk0lzTlhJNd5R69lMq5lpWpPMb/UieFp41vsAReh8W5Cwi67DhkHflgb6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIlgrDq++UMPhf1VB0EHtOXrFD9q9CvhESCm85k9EgE=;
 b=KdvXTooXWV1mpeG8zSwSTj4PJxjEwYR3PEi3bagSyJWodAqjRRwptXDEcdEd2yyHG5GY1gU+HacLbbTmccJGPQhqpua5sQA7CDEZcAdFN2xbnl3ANUzlxq2OB9b8z8jx6AdnBWrFa8OsjELGu5eAH7otJnZKvcwmRk9BPTocViP8w6ldikWeu7zRRUHH3KK8w3YACUkMSkR5keZtjjEvqdZf6Y3zOx1JYAzxUlkCtvPs4bbWjW7/GnbD1KaJKf32LrQkDD+N15kEMYBPwS+Q4iOtVH6gtSIKzFMu+kEUuqEcUx4DQ82f7enIWXZyFl2IZAT4TteZJyhXi0UFK4mudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIlgrDq++UMPhf1VB0EHtOXrFD9q9CvhESCm85k9EgE=;
 b=JLWKVD+zcZWtpKY6+tAzTfA8mYyw6P/qGcDTG08anUzDwaHBCQLvLedm+VNJ1jK5ODRCaHrfUR8PapK4ALDoJgbc3EYNScDqQejVEeJtyRgAlIritTzOGAjTFXVW5OFSS5/0lnOKtMAfQFg8nFDkECXk9day8EQEIFHtGdYV3HI=
Received: from BL0PR01MB4226.prod.exchangelabs.com (2603:10b6:208:49::30) by
 DS7PR01MB7878.prod.exchangelabs.com (2603:10b6:8:81::10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Fri, 29 Mar 2024 01:32:48 +0000
Received: from BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26]) by BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26%7]) with mapi id 15.20.7409.038; Fri, 29 Mar 2024
 01:32:47 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v3 2/2] perf/arm-cmn: Enable support for tertiary match group
Date: Thu, 28 Mar 2024 18:32:15 -0700
Message-ID: <20240329013215.169345-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329013215.169345-1-ilkka@os.amperecomputing.com>
References: <20240329013215.169345-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:610:b1::13) To BL0PR01MB4226.prod.exchangelabs.com
 (2603:10b6:208:49::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4226:EE_|DS7PR01MB7878:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SbG9qLf69RV3Fnf4b+OGbXFBCzBb7MIom/4VY0Zaa8TF6eVblRVeXaZVScbTKq8CIYxIMONmJ3vtRJGbUUhQC/y+KkDWHdqcCbU1ILGMRQ7w5XR1gk5WKe6EitvOFBp3G/FoSZhP1fp54huO2AIHfXM43qjlb2lHWzTQNdbjGOAc5T0FAU5H+sBiXL+7UEIGqdZZcQvSouXT3w+8TVKCjwWn1zBMy5v7MRO1lQS6SktVISkvA6l2n6t7KzqUvVM5HHSEgu0de0UCeyBKNmC1p2XyDzcC2Q3+rWZkpPTbWevRPniVXGtq0uIUwHJfnxnbDuMrwfpgtig7j4aqQF4hBz0ypg7AoQp0BDiDM1MVb/PMOCqKc/TjtiT6m7EznhhSbotfqgx8dyEw7S0Hb7d2tnTf5etDoDo2fZygGKSgUepKJk0HReiafJYC1MYLF6Uk1hAzb/t+4rR6z89tmv3mPM/Dyp3jl4AQH/6tePQGux+eAbeeKCZgvChBvuekc3fsRzjCoVttQ0JDjm8zjPRnfqu/zssXgvS2GOf3MGH2qNyOZ4BqtD0JxPdSHDonSKiV2J4ZMmE1tTgd9y8QE740yEPDXfEIbDuteIPhiF8IzwITd1AwcIZKnrXZX7pyJ6XoRZ194F/MRsotI44O8/OZurkFYDwjpwAsQtG5IFgFo0AZrT8xG4FJ3JYt3WKv4EYtiEt/RFX7pu84Imk+sHryXkaW4UcrHxdc5ICTkepx1OQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4226.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vxYU38GydlZDKK9eTTbvg+mPbf07/ZwL4A0OjJP+Vt3f4PbgKgbJ03Pl3YfT?=
 =?us-ascii?Q?al3YVJ/GPVkjWL8DJM+vPqJO59l06l8f/ZFau4D9ZiKYjtCAqGPRKgDXYjJj?=
 =?us-ascii?Q?9ULb7CD9lBSGzYBQ1sQ7y/OR0qX6L5vxK6nO4jkjcQIF9BMt/MP9rDs20hbY?=
 =?us-ascii?Q?h2jHR2KVBCt8XEhYgGFck3v5/AMshoXDwEEm1ZdQ7YweetrazvF0LG6Up+lU?=
 =?us-ascii?Q?a3wciOksdSyn1ZCnnA427Anvh6/c4rgrEjpsurMgobSobDkUHkxnmjRbY2fR?=
 =?us-ascii?Q?ObUXltZnrYDRJAFLcrKkwVpRVoFqukta3OQ00u/n79Zqo5zbNKHZxnL9zm3f?=
 =?us-ascii?Q?am16yOBQEVDpuAwa8g0CmHy64tOXro+HGl6OM+zNiXv+rLbrubnpZwqH4xvA?=
 =?us-ascii?Q?JQafqkKUz5V+/+AInxLqaFg5Llf0AY9e0XrauhqsGEVqOUMHl5X7dfYoKCqU?=
 =?us-ascii?Q?ShRWyXWFYPXZ2fP3sxZcXUAV6fatObZ8AUipw2iUSxRUZZ8IxCc7bcSD3RNe?=
 =?us-ascii?Q?Ghw+0IbczEzxowvlvp/+5eAnVlgdcoDbKRM/EM6TCyDB42QiMPVM3NBz3s8d?=
 =?us-ascii?Q?1EQMqj2GdcF6FNE9tmpYJC8HXPiNvslh/GQa7470y5ZIsakCGnoiM4rPo7kf?=
 =?us-ascii?Q?CCw9zhb/k4hrmCL1++GHg/Vl9aCaXRPMLRGMW/shHliUkfE/kZbvp/bP6CFb?=
 =?us-ascii?Q?YKpCzlJMpAHA6px4FTlnAKJJx5TwLNa/hZlmNCYN+JIgqHJ0qVaisDjT9UWp?=
 =?us-ascii?Q?vwRdJ9uHZ+9hAGhIY7md3OR4sWV6LIqYH+qq5546QrCAXfYGRrQeMDYJZ1xo?=
 =?us-ascii?Q?0+NGhKqZsAJGSCGapZC1AXzYZtRS7vn2qsdSxM4cFggr2e+raPhWCnovwN7i?=
 =?us-ascii?Q?dE8ZeTm1N7NMVKnBpSY31NXl4S/WWkQ0Ruy+uHCRFgWOsgLCkOB/T9XhIHdI?=
 =?us-ascii?Q?bk3EN1vtbye/BrdTKHtqDCjRb8Ftqm86MM2sDXTrqsE6fKJJaAO3p2mt63qS?=
 =?us-ascii?Q?XH9qIhsLqwt87B3mC+KP1K66aTUqGJe5VZfp9Y1DF4RtgREH1Yl4A63TVV3Y?=
 =?us-ascii?Q?eFgvlvtc5U6zkjRfpPJNckWV5ygoDrHh5C16+QCj1TaLVu8Uv6y2lSYWcL+7?=
 =?us-ascii?Q?iCfsboexJkC/S8XAdxqknfq0fGYVN2p9mkpUg8FamN9u3Nz7WzTR0KjaY0Dj?=
 =?us-ascii?Q?CP6nitAFROUmkQv2aU3uuz69MvDDZFbh6THGJFMa3d/gZzXEYgSy1JNVT/+6?=
 =?us-ascii?Q?69nLTJFsmJG1L4gkkvqIWYyPJkAYXFb1m9/6buNEoT3V715ETxjEAp2UBPSt?=
 =?us-ascii?Q?xidK5zDy6qDJVFivdFmjOJY+bhCsAYtKJ3iOkpIpuSF1iuIXJwQmei0S/WzZ?=
 =?us-ascii?Q?6YhyebJJgP6TSRbYYcM9EVYi4lxtP3fmfb+liG+yUuVFMhd53wMp5vQQrRmf?=
 =?us-ascii?Q?CrKtXrAMBVfwmoywkaza/I1DPWxOqUndkTe4CwzaW00KbXtki+RNxZArvq8Y?=
 =?us-ascii?Q?hkn1iFjkznlkOZ1ktFHASA4tiuUK+cG+5t7lV3Fvax41cq8QjtEnTZM5KoeF?=
 =?us-ascii?Q?9SrgHppR0i5m04GBUy5dwiJYpbnrDIDxvIGp6hAf1Lzk6RpuddgX6j1WRs0K?=
 =?us-ascii?Q?SSeaPKiABz4UMePKboiJtBQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf73bd7-063d-4b83-a274-08dc4f9023b5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4226.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:32:47.6464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0lKLplhGi/g1nPtOodfCYXCNQJSENvHtDEfowBHtIz4tptaSRNEoAgRDlyB64UJ5e2cMp620RB1FVZ+/98jZoaXYqHPcJiF76FBsliF2wceTXEU4lEdimXRhHRwoOOv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7878

Add support for tertiary match group.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm-cmn.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 9f4a82861faa..3d7db1254753 100644
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
 
@@ -1384,7 +1383,7 @@ static void arm_cmn_claim_wp_idx(struct arm_cmn_dtm *dtm,
 	arm_cmn_set_wp_idx(hw->wp_idx, pos, wp_idx - CMN_EVENT_EVENTID(event));
 }
 
-static u32 arm_cmn_wp_config(struct perf_event *event)
+static u32 arm_cmn_wp_config(struct perf_event *event, int wp_idx)
 {
 	u32 config;
 	u32 dev = CMN_EVENT_WP_DEV_SEL(event);
@@ -1394,6 +1393,10 @@ static u32 arm_cmn_wp_config(struct perf_event *event)
 	u32 combine = CMN_EVENT_WP_COMBINE(event);
 	bool is_cmn600 = to_cmn(event->pmu)->part == PART_CMN600;
 
+	/* CMN-600 supports only primary and secondary matching groups */
+	if (is_cmn600)
+		grp &= 1;
+
 	config = FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_DEV_SEL, dev) |
 		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_CHN_SEL, chn) |
 		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_GRP, grp) |
@@ -1401,7 +1404,9 @@ static u32 arm_cmn_wp_config(struct perf_event *event)
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
@@ -1898,12 +1903,14 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 			input_sel = CMN__PMEVCNT0_INPUT_SEL_XP + dtm_idx;
 		} else if (type == CMN_TYPE_WP) {
 			int tmp, wp_idx;
-			u32 cfg = arm_cmn_wp_config(event);
+			u32 cfg;
 
 			wp_idx = arm_cmn_find_free_wp_idx(dtm, event);
 			if (wp_idx < 0)
 				goto free_dtms;
 
+			cfg = arm_cmn_wp_config(event, wp_idx);
+
 			tmp = dtm->wp_event[wp_idx ^ 1];
 			if (tmp >= 0 && CMN_EVENT_WP_COMBINE(event) !=
 					CMN_EVENT_WP_COMBINE(cmn->dtc[d].counters[tmp]))
-- 
2.43.0


