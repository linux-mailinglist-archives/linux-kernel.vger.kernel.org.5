Return-Path: <linux-kernel+bounces-54023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0BD84A95F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1471E1F29ECF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A28D48CF2;
	Mon,  5 Feb 2024 22:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="o2Cg/K9S"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B571EB49
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172438; cv=none; b=ThLv4olUbR0eM+H8u5gQBP55wR9bcA3pC8Hj4X+Ed8Vau9I7kQkSRfOzp+Bw7wzjqgP/2o6/YJMlA0IIeOuWLIShLgfYGcz9jCiZ7PYTAOixCmzeyzcrLWfaRcFdzaGQSO0+9FQ1zf+PVUTc9Qw3wMm5vacuehw40ezVPsqLVDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172438; c=relaxed/simple;
	bh=ju8fO7bRaWm0bjcYGpe5g5YgdTVD76spIOWUxaGYDKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pCKXXEhrCBaHgkdh5IQ2LwhQtnZHUyHWQt9ZAuuEZP473EDc7hQKvxLBWtpzsopAN8YNZPPoKOWO0M1a10koMpu3+ohjGZp9dcBmrPqJym4DYEI+yxVwgvh6l3FFi0Z4dcvrnZa0Up5bwcBs8lkZOugkACIz5Ybqjj0WKqwUmyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=o2Cg/K9S; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-511538be947so1350220e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 14:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1707172434; x=1707777234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsogSjsdXjaHsLgoxoa0By5YJEKAV8QszBW6RcRGT10=;
        b=o2Cg/K9ST3eWfLspmvgWv0fHXXbDwx7gSSqnJu/sRB2R0CqEYNjzORz0uwDwrYrj5o
         ZduVUMvrdhwB4wIcbB5DGhCzPn5TaBiHZBr+UQlcuGW12JQpXv0cbe0FrftB5H1FkxBh
         K5Li5MzZqjTQ4TWVnQ3FqsFT7qLrmh/t0fLF53XwrgE2W40yKYr6MWay7MB177CPlbof
         Hk9z5QNYGlHn8sqLfh29Sy8418Dez97fkfecu2wQj9di2WuzqUIlwM96Go/OzFbYklCS
         UaoTw2qNot81Lq5XkGTQePKx3WHUvcMAPfzbS9x98jkb1QmQdM7lsHmdq8pfL3ZMa79P
         T2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172434; x=1707777234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsogSjsdXjaHsLgoxoa0By5YJEKAV8QszBW6RcRGT10=;
        b=AzH87hjazzRpM4zVwlo44XSKnnZkn8no9isTXdVEh75mhQtiEgsdhLtcVJ20ePCvVl
         dflpMA3hCgvAbUeAF6+impE9QslC5oJfVwlYuf5/GGWgbO4rnRB8CEaBLTJf6I+bkQFz
         q6gqwyh9Sk2YW/O4TdnuIGSSsTbMGZToTuVfQlky6hgUBZt1mqxpFQKhMtPVyaIzKIqf
         LYvrMAqNs+1iFxY79iJU93Gakq3coUVLbgjOUVFwP9Gox0Fs5/vz5L4llAqbUVsOQBO/
         mKVL8kI0ECOBoygJe01hvwkSCJ4QyuHUqbSy9DcZnjeSK0+w27oBsLkjRrqyx+hXYiyJ
         Xjbw==
X-Gm-Message-State: AOJu0Yz7i+VLnz3Nem8oeQNlrAJ2f62XmfpIzUYxG3FR1SmQ1dAWBkGG
	+MIzHKqbwQt0y37dthjpyQoEnut69/BxdiNSuDtj5tA/4oYPMr0r8eC0x0Y4K9g=
X-Google-Smtp-Source: AGHT+IFg+zOTzzn6r47C/RVRyVOvGJjoHtQL+b/Xl20Qdm/seBACwfEBRFYJpSUcz09n38MwmQHf8A==
X-Received: by 2002:a05:6512:466:b0:511:56ef:93eb with SMTP id x6-20020a056512046600b0051156ef93ebmr513893lfd.30.1707172434182;
        Mon, 05 Feb 2024 14:33:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXRiTBvmmsc4xVVrprACB8/xbJXi4TkJ7DuhkCVnY1R9PzBaaOSKkLFYr+zWhloZjkdDBNq5fs9ha/LDQviqBuEleB8wNDZKpwjM/XCCfwSyNF0YKPCm86oN/PbZWnJshw5tMkbGdSiA/2Rpf8vWYoWGCPNCEoQ95+uEmnp0BNY7fkmEINCfSSGvXuW+tHSu0ZNTBCoJOhbavYH6elyXxP92QJcFX9BwK6AStevmUxnTJVvCdMc1FTHtJX9gJoFSDeFI/rZPZBsNkeFiiQCuUqeQrb8lTtrP7fS2Nt+4g==
