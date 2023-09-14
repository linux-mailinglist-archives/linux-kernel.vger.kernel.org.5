Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BFA7A054C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbjINNQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbjINNQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:16:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8B91FD5;
        Thu, 14 Sep 2023 06:16:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 97A9021842;
        Thu, 14 Sep 2023 13:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694697399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKBTahQunslc+rwPFTpR4lF34AdmUPBQHy7sPwquY2I=;
        b=uaiILth6R+RqHEJYuiyeI/wOZnySfe2Scae7Znwl14HCONN8ce+9YyX3QF45A8wzyrrD8q
        E2TDy5VdI6Lg/5B5fpq7VOZlL/GUwT5vYDCXMriZPKRlKmN1NcCuvhiQAsHA4KaCRYdMbf
        GZvOmv0zLh7ojYXy2jitNGn2xxzlRNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694697399;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKBTahQunslc+rwPFTpR4lF34AdmUPBQHy7sPwquY2I=;
        b=aN1ZHWhPQDkc8CUonNARkRazVN6sN5vJ8cRFA6BO0/zMtH75/ClXY0kBphEWglj/rIegdl
        t22B/YjhQH6cSIAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 759F6139F2;
        Thu, 14 Sep 2023 13:16:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qNUVHLcHA2U6TQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 14 Sep 2023 13:16:39 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 2/2] mm, vmscan: remove ISOLATE_UNMAPPED
