Return-Path: <linux-kernel+bounces-123965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA638891069
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093571C22469
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925551DA58;
	Fri, 29 Mar 2024 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Ivk9n8G5"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A3917C77
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 01:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711675967; cv=fail; b=i1ayD55VCh7vjWiz4J1sMq9s0ObWtxS6QwheMJDgrA85BaAHvGkIDMwr1NjiGHLDhirtGT/xWQCWQ+A+ajCmYH6AAOHrERTTob37u9jkdqQFaktxxtswV/2/NMiSHmOpStvfyqlhL4kJ63XifTsE8t/mJBa46LaJF+5xXqBLxu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711675967; c=relaxed/simple;
	bh=7RRmFGzpvFlygvoZ0JvQWBzV6vREGdaNwrEtBV3h74Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=orVFUDRy2Srg2AAeTyZqtweahb6pEEphs4UnjJpn/eL/uYs+D/qYOoNP6aTkWiz0mqcgNnrp2HEltWIVx0dbzUK9IbYS+44HsO2dLAw0bbu6JoGuFBKuyHuBJsHmi6GH5cUzKYzTeWUWQix1SvCrqCJgx93fzZQuC1dSG0f/p3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Ivk9n8G5; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAJcmHcgbTCPDOI3eJIiQwk0CYvoV/DEJI5MvWkJOPj6mHb17jnQ9X0Z2f6t1e5RB5TqKZreujrIvy2D/+AJCa3qRk4GwUE35GZvpSSygYYKercueyhaUPdGYsDuxfFw455gYA/WPh8gZ2z4ZVH4iCQR1JqKNSx3quuW7uIcS8x/nF3FE5Td0EhpUyUoikk6H6m+aQct9ZevUOzfp06XUnxVua717caQ8m0P6FbnOOIPO9UGoeLNAtzzb0U+exwtXR2lhgSJCYnbyOxGoVGW/hB48r2qpaad/r0J/AiE18h5L3cOHY1CukhC7NpaKgiWEYOrWzkMR2tusGHWSdGiUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ll5JW0l5WfxPWTGpRYxt/P9NbQPRIrY/boPHLZaVqVo=;
 b=cBQ+TYsPbK1cqW3EZN5qzxr7t4q/hrTwFExq84Ez0e0UtYj2m27UE0x3JEby8OesXwvHvIcrGPeF9ksCvqFG6GkDwrc4r1nm0M7AANx/eQ5/ymwxjCFISNoi7YePSZDBCDGNpzI0XS6iK2SqJiKoiDB0WNXkor0HEe0nsBW1d0m55omUipc/NCqhxNKvqU+mubazRLb49brE/V5MUjwQg8S8oRl3bteTJfNA+s2mY8kj+LH1TZ45Viv9hKVeE/2BK3wkHYUJDGPnseJNGTXWEzVilfMbOUvPq1POS+dGKRQDEwKpBPIcIiSIrd5pZ8+YkC5PW4nWyIxXqXOJVRNhww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ll5JW0l5WfxPWTGpRYxt/P9NbQPRIrY/boPHLZaVqVo=;
 b=Ivk9n8G5DknRULFYr/8inYvXnh8n97r4VMnVZg1WGDHUgjE0K/LwBzprHibv6wnXqSgaazNJyQhv9lHXtoZov1QwKmm099roZqAgz1yM6mOP3bH1TcUxh0ryw9xeOuyGcWzXnwER/otN60ycDIeKhhPFtBFa9K9vXQwA6bMnyt0=
Received: from BL0PR01MB4226.prod.exchangelabs.com (2603:10b6:208:49::30) by
 DS7PR01MB7878.prod.exchangelabs.com (2603:10b6:8:81::10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Fri, 29 Mar 2024 01:32:42 +0000
Received: from BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26]) by BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26%7]) with mapi id 15.20.7409.038; Fri, 29 Mar 2024
 01:32:42 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v3 1/2] perf/arm-cmn: Decouple wp_config registers from filter group number
