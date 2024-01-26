Return-Path: <linux-kernel+bounces-40732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDD883E4E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A8D284A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595724596A;
	Fri, 26 Jan 2024 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="sJYSvv4D"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2099.outbound.protection.outlook.com [40.107.220.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E5625633
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307190; cv=fail; b=gEZCWdkEyEUioWOQAmuLTzJqzo6Sg3G6JWOrWZM0FzsFTe7vAlRFAwDAQkjnPL+UgNY0riR49ehGrPhHUMV9HfzdmOZ9CSDVb+peTDzq8KZz3byBPalNPvBaL+GWYdo8HgHgV1tBW70jl41lGAUL3USof1mNy3xwMqHBmxZkApc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307190; c=relaxed/simple;
	bh=YVy10MWIkjrQRbmHYyMOUQFtkZKn9gX8sWhoofxP+OM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y2cBrQRvphp56dw2FCX0V9xuGkHiXEnqRMGtwQybHnMZgdwGHnBw4BaD9s7DDScP1578/5fJ7YFP8TuKT1H+mQIpE6MG/PmzsY8a+a4l49Gu+iTxxYAMqO+6lHD285/CYXyni1lqx3P2aiTtJFTVLjrR6UDKg9dYFAIsH3wRQ2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=sJYSvv4D; arc=fail smtp.client-ip=40.107.220.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BplPtzhaknf5JhcZFDM76E31x6elMzdDN6jwqtFiYIUjd2B8kvuMp/62ZoWKfSCp5oX8dCEko/wTvfujHd9tlrxFeXv2+ULpVIVaHidpVcidvaiDZebtLeEHcvkR+V8tCV1VpZe7o4NjzjguxB+VPtoL8vnQ9qcC2XxFDWJz/bHjmVQiYq7sjPaEFfb3vFG2jFIdBE6Cy4md2Pym0EdbkoZYyQxf+EaBw9kKYIzDFg5RqhQ6FJX5rux8/vtRFAWoW/iRmY9fyb0sWQuE1sBh+i/6/+gN1TlYJztcvU9WbZdaOBKmYa7WTxV6+ceNSYcRiRoYhE8lIbF9IoMfn0OqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A43sP7k8Oio1GOvgjHg6OcMOUBSEQgGOnOM5a+i2sow=;
 b=bA1X/4OQSuAprcEuYSg4mtHmbYmtOMwv3QcEV1H+zqhy8P4PU2GjkjO+UZiMessErZcngvkjYs5WdoFwNsafkJt4LgVfItijMRNk6LXop4N0rRkuZXS4wN11dntlkIw/ApxXp5A+slYgAMydsq5hD75M5jnMHGm2m0zvidy/ne18hqX7kG43j0OVUOZtvj0iMQmAd2ElINflDtoplJJP31u6znxzuAT1BF3GQ4bEn7xgTtraaGZJkbhp1gjaiut8nCGAV+E5pO1y85HX7nZR65e4VX2AipdlEV1QgRx+qWQbMhwGFO/4cHn1VXRsLiMeaWG4TpJZrOIWp6gUXJSWdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A43sP7k8Oio1GOvgjHg6OcMOUBSEQgGOnOM5a+i2sow=;
 b=sJYSvv4DUtVppexc2dn2g9PEazrvjvId2nF+KQyz7XFohWV5Y1xw22qZ54filMh5JXrpXGAbENryw5TKTiakTyubvMity0Rfm7YY0fOuNA28dWyoQEAq2sSfmB/6gE9G4Ralg1axpmJpL0jq8OJPl5+sBVeKjbiGFhrFowOj3gQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB8166.prod.exchangelabs.com (2603:10b6:510:293::17) by
 PH0PR01MB7491.prod.exchangelabs.com (2603:10b6:510:f2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.24; Fri, 26 Jan 2024 22:13:06 +0000
Received: from PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::67b9:4671:4fdb:2dbf]) by PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::67b9:4671:4fdb:2dbf%5]) with mapi id 15.20.7228.023; Fri, 26 Jan 2024
 22:13:06 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf/arm-cmn: Enable support for tertiary match group
