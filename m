Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55177FDAD1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjK2PIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbjK2Ozk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:55:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2045310DF;
        Wed, 29 Nov 2023 06:55:45 -0800 (PST)
Date:   Wed, 29 Nov 2023 14:55:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701269743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7fdg9HsOCuKA61WgZU0Q3a150uw7ZsSmWZm77p0STY=;
        b=3VS2nUxhbvX0YkzobvkabVg1G3ZXYUUY0jsOHrr1xGUq925nsPWUfxr+Pe+Uj1OA9ECpMP
        YK24kCIQjXaT3FOwFPZAcWo4rIrJKB+ScNMprL93VsHStttXFHe7YUtUAFvMt2VkGDXg0S
        hzvJitaCLYKZmqlm08WTE4ExFf0jnPbapHlxhBoslbH3bfn/7leN4hLCLxkkmovPyUVUGa
        XE1CFmGKsNk1np+UC4Zt7ktOv2uUf4Hm/pfMQGg/ZrrL+WC10uF/8N58NRSMLqsbH8WJzd
        VGI7eRuYv+6/HLQE4wnkFSbo/UQ9SyXJtZANpLFUpfof+q3T2jQEYf1NF4iNRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701269743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7fdg9HsOCuKA61WgZU0Q3a150uw7ZsSmWZm77p0STY=;
        b=Fp0sg0f3pICor0IYtjwps1teD4BvPlL6tKD7Z/lZmK7hU5NZggyIUwRj6UC3jpDt4XhAZY
        TnGK6OytYQMq14DA==
From:   "tip-bot2 for Elliot Berman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] freezer,sched: Do not restore saved_state of a
 thawed task
Cc:     Elliot Berman <quic_eberman@quicinc.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Abhijeet Dharmapurikar <quic_adharmap@quicinc.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231120-freezer-state-multiple-thaws-v1-1-f2e1dd7ce5a2@quicinc.com>
References: <20231120-freezer-state-multiple-thaws-v1-1-f2e1dd7ce5a2@quicinc.com>
MIME-Version: 1.0
Message-ID: <170126974302.398.5668977195119638525.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     23ab79e8e469e2605beec2e3ccb40d19c68dd2e0
Gitweb:        https://git.kernel.org/tip/23ab79e8e469e2605beec2e3ccb40d19c68dd2e0
Author:        Elliot Berman <quic_eberman@quicinc.com>
AuthorDate:    Mon, 20 Nov 2023 09:36:31 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Nov 2023 15:43:48 +01:00

freezer,sched: Do not restore saved_state of a thawed task

It is possible for a task to be thawed multiple times when mixing the
*legacy* cgroup freezer and system-wide freezer. To do this, freeze the
cgroup, do system-wide freeze/thaw, then thaw the cgroup. When this
happens, then a stale saved_state can be written to the task's state
and cause task to hang indefinitely. Fix this by only trying to thaw
tasks that are actually frozen.

This change also has the marginal benefit avoiding unnecessary
wake_up_state(p, TASK_FROZEN) if we know the task is already thawed.
There is not possibility of time-of-compare/time-of-use race when we skip
the wake_up_state because entering/exiting TASK_FROZEN is guarded by
freezer_lock.

Fixes: 8f0eed4a78a8 ("freezer,sched: Use saved_state to reduce some spurious wakeups")
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Abhijeet Dharmapurikar <quic_adharmap@quicinc.com>
Link: https://lore.kernel.org/r/20231120-freezer-state-multiple-thaws-v1-1-f2e1dd7ce5a2@quicinc.com
---
 kernel/freezer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index c450fa8..759006a 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -201,7 +201,7 @@ void __thaw_task(struct task_struct *p)
 	if (WARN_ON_ONCE(freezing(p)))
 		goto unlock;
 
-	if (task_call_func(p, __restore_freezer_state, NULL))
+	if (!frozen(p) || task_call_func(p, __restore_freezer_state, NULL))
 		goto unlock;
 
 	wake_up_state(p, TASK_FROZEN);
