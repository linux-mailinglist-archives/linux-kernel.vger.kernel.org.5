Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1FE7D062E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346828AbjJTBkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346805AbjJTBkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:40:46 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB347124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:40:44 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3574cde48b4so1066595ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1697766044; x=1698370844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0pwSa2GbXJihOZrNu7aMcnrt6aomdhOt1W1hRoVbr8=;
        b=N44iB+AmDtzIIgLBjpm32TTYi98/zApjmjJ1fnQPghi2nhfvDY8fJqkFIMsg2+ukGu
         pg/OlKXxJlIg9T9ys70LiFam6r7U+LUiS/9irMfmvHS9XRsKaIQWY2ysuMCgGzSJ/VGv
         h+TG+s8yfyMKNkXAC/6cCnfY9gGFxdiD1vUa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697766044; x=1698370844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0pwSa2GbXJihOZrNu7aMcnrt6aomdhOt1W1hRoVbr8=;
        b=ONOFXLSR4mtBa0sYKumbyqiEIDNAT3IilqL0Rv/qNVjuwCGHTBTt9N3gncQFGTD1a4
         XSfAYRbXzTaZNBoyiRgZ9ISA7xGQCmTivuLUX1Bw9BEuVrO6mPpKjvQu82egCYAN7Q9i
         AgXQnyX7G8NcpaYjDWJVYK0TrisqSYUjL0mLJVVXBFSxXqtLNO0W6yT9U2mlJauIskgx
         t+F9EKOLPskxCYBTbxajjATHIonro2vc6IvvQW3vwV3x3ULjcVA72EkWFrOh6uN24v2v
         m2kh814ulLbQASF8GUaP8CMbRulzvPCLVdjMi/2DzcYaJS2yKhtTXA2jY99nTSesxJG9
         iBOw==
X-Gm-Message-State: AOJu0Yzc8D8ODGlX9YANZMxZMbtI4Uvp1KEX4nKKatbDG0wRWvjyGz1b
        YoHa8lWjUAb+JbEYmN+LOclMNqgTFt8yiomefAPFnA==
X-Google-Smtp-Source: AGHT+IEbjO8xFNME7aragcQ5plTxHyQwlDYPbxPXL6etAIv8PmIGBNNwr5fNyZKGj4poZA7mTjr1Cg==
X-Received: by 2002:a05:6e02:214b:b0:34d:e998:fb4f with SMTP id d11-20020a056e02214b00b0034de998fb4fmr850150ilv.10.1697766043833;
        Thu, 19 Oct 2023 18:40:43 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id h9-20020a056e020d4900b00350f5584876sm270394ilj.27.2023.10.19.18.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 18:40:43 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 3/3] sched: Update ->next_balance correctly during newidle balance
Date:   Fri, 20 Oct 2023 01:40:28 +0000
Message-ID: <20231020014031.919742-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231020014031.919742-1-joel@joelfernandes.org>
References: <20231020014031.919742-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>

When newidle balancing triggers, we see that it constantly clobbers
rq->next_balance even when there is no newidle balance happening due to
the cost estimates.  Due to this, we see that periodic load balance
(rebalance_domains) may trigger way more often when the CPU is going in
and out of idle at a high rate but is no really idle. Repeatedly
triggering load balance there is a bad idea as it is a heavy operation.
It also causes increases in softirq.

Another issue is ->last_balance is not updated after newidle balance
causing mistakes in the ->next_balance calculations.

Fix by updating last_balance when a newidle load balance actually
happens and then updating next_balance. This is also how it is done in
other load balance paths.

Testing shows a significant drop in softirqs when running:
cyclictest -i 100 -d 100 --latency=1000 -D 5 -t -m  -q

Goes from ~6k to ~800.

Cc: Suleiman Souhlal <suleiman@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/fair.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8e276d12c3cb..b147ad09126a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12076,11 +12076,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	if (!READ_ONCE(this_rq->rd->overload) ||
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
-
-		if (sd)
-			update_next_balance(sd, &next_balance);
 		rcu_read_unlock();
-
 		goto out;
 	}
 	rcu_read_unlock();
@@ -12095,8 +12091,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		int continue_balancing = 1;
 		u64 domain_cost;
 
-		update_next_balance(sd, &next_balance);
-
 		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
 			break;
 
@@ -12109,6 +12103,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 			t1 = sched_clock_cpu(this_cpu);
 			domain_cost = t1 - t0;
 			update_newidle_cost(sd, domain_cost);
+			sd->last_balance = jiffies;
+			update_next_balance(sd, &next_balance);
 
 			curr_cost += domain_cost;
 			t0 = t1;
-- 
2.42.0.655.g421f12c284-goog

