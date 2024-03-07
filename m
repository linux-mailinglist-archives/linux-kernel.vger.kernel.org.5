Return-Path: <linux-kernel+bounces-96353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CA6875AE3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F44F1C2115B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BB93D3BB;
	Thu,  7 Mar 2024 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="X12JIIqv"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2130.outbound.protection.outlook.com [40.107.243.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612103EA8D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709853007; cv=fail; b=dtJ4lZFB6RGSpX/348t6vG5diWy7fqOHRkSG6d7IqYGd9AEh5+xzPfKvldoumK1MXOHrWN579RhGbG9gTHil17oH/yTbsZtXcrvVa0A6CKpQdDv+rD30f7qucPDBEtjqqvtWaU2aLjRkhLn1wMGmwDng9TGc0upku0SaBNS/bAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709853007; c=relaxed/simple;
	bh=Fy/dKJ9IC0aFe0cDF2S20yTzrbga7DAT3VDq/B8BkP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H4Jg3iQ1ddW7uZffiTTPhqLBkyKn27lR0JtRoR7tG0CBJ2O9AWtTEqptSm+rYFkNetzNm7qGCHlbGYI2cYzDxuiReAfDkeiVAZ2tMLngMC8ItDuhrlxwhPhYW3LaSCDP5R13z55LObSCUDDcYMEJnOfBf6qNCVa8q/VrjiXZmgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=X12JIIqv; arc=fail smtp.client-ip=40.107.243.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=km70QExyaBLg/tYBdbnPI9q8+z3IWYIO1jiG6jKHLns4gWyLurFsS+mL0UvvW/oIWEu8sL/7WOzZOALsvMby0l8IwGk4CMX36dEGL2UkedcnK3zG9NmccLsOQwtbeusZfAwcwuwE/aI/1PnBuQIoVu5KQgHzF20UgTQcjN3Tjy9pT2cG0LbslRSBqmWT0Uv8VjaHoHbCHpS06SPnWkavMZwxn412pf8buJz9voAgnZnfMuGDxpAm78lGoQxm1hsS8ztInVCfa8Z66IuweaFgxXOV69e92+fm2FCVjBY3WIN9frlZz3qNRsrwvb3lQj5d9kSEIasKLTsqPlp/gy5Bqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+twEQDvykkkKJyXddL9pYIiCIC4qHdRWT5XHHYExKM8=;
 b=i+ReFGMBwXI7CQ5v8uR0NnQVIc59OBLvzZfoCWaJLrtMQETuR83KgSXpODuDqnYSLzQ3IAlciZD/S/jomE+CuxcE2mc64NKA+EFYPKnM1hdXKLrN13lKlZvnGqGGxZ8pmnUkuMdx4QYvb94oVkk5wU8+WsVUpZOAzRdD3UOV9r5KedLdED/0+JKTwBYMTCpLrGqxasE1cLnk1pc7jp7jnQ89Ae2fujaNFcKesq1+4dfhrdVp/4hSgrsqChsiZdzgKk9KYVGlUsTN+0ibF+Vl71rI+R/PMDN7OhSkuDsMW5dhMcXvF9lgK2riS1eYyJQhN6wHqX9fIauKarZzSK3V+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+twEQDvykkkKJyXddL9pYIiCIC4qHdRWT5XHHYExKM8=;
 b=X12JIIqvTamq7bBN7LghJJ8yY6hqpYu2RQGGWUJgyWhMw1XckAC8CFisCKov4BzJlJ5C9Gz6DfvF8L4P+5slEVMRku7awU7vwV/uW1rpYX04apaJaM6L28M3agh9UtqSelMQ5K7dRj8nJEm4gIKiGXVCqjpatPaH7A+b3+xnR08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL0PR01MB4226.prod.exchangelabs.com (2603:10b6:208:49::30) by
 BL3PR01MB7116.prod.exchangelabs.com (2603:10b6:208:33b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.27; Thu, 7 Mar 2024 23:10:02 +0000
Received: from BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26]) by BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 23:10:02 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] perf/arm-cmn: Decouple wp_config registers from filter group number
Date: Thu,  7 Mar 2024 15:09:28 -0800
Message-ID: <20240307230929.6233-2-ilkka@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: d24b0d63-d5d4-4a66-34b0-08dc3efbb834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7zceF4Q9fQaC5o6bn2zk4ch9l73bbHbcOZeu7mPFiW6PP985WQQDrtTJC+E/fUJkMfFoGQDr5zDWJBRTv9asWpjzduxLU5PgQqDkpmcWbgFZ+eHRfs+dbIjBZZvpcSYgLXRUXgtJvHLej0uzMqsTmuvTt2oYWT4f7F18ylBdXBjBuLklNHnz3GZxnNqNCmJbcXQQV6cdKzLomvfw53towJnBnaBSyxjEfmN5ioK34Z3In0Yle8165MTIj+TEaLgO/QmFrKD6lc3ea+KSDwjlJatmJTU7U8PCssI4hLbxsaNhrmFDuscDIDiA0CtCRPp5aMTaEVQ7tISwq9BTMFHqvumwFjLXMLtUI08TP+ZCIEgVC+kObUkk2IAqe8evW1ieGBD4/8rl1QZI2nYJfZVfhDEgTJM2sx8iRtEtIJ/78r/Lv1tlRPCik8oYmj1iFcKFRvOal3GtawoU5Rts1zA6YGfJFuFPnu5LgV9nBb+0IoGl8TZrAvS8g1b/QjJg+3LwQLBuDBMl03FXYj03oiIc/dhTQYnFvtITZv3FWeYVwUYonnPgC3xi2xC9X98aze9J5uBgzq/5LZPv58sntb07kMHWRvdaMPAqw7R5mFf/ucIQEho3XqHV6n3TzE0nbS+/In8VwmwspY1VHh+IvmzVCSY91+/zyyeH3DozEpH+2Ta/EJdHhTkyx7AA+t7iMc2y6qp4Nu6NfPavWF+tUg7H18CIMxKOUbT/xsUGp7pRwBU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4226.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XIBEwk8PoyFW6PsGDUSHzKCpyPJtaesN0qF22DzV7s7adrwjHOK6A5ujJQj5?=
 =?us-ascii?Q?6p25W6e3fOV1AX5D3wBNeYW/HmczL5ItTKiG36rTx8eZC2+HmB5wRIAJYqep?=
 =?us-ascii?Q?lJLqz6aZgBvYWzSp9ZpZ7Tea8FRbSBNqGi2daNQ/q79J8FH0YO7s5JIfO8GB?=
 =?us-ascii?Q?KvB8X34qtixsc+z2+hC+Nrng3VXRDhStTXfLaU9q5qi/L420cTvucrUWD1bV?=
 =?us-ascii?Q?JIeXYRlZdcF/WXjPGxPd/nuUCVymS4HRJivvTzdaXdjYqQbaAC6nmAIxBPoQ?=
 =?us-ascii?Q?OFwSiJQdVfS+kVdgPxmMqzuvBApQJlqR+Vsz9JyDhTi+XVn4YO3DbtLg/svr?=
 =?us-ascii?Q?4gvrq8wWaAJMu9A70jofgTR1YCjziVfaRcC1yQghvUUiFTrmD8F0zxD/ThHN?=
 =?us-ascii?Q?se52+6vxuvhW7QI1JGTK8ofieivkql8wCN1zFqL5BJessT7jwKEU7xrDwx3O?=
 =?us-ascii?Q?TZsAL6bj+7hMhkk8E9yw6iXPBr6W4Mwg7Jm8oSFBLarEZFcPFckjBf7Kw6GH?=
 =?us-ascii?Q?6OdC8lsb3aq3NI2S9e2oBxFFWTcTmWm9vmcPz6FuDzKX7Iw00Quznwk/uIVs?=
 =?us-ascii?Q?dRKMZlS+7+3g2FqH4kX1qlK+m+wzRL3SYJGq9HSpJ2JdfXDlgG7na+KX5WtK?=
 =?us-ascii?Q?t3+egAqgAqQ40dedtoE60IkEhOLv54061/4d4aQjj65Ow+wbtl+AdstiSQ3z?=
 =?us-ascii?Q?5yVJsrd+Np3ROtB1wqZCCCicPcer3LcTFYfc6Tc8IxQxvvba/UFTi6tjwmwX?=
 =?us-ascii?Q?hGter4RsfHuN+VgQGVVUjdqqvlzeVJ+11R/OBAUUQk2GGqo66pi5kt8E22NX?=
 =?us-ascii?Q?OfTQRNpiR+oaTbB38nfcUOfYWRtxLEvakumxNIViGwdQn0lp6oq1C3yTTAgR?=
 =?us-ascii?Q?kR5dTptvlq87Zx0ODw1i6aRA/gM9x0vGugRU9fmi7l0XmKL5YGhbW4XI/cXH?=
 =?us-ascii?Q?r8m+FRtGbByTfDKXSCg91FGsVGhTgvORor2B8porTufQplLyF5qN3OKgJU1x?=
 =?us-ascii?Q?Jg9v/cpqbEvlQIizuey8Vk1OKGMWehDNrvl1txScV8exKsHY/HS5yeUztvR3?=
 =?us-ascii?Q?lR3i7M/q7gMXc6JjI9YV7TJLrztcOyix6LFJqu2gyT2dI9/SCY3BeBfmL24N?=
 =?us-ascii?Q?JA7D4pV7cmsAtV/ovShisbv3LtMhJ3YGmcF1Fri6q9qdiWqbOyT9zdffcWHp?=
 =?us-ascii?Q?PxryzBlmnMgnpSkcpeFsTRF/eiKer4YdnBdhfq2JZsoB/pkgEcqNrPOBKiYn?=
 =?us-ascii?Q?+0I8Jw1nFPp0x798OAf3HzbvLMfOwkcYOihvA7EEvrUR6rbEcIr4BjIdgWW6?=
 =?us-ascii?Q?4TnzWpx7M36rk3CMKhmb6S5gVi4EwltV2QCTcpgX80lYmBAkPd1UgJhbIgo0?=
 =?us-ascii?Q?7Q1SHlYxCx3NgnVnk1HbqdVpvR0/EEviXOxCo0gkgtk/IpHSrUHMxdu6doKV?=
 =?us-ascii?Q?WUUqP4Fp4ovUpF0NDhgrZIUplfc7JIzXoFmgyxCyw1nKNKOVVaZ+fdnspfG6?=
 =?us-ascii?Q?8wI8ppGHI2DexOujLrCm3mGm9vvxcXDYXysMHNXxMmufvB8kmA2eiGfp/sPX?=
 =?us-ascii?Q?feZCCLnEQVwI5xn1EV3hEYQJFFY12bwFCN5NSfUM37twDQ6I4SE2BRoNrZww?=
 =?us-ascii?Q?LjTiUy7AuS2u5hFxec4FoRc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24b0d63-d5d4-4a66-34b0-08dc3efbb834
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4226.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 23:10:02.8775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEbz2oIJv0Mx3hx7JCgS0jmUxGEl9mVnnj5f6KszLYX55SqyqA8Fom2CUDKf3imZQLhK1/NP/WGwpzg1FuyX9Ua5IugsVT5PVO7H+ewqjYpiVM1qu2bYEpeqXdMOoPLx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7116

