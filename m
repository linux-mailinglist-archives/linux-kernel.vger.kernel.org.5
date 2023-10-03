Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5012A7B62B3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjJCHqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjJCHqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:46:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE83A9;
        Tue,  3 Oct 2023 00:45:56 -0700 (PDT)
Date:   Tue, 03 Oct 2023 07:45:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696319155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=upHOqm9ZlfS4CRKOxbhW/yLyTqSD3syqj4fBx15H5dQ=;
        b=itovq23DX9jPAAdl6M1L/+1rfnV0il1nCuesJjXCxeX5IDS77YqJlAqTluq9OQLAdgLSjv
        23rL5702xxnCRNRZ4aEhQ16eKbcNNmLK3MCi/Pm22M5DjiIYgSECuv5Ntak9Zsvd/gFVRp
        7f+tSprGYrE6/pt3rAH0h9gGsnSDPrgtO3uL0GFKrBGoKbnyotfDsIBFA5phyL41C/u5lm
        77qM0Lhh5B/dJrg0wULxq3tjWnIEHls14AdPklQsc1CTiil6b/TbtmJUuvAMSUAtvIRKLk
        hq39cQ4OJqt4eaYg86icNnscCUD4dSIfu9GYtGEW+MXn0z9LqlnXCZB5gynEmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696319155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=upHOqm9ZlfS4CRKOxbhW/yLyTqSD3syqj4fBx15H5dQ=;
        b=6jRj2UFeMs7XXcEZOTelpNioWeoXE5zwYzcQUccJuI+wvZTHdzlLtrAa7wagXW2F+/aHOp
        GdI+ubWCuEQA+aAQ==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Use local64_try_cmpxchg in
 rapl_event_update()
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230807145134.3176-2-ubizjak@gmail.com>
References: <20230807145134.3176-2-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169631915427.3135.14176807779791264532.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     df60e18058bb6792c85e4ede43876c1df44f5b9a
Gitweb:        https://git.kernel.org/tip/df60e18058bb6792c85e4ede43876c1df44f5b9a
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 07 Aug 2023 16:51:15 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 09:36:18 +02:00

perf/x86/rapl: Use local64_try_cmpxchg in rapl_event_update()

Use local64_try_cmpxchg() instead of local64_cmpxchg(*ptr, old, new) == old.

X86 CMPXCHG instruction returns success in ZF flag, so this change saves a
compare after CMPXCHG (and related move instruction in front of CMPXCHG).

Also, try_cmpxchg() implicitly assigns old *ptr value to "old" when CMPXCHG
fails. There is no need to re-read the value in the loop.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230807145134.3176-2-ubizjak@gmail.com

Cc. "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/events/rapl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index e8f53b2..6d3e738 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -179,13 +179,11 @@ static u64 rapl_event_update(struct perf_event *event)
 	s64 delta, sdelta;
 	int shift = RAPL_CNTR_WIDTH;
 
-again:
 	prev_raw_count = local64_read(&hwc->prev_count);
-	rdmsrl(event->hw.event_base, new_raw_count);
-
-	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-			    new_raw_count) != prev_raw_count)
-		goto again;
+	do {
+		rdmsrl(event->hw.event_base, new_raw_count);
+	} while (!local64_try_cmpxchg(&hwc->prev_count,
+				      &prev_raw_count, new_raw_count));
 
 	/*
 	 * Now we have the new raw value and have updated the prev
