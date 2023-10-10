Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ABD7BF58C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442732AbjJJITg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379439AbjJJITc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:19:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4693A4;
        Tue, 10 Oct 2023 01:19:31 -0700 (PDT)
Date:   Tue, 10 Oct 2023 08:19:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696925970;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=krtUQmSlb1m09HhIcJ/jP6C/QflQUzkrmaItwHGMfRw=;
        b=3sXeHpwlc19ZTlBI0oUOX1Bnchba2FKam4Y4CufzIZAwn91tXUtH2YRKq05x2pQubiLp4j
        giT/fVegzriMsKAUYsuucpcUkJV2hQKPPxOCpY3i/3J6E1RYVAt9Tkwu1MPKyeaCJ43vB3
        2BB1oUQL+00hJvWY1kOn4Uq/y1i7hsEAG7AIUykwpGjDDukL2fwjBsk44sbVObOHI436Pb
        PKC4NNfUxJyE9XZ09v5Sr0fwBBMH+pBNxU0SUABy1HviL7D7R32jIZBEVjSMb18oO6GjQc
        EmzB7D3pVVBNAQSJUUuZrmen6A9InUcqeil4ev6CYlmY7cpsHFPi/7Ieh6ZMpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696925970;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=krtUQmSlb1m09HhIcJ/jP6C/QflQUzkrmaItwHGMfRw=;
        b=jdmnkk8ZRGYQyG/pdN4qz8w93+ChYACpLYnI8nP2FTVsbv5rF7s5FLDN4dkecMVst0WONS
        YPLBBZ8I7bPWwoBw==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/uncore: Use rdmsr if rdpmc is unavailable
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ce9d994e32a3fcb39fa59fcf43ab4260d11aba097=2E16964?=
 =?utf-8?q?25185=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Ce9d994e32a3fcb39fa59fcf43ab4260d11aba097=2E169642?=
 =?utf-8?q?5185=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169692596934.3135.13596342947023817018.tip-bot2@tip-bot2>
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

Commit-ID:     7ef0343855dc23a979a53b3143540f93f3e5bef8
Gitweb:        https://git.kernel.org/tip/7ef0343855dc23a979a53b3143540f93f3e5bef8
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 05 Oct 2023 10:53:13 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Oct 2023 16:12:24 +02:00

perf/x86/amd/uncore: Use rdmsr if rdpmc is unavailable

Not all uncore PMUs may support the use of the RDPMC instruction for
reading counters. In such cases, read the count from the corresponding
PERF_CTR register using the RDMSR instruction.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/e9d994e32a3fcb39fa59fcf43ab4260d11aba097.1696425185.git.sandipan.das@amd.com
---
 arch/x86/events/amd/uncore.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index ff1d09c..2fe6239 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -96,7 +96,16 @@ static void amd_uncore_read(struct perf_event *event)
 	 */
 
 	prev = local64_read(&hwc->prev_count);
-	rdpmcl(hwc->event_base_rdpmc, new);
+
+	/*
+	 * Some uncore PMUs do not have RDPMC assignments. In such cases,
+	 * read counts directly from the corresponding PERF_CTR.
+	 */
+	if (hwc->event_base_rdpmc < 0)
+		rdmsrl(hwc->event_base, new);
+	else
+		rdpmcl(hwc->event_base_rdpmc, new);
+
 	local64_set(&hwc->prev_count, new);
 	delta = (new << COUNTER_SHIFT) - (prev << COUNTER_SHIFT);
 	delta >>= COUNTER_SHIFT;
@@ -164,6 +173,9 @@ out:
 	hwc->event_base_rdpmc = pmu->rdpmc_base + hwc->idx;
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
+	if (pmu->rdpmc_base < 0)
+		hwc->event_base_rdpmc = -1;
+
 	if (flags & PERF_EF_START)
 		event->pmu->start(event, PERF_EF_RELOAD);
 
