Return-Path: <linux-kernel+bounces-24390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A8382BBE5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37614B21326
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03B25D74E;
	Fri, 12 Jan 2024 07:41:06 +0000 (UTC)
Received: from out187-20.us.a.mail.aliyun.com (out187-20.us.a.mail.aliyun.com [47.90.187.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D4F5B5BF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047207;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.W4PYTwM_1705044926;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.W4PYTwM_1705044926)
          by smtp.aliyun-inc.com;
          Fri, 12 Jan 2024 15:35:27 +0800
From: "Bang Li" <libang.li@antgroup.com>
To: akpm@linux-foundation.org
Cc:  <linux-mm@kvack.org>,
   <linux-kernel@vger.kernel.org>,
  "=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?=" <teawater@antgroup.com>,
  "=?UTF-8?B?WWFuIFlhbihjYWlsaW5nKQ==?=" <yanyan.yan@antgroup.com>,
  "Bang Li" <libang.li@antgroup.com>
Subject: [PATCH] mm/compaction: Reduce unnecessary loops
Date: Fri, 12 Jan 2024 15:35:24 +0800
Message-Id: <20240112073524.80724-1-libang.li@antgroup.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compaction will be triggered when we write 1 to '/proc/sys/vm/
compact_memory'. During the execution of the process, when we send
SIGKILL to terminate the compaction, the process does not exit
immediately. Instead, it will continue to loop through the remaining
zones and nodes before exiting.

in my environment:

[root]# cat /proc/buddyinfo
Node 0, zone      DMA      1      1      1      0      2      1      1      0      1      1      3
Node 0, zone    DMA32   1666   1123    804    625    488    356    321    278    209    178    250
Node 0, zone   Normal  58852  83160  49983   9812   2287   1229  19604  24471  10346   5219  12205
[root]# echo 1 > /sys/kernel/debug/tracing/events/compaction/mm_compaction_end/enable

before the patch:

[root]# timeout --signal=SIGKILL 0.002 bash -c 'echo 1 > /proc/sys/vm/compact_memory'
[root]# cat /sys/kernel/debug/tracing/trace_pipe
           <...>-26494   [014] .....   226.468993: mm_compaction_end: zone_start=0x1 migrate_pfn=0xe00 free_pfn=0xe00 zone_end=0x1000, mode=sync status=complete
           <...>-26494   [014] .....   226.469718: mm_compaction_end: zone_start=0x1000 migrate_pfn=0x20a80 free_pfn=0xffe00 zone_end=0x100000, mode=sync status=contended
           <...>-26494   [014] .....   226.469720: mm_compaction_end: zone_start=0x100000 migrate_pfn=0x100000 free_pfn=0x307fe00 zone_end=0x3080000, mode=sync status=contended

after the patch:

[root]# timeout --signal=SIGKILL 0.002 bash -c 'echo 1 > /proc/sys/vm/compact_memory'
[root]# cat /sys/kernel/debug/tracing/trace_pipe
           <...>-17491   [053] .....   109.005387: mm_compaction_end: zone_start=0x1 migrate_pfn=0xe00 free_pfn=0xe00 zone_end=0x1000, mode=sync status=complete
           <...>-17491   [053] .....   109.006139: mm_compaction_end: zone_start=0x1000 migrate_pfn=0x22220 free_pfn=0xffe00 zone_end=0x100000, mode=sync status=contended

Although it exits quickly after receiving the SIGKILL signal, a better
solution is to terminate the loop early after receiving the SIGKILL
signal.

Signed-off-by: Bang Li <libang.li@antgroup.com>
---
 mm/compaction.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 27ada42924d5..16f2bde5205d 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2807,7 +2807,7 @@ static void proactive_compact_node(pg_data_t *pgdat)
 }
 
 /* Compact all zones within a node */
-static void compact_node(int nid)
+static int compact_node(int nid)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
 	int zoneid;
@@ -2830,7 +2830,12 @@ static void compact_node(int nid)
 		cc.zone = zone;
 
 		compact_zone(&cc, NULL);
+
+		if (fatal_signal_pending(current))
+			return -EINTR;
 	}
+
+	return 0;
 }
 
 /* Compact all nodes in the system */
@@ -2841,8 +2846,10 @@ static void compact_nodes(void)
 	/* Flush pending updates to the LRU lists */
 	lru_add_drain_all();
 
-	for_each_online_node(nid)
-		compact_node(nid);
+	for_each_online_node(nid) {
+		if (compact_node(nid))
+			break;
+	}
 }
 
 static int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
-- 
2.19.1.6.gb485710b


