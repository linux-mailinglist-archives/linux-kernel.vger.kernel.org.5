Return-Path: <linux-kernel+bounces-96469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30138875C97
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CDC1F21442
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704CF2B9AC;
	Fri,  8 Mar 2024 03:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="WS5dxpqn"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2128.outbound.protection.outlook.com [40.107.117.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25F928E09
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 03:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709867532; cv=fail; b=El0XKqKIVp9VDr0iH9JUaN5pJcCqcErlc8a9Kk4fA9Jlg8zfnYMnLZiNeetVxnTfxTUBDh5ACLs+EQ6ziLDCRP7YSrKyuuFIVwnborR/8+HLINsfogBZ2/7S9df4+UbKuaK7w60v4pFBlSp6fnTDrNDtykfD0VEeSGdQBZD1Vf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709867532; c=relaxed/simple;
	bh=WvZcWP+5uj3R88wA4OmRxexgnXVMmLy1I5uyq7p6Moo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WoKdyLj7WO+NQICEJX/J9MHVcbA5qk44bPWxWy/i0L2RRNym4Cw5Yr5cPJwBUGs8+Mpr6s6bnwblBksgrbMWbTvufEn35F0f8xVlfi3eBU8SMsP5pftBBEL7yY+XM4OsSv17dk3hVVhMQzYky/Nv6kffGQYrA+nfd9zb9Wp0f7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=WS5dxpqn; arc=fail smtp.client-ip=40.107.117.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBZpTXoA0n3QvPiJ6WVhycUYlOxdTJsyGKJFHbwvAZhvLoonbNLYPrOU613RbODrJYupZDkF3vy2JJqvS1avAPfkV3DKYIU5Vxf48Mqxjg+EFxfK4YZ9eXtafaSY02a3hyz9IvpON3/k57HCe6iEtMGgHDIsYy9U5/l+DGaXZRLXx23lnIoAto0KC9MvP43apZSl1y8UwTf/9s7ybvz0tpZDwvVP31ioH3p+baHEDYQLgjc5v/ZrBWTF8YRMZ+EO1rr6Wvvh8z6dCYh2HN3kCNpTfiy7wq68n+J5cpcaN+jM/CLisDC1cuRvqBzLyXn6G8OJjaKnXWUlc2Db0pquYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwHzvj99GpdRgeZZGtb+hWyxzYgczx5x7O7lITyx0jA=;
 b=f68rT+H6NbWtsgldQtfVtuFYwqf/ENk6Bl68N66460+gnj5+NRJqWuQDUIqXzITGrM7GgyUOlVm2EQ+1ABvLqBRjNn0STJ/CEHB6IxyTOaPVZaR2HbXLv/nTyJrGj1JOtBroduQo0LyYujQ3Wt0XoZXeyxufy3IBsPK+1XewK+m07y7+RQZFzlkolCeTuupAH30ZyAn9dTBKjw/IEFXFKLkjJIginzo8FR0ZW8TgoRmxPFZCFMC6RHU92vZhhkzjmYNMvwvg2myajm3dqu8cK1d0SdVSHdSqOIEDeMlw58/1RaugrPdYNNVxPnw/YyOQ/i//Q4y3feGUW0kZJZ+8sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwHzvj99GpdRgeZZGtb+hWyxzYgczx5x7O7lITyx0jA=;
 b=WS5dxpqnOn/eXfiY9II3yAI47FyRERRxx2NibJEfAkB+8GCGQr3hkyPguntiGf2PxhuH0JJOJLfWvwHKK2SmtADUWhaDk4QRT9dpzguBtHdGgjaF3dXANZJsbWQXlc6K/Up4zBGM6wwigZy9yv6w2DS/6jl2rwVYpyWDLAdYTdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
 by SI2PR02MB5539.apcprd02.prod.outlook.com (2603:1096:4:1a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 03:12:06 +0000
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::60d1:4349:510c:8133]) by TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::60d1:4349:510c:8133%4]) with mapi id 15.20.7339.031; Fri, 8 Mar 2024
 03:12:06 +0000
