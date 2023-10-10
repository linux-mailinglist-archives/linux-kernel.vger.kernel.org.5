Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E417BF7AA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjJJJoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjJJJnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:43:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C514B9F;
        Tue, 10 Oct 2023 02:43:49 -0700 (PDT)
Date:   Tue, 10 Oct 2023 09:43:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696931028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hyGfcz1FT6XDFHU1MwIubwjKxpqcfVPPlqtlsHiZTXQ=;
        b=TF78imSPGto4mYm4Ga9+Tjsk3udIDbja++oHLlM8MQueu1t0E2iaqAOgl62VBXFik2NENg
        S9w/gqHwoJc0CQnBfolETDQbD/soQBO20s0xmpZ9q9Mi8CBdzSq44Y2ErRY/8ZJK7eBgkq
        2PbqNelN14G0mL8JPKw5qIPikdJbL/OTF4gkQNarnER7gmL52mMiSYzDth6UA5Yp9Lz3+/
        MCr3U1CP9eaVdXWaLjZ8o+z1XryGgQBkvGoEgkbXHrZ4gkxW7EFxqeFrCTAd/pqHTa22wj
        PencerVBahIXYy/1FfF6MpQEnMySUd1hgOYz2eeBEG1+1zxkzR96CkqZhmYa4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696931028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hyGfcz1FT6XDFHU1MwIubwjKxpqcfVPPlqtlsHiZTXQ=;
        b=8AvPuH7yEiBACGcpaRka20ra35j/6CrakMXcrQYq0YtLJQIXLEKHnZHvueo/9sa0fW73jQ
        ps5tdMtouZyWCrCA==
From:   "tip-bot2 for Raghavendra K T" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Move up the access pid reset logic
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Raghavendra K T <raghavendra.kt@amd.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231010083143.19593-5-mgorman@techsingularity.net>
References: <20231010083143.19593-5-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <169693102782.3135.18020196809878344961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2e2675db1906ac04809f5399bf1f5e30d56a6f3e
Gitweb:        https://git.kernel.org/tip/2e2675db1906ac04809f5399bf1f5e30d56a6f3e
Author:        Raghavendra K T <raghavendra.kt@amd.com>
AuthorDate:    Tue, 10 Oct 2023 09:31:41 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Oct 2023 11:10:01 +02:00

sched/numa: Move up the access pid reset logic

Recent NUMA hinting faulting activity is reset approximately every
VMA_PID_RESET_PERIOD milliseconds. However, if the current task has not
accessed a VMA then the reset check is missed and the reset is potentially
deferred forever. Check if the PID activity information should be reset
before checking if the current task recently trapped a NUMA hinting fault.

[ mgorman@techsingularity.net: Rewrite changelog ]

Suggested-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231010083143.19593-5-mgorman@techsingularity.net
---
 kernel/sched/fair.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 31cfdb0..ce36969 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3260,16 +3260,7 @@ static void task_numa_work(struct callback_head *work)
 			continue;
 		}
 
-		/* Do not scan the VMA if task has not accessed */
-		if (!vma_is_accessed(vma)) {
-			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_PID_INACTIVE);
-			continue;
-		}
-
-		/*
-		 * RESET access PIDs regularly for old VMAs. Resetting after checking
-		 * vma for recent access to avoid clearing PID info before access..
-		 */
+		/* RESET access PIDs regularly for old VMAs. */
 		if (mm->numa_scan_seq &&
 				time_after(jiffies, vma->numab_state->pids_active_reset)) {
 			vma->numab_state->pids_active_reset = vma->numab_state->pids_active_reset +
@@ -3278,6 +3269,12 @@ static void task_numa_work(struct callback_head *work)
 			vma->numab_state->pids_active[1] = 0;
 		}
 
+		/* Do not scan the VMA if task has not accessed */
+		if (!vma_is_accessed(vma)) {
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_PID_INACTIVE);
+			continue;
+		}
+
 		do {
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
