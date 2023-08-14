Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CF577BC7C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjHNPId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjHNPIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:08:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDAA1701;
        Mon, 14 Aug 2023 08:08:09 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:08:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692025687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TtHT+J68I3rRJzRfHqk10FJonfgbAJ03Mdzrif1b1mU=;
        b=BltpUni2c9NXtlxUmSn/rU5QLNmNCkCQ+95EzRLKLBxLZqXGR0nO+j/Vt89bgi/KAiAGeI
        ReCncP2ZJtf5FySBPFmEgwYibwR7QKpFtdnqXHWS31ViJY5Lz7Pu2mTU6XHW51VJ8K7R7k
        sAAMqxlvmxl/iHWyuMi+MFyWFHYub1rSUtHYp3OoXMA960h02wIMMbQoIAKbXHP+oaVtzT
        t8j9wJY97xobW0YcTO2909r13XrERwfZRYCOZiae/9TFiVpdufDSVUIqST2Dhe+CoID0jN
        zNcO+qGgkUXkHAEM6rR9pP5o+2I3p2tSIMWhQyWfAlJ10NGE8JUen7oc1gTaTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692025687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TtHT+J68I3rRJzRfHqk10FJonfgbAJ03Mdzrif1b1mU=;
        b=rhCZn1Q39812hLfPld+vRtxYLmkpjGjuEyVfm5EogcT5fYUR1sxSLgyJl/YfIFFcOivAR2
        0N71+Jcf71J5h4DQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify get_nohz_timer_target()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230801211811.828443100@infradead.org>
References: <20230801211811.828443100@infradead.org>
MIME-Version: 1.0
Message-ID: <169202568709.27769.1200732913266854235.tip-bot2@tip-bot2>
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

Commit-ID:     7537b90c0036759e0b1b43dfbc6224dc5e900b13
Gitweb:        https://git.kernel.org/tip/7537b90c0036759e0b1b43dfbc6224dc5e900b13
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 01 Aug 2023 22:41:22 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Aug 2023 17:01:24 +02:00

sched: Simplify get_nohz_timer_target()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20230801211811.828443100@infradead.org
---
 kernel/sched/core.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a97eab3..6cda296 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1097,25 +1097,22 @@ int get_nohz_timer_target(void)
 
 	hk_mask = housekeeping_cpumask(HK_TYPE_TIMER);
 
-	rcu_read_lock();
+	guard(rcu)();
+
 	for_each_domain(cpu, sd) {
 		for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
 			if (cpu == i)
 				continue;
 
-			if (!idle_cpu(i)) {
-				cpu = i;
-				goto unlock;
-			}
+			if (!idle_cpu(i))
+				return i;
 		}
 	}
 
 	if (default_cpu == -1)
 		default_cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
-	cpu = default_cpu;
-unlock:
-	rcu_read_unlock();
-	return cpu;
+
+	return default_cpu;
 }
 
 /*
