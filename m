Return-Path: <linux-kernel+bounces-71465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264D585A5AB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946AA1F257F6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3344A376F4;
	Mon, 19 Feb 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="jR5wQ3AT"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2097.outbound.protection.outlook.com [40.107.215.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC03715E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352267; cv=fail; b=MHhboo6pW4oSfU1O69a4QgOyGWWCJIfl8eiJkQl2250OJ1IQfoXNhIXNlBcK5Hu4GuK2stBdNWbIiURB5edmwf+gXZgd74067XzOcjEhcHrA7rKreSM+a14NCATHJvA7Q21n6uLkB9lzCrX0xPIrH7wIwXWTad2XV6xU9b0Q6bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352267; c=relaxed/simple;
	bh=rTxCxiu0kMN5bcUwxJ628g2Tiykmb740pskJH+i4syQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N8Wsm11AVmP9SFWTcRbtaCW7aN88KNN7h0fgzeGWQeuVtV/QgG3eQFOIvu7Q//YP+87h6zkaEv2JtbvNrPzKCOLp5Z7KK4GiJr5k/880aJWxyDyVlg3FrQLC5BeoIatcGsynoPqTIkgpunbkMQXAv8SALPH+39SbnhCCA+L1gYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=jR5wQ3AT; arc=fail smtp.client-ip=40.107.215.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYNE3ANhPKBXYBbM8iHBLlt5ngzBc3vMuZ2eo85L/w2KtjhIP3EcnhGWRxDz8Y9pfyCHAJw6uUXhMJKD3+KPn2LZbjJgBliRKIaE7Apuctd7DWRifotE9zQ3JsmiVTh5/55wsFcRySo7BYibWN75TA7DFa9K8tTY3tPwqs9YOngFR3/gGRycdwKYH/lHU8y0THMX+lleOXOTDzAhFj67OTn6BgMeXd8E9WOM9+c42nvxZoDQHzh0Y8AP+a1alqRm8/7LYCwawwQF29JyMHPUUad93FT9gGHDICzl2L4UDzxmJ7fuvB07/ZN/5/S3pAXQCmH81LEmHFjot1MlfyhaxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEn8wt027nANIH/HsoakEVsADqO1YDYUv4uD+sqT1h0=;
 b=HWFIEltSPy6yrHXvcoHNyiWQmCnGHVPEJEnLeRXj+h3hjhiy05eNO1sO0o+rhHuYvve1tZD0bKGZnyRtpAtjnUB/eTl9T9y4AkOY8T5yl8VVA5etZTXmeZ5aiYuP0oLXiYZB6ef8CJM2wENDaIbjC+2gWS3qkm7krocjAXUHtpqIJzL3UO/AZHcIybh3lDnoQ28+zYDfKM/PoOYgSaA2pm0hqcr+qMN8qCaQcjwJay87p1ZReDGBTKBfJFQF811aIsbqjSYgbc0uPougMM0f9h8FdbjXKXTXVSiJPsexN37Q97HW2nIx5dpm4U6tAGOqONxZ1j0I6fyy8r2KVmxeIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEn8wt027nANIH/HsoakEVsADqO1YDYUv4uD+sqT1h0=;
 b=jR5wQ3ATqzYtFHi36StysqFFq6we0OD6No0wPs/a+zxo1qJWbTTxpz/ManGoQNbfqAJfPLbe66BXAt4KGH+j3h9tszwvuaYPVEcw+BpZIt7zoTGrPUHwK5ER8+Z6zb8XtaZk/MKLrGZ/M+l5Nq1F8Bn9pbHUwHba70f4e1Kk/lw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
 by SEZPR02MB5864.apcprd02.prod.outlook.com (2603:1096:101:73::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Mon, 19 Feb
 2024 14:17:41 +0000
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::9b7:25b2:5977:633a]) by TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::9b7:25b2:5977:633a%3]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 14:17:41 +0000
From: lipeifeng@oppo.com
To: lipeifeng@oppo.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	osalvador@suse.de
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: support kshrinkd
Date: Mon, 19 Feb 2024 22:17:03 +0800
Message-Id: <20240219141703.3851-3-lipeifeng@oppo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ec98647c-7832-4569-41ee-08dc31558877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Iyrbn7BC6tC0L4ETRa4PsRENmHS67zKOPE95uG7vXzVpvcBvp6H+vWaQQCunXB5Bi6g/B5vY7deeH3vt+VmhISLpFexepPvqnghNqyX6bIyRYIuy3epoQ/mnGMXp6VFe8h30ifhkeN5aMSU4HqKNO/CCc/KlJWxyKrGkVAkecDZ10/kkV/r7hayaz1LcsYLNbF2WSppqc6Fd67PW26o6rH/yJ2pXvnA5dJPw3XZcxZfQ+tReXnclCEUybU43B1o4egLM196eliHePFRqccAim4vn2mBIVx/DMrCwCDJCoa/DG1HF01HqoiTBm0Fbp2h+2oq0mnCiDaOhTCsd7AY0oHdilMpHdL/osv25qo/n0cIB8p7uyotA4P096Sexm0I7/j6Dawe+9fzLb9hOamb5HO25/YtLeWzHam7ftBSCZzuFOuHm3q+rgScHC9w4qnXGD8lSsqIqOkPGArDQeDEQMeJWCsKAyspBOqtbrPn6zlDgYI7b30nFSm/yVi7bm+sRsrsj16GTjuZWf5QNy1q/1cTHja51Y3P6Jv6KP3DGbST/dRM165CvJR8iot+u5qPDeSa+j2njQS4g4XIfbx+taQEK5ZhrAMZAOWc4MQx4Vku813RqkYvpWOWClwSF/EE5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5595.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aRiyMsWgsd/K31XEzN4tJMQrkgl1fgQk2BkG3ezdcdJDCDEdy/8jKBJi9Izr?=
 =?us-ascii?Q?fi7377wJqZ668rle7A5VbHw2JhQSMCAPe5QKM7pRBlw5YgYusn6Y4+HTZqWz?=
 =?us-ascii?Q?X5ckRF85lOvpUSgORwIGfL1MXL4kSMSRoEDmqZqVnZhlTvT1TtNQJFyG3eKL?=
 =?us-ascii?Q?t1km3PemUg6Mn6VuVASlCGRjFgzrutScd+hJ4+j2HvYAnGbVo9JLnxh6lzl+?=
 =?us-ascii?Q?tS5LsxkBUExu7EYNTToM3Cq+SyiV/fkjoeagGriNE9UTXVsyPc6IupOWBmpi?=
 =?us-ascii?Q?OUoQwPVpORi1fZsI7aE4ZLA9vA0Em48KZT2Z3pdGGJd2NmGYZ4VnRqDWyFJJ?=
 =?us-ascii?Q?gvRh3P2lQbehJDQQuYTOAmc574ke5vAhMmcxyOEwI1spmsYT2kamZV61mplj?=
 =?us-ascii?Q?UtwgG2JBf8i9W8jr9hBPFy66vVvb7DsOrqQprMkZjN/uhs4Z6oU8LM7skrBI?=
 =?us-ascii?Q?Vbl6E/bIpPGFUKJ/+pq7lcaRWbyzFKGhMelP43ytreNq2gBuIxD445Gt6gkn?=
 =?us-ascii?Q?2GLZBx42eNPRG3jAvIYgFuJVndDDb4z2b25q7/yl1MOl8NaRQOlfyqbwvM8j?=
 =?us-ascii?Q?4gwnKPHIy0FaRQTS/gwKnjW1Bd78tLAwvZKHALlVoK2TrxVKWTehrMq+nDGl?=
 =?us-ascii?Q?Cde6BHxeHRzmOX/DNEMdXtYINEux2RkjZbQqCPGr2dgCdxKJSlc+ddqRpzug?=
 =?us-ascii?Q?R/rQTGnMitcxEuctWQTpI7jIezmJwS+rDHvaeeAI9NtXmIEuoZboY5k5McKe?=
 =?us-ascii?Q?x0aCZvtFtBkh7L1wc8NjX1n97wfI+mzv0S9WCTFtyZe2R/E9dHncY02bUexc?=
 =?us-ascii?Q?64xfij3Q6Qi9TQ2AnFH4HjPjFuSt3bGoX54GJYVh4nR6D17skFlkuctMZVZK?=
 =?us-ascii?Q?dX2LHqRCr1YS37CzLHi52xmwbDW9u7H1lBbp+r3YKdYQZX5QtAnJeM622Zj8?=
 =?us-ascii?Q?7ik6KHbn/h/GNPBZXJsv2vPjIoYFHn7jGrft6oLBOeBjS8ZpTYSEXPpkaegN?=
 =?us-ascii?Q?GkxgIS7bf6JzA6Hd9fPG+MMtOwZc2JmM+CdyHM+6q5WYXv+6GKlXldFne9pF?=
 =?us-ascii?Q?4txqCRpf5Y0nsCsu2U49QniTjwd/D53mifr9EidAV/qTYl4xEvQ+MphZmuvq?=
 =?us-ascii?Q?imKPWdEQ6+pArF7L8kS48jiDSKY9yqvhcPRnjSSw8y5uESaO+AXEvsmeYA04?=
 =?us-ascii?Q?U07ovAJgOqcvYXhXiovaMPXKySsAfJ97DkA3n1dpj3lZhXCrvglCybByHWg7?=
 =?us-ascii?Q?3eHAyA41PpDmUDR7v5iENafhBdsqSawpYeLOeznLzHIj1R9z13e84Lge0fQs?=
 =?us-ascii?Q?p0FPJPzcot9gRsBO+aF3ZQ+ofaAgUaPiL42Sa0FuozdhocmPu8VBq//0Zxxx?=
 =?us-ascii?Q?bu4yrEDQaVc1+eCvna2SppcMYlFdoQn+klPZo8xPwF3rw9R7wfqhJtc+q/06?=
 =?us-ascii?Q?3A82sHaZicQEUExl7pRWFa7yXCuw5H8SWgKj7SLmCrIelfsCt4kj/MyJbCJ6?=
 =?us-ascii?Q?SVBO+OWYYIvRXZ6o5RPgGjrtF+xFuzAua+1jbKhB5BDLiVKus/GgCRrILFU3?=
 =?us-ascii?Q?8HPBJxDtHjrSa/a5wXga0ju2XNNJk4dS2SAHkQnJNKmItNgSEGEw8dW9GCDb?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec98647c-7832-4569-41ee-08dc31558877
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5595.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 14:17:41.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYtAf7VnBuZffOxYBBJcTrAum2icIV/cT1Q290eopKoxicHiLTao45NssgnLgxF8DVm3X8V/xQmw4r1ZoSjtVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5864