Previously, wp_config0/2 registers were used for primary match group and
wp_config1/3 registers for secondary match group. In order to support
tertiary match group, this patch decouples the registers and the groups.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm-cmn.c | 125 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 105 insertions(+), 20 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 7e3aa7e2345f..29d46e0cf1cd 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -589,6 +589,13 @@ struct arm_cmn_hw_event {
 	s8 dtc_idx[CMN_MAX_DTCS];
 	u8 num_dns;
 	u8 dtm_offset;
+
+	/*
+	 * WP config registers are divided to UP and DOWN events. We need to
+	 * keep to track only one of them.
+	 */
+	DECLARE_BITMAP(wp_cfg, 2 * CMN_MAX_XPS);
+
 	bool wide_sel;
 	enum cmn_filter_select filter_sel;
 };
@@ -1335,9 +1342,51 @@ static const struct attribute_group *arm_cmn_attr_groups[] = {
 	NULL
 };
 
-static int arm_cmn_wp_idx(struct perf_event *event)
+static inline unsigned int arm_cmn_get_xp_idx(struct arm_cmn *cmn,
+					      struct arm_cmn_node *xp)
 {
-	return CMN_EVENT_EVENTID(event) + CMN_EVENT_WP_GRP(event);
+	return  ((unsigned long) xp - (unsigned long) cmn->xps) / sizeof(struct arm_cmn_node);
+}
+
+static int arm_cmn_find_free_wp_idx(struct arm_cmn *cmn, struct arm_cmn_dtm *dtm,
+				   struct perf_event *event)
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
+static int arm_cmn_get_assigned_wp_idx(struct arm_cmn *cmn,
+				       struct arm_cmn_node *xp,
+				       struct perf_event *event,
+				       struct arm_cmn_hw_event *hw)
+{
+	int xp_idx = arm_cmn_get_xp_idx(cmn, xp);
+
+	if (test_bit(2 * xp_idx, hw->wp_cfg))
+		return CMN_EVENT_EVENTID(event);
+	else if (test_bit(2 * xp_idx + 1, hw->wp_cfg))
+		return CMN_EVENT_EVENTID(event) + 1;
+
+	dev_err(cmn->dev, "Could't find the assigned wp_cfg\n");
+	return -EINVAL;
+}
+
+static void arm_cmn_claim_wp_idx(struct arm_cmn *cmn,
+				    struct arm_cmn_dtm *dtm,
+				    struct perf_event *event,
+				    struct arm_cmn_node *xp,
+				    int wp_idx, unsigned int dtc)
+{
+	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
+	int xp_idx = arm_cmn_get_xp_idx(cmn, xp);
+
+	dtm->wp_event[wp_idx] = hw->dtc_idx[dtc];
+	set_bit(2 * xp_idx + (wp_idx & 1), hw->wp_cfg);
 }
 
 static u32 arm_cmn_wp_config(struct perf_event *event)
