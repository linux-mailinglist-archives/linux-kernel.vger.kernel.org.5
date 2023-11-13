Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461D17EA726
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjKMXpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjKMXpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:45:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D042910C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699919086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=kzmqPw87QEnBeQlSVWGP3J/i9psO+2r7MY9OYmaqENY=;
        b=SFEhJbx2P30DtkyJtAeGImnme/Tc6+QiEWWLyv1JxBGOUaMIJaY/fbsU+xwPjOdq3yAEjc
        +duoKUPoZTFGEFiJjFyqnE4xPiOL0hzP1bm2mIyoqCgT6D3Q7RrpuWBFrAsBg1YwVLuu7E
        qHvVtrwDUnpvhpNInUqKk85thQVvVwA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-cZCqJAktN82N8Llx0r_7qg-1; Mon,
 13 Nov 2023 18:44:43 -0500
X-MC-Unique: cZCqJAktN82N8Llx0r_7qg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CA341C2B660;
        Mon, 13 Nov 2023 23:44:42 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CCD5F40C6EB9;
        Mon, 13 Nov 2023 23:44:41 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 300E6409C16E0; Mon, 13 Nov 2023 20:35:57 -0300 (-03)
Message-ID: <20231113233502.587879658@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 13 Nov 2023 20:34:22 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 2/2] mm: vmstat: use node_page_state_snapshot in too_many_isolated
References: <20231113233420.446465795@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A customer reported seeing processes hung at too_many_isolated,
while analysis indicated that the problem occurred due to out
of sync per-CPU stats (see below).

Fix is to use node_page_state_snapshot to avoid the out of stale values.

2136 static unsigned long
    2137 shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
    2138                      struct scan_control *sc, enum lru_list lru)
    2139 {
    :
    2145         bool file = is_file_lru(lru);
    :
    2147         struct pglist_data *pgdat = lruvec_pgdat(lruvec);
    :
    2150         while (unlikely(too_many_isolated(pgdat, file, sc))) {
    2151                 if (stalled)
    2152                         return 0;
    2153 
    2154                 /* wait a bit for the reclaimer. */
    2155                 msleep(100);   <--- some processes were sleeping here, with pending SIGKILL.
    2156                 stalled = true;
    2157 
    2158                 /* We are about to die and free our memory. Return now. */
    2159                 if (fatal_signal_pending(current))
    2160                         return SWAP_CLUSTER_MAX;
    2161         }

msleep() must be called only when there are too many isolated pages: 

    2019 static int too_many_isolated(struct pglist_data *pgdat, int file,
    2020                 struct scan_control *sc)
    2021 {
    :
    2030         if (file) {
    2031                 inactive = node_page_state(pgdat, NR_INACTIVE_FILE);
    2032                 isolated = node_page_state(pgdat, NR_ISOLATED_FILE);
    2033         } else {
    :
    2046         return isolated > inactive;

The return value was true since:

    crash> p ((struct pglist_data *) 0xffff00817fffe580)->vm_stat[NR_INACTIVE_FILE]
    $8 = {
      counter = 1
    }
    crash> p ((struct pglist_data *) 0xffff00817fffe580)->vm_stat[NR_ISOLATED_FILE]
    $9 = {
      counter = 2

while per_cpu stats had:

    crash> p ((struct pglist_data *) 0xffff00817fffe580)->per_cpu_nodestats
    $85 = (struct per_cpu_nodestat *) 0xffff8000118832e0
    crash> p/x 0xffff8000118832e0 + __per_cpu_offset[42]
    $86 = 0xffff00917fcc32e0
    crash> p ((struct per_cpu_nodestat *) 0xffff00917fcc32e0)->vm_node_stat_diff[NR_ISOLATED_FILE]
    $87 = -1 '\377'
    
    crash> p/x 0xffff8000118832e0 + __per_cpu_offset[44]
    $89 = 0xffff00917fe032e0
    crash> p ((struct per_cpu_nodestat *) 0xffff00917fe032e0)->vm_node_stat_diff[NR_ISOLATED_FILE]
    $91 = -1 '\377' 

It seems that processes were trapped in direct reclaim/compaction loop
because these nodes had few free pages lower than watermark min.

  crash> kmem -z | grep -A 3 Normal
  :
  NODE: 4  ZONE: 1  ADDR: ffff00817fffec40  NAME: "Normal"
    SIZE: 8454144  PRESENT: 98304  MIN/LOW/HIGH: 68/166/264
    VM_STAT:
          NR_FREE_PAGES: 68
  --
  NODE: 5  ZONE: 1  ADDR: ffff00897fffec40  NAME: "Normal"
    SIZE: 118784  MIN/LOW/HIGH: 82/200/318
    VM_STAT:
          NR_FREE_PAGES: 45
  --
  NODE: 6  ZONE: 1  ADDR: ffff00917fffec40  NAME: "Normal"
    SIZE: 118784  MIN/LOW/HIGH: 82/200/318
    VM_STAT:
          NR_FREE_PAGES: 53
  --
  NODE: 7  ZONE: 1  ADDR: ffff00997fbbec40  NAME: "Normal"
    SIZE: 118784  MIN/LOW/HIGH: 82/200/318
    VM_STAT:
          NR_FREE_PAGES: 52

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 mm/compaction.c |    6 +++---
 mm/vmscan.c     |    8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

Index: linux/mm/compaction.c
===================================================================
--- linux.orig/mm/compaction.c
+++ linux/mm/compaction.c
@@ -791,11 +791,11 @@ static bool too_many_isolated(struct com
 
 	unsigned long active, inactive, isolated;
 
-	inactive = node_page_state(pgdat, NR_INACTIVE_FILE) +
+	inactive = node_page_state_snapshot(pgdat, NR_INACTIVE_FILE) +
 			node_page_state(pgdat, NR_INACTIVE_ANON);
-	active = node_page_state(pgdat, NR_ACTIVE_FILE) +
+	active = node_page_state_snapshot(pgdat, NR_ACTIVE_FILE) +
 			node_page_state(pgdat, NR_ACTIVE_ANON);
-	isolated = node_page_state(pgdat, NR_ISOLATED_FILE) +
+	isolated = node_page_state_snapshot(pgdat, NR_ISOLATED_FILE) +
 			node_page_state(pgdat, NR_ISOLATED_ANON);
 
 	/*
Index: linux/mm/vmscan.c
===================================================================
--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -1756,11 +1756,11 @@ static int too_many_isolated(struct pgli
 		return 0;
 
 	if (file) {
-		inactive = node_page_state(pgdat, NR_INACTIVE_FILE);
-		isolated = node_page_state(pgdat, NR_ISOLATED_FILE);
+		inactive = node_page_state_snapshot(pgdat, NR_INACTIVE_FILE);
+		isolated = node_page_state_snapshot(pgdat, NR_ISOLATED_FILE);
 	} else {
-		inactive = node_page_state(pgdat, NR_INACTIVE_ANON);
-		isolated = node_page_state(pgdat, NR_ISOLATED_ANON);
+		inactive = node_page_state_snapshot(pgdat, NR_INACTIVE_ANON);
+		isolated = node_page_state_snapshot(pgdat, NR_ISOLATED_ANON);
 	}
 
 	/*


