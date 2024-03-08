Return-Path: <linux-kernel+bounces-96908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EE7876302
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BAF71F21A4B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF4456456;
	Fri,  8 Mar 2024 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbX+QNir"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761C83C24
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896716; cv=none; b=KrTNozhi0pK3vi9JO5kS3LbiSmPl6wfe0KNme0GQtdsTirhqICzBd/D4UgDtOt+dI0GWPRT/iBG+2xS+poahtZz+YngqsmFB+6RGp3JPvHx63bgXpgwRBdJpinErNGGf/v16AO27hpB66pj903JV4NpJPGsydfta2kraCUM7lC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896716; c=relaxed/simple;
	bh=mZXA0w0qbcZUUB8hRyDOhH4UKVb+9IvvzRfXr3AcBko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YzhZoJAcVb7u8vKkVt+21xZZyrOFVY7vuXtCup/OdM0rNeOjHJuKfUFCjs0FEaByTBypOISf5aazsLRGtVe4wqTF8g/DndUMCdLMRzqyauLWiBk2Mz3ff0omKpUlznL+1PddcNtiq65UV9L7Pze0sGBq27/f6gO/q7XFySVkcqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbX+QNir; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e65ed1c3aso601665f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709896713; x=1710501513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSOz+7Sts53Qhe5VQivnL2JCHzBJY0rk8TTBQBo3Arw=;
        b=BbX+QNirP775M957hWGqOHlOZ1vbuBeba2MxtlQa1mOX6MSdpQ6wmYmELsQ4LzSaqa
         AhT2v4TwmwDddMclYNGdjvYFdV+SmTUfL8yJdL8MajK9/xP1SocDY1UWF+32aUEiWqub
         aDze7JKF/XlUhq/EALLFNc7CpppXQel9X2QfG0WhTlNFFURVNjaunOzv0zUou3wL0yHo
         VLpH4PvKtqUN/S0dsb9jjhgRiZs5CpKI6fjjU4zmzPUokMl5GHi0Iw1PA686FEiRb7NM
         IlkNZyILPBxTxr+Z4CZ0eY1o24g/HoA68ZODdEdPvahkj3qb+zTizJ//0MR20PixDjBu
         lBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896713; x=1710501513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSOz+7Sts53Qhe5VQivnL2JCHzBJY0rk8TTBQBo3Arw=;
        b=ObsT545IUMmViKerPWf4+OjZ5xS5n29dfjpjTXMEOosPsZib8LPTGC3m35FVkG6RZg
         dcDbrYeJDC54gVkm5R8G+gSGXIX7L/8kUQROGx1vRxyKlEuNwezOPUrtnaX2bfEX3Y8p
         D0wKCGw/FGOAOmau2sDu0JoUn9aDnN4oNw/8tHAoBq15aLqNX1amJ7491ptg5l8ZIWmF
         bGhbHktVZublfDQVjuHcRr00GsLUIH3cyNWI6ox1LssgmDjd1BB9axOwiVE+ItcIsHFI
         QmruBQP71/0SPStvO/GQzz/YlETJxT1BcvpAU1/J2IBZL/7KQgPTzD/5atzKUtAnXy5f
         eJnQ==
X-Gm-Message-State: AOJu0YwEE1TSITYyfh3rqeSfjo2hQBTk0+p06rJXhXgE9SOBGMsb/IZ/
	CDQuuKdtd3cNWCoYh8CqaFVuE/DNP+TjzP/dCkh0TXDVAgyexH3lrB2QJT0SQEc=
X-Google-Smtp-Source: AGHT+IE3Upszx1vJaZQz8ncMoS66zlztFZT6PSSeXv2PBr0o9lI/XnNzJ5pm0IO/7nK0nJcVoMs3bQ==
X-Received: by 2002:a05:6000:1a51:b0:33e:47d3:a6cd with SMTP id t17-20020a0560001a5100b0033e47d3a6cdmr8019786wry.68.1709896712564;
        Fri, 08 Mar 2024 03:18:32 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id v9-20020adfedc9000000b0033e712b1d9bsm2523884wro.77.2024.03.08.03.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:18:32 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 01/13] sched/balancing: Rename run_rebalance_domains() => sched_balance_softirq()
Date: Fri,  8 Mar 2024 12:18:07 +0100
Message-Id: <20240308111819.1101550-2-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240308111819.1101550-1-mingo@kernel.org>
References: <20240308111819.1101550-1-mingo@kernel.org>
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
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 Documentation/scheduler/sched-domains.rst                    | 2 +-
 Documentation/translations/zh_CN/scheduler/sched-domains.rst | 2 +-
 kernel/sched/fair.c                                          | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

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
index 116a640534b9..953f39deb68e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12415,7 +12415,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
  * - indirectly from a remote scheduler_tick() for NOHZ idle balancing
  *   through the SMP cross-call nohz_csd_func()
  */
-static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
+static __latent_entropy void sched_balance_softirq(struct softirq_action *h)
 {
 	struct rq *this_rq = this_rq();
 	enum cpu_idle_type idle = this_rq->idle_balance;
@@ -13216,7 +13216,7 @@ __init void init_sched_fair_class(void)
 #endif
 	}
 
-	open_softirq(SCHED_SOFTIRQ, run_rebalance_domains);
+	open_softirq(SCHED_SOFTIRQ, sched_balance_softirq);
 
 #ifdef CONFIG_NO_HZ_COMMON
 	nohz.next_balance = jiffies;
-- 
2.40.1