Date: Thu, 28 Mar 2024 18:32:14 -0700
Message-ID: <20240329013215.169345-2-ilkka@os.amperecomputing.com>
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
	aGQauRpTEm1LBxllEfx3pd+g0M26WFOQFqZKAUurhFIk1Cgjz5l9aYl+NO+yl3oEAHm6vmPv51QTMB06IOFhocnjQ+cRDweaZUs/gG8vcN6PEuGZcJshLRriX/HvSS404IYG2PoIEZ+/vNbrTNl3qJxCJPtGsTQMKPMXHDub0Xpty9okko0I1VsbhUpB4squYgnSwMZzIG+qBXA86BaNXWk/TWXnuOJPrked0FfUj9GPoPch8iMDSVQXhFQppshBCJ7EDAyM64mnAQtpWJuMLMwV/xUprUGjeSp44iFH29ASUbQ2WD0rgN+KJIOdxEPPhzhhVhLkAu4+EiezuDwtElPLVs5Ry8/EDwQSVJuygiBdTi9EmS9VCb2O4uf8MckV5GgHpjZ0oQ2zyzEcQuRl/21YhqoPhKe0t0OFIXL+hSC/30RYKSGuzRlglYyqCtqup1FTmmnPi38KE1RJttpklDlb/zxp5wq4hIR1L+B5prM47Z02YKDgNmOdP8gPJFqHkAvQ3d0vHzYAtE74Rj5kixla1vH/9c6mQm8aAY7McmLR5ym4CRlKdNjgBtMXFA3s3WU4owjj44aOFzfVkEgXnQvgzFqACGJmBVv6G47pvKLglH1w4Kl7mmeOwzo9BdvbDfbMZWN6RAeMZesloiyw/Yg4Uz7ejArjmHO4FC2x9M/AB7pmEc63L1FfrVmzmjxPeWEU9KThYoYE+b27kjEwie2ub+oxE0oaZatqztHz3VQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4226.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UV7b3EwDusVmGdHQ1lZqFdXb75TfpfU0cS4P6uVaBGJQ+XNE2LM8gPkwSu9E?=
 =?us-ascii?Q?9kkVom+TKA0kbs+jY9KINf8ezNXjZXXHtqAZwCye2T+JtQ26d7GJYwgDpHeH?=
 =?us-ascii?Q?6gGzuVOvA7UN1lVqJnjlxEP+2cBQEsdXE7lqNZeUhxeT/36Dp0eefb0oHfVV?=
 =?us-ascii?Q?cLJeQuYJhjZuVaC4jBDtfSpNkpflYAYMmbIqDQoFT2AJAkT7TuZnvKnhQMZV?=
 =?us-ascii?Q?szNemuoKcqJ20xnqTZhirHSr0tpMFdveuasCBiiy7WlbIgQrLZTBHRVIQkeG?=
 =?us-ascii?Q?IWQ6v9kQG7hYSMkNHscdC6xsvpFCv3GcslXYyYfVNbsguE++KgKyZrHrbqNh?=
 =?us-ascii?Q?V0mbBHjMqrtT/rG7eJusSVHeawdozykAhECJ508ciiXlVizAp+VcUePDgiXB?=
 =?us-ascii?Q?sDGG4LbzMBSvt9rvq2X2POg5ZAlprp2veRD0DfYszSnSGSOFe09Ir94NCTZJ?=
 =?us-ascii?Q?TZ7n6bOnek60EjWQamwgFI+ournCedjZn3KTJfBUhoCeDYLMC+ZaXmk6nNT+?=
 =?us-ascii?Q?ORfgAPmdo2cBdOPJghWYn4fOz4VojdDDmNC/6ZiNEmUO+C0KejeDyN+Napv9?=
 =?us-ascii?Q?9B0c2yU+LohsMaKRGK/gGBEUqrSgbDsT2+tjwDTO6ndQxo4k9VJkvIbKjdhn?=
 =?us-ascii?Q?F0meh+luzSbjVdfWDuEhoEuEGeFUmdVgV2CT3cEmoejFuMlv8Msyi/aiC303?=
 =?us-ascii?Q?M1IQ1NoxsfKe2H+wAN6Sby+5YhnvNUrdGmzMo3iEgPbxpa1j36/Vd3kvTCXq?=
 =?us-ascii?Q?AQca9tOHMSf9dVg/6aGFaR6ub+neFCVdJeND0TqcBSIalOcqbfSeAPt0suf/?=
 =?us-ascii?Q?Q6sewT29+VQhe2DtaE6lTMpznOGRGQ+qtGR95ACWfwLM8krZkxBv+9AYoYGm?=
 =?us-ascii?Q?wTqlpcmUsQ+L2bHe7DjbGtDYceQA1M0OEO0XFvXiVS3zPou8bmM8rRc81SzO?=
 =?us-ascii?Q?k67v3HI/pea0oL4Sc6mvJR/jWZtX2WSDjZi7k8D/pRbrwkU5wr8/EDeLrvgH?=
 =?us-ascii?Q?MkTd+BTxk8S1tVwBoIW2TUUBGpVDJwwrT5DbUuJ3HgEhBoonSSkJer4V/MUK?=
 =?us-ascii?Q?hM6Yfn6RayKVbhyAOCyfLmtb4hzEPEyBr3tTxpaH23hjSKqy+pfs6bItseuE?=
 =?us-ascii?Q?4ojU0gOxA+WzbR3SzCrWVCxDP7ONfSvsQDGEfM1WIwk7+mKB0qAlaMzVECet?=
 =?us-ascii?Q?L8FbqYLcijOnUxIvDO77EIhCOBOcNUkmPIses++w+8Vg3AHOJ66zfbv660Jw?=
 =?us-ascii?Q?m15XHKyHZKyCVupA+XuiqlukYtvpydbnj2NYY4c/eV6VIwYzHpoKDEG5Wl6E?=
 =?us-ascii?Q?sX1mtFLtjvM0/xBIXrcRpTpjTeDCsgzXRRZ3EQKPHrwM7zK1xY2IJjdrBP8X?=
 =?us-ascii?Q?6nodbrWhYZD1hViqUeLwRTmpOwq5P0/ZltRwaclXo7Kkzbb4QPvBLchkKSFO?=
 =?us-ascii?Q?lyYFqXGtFOeFhUTknhYgjdsdiPyY23lpiVXfBnbkuFLB8scicbXMlDFw/UQd?=
 =?us-ascii?Q?5DzF5AONM25/VmdbWHIHoiiCcClbLjTU1xprbxuYWyBE6nmh5csAMvxMFulM?=
 =?us-ascii?Q?9sFChxn58uT9UMp7IYgMzZaMw1ToPP2hRLXkDKKuDhL/iBT0wwQRKXiCWa6D?=
 =?us-ascii?Q?NOw98R9QZubMSdYp78DKLtc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fd1745-5458-4607-08b2-08dc4f902111
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4226.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:32:42.9339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+8mXnNzUquQXjpdYIbRBrGGQfhY1Px9efsIi90APIXWKmfq0bvS5A7Qz3hwW2YBBOb/3EJd1R+mN26BjPx0278621CKPkoI8JsZpcGFU+4SkVoSUaotr1nH0rPNShOf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7878

