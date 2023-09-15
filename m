Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA40E7A1E13
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjIOMGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbjIOMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:06:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F143584;
        Fri, 15 Sep 2023 05:03:30 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:03:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694779409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tBk01TZqJa0xUvb64FfLoh9y4GLN054lkdXjN7A7La8=;
        b=EsaiYeOw9T+ygEcGJlO8QQ8dsaBQfcqHNHFB3Cn+etpQ/UJ5l/e48LNvGwv+BQHC4F71SL
        iy7Yoo1PNrjEhYVjvERHW1/GHJIxwPntFtdHdPvZkKQrU7TQ+80w7POl+3DYg/jszoiLSc
        vEWVcnNKuj0s2bUWdc25YrcGKy6c2ORTiJ2bPbAAiYyby8w4i5noLrvvsmKHRpsgBy+foc
        WpOmoHFxsIVJ0n2baVyKvDozJIBaN5e1EqA49++wIxrFX0o+da2OVMgDvXE98G58p7l3nb
        qF3wSUjDtby0OlJsmgA6887byiKNnC1TafGXUvzCs0AsxB9Tr/frJ1woVK9f2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694779409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tBk01TZqJa0xUvb64FfLoh9y4GLN054lkdXjN7A7La8=;
        b=FmXegposMGlqeGZhwhfMgaDBYdRN9Mx1sWsk5hc86W+OZcE1q9kE0usBLy/FmOnGNK9ulz
        T7nJTK1oZkeUIzDA==
From:   "tip-bot2 for Yury Norov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix open-coded numa_nearest_node()
Cc:     Yury Norov <yury.norov@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230819141239.287290-3-yury.norov@gmail.com>
References: <20230819141239.287290-3-yury.norov@gmail.com>
MIME-Version: 1.0
Message-ID: <169477940902.27769.3566376802843412168.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d1db9fb432d50b0eecdfdd85d17cc15a59cc093b
Gitweb:        https://git.kernel.org/tip/d1db9fb432d50b0eecdfdd85d17cc15a59cc093b
Author:        Yury Norov <yury.norov@gmail.com>
AuthorDate:    Sat, 19 Aug 2023 07:12:34 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Sep 2023 13:48:10 +02:00

sched/fair: Fix open-coded numa_nearest_node()

task_numa_placement() searches for a nearest node to migrate by calling
for_each_node_state(). Now that we have numa_nearest_node(), switch to
using it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20230819141239.287290-3-yury.norov@gmail.com
---
 kernel/sched/fair.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8dbff6e..41cfd61 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2847,19 +2847,7 @@ static void task_numa_placement(struct task_struct *p)
 	}
 
 	/* Cannot migrate task to CPU-less node */
-	if (max_nid != NUMA_NO_NODE && !node_state(max_nid, N_CPU)) {
-		int near_nid = max_nid;
-		int distance, near_distance = INT_MAX;
-
-		for_each_node_state(nid, N_CPU) {
-			distance = node_distance(max_nid, nid);
-			if (distance < near_distance) {
-				near_nid = nid;
-				near_distance = distance;
-			}
-		}
-		max_nid = near_nid;
-	}
+	max_nid = numa_nearest_node(max_nid, N_CPU);
 
 	if (ng) {
 		numa_group_count_active_nodes(ng);
