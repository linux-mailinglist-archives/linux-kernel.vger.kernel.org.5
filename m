Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846077D9984
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345877AbjJ0NQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJ0NQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:16:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B25C2;
        Fri, 27 Oct 2023 06:16:52 -0700 (PDT)
Date:   Fri, 27 Oct 2023 13:16:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698412611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jwt9hayn6vPrZcnYrZKtCafofLuWqxGIW6u1vLVnfqw=;
        b=Iwgz/+oK17eCxS4aiBIBOsriJEXa5rwVGqszG7FwC2Mwz4BJSgJwMRjEEOzPcfjiVzaV0J
        hoUpqDhTEYtqIgn8l8EIx3JPmMOiF8wB5zLnEMFkxkH0nd1efvlRDy8kjKPvkfHlfrJSbO
        xU3KKhQC7445PmCZXXS+2k8ToM93S5FposJhKCflZZ/vmQjRH25/laXLKJnfRZLNbhy1MI
        uWhdW16zKxgfDijveNj6/e1qSI9fZqX3pwuGhAS7pzffktB0zwwgKGOATSNbZFoEe94F46
        L+OVCwS+ArfQUH/uruo1PyL/5qNdZ+EFyTYUXjUR19Bq7jwshrzEBwsUX0he7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698412611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jwt9hayn6vPrZcnYrZKtCafofLuWqxGIW6u1vLVnfqw=;
        b=s35mDTwvw0LlKVIdhgporScUKzdR1r+raO7yMW1v2UlZxqv+FbLgGQJd5SE95eSu5GBoeV
        v4cA8afz2anyfEAQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add branch_sample_call_stack
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231025201626.3000228-3-kan.liang@linux.intel.com>
References: <20231025201626.3000228-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169841261085.3135.9502675795859035116.tip-bot2@tip-bot2>
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

Commit-ID:     1f2376cd03dd3b965d130ed46a7c92769d614ba1
Gitweb:        https://git.kernel.org/tip/1f2376cd03dd3b965d130ed46a7c92769d614ba1
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 25 Oct 2023 13:16:21 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Oct 2023 15:05:09 +02:00

perf: Add branch_sample_call_stack

Add a helper function to check call stack sample type.

The later patch will invoke the function in several places.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20231025201626.3000228-3-kan.liang@linux.intel.com
---
 arch/x86/events/core.c     | 2 +-
 include/linux/perf_event.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 40c9af1..0905064 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -601,7 +601,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 		}
 	}
 
-	if (event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK)
+	if (branch_sample_call_stack(event))
 		event->attach_state |= PERF_ATTACH_TASK_DATA;
 
 	/*
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7897ef0..ac1a59c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1144,6 +1144,11 @@ static inline bool branch_sample_counters(const struct perf_event *event)
 	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS;
 }
 
+static inline bool branch_sample_call_stack(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
+}
+
 struct perf_sample_data {
 	/*
 	 * Fields set by perf_sample_data_init() unconditionally,
