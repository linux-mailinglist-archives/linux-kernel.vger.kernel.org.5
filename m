Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3127D4DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjJXKYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbjJXKYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:24:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E54C109;
        Tue, 24 Oct 2023 03:24:18 -0700 (PDT)
Date:   Tue, 24 Oct 2023 10:24:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698143056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=28aCRziD+yYu6Y2lzKh3gDPEavBxokK82RLhoT7NNw0=;
        b=k0j4X3y0RWj8F8IZfJzspiSy22wT9AtOeRwUc2Gdo0hQDKVsvUyU1ijt6GNQ+Ve+mNQwHU
        Q2tpu9/HOqli7hBVCPwglmVhisiskrtj6lu8EuO+MPNRBNly/KyGIooWkGdR1relQrpO/b
        MlhPY/sPZJfvYYwQ8DcvZMgZjGhthUzUQEIfj8WV7NNuYO150UVLVhxhRXMO5AcjxdXuN6
        6jhRqH2G7dGeACtH3foMjuXFjQYms1ayu5kfPOlJ8st5azQU/FWmAGkNRxvUftfjm755dR
        bccTpoY/zVDJ3tz6JbyyfSa3G4XRGr7PeckjLkzhDKqwEIqsJJvu6jfwa84UfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698143056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=28aCRziD+yYu6Y2lzKh3gDPEavBxokK82RLhoT7NNw0=;
        b=AHNaJxUx0HOXnZm6Ab6cfR/0xHMsawNipE4JRLeg1BB4njUhJ5jgXuWR8eqQ/rTBemxIbM
        0yNIn+7AexaI2/Cw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix potential NULL deref
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169814305576.3135.13128124905427948151.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     a71ef31485bb51b846e8db8b3a35e432cc15afb5
Gitweb:        https://git.kernel.org/tip/a71ef31485bb51b846e8db8b3a35e432cc15afb5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 24 Oct 2023 11:42:21 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 24 Oct 2023 12:15:12 +02:00

perf/core: Fix potential NULL deref

Smatch is awesome.

Fixes: 32671e3799ca ("perf: Disallow mis-matched inherited group reads")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d0663b9..a2f2a95 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13372,7 +13372,8 @@ static int inherit_group(struct perf_event *parent_event,
 		    !perf_get_aux_event(child_ctr, leader))
 			return -EINVAL;
 	}
-	leader->group_generation = parent_event->group_generation;
+	if (leader)
+		leader->group_generation = parent_event->group_generation;
 	return 0;
 }
 