Previously, wp_config0/2 registers were used for primary match group and
wp_config1/3 registers for secondary match group. In order to support
tertiary match group, this patch decouples the registers and the groups.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm-cmn.c | 97 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 80 insertions(+), 17 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 7ef9c7e4836b..9f4a82861faa 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -590,6 +590,13 @@ struct arm_cmn_hw_event {
 	s8 dtc_idx[CMN_MAX_DTCS];
 	u8 num_dns;
 	u8 dtm_offset;
+
+	/*
+	 * WP config registers are divided to UP and DOWN events. We need to
+	 * keep to track only one of them.
+	 */
+	DECLARE_BITMAP(wp_idx, CMN_MAX_XPS);
+
 	bool wide_sel;
 	enum cmn_filter_select filter_sel;
 };
@@ -617,6 +624,17 @@ static unsigned int arm_cmn_get_index(u64 x[], unsigned int pos)
 	return (x[pos / 32] >> ((pos % 32) * 2)) & 3;
 }
 
+static void arm_cmn_set_wp_idx(unsigned long *wp_idx, unsigned int pos, bool val)
+{
+	if (val)
+		set_bit(pos, wp_idx);
+}
+
+static unsigned int arm_cmn_get_wp_idx(unsigned long *wp_idx, unsigned int pos)
+{
+	return test_bit(pos, wp_idx);
+}
+
 struct arm_cmn_event_attr {
 	struct device_attribute attr;
 	enum cmn_model model;
@@ -1336,9 +1354,34 @@ static const struct attribute_group *arm_cmn_attr_groups[] = {
 	NULL
 };
 
-static int arm_cmn_wp_idx(struct perf_event *event)
+static int arm_cmn_find_free_wp_idx(struct arm_cmn_dtm *dtm,
+				    struct perf_event *event)
+{
+	int wp_idx = CMN_EVENT_EVENTID(event);
+
+	if (dtm->wp_event[wp_idx] >= 0)
+		if (dtm->wp_event[++wp_idx] >= 0)
+			return -ENOSPC;
+
+	return wp_idx;
+}
+
+static int arm_cmn_get_assigned_wp_idx(struct perf_event *event,
+				       struct arm_cmn_hw_event *hw,
+				       unsigned int pos)
 {
-	return CMN_EVENT_EVENTID(event) + CMN_EVENT_WP_GRP(event);
+	return CMN_EVENT_EVENTID(event) + arm_cmn_get_wp_idx(hw->wp_idx, pos);
+}
+
+static void arm_cmn_claim_wp_idx(struct arm_cmn_dtm *dtm,
+				 struct perf_event *event,
+				 unsigned int dtc, int wp_idx,
+				 unsigned int pos)
+{
+	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
+
+	dtm->wp_event[wp_idx] = hw->dtc_idx[dtc];
+	arm_cmn_set_wp_idx(hw->wp_idx, pos, wp_idx - CMN_EVENT_EVENTID(event));
 }
 
 static u32 arm_cmn_wp_config(struct perf_event *event)
@@ -1520,12 +1563,12 @@ static void arm_cmn_event_start(struct perf_event *event, int flags)
 		writeq_relaxed(CMN_CC_INIT, cmn->dtc[i].base + CMN_DT_PMCCNTR);
 		cmn->dtc[i].cc_active = true;
 	} else if (type == CMN_TYPE_WP) {
-		int wp_idx = arm_cmn_wp_idx(event);
 		u64 val = CMN_EVENT_WP_VAL(event);
 		u64 mask = CMN_EVENT_WP_MASK(event);
 
 		for_each_hw_dn(hw, dn, i) {
 			void __iomem *base = dn->pmu_base + CMN_DTM_OFFSET(hw->dtm_offset);
+			int wp_idx = arm_cmn_get_assigned_wp_idx(event, hw, i);
 
 			writeq_relaxed(val, base + CMN_DTM_WPn_VAL(wp_idx));
 			writeq_relaxed(mask, base + CMN_DTM_WPn_MASK(wp_idx));
@@ -1550,10 +1593,9 @@ static void arm_cmn_event_stop(struct perf_event *event, int flags)
 		i = hw->dtc_idx[0];
 		cmn->dtc[i].cc_active = false;
 	} else if (type == CMN_TYPE_WP) {
-		int wp_idx = arm_cmn_wp_idx(event);
-
 		for_each_hw_dn(hw, dn, i) {
 			void __iomem *base = dn->pmu_base + CMN_DTM_OFFSET(hw->dtm_offset);
+			int wp_idx = arm_cmn_get_assigned_wp_idx(event, hw, i);
 
 			writeq_relaxed(0, base + CMN_DTM_WPn_MASK(wp_idx));
 			writeq_relaxed(~0ULL, base + CMN_DTM_WPn_VAL(wp_idx));
@@ -1571,10 +1613,23 @@ struct arm_cmn_val {
 	u8 dtm_count[CMN_MAX_DTMS];
 	u8 occupid[CMN_MAX_DTMS][SEL_MAX];
 	u8 wp[CMN_MAX_DTMS][4];
+	u8 wp_combine[CMN_MAX_DTMS][2];
 	int dtc_count[CMN_MAX_DTCS];
 	bool cycles;
 };
 
+static int arm_cmn_val_find_free_wp_config(struct perf_event *event,
+					  struct arm_cmn_val *val, int dtm)
+{
+	int wp_idx = CMN_EVENT_EVENTID(event);
+
+	if (val->wp[dtm][wp_idx])
+		if (val->wp[dtm][++wp_idx])
+			return -ENOSPC;
+
+	return wp_idx;
+}
+
 static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
 				  struct perf_event *event)
 {
@@ -1606,8 +1661,9 @@ static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
 		if (type != CMN_TYPE_WP)
 			continue;
 
-		wp_idx = arm_cmn_wp_idx(event);
-		val->wp[dtm][wp_idx] = CMN_EVENT_WP_COMBINE(event) + 1;
+		wp_idx = arm_cmn_val_find_free_wp_config(event, val, dtm);
+		val->wp[dtm][wp_idx] = 1;
+		val->wp_combine[dtm][wp_idx >> 1] += !!CMN_EVENT_WP_COMBINE(event);
 	}
 }
 
@@ -1631,6 +1687,7 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
 		return -ENOMEM;
 
 	arm_cmn_val_add_event(cmn, val, leader);
+
 	for_each_sibling_event(sibling, leader)
 		arm_cmn_val_add_event(cmn, val, sibling);
 
@@ -1645,7 +1702,7 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
 			goto done;
 
 	for_each_hw_dn(hw, dn, i) {
-		int wp_idx, wp_cmb, dtm = dn->dtm, sel = hw->filter_sel;
+		int wp_idx, dtm = dn->dtm, sel = hw->filter_sel;
 
 		if (val->dtm_count[dtm] == CMN_DTM_NUM_COUNTERS)
 			goto done;
@@ -1657,12 +1714,12 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
 		if (type != CMN_TYPE_WP)
 			continue;
 
-		wp_idx = arm_cmn_wp_idx(event);
-		if (val->wp[dtm][wp_idx])
+		wp_idx = arm_cmn_val_find_free_wp_config(event, val, dtm);
+		if (wp_idx < 0)
 			goto done;
 
-		wp_cmb = val->wp[dtm][wp_idx ^ 1];
-		if (wp_cmb && wp_cmb != CMN_EVENT_WP_COMBINE(event) + 1)
+		if (wp_idx & 1 &&
+		    val->wp_combine[dtm][wp_idx >> 1] != !!CMN_EVENT_WP_COMBINE(event))
 			goto done;
 	}
 
@@ -1773,8 +1830,11 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
 		struct arm_cmn_dtm *dtm = &cmn->dtms[hw->dn[i].dtm] + hw->dtm_offset;
 		unsigned int dtm_idx = arm_cmn_get_index(hw->dtm_idx, i);
 
-		if (type == CMN_TYPE_WP)
-			dtm->wp_event[arm_cmn_wp_idx(event)] = -1;
+		if (type == CMN_TYPE_WP) {
+			int wp_idx = arm_cmn_get_assigned_wp_idx(event, hw, i);
+
+			dtm->wp_event[wp_idx] = -1;
+		}
 
 		if (hw->filter_sel > SEL_NONE)
 			hw->dn[i].occupid[hw->filter_sel].count--;
@@ -1783,6 +1843,7 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
 		writel_relaxed(dtm->pmu_config_low, dtm->base + CMN_DTM_PMU_CONFIG);
 	}
 	memset(hw->dtm_idx, 0, sizeof(hw->dtm_idx));