@@ -1519,12 +1568,16 @@ static void arm_cmn_event_start(struct perf_event *event, int flags)
 		writeq_relaxed(CMN_CC_INIT, cmn->dtc[i].base + CMN_DT_PMCCNTR);
 		cmn->dtc[i].cc_active = true;
 	} else if (type == CMN_TYPE_WP) {
-		int wp_idx = arm_cmn_wp_idx(event);
 		u64 val = CMN_EVENT_WP_VAL(event);
 		u64 mask = CMN_EVENT_WP_MASK(event);
 
 		for_each_hw_dn(hw, dn, i) {
 			void __iomem *base = dn->pmu_base + CMN_DTM_OFFSET(hw->dtm_offset);
+			int wp_idx;
+
+			wp_idx = arm_cmn_get_assigned_wp_idx(cmn, dn, event, hw);
+			if (wp_idx < 0)
+				return;
 
 			writeq_relaxed(val, base + CMN_DTM_WPn_VAL(wp_idx));
 			writeq_relaxed(mask, base + CMN_DTM_WPn_MASK(wp_idx));
@@ -1549,10 +1602,13 @@ static void arm_cmn_event_stop(struct perf_event *event, int flags)
 		i = hw->dtc_idx[0];
 		cmn->dtc[i].cc_active = false;
 	} else if (type == CMN_TYPE_WP) {
-		int wp_idx = arm_cmn_wp_idx(event);
-
 		for_each_hw_dn(hw, dn, i) {
 			void __iomem *base = dn->pmu_base + CMN_DTM_OFFSET(hw->dtm_offset);
+			int wp_idx;
+
+			wp_idx = arm_cmn_get_assigned_wp_idx(cmn, dn, event, hw);
+			if (wp_idx < 0)
+				continue;
 
 			writeq_relaxed(0, base + CMN_DTM_WPn_MASK(wp_idx));
 			writeq_relaxed(~0ULL, base + CMN_DTM_WPn_VAL(wp_idx));
@@ -1574,8 +1630,20 @@ struct arm_cmn_val {
 	bool cycles;
 };
 
-static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
-				  struct perf_event *event)
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
+static int arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
+				 struct perf_event *event)
 {
 	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
 	struct arm_cmn_node *dn;
@@ -1583,12 +1651,12 @@ static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
 	int i;
 
 	if (is_software_event(event))
-		return;
+		return 0;
 
 	type = CMN_EVENT_TYPE(event);
 	if (type == CMN_TYPE_DTC) {
 		val->cycles = true;
-		return;
+		return 0;
 	}
 
 	for_each_hw_dtc_idx(hw, dtc, idx)
@@ -1605,9 +1673,14 @@ static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
 		if (type != CMN_TYPE_WP)
 			continue;
 
-		wp_idx = arm_cmn_wp_idx(event);
+		wp_idx = arm_cmn_val_find_free_wp_config(event, val, dtm);
+		if (wp_idx < 0)
+			return -ENOSPC;
+
 		val->wp[dtm][wp_idx] = CMN_EVENT_WP_COMBINE(event) + 1;
 	}
+
+	return 0;
 }
 
 static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
