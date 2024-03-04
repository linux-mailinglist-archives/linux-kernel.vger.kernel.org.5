Return-Path: <linux-kernel+bounces-90354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6946586FDFE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2BD1C20DB6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3323986D;
	Mon,  4 Mar 2024 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOL1eoRB"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BE93839F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545735; cv=none; b=BE7D6Raad1ajVTJ8BK8ctO68xRaDEwkZFgtYZ2tGunM0o94mc3KOCW9OC9giKXyMSR7gRWP4BpiL2yFwzTZW8imTUDh95X0/R+TmDJFjEylRme3spgSpdlda8WcXgkrDJ5APWmT9kYwqzsAPCscMOQc+5iyh9xTT93c0QAHGfzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545735; c=relaxed/simple;
	bh=vdGrZwaI/Ookkfx04vBorgAmg1RU8pL6JYSXfdzQ9PY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDS5yVtvuUXj70p6fRLPx+vOElRCTcu1Cd4Htbx3M9cP2LXTSRtnUD2PPIIJbrFHUNmWw37TsObY/DuruxCpg75JiBEIrV0AmOLTvFYIWytrj2eY4g0+ANeA5xputcGG+hL9xZnA00GyeJ/pe80qJiIjoAzmsyJtfbU4m0WmVLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOL1eoRB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a28a6cef709so689876766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709545732; x=1710150532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaJ13RYdVXWmZbDkVn4tVEtiI++AgEDK8GYib1p9JJ0=;
        b=gOL1eoRBVB2dUVJHDflLCwkLxEXuc0M+wNx0qTrFP5kx6eyHI66SOj9fw1D9AGknAR
         tKz/GKOmQuFpccgXUbRAsXQ7baqKpyOylLQXPmtz8hv1n/RKQGBhqv1mHdh1IZ42iIJX
         qHcS+nFyYAgViyI1v8hA/Pdqt0YKaIhu31VTbtf3FKuJGMows5bDTQAeagEa9OnoXYbn
         qyiaOaG3WrRP9fbqwHVSp7k5xC+RWJyA49o5VYKkFRsvwppD9WUZt5jGXoXU6BuGsAI2
         695NDOPPOcNMzmLhj/lxpaaI2CCneQ95OhQSxRaomXpVcuscNrcX1BiatwbNM2bs29bf
         ZBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709545732; x=1710150532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eaJ13RYdVXWmZbDkVn4tVEtiI++AgEDK8GYib1p9JJ0=;
        b=htubOOkW/SxVu4cN+wHmcoItNWCj1+tow/1nEJ1XlVvz7KxpAkxgzACo6fiGKLpKrY
         4SjygF63bDLuFN3Gh5UohZ6RFKU2LkmIB6K6e2dGvA0Ac5GTjH/k2dfFV/chNvDgGax3
         MrH4R2qTOkaoEJif/HGboDCEhb/w/MwT7Po+lA8/QWdjrNFGz7vDnPDxeYHLRyyL3Ti5
         v0B5PS4KGFUPzn7rtJS0loD+1f1eJZPkfbRfFN7AWYl7pWY6lgneYLtvuPqeNjX5AztU
         gNXTy3pwnzf0W+soS3hmI6IHXe14/ucK/iyBVyXJpB26GfCdKLFbMrdKuKdskiPYruYD
         xIrQ==
X-Gm-Message-State: AOJu0YypeAy36Tg1dhtIrmcdxJvsaQ7hv1GBpSmvmrAg56HOmLRQs9ae
	L3wVsi1sKAfa6FXlt+XRPdktbE9KOyaBSAlIaft+zKSePEIYpoAVIsjEKeRLWFQ=
X-Google-Smtp-Source: AGHT+IH6YqqEJKxD+XyOyFPhadLbYTSOXX1KeuXfpxyOUnOXhPuYTKnbKZYpveSWNXLdWl+VNgHj7w==
X-Received: by 2002:a17:906:48c6:b0:a45:2038:4caa with SMTP id d6-20020a17090648c600b00a4520384caamr2023252ejt.76.1709545732374;
        Mon, 04 Mar 2024 01:48:52 -0800 (PST)
