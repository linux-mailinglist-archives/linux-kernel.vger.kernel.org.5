Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5747FF01A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345538AbjK3N2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjK3N2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:28:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A32D6C;
        Thu, 30 Nov 2023 05:28:25 -0800 (PST)
Date:   Thu, 30 Nov 2023 13:28:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701350903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mOpN8Iak2/OJw05hoCr+GK2iIlc++ht5sIA0P0Wo5cg=;
        b=f6K4ws7QVU4nznJOytCRVktEIpwL4LNXK9dmPw7I9wNMqPLoRR4b4bCvjScWfz2BbVCzKp
        nG+NHGAr0ma6g5RRwqcmT59JbD03TZHLUL/Xt9t7BbEHveHRtX2fyryMMmkrl6ucbGOad/
        7Myhv1BR7dQ1Sq7ncW05PLKU/m4AhXn8FNWzfzStmgDFVWwf2dheqodf12x9D8yVgfsaHC
        +EOlgt/97wt4KTv9xTMTx40oRaSOpoMlKSNt2O2lN+oWuFtEpkKVlIThtwfvbJkyPeTRtW
        yVOPyq3zRZqrJV6XJDLEnexL/K032sOBQcvcHiAPJb95IElN5aTmh2VeJk0TAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701350903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mOpN8Iak2/OJw05hoCr+GK2iIlc++ht5sIA0P0Wo5cg=;
        b=Y6PpYNDXabZvv6HzS1CME6T/8rs8zDdZnHwfvwt5iQprAaD74fqI4UUlcChCIxnMHN0ZNE
        NEi/XFktlt3yWJBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix perf_event_validate_size()
Cc:     Budimir Markovic <markovicbudimir@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170135090300.398.16580844443906542392.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     382c27f4ed28f803b1f1473ac2d8db0afc795a1b
Gitweb:        https://git.kernel.org/tip/382c27f4ed28f803b1f1473ac2d8db0afc795a1b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 29 Nov 2023 15:24:52 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Nov 2023 15:43:50 +01:00

perf: Fix perf_event_validate_size()

Budimir noted that perf_event_validate_size() only checks the size of
the newly added event, even though the sizes of all existing events
can also change due to not all events having the same read_format.

When we attach the new event, perf_group_attach(), we do re-compute
the size for all events.

Fixes: a723968c0ed3 ("perf: Fix u16 overflows")
Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c | 61 ++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b704d83..c9d123e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1814,31 +1814,34 @@ static inline void perf_event__state_init(struct perf_event *event)
 					      PERF_EVENT_STATE_INACTIVE;
 }
 
-static void __perf_event_read_size(struct perf_event *event, int nr_siblings)
+static int __perf_event_read_size(u64 read_format, int nr_siblings)
 {
 	int entry = sizeof(u64); /* value */
 	int size = 0;
 	int nr = 1;
 
-	if (event->attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
 		size += sizeof(u64);
 
-	if (event->attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 		size += sizeof(u64);
 
-	if (event->attr.read_format & PERF_FORMAT_ID)
+	if (read_format & PERF_FORMAT_ID)
 		entry += sizeof(u64);
 
-	if (event->attr.read_format & PERF_FORMAT_LOST)
+	if (read_format & PERF_FORMAT_LOST)
 		entry += sizeof(u64);
 
-	if (event->attr.read_format & PERF_FORMAT_GROUP) {
+	if (read_format & PERF_FORMAT_GROUP) {
 		nr += nr_siblings;
 		size += sizeof(u64);
 	}
 
-	size += entry * nr;
-	event->read_size = size;
+	/*
+	 * Since perf_event_validate_size() limits this to 16k and inhibits
+	 * adding more siblings, this will never overflow.
+	 */
+	return size + nr * entry;
 }
 
 static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
@@ -1888,8 +1891,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
  */
 static void perf_event__header_size(struct perf_event *event)
 {
-	__perf_event_read_size(event,
-			       event->group_leader->nr_siblings);
+	event->read_size =
+		__perf_event_read_size(event->attr.read_format,
+				       event->group_leader->nr_siblings);
 	__perf_event_header_size(event, event->attr.sample_type);
 }
 
@@ -1920,24 +1924,35 @@ static void perf_event__id_header_size(struct perf_event *event)
 	event->id_header_size = size;
 }
 
+/*
+ * Check that adding an event to the group does not result in anybody
+ * overflowing the 64k event limit imposed by the output buffer.
+ *
+ * Specifically, check that the read_size for the event does not exceed 16k,
+ * read_size being the one term that grows with groups size. Since read_size
+ * depends on per-event read_format, also (re)check the existing events.
+ *
+ * This leaves 48k for the constant size fields and things like callchains,
+ * branch stacks and register sets.
+ */
 static bool perf_event_validate_size(struct perf_event *event)
 {
-	/*
-	 * The values computed here will be over-written when we actually
-	 * attach the event.
-	 */
-	__perf_event_read_size(event, event->group_leader->nr_siblings + 1);
-	__perf_event_header_size(event, event->attr.sample_type & ~PERF_SAMPLE_READ);
-	perf_event__id_header_size(event);
+	struct perf_event *sibling, *group_leader = event->group_leader;
 
-	/*
-	 * Sum the lot; should not exceed the 64k limit we have on records.
-	 * Conservative limit to allow for callchains and other variable fields.
-	 */
-	if (event->read_size + event->header_size +
-	    event->id_header_size + sizeof(struct perf_event_header) >= 16*1024)
+	if (__perf_event_read_size(event->attr.read_format,
+				   group_leader->nr_siblings + 1) > 16*1024)
 		return false;
 
+	if (__perf_event_read_size(group_leader->attr.read_format,
+				   group_leader->nr_siblings + 1) > 16*1024)
+		return false;
+
+	for_each_sibling_event(sibling, group_leader) {
+		if (__perf_event_read_size(sibling->attr.read_format,
+					   group_leader->nr_siblings + 1) > 16*1024)
+			return false;
+	}
+
 	return true;
 }
 
