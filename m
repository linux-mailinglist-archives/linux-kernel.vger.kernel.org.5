Return-Path: <linux-kernel+bounces-134990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0A789B9A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3B31C21F35
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9693B2C68A;
	Mon,  8 Apr 2024 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="giRdlQmU"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021007.outbound.protection.outlook.com [52.101.128.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5DF29CE8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563554; cv=fail; b=VRZWU47ZDTMcYiW0v8BDa0ZTxNbOQ9aHrJW9EPoLoAh9VmRGNE9ZFNiE3YaAs2mmq+1dszkK0nczE8Q/LK9j+PdJRByHyGDWAbxxVp9e44WQtZsJJ8Y9Vkj5f85DY+pQDbhU/k9ZGJFhlLuqrF9ztf62X0o9nwbX7zNnkIf16dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563554; c=relaxed/simple;
	bh=rohCanJmUvZYONxL80o9aBSNN3KAC0vsj3oeC5tKz14=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mA4PLIqOFLoKhod/4mL7nhgwT5BoSH2+fLXjZS/b4kUIZizV8GCk/4LLL/70SOddM16yfIOPwrsT6KNSn4ZtmxhJ0VWgLoTm6sAMSc0r1OjPVdF+0qATjBW7ZdSA5k2kC21gxE9wt05f0EwHZW0EYJw9pXEwLDCFdPP3VKqmb2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=giRdlQmU; arc=fail smtp.client-ip=52.101.128.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vs7/zhumL9OZar+t9l6pg8oi++AA2aFxGF6C+zIRbpIV4g4krLLftuUDSPUi0RF3pY2p7Xdem+KCvT34czRCU2CHlaOiUpBz/shbQcBb0+K50/Lf0EQNnP9lyuYE5H380Jt9cFOGqSzRSttesLQfMbVsMlScjwR56AF4W56GZUCVITlJ0XN9r94PXQY79iP04jTQAbuj7bl7yNQapIJE5BcDsvS21ZVShA3HQG0tgFsR7+sQWJKLgtBY6U2eX5tK0T32vPk/PwBDhCGZ+of6S4Zy/8cX4M3bhbE7EtpSF78lhWjw2rxwSiGK+F8Fg75OtJ+YZsUQP75mrFy5rjFRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh6gNWfQfB972JQeZP4EtAiL349Z8N7AB3fAYjXU0Pc=;
 b=E3b5S0kIHP1508G1ANUIJxArb8Wbo4QGbbuiOmcRicoEXMH6vc9eNzv1uWwjDW3cb4ZxbY6eDJq23UeLr/y8CayAei6PiOUFlIVLw5HtKo510QEIZ4hhqdmvaylq6vYzdCYU49oMXjZAgdpRxsTOHIByNvvBWrfg3ccqzHieVyggyZCxUsOi6Z8AIOUWbPkcVAgTLiCD8S1uE3KIbrFjybpJHOKa92y0rtSMEGY125dO8BS91zU0PZZxtUaU5N6cIqegDKd+ClrlrDJoVbTrRu2P+zgAPInyYXCmm96d3DXgRF5+qUh+xyEyfch+NfwqTn/Jw8ept1KWS+WWMuUqEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh6gNWfQfB972JQeZP4EtAiL349Z8N7AB3fAYjXU0Pc=;
 b=giRdlQmU08UlbbTbs4oEBve+3ywwIuaxxCg3ibvu3xytpxfvPqupppsdLFIeraShAw8eA6wQogRgxZyuh3Zx4td1G6v9DVkSMDYSyFBkT1soXsEtHwbEjfIUDSIi/HWad9Di018WTIRRuOEpvrWA2gmHNQKw0TbY/Ft8GwYkYa4=
Received: from SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) by SEZPR02MB5933.apcprd02.prod.outlook.com
 (2603:1096:101:75::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 08:05:48 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:192:cafe::2e) by SI2PR01CA0022.outlook.office365.com
 (2603:1096:4:192::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.33 via Frontend
 Transport; Mon, 8 Apr 2024 08:05:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 08:05:47 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 8 Apr
 2024 16:05:47 +0800
From: <liuhailong@oppo.com>
To: <akpm@linux-foundation.org>
CC: <nathan@kernel.org>, <ndesaulniers@google.com>, <trix@redhat.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<surenb@google.com>, <zhaoyang.huang@unisoc.com>,
	<quic_charante@quicinc.com>, <yuzhao@google.com>, liuhailong
	<liuhailong@oppo.com>
Subject: [PATCH] mm: vmscan: do not skip CMA while LRU is full of CMA folios
Date: Mon, 8 Apr 2024 16:05:39 +0800
Message-ID: <20240408080539.14282-1-liuhailong@oppo.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SEZPR02MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: f5764fdb-344e-439b-9085-08dc57a2b301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vlKAfEE9x9eP6K/KM+1rxAjqqD3gl7DeVo/z2zV2Ak+axWxVXAq7PT6/kHxxpw97KCj50rDoh71J4Nm7+Qy6tNdKZe7/KcIMj8yCJIk2vgWW8/BpuWsfx6lAIIEwNMLWhoYgXgerfule1HPZb3HFypkpWS7BbpVkypyvCtDrkJ5vktlRGuaFWbQIXzk3q7VMbhDR3wV125rPYGjj8WZ+QAlUxHFQv7F7E++L5AENlBV9lx8xDtdGhMqn8qcPFjjHgEBy5YcyHjFTqGUJUlqKw/eek+jfYKkswjImk6hhkcKO5i7RVAGngAWPx7rWlsTHsr4TuWQJYXLgP5LtwT7C0JyoNEb8OTcgDldow6dzBkEZOzdQ+RuxsQvHZnXLKrBjn4A8zFE10NKtOybwA9UZ+j0fE3RfKhqqzBXWPdPPsHVsyqGziAoCN3yWFr2H4hJTENGnvggRJE4sGsjKvQoyMmkTKZgoI1FNKXkUI4hUTYAghrJPwFVAAVyjaFqtrdzzfuIF9AmN4DNGCBqUz95ht7UEg90p4qRVMfkxn0oFSZD8NTTWpn9KZb7AchCFW3hXfUmyWXyEtyn1WSW9q6w+72q0GOC4vfOxF21oeZF20mvIBYUQJIzQ255wIesSkoyzBck4PlOQSD+HVpw05lx0Ap1DXEUOVNPV1iZolLhA61J75T9u6MzU5vrEeIamiU1HKD1W6k+5mAnBry7GKjnmWXIrAP1/QE0Lq8Yt0Ekgfu6Ph5wCPoUFHxX47Wox+fxX
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004)(7416005);DIR:OUT;SFP:1102;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 08:05:47.8216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5764fdb-344e-439b-9085-08dc57a2b301
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5933