Received: from kepler.redhat.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id s22-20020a170906501600b00a42e2bc82dbsm4569839ejj.169.2024.03.04.01.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:48:51 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 9/9] sched/balancing: Rename run_rebalance_domains() => sched_balance_softirq()
Date: Mon,  4 Mar 2024 10:48:31 +0100
Message-Id: <20240304094831.3639338-10-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240304094831.3639338-1-mingo@kernel.org>
References: <20240304094831.3639338-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

run_rebalance_domains() is a misnomer, as it doesn't only
run rebalance_domains(), but since the introduction of the
NOHZ code it also runs nohz_idle_balance().

Rename it to sched_balance_softirq(), reflecting its more
generic purpose and that it's a softirq handler.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 Documentation/scheduler/sched-domains.rst                    | 2 +-
 Documentation/translations/zh_CN/scheduler/sched-domains.rst | 2 +-
 kernel/sched/fair.c                                          | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
index e57ad28301bd..6577b068f921 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -34,7 +34,7 @@ out of balance are tasks moved between groups.
 In kernel/sched/core.c, trigger_load_balance() is run periodically on each CPU
 through scheduler_tick(). It raises a softirq after the next regularly scheduled
 rebalancing event for the current runqueue has arrived. The actual load
-balancing workhorse, run_rebalance_domains()->rebalance_domains(), is then run
+balancing workhorse, sched_balance_softirq()->rebalance_domains(), is then run
 in softirq context (SCHED_SOFTIRQ).
 
 The latter function takes two arguments: the runqueue of current CPU and whether
diff --git a/Documentation/translations/zh_CN/scheduler/sched-domains.rst b/Documentation/translations/zh_CN/scheduler/sched-domains.rst
index e814d4c01141..fbc326668e37 100644
--- a/Documentation/translations/zh_CN/scheduler/sched-domains.rst
+++ b/Documentation/translations/zh_CN/scheduler/sched-domains.rst
@@ -36,7 +36,7 @@ CPU共享。任意两个组的CPU掩码的交集不一定为空，如果是这
 
 在kernel/sched/core.c中，trigger_load_balance()在每个CPU上通过scheduler_tick()
 周期执行。在当前运行队列下一个定期调度再平衡事件到达后，它引发一个软中断。负载均衡真正
-的工作由run_rebalance_domains()->rebalance_domains()完成，在软中断上下文中执行
+的工作由sched_balance_softirq()->rebalance_domains()完成，在软中断上下文中执行
 （SCHED_SOFTIRQ）。
 
 后一个函数有两个入参：当前CPU的运行队列、它在scheduler_tick()调用时是否空闲。函数会从
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0eb2cafa1509..cdf0dbb9d3e3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12408,7 +12408,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 }
 
 /*
- * The run_rebalance_domains() softirq handler is triggered via SCHED_SOFTIRQ
+ * The sched_balance_softirq() softirq handler is triggered via SCHED_SOFTIRQ
  * from two places:
  *
  *  - the scheduler_tick(),
@@ -12416,7 +12416,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
  *  - from the SMP cross-call function nohz_csd_func(),
  *    used by NOHZ idle balancing (with NOHZ_BALANCE_KICK set).
  */
-static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
+static __latent_entropy void sched_balance_softirq(struct softirq_action *h)
 {
 	struct rq *this_rq = this_rq();
 	enum cpu_idle_type idle = this_rq->idle_balance;
@@ -13217,7 +13217,7 @@ __init void init_sched_fair_class(void)
 #endif
 	}
 
-	open_softirq(SCHED_SOFTIRQ, run_rebalance_domains);
+	open_softirq(SCHED_SOFTIRQ, sched_balance_softirq);
 
 #ifdef CONFIG_NO_HZ_COMMON
 	nohz.next_balance = jiffies;
-- 
2.40.1


