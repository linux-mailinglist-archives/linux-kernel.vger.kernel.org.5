Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AB57A054B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbjINNQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238623AbjINNQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:16:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB9D1A5;
        Thu, 14 Sep 2023 06:16:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 72EB31F459;
        Thu, 14 Sep 2023 13:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694697399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rAhS+FVn6ocw85psQvFvN0PR1VlmozuQ4I8i9ZtjuaY=;
        b=rXYZHOfzaYBcmQOVenjZjswEmg6RN8Sk2V+BW7r+HfBOpYHGbbkEjxpu9Zgwo9D+tbJ4Vp
        kmB2yLegf2zWD9jKJ3Ng7DLOqQQ9DxQc92Zd8RqQLJohLIpq9KcXUJ7v+rov8SOyDnqYj6
        B+M40p1WYtQj6yYH4kenKUe5Ci3sMno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694697399;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rAhS+FVn6ocw85psQvFvN0PR1VlmozuQ4I8i9ZtjuaY=;
        b=w7ODrEMWKXDJyZH8yRRXjpu91JCbJkXlJ4zV31DCOedOfday7a05umNo2GtvdyBR8OgJ0B
        HgOQEkZWGtvD7wDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53F3B13580;
        Thu, 14 Sep 2023 13:16:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5fDXE7cHA2U6TQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 14 Sep 2023 13:16:39 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 1/2] trace-vmscan-postprocess: sync with tracepoints updates
Date:   Thu, 14 Sep 2023 15:16:38 +0200
Message-ID: <20230914131637.12204-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The script has fallen behind tracepoint changes for a while, fix it up.

Most changes are mechanical (renames, removal of tracepoint parameters
that are not used by the script). More notable change involves
mm_vmscan_lru_isolate which is relying on the isolate_mode to determine
if the inactive list is being scanned. However the parameter currently
only indicates ISOLATE_UNMAPPED. We can use the lru parameter instead to
determine which list is scanned, and stop checking isolate_mode.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 .../postprocess/trace-vmscan-postprocess.pl   | 40 ++++++++-----------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/Documentation/trace/postprocess/trace-vmscan-postprocess.pl b/Documentation/trace/postprocess/trace-vmscan-postprocess.pl
index e24c009789a0..725d41a8d4ef 100644
--- a/Documentation/trace/postprocess/trace-vmscan-postprocess.pl
+++ b/Documentation/trace/postprocess/trace-vmscan-postprocess.pl
@@ -107,14 +107,14 @@ GetOptions(
 );
 
 # Defaults for dynamically discovered regex's
-my $regex_direct_begin_default = 'order=([0-9]*) may_writepage=([0-9]*) gfp_flags=([A-Z_|]*)';
+my $regex_direct_begin_default = 'order=([0-9]*) gfp_flags=([A-Z_|]*)';
 my $regex_direct_end_default = 'nr_reclaimed=([0-9]*)';
 my $regex_kswapd_wake_default = 'nid=([0-9]*) order=([0-9]*)';
 my $regex_kswapd_sleep_default = 'nid=([0-9]*)';
-my $regex_wakeup_kswapd_default = 'nid=([0-9]*) zid=([0-9]*) order=([0-9]*) gfp_flags=([A-Z_|]*)';
-my $regex_lru_isolate_default = 'isolate_mode=([0-9]*) classzone_idx=([0-9]*) order=([0-9]*) nr_requested=([0-9]*) nr_scanned=([0-9]*) nr_skipped=([0-9]*) nr_taken=([0-9]*) lru=([a-z_]*)';
+my $regex_wakeup_kswapd_default = 'nid=([0-9]*) order=([0-9]*) gfp_flags=([A-Z_|]*)';
+my $regex_lru_isolate_default = 'isolate_mode=([0-9]*) classzone=([0-9]*) order=([0-9]*) nr_requested=([0-9]*) nr_scanned=([0-9]*) nr_skipped=([0-9]*) nr_taken=([0-9]*) lru=([a-z_]*)';
 my $regex_lru_shrink_inactive_default = 'nid=([0-9]*) nr_scanned=([0-9]*) nr_reclaimed=([0-9]*) nr_dirty=([0-9]*) nr_writeback=([0-9]*) nr_congested=([0-9]*) nr_immediate=([0-9]*) nr_activate_anon=([0-9]*) nr_activate_file=([0-9]*) nr_ref_keep=([0-9]*) nr_unmap_fail=([0-9]*) priority=([0-9]*) flags=([A-Z_|]*)';
-my $regex_lru_shrink_active_default = 'lru=([A-Z_]*) nr_scanned=([0-9]*) nr_rotated=([0-9]*) priority=([0-9]*)';
+my $regex_lru_shrink_active_default = 'lru=([A-Z_]*) nr_taken=([0-9]*) nr_active=([0-9]*) nr_deactivated=([0-9]*) nr_referenced=([0-9]*) priority=([0-9]*) flags=([A-Z_|]*)' ;
 my $regex_writepage_default = 'page=([0-9a-f]*) pfn=([0-9]*) flags=([A-Z_|]*)';
 
 # Dyanically discovered regex
@@ -184,8 +184,7 @@ sub generate_traceevent_regex {
 $regex_direct_begin = generate_traceevent_regex(
 			"vmscan/mm_vmscan_direct_reclaim_begin",
 			$regex_direct_begin_default,
-			"order", "may_writepage",
-			"gfp_flags");
+			"order", "gfp_flags");
 $regex_direct_end = generate_traceevent_regex(
 			"vmscan/mm_vmscan_direct_reclaim_end",
 			$regex_direct_end_default,
@@ -201,11 +200,11 @@ $regex_kswapd_sleep = generate_traceevent_regex(
 $regex_wakeup_kswapd = generate_traceevent_regex(
 			"vmscan/mm_vmscan_wakeup_kswapd",
 			$regex_wakeup_kswapd_default,
-			"nid", "zid", "order", "gfp_flags");
+			"nid", "order", "gfp_flags");
 $regex_lru_isolate = generate_traceevent_regex(
 			"vmscan/mm_vmscan_lru_isolate",
 			$regex_lru_isolate_default,
-			"isolate_mode", "classzone_idx", "order",
+			"isolate_mode", classzone", "order",
 			"nr_requested", "nr_scanned", "nr_skipped", "nr_taken",
 			"lru");
 $regex_lru_shrink_inactive = generate_traceevent_regex(
@@ -218,11 +217,10 @@ $regex_lru_shrink_inactive = generate_traceevent_regex(
 $regex_lru_shrink_active = generate_traceevent_regex(
 			"vmscan/mm_vmscan_lru_shrink_active",
 			$regex_lru_shrink_active_default,
-			"nid", "zid",
-			"lru",
-			"nr_scanned", "nr_rotated", "priority");
+			"nid", "nr_taken", "nr_active", "nr_deactivated", "nr_referenced",
+			"priority", "flags");
 $regex_writepage = generate_traceevent_regex(
-			"vmscan/mm_vmscan_writepage",
+			"vmscan/mm_vmscan_write_folio",
 			$regex_writepage_default,
 			"page", "pfn", "flags");
 
@@ -371,7 +369,7 @@ sub process_events {
 				print "         $regex_wakeup_kswapd\n";
 				next;
 			}
-			my $order = $3;
+			my $order = $2;
 			$perprocesspid{$process_pid}->{MM_VMSCAN_WAKEUP_KSWAPD_PERORDER}[$order]++;
 		} elsif ($tracepoint eq "mm_vmscan_lru_isolate") {
 			$details = $6;
@@ -381,18 +379,14 @@ sub process_events {
 				print "         $regex_lru_isolate/o\n";
 				next;
 			}
-			my $isolate_mode = $1;
 			my $nr_scanned = $5;
-			my $file = $8;
-
-			# To closer match vmstat scanning statistics, only count isolate_both
-			# and isolate_inactive as scanning. isolate_active is rotation
-			# isolate_inactive == 1
-			# isolate_active   == 2
-			# isolate_both     == 3
-			if ($isolate_mode != 2) {
+			my $lru = $8;
+
+			# To closer match vmstat scanning statistics, only count
+			# inactive lru as scanning
+			if ($lru =~ /inactive_/) {
 				$perprocesspid{$process_pid}->{HIGH_NR_SCANNED} += $nr_scanned;
-				if ($file =~ /_file/) {
+				if ($lru =~ /_file/) {
 					$perprocesspid{$process_pid}->{HIGH_NR_FILE_SCANNED} += $nr_scanned;
 				} else {
 					$perprocesspid{$process_pid}->{HIGH_NR_ANON_SCANNED} += $nr_scanned;
-- 
2.42.0

