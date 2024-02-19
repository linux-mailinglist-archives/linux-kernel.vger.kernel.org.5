Return-Path: <linux-kernel+bounces-71464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 552B385A5A7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2171C21D10
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A475374EA;
	Mon, 19 Feb 2024 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="eXMWHtfL"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2097.outbound.protection.outlook.com [40.107.215.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8162D047
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352265; cv=fail; b=c4XxGAAz2viqoXGCHlPzHfXTowJ8auXX6l0KDefBgRgahL12QAMc78Eilm2N4OAggI5l15i1iQcpj3H1AJJqASHX8dzzD5Jw9gXSXgZNQ/Fi6C/WPN9KtMaoKhBxX7Fz6glk97sEGSFoCiDKVlo1Qtkvwi8hxhjcH7iXcWVIsaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352265; c=relaxed/simple;
	bh=gRmzo10zdxrraEypl3/FrM1VQwn9/7q08JhqgMPkuuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RUurxOab9cg6vvcpz1OPiQsLrFec1tcO4E4wsE9z9bW5aMksy+bV3leRkR5/+LllU9u1gwkPZIvUvqmrBf/wJRPtgncLBck1QEF6++7wPxIEeF0Ep5EsxIM6Ci9/CTpV3Sor9Ccst2g/ybg6dtGyEktyjzhkQG0XaO0696av+NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=eXMWHtfL; arc=fail smtp.client-ip=40.107.215.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsUA8G1jFlc3lcAmv8Epw5Aa/BMgdEbI+MBn/ig3NqFweD5c1Be+zjL/pNYFDwHBOt/1xKmq6n6Vf2d0KJDHHwrkxl3evn5l2+2esaw+SeQN+zyWcdA5mfmj2xyDheS1ivhTZPsGIY+pkNHpp/G+UGA5YDrrxzwAseVZCAItMcrTGyld6AYqHiHOAqPppLFH3fQgBHp7Chk3ls09yfo/23KT6uOzPiDKuITo5sP77XWHDHOLQqin4JjHyG/ZamUGvkCEBVq64W+/Sxr1gM1dMZPRGPYQnGCVJf9+M5MuJTx4tlvrWT7S5L6OhfE2q5wjceLyHWx8aHujnEoWPIQQew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WnD33kVHlVoJspZP0pfVloaZl+Ow5XeFg4qdDmADHI=;
 b=fzJNZcxCy4vBKYkkq7hEcubW+S+eck9LYRZAhNbxtEHYhAIVIh7E322JPNt0yfpI0ufdZ9OuLC2PYEugGd1Xo8jwtKhZnPfl34YkKuR4ouzscYKshnCBYT0La0PkdEV53GKmVjAw1d0x54+mObLYYtGEaKksoyrNfi9b+AL/X2OdytA/Ak5eKN1YIrjiz51/l9N58w46eHgeY0GEwXf8YgwuJhbSp/QcctKg9RU+hKLlR+Dqm1HSO53bFQa7eYpGM93NzfUV7rbCYFeSbXQl6UIKm5f9yvDKh4J8/6rwwRqoVmaSAyPmFMyDy8sSicM2tXwgIVzZWC6qJlMeni6Rrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WnD33kVHlVoJspZP0pfVloaZl+Ow5XeFg4qdDmADHI=;
 b=eXMWHtfL4Vh/Qr8AyCzAkUSmwRp5NhMjXgJ0bRXZD2ycaUD62iH9lEpqMfFrXhGaT4GMSUQ2YfRlk2JS45Q/rSQpdmWy1ml+edNW2VODbt0mh5UxBuGUdVNYFraySyfOOsobjSG1a4qWPDszONLDteMtVRs9TGYrxlPfrPbOpL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
 by SEZPR02MB5864.apcprd02.prod.outlook.com (2603:1096:101:73::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Mon, 19 Feb
 2024 14:17:38 +0000
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::9b7:25b2:5977:633a]) by TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::9b7:25b2:5977:633a%3]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 14:17:38 +0000
From: lipeifeng@oppo.com
To: lipeifeng@oppo.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	osalvador@suse.de
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/rmap: support folio_referenced to control if try_lock in rmap_walk
Date: Mon, 19 Feb 2024 22:17:02 +0800
Message-Id: <20240219141703.3851-2-lipeifeng@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219141703.3851-1-lipeifeng@oppo.com>
References: <20240219141703.3851-1-lipeifeng@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB5595:EE_|SEZPR02MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 78dcb474-b6fd-436f-d846-08dc315586d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s6YcgLVFNd4LJs2/D7G5L+Za4wjwBz8SW5aexQI1UMGogsZpq+eW8R9uhV2Lp6AdpRqmOeIgTVCUo57jjG7J4Tx1cqTtlwmlOKIxl80yx++E4quSRJb9yqgFVr2QrTOIgE+UySpx0WXK8HZeRWMFR41wFLyvG1F7BlmCcZ3dD2KmI4O2gMbJkdRp5LhX9ymq2u3QvkvnBWm3aSdxafe82vUM7gk3bpAe6xAhnuQhbPXd7S9a3AeOW6V6r5wumo8SEOM75eDsEJR0G1MEgv/WACmvNIpvqGNof0c2BobsPOZ0UvOea0GWvEBXqtEL+w7nL/QZNlO1qbvGB6ZPy9MP2E/ryahkaCQlypB8yWoFUjHdBRDbfC9gU/yZiOUISZEADwPMB86VXVxIyo7Xchk04EURnUjinD9UAw2G3fW/ZlczIPmX/4L6r/liNnPkW4GKx5G40MlBQuf2eRkYUqhhjNsZ958S8sYu9Z/itD3c6Boyce2W+rf/SXMyM7eGkuZys/1ht9mkFfUWaDkjSGyr3iuayDpQVPhe71qDV9DyYpRqYz5INjoYCm7XL58/zM/xa7p6TvEVpL6lnyTBYsGIikU2HF6upL04R6HwtdonQ7Xp8mQlBkZQLaoUxPfmEsUx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5595.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y1gs2z4bU+E2Wg2TKz6xn2TZnZkdAPS81OdsShGEwteDZCATU+WRkuOPQK7h?=
 =?us-ascii?Q?nIY6J250IPbYuhP/7bir3eVHRQUwSdD9R9Ac3KcC0burzQhI+rve24SCi2WR?=
 =?us-ascii?Q?g0T2rQ7Mo1fx+I6YI0xg9XgpyfcdIkqKSIJ5PiTKMWj5D69bDC3Db9MB7gZz?=
 =?us-ascii?Q?0IaccDHIz6LBwPrdGTSxWNSeiHbrEVr6uUb4CRJ8MkOf32fUSzjwWCXsPxcn?=
 =?us-ascii?Q?UAs2kcUKCgcI2xoqrt1xlKow1zq+q/26Vp3GE8JIXDWU7QVnMZ7Tdh8+MsSQ?=
 =?us-ascii?Q?7fAZARavu2XnovmH/wl/kUaO9Tl2YZ1w/BbhpjwRPhiX20CAb7Tr/hziryhU?=
 =?us-ascii?Q?rc2In28sgWuawQlL4AIB1eksg2ungsuCVPFLnmdiUM6u4qCrNRJo8+si+nnu?=
 =?us-ascii?Q?w0EyVQUCWfxd623ymMt4w+nM/FuP0QWq78uOEld5d/x/oPFtNnYBogoLye1Z?=
 =?us-ascii?Q?ogJeG+Kb5a9mHgW5qC7yI5crH6HadgR2h0accl6my0hIQ562aZart7zgcrb2?=
 =?us-ascii?Q?koi7GP7QdOurSQG9snjZY/lMLpDDHY8GklCRpgBfqlJJuOF+iWq6HLGTaQg2?=
 =?us-ascii?Q?OEoVGevDQi+J5pbwGGT6ilewI4hY9aPzifmp+/wPTX641bcscCtagM1MqO4c?=
 =?us-ascii?Q?3I21UgyDXFXaKcUYqr6iYZ6K92DvcimchlnpnosejIiOYDXbaa0CO99g+AFJ?=
 =?us-ascii?Q?MHZ5ofhzyp5KjFHbuj00KdKuQd04FoH0A/uX6G69VafSrxQ+8RmcUieEGGCf?=
 =?us-ascii?Q?vqN/cUsB2Dt9BRkwZkO7t/3LAtJxTjnvEz+z9hhAIDnr7DfVTWJ7k9/gbOhI?=
 =?us-ascii?Q?xTPAsvmGYEDYiFDvVZWnkwkRW7IWuF1VS0ZRgmCaMVRsKWcwDbltbAn1p8CY?=
 =?us-ascii?Q?l5yNLzi/b9qiwkdhEOJOG8YPAi7CauHMamqBDTZT0W405YaYry0sMUHq7TYj?=
 =?us-ascii?Q?jUR6uLFFRIW4qSrG99eBDh5Teibi1VrE75aWORAxJt2KcxV8OzJ9bYUfk6LD?=
 =?us-ascii?Q?gyUTSOktvRDoblQKmwWyKSk0tluEqh8JiH/YZBp651o9iiU/+Qh/5XBz59B+?=
 =?us-ascii?Q?R9BJQWwDG5reC/x0NebK9x4b6IO4gfcCSKKPLE2HbkvnDbcV0mPk2CtGcb3g?=
 =?us-ascii?Q?H9h57iDYFyRtd7HV09b8MzQbWTGs9M/Vd9AqCm+58T5Td5mA8ism2Lr2AHuH?=
 =?us-ascii?Q?t2Lyq+k5ZBIajdkNv6uEyP33GfNMYQ+XaPo4LSludo3Fcrcyk3hUh1Vb7qug?=
 =?us-ascii?Q?deGzuqZ8jhe14w0Ic9s06NdlfYKfbmzXcLub/lASYhcq1eOsDbvQIX1Py6vF?=
 =?us-ascii?Q?pZ7meGLxuxj/GdSr5ueHEk17Fo7aPy9w/B8Id2chBiUzF0e7pgvCPYMhZ6Ah?=
 =?us-ascii?Q?4+xro7mhKna1Vo2+TIRYV+vsjvqeEhKQ6DHwqcrdlMnM6jWfsSqNaWgaa7vf?=
 =?us-ascii?Q?ducNTpq1aShpbyD1qdiFXb6QtJirsJVaBrITYFuSMEeIm5KCrfrDSTwYdZTp?=
 =?us-ascii?Q?f/1o15IaFXETJPsxMDsW4tqC68zU5CRg9rP3qtl1yCcPKQTWH3i312+ezf4P?=
 =?us-ascii?Q?wiNdrnmhAkH14Yk8SaL5zrrDzhSIiDmlykYkV/PEjyTkq33k5EXQAuErL2Hn?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78dcb474-b6fd-436f-d846-08dc315586d8
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5595.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 14:17:38.5251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8w49U9LQjVewqBD9N7sbArkXlPpdFCHilwLcDMpjKTyJt6yGTZR4gGZAc5pNpLfgu4W53+PdzvKeZXAS2DaZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5864

