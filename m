Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EB37B71A1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbjJCTTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240870AbjJCTTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:19:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0276DAC;
        Tue,  3 Oct 2023 12:19:08 -0700 (PDT)
Date:   Tue, 03 Oct 2023 19:19:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696360747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JLggR4hP0YNeCfk8Z90Zu+QllYjvLO9T0uR23xEQClA=;
        b=bQnmu4hYKw7J3LyK+af2GK9vmsSRkKqrzcR7+ueJHK3LTpZf9gfPpqNARp0n2IZ+yW3V2s
        ZGUBYx/0BCz1QW6+cLK2cW3ryrqUxkGpW0jg4mrkR1VL3kuNlbosEbUNWAitKumKRKg+9M
        FCWYNKaQjBjmRTq7axGt4o987Ia0RWUJVT6CONLbFh41cS8H9TqKdCoZ2kYcSJMFqaorp+
        WEDZ8MBjjuA6oOS8WqdDTRzjrBbjhbNmEzOnamFiUw9S16JM80QNrZ6uJ2H9M1q/JSOIAs
        Af4S/8BbXw91CqEBViDduhO3ItYUV+n6Rzjy663DhUiamjCnvgSisErFWhhesA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696360747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JLggR4hP0YNeCfk8Z90Zu+QllYjvLO9T0uR23xEQClA=;
        b=+lPAcBN0DeKMgCmg54FuSJ8XFGdE38Ex5WRl1B0CjnTACt8RqwufKhnmhXNwTQzM4Q5Y/0
        oci6aN9kH2IPvrDw==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Stop doing cpu_relax() in the
 local64_cmpxchg() loop in rapl_event_update()
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230807145134.3176-1-ubizjak@gmail.com>
References: <20230807145134.3176-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169636074660.3135.17644433006738661044.tip-bot2@tip-bot2>
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

Commit-ID:     1ce19bf90bd55bf54f9ed75d594029db63d395b0
Gitweb:        https://git.kernel.org/tip/1ce19bf90bd55bf54f9ed75d594029db63d395b0
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 07 Aug 2023 16:51:14 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 21:13:23 +02:00

perf/x86/rapl: Stop doing cpu_relax() in the local64_cmpxchg() loop in rapl_event_update()

According to the following commit:

   f5fe24ef17b5 ("lockref: stop doing cpu_relax in the cmpxchg loop")

   "On the x86-64 architecture even a failing cmpxchg grants exclusive
    access to the cacheline, making it preferable to retry the failed op
    immediately instead of stalling with the pause instruction."

Based on the above observation, remove cpu_relax() from the
local64_cmpxchg() loop of rapl_event_update().

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20230807145134.3176-1-ubizjak@gmail.com
---
 arch/x86/events/rapl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 1579429..e8f53b2 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -184,10 +184,8 @@ again:
 	rdmsrl(event->hw.event_base, new_raw_count);
 
 	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-			    new_raw_count) != prev_raw_count) {
-		cpu_relax();
+			    new_raw_count) != prev_raw_count)
 		goto again;
-	}
 
 	/*
 	 * Now we have the new raw value and have updated the prev
