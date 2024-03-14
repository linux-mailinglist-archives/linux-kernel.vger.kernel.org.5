Return-Path: <linux-kernel+bounces-103371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E9387BEA9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5918289421
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285A96FE09;
	Thu, 14 Mar 2024 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="IClft8te"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E61F6EB73
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425746; cv=fail; b=NcgHzDk+P1tr99Ye6BGMDOJp2PQVOt+duGmWqceuk/4anzU12ayimdMYJxTNwQ4DpfvikD8ln1pHGq+wCciRUQMEg7U2ngBJ0fIqjYjLHmeYeUm2tsSuWPhOgxSiQwJiS7UiDX/wdTl6Ry8ysDvRaN84m4ei1ttwRBoxAzSF3rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425746; c=relaxed/simple;
	bh=V+JUXSGQNyoQ/O1A5k9aUYpXfhy4xtp/OIzIgoDEslQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MvC220Tvr8xRtWFGbMYJxMEAKVOQbr+m6GYAFjEDQ9ov05pvQoaDb3p3aT+BQBk86OmLhuzkoDnOMHSG2bFuvAjZXDDT9cdjWlx/ZODuDKjLpcLfiRZHLI6gLBmBpHjjOvflBxuttXocsmV3E9FC/Ztrtiq3grlFyh4F2qfmwrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=IClft8te; arc=fail smtp.client-ip=40.107.255.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3Qdv+bF9KEACAdcI8sd4A4Q+K1Iglw9iF9ADUoMySjdM2tu1Ecxiebf8nHlZ6RjGxage3XM8FK6NXSL/Vr5mixsJ5+WAcqnuz/ftoGVHZ8OBx1ya80vwcwVH1KM6MYYJZEDSSJCAwdFqsg4+8uNwx6dUIDoNgM5pDSvpB+wjm4Ijn3y4u8C0g+I41sXxMGa42eBE91CLSNNg4Jnq3k/dj8lbE+3cPG9YWhoMscgmTnL1jF8CDLxvUDuaQUvJF+ztMR44aOPdYhKq/fidsNl3MFl6FGTRZ83DBF+3NJE7As09MV6Tbv6+A7Vt7XzSIeOHULvPTTXRuZKGmlaJwLIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdTeTxUTc7bvID5bSUOaCMoO/h8AUVtgfchyzcDc7sc=;
 b=cLDUsc1yp3BzGEOVmpL4EdB2OsKoVyuCOzStvvPsraJ7tBkSd9TS/m9mpOPOGB089aBfbw1FBjH4wAIOMlcC3GX3f8IrsHd7gwlpsRSEvilidUydrc0jhhD9zCk+RUbh2IKgppEGOw2ihymO41VYZv48f6zlVs8LzLNPCt0dzBeDLD6IiefKz1EWhPSv8992F6066EAzrRLOdleN+Sq6uJeCYH1ijttEsI3+IFs0eTDTkJEM6TDm8c1E3pstneUGgSf8jATBo+5FqETRTDfxtGD5srf1dU2gYm7y85G6wn5a3tjPkOqc4B/QN8+sVsq7o1PZEohyHCBtUSvNwnpBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdTeTxUTc7bvID5bSUOaCMoO/h8AUVtgfchyzcDc7sc=;
 b=IClft8te39aCGO78B5CahmVNSMTqFsT833j3lj/njhN6PDWgzvq3mUy68wpzyhK6bYkKqrgolpH9Q1JFmHHeM6o/L60/X658WdyBkG0dCx74yzETv1fCgfNxs+L9ApT2Ud65BwVs8X1yQ9c3XuYQcl/AUV9cbRb7llXpEF/sN64=
Received: from KL1PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::18) by TY0PR02MB7105.apcprd02.prod.outlook.com
 (2603:1096:405:8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Thu, 14 Mar
 2024 14:15:39 +0000
Received: from HK2PEPF00006FB3.apcprd02.prod.outlook.com
 (2603:1096:820:149:cafe::8d) by KL1PR01CA0157.outlook.office365.com
 (2603:1096:820:149::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Thu, 14 Mar 2024 14:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FB3.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 14:15:38 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Mar
 2024 22:15:37 +0800
From: <liuhailong@oppo.com>
To: <akpm@linux-foundation.org>
CC: <nathan@kernel.org>, <ndesaulniers@google.com>, <trix@redhat.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<surenb@google.com>, <zhaoyang.huang@unisoc.com>, Hailong.Liu
	<liuhailong@oppo.com>
Subject: [PATCH] Revert "mm: skip CMA pages when they are not available"
Date: Thu, 14 Mar 2024 22:15:16 +0800
Message-ID: <20240314141516.31747-1-liuhailong@oppo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB3:EE_|TY0PR02MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: be71050a-24d4-4d57-518f-08dc44313954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4C7FiLAszmXzhkhYpc8zYvunlAwhVdP5ymcSY1WgCE/Q6srT7ktKv/o8M6Z6FsroYtavhNFj9eLjHCkfY6HiEcZFUah9FFdNbJ8Mb9OyVNo+A0OnLzWE+okXy0qF8UrlUI0KwZNFYWBaGpjXx0eu0TgERM0epayjZp5GxA1M5BPtieXUIGRUDiHhrZWnpEfwqW29EwgN5ZJzBnyzi2E63Ojhuu1KaQ1psFKujBrTFnlZ57BXpWD7rVKLoz37c6BTlHCW/jPnP5gfxpT6JQNGbOOwF8yjhZJMtr944Y6swe7AbzedtRSgwedcbOG/Glqm78C02R/quPi/D90eiOfUlLaM5wXEvl+j+ON3s5KEsCujcRixw9vmk6eWK4+HSC6QmurzZ0dWWt4RornkS637Zf7TcsszmrOf+hHZJ9xowlfHpzPxgjf8z5xLf8Io2M0/r7ktF3n2Qw83WWwWe7/EcEyaeJ4sJ1F07aJKUz5UxLvqEorKBbHAvA5kJOX7kRlGx1WtBSyQtKI2+7/V2eRUqhEU0yxOD658dQH0oBKq/Kew4wCLk7c34+8Q//Fg6lYIdDj2nfXLxPJ016Ai73fL6mSZvO2zRejVNuEHSp5axeLU1oPEy0jUNGgyIiNPwOm5Sh7TijSqs1K3U+eAkXvJKPYYicvPRZySj6V/8W60fdMkcGpwVQD9HYkz9g2KLi6mRcJmCS7osvQ2z3N0T73woUIjsBWS+dlkirjkYBVIlyBATgHGBiXsxYrdjTbfWizn
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 14:15:38.3962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be71050a-24d4-4d57-518f-08dc44313954
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB7105

From: "Hailong.Liu" <liuhailong@oppo.com>

This reverts commit 5da226dbfce3a2f44978c2c7cf88166e69a6788b.

patch may cause system not responding. if cma pages is large in lru_list
and system is in lowmemory, many tasks would enter direct reclaim and waste
cpu time to isolate and return. Test this patch on android-5.15 device
and tasks call stack as below.

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

without this patch, the tasks will reclaim cma pages and wakeup
oom-killer or not spin on cpus.

Signed-off-by: Hailong.Liu <liuhailong@oppo.com>
---
 mm/vmscan.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2fe4a11d63f4..197ddf62019f 100644
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
-- 
2.34.1