From: lipeifeng <lipeifeng@oppo.com>

The patch to support folio_referenced to control the bevavior
of walk_rmap, which for some thread to hold the lock in rmap_walk
instead of try_lock when using folio_referenced.

Signed-off-by: lipeifeng <lipeifeng@oppo.com>
---
 include/linux/rmap.h |  5 +++--
 mm/rmap.c            |  5 +++--
 mm/vmscan.c          | 16 ++++++++++++++--
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b7944a8..846b261 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -623,7 +623,8 @@ static inline int folio_try_share_anon_rmap_pmd(struct folio *folio,
  * Called from mm/vmscan.c to handle paging out
  */
 int folio_referenced(struct folio *, int is_locked,
-			struct mem_cgroup *memcg, unsigned long *vm_flags);
+			struct mem_cgroup *memcg, unsigned long *vm_flags,
+			unsigned int rw_try_lock);
 
 void try_to_migrate(struct folio *folio, enum ttu_flags flags);
 void try_to_unmap(struct folio *, enum ttu_flags flags);
@@ -739,7 +740,7 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 
 static inline int folio_referenced(struct folio *folio, int is_locked,
 				  struct mem_cgroup *memcg,
-				  unsigned long *vm_flags)
+				  unsigned long *vm_flags, unsigned int rw_try_lock)
 {
 	*vm_flags = 0;
 	return 0;
diff --git a/mm/rmap.c b/mm/rmap.c
index f5d43ed..15d1fba 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -952,6 +952,7 @@ static bool invalid_folio_referenced_vma(struct vm_area_struct *vma, void *arg)
  * @is_locked: Caller holds lock on the folio.
  * @memcg: target memory cgroup
  * @vm_flags: A combination of all the vma->vm_flags which referenced the folio.
+ * @rw_try_lock: if try_lock in rmap_walk
  *
  * Quick test_and_clear_referenced for all mappings of a folio,
  *
@@ -959,7 +960,7 @@ static bool invalid_folio_referenced_vma(struct vm_area_struct *vma, void *arg)
  * the function bailed out due to rmap lock contention.
  */
 int folio_referenced(struct folio *folio, int is_locked,
-		     struct mem_cgroup *memcg, unsigned long *vm_flags)
+		     struct mem_cgroup *memcg, unsigned long *vm_flags, unsigned int rw_try_lock)
 {
 	int we_locked = 0;
 	struct folio_referenced_arg pra = {
@@ -970,7 +971,7 @@ int folio_referenced(struct folio *folio, int is_locked,
 		.rmap_one = folio_referenced_one,
 		.arg = (void *)&pra,
 		.anon_lock = folio_lock_anon_vma_read,
-		.try_lock = true,
+		.try_lock = rw_try_lock ? true : false,
 		.invalid_vma = invalid_folio_referenced_vma,
 	};
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4f9c854..0296d48 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -136,6 +136,9 @@ struct scan_control {
 	/* Always discard instead of demoting to lower tier memory */
 	unsigned int no_demotion:1;
 
+	/* if try_lock in rmap_walk */
+	unsigned int rw_try_lock:1;
+
 	/* Allocation order */
 	s8 order;
 
@@ -827,7 +830,7 @@ static enum folio_references folio_check_references(struct folio *folio,
 	unsigned long vm_flags;
 
 	referenced_ptes = folio_referenced(folio, 1, sc->target_mem_cgroup,
-					   &vm_flags);
+					   &vm_flags, sc->rw_try_lock);
 	referenced_folio = folio_test_clear_referenced(folio);
 
 	/*
@@ -1501,6 +1504,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
 		.may_unmap = 1,
+		.rw_try_lock = 1,
 	};
 	struct reclaim_stat stat;
 	unsigned int nr_reclaimed;
@@ -2038,7 +2042,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 		/* Referenced or rmap lock contention: rotate */
 		if (folio_referenced(folio, 0, sc->target_mem_cgroup,
-				     &vm_flags) != 0) {
+				     &vm_flags, sc->rw_try_lock) != 0) {
 			/*
 			 * Identify referenced, file-backed active folios and
 			 * give them one more trip around the active list. So
@@ -2096,6 +2100,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 		.may_unmap = 1,
 		.may_swap = 1,
 		.no_demotion = 1,
+		.rw_try_lock = 1,
 	};
 
 	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, false);
@@ -5442,6 +5447,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
 		.may_swap = true,
 		.reclaim_idx = MAX_NR_ZONES - 1,
 		.gfp_mask = GFP_KERNEL,
+		.rw_try_lock = 1,
 	};
 
 	buf = kvmalloc(len + 1, GFP_KERNEL);
@@ -6414,6 +6420,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 		.may_writepage = !laptop_mode,
 		.may_unmap = 1,
 		.may_swap = 1,
+		.rw_try_lock = 1,
 	};
 
 	/*
@@ -6459,6 +6466,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 		.may_unmap = 1,
 		.reclaim_idx = MAX_NR_ZONES - 1,
 		.may_swap = !noswap,
+		.rw_try_lock = 1,
 	};
 
 	WARN_ON_ONCE(!current->reclaim_state);
@@ -6503,6 +6511,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_unmap = 1,
 		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
 		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
+		.rw_try_lock = 1,
 	};
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
@@ -6764,6 +6773,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		.gfp_mask = GFP_KERNEL,
 		.order = order,
 		.may_unmap = 1,
+		.rw_try_lock = 1,
 	};
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
@@ -7223,6 +7233,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 		.may_unmap = 1,
 		.may_swap = 1,
 		.hibernation_mode = 1,
+		.rw_try_lock = 1,
 	};
 	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
 	unsigned long nr_reclaimed;
@@ -7381,6 +7392,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
 		.may_swap = 1,
 		.reclaim_idx = gfp_zone(gfp_mask),
+		.rw_try_lock = 1,
 	};
 	unsigned long pflags;
 
-- 
2.7.4


