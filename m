Return-Path: <linux-kernel+bounces-96470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5780D875C98
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF5E1C212CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F102C1A7;
	Fri,  8 Mar 2024 03:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="v/kM8cdM"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2128.outbound.protection.outlook.com [40.107.117.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EB228E2B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 03:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709867534; cv=fail; b=jsQmGfcgQjGsIMEYzsC48VBYZZJ4wn/41gQVGKDHQfSR2fPEngw9bjsrznUy5HJz3uQIlNlVBdDZ+Eplr28fbCIiDPJ021rGsrAmC7jfu1MlZJbiwiNU/uNCT5T3aai7Ot2CYzVNLMzp+EpCUicM4g+Bto+ZSAPZf+KS4LsBnU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709867534; c=relaxed/simple;
	bh=3yA5kivntHSYiFbfsQRa81HnPm+xvv6jMVfgRpzFDkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cTwN50kXbcM8afWtoIxniBhWoo6sSFEa9ijxUGopkdNLZ7Xyc70F9RkaieiW+bctSDBalbzbTxDpaB7vzWG3P1sfPI7oLJwtaZ9aApVKSfj1sfZKFiw9fYwKojxXIyC6Dcye1aYCY1y1iQUh9ITk+XNt5HdKWkyZK2iJdOydLkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=v/kM8cdM; arc=fail smtp.client-ip=40.107.117.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQwduM4VQaX2/FB4W1FmsLGw0Gnc89NNAkXWQAFrciYAbCjFYoBG/DnK8qFFDtqv5uPAB+DMzPGAlmMVVvT5hD6UqhDvQjPe+63RSsHn9kOJ+/JHEE5FUK9NfMalwyC/tvxDlfkUdsDtGji/ZjCIjMOUGumgXba0kMZ9C6VlSYq8w8yGgj2t45ARKKTUBPU+FW+mLlD5NV4O4kVSJ8jfow1CmTKu2Kox4iwWdltalH46xqUiFrJWgHjchBwf1rE+dNEfDM6EfAD6kys/SqAff69KoudIJlhqGN/oTPj/A3Yxqw45E9ILK5dT3loprkzjwhVsG8XLVMw7/1aDsSf5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ3y0wvgaO/iALc6RQVVddHIoDPahz9gL4TbBK7bmcY=;
 b=Q2GUXreZvcR99cfDQBK76XVaiWTJYEHEKYYWRZ2yRU8bEq2bTBfQUlRPwH7a6+bNwsNJ8HpKUKKp3aLTSTv78klZd5ECThFl79mfEOpxadNRcVXi8pE74XeO6jcV96GW8N/e7P0NSzuZc/GXQvQIYaAKcBow+khQmfACoIkiVilsFU1FymmVS7dOxiSObWciqO5KuJJFmW/U7+9EpVMoh4Xz5aiJ8FgbT6tvKwl5xq8wy3MC1lOWohzWOQVCRtSB/M+LtiZSoPcYi1hQ2nJZGGgC/MLAcQGITiM106E0CbCj3vyOdXnZpTrQ0SY0bheVxpQPDTbAy+iP/I93JFAVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ3y0wvgaO/iALc6RQVVddHIoDPahz9gL4TbBK7bmcY=;
 b=v/kM8cdMMLGgLIXqUa5kVJysZ80SRjID8rTlGcSG0Xw3fFRwWgq0Lz5zY5pflbdVpwRLYv+w5KXDXcJ9DoxGsU6/jj0EvV4GszbRdNW+fkcOFsLQET3N5tm2lqzQZKMdXwQpLPIHFDkxtpLQG42UKG7JwwLS6jTdnAJdHUPuQmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
 by SI2PR02MB5539.apcprd02.prod.outlook.com (2603:1096:4:1a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 03:12:09 +0000
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::60d1:4349:510c:8133]) by TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::60d1:4349:510c:8133%4]) with mapi id 15.20.7339.031; Fri, 8 Mar 2024
 03:12:09 +0000
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
Subject: [PATCH v2 2/2] mm: vmscan: reclaim contended folios asynchronously instead of promoting them
Date: Fri,  8 Mar 2024 11:11:26 +0800
Message-Id: <20240308031126.750-3-lipeifeng@oppo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6dce3b22-6ab3-4664-ac03-08dc3f1d8ab8
X-LD-Processed: f1905eb1-c353-41c5-9516-62b4a54b5ee6,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yHEYuDKb3j2x3N2ZwPzgYNmUc9OAcvBLBhwBAPvb4AxCvvSuh8nqxMhsQ7VU8v9Y9h2WNlA12Wc1eSb/0HprZTKiPcir5OwLvzcjzV1vS2gvzZZkj6w4CYTL8KewNseKD8ATZIkDreqaGXJ9WhY3ZXw/bz66fT54i1PGBDIw/W1pDB/NL5ax0txfMkVgI38dpwq1OYVhIEr/uUsMxqQPAdWjDpt8So3xxkvFpAY9p/D3eqqZE9/6UsD+fUnx8ACexhm8SvDAxuTjewyg8xfr9myyVZ/lOalfAWOxvWhF73DI/1Kdki+/x3ZUNbWCsgoyTIl8T87q7t/2IOlI4xIJjqbzBCsCgRUwPZ5Duh/UYtEpctV2Nc/vm7vv1ZzZkWtEyrzZ46Is9wXxiWcHuSyMc7c3bwD8pgAoYGzojCZzcypaSmbn9bNt9N3RVlUFBkmjPVM0MCYka0ACK+5wqz9ovGGK6XlQ9KSGq1OBDBHSjLjSg9i7Rwa6x7a10pUGl8SImwpEFYwQUq9yb8GirSvzCX4N/nmJ06SrepRAAw0j2DaahvsTRxKV0Vu0aAW5PdIGl8VrtOP+sgtuF6CJ+kmtCYGsg+a35YvuB9BVs55jjdqLMojm6XP9wifUS/35rx3dz3U/6rSYeyClA1tHNsTI6PzdWuVrUBM0rPzaRVA9zzAcjZOHqzyN6vRAAyia4Mac5mVGGERA1757TJ9WqVlste9wn4ZZ3P3RX0sEor6IP1Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5595.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+CJTHdeqOpu4zTp0iK8PpMcT6JOXKB8LOCw2fObY8YyBTisdcz0LQYXsBq+k?=
 =?us-ascii?Q?QZc5xPVR2bJAJGgJjC323Qf+vgXkKdE7/tMWdprHfCym5dv64F6Ze+JO4Rf8?=
 =?us-ascii?Q?+mesFOoMGFakzqs43ICVdVRti48i6AOEzUP5VnytKZFcyUXRCBB2gX16/e7D?=
 =?us-ascii?Q?mb35ayUJesdGkOcAIXNbNY3/apRhvPfdVFHSjrZE4AmE3Ydc7dQhgkDzJPVC?=
 =?us-ascii?Q?iHBAiDJPfcnugVTLN74eNKrlKNrhUK5QRQJdCvwVg3KU552MDTNwBX6zV4gk?=
 =?us-ascii?Q?BDYNjyTegE+i4nM+yB/U2jbENxrKGF9XoObEsFvp7JT7f9jjHH1UEK9taIYH?=
 =?us-ascii?Q?HtGBpBxXmScdyZEteBbU9p0WMyjhpwdi1N2AudqJb//AyOTr7g+qBKWQKEh1?=
 =?us-ascii?Q?5JJWXeWRrdeOFr8qJow87iEBUydstfuOSYidx3BhAvrtSmUEqFWBuxQX9QYt?=
 =?us-ascii?Q?j9KWOTU8yl3YftMHQnlSzLzhatoxBbIxzVjCKwU/tM22hyB/KQ0YvY1sf6sD?=
 =?us-ascii?Q?uWMkvjx96/v+Ftm9NQRVxALaxE32H2vLvbuWSTPI/HRoXEuedf5zUq6ZtjnZ?=
 =?us-ascii?Q?vrxhyOqecPwBaPzpDMvUftlTEFplfcWLVCeXBoxqKr0WygXoMFnNYKimqC22?=
 =?us-ascii?Q?oowJZRMawyXlDAJvMPK7zRVILoYPEgI5rSMD3GgDaHY0T9lQC5O9woUp02Jt?=
 =?us-ascii?Q?C/hbqiO0gHcIFUmj5VqvTJcybaCd755+bIMgOWKx+OlMTExlMFPL2aAMaTIG?=
 =?us-ascii?Q?sZ2ImaizNMGtOVM9rKM9Ic6NMas/8rpDQuQcXi2tSaAfCIJT000tkqN6t143?=
 =?us-ascii?Q?htYigd1Bk7Sat+I7e5Ah3By9M11tyQIgED9zvRFJERYPxU3JO0sqLl6blFbH?=
 =?us-ascii?Q?R3lO8RjvLqxwgf5xzZf4/gYPNRDVkUheW+P+7mPXOlEUJ5MXKUu4d5PRI91+?=
 =?us-ascii?Q?MkwHwN3ICon1BKiycJsCooM8HF8cmtV4FwWoVYdl7cbYwm5hjUqeJQrGQxW1?=
 =?us-ascii?Q?pXkcjhAPLdmksZu34665wVxIJCrUegT7PwbdDKurPqg2c/M2KE6+ZhTfm05V?=
 =?us-ascii?Q?wgVrmMyAzU6b8bPkbDjQXlwQWi4H/F1NyH/n/zyi5uaXrtd+5ZmTOeaf0iZg?=
 =?us-ascii?Q?OE/6g2oUi59Gx7BUhj9Vc5Cwkq65Oh/R8p3J4zj7OOVKF/GsFEJBsGYQc/Zv?=
 =?us-ascii?Q?ym0hmeJT3knTCYEOQ7HYXpxsFtgHnfvGeaefz2NxscN7I0m106C8gPjVMkMv?=
 =?us-ascii?Q?bOHSUXZC1wWa/1B9AvThEyyuftHjOhamHH6bLNnMZlz+jAsAvk9bL2IGolaC?=
 =?us-ascii?Q?gd2sC53Nuruzm1oSH7dX7lRCzqfY8VdNo+pcQgNFL1dXuJ5VXTzG1OmWPlXh?=
 =?us-ascii?Q?pwzHK0/Qelj2QFxw2nrNRDMvjYJZtELaX+n29K3XH4b6raO0yPZOBxQ7wIW0?=
 =?us-ascii?Q?06FK74/aNE4pHageQssZXmDIAThOX0HRfWqvZos6LtRaFofVAT+bvvdGNkt6?=
 =?us-ascii?Q?MqyLkdFPaNb/8qp0AGx7ccYjSDWNfvjHgn0ABsaeYmUcDrufH+AopLGvsiUb?=
 =?us-ascii?Q?IW8QZ/eEVyEVzn5GRpdUW829FMX+5OU7W+ZNmrGS?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dce3b22-6ab3-4664-ac03-08dc3f1d8ab8
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5595.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 03:12:09.5583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDqSthN1uI7GHreDMrAv6MWGf1gSkHWNZpf1VNhboTlnbc1Tn1Yly+7A/96ZoVOsZ0TneGBZz9elwQ5C79oSGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5539