Date: Fri, 26 Jan 2024 14:12:15 -0800
Message-Id: <20240126221215.1537377-4-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240126221215.1537377-1-ilkka@os.amperecomputing.com>
References: <20240126221215.1537377-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::27) To PH0PR01MB8166.prod.exchangelabs.com
 (2603:10b6:510:293::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB8166:EE_|PH0PR01MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a660bd-d315-4bd8-8535-08dc1ebbf909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fajeldIIdIIIbSYQOdtbozQK1s97E83CMS47XcPIs3ooNHo4LbJm/cFhQaga3dnbxNr7S9P5FpqfkzVXuKt7ZclYN/vQkbCmHc0FR4PSqI8UumgnApYg9Dls37X5P6EmWToJFIO+TH0E+uVKRtFY4jJxwetMpDWWFrXHWKlSHQzqATnT73ScSNQ1Xy3wOdx5tngn+LSVhZ7onJCbkpzXyBVr7H6Izor7D0d/9LcLmTq0DaP1vQ0+nv1uphW6lmNT1RUspetMJGtRSSEJa2BsgvTk5aVmKGTv/kNM1PRElzhWEhEEn5OomWS29pPnKHVjCnQijtJKArDJH5Sicrl+p7fZ7uFMTFtP7+OgXtI01fEEBQHS64HG25KoRSony/5smbzpmWOqOwrPQcl8aCH4KwweA+Q+oV5f6aQeJsAvhX8h88Eofoio1zMga9ixxvRDhil7Z2nOJXF9voRcCWv7sUCEFegVX+qMfMfYeUSq/ftYui1QPw+FHg3zlhQO5ddVam2/z18r8uw4MVFZ5Y+xkS366NCFJXoikEILlViBd8J5aVDFbRw3Z9UH6bPdkDavn69EsbNKHXlViwCwMEYYgbe+vPVpcl0MqhtdaXxw/Yexe62fBKX65eF24EwQce6R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB8166.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(136003)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(66476007)(8936002)(2906002)(66946007)(8676002)(316002)(4326008)(66556008)(86362001)(110136005)(41300700001)(478600001)(6486002)(1076003)(83380400001)(6512007)(52116002)(38100700002)(38350700005)(6666004)(2616005)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bCfCoVSMkcH04ceRQs9xWqE4OyF85WLT8kjqAoxv7BQLSF+vQWHnQMECRdpC?=
 =?us-ascii?Q?89/NWe+ywqRwtuEIhzsJrbtZTjX+2jNYg3VeWXE2fBClBiLAE89rDyiOD0ra?=
 =?us-ascii?Q?xnhqscrLdguAf4stvHue4wDDLyglQ9s6G+4+Q/Pdwv89s6KUAN4pUkaisSJ8?=
 =?us-ascii?Q?XFarX0wRsIqQRSDpV5cZFax5VWbmB7JYzhAbV47iAAI9y4urXUUOc9Vd/0yF?=
 =?us-ascii?Q?Bx0V2SCcdJJIKbTo4nqeXaDtRFIvihPlBF+Ha5NHTD3aa4p8JWzWonV+3qHd?=
 =?us-ascii?Q?yy/M6fOadHWg8QQX6jt4/G0le3HNurLfJKK7P668PUQXS4S77Y7F7m/GpP8L?=
 =?us-ascii?Q?h2gRE0ihZnOCEdU64T/rsvwY0Qml8aZjgs9MZgKgqSN1CJCBoGQpkYWAYW6a?=
 =?us-ascii?Q?F/bJB56Rry39yJtAqDcVscRTOGopyAY4se/G+F2IymtuztM/JJ3/IrN6TFmK?=
 =?us-ascii?Q?QKn92OkNw4BsXoCbBLpx/T+aA2dOcJlFjm/5Nh0CmhspzVtL9LeBUcYOi5gk?=
 =?us-ascii?Q?+bcqucd2QqsWI+GEU4Yf/5z89J6i/LVk+/hhFjF9sa6gHElf2/u8P6nK7b94?=
 =?us-ascii?Q?VkTOfcvb0RwGlYqCHHEm2TRYaxZjE1K165IQ5d8B7V890ub+dW1aVPXVZzeg?=
 =?us-ascii?Q?xPXtVCsppmwhYDPBKwxzoNvT2tulUrtJ1bM4rY/ebdits7CQwLW/T+YOZ9Z2?=
 =?us-ascii?Q?pAGahtcGMOLaoxFpG3EoJiERkDOEicY/U7hUB6YFaIdE/ilh4AB1B5OXsUdq?=
 =?us-ascii?Q?YmLZkObBsUQv1oGOS6U4p7Y9f78WCKD1g98VdOfukZGMzBgieEFLu7LUApr8?=
 =?us-ascii?Q?c0kSDVJk9eB35mm3/KBnOomI13ziA71ZLkh7j36UBTTrZYJCMtqZqQQ+T9o0?=
 =?us-ascii?Q?cj0Mqy7sxG4Wib/AoxHQg9dyw/4Ac0ysmb659pp7ALngnXr6zakEJbuLU/0U?=
 =?us-ascii?Q?Lv70cUMBpBxKx09jnulq8Sy4sEPvARfgEI8qbicM+x5g6CUh8xDHZnhqqY/g?=
 =?us-ascii?Q?3gt+t1XxMecuL9mWvFao2BWPHKz3F2sF5hJ1Yd7UUJWdYse2ygvxn6eWjO4O?=
 =?us-ascii?Q?qx9hTKCcZmBzuT+fiD4gnoPzFB+HqoxfQ2Kj0z07DndIRs/FpsuC0RDn1QoH?=
 =?us-ascii?Q?38nseHUOFv3KDepTSSIC/n2nsViWCAr4LQpUGTsxWBBqztWYWjXi4eYh04QM?=
 =?us-ascii?Q?JbT8Dt+hZ9j4oDYOyAX0KdnQr7ssM2Z9W4dVpm0KMy+u6kBJvka0P0d0OnEK?=
 =?us-ascii?Q?6oakwfw6csvz4Mgos+z79ZuuqWlfTUyiapJ0mPqo+Gi8iU6PJ4q8on3ECL8G?=
 =?us-ascii?Q?xvTvIBAACHYmvdSWNiRAkHooVQ17ER07bMOHWfMfhOXUxkpE8KcIozQ2Rqk7?=
 =?us-ascii?Q?hKFzRI3Emqlh2omf7OhHUXNWyAobhn1VMDZtYbqG1qsuh9PFZ42XSSN9W/nb?=
 =?us-ascii?Q?xsqROU8e0n/odACdD+2EPArYNjwievr6ikSovbT14XI/Tssr9KS6xeMafHqA?=
 =?us-ascii?Q?k5Pka4DCeiMDFGW44HeOussnzEtnw6wkiVoaoHYOaJYBB/cPdHBLHBHw1C3q?=
 =?us-ascii?Q?7ePROVSPLZDee0G3Ni6dpZAH+QUjt/9791PYC3S2tvAHZpgEV3WGHW/rssQr?=
 =?us-ascii?Q?OOud3p2uCdJozUbdUi7pxEI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a660bd-d315-4bd8-8535-08dc1ebbf909
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB8166.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 22:13:06.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECCi1Gd7AtAI+F7GBMo9cENDudvC4gxwW9BMNGNYi8fsMPlXlWwWtsOAJyykEZ9Zg+z+tDeCZ5GF9JSoUmX1aZgpmdFyOJhZl7jwV/iC7qO0hmanYaIUEQ035V1Zd47i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7491

Add support for tertiary match group.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm-cmn.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index dc6370396ad0..ce9fbdcf6144 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -91,10 +91,13 @@
 #define CMN600_WPn_CONFIG_WP_COMBINE	BIT(6)
 #define CMN600_WPn_CONFIG_WP_EXCLUSIVE	BIT(5)
 #define CMN_DTM_WPn_CONFIG_WP_GRP	GENMASK_ULL(5, 4)
+#define CMN600_WPn_CONFIG_WP_GRP	BIT(4)
 #define CMN_DTM_WPn_CONFIG_WP_CHN_SEL	GENMASK_ULL(3, 1)
 #define CMN_DTM_WPn_CONFIG_WP_DEV_SEL	BIT(0)
 #define CMN_DTM_WPn_VAL(n)		(CMN_DTM_WPn(n) + 0x08)
 #define CMN_DTM_WPn_MASK(n)		(CMN_DTM_WPn(n) + 0x10)
+#define CMN_DTM_WP_CHN_SEL_REQ_VC	0
+#define CMN_DTM_WP_GRP_TERTIARY		0x2
 
 #define CMN_DTM_PMU_CONFIG		0x210
 #define CMN__PMEVCNT0_INPUT_SEL		GENMASK_ULL(37, 32)
@@ -175,8 +178,8 @@
 #define CMN_CONFIG_WP_DEV_SEL		GENMASK_ULL(50, 48)
 #define CMN_CONFIG_WP_CHN_SEL		GENMASK_ULL(55, 51)
 /* Note that we don't yet support the tertiary match group on newer IPs */
-#define CMN_CONFIG_WP_GRP		BIT_ULL(56)
-#define CMN_CONFIG_WP_EXCLUSIVE		BIT_ULL(57)
+#define CMN_CONFIG_WP_GRP		GENMASK_ULL(57, 56)
+#define CMN_CONFIG_WP_EXCLUSIVE		BIT_ULL(58)
 #define CMN_CONFIG1_WP_VAL		GENMASK_ULL(63, 0)
 #define CMN_CONFIG2_WP_MASK		GENMASK_ULL(63, 0)
 
@@ -1298,7 +1301,9 @@ static struct attribute *arm_cmn_format_attrs[] = {
 
 	CMN_FORMAT_ATTR(CMN_ANY, wp_dev_sel, CMN_CONFIG_WP_DEV_SEL),
 	CMN_FORMAT_ATTR(CMN_ANY, wp_chn_sel, CMN_CONFIG_WP_CHN_SEL),
-	CMN_FORMAT_ATTR(CMN_ANY, wp_grp, CMN_CONFIG_WP_GRP),
+	CMN_FORMAT_ATTR(CMN600, wp_grp, CMN600_WPn_CONFIG_WP_GRP),
+	CMN_FORMAT_ATTR(NOT_CMN600, wp_grp, CMN_CONFIG_WP_GRP),
+
 	CMN_FORMAT_ATTR(CMN_ANY, wp_exclusive, CMN_CONFIG_WP_EXCLUSIVE),
 	CMN_FORMAT_ATTR(CMN_ANY, wp_combine, CMN_CONFIG_WP_COMBINE),
 
@@ -1398,8 +1403,11 @@ static u32 arm_cmn_wp_config(struct perf_event *event)
 
 	config = FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_DEV_SEL, dev) |
 		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_CHN_SEL, chn) |
