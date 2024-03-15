Return-Path: <linux-kernel+bounces-104153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4641D87C9CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29FE1F232CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96911758F;
	Fri, 15 Mar 2024 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="Wu/A1eRF"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CDE16427
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490702; cv=fail; b=BAPDYqzb2WPLGaE/aa2axZ0kJoMAWf6Lp/us9Y8b210RZU/W9nWcxkMlJjDsXr+rLnZ5E5HBunQS20qBKoRbZzWZ/hGxo+6P9TAnzlix2GXhbOwQioxmdnjwzPHonhYv4dVPWLqMaYgDOfPlyd2fUY210MTqn9NzmZue6ZfzdNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490702; c=relaxed/simple;
	bh=HQXAcvUjvVaI4nbm7YONQRFgmGnt51dXibAO0Oqec6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2EUVvueX7ENK9CeH5sIVX/Jhv9oOxNBFk7k82Y/9eGqD6LsofbEVzLzStpDTzsgJMyeM8wPTpj8tk5yvDXkXtQuCnAQJNCvStq2RosshFvKMJloT/E9ADRolJjmCk21L6RscYAMXqCMK4KvLYBd0v1CVVrfJ4RtLPM1v3V/PAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=Wu/A1eRF; arc=fail smtp.client-ip=40.107.117.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYBsrmqH3U4xYncwxcgw8uzIWQEALiT0MhDA3e6tVzlvyL23LZTMVnhgj0UQ6pi0lscgLNich+bWQre9rYw9U53dedKjW3Pf8qVkV8EhlZH/FHyq+NWUZi7dEJW30mTtvoV1DiTsXMwnlGwc/n0/X5xYDfb3+JWrrERv0ytXxcEYqzquwUEXZ8PjbPgJYcTWo5d1W/VRhONjCFlplScyaRkg8duv85YWEqj9ruBjz0QuHJYrRoFaecgioFcRsA2EXzJlwTJKjT76QtKBIbsRaQO7eBGFaMdpXk5HFDNiATwRjfOl3Z57M7gxVctwyiyJEUoVhEqqrLB87ZHZPbICVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSMQ+co08OZP1j4maPyd8Gzb5mLhE6B+G1tb7W0PLYg=;
 b=PZDdnWNCdxW68AYMb1NacV1/B1vQ106Cc/GBtlLTCgToo00U4n4EvtGtdBj4IsRKSveApgPgMbUG4jHynBQdzY2rxPNLm+D/wnSRIdjGlIF/yzPZ02zJi7D6mnWoGNbjQIRinVEDOdI2uctD/RMTXSLr4e61ohUDItAmuAsVyL8V+7MNsfyn/YYVM6i1lsyh2WB3QwSzrcI/Iw4QVS6SrZoRLx6rvurUSmBpuFPqXE7VcW2NZ+ci73M78KhnBFa2Df3ImPEs5uYAtji+PozGCqdA17Ib2HeW6aqd9ZHMDGdzDHF22+vnV0jYu/b3bUsXKCdK2fIzEH3zKgDBL5CP1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSMQ+co08OZP1j4maPyd8Gzb5mLhE6B+G1tb7W0PLYg=;
 b=Wu/A1eRFcAYik9s3+xthcM4oqU3oAhui1lDrSB4tr+iH3zRMSJEQAEnLP4Ef9Uf7A2aKb5AqtTlfI3f3vL67EeZS+1En966PKe49yiRYrXt4SO7eP5K2IfY/Tnbk1dCX0WvLeJf2YVmbgh9KCklWv7kYXXVDXdT+v4N2iHyOLrs=
