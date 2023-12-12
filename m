Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A944580E04B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjLLAby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjLLAbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:31:51 -0500
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1FED5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:31:54 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-35d74cf427cso20405355ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702341113; x=1702945913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7yqZVth6bKK2qa/zOSItkbz59H3fBeQuCjW6KsND1Y=;
        b=tAzTNwHHk6Hpwdacfqv9Jj4HztcPrpcGpP8TVnWJWhywNLBdYclqClRM+FI7mLAUzQ
         ek7HAZ9PRcHZSf0tfKnARvIEFxZzt9T3cksL0Co2eceXcluFADYxp5nmDunfy4DA+IyH
         yUitL/AghVW7UwEfazmi3GO2jc44enQKz3MObpqXSnbbl1+szZ9/ObXvcQ8uDhU/PejS
         nF2SjkSLKkX40PeNL1ppnr64tgJK93c/n27lTU6Y/e6aCgxd6XbZRTHkXPAn8IsOxo0y
         OY+r+WvGmwy6v/4w0VzhGBKg8Y19Irjod3Gn5peGenL/aiX/AxAxAaMvFnO6s/mzkRDJ
         PFTg==
X-Gm-Message-State: AOJu0YymoeqhcZKI5a7BUUQCf+ElYfChDG/oi3JOtFSOWlXjWNEyv0Wa
        L+nDh65JixrNUKbFLA3ouV4RmeXeLFDG8Oj4
X-Google-Smtp-Source: AGHT+IGoPJ4tO3rq4Solwz4SbFr44ni4nzZTuO0WIC6AH6+rDLXd3PcjIbtRBQwpju8Nl16pgrf94g==
X-Received: by 2002:a92:c564:0:b0:35d:7de6:c388 with SMTP id b4-20020a92c564000000b0035d7de6c388mr6289411ilj.30.1702341113434;
        Mon, 11 Dec 2023 16:31:53 -0800 (PST)
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id by4-20020a056e02260400b0035cb9b85123sm2616670ilb.46.2023.12.11.16.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 16:31:52 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, youssefesmat@google.com, joelaf@google.com,
        roman.gushchin@linux.dev, yu.c.chen@intel.com,
        kprateek.nayak@amd.com, gautham.shenoy@amd.com,
        aboorvad@linux.vnet.ibm.com, wuyun.abel@bytedance.com,
        tj@kernel.org, kernel-team@meta.com
Subject: [PATCH v4 3/8] sched: Tighten unpinned rq lock window in newidle_balance()
Date:   Mon, 11 Dec 2023 18:31:36 -0600
Message-ID: <20231212003141.216236-4-void@manifault.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231212003141.216236-1-void@manifault.com>
References: <20231212003141.216236-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In newidle_balance(), we may drop and reacquire the rq lock in the
load-balance phase of the function. We currently do this before we check
rq->rd->overload or rq->avg_idle, which is unnecessary. Let's tighten
the window where we call rq_unpin_lock().

Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/fair.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcea3d55d95d..e1b676bb1fed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12296,14 +12296,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (!cpu_active(this_cpu))
 		return 0;
 
-	/*
-	 * This is OK, because current is on_cpu, which avoids it being picked
-	 * for load-balance and preemption/IRQs are still disabled avoiding
-	 * further scheduler activity on it and we're being very careful to
-	 * re-start the picking loop.
-	 */
-	rq_unpin_lock(this_rq, rf);
-
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
 
@@ -12318,6 +12310,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	}
 	rcu_read_unlock();
 
+	/*
+	 * This is OK, because current is on_cpu, which avoids it being picked
+	 * for load-balance and preemption/IRQs are still disabled avoiding
+	 * further scheduler activity on it and we're being very careful to
+	 * re-start the picking loop.
+	 */
+	rq_unpin_lock(this_rq, rf);
 	raw_spin_rq_unlock(this_rq);
 
 	t0 = sched_clock_cpu(this_cpu);
@@ -12358,6 +12357,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	rcu_read_unlock();
 
 	raw_spin_rq_lock(this_rq);
+	rq_repin_lock(this_rq, rf);
 
 	if (curr_cost > this_rq->max_idle_balance_cost)
 		this_rq->max_idle_balance_cost = curr_cost;
@@ -12384,8 +12384,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	else
 		nohz_newidle_balance(this_rq);
 
-	rq_repin_lock(this_rq, rf);
-
 	return pulled_task;
 }
 
-- 
2.42.1

