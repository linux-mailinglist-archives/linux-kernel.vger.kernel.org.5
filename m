Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F177BD876
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345666AbjJIK0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjJIK0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:26:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCCD99;
        Mon,  9 Oct 2023 03:26:13 -0700 (PDT)
Date:   Mon, 09 Oct 2023 10:26:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696847171;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7S8iBamwoqMF5Q9aR2B8Rdv3kLt9b/VFv73v1vNci9o=;
        b=Vg6xIS9yv82xscmF6w5RYwOXqwAIbTPmzAo4E7w+qqGtzRPqhUvM+vAX1B6kYWXjpZtoJr
        yHqaBeSuGct2OmbZWh7nSigdC7r3/CXokEVrGRage4MMON3zP1caNH1pnuCH0B9okZIfQ/
        lAw5dH977gtCeGi/OlrBP06tGtvQ3LhAUJfq8KY2NhVJespYQ2AA5OUyl7cM8HNvbPav4Q
        SUxKbUzuN9xmqVqFhv9VssRoP+Yz5UCL/Y6c1vSSRBrohfpq3VY8HxD+KOsRWW5lGfaV2P
        QreBUZrjQMW3AsiPH+RzNKRWJO7GwEtpLGRnJEtKTpHjv3wcdJcyVwSjJhG/NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696847171;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7S8iBamwoqMF5Q9aR2B8Rdv3kLt9b/VFv73v1vNci9o=;
        b=94D0NONb2e5OPtYjYweONyCe++FkjZpdwhVhTt/kMqpINJZyu5YZQKch5w3DaXD92l+3Ld
        IrKamuUl6dhheZDQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/nohz: Remove unnecessarily complex error
 handling pattern from find_new_ilb()
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231006102518.2452758-4-mingo@kernel.org>
References: <20231006102518.2452758-4-mingo@kernel.org>
MIME-Version: 1.0
Message-ID: <169684717032.3135.17626767741431018350.tip-bot2@tip-bot2>
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

Commit-ID:     f4bb5705114530cd775a5a649b666755b3efe7aa
Gitweb:        https://git.kernel.org/tip/f4bb5705114530cd775a5a649b666755b3efe7aa
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 06 Oct 2023 12:25:18 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Oct 2023 12:21:23 +02:00

sched/nohz: Remove unnecessarily complex error handling pattern from find_new_ilb()

find_new_ilb() returns nr_cpu_ids on failure - which is the usual
cpumask bitops return pattern, but is weird & unnecessary in this
context: not only is it a global variable, it it is a +1 out of
bounds CPU index and also has different signedness ...

Its only user, kick_ilb(), then checks the return against nr_cpu_ids
to decide to return. There's no other use.

So instead of this, use a standard -1 return on failure to find an
idle CPU, as the argument is signed already.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Link: https://lore.kernel.org/r/20231006102518.2452758-4-mingo@kernel.org
---
 kernel/sched/fair.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f82b301..19bb4ac 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11528,7 +11528,7 @@ static inline int find_new_ilb(void)
 			return ilb_cpu;
 	}
 
-	return nr_cpu_ids;
+	return -1;
 }
 
 /*
@@ -11549,8 +11549,7 @@ static void kick_ilb(unsigned int flags)
 		nohz.next_balance = jiffies+1;
 
 	ilb_cpu = find_new_ilb();
-
-	if (ilb_cpu >= nr_cpu_ids)
+	if (ilb_cpu < 0)
 		return;
 
 	/*