Received: from PS2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::14) by SEYPR02MB6268.apcprd02.prod.outlook.com
 (2603:1096:101:d1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Fri, 15 Mar
 2024 08:18:17 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:57:cafe::fa) by PS2PR01CA0050.outlook.office365.com
 (2603:1096:300:57::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Fri, 15 Mar 2024 08:18:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 08:18:16 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Mar
 2024 16:18:12 +0800
From: <liuhailong@oppo.com>
To: <akpm@linux-foundation.org>
CC: <nathan@kernel.org>, <ndesaulniers@google.com>, <trix@redhat.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<surenb@google.com>, <zhaoyang.huang@unisoc.com>,
	<quic_charante@quicinc.com>, <yuzhao@google.com>, Hailong.Liu
	<liuhailong@oppo.com>
Subject: [PATCH v2] Revert "mm: skip CMA pages when they are not available"
Date: Fri, 15 Mar 2024 16:18:03 +0800
Message-ID: <20240315081803.2223-1-liuhailong@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314141516.31747-1-liuhailong@oppo.com>
References: <20240314141516.31747-1-liuhailong@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw30.adc.com
 (172.16.56.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEYPR02MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 37714070-c11a-430d-f806-08dc44c87785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lE/7HgiZ1CZ6thGpta3dc4DbpPflis2+ARATZOjgWUxxAf+6VuJqfrlhmLb2tMTOPmDlqpKm3kEW/Nj0VEyIGu5budE1PcMKrS49md3QTU+mPf+npmxVtVZn7wpCGtAHTSO1+aIvSTbloPMcjYtgRGD74ZnS0oW7lZLThBD5u/AnspxqnJzXiOMIMw5EgctCIwRmSxNtQHzINEsT0xyuIE9TFZRQeeBM7LfMLzUaPWqtC2sb+63wAUxr1GC2hzavP+S2RI0MMSPpAciU1ca+vmO9l5UkaVSwsQoX2t9nvNnMsFfrBhZdGSY55fPYkYANYax2lxXzhaRdG5Hd1Kw/XY6eV+YxIWfvXAaigpFICAsTIWMddwQa80ACuva64SwBxEWQJ81qXY1SuH8DBdPX7Pouz62FmCUZk6Fg6LQPWChg1PDFs5lCMQISd2ysRLA6ubszZv/5p5pbShnXi3PPHuIl/qEuI84QZD6MvFB+zMz81ep0O5rxlunFwi/0e9Q8myN5mvUw84kx4UEz4ou60X5ZynZ8OLSQqlsN60TvNFQReCDxhS8HrB0BdZgtj0So+ZtTE/lO6vSTvw6Km4kuRT55P1azmCj0uztaLngKMIra121BqaBSiOK8h1mAX3UfETCkrPz/NquQG6K3+d0k4Bn0ztzpAnkz2+4AdEsZKEc79cFdBe2eLBmKK+nf0fVaaOwcCyuwBDXYDTGOFbkPWihMFa6tY0Ty92SEd82eqyX/Ix5JJl32iiIbHq9bhsfF
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 08:18:16.7465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37714070-c11a-430d-f806-08dc44c87785
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6268

From: "Hailong.Liu" <liuhailong@oppo.com>

This reverts
commit b7108d66318a ("Multi-gen LRU: skip CMA pages when they are not eligible")
commit 5da226dbfce3 ("mm: skip CMA pages when they are not available")

skip_cma may cause system not responding. if cma pages is large in lru_list
and system is in lowmemory, many tasks would direct reclaim and waste
cpu time to isolate_lru_pages and return.

Test this patch on android-5.15 8G device
reproducer:
- cma_declare_contiguous 3G pages
- set /proc/sys/vm/swappiness 0 to enable direct_reclaim reclaim file
  only.
- run a memleak process in userspace

trace the trace_mm_vmscan_lru_isolate which get
[ 1178.059160] 2825  3405 I UsbFfs-worker   : isolate_lru_pages:1895 total_scan: 24385 skipped: 24382
[ 1178.059699] 2825  3405 I UsbFfs-worker   : isolate_lru_pages:1895 total_scan: 24412 skipped: 24401
[ 1178.061747] 2825  3405 I UsbFfs-worker   : isolate_lru_pages:1895 total_scan: 24412 skipped: 24401
From the log, tasks is waste time to scan lru list and call stack as below.

Task name: UsbFfs-worker [affinity: 0xff] pid: 3374 cpu: 7 prio: 120 start: ffffff8897a35c80
state: 0x0[R] exit_state: 0x0 stack base: 0xffffffc01eaa0000
Last_enqueued_ts:       0.000000000 Last_sleep_ts:       0.000000000
Stack:
[<ffffffd32ee7d910>] __switch_to+0x180
[<ffffffd3302022fc>] __schedule+0x4dc
[<ffffffd330201e08>] preempt_schedule+0x5c
[<ffffffd33020a4d0>] _raw_spin_unlock_irq+0x54
[<ffffffd32f14906c>] shrink_inactive_list+0x1d0
[<ffffffd32f143998>] shrink_lruvec+0x1bc
[<ffffffd32f147c0c>] shrink_node_memcgs+0x184
[<ffffffd32f147414>] shrink_node+0x2d0
[<ffffffd32f146d38>] shrink_zones+0x14c
[<ffffffd32f142e84>] do_try_to_free_pages+0xe8
[<ffffffd32f142b08>] try_to_free_pages+0x2e0
[<ffffffd32f1a8e44>] __alloc_pages_direct_reclaim+0x84
[<ffffffd32f1a2d58>] __alloc_pages_slowpath+0x4d0
[<ffffffd32f1a23bc>] __alloc_pages_nodemask[jt]+0x124
[<ffffffd32f19a220>] __vmalloc_area_node+0x188
[<ffffffd32f19a540>] __vmalloc_node+0x148
[<ffffffd32f19a60c>] vmalloc+0x4c
[<ffffffd32f910218>] ffs_epfile_io+0x258
[<ffffffd330033780>] kretprobe_trampoline[jt]+0x0
[<ffffffd330033780>] kretprobe_trampoline[jt]+0x0
[<ffffffd32f28129c>] __io_submit_one+0x1c0
[<ffffffd32f280e38>] io_submit_one+0x88
[<ffffffd32f280c88>] __do_sys_io_submit+0x178
[<ffffffd32f27eac0>] __arm64_sys_io_submit+0x20
[<ffffffd32eeabb74>] el0_svc_common.llvm.9961749221945255377+0xd0
[<ffffffd32eeaba34>] do_el0_svc+0x28
[<ffffffd32ff21be8>] el0_svc+0x14
[<ffffffd32ff21b70>] el0_sync_handler+0x88
[<ffffffd32ee128b8>] el0_sync+0x1b8

Task name: kthreadd [affinity: 0xff] pid: 2 cpu: 7 prio: 120 start: ffffff87808c0000
state: 0x0[R] exit_state: 0x0 stack base: 0xffffffc008078000
Last_enqueued_ts:       0.000000000 Last_sleep_ts:       0.000000000
Stack:
[<ffffffd32ee7d910>] __switch_to+0x180
[<ffffffd3302022fc>] __schedule+0x4dc
[<ffffffd330201e08>] preempt_schedule+0x5c
[<ffffffd33020a4d0>] _raw_spin_unlock_irq+0x54
[<ffffffd32f149168>] shrink_inactive_list+0x2cc
[<ffffffd32f143998>] shrink_lruvec+0x1bc
[<ffffffd32f147c0c>] shrink_node_memcgs+0x184
[<ffffffd32f147414>] shrink_node+0x2d0
[<ffffffd32f146d38>] shrink_zones+0x14c
[<ffffffd32f142e84>] do_try_to_free_pages+0xe8
[<ffffffd32f142b08>] try_to_free_pages+0x2e0
[<ffffffd32f1a8e44>] __alloc_pages_direct_reclaim+0x84
[<ffffffd32f1a2d58>] __alloc_pages_slowpath+0x4d0
[<ffffffd32f1a23bc>] __alloc_pages_nodemask[jt]+0x124
[<ffffffd32f19a220>] __vmalloc_area_node+0x188
[<ffffffd32f19a044>] __vmalloc_node_range+0x88
[<ffffffd32f0fb430>] scs_alloc+0x1b8
[<ffffffd32f0fb62c>] scs_prepare+0x20
[<ffffffd32ef2ce04>] dup_task_struct+0xd4
[<ffffffd32ef2a77c>] copy_process+0x144
[<ffffffd32ef2bae4>] kernel_clone+0xb4
[<ffffffd32ef2c040>] kernel_thread+0x5c
[<ffffffd32ef618d0>] kthreadd+0x184

Signed-off-by: Hailong.Liu <liuhailong@oppo.com>
---
 mm/vmscan.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6f13394b112e..29306c29309f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2261,25 +2261,6 @@ static __always_inline void update_lru_sizes(struct lruvec *lruvec,

 }

-#ifdef CONFIG_CMA
-/*
- * It is waste of effort to scan and reclaim CMA pages if it is not available
- * for current allocation context. Kswapd can not be enrolled as it can not
- * distinguish this scenario by using sc->gfp_mask = GFP_KERNEL
- */
-static bool skip_cma(struct folio *folio, struct scan_control *sc)
-{
-	return !current_is_kswapd() &&
-			gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE &&
-			get_pageblock_migratetype(&folio->page) == MIGRATE_CMA;
-}
-#else
-static bool skip_cma(struct folio *folio, struct scan_control *sc)
-{
-	return false;
-}
-#endif
-
 /*
  * Isolating page from the lruvec to fill in @dst list by nr_to_scan times.
  *
@@ -2326,8 +2307,7 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 		nr_pages = folio_nr_pages(folio);
 		total_scan += nr_pages;

-		if (folio_zonenum(folio) > sc->reclaim_idx ||
-				skip_cma(folio, sc)) {
+		if (folio_zonenum(folio) > sc->reclaim_idx) {
 			nr_skipped[folio_zonenum(folio)] += nr_pages;
 			move_to = &folios_skipped;
 			goto move;
@@ -4945,7 +4925,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}

 	/* ineligible */
-	if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
+	if (zone > sc->reclaim_idx) {
 		gen = folio_inc_gen(lruvec, folio, false);
 		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
--
Changes in v2:
- add reproducer
- fix build error on v6.6-rc7