@@ -1629,9 +1702,15 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
 	if (!val)
 		return -ENOMEM;
 
-	arm_cmn_val_add_event(cmn, val, leader);
-	for_each_sibling_event(sibling, leader)
-		arm_cmn_val_add_event(cmn, val, sibling);
+	ret = arm_cmn_val_add_event(cmn, val, leader);
+	if (ret)
+		goto done;
+
+	for_each_sibling_event(sibling, leader) {
+		ret = arm_cmn_val_add_event(cmn, val, sibling);
+		if (ret)
+			goto done;
+	}
 
 	type = CMN_EVENT_TYPE(event);
 	if (type == CMN_TYPE_DTC) {
@@ -1656,8 +1735,8 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
 		if (type != CMN_TYPE_WP)
 			continue;
 
-		wp_idx = arm_cmn_wp_idx(event);
-		if (val->wp[dtm][wp_idx])
+		wp_idx = arm_cmn_val_find_free_wp_config(event, val, dtm);
+		if (wp_idx < 0)
 			goto done;
 
 		wp_cmb = val->wp[dtm][wp_idx ^ 1];
@@ -1772,8 +1851,11 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
 		struct arm_cmn_dtm *dtm = &cmn->dtms[hw->dn[i].dtm] + hw->dtm_offset;
 		unsigned int dtm_idx = arm_cmn_get_index(hw->dtm_idx, i);
 
-		if (type == CMN_TYPE_WP)
-			dtm->wp_event[arm_cmn_wp_idx(event)] = -1;
+		if (type == CMN_TYPE_WP) {
+			int wp_idx = arm_cmn_get_assigned_wp_idx(cmn, &hw->dn[i], event, hw);
+
+			dtm->wp_event[wp_idx] = -1;
+		}
 
 		if (hw->filter_sel > SEL_NONE)
 			hw->dn[i].occupid[hw->filter_sel].count--;
@@ -1782,6 +1864,7 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
 		writel_relaxed(dtm->pmu_config_low, dtm->base + CMN_DTM_PMU_CONFIG);
 	}
 	memset(hw->dtm_idx, 0, sizeof(hw->dtm_idx));