From: lipeifeng <lipeifeng@oppo.com>

'commit 6d4675e60135 ("mm: don't be stuck to rmap lock on reclaim path")'
The above patch would avoid reclaim path to stuck rmap lock.
But it would cause some folios in LRU not sorted by aging because
the contended-folio in rmap_walk would be putback to the head of LRU
when shrink_folio_list even if the folio is very cold.

Monkey-test in phone for 300 hours shows that almost one-third of the
contended-pages can be freed successfully next time, putting back those
folios to LRU's head would break the rules of LRU.
- pgsteal_kshrinkd 262577
- pgscan_kshrinkd 795503

For the above reason, the patch setups new kthread:kshrinkd to reclaim
the contended-folio in rmap_walk when shrink_folio_list, to avoid to
break the rules of LRU.

Signed-off-by: lipeifeng <lipeifeng@oppo.com>
---
 include/linux/mmzone.h        |   6 ++
 include/linux/swap.h          |   3 +
 include/linux/vm_event_item.h |   2 +
 mm/memory_hotplug.c           |   2 +
 mm/vmscan.c                   | 189 +++++++++++++++++++++++++++++++++++++++++-
 mm/vmstat.c                   |   2 +
 6 files changed, 201 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a497f18..83d7202 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1329,6 +1329,12 @@ typedef struct pglist_data {
 
 	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
 
+	struct list_head kshrinkd_folios; /* rmap_walk contended folios list*/
+	spinlock_t kf_lock; /* Protect kshrinkd_folios list*/
+
+	struct task_struct *kshrinkd; /* reclaim kshrinkd_folios*/
+	wait_queue_head_t kshrinkd_wait;
+
 #ifdef CONFIG_COMPACTION
 	int kcompactd_max_order;
 	enum zone_type kcompactd_highest_zoneidx;
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4db00dd..155fcb6 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -435,6 +435,9 @@ void check_move_unevictable_folios(struct folio_batch *fbatch);
 extern void __meminit kswapd_run(int nid);
 extern void __meminit kswapd_stop(int nid);
 
+extern void kshrinkd_run(int nid);
+extern void kshrinkd_stop(int nid);
+
 #ifdef CONFIG_SWAP
 
 int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 747943b..ee95ab1 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -38,9 +38,11 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		PGLAZYFREED,
 		PGREFILL,
 		PGREUSE,
+		PGSTEAL_KSHRINKD,
 		PGSTEAL_KSWAPD,
 		PGSTEAL_DIRECT,
 		PGSTEAL_KHUGEPAGED,
+		PGSCAN_KSHRINKD,
 		PGSCAN_KSWAPD,
 		PGSCAN_DIRECT,
 		PGSCAN_KHUGEPAGED,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2189099..1b6c4c6 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1209,6 +1209,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 
 	kswapd_run(nid);
 	kcompactd_run(nid);
+	kshrinkd_run(nid);
 
 	writeback_set_ratelimit();
 
@@ -2092,6 +2093,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	}
 
 	if (arg.status_change_nid >= 0) {
+		kshrinkd_stop(node);
 		kcompactd_stop(node);
 		kswapd_stop(node);
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0296d48..63e4fd4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -139,6 +139,9 @@ struct scan_control {
 	/* if try_lock in rmap_walk */
 	unsigned int rw_try_lock:1;
 
+	/* need kshrinkd to reclaim if rwc trylock contended*/
+	unsigned int need_kshrinkd:1;
+
 	/* Allocation order */
 	s8 order;
 
@@ -190,6 +193,17 @@ struct scan_control {
  */
 int vm_swappiness = 60;
 
+/*
+ * Wakeup kshrinkd those folios which lock-contended in ramp_walk
+ * during shrink_folio_list, instead of putting back to the head
+ * of LRU, to avoid to break the rules of LRU.
+ */
+static void wakeup_kshrinkd(struct pglist_data *pgdat)
+{
+	if (likely(pgdat->kshrinkd))
+		wake_up_interruptible(&pgdat->kshrinkd_wait);
+}
+
 #ifdef CONFIG_MEMCG
 
 /* Returns true for reclaim through cgroup limits or cgroup interfaces. */
@@ -821,6 +835,7 @@ enum folio_references {
 	FOLIOREF_RECLAIM_CLEAN,
 	FOLIOREF_KEEP,
 	FOLIOREF_ACTIVATE,
+	FOLIOREF_LOCK_CONTENDED,
 };
 
 static enum folio_references folio_check_references(struct folio *folio,
@@ -841,8 +856,12 @@ static enum folio_references folio_check_references(struct folio *folio,
 		return FOLIOREF_ACTIVATE;
 
 	/* rmap lock contention: rotate */
-	if (referenced_ptes == -1)
-		return FOLIOREF_KEEP;
+	if (referenced_ptes == -1) {
+		if (sc->need_kshrinkd && folio_pgdat(folio)->kshrinkd)
+			return FOLIOREF_LOCK_CONTENDED;
+		else
+			return FOLIOREF_KEEP;
+	}
 
 	if (referenced_ptes) {
 		/*
@@ -1012,6 +1031,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	LIST_HEAD(ret_folios);
 	LIST_HEAD(free_folios);
 	LIST_HEAD(demote_folios);
+	LIST_HEAD(contended_folios);
 	unsigned int nr_reclaimed = 0;
 	unsigned int pgactivate = 0;
 	bool do_demote_pass;
@@ -1028,6 +1048,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		enum folio_references references = FOLIOREF_RECLAIM;
 		bool dirty, writeback;
 		unsigned int nr_pages;
+		bool lock_contended = false;
 
 		cond_resched();
 
@@ -1169,6 +1190,9 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		case FOLIOREF_KEEP:
 			stat->nr_ref_keep += nr_pages;
 			goto keep_locked;
+		case FOLIOREF_LOCK_CONTENDED:
+			lock_contended = true;
+			goto keep_locked;
 		case FOLIOREF_RECLAIM:
 		case FOLIOREF_RECLAIM_CLEAN:
 			; /* try to reclaim the folio below */
@@ -1449,7 +1473,10 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 keep_locked:
 		folio_unlock(folio);
 keep:
-		list_add(&folio->lru, &ret_folios);
+		if (unlikely(lock_contended))
+			list_add(&folio->lru, &contended_folios);
+		else
+			list_add(&folio->lru, &ret_folios);
 		VM_BUG_ON_FOLIO(folio_test_lru(folio) ||
 				folio_test_unevictable(folio), folio);
 	}
@@ -1491,6 +1518,14 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	free_unref_page_list(&free_folios);
 
 	list_splice(&ret_folios, folio_list);
+
+	if (!list_empty(&contended_folios)) {
+		spin_lock_irq(&pgdat->kf_lock);
+		list_splice(&contended_folios, &pgdat->kshrinkd_folios);
+		spin_unlock_irq(&pgdat->kf_lock);
+		wakeup_kshrinkd(pgdat);
+	}
+
 	count_vm_events(PGACTIVATE, pgactivate);
 
 	if (plug)
@@ -1505,6 +1540,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 		.gfp_mask = GFP_KERNEL,
 		.may_unmap = 1,
 		.rw_try_lock = 1,
+		.need_kshrinkd = 0,
 	};
 	struct reclaim_stat stat;
 	unsigned int nr_reclaimed;
@@ -2101,6 +2137,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 		.may_swap = 1,
 		.no_demotion = 1,
 		.rw_try_lock = 1,
+		.need_kshrinkd = 0,
 	};
 
 	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, false);
@@ -5448,6 +5485,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
 		.reclaim_idx = MAX_NR_ZONES - 1,
 		.gfp_mask = GFP_KERNEL,
 		.rw_try_lock = 1,
+		.need_kshrinkd = 0,
 	};
 
 	buf = kvmalloc(len + 1, GFP_KERNEL);
@@ -6421,6 +6459,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 		.may_unmap = 1,
 		.may_swap = 1,
 		.rw_try_lock = 1,
+		.need_kshrinkd = 1,
 	};
 
 	/*
@@ -6467,6 +6506,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 		.reclaim_idx = MAX_NR_ZONES - 1,
 		.may_swap = !noswap,
 		.rw_try_lock = 1,
+		.need_kshrinkd = 0,
 	};
 
 	WARN_ON_ONCE(!current->reclaim_state);
@@ -6512,6 +6552,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
 		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
 		.rw_try_lock = 1,
+		.need_kshrinkd = 0,
 	};
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
@@ -6774,6 +6815,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		.order = order,
 		.may_unmap = 1,
 		.rw_try_lock = 1,
+		.need_kshrinkd = 1,
 	};
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
@@ -7234,6 +7276,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 		.may_swap = 1,
 		.hibernation_mode = 1,
 		.rw_try_lock = 1,
+		.need_kshrinkd = 0,
 	};
 	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
 	unsigned long nr_reclaimed;
@@ -7304,6 +7347,145 @@ static int __init kswapd_init(void)
 
 module_init(kswapd_init)
 
+static int kshrinkd_should_run(pg_data_t *pgdat)
+{
+	int should_run;
+
+	spin_lock_irq(&pgdat->kf_lock);
+	should_run = !list_empty(&pgdat->kshrinkd_folios);
+	spin_unlock_irq(&pgdat->kf_lock);
+
+	return should_run;
+}
+
+static unsigned long kshrinkd_reclaim_folios(struct list_head *folio_list,
+				struct pglist_data *pgdat)
+{
+	struct reclaim_stat dummy_stat;
+	unsigned int nr_reclaimed = 0;
+	struct scan_control sc = {
+		.gfp_mask = GFP_KERNEL,
+		.may_writepage = 1,
+		.may_unmap = 1,
+		.may_swap = 1,
+		.no_demotion = 1,
+		.rw_try_lock = 0,
+		.need_kshrinkd = 0,
+	};
+
+	if (list_empty(folio_list))
+		return nr_reclaimed;
+
+	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, false);
+
+	return nr_reclaimed;
+}
+
+/*
+ * The background kshrink daemon, started as a kernel thread
+ * from the init process.
+ *
+ * Kshrinkd is to reclaim the contended-folio in rmap_walk when
+ * shrink_folio_list instead of putting back into the head of LRU
+ * directly, to avoid to break the rules of LRU.
+ */
+
+static int kshrinkd(void *p)
+{
+	pg_data_t *pgdat;
+	LIST_HEAD(tmp_contended_folios);
+
+	pgdat = (pg_data_t *)p;
+
+	current->flags |= PF_MEMALLOC | PF_KSWAPD;
+	set_freezable();
+
+	while (!kthread_should_stop()) {
+		unsigned long nr_reclaimed = 0;
+		unsigned long nr_putback = 0;
+
+		wait_event_freezable(pgdat->kshrinkd_wait,
+				kshrinkd_should_run(pgdat));
+
+		/* splice rmap_walk contended folios to tmp-list */
+		spin_lock_irq(&pgdat->kf_lock);
+		list_splice(&pgdat->kshrinkd_folios, &tmp_contended_folios);
+		INIT_LIST_HEAD(&pgdat->kshrinkd_folios);
+		spin_unlock_irq(&pgdat->kf_lock);
+
+		/* reclaim rmap_walk contended folios */
+		nr_reclaimed = kshrinkd_reclaim_folios(&tmp_contended_folios, pgdat);
+		__count_vm_events(PGSTEAL_KSHRINKD, nr_reclaimed);
+
+		/* putback the folios which failed to reclaim to lru */
+		while (!list_empty(&tmp_contended_folios)) {
+			struct folio *folio = lru_to_folio(&tmp_contended_folios);
+
+			nr_putback += folio_nr_pages(folio);
+			list_del(&folio->lru);
+			folio_putback_lru(folio);
+		}
+
+		__count_vm_events(PGSCAN_KSHRINKD, nr_reclaimed + nr_putback);
+	}
+
+	current->flags &= ~(PF_MEMALLOC | PF_KSWAPD);
+
+	return 0;
+}
+
+/*
+ * This kshrinkd start function will be called by init and node-hot-add.
+ */
+void kshrinkd_run(int nid)
+{
+	pg_data_t *pgdat = NODE_DATA(nid);
+
+	if (pgdat->kshrinkd)
+		return;
+
+	pgdat->kshrinkd = kthread_run(kshrinkd, pgdat, "kshrinkd%d", nid);
+	if (IS_ERR(pgdat->kshrinkd)) {
+		/* failure to start kshrinkd */
+		WARN_ON_ONCE(system_state < SYSTEM_RUNNING);
+		pr_err("Failed to start kshrinkd on node %d\n", nid);
+		pgdat->kshrinkd = NULL;
+	}
+}
+
+/*
+ * Called by memory hotplug when all memory in a node is offlined.  Caller must
+ * be holding mem_hotplug_begin/done().
+ */
+void kshrinkd_stop(int nid)
+{
+	struct task_struct *kshrinkd = NODE_DATA(nid)->kshrinkd;
+
+	if (kshrinkd) {
+		kthread_stop(kshrinkd);
+		NODE_DATA(nid)->kshrinkd = NULL;
+	}
+}
+
+static int __init kshrinkd_init(void)
+{
+	int nid;
+
+	for_each_node_state(nid, N_MEMORY) {
+		pg_data_t *pgdat = NODE_DATA(nid);
+
+		spin_lock_init(&pgdat->kf_lock);
+		init_waitqueue_head(&pgdat->kshrinkd_wait);
+		INIT_LIST_HEAD(&pgdat->kshrinkd_folios);
+
+		kshrinkd_run(nid);
+	}
+
+	return 0;
+}
+
+module_init(kshrinkd_init)
+
 #ifdef CONFIG_NUMA
 /*
  * Node reclaim mode
@@ -7393,6 +7575,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 		.may_swap = 1,
 		.reclaim_idx = gfp_zone(gfp_mask),
 		.rw_try_lock = 1,
+		.need_kshrinkd = 1,
 	};
 	unsigned long pflags;
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index db79935..76d8a3b 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1279,9 +1279,11 @@ const char * const vmstat_text[] = {
 
 	"pgrefill",
 	"pgreuse",
+	"pgsteal_kshrinkd",
 	"pgsteal_kswapd",
 	"pgsteal_direct",
 	"pgsteal_khugepaged",
+	"pgscan_kshrinkd",
 	"pgscan_kswapd",
 	"pgscan_direct",
 	"pgscan_khugepaged",
-- 
2.7.4