Received: from airbuntu.. (host109-154-238-234.range109-154.btcentralplus.com. [109.154.238.234])
        by smtp.gmail.com with ESMTPSA id hi2-20020a05600c534200b0040ef702a338sm9683135wmb.25.2024.02.05.14.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:33:53 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>,
	Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>,
	Chung-Kai Mei <chungkai@google.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 3/3] sched/fair: Remove magic hardcoded margin in fits_capacity()
Date: Mon,  5 Feb 2024 22:33:44 +0000
Message-Id: <20240205223344.2280519-4-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205223344.2280519-1-qyousef@layalina.io>
References: <20240205223344.2280519-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace hardcoded margin value in fits_capacity() with better dynamic
logic.

80% margin is a magic value that has served its purpose for now, but it
no longer fits the variety of systems that exist today. If a system is
over powered specifically, this 80% will mean we leave a lot of capacity
unused before we decide to upmigrate on HMP system.

On many systems the little cores are under powered and ability to
migrate faster away from them is desired.

There are two factors that must define when a task is misfit:

1. Due to invariance, time stretches and the ability of a task to reach
   certain util value requires longer runtime on smaller CPUs.

   This means tasks running on biggest core will require shorter amount
   of time to reach max performance point compared to the smaller cores.
   To counter the impact of this invariance, we must ensure that the
   task migrate faster so that they can reach the max performance point
   at a constant rate regardless where they're running on.

2. Misfit migration relies on TICK to help it to migrate. But as a worst
   case scenario this TICK can happen after we cross the fits_capacity
   threshold. So we must cater for this worst case scenario when
   calculating the threshold so tasks don't end up stuck on the wrong
   CPU which can cause performance and latency problems.

Below table shows the mapping for the misfit threshold without and with
taking the tick (4ms) into account. Note how the margin needs to be very
large at the bottom end, but very small at the higher end.

It is still large in the 600-750 range where many mid cores lie. So
there are contradiction requirements of enabling tasks to experience
coherent ramp-up time across all CPUs and reduce the latency to achieve
max performance point vs slowing down to allow mid clusters to be more
utilized in 'not so busy' situations.

Not sure if the answer lies in misfit definition. But most likely in
better task placement and load balancing strategies that considers other
factors beside misfit.

cap		threshold	%		threshold-tick	%
0		0		0		0		0
16		0		0		0		0
32		1		3.12		0		0
48		3		6.25		2		4.16
64		4		6.25		2		3.12
80		6		7.5		5		6.25
96		10		10.41		8		8.33
112		14		12.5		11		9.82
128		18		14.06		16		12.5
144		21		14.58		18		12.5
160		26		16.25		23		14.37
176		33		18.75		29		16.47
192		39		20.31		35		18.22
208		47		22.59		43		20.67
224		55		24.55		50		22.32
240		63		26.25		59		24.58
256		73		28.51		68		26.56
272		82		30.14		77		28.30
288		93		32.29		87		30.20
304		103		33.88		97		31.90
320		114		35.62		108		33.75
336		126		37.5		120		35.71
352		138		39.20		132		37.5
368		151		41.03		144		39.13
384		163		42.44		157		40.88
400		177		44.25		170		42.5
416		197		47.35		190		45.67
432		212		49.07		204		47.22
448		226		50.44		218		48.66
464		241		51.93		233		50.21
480		263		54.79		255		53.12
496		278		56.04		271		54.63
512		294		57.42		286		55.85
528		317		60.03		309		58.52
544		333		61.21		325		59.74
560		356		63.57		348		62.14
576		380		65.97		372		64.58
592		396		66.89		388		65.54
608		419		68.91		412		67.76
624		443		70.99		435		69.71
640		466		72.81		459		71.71
656		489		74.54		482		73.47
672		512		76.19		505		75.14
688		534		77.61		528		76.74
704		557		79.11		550		78.12
720		578		80.27		572		79.44
736		606		82.33		600		81.52
752		633		84.17		627		83.37
768		653		85.02		647		84.24
784		678		86.47		672		85.71
800		707		88.37		701		87.62
816		729		89.33		724		88.72
832		756		90.86		751		90.26
848		780		91.98		776		91.50
864		803		92.93		799		92.47
880		828		94.09		824		93.63
896		850		94.86		847		94.53
912		874		95.83		871		95.50
928		897		96.65		894		96.33
944		921		97.56		919		97.35
960		943		98.22		941		98.02
976		964		98.77		963		98.66
992		984		99.19		983		99.09
1008		1004		99.60		1004		99.60
1024		1022		99.80		1022		99.80

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/core.c  |  1 +
 kernel/sched/fair.c  | 42 +++++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h |  1 +
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index db4be4921e7f..def7af257270 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10004,6 +10004,7 @@ void __init sched_init(void)
 		rq->sd = NULL;
 		rq->rd = NULL;
 		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