From: lipeifeng@oppo.com
To: lipeifeng@oppo.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	osalvador@suse.de,
	willy@infradead.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v2 1/2] mm/rmap: provide folio_referenced with the options to try_lock or lock
Date: Fri,  8 Mar 2024 11:11:25 +0800
Message-Id: <20240308031126.750-2-lipeifeng@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308031126.750-1-lipeifeng@oppo.com>
References: <20240308031126.750-1-lipeifeng@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:3:18::21) To TYZPR02MB5595.apcprd02.prod.outlook.com
 (2603:1096:400:1c5::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB5595:EE_|SI2PR02MB5539:EE_
X-MS-Office365-Filtering-Correlation-Id: b97105fd-2367-42b8-50a7-08dc3f1d88e9
X-LD-Processed: f1905eb1-c353-41c5-9516-62b4a54b5ee6,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pYPBl3wpIdnBU8cklijyU/4CeuxGinOb6RtJ4ZIYEBUUdurF4xu8DTgOEnJtWe71z4fl5NQmCPT5PGtJAgYva5PAja/XvDXWlL7riBLiPpI16O/VQcDqawFbzm05t3Wn6WEySpJyCDJV8ci6gBNN6bY3oA5/z9V4raTjKls+V6lo+LMUd3/JXlQJigLYa/WRbvzd2GEKvNDZd1i7SlpSondc1z7gp0D/Ocbu22M7nqo2O05/+aPtK2c5meYt1Z8GJ+KCNClCsI3oJPxmzW6zOPMBvbZTsIm3cpl7l36ECNzCIr/i6JeESiDuidxMNsJEmUcOa29wP4kE12KGbtxx+Gzn+0GHB5wOAO5sBgB9hEPtpsgI3saaJnYk3wPi9eh+yDZYgGYsMlXm+U1j3cxlCS9D2MB0hoJqsFhQXhVOAxAI2cSokwREtXCFiFmU7nSd3pxZvr1d710OgrqMAI/M3MEX3Xc87UXRZLa5+OxycZ5vnlSPviOL1ma1gZXlghyLPEYQFXMtu3arjiW5smcQmjcAjLGNVKRsld6aLY79U2S3cD0duLAksecMeoW+okxltyWQ/8svxMEnU9APJsGmy851Mze5rHY1Ni5cZTg+gqve/APor/dyC35/jUij7avTOV+zht6jKY+zZFAKpRBR8+plpot/lh9nIZVy2SVZAzQaQwqXryagZtUnlvSc3EpY2ChDTv0L8JqoIUMncMmNfXtKGMYlmfiG/PaH+hC2rKs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5595.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4rbcwn3A6z6tsevDw3aP7XVSIMGHrGUKLcI+aj54UEc6igGjEy1eCTn9/TC3?=
 =?us-ascii?Q?Fluphykfb4LANWJSxuTwTmWkuVsePer3JCY8zA0r106U3BJ7hPhMC781Y6Q4?=
 =?us-ascii?Q?WlX5p28XZpWBaun34uGxZpIpNYVUXqUvNGG0MWvyCp0ZWiIvVvXH+JB8Y1Tz?=
 =?us-ascii?Q?qzS0Ivg9dWUyDemAl7Y8Nc9jnln8JZp68oYLqpOc++sxoJp0VarNYySzkQYi?=
 =?us-ascii?Q?XYIftZbYXhRwbj4fd6sM1po5U6sGsAu9WHSw9BXDKuUtdX6hVgFV8BenPr2h?=
 =?us-ascii?Q?whjtqUymN8xXdRdgfO78E99I4m/WBVGBNL1IDK4eb1x+I4+uiMe7tRea8wh0?=
 =?us-ascii?Q?vNJs7ALTmY6gNh8Vzp5DO3Y9xwss/vOqSVjRhw1E4QKn+4p0GXqlpYElQB4x?=
 =?us-ascii?Q?F/7H5mnunSGsNA5Sv+0bLG7GlEJcV4RK1z0Nm8Fcud8IfRPa3sj3dLVnPP4X?=
 =?us-ascii?Q?CGUV3r3MUf5upoqFkAL8cZlSEqscIpOoAh6IHESvjIRxmffZwmoL60iaVP5U?=
 =?us-ascii?Q?+aEqfN/9y1ZFKzasz8s8HyImiDTedJ8bE/ywJh3EF8p+5Cm72ibAYrvA7X1A?=
 =?us-ascii?Q?1+Lmbr8hK1E6VRfwJ+yxJXZ1wW4AKKekUqrP6Fjl/FA3b0971eXF/0b0GvdJ?=
 =?us-ascii?Q?CXK8inGpOgTxLJTjT/EGjZBSIIuXKvMhzcziKHIWmeoH9ErQG41EPX1pI0gs?=
 =?us-ascii?Q?WBlV94b58NBY6BtqqjniTK4Ac2hFjpbUcJ0U0hRhbBQnriSjkFYlrorTZiAs?=
 =?us-ascii?Q?TATrE1PTYsQTXL41wkuDiAH+6gmsl3YMLGkXNBjUHsXkcG+9WHb1qiunwcgh?=
 =?us-ascii?Q?BCsKjGCoxUoHQtzSxq+3f3peWqeFaYzNBlzWU6o9OZJnx8vB9IFDah8AxoTk?=
 =?us-ascii?Q?oMRzU83IRg6qII3ji8Iaq9JoADD6Xxe2KvEfKV1K7I1/lZGIg9kB5IBoc6Xj?=
 =?us-ascii?Q?RTgePBFIiI77obR0Pz0M1D2ys6yO1FxOhW3fin6pK9jmg5Xq6jVJEh8pjfJX?=
 =?us-ascii?Q?HBTuJVNixbf5q3xez9BecQb/S/9HRk7pZJC/SX4Tp3amOag/YxFbxTMefCUI?=
 =?us-ascii?Q?pdm2nZV1PQ330TbhTIiQnFl4b1Wk9qU89KWQG8vsGw0rgDDdHWe0u82jcdg9?=
 =?us-ascii?Q?dPxeEVpAUGkWhqP/l76UZ7gRhp2ERDZuxuSy41+9oPFr3qE1xbVLzocQvnkX?=
 =?us-ascii?Q?tUW59jkDmyut8ywAvQ3nK1jkA7QmKNZNglN6Y+2h+ZEf1umd9cNa4ZwY/GwU?=
 =?us-ascii?Q?UyW8sp9kl3TiZPtAUsyWlBrGF/+9kHbzoJUwBpS4PPyu3CYo96zS4S96fKdQ?=
 =?us-ascii?Q?epiDo2dWV53+ztlPWRPFssmzN/KHROk69mXGTsIbKF7xya2wz7D+Ny0+bGTm?=
 =?us-ascii?Q?Ozz8+VDoUHRE+AmFHk19LYb5MYusi0/rQ/Qk+C35I7cCfWU95LBIkJlab49Z?=
 =?us-ascii?Q?wB2pnpOb/KbMHYu1apGpaN2jYZFfUP2PhL6SpD8hx33LXFoSII4a5uhcZbKG?=
 =?us-ascii?Q?+0z4C7TunBxdgJXOZmTRKXWvnNqdLMfjBWBRSxrushHiJ3sqH2CJFk4aXCfH?=
 =?us-ascii?Q?Dn9Fju/iU0k3vmj+aVr2lulLtNPg9ZGIm9SPwKzE?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97105fd-2367-42b8-50a7-08dc3f1d88e9
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5595.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 03:12:06.4725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoSPn635gYLQ22J+0PizwSEIsnDGTtiZgBdyt6/FHnxtGIY0sN4pWSV8bhcfuIKpqIDlrUuNk+0JYPMXb0MQww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5539

From: Peifeng Li <lipeifeng@oppo.com>

The commit 6d4675e60135 ("mm: don't be stuck to rmap lock on reclaim path")
unconditionally switches to try_lock to avoid lock contention. This patch
introduces a parameter to allow folio_referenced to genuinely wait and
hold the lock in certain scenarios.
Before introducing the new context, we always set try_lock to true to
maintain the current behavior of the code.

Signed-off-by: Peifeng Li <lipeifeng@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/rmap.h |  5 +++--
 mm/rmap.c            |  5 +++--
 mm/vmscan.c          | 16 ++++++++++++++--
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b7944a833668..846b2617a9f2 100644
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
index 3746a5531018..7d01f81ca587 100644
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
index a0e53999a865..509b5e0dffd3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -147,6 +147,9 @@ struct scan_control {
 	/* Always discard instead of demoting to lower tier memory */
 	unsigned int no_demotion:1;
 
+	/* if try_lock in rmap_walk */
+	unsigned int rw_try_lock:1;
+
 	/* Allocation order */
 	s8 order;
 
@@ -850,7 +853,7 @@ static enum folio_references folio_check_references(struct folio *folio,
 	unsigned long vm_flags;
 
 	referenced_ptes = folio_referenced(folio, 1, sc->target_mem_cgroup,
-					   &vm_flags);
+					   &vm_flags, sc->rw_try_lock);
 	referenced_folio = folio_test_clear_referenced(folio);
 
 	/*
@@ -1522,6 +1525,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
 		.may_unmap = 1,
+		.rw_try_lock = 1,
 	};
 	struct reclaim_stat stat;
 	unsigned int nr_reclaimed;
@@ -2059,7 +2063,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 		/* Referenced or rmap lock contention: rotate */
 		if (folio_referenced(folio, 0, sc->target_mem_cgroup,
-				     &vm_flags) != 0) {
+				     &vm_flags, sc->rw_try_lock) != 0) {
 			/*
 			 * Identify referenced, file-backed active folios and
 			 * give them one more trip around the active list. So
@@ -2114,6 +2118,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 		.may_unmap = 1,
 		.may_swap = 1,
 		.no_demotion = 1,
+		.rw_try_lock = 1,
 	};
 
 	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, ignore_references);
@@ -5459,6 +5464,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
 		.may_swap = true,
 		.reclaim_idx = MAX_NR_ZONES - 1,
 		.gfp_mask = GFP_KERNEL,
+		.rw_try_lock = 1,
 	};
 
 	buf = kvmalloc(len + 1, GFP_KERNEL);
@@ -6436,6 +6442,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 		.may_writepage = !laptop_mode,
 		.may_unmap = 1,
 		.may_swap = 1,
+		.rw_try_lock = 1,
 	};
 
 	/*
@@ -6481,6 +6488,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 		.may_unmap = 1,
 		.reclaim_idx = MAX_NR_ZONES - 1,
 		.may_swap = !noswap,
+		.rw_try_lock = 1,
 	};
 
 	WARN_ON_ONCE(!current->reclaim_state);
@@ -6527,6 +6535,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_unmap = 1,
 		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
 		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
+		.rw_try_lock = 1,
 	};
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
@@ -6788,6 +6797,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		.gfp_mask = GFP_KERNEL,
 		.order = order,
 		.may_unmap = 1,
+		.rw_try_lock = 1,
 	};
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
@@ -7257,6 +7267,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 		.may_unmap = 1,
 		.may_swap = 1,
 		.hibernation_mode = 1,
+		.rw_try_lock = 1,
 	};
 	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
 	unsigned long nr_reclaimed;
@@ -7415,6 +7426,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
 		.may_swap = 1,
 		.reclaim_idx = gfp_zone(gfp_mask),
+		.rw_try_lock = 1,
 	};
 	unsigned long pflags;
 
-- 
2.34.1