From: Peifeng Li <lipeifeng@oppo.com>

Commit 6d4675e60135 ("mm: don't be stuck to rmap lock on reclaim path")
prevents the reclaim path from becoming stuck on the rmap lock. However,
it reinserts those folios at the head of the LRU during shrink_folio_list,
even if those folios are very cold.

While running an Android phone with 6GiB memory for 2 hours, I observed
that 321728 folios can be incorrectly placed back to the inactive head
of the LRU due to lock contention, which amounts to approximately 44
folios per second. Similarly, the same test conducted on 4GiB phones
shows that 106 folios are improperly promoted per second. This can
have a detrimental effect on performance by increasing refaults and
the likelihood of OOM (Out of Memory) killing.

For this reason, the patch introduces a separate list for contended folios
and wakes up a new kthread:kshrinkd thread to asynchronously reclaim them,
thus preventing excessive violations of LRU rules. This new thread will
set try_lock to false and always wait until it holds the lock.

Below is some data collected from two phones running monkey for two
hours(less is better):

Phone with 6GiB memory:
                      w/o patch          w/patch              delta
workingset_refault   1451043114         1408015823            -2.9%
lmkd count             9231              9009                 -2.4%

Phone with 4GiB memory:
                      w/o patch          w/patch              delta
workingset_refault    2674649801         2581150132           -3.4%
lmkd count             13800             13061                -5.3%