+		rq->fits_capacity_threshold = SCHED_CAPACITY_SCALE;
 		rq->balance_callback = &balance_push_callback;
 		rq->active_balance = 0;
 		rq->next_balance = jiffies;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b803030c3a03..630eae0470ca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -101,11 +101,22 @@ int __weak arch_asym_cpu_priority(int cpu)
 }
 
 /*
- * The margin used when comparing utilization with CPU capacity.
+ * fits_capacity() must ensure that a task will not be 'stuck' on a CPU with
+ * lower capacity for too long. This can happen because of two reasons:
  *
- * (default: ~20%)
+ * 1. Capacity and frequency invariance means the runtime on each CPU is not
+ *    the same. We want the task to experience the same ramp-up time to reach
+ *    max performance point of the system as if they were running on the
+ *    biggest CPU.
+ *
+ * 2. A misfit migration will require a tick as a worst case scenario to
+ *    migrate it to a bigger CPU. So we must cater for this time and make sure
+ *    it migrates before it becomes a true misfit.
  */
-#define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
+static inline bool fits_capacity(unsigned long util, int cpu)
+{
+	return util < cpu_rq(cpu)->fits_capacity_threshold;
+}
 
 /*
  * The margin used when comparing CPU capacities.
@@ -4965,13 +4976,12 @@ static inline int util_fits_cpu(unsigned long util,
 				int cpu)
 {
 	unsigned long capacity_orig, capacity_orig_thermal;
-	unsigned long capacity = capacity_of(cpu);
 	bool fits, uclamp_max_fits;
 
 	/*
 	 * Check if the real util fits without any uclamp boost/cap applied.
 	 */
-	fits = fits_capacity(util, capacity);
+	fits = fits_capacity(util, cpu);
 
 	if (!uclamp_is_used())
 		return fits;
@@ -9522,12 +9532,30 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 {
 	unsigned long capacity = scale_rt_capacity(cpu);
 	struct sched_group *sdg = sd->groups;
+	struct rq *rq = cpu_rq(cpu);
+	u64 limit;
 
 	if (!capacity)
 		capacity = 1;
 
-	cpu_rq(cpu)->cpu_capacity = capacity;
-	trace_sched_cpu_capacity_tp(cpu_rq(cpu));
+	rq->cpu_capacity = capacity;
+	trace_sched_cpu_capacity_tp(rq);
+
+	/*
+	 * Calculate the util at which the task must be considered a misfit.
+	 *
+	 * We must ensure that a task experiences the same ramp-up time to
+	 * reach max performance point of the system regardless of the CPU it
+	 * is running on (due to invariance, time will stretch and task will
+	 * take longer to achieve the same util value compared to a task
+	 * running on a big CPU) and a delay in misfit migration which depends
+	 * on TICK doesn't end up hurting it as it can happen after we would
+	 * have crossed this threshold.
+	 */
+	limit = approximate_runtime(arch_scale_cpu_capacity(cpu)) * USEC_PER_MSEC;
+	limit -= TICK_USEC; /* sd->balance_interval is more accurate */
+	limit = cap_scale(limit, arch_scale_cpu_capacity(cpu));
+	rq->fits_capacity_threshold = approximate_util_avg(0, limit);
 
 	sdg->sgc->capacity = capacity;
 	sdg->sgc->min_capacity = capacity;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d078e6481bd0..92c29b6d3cc5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1054,6 +1054,7 @@ struct rq {
 	struct sched_domain __rcu	*sd;
 
 	unsigned long		cpu_capacity;
+	unsigned long		fits_capacity_threshold;
 
 	struct balance_callback *balance_callback;
 
-- 
2.34.1


