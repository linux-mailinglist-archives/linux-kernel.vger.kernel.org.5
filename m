Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D21782690
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjHUJuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjHUJuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:50:19 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A3891
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:49:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a3cae6d94so1112104b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692611393; x=1693216193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5u5p5wIzjh+fwvbAxDjD9qzdk82gCEiNMT6dRCalpmo=;
        b=iqQKGdhowNm+m3nxKNhBqwv4PjjDPJ13hbjWWeK6YnED7ABf6tFB6qrjAdXqT7ymnV
         GZy5WIuEC8QGd/m3iMo5OSRAe59Ubg6CKf6eHudB8ADK/IJYkR/d9RvdKEAOv7ohLAxV
         0wq5XT79HGH8Xb2w7QGmDkZGtRmDE1Q4DfVQz8AJ2bxiI0180VgcacOjL6a9Ud/2uJAC
         pbfN6B8RtAN1tMdRxsf3rXpfTK7Q/hUy/1wcJP1KNtThnx3tLIKkIK6tFdnjDnXl9Tuw
         puCBUX3PT6NYnxiQD04Uj/fmiksErrwIttcJ9LlpMQwWhddNu9CsBffzD4ntU1RanWcw
         ObSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692611393; x=1693216193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5u5p5wIzjh+fwvbAxDjD9qzdk82gCEiNMT6dRCalpmo=;
        b=BUt8fL8DF9ImXYbzJqQuqQnLc0usxE6RHJloUuP997OrWg5BoJbEUxmZhNhQtmjHxn
         6caMLpXU2E5OSQUlVw2iOzkt4MjeHKJFssHJCs8QPdb3AMpjRt1RZLNfX9kCGkrwbH48
         vT6eyhVrvsA2DvZ7m52bmHgh3FSK+9qkaxKcBsie43b0RGk97Bgqe+eXsUYwSnntUxQL
         Z0xmmQkKAjVDBEtGLisToWnC/fZtimGh4Gj23G2H9x1MUaU1QLiBxQT634/ROVKhQrPW
         OIRDfh1xIc8GdLlgXCJ1Z3uBcUlKvzh0mgtq4acjwdCrm02tehaZjWufNC5gsXt60Myx
         odGw==
X-Gm-Message-State: AOJu0YyN/eXXJ2vmzedVAl/W7oo1Istq+OZn9bV2meNx93iNdAnRfja9
        WJMvvJ0XRw/NA4qzbpzPwzoRfg==
X-Google-Smtp-Source: AGHT+IGKC7Q9/zMXJ1zL4wYqI5Mjp/KI3sl9NQzbzB5bObhS6PTxk5kZ/vDNV25XjPXG9WU8vxBDCA==
X-Received: by 2002:a05:6a20:d410:b0:13f:52f1:fe67 with SMTP id il16-20020a056a20d41000b0013f52f1fe67mr6611056pzb.23.1692611393559;
        Mon, 21 Aug 2023 02:49:53 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id x9-20020a056a00270900b0068a4cd8b530sm1674892pfv.139.2023.08.21.02.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 02:49:53 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        pauld@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH 2/2] sched/rt: Block nohz tick_stop when rt bandwidth in use
Date:   Mon, 21 Aug 2023 17:49:27 +0800
Message-Id: <20230821094927.51079-3-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230821094927.51079-1-jiahao.os@bytedance.com>
References: <20230821094927.51079-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop
when cfs bandwidth in use") has been merged. It can handle
conflicts between NOHZ full and cfs_bandwidth, and the
scheduler feature HZ_BW allows us to choose which one to prefer.

This problem also exists between NOHZ full and rt_bandwidth.
Now when there is only one RR task or only FIFO tasks on
the NOHZ full cpu, NOHZ full will stop tick even though
those tasks are constrained by rt_bandwidth. This makes It
very easy for RT tasks to run longer than the rt_bandwidth
runtime limit. This may cause rt bandwidth limit not timely
and CFS task starvation for a long time.

Similar to the commit above, we also add a check in
pick_next_task_rt(), which updates the tick dependency
status according to whether the task to be run is
constrained by rt_bandwidth.

Add check in sched_can_stop_tick() to cover some
edge cases such as rq nr_running going from 2->1 without
going through pick_next_task_rt() and the 1 remains
the running RT task.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/rt.c | 61 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0b9e9467ef61..f55ce6935a80 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1741,7 +1741,31 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 }
 
 #ifdef CONFIG_NO_HZ_FULL
-static bool can_stop_tick_rt(struct rq *rq, int *stop_next)
+/*
+ * If the scheduler feature HZ_BW is enabled, we need to further
+ * check whether task @p is constrained by RT bandwidth to decide
+ * whether to stop tick.
+ */
+static inline bool rt_task_bw_constrained(struct task_struct *p)
+{
+	struct rt_rq *rt_rq;
+
+	if (!sched_feat(HZ_BW))
+		return false;
+
+	if (rt_bandwidth_enabled())
+		return true;
+
+	if (p->sched_class == &rt_sched_class && task_on_rq_queued(p)) {
+		rt_rq = rt_rq_of_se(&p->rt);
+		if (sched_rt_runtime(rt_rq) != RUNTIME_INF)
+			return true;
+	}
+
+	return false;
+}
+
+static bool __can_stop_tick_rt(struct rq *rq, struct task_struct *p, int *stop_next)
 {
 	int fifo_nr_running;
 
@@ -1751,7 +1775,7 @@ static bool can_stop_tick_rt(struct rq *rq, int *stop_next)
 	 */
 	if (rq->rt.rr_nr_running) {
 		*stop_next = 1;
-		if (rq->rt.rr_nr_running == 1)
+		if (rq->rt.rr_nr_running == 1 && !rt_task_bw_constrained(p))
 			return true;
 		else
 			return false;
@@ -1764,11 +1788,38 @@ static bool can_stop_tick_rt(struct rq *rq, int *stop_next)
 	fifo_nr_running = rq->rt.rt_nr_running - rq->rt.rr_nr_running;
 	if (fifo_nr_running) {
 		*stop_next = 1;
-		return true;
+		if (!rt_task_bw_constrained(p))
+			return true;
+		else
+			return false;
 	}
 
 	return true;
 }
+
+static bool can_stop_tick_rt(struct rq *rq, int *stop_next)
+{
+	bool ret;
+
+	ret = __can_stop_tick_rt(rq, rq->curr, stop_next);
+	if (stop_next)
+		return ret;
+
+	return true;
+}
+static void sched_rt_update_stop_tick(struct rq *rq, struct task_struct *p)
+{
+	int cpu = cpu_of(rq);
+	int unused;
+
+	if (!sched_feat(HZ_BW) || !tick_nohz_full_cpu(cpu))
+		return;
+
+	if (!__can_stop_tick_rt(rq, p, &unused))
+		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
+}
+#else /* CONFIG_NO_HZ_FULL */
+static inline void sched_rt_update_stop_tick(struct rq *rq, struct task_struct *p) {}
 #endif
 
 static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
@@ -1846,8 +1897,10 @@ static struct task_struct *pick_next_task_rt(struct rq *rq)
 {
 	struct task_struct *p = pick_task_rt(rq);
 
-	if (p)
+	if (p) {
+		sched_rt_update_stop_tick(rq, p);
 		set_next_task_rt(rq, p, true);
+	}
 
 	return p;
 }
-- 
2.39.2

