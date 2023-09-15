Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33837A18FC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjIOIgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjIOIgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:36:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9768EE6;
        Fri, 15 Sep 2023 01:36:13 -0700 (PDT)
Date:   Fri, 15 Sep 2023 08:36:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694766972;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XDekMdwupTyWDwCGZoYIpGZOfxAKnogrAKuuYq2O6hs=;
        b=WzXoOA/P88KDxWvHoF+hRKOB/lWu+VNeCE5zugfT5TShgTEQS36yLrWEWLmdxRTgNPJL2Q
        wqeg+7gskf7lw1P90NghGB4cvxFjJluFb/FyyJgMIIPmQ6QuE+Ijo7QrjLJv08JtYSAm1P
        Q1b0lIoQ5T3k2uEig7ODs9sWtJAvcECqhIVoexK8Deo8JgCpCfSqvxfXVDFG+73iPDTiec
        IgMt3qnyysyhWI4CmNvMB3K60UqYQkkbJWu+zM64Cdt+OZnU9enVm4JMdb8T4UpX9+myYy
        oaX04AJiQasH+dl/CpiwvmPK/4xj/pN869m9Uw6vEH4qDf/XGcoPQnNSUS5eEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694766972;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XDekMdwupTyWDwCGZoYIpGZOfxAKnogrAKuuYq2O6hs=;
        b=z6zbHgQBKNDWOPdv/s3pf58SQmDQ3eElerkEIDJfdMukXWuYlqeWnR4PJ3cnOE0sQ3NXzU
        aCNzrSdUCeEc83Aw==
From:   "tip-bot2 for Matthew Wilcox (Oracle)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Assert for_each_thread() is properly locked
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230821134428.2504912-1-willy@infradead.org>
References: <20230821134428.2504912-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID: <169476697114.27769.10512661720392590327.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4de7b17fd05d03fa919e8c47fc66122bd24d7b6c
Gitweb:        https://git.kernel.org/tip/4de7b17fd05d03fa919e8c47fc66122bd24d7b6c
Author:        Matthew Wilcox (Oracle) <willy@infradead.org>
AuthorDate:    Mon, 21 Aug 2023 14:44:28 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Sep 2023 10:33:29 +02:00

sched: Assert for_each_thread() is properly locked

list_for_each_entry_rcu() takes an optional fourth argument which
allows RCU to assert that the correct lock is held.  Several callers
of for_each_thread() rely on their caller to be holding the appropriate
lock, so this is a useful assertion to include.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Link: https://lore.kernel.org/r/20230821134428.2504912-1-willy@infradead.org
---
 include/linux/sched/signal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0014d3a..9610bad 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -656,7 +656,8 @@ extern bool current_is_single_threaded(void);
 	while ((t = next_thread(t)) != g)
 
 #define __for_each_thread(signal, t)	\
-	list_for_each_entry_rcu(t, &(signal)->thread_head, thread_node)
+	list_for_each_entry_rcu(t, &(signal)->thread_head, thread_node, \
+		lockdep_is_held(&tasklist_lock))
 
 #define for_each_thread(p, t)		\
 	__for_each_thread((p)->signal, t)
