Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6B47C68BD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbjJLJAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjJLJAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:00:40 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A58F91
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:00:16 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6c7bbfb7a73so464719a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697101215; x=1697706015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0VwF/DnjzvrQBpX9Fi3ADecurBEx2NpUXKTS2sPKDzc=;
        b=TM9uyuY9ungupFSVt6HqPNVMuXwA1JzreG/hDY8MX7iJWzEbFNgeOTMdr0KeMc7iUu
         01dyTdn3y4gnFN3HjsS6ggwI0i5q2NqnsUM/BMT8lQQLb7NwtaxgfmH/8JwPaKOm7qXS
         D347fQssZWBjxRzp6Cg///iq89yU7uxGzg0aggVnlZi9+O3nuHcDWymCTK38n06CTnge
         AdNXH8oKfVtBDvi3jJ1rF/2ssguUS7FJXDIqrlNvQBqUvCSvdmNlhvhwsNfpFRNYNlO2
         doT3ZlclpsseO0tJRAU3/ET3+B4DDjtIKJGi/zCxxqMTiRsQCbDGv+0mOkHBVY3dmps7
         ZE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697101215; x=1697706015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0VwF/DnjzvrQBpX9Fi3ADecurBEx2NpUXKTS2sPKDzc=;
        b=c95Hk+dbWf6LTz2XJE1bRPHuGQcYPzJ53iVbnrfNlpmj+Mmwf4H5yV9psTs9fUUgF4
         U6h5ylQaVkczT2vlYC+WeawUVP4GDUd+qfAJPuQGWo6z6NTZ9FjrmXCVdlsYsayLffh6
         oHNRttt4mjg6VCvr9HBmaNocobK40brA87VE6Ogs8hckm1BcTCRVYBztj2g7dIRPLlMA
         3/jMk0A2WNHju9MD0c9/pMq1ugoasrcXnC1DOgsKdwyJLRi11PCH5097wX2NoupyX9CR
         QUOPdEjh1yJKqMabTk1rhTXunA0AsEZL0nbrR0fEv+VTYkef6kuzxl5Sf1MMpTv1g4Ze
         PFJA==
X-Gm-Message-State: AOJu0YzY9jkFWmWQ6VQFaf/TnmtN5SuHA/uodtbOjKKbWxRnJAATW+li
        ICEIS1xpOhMFulyxjdN06WYFOQ==
X-Google-Smtp-Source: AGHT+IFTgicovI00vM2IZFMnWUNNWbEtTFiPgvdARarjHQQR7JrMfIy6U8IFQGeL2jKoMGVdxmFkoQ==
X-Received: by 2002:a9d:6b05:0:b0:6c4:cda6:ff3e with SMTP id g5-20020a9d6b05000000b006c4cda6ff3emr23327998otp.18.1697101215449;
        Thu, 12 Oct 2023 02:00:15 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id q25-20020a62e119000000b006933866f49dsm11796595pfh.19.2023.10.12.02.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:00:15 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>,
        stable@vger.kernel.org, Igor Raits <igor.raits@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] sched/core: Fix RQCF_ACT_SKIP leak
Date:   Thu, 12 Oct 2023 17:00:03 +0800
Message-Id: <20231012090003.11450-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Igor Raits and Bagas Sanjaya report a RQCF_ACT_SKIP leak warning.
Link: https://lore.kernel.org/all/a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com

This warning may be triggered in the following situations:

    CPU0                                      CPU1

__schedule()
  *rq->clock_update_flags <<= 1;*   unregister_fair_sched_group()
  pick_next_task_fair+0x4a/0x410      destroy_cfs_bandwidth()
    newidle_balance+0x115/0x3e0       for_each_possible_cpu(i) *i=0*
      rq_unpin_lock(this_rq, rf)      __cfsb_csd_unthrottle()
      raw_spin_rq_unlock(this_rq)
                                      rq_lock(*CPU0_rq*, &rf)
                                      rq_clock_start_loop_update()
                                      rq->clock_update_flags & RQCF_ACT_SKIP <--
      raw_spin_rq_lock(this_rq)

The purpose of RQCF_ACT_SKIP is to skip the update rq clock,
but the update is very early in __schedule(), but we clear
RQCF_*_SKIP very late, causing it to span that gap above
and triggering this warning.

In __schedule() we can clear the RQCF_*_SKIP flag immediately
after update_rq_clock() to avoid this RQCF_ACT_SKIP leak warning.
And set rq->clock_update_flags to RQCF_UPDATED to avoid
rq->clock_update_flags < RQCF_ACT_SKIP warning that may be triggered later.

Fixes: ebb83d84e49b ("sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()")
Cc: stable@vger.kernel.org
Reported-by: Igor Raits <igor.raits@gmail.com>
Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
Closes: https://lore.kernel.org/all/20230913082424.73252-1-jiahao.os@bytedance.com
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 802551e0009b..afb8d213155b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5374,8 +5374,6 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	/* switch_mm_cid() requires the memory barriers above. */
 	switch_mm_cid(rq, prev, next);
 
-	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
-
 	prepare_lock_switch(rq, next, rf);
 
 	/* Here we just switch the register state and the stack. */
@@ -6615,6 +6613,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	/* Promote REQ to ACT */
 	rq->clock_update_flags <<= 1;
 	update_rq_clock(rq);
+	rq->clock_update_flags = RQCF_UPDATED;
 
 	switch_count = &prev->nivcsw;
 
@@ -6694,8 +6693,6 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
-		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
-
 		rq_unpin_lock(rq, &rf);
 		__balance_callbacks(rq);
 		raw_spin_rq_unlock_irq(rq);
-- 
2.39.2

