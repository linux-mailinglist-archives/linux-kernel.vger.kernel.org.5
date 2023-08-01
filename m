Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA95676BF42
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjHAVZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjHAVY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:24:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062492708
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2Fw/6pc13hFz4431UNCf/XS3M9fAIWcYfqPnXE09Ku4=; b=jf7h3twPdz2DT1GCwfUgdsHWvl
        6gJ6KV5WtDzaSrLPLVmGcSsNI/aPU6YuG/xgdRcISp/8cdMuxLDYSSOACzvce0Xin0ei5eurCCVW6
        pKhIniOu3a6lY3JXgczXG8BA4bNwQ7ibysONv7Fklk9bZ4pMTaX6+Jhxsn/5ua9oyqgzxNHtotBA2
        m+Rej9y/VI678MskQgPdCshVY4X6Qmnwpqj76M6A/AW1o7OgItWsLTAKeedBx6E19GFALEo58HwfS
        6ZyZ0DSbdXMfYqFv4nb7aPil+r8I1F8t7OlD0qIUnWQHwn4lbg194c89YhUGFLlx1PCBGeyPtrqCd
        QdZAOqSg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQwqm-00B5yX-0o; Tue, 01 Aug 2023 21:24:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 569F43002D3;
        Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 389C52028A2D8; Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Message-ID: <20230801211811.828443100@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Aug 2023 22:41:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] sched: Simplify get_nohz_timer_target()
References: <20230801204121.929256934@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

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