The Monkey is a program that runs on your emulator or device and generates
pseudo-random streams of user events such as clicks, touches, or gestures,
as well as a number of system-level events.

The Android low memory killer daemon (lmkd) process monitors the memory
state of a running Android system and reacts to high memory pressure by
killing the least essential processes to keep the system performing at
acceptable levels.

Signed-off-by: Peifeng Li <lipeifeng@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/mmzone.h        |   6 ++
 include/linux/swap.h          |   3 +
 include/linux/vm_event_item.h |   2 +
 mm/memory_hotplug.c           |   2 +
 mm/vmscan.c                   | 189 +++++++++++++++++++++++++++++++++-
 mm/vmstat.c                   |   2 +
 6 files changed, 201 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c11b7cde81ef..19acacf92cc9 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1332,6 +1332,12 @@ typedef struct pglist_data {
 
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
index 2955f7a78d8d..6d15b577b6a3 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -438,6 +438,9 @@ void check_move_unevictable_folios(struct folio_batch *fbatch);
 extern void __meminit kswapd_run(int nid);
 extern void __meminit kswapd_stop(int nid);
 
+extern void kshrinkd_run(int nid);
+extern void kshrinkd_stop(int nid);
+
 #ifdef CONFIG_SWAP
 
 int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 747943bc8cc2..ee95ab138c87 100644
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
index a444e2d7dd2b..5e1c326a8bde 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1218,6 +1218,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 
 	kswapd_run(nid);
 	kcompactd_run(nid);
+	kshrinkd_run(nid);
 
 	writeback_set_ratelimit();
 
@@ -2098,6 +2099,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	}
 
 	if (arg.status_change_nid >= 0) {
+		kshrinkd_stop(node);
 		kcompactd_stop(node);
 		kswapd_stop(node);
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 509b5e0dffd3..ef540a520b47 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -150,6 +150,9 @@ struct scan_control {
 	/* if try_lock in rmap_walk */
 	unsigned int rw_try_lock:1;
 
+	/* need kshrinkd to reclaim if rwc trylock contended*/
+	unsigned int need_kshrinkd:1;
+
 	/* Allocation order */
 	s8 order;
 
@@ -201,6 +204,17 @@ struct scan_control {
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
@@ -844,6 +858,7 @@ enum folio_references {
 	FOLIOREF_RECLAIM_CLEAN,
 	FOLIOREF_KEEP,
 	FOLIOREF_ACTIVATE,
+	FOLIOREF_LOCK_CONTENDED,
 };
 
 static enum folio_references folio_check_references(struct folio *folio,
@@ -864,8 +879,12 @@ static enum folio_references folio_check_references(struct folio *folio,
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
@@ -1035,6 +1054,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	struct folio_batch free_folios;
 	LIST_HEAD(ret_folios);
 	LIST_HEAD(demote_folios);
+	LIST_HEAD(contended_folios);
 	unsigned int nr_reclaimed = 0;
 	unsigned int pgactivate = 0;
 	bool do_demote_pass;
@@ -1052,6 +1072,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		enum folio_references references = FOLIOREF_RECLAIM;
 		bool dirty, writeback;
 		unsigned int nr_pages;
+		bool lock_contended = false;
 
 		cond_resched();
 
@@ -1193,6 +1214,9 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		case FOLIOREF_KEEP:
 			stat->nr_ref_keep += nr_pages;
 			goto keep_locked;
+		case FOLIOREF_LOCK_CONTENDED:
+			lock_contended = true;
+			goto keep_locked;
 		case FOLIOREF_RECLAIM:
 		case FOLIOREF_RECLAIM_CLEAN:
 			; /* try to reclaim the folio below */
@@ -1470,7 +1494,10 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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
@@ -1512,6 +1539,14 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	free_unref_folios(&free_folios);
 
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
@@ -1526,6 +1561,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 		.gfp_mask = GFP_KERNEL,
 		.may_unmap = 1,
 		.rw_try_lock = 1,
+		.need_kshrinkd = 0,
 	};
 	struct reclaim_stat stat;
 	unsigned int nr_reclaimed;
@@ -2119,6 +2155,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 		.may_swap = 1,
 		.no_demotion = 1,
 		.rw_try_lock = 1,
+		.need_kshrinkd = 0,
 	};
 
 	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, ignore_references);
@@ -5465,6 +5502,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
 		.reclaim_idx = MAX_NR_ZONES - 1,
 		.gfp_mask = GFP_KERNEL,
 		.rw_try_lock = 1,
+		.need_kshrinkd = 0,
 	};
 
 	buf = kvmalloc(len + 1, GFP_KERNEL);
@@ -6443,6 +6481,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 		.may_unmap = 1,
 		.may_swap = 1,
 		.rw_try_lock = 1,
+		.need_kshrinkd = 1,
 	};
 
 	/*
@@ -6489,6 +6528,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 		.reclaim_idx = MAX_NR_ZONES - 1,
 		.may_swap = !noswap,
 		.rw_try_lock = 1,
+		.need_kshrinkd = 0,
 	};
 
 	WARN_ON_ONCE(!current->reclaim_state);
@@ -6536,6 +6576,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
 		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
 		.rw_try_lock = 1,
+		.need_kshrinkd = 0,
 	};
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
@@ -6798,6 +6839,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		.order = order,
 		.may_unmap = 1,
 		.rw_try_lock = 1,
+		.need_kshrinkd = 1,
 	};
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
@@ -7268,6 +7310,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 		.may_swap = 1,
 		.hibernation_mode = 1,
 		.rw_try_lock = 1,
+		.need_kshrinkd = 0,
 	};
 	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
 	unsigned long nr_reclaimed;
@@ -7338,6 +7381,145 @@ static int __init kswapd_init(void)
 
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
@@ -7427,6 +7609,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 		.may_swap = 1,
 		.reclaim_idx = gfp_zone(gfp_mask),
 		.rw_try_lock = 1,
+		.need_kshrinkd = 1,
 	};
 	unsigned long pflags;
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index db79935e4a54..76d8a3b2d1a8 100644
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
2.34.1


