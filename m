Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D55876CEC0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbjHBNbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbjHBNbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:31:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97402269A;
        Wed,  2 Aug 2023 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=eQsShqCZQhSRZELiV+wvARE7XUysNmI7Pn/FkVFS3UY=; b=CoKaaQvwg2eF7NA5/aiaXSbUSO
        NKjRN2+A9m+yrIzlnelbVshYusq0wWHEJjIfqOmc2tEHNYIyC3pFm+zlhPbFKFi5aDDI6j5bNAYHl
        Xo6lGXsqowLKdsPT9y0eWuX9IwL3ppBs+zRNi5rpFJDe9+ZmJftsDpEHfLyaL8tUvu84bDkoWshP2
        cFxLMrucsBCZWPIBecpJM7evZxCMfgK2ivTEQo5eFLWUAnviBmdijWpZZzw3iTKIlJ6CM/eSQ1GiF
        4InJSRVopZBFp8pMJPyCZDxdhm9KupCLJIcqPpAz3K+V8uzGQBXu1J5kCVMS135vXTCrH0Hwim2tC
        OALx8RAA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRBwZ-00Fxf9-1s;
        Wed, 02 Aug 2023 13:31:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1942E300768;
        Wed,  2 Aug 2023 15:31:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 00BDA2107D7E7; Wed,  2 Aug 2023 15:31:14 +0200 (CEST)
Message-ID: <20230802132925.686745535@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Aug 2023 15:24:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     anna-maria@linutronix.de, rafael@kernel.org, tglx@linutronix.de,
        frederic@kernel.org, gautham.shenoy@amd.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, kajetan.puchalski@arm.com
Subject: [RFC][PATCH v2 3/5] cpuidle/teo: Simplify a little
References: <20230802132431.254614419@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some of the early exit cases that rely on state_count, since we
have the additional tick state. Declutters some of the next patches, can
possibly be re-instated later if desired.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/cpuidle/governors/teo.c |   31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -187,7 +187,6 @@ struct teo_bin {
  * @next_recent_idx: Index of the next @recent_idx entry to update.
  * @recent_idx: Indices of bins corresponding to recent "intercepts".
  * @util_threshold: Threshold above which the CPU is considered utilized
- * @utilized: Whether the last sleep on the CPU happened while utilized
  */
 struct teo_cpu {
 	s64 time_span_ns;
@@ -197,7 +196,6 @@ struct teo_cpu {
 	int next_recent_idx;
 	int recent_idx[NR_RECENT];
 	unsigned long util_threshold;
-	bool utilized;
 };
 
 static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
@@ -379,33 +377,6 @@ static int teo_select(struct cpuidle_dri
 	duration_ns = tick_nohz_get_sleep_length(&delta_tick);
 	cpu_data->sleep_length_ns = duration_ns;
 
-	/* Check if there is any choice in the first place. */
-	if (drv->state_count < 2) {
-		idx = 0;
-		goto end;
-	}
-	if (!dev->states_usage[0].disable) {
-		idx = 0;
-		if (drv->states[1].target_residency_ns > duration_ns)
-			goto end;
-	}
-
-	cpu_data->utilized = teo_cpu_is_utilized(dev->cpu, cpu_data);
-	/*
-	 * If the CPU is being utilized over the threshold and there are only 2
-	 * states to choose from, the metrics need not be considered, so choose
-	 * the shallowest non-polling state and exit.
-	 */
-	if (drv->state_count < 3 && cpu_data->utilized) {
-		for (i = 0; i < drv->state_count; ++i) {
-			if (!dev->states_usage[i].disable &&
-			    !(drv->states[i].flags & CPUIDLE_FLAG_POLLING)) {
-				idx = i;
-				goto end;
-			}
-		}
-	}
-
 	/*
 	 * Find the deepest idle state whose target residency does not exceed
 	 * the current sleep length and the deepest idle state not deeper than
@@ -541,7 +512,7 @@ static int teo_select(struct cpuidle_dri
 	 * If the CPU is being utilized over the threshold, choose a shallower
 	 * non-polling state to improve latency
 	 */
-	if (cpu_data->utilized)
+	if (teo_cpu_is_utilized(dev->cpu, cpu_data))
 		idx = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
 
 end:


