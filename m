Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5185E76BF3E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjHAVZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjHAVYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:24:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3922359E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+t+cIZqcnxPpRu93TZSyPqI5zhsAiI8Yqy+BlhriBHw=; b=IM3WYqsNA2BbiQtdFADa2gomoD
        qqrejQLUxpaa3PX8lxd6dkq4elfIaAVb/VgsWGSVE2hhf4aL/p6PEV18fehDaFl6cT7d2ZEbNRHyW
        JrhQXBi4Jktho0k0IEW+Y8ZTrBu3UP2Db1TKI2P00+TNAGyN3K5oXBLOXr5CeCJSbcrWv3KOvo665
        cwPgWklfuD8p35guhVqMcNcyqtQ0iWmvxMBiwdez1fFBkELMfv8gM8DK/PKc/Y3tVe5gU95qdK2Tb
        hBiwxSEcc40v8QISM1Lp5siTkIAQZmHqL+XUAnVu9A9p6jukzbGjTn+nOYR9wy1QTwXLe2D4b4aCG
        cv3D41BA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQwqm-00B5yc-2S; Tue, 01 Aug 2023 21:24:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5893F300768;
        Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3A78A202883B0; Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Message-ID: <20230801211811.896559109@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Aug 2023 22:41:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] sched: Simplify sysctl_sched_uclamp_handler()
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
 kernel/sched/core.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1801,7 +1801,8 @@ static int sysctl_sched_uclamp_handler(s
 	int old_min, old_max, old_min_rt;
 	int result;
 
-	mutex_lock(&uclamp_mutex);
+	guard(mutex)(&uclamp_mutex);
+
 	old_min = sysctl_sched_uclamp_util_min;
 	old_max = sysctl_sched_uclamp_util_max;
 	old_min_rt = sysctl_sched_uclamp_util_min_rt_default;
@@ -1810,7 +1811,7 @@ static int sysctl_sched_uclamp_handler(s
 	if (result)
 		goto undo;
 	if (!write)
-		goto done;
+		return 0;
 
 	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
 	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE	||
@@ -1846,16 +1847,12 @@ static int sysctl_sched_uclamp_handler(s
 	 * Otherwise, keep it simple and do just a lazy update at each next
 	 * task enqueue time.
 	 */
-
-	goto done;
+	return 0;
 
 undo:
 	sysctl_sched_uclamp_util_min = old_min;
 	sysctl_sched_uclamp_util_max = old_max;
 	sysctl_sched_uclamp_util_min_rt_default = old_min_rt;
-done:
-	mutex_unlock(&uclamp_mutex);
-
 	return result;
 }
 #endif