Date:   Thu, 14 Sep 2023 15:16:39 +0200
Message-ID: <20230914131637.12204-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914131637.12204-3-vbabka@suse.cz>
References: <20230914131637.12204-3-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This isolate_mode_t flag is effectively unused since 89f6c88a6ab4 ("mm:
__isolate_lru_page_prepare() in isolate_migratepages_block()") as
sc->may_unmap is now checked directly (and only node_reclaim has a mode
that sets it to 0). The last remaining place is mm_vmscan_lru_isolate
tracepoint for the isolate_mode parameter. That one was mainly used to
indicate the active/inactive mode, which the trace-vmscan-postprocess.pl
script consumed, but that got silently broken. After fixing the script
by the previous patch, it does not need the isolate_mode anymore. So
just remove the parameter and with that the whole ISOLATE_UNMAPPED flag.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 .../trace/postprocess/trace-vmscan-postprocess.pl         | 8 ++++----
 include/linux/mmzone.h                                    | 2 --
 include/trace/events/vmscan.h                             | 8 ++------
 mm/vmscan.c                                               | 3 +--
 4 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/Documentation/trace/postprocess/trace-vmscan-postprocess.pl b/Documentation/trace/postprocess/trace-vmscan-postprocess.pl
index 725d41a8d4ef..048dc0dbce64 100644
--- a/Documentation/trace/postprocess/trace-vmscan-postprocess.pl
+++ b/Documentation/trace/postprocess/trace-vmscan-postprocess.pl
@@ -112,7 +112,7 @@ my $regex_direct_end_default = 'nr_reclaimed=([0-9]*)';
 my $regex_kswapd_wake_default = 'nid=([0-9]*) order=([0-9]*)';
 my $regex_kswapd_sleep_default = 'nid=([0-9]*)';
 my $regex_wakeup_kswapd_default = 'nid=([0-9]*) order=([0-9]*) gfp_flags=([A-Z_|]*)';
-my $regex_lru_isolate_default = 'isolate_mode=([0-9]*) classzone=([0-9]*) order=([0-9]*) nr_requested=([0-9]*) nr_scanned=([0-9]*) nr_skipped=([0-9]*) nr_taken=([0-9]*) lru=([a-z_]*)';
+my $regex_lru_isolate_default = 'classzone=([0-9]*) order=([0-9]*) nr_requested=([0-9]*) nr_scanned=([0-9]*) nr_skipped=([0-9]*) nr_taken=([0-9]*) lru=([a-z_]*)';
 my $regex_lru_shrink_inactive_default = 'nid=([0-9]*) nr_scanned=([0-9]*) nr_reclaimed=([0-9]*) nr_dirty=([0-9]*) nr_writeback=([0-9]*) nr_congested=([0-9]*) nr_immediate=([0-9]*) nr_activate_anon=([0-9]*) nr_activate_file=([0-9]*) nr_ref_keep=([0-9]*) nr_unmap_fail=([0-9]*) priority=([0-9]*) flags=([A-Z_|]*)';
 my $regex_lru_shrink_active_default = 'lru=([A-Z_]*) nr_taken=([0-9]*) nr_active=([0-9]*) nr_deactivated=([0-9]*) nr_referenced=([0-9]*) priority=([0-9]*) flags=([A-Z_|]*)' ;
 my $regex_writepage_default = 'page=([0-9a-f]*) pfn=([0-9]*) flags=([A-Z_|]*)';
@@ -204,7 +204,7 @@ $regex_wakeup_kswapd = generate_traceevent_regex(
 $regex_lru_isolate = generate_traceevent_regex(
 			"vmscan/mm_vmscan_lru_isolate",
 			$regex_lru_isolate_default,
-			"isolate_mode", classzone", "order",
+			"classzone", "order",
 			"nr_requested", "nr_scanned", "nr_skipped", "nr_taken",
 			"lru");
 $regex_lru_shrink_inactive = generate_traceevent_regex(
@@ -379,8 +379,8 @@ sub process_events {
 				print "         $regex_lru_isolate/o\n";
 				next;
 			}
-			my $nr_scanned = $5;
-			my $lru = $8;
+			my $nr_scanned = $4;
+			my $lru = $7;
 
 			# To closer match vmstat scanning statistics, only count
 			# inactive lru as scanning
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4106fbc5b4b3..486587fcd27f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -639,8 +639,6 @@ struct lruvec {
 #endif
 };
 
-/* Isolate unmapped pages */
-#define ISOLATE_UNMAPPED	((__force isolate_mode_t)0x2)
 /* Isolate for asynchronous migration */
 #define ISOLATE_ASYNC_MIGRATE	((__force isolate_mode_t)0x4)
 /* Isolate unevictable pages */
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index d2123dd960d5..1a488c30afa5 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -285,10 +285,9 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
 		unsigned long nr_scanned,
 		unsigned long nr_skipped,
 		unsigned long nr_taken,
-		isolate_mode_t isolate_mode,
 		int lru),
 
-	TP_ARGS(highest_zoneidx, order, nr_requested, nr_scanned, nr_skipped, nr_taken, isolate_mode, lru),
+	TP_ARGS(highest_zoneidx, order, nr_requested, nr_scanned, nr_skipped, nr_taken, lru),
 
 	TP_STRUCT__entry(
 		__field(int, highest_zoneidx)
@@ -297,7 +296,6 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
 		__field(unsigned long, nr_scanned)
 		__field(unsigned long, nr_skipped)
 		__field(unsigned long, nr_taken)
-		__field(unsigned int, isolate_mode)
 		__field(int, lru)
 	),
 
@@ -308,7 +306,6 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
 		__entry->nr_scanned = nr_scanned;
 		__entry->nr_skipped = nr_skipped;
 		__entry->nr_taken = nr_taken;
-		__entry->isolate_mode = (__force unsigned int)isolate_mode;
 		__entry->lru = lru;
 	),
 
@@ -316,8 +313,7 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
 	 * classzone is previous name of the highest_zoneidx.
 	 * Reason not to change it is the ABI requirement of the tracepoint.
 	 */
-	TP_printk("isolate_mode=%d classzone=%d order=%d nr_requested=%lu nr_scanned=%lu nr_skipped=%lu nr_taken=%lu lru=%s",
-		__entry->isolate_mode,
+	TP_printk("classzone=%d order=%d nr_requested=%lu nr_scanned=%lu nr_skipped=%lu nr_taken=%lu lru=%s",
 		__entry->highest_zoneidx,
 		__entry->order,
 		__entry->nr_requested,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6f13394b112e..f2e5e992fefb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2389,8 +2389,7 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 	}
 	*nr_scanned = total_scan;
 	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, nr_to_scan,
-				    total_scan, skipped, nr_taken,
-				    sc->may_unmap ? 0 : ISOLATE_UNMAPPED, lru);
+				    total_scan, skipped, nr_taken, lru);
 	update_lru_sizes(lruvec, lru, nr_zone_taken);
 	return nr_taken;
 }
-- 
2.42.0