+	bitmap_zero(hw->wp_cfg, 2 * CMN_MAX_XPS);
 
 	for_each_hw_dtc_idx(hw, j, idx)
 		cmn->dtc[j].counters[idx] = NULL;
@@ -1835,10 +1918,11 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 		if (type == CMN_TYPE_XP) {
 			input_sel = CMN__PMEVCNT0_INPUT_SEL_XP + dtm_idx;
 		} else if (type == CMN_TYPE_WP) {
-			int tmp, wp_idx = arm_cmn_wp_idx(event);
+			int tmp, wp_idx;
 			u32 cfg = arm_cmn_wp_config(event);
 
-			if (dtm->wp_event[wp_idx] >= 0)
+			wp_idx = arm_cmn_find_free_wp_idx(cmn, dtm, event);
+			if (wp_idx < 0)
 				goto free_dtms;
 
 			tmp = dtm->wp_event[wp_idx ^ 1];
@@ -1847,7 +1931,8 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 				goto free_dtms;
 
 			input_sel = CMN__PMEVCNT0_INPUT_SEL_WP + wp_idx;
-			dtm->wp_event[wp_idx] = hw->dtc_idx[d];
+
+			arm_cmn_claim_wp_idx(cmn, dtm, event, dn, wp_idx, d);
 			writel_relaxed(cfg, dtm->base + CMN_DTM_WPn_CONFIG(wp_idx));
 		} else {
 			struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, dn->id);
-- 
2.43.2


