Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D9576CD09
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbjHBMjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbjHBMiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:38:55 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C002330F3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:38:36 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a426e70575so4101887b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 05:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690979915; x=1691584715;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHj0ogn13uTD9ShXB2epVwSA8wIkWRIMgchHlQuBxLk=;
        b=WJgrzvkLDCxVrGzix111FmRTltpPpjO64wXrQbc3d4n8G+ckVsq12T9rapATZp2PW+
         lSIWWFy5GpvB5GHZlX2d0S9+rwXCmZDrWAo4Ujx87DJ4xEWP9lEdJlnieQYQ3xtiVfPI
         bk3wM9DbfoXAER0cr9qZLNpFF+lxJwht27dY+jWfBPQK5rujlRkkf9+ZgargfUTPoAGo
         u654rmIL1LsvndT2AqxeattLmn0BrUWY7goKlUuYzMH+EgXpjS3kM0GvJAku+2xS6VP+
         iULEc+LfoRtGopXWukQld7lm/yNSxkcB7khdxDqFIMwHM3CvhrDxdd5mScx/P21/DFgt
         xZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690979915; x=1691584715;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHj0ogn13uTD9ShXB2epVwSA8wIkWRIMgchHlQuBxLk=;
        b=LmWGrJtkdnWm0O+uLwEXWot44n3S1Gos5M3ItQVMtfD/0JiOlVvzJTtGLb280dVXZ6
         OmjnYqAwcWcvkEMZy8NGYc//pdA7PAE6Kbm3IifYb0qE6Pj5+a3m/0PgTTWhvc5q+lM9
         3N5Q65dFJn0Yp4aABmVGOpHXbDv3FmMpCHpsB+3gQDaCW+5WX1FVBim8IubL7jR+95Ml
         GxaSXTePljgC10df5DtSjR9VjGgqgv5aagtN3Xeb8lENRlFPwjzOs+gFD9v6ie8Hnsxd
         +upUoRypYloDQ56MQmeHzpsCIGSkqVOwLlZcLaxLuLIHu04Vzc4VlKUVIbJ8372sOgF4
         Hyaw==
X-Gm-Message-State: ABy/qLYWIVFMGyB/7jzwcYtuK1jQ3/AGDElXLDav+J0MQdIorltGvSQa
        dWTuJRcwUC+6WvYveau3+GI=
X-Google-Smtp-Source: APBJJlGx9qMcCJMFddU0V+VzxGFmFG3wURPqhamSEipbPZmZopsqwCEWMBb6mbzA5GhBbttT7CZy1w==
X-Received: by 2002:a05:6808:2382:b0:3a0:38c2:2654 with SMTP id bp2-20020a056808238200b003a038c22654mr16938376oib.58.1690979915061;
        Wed, 02 Aug 2023 05:38:35 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a001e00b00265c742a262sm1118029pja.4.2023.08.02.05.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:38:33 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        akpm@linux-foundation.org
Cc:     ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2] ocfs2: cluster: fix potential deadlock on &qs->qs_lock
Date:   Wed,  2 Aug 2023 12:38:24 +0000
Message-Id: <20230802123824.15301-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

&qs->qs_lock is acquired by timer o2net_idle_timer() along the following
call chain. Thus the acquisition of the lock under process context should
disable bottom half, otherwise deadlock could happen if the timer happens
to preempt the execution while the lock is held in process context on the
same CPU.

<timer interrupt>
        -> o2net_idle_timer()
        -> o2quo_conn_err()
        -> spin_lock(&qs->qs_lock)

Several lock acquisition of &qs->qs_lock under process contex do not
disable irq or bottom half. The patch fixes these potential deadlocks
scenerio by using spin_lock_bh() on &qs->qs_lock.

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock. x86_64 allmodconfig using gcc shows
no new warning.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

Changes in v2
- Consistently use spin_lock_bh() on all potential deadlock sites of
  &qs->qs_lock
---
 fs/ocfs2/cluster/quorum.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/ocfs2/cluster/quorum.c b/fs/ocfs2/cluster/quorum.c
index 189c111bc371..15d0ed9c13e5 100644
--- a/fs/ocfs2/cluster/quorum.c
+++ b/fs/ocfs2/cluster/quorum.c
@@ -93,7 +93,7 @@ static void o2quo_make_decision(struct work_struct *work)
 	int lowest_hb, lowest_reachable = 0, fence = 0;
 	struct o2quo_state *qs = &o2quo_state;
 
