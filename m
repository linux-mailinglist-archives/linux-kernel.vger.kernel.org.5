Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2835A76CEC1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjHBNbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbjHBNbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:31:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86302698;
        Wed,  2 Aug 2023 06:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=FEv2iT5iG0jeFDcJt9mW5bYGJa6fvQIcftXsRiIKsDM=; b=OJeHWtCn/qCA8UDeTUprU4JcoE
        77B5rES8YJQG+Q34u94zXR/7WTH2Or1bRj2FBQDgfqyoVbbhzgSlM58+STeDCDdBKRDhygd1kseue
        CZmWUYiCbUxqCXDdVvTAD+m4In1W14yavTbJ/LOI8YuWgbV6XlFA0xDIfjfKpZ3Dxdtv19mss6loJ
        rRfiEacR0MiXzF5PPxbZcZ6dd8IHuh8Wz8s6n8CA2TXE3+BorgkSgKhIEEyOEO3leo4VBS6/hKCJ+
        9PGvGM7SgNwVSXAGA3lcMmmvP64s3JDMdBMzXPLpXRggMhrWL8KyTOyuHAUGThBTh0GonGYJgAuwO
        DjZ5gJrw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRBwa-00FBnY-5G; Wed, 02 Aug 2023 13:31:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 56827300DCF;
        Wed,  2 Aug 2023 15:31:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0788F2107D7EA; Wed,  2 Aug 2023 15:31:15 +0200 (CEST)
Message-ID: <20230802132925.824393002@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Aug 2023 15:24:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     anna-maria@linutronix.de, rafael@kernel.org, tglx@linutronix.de,
        frederic@kernel.org, gautham.shenoy@amd.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, kajetan.puchalski@arm.com
Subject: [RFC][PATCH v2 5/5] cpuidle,teo: Improve state selection
References: <20230802132431.254614419@infradead.org>
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

When selecting a state, stop when history tells us 66% of recent idles
were at or below our current state.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/cpuidle/governors/teo.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -361,6 +361,7 @@ static int teo_select(struct cpuidle_dri
 	unsigned int recent_sum = 0;
 	unsigned int idx_hit_sum = 0;
 	unsigned int hit_sum = 0;
+	unsigned int thresh_sum = 0;
 	int constraint_idx = 0;
 	int idx0 = 0, idx = -1;
 	bool alt_intercepts, alt_recent;
@@ -376,6 +377,8 @@ static int teo_select(struct cpuidle_dri
 
 	duration_ns = tick_ns = tick_get_sleep_length(false);
 
+	thresh_sum = 2 * cpu_data->total / 3; /* 66% */
+
 	/*
 	 * Find the deepest idle state whose target residency does not exceed
 	 * the current sleep length and the deepest idle state not deeper than
@@ -406,6 +409,9 @@ static int teo_select(struct cpuidle_dri
 		if (s->target_residency_ns > duration_ns)
 			break;
 
+		if (intercept_sum + hit_sum > thresh_sum)
+			break;
+
 		if (s->target_residency_ns == SHORT_TICK_NSEC) {
 			/*
 			 * We hit the tick state, see if it makes sense to