+	memset(hw->wp_idx, 0, sizeof(hw->wp_idx));
 
 	for_each_hw_dtc_idx(hw, j, idx)
 		cmn->dtc[j].counters[idx] = NULL;
@@ -1836,10 +1897,11 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 		if (type == CMN_TYPE_XP) {
 			input_sel = CMN__PMEVCNT0_INPUT_SEL_XP + dtm_idx;
 		} else if (type == CMN_TYPE_WP) {
-			int tmp, wp_idx = arm_cmn_wp_idx(event);
+			int tmp, wp_idx;
 			u32 cfg = arm_cmn_wp_config(event);
 
-			if (dtm->wp_event[wp_idx] >= 0)
+			wp_idx = arm_cmn_find_free_wp_idx(dtm, event);
+			if (wp_idx < 0)
 				goto free_dtms;
 
 			tmp = dtm->wp_event[wp_idx ^ 1];
@@ -1848,7 +1910,8 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 				goto free_dtms;
 
 			input_sel = CMN__PMEVCNT0_INPUT_SEL_WP + wp_idx;
-			dtm->wp_event[wp_idx] = hw->dtc_idx[d];
+
+			arm_cmn_claim_wp_idx(dtm, event, d, wp_idx, i);
 			writel_relaxed(cfg, dtm->base + CMN_DTM_WPn_CONFIG(wp_idx));
 		} else {
 			struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, dn->id);
-- 
2.43.0