-	spin_lock(&qs->qs_lock);
+	spin_lock_bh(&qs->qs_lock);
 
 	lowest_hb = find_first_bit(qs->qs_hb_bm, O2NM_MAX_NODES);
 	if (lowest_hb != O2NM_MAX_NODES)
@@ -146,14 +146,14 @@ static void o2quo_make_decision(struct work_struct *work)
 
 out:
 	if (fence) {
-		spin_unlock(&qs->qs_lock);
+		spin_unlock_bh(&qs->qs_lock);
 		o2quo_fence_self();
 	} else {
 		mlog(ML_NOTICE, "not fencing this node, heartbeating: %d, "
 			"connected: %d, lowest: %d (%sreachable)\n",
 			qs->qs_heartbeating, qs->qs_connected, lowest_hb,
 			lowest_reachable ? "" : "un");
-		spin_unlock(&qs->qs_lock);
+		spin_unlock_bh(&qs->qs_lock);
 
 	}
 
@@ -196,7 +196,7 @@ void o2quo_hb_up(u8 node)
 {
 	struct o2quo_state *qs = &o2quo_state;
 
-	spin_lock(&qs->qs_lock);
+	spin_lock_bh(&qs->qs_lock);
 
 	qs->qs_heartbeating++;
 	mlog_bug_on_msg(qs->qs_heartbeating == O2NM_MAX_NODES,
@@ -211,7 +211,7 @@ void o2quo_hb_up(u8 node)
 	else
 		o2quo_clear_hold(qs, node);
 
-	spin_unlock(&qs->qs_lock);
+	spin_unlock_bh(&qs->qs_lock);
 }
 
 /* hb going down releases any holds we might have had due to this node from
@@ -220,7 +220,7 @@ void o2quo_hb_down(u8 node)
 {
 	struct o2quo_state *qs = &o2quo_state;
 
-	spin_lock(&qs->qs_lock);
+	spin_lock_bh(&qs->qs_lock);
 
 	qs->qs_heartbeating--;
 	mlog_bug_on_msg(qs->qs_heartbeating < 0,
@@ -233,7 +233,7 @@ void o2quo_hb_down(u8 node)
 
 	o2quo_clear_hold(qs, node);
 
-	spin_unlock(&qs->qs_lock);
+	spin_unlock_bh(&qs->qs_lock);
 }
 
 /* this tells us that we've decided that the node is still heartbeating
@@ -245,14 +245,14 @@ void o2quo_hb_still_up(u8 node)
 {
 	struct o2quo_state *qs = &o2quo_state;
 
-	spin_lock(&qs->qs_lock);
+	spin_lock_bh(&qs->qs_lock);
 
 	mlog(0, "node %u\n", node);
 
 	qs->qs_pending = 1;
 	o2quo_clear_hold(qs, node);
 
-	spin_unlock(&qs->qs_lock);
+	spin_unlock_bh(&qs->qs_lock);
 }
 
 /* This is analogous to hb_up.  as a node's connection comes up we delay the
@@ -264,7 +264,7 @@ void o2quo_conn_up(u8 node)
 {
 	struct o2quo_state *qs = &o2quo_state;
 
-	spin_lock(&qs->qs_lock);
+	spin_lock_bh(&qs->qs_lock);
 
 	qs->qs_connected++;
 	mlog_bug_on_msg(qs->qs_connected == O2NM_MAX_NODES,
@@ -279,7 +279,7 @@ void o2quo_conn_up(u8 node)
 	else
 		o2quo_clear_hold(qs, node);
 
-	spin_unlock(&qs->qs_lock);
+	spin_unlock_bh(&qs->qs_lock);
 }
 
 /* we've decided that we won't ever be connecting to the node again.  if it's
@@ -290,7 +290,7 @@ void o2quo_conn_err(u8 node)
 {
 	struct o2quo_state *qs = &o2quo_state;
 
-	spin_lock(&qs->qs_lock);
+	spin_lock_bh(&qs->qs_lock);
 
 	if (test_bit(node, qs->qs_conn_bm)) {
 		qs->qs_connected--;
@@ -307,7 +307,7 @@ void o2quo_conn_err(u8 node)
 	mlog(0, "node %u, %d total\n", node, qs->qs_connected);
 
 
-	spin_unlock(&qs->qs_lock);
+	spin_unlock_bh(&qs->qs_lock);
 }
 
 void o2quo_init(void)
-- 
2.17.1