From: liuhailong <liuhailong@oppo.com>

If the allocation flag isn't movable, commit 5da226dbfce3 ("mm:
skip CMA pages when they are not available") skips CMA during direct
reclamation. This generally speeds up the reclamation of non-movable
folios. However, in scenarios with limited system memory and a majority
of reclaimable folios in LRU being from CMA, this can result in prolonged
idle loops where the system reclaims nothing but consumes CPU.

I traced the process of a thread entering direct reclamation,
and printed the relevant information of the sc(scan_control).
__alloc_pages_direct_reclaim start
sc->priority:9 sc->nr_skipped_cma:32208  sc->nr_scanned:36  sc->nr_reclaimed:3
sc->priority:8 sc->nr_skipped_cma:32199  sc->nr_scanned:69  sc->nr_reclaimed:3
sc->priority:7 sc->nr_skipped_cma:198405 sc->nr_scanned:121 sc->nr_reclaimed:3
sc->priority:6 sc->nr_skipped_cma:236713 sc->nr_scanned:147 sc->nr_reclaimed:3
sc->priority:5 sc->nr_skipped_cma:708209 sc->nr_scanned:379 sc->nr_reclaimed:3
sc->priority:4 sc->nr_skipped_cma:785537 sc->nr_scanned:646 sc->nr_reclaimed:3
__alloc_pages_direct_reclaim end duration 3356ms

Continuously skipping CMA even when the LRU is filled with CMA
folios can also result in lmkd failing to terminate processes. The
duration of psi_memstall (measured from the exit to the entry of
__alloc_pages_direct_reclaim) becomes excessively long, lasting for
example a couple of seconds. Consequently, lmkd fails to awaken and
terminate processes promptly.

This patch introduces no_skip_cma and sets it to true when the number of
skipped CMA folios is excessively high. It offers two benefits: Rather
than wasting time in idle loops, it's better to assist other threads in
reclaiming some folios; This shortens the duration of psi_memstall and
ensures timely activation of lmkd within a few milliseconds.

Signed-off-by: liuhailong <liuhailong@oppo.com>
---
 mm/vmscan.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fa321c125099..2c74c1c94d88 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -114,6 +114,9 @@ struct scan_control {
 	/* Proactive reclaim invoked by userspace through memory.reclaim */
 	unsigned int proactive:1;

+	/* Can reclaim skip cma pages */
+	unsigned int no_skip_cma:1;
+
 	/*
 	 * Cgroup memory below memory.low is protected as long as we
 	 * don't threaten to OOM. If any cgroup is reclaimed at
@@ -157,6 +160,9 @@ struct scan_control {
 	/* Number of pages freed so far during a call to shrink_zones() */
 	unsigned long nr_reclaimed;

+	/* Number of cma-pages skipped so far during a call to shrink_zones() */
+	unsigned long nr_skipped_cma;
+
 	struct {
 		unsigned int dirty;
 		unsigned int unqueued_dirty;
@@ -1572,9 +1578,13 @@ static __always_inline void update_lru_sizes(struct lruvec *lruvec,
  */
 static bool skip_cma(struct folio *folio, struct scan_control *sc)
 {
-	return !current_is_kswapd() &&
+	bool ret = !current_is_kswapd() && !sc->no_skip_cma &&
 			gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE &&
 			folio_migratetype(folio) == MIGRATE_CMA;
+
+	if (ret)
+		sc->nr_skipped_cma += folio_nr_pages(folio);
+	return ret;
 }
 #else
 static bool skip_cma(struct folio *folio, struct scan_control *sc)
@@ -6188,6 +6198,7 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 			vmpressure_prio(sc->gfp_mask, sc->target_mem_cgroup,
 					sc->priority);
 		sc->nr_scanned = 0;
+		sc->nr_skipped_cma = 0;
 		shrink_zones(zonelist, sc);

 		if (sc->nr_reclaimed >= sc->nr_to_reclaim)
@@ -6202,6 +6213,16 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 		 */
 		if (sc->priority < DEF_PRIORITY - 2)
 			sc->may_writepage = 1;
+
+		/*
+		 * If we're getting trouble reclaiming non-cma pages and
+		 * currently a substantial number of CMA pages on LRU,
+		 * start reclaiming cma pages to alleviate other threads
+		 * and decrease lru size.
+		 */
+		if (sc->priority < DEF_PRIORITY - 2 &&
+		    sc->nr_scanned < (sc->nr_skipped_cma >> 3))
+			sc->no_skip_cma = 1;
 	} while (--sc->priority >= 0);

 	last_pgdat = NULL;
--
2.36.1


