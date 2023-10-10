Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964F47BF58D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442770AbjJJITv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442726AbjJJITf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:19:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75BAA4;
        Tue, 10 Oct 2023 01:19:33 -0700 (PDT)
Date:   Tue, 10 Oct 2023 08:19:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696925971;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMu6TYgdVk96reZutAj1sITsyuqIoE1XM25s6i/qFSA=;
        b=FeJu6Kahkg23bMJxHYV3VdQgufFiw2LcGN3IUYpb5BqOWPc794HqdWFMR+tIBwSE7jpmN1
        hJZzDGd5L+lOIspT10lQaZ4UBaMEAVq9M+ruLWqO4jxd+eSTSmrWk3qm4PvziktMgqSBYG
        CdR+j1ZOuBAc4ZIEZwmzER+J6HDkosAS2SVwqyoGRnhBUP2ws4jzs60nsqdQQVQ++7y3dk
        KLMksp6JNXacTts2TE+Hl02Wu+a5ZLkycO7OrcrrjUWiJ9AOkbN4suoBHZY8AvUg1bxwgG
        LqdM8OoQ0hdnQMi3GfoNHHee3VCt9+EDEXulucy7PVjTFzZLTN8hTL26cgvSLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696925971;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMu6TYgdVk96reZutAj1sITsyuqIoE1XM25s6i/qFSA=;
        b=qEkHrPri7slGwbu0i2gxSbRSaX4+ORSJFDuTrDFByB+pttGMs+LKqy6SXfP+nPXDx+sSue
        SriTFNCmJik7dMDQ==
From:   "tip-bot2 for Tero Kristo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Allow reading package events from
 perf_event_read_local
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230913125956.3652667-1-tero.kristo@linux.intel.com>
References: <20230913125956.3652667-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169692597126.3135.9524485873663887091.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1765bb61bb18a7b81f68806de6e8b8f5000f65bf
Gitweb:        https://git.kernel.org/tip/1765bb61bb18a7b81f68806de6e8b8f5000f65bf
Author:        Tero Kristo <tero.kristo@linux.intel.com>
AuthorDate:    Wed, 13 Sep 2023 15:59:56 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Oct 2023 16:12:22 +02:00

perf/core: Allow reading package events from perf_event_read_local

Per-package perf events are typically registered with a single CPU only,
however they can be read across all the CPUs within the package.
Currently perf_event_read maps the event CPU according to the topology
information to avoid an unnecessary SMP call, however
perf_event_read_local deals with hard values and rejects a read with a
failure if the CPU is not the one exactly registered. Allow similar
mapping within the perf_event_read_local if the perf event in question
can support this.

This allows users like BPF code to read the package perf events properly
across different CPUs within a package.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230913125956.3652667-1-tero.kristo@linux.intel.com
---
 kernel/events/core.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index af56919..708d474 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4425,6 +4425,9 @@ static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
 {
 	u16 local_pkg, event_pkg;
 
+	if ((unsigned)event_cpu >= nr_cpu_ids)
+		return event_cpu;
+
 	if (event->group_caps & PERF_EV_CAP_READ_ACTIVE_PKG) {
 		int local_cpu = smp_processor_id();
 
@@ -4527,6 +4530,8 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 			  u64 *enabled, u64 *running)
 {
 	unsigned long flags;
+	int event_oncpu;
+	int event_cpu;
 	int ret = 0;
 
 	/*
@@ -4551,15 +4556,22 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 		goto out;
 	}
 
+	/*
+	 * Get the event CPU numbers, and adjust them to local if the event is
+	 * a per-package event that can be read locally
+	 */
+	event_oncpu = __perf_event_read_cpu(event, event->oncpu);
+	event_cpu = __perf_event_read_cpu(event, event->cpu);
+
 	/* If this is a per-CPU event, it must be for this CPU */
 	if (!(event->attach_state & PERF_ATTACH_TASK) &&
-	    event->cpu != smp_processor_id()) {
+	    event_cpu != smp_processor_id()) {
 		ret = -EINVAL;
 		goto out;
 	}
 
 	/* If this is a pinned event it must be running on this CPU */
-	if (event->attr.pinned && event->oncpu != smp_processor_id()) {
+	if (event->attr.pinned && event_oncpu != smp_processor_id()) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -4569,7 +4581,7 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 	 * or local to this CPU. Furthermore it means its ACTIVE (otherwise
 	 * oncpu == -1).
 	 */
-	if (event->oncpu == smp_processor_id())
+	if (event_oncpu == smp_processor_id())
 		event->pmu->read(event);
 
 	*value = local64_read(&event->count);