-		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_GRP, grp) |
 		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_DEV_SEL2, dev >> 1);
+
+	if (grp)
+		config |= is_cmn600 ? CMN600_WPn_CONFIG_WP_GRP :
+				      FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_GRP, grp);
 	if (exc)
 		config |= is_cmn600 ? CMN600_WPn_CONFIG_WP_EXCLUSIVE :
 				      CMN_DTM_WPn_CONFIG_WP_EXCLUSIVE;
@@ -1764,6 +1772,13 @@ static int arm_cmn_event_init(struct perf_event *event)
 		/* ...and we need a "real" direction */
 		if (eventid != CMN_WP_UP && eventid != CMN_WP_DOWN)
 			return -EINVAL;
+
+		if (cmn->part != PART_CMN600)
+			if (CMN_EVENT_WP_GRP(event) > CMN_DTM_WP_GRP_TERTIARY ||
+			    (CMN_EVENT_WP_GRP(event) == CMN_DTM_WP_GRP_TERTIARY &&
+			     CMN_EVENT_WP_CHN_SEL(event) != CMN_DTM_WP_CHN_SEL_REQ_VC))
+				return -EINVAL;
+
 		/* ...but the DTM may depend on which port we're watching */
 		if (cmn->multi_dtm)
 			hw->dtm_offset = CMN_EVENT_WP_DEV_SEL(event) / 2;
-- 
2.40.1


