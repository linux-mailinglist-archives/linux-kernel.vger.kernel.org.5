Return-Path: <linux-kernel+bounces-73207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 266C385BF51
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9397C1F23059
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6492576031;
	Tue, 20 Feb 2024 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSHfxUp2"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9597574E18
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441202; cv=none; b=aEYbgxoUJ6s2j+jsdTDUVHPvrgmel1DXBe+YVFPHKbGhJkLHsRJHQ6uRk5NWhHZLufkmZkVVS2BCnhZcSpUeUXA/pgam31iqwNLFLJUlCPyEHiIQi7/fCmhzudMwGz/YfRS7sWTIPAVZJQfncTCZylF0ZtDy4VN43l9B05vsltI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441202; c=relaxed/simple;
	bh=qGYUynN5NcpKB39sGuu0UZatjNpLQ2jh/6eViMwAlgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWIz364jmNitklt2Fo45mLJa8KXSfN2Z34xI2FSxm3woHFsmK+IRMElS7YP9uIvNheDV0JCeasI/WXNpzyGAnxIeIQpiebIoTY7zJA0jYyqWja0iukgu31knMktev72KcFWmOtAJoCiW2aLxSjjL/4ySLSGQ5N8UHuEcQiQgFrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dSHfxUp2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33d01faf711so3346876f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708441198; x=1709045998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1flPou5mYVBaU24sWFJ4cs1Flglsy9dq5X4Do8IR/4=;
        b=dSHfxUp2D2XnloFD7YoFN5JbTdzvDr3IPAbgzrTamQvBDw+N0kt+IzqQ8gKX83Z2X6
         +z/jh4MousLTHeGEqQrVC0H+KbYXR3BiYYX8Jezhdq5SUaAnf2/AaEXFqACMjpRv/DXk
         2V05zf7hHa+F0VdfhFxp72WdfyBIU6Sx/aytZbj6kwFWIWbdDoqbroeydMvS0UayDnVG
         DcrhTMEOh9scAHyvz+RFRK6ga8VovwqX37coFZBhY3+dwDjieXT1D5NX/MGjtNezGFbC
         CpfEY6SU8s9pN2mBAbXAFacRyHMn37wbqvADV9nZFYsVGhJAxVo+e3FnzWAuAgxhSbpp
         XnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708441198; x=1709045998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1flPou5mYVBaU24sWFJ4cs1Flglsy9dq5X4Do8IR/4=;
        b=jjN4QCYLuNJwBUfiikErsGQx3dXuaZfY4SUm4NmesJ89Fh+Cidiqj6MS7fNZuzKi5e
         Bum96Y5HO8uRYccJy/jdk+SjlY2E8xNKQiw67OlU9b/IbIwexiCmDBmpRIYICRkjLHL5
         bHqJWK8gFEuCmXieWP2m3RPjtjhYt4Mx0XRvx1aE2dx0Qlc5/h8PHmOjGe94QTOrEEGM
         rXaQ9Je52AkdrNDpGrPPQyf+TIk/8uypnAJE/HSfj/9fzSPmrbmKAnObUxRJsVirijdu
         3u+QjF9TIY4xR7vv8b9S0TnDmJDyRYOAm8lADlQ9gJStEOt4da7OOmSl1bQlFBm0lL3O
         YwFw==
X-Forwarded-Encrypted: i=1; AJvYcCUz93mWS8VkzflNfJNH7UdHKHqa3LMSvcd3R9h3uXoUWRkMyVp/vPo5Z5oKEAzsCnpbxE/3lG4NVavxRBtBQMp8sMxb1lbC7qy0tHGI
X-Gm-Message-State: AOJu0Yzcv92za/sAmPiSuxvpPepAsfawWyeecuzMdfae03ZNUNRQOG9L
	Zc/rdRcnwbEJna8KOo6q46ZOIX09u1aOxKeBx+wrj8Y43TzWErIowQfaH8izO2g=
X-Google-Smtp-Source: AGHT+IFnH6LSh/eHytWkpMH9ltLZeBfbERZJS//BO9MobsMYNV9mdBL8Hsbe3uWxLgQeZ8IruQVCew==
X-Received: by 2002:a5d:4d88:0:b0:33d:37ae:32fa with SMTP id b8-20020a5d4d88000000b0033d37ae32famr5051649wru.50.1708441197841;
        Tue, 20 Feb 2024 06:59:57 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:8deb:bfb9:b028:6d5c])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b0033d39626c27sm9304405wru.76.2024.02.20.06.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 06:59:57 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	agross@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	lukasz.luba@arm.com,
	rui.zhang@intel.com,
	mhiramat@kernel.org,
	daniel.lezcano@linaro.org,
	amit.kachhap@gmail.com,
	corbet@lwn.net,
	gregkh@linuxfoundation.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v5 2/5] sched: Take cpufreq feedback into account
Date: Tue, 20 Feb 2024 15:59:44 +0100
Message-Id: <20240220145947.1107937-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220145947.1107937-1-vincent.guittot@linaro.org>
References: <20240220145947.1107937-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aggregate the different pressures applied on the capacity of CPUs and
create a new function that returns the actual capacity of the CPU:
  get_actual_cpu_capacity()

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/fair.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8e30e2bb77a0..9c650b860946 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4959,13 +4959,22 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	trace_sched_util_est_se_tp(&p->se);
 }
 
+static inline unsigned long get_actual_cpu_capacity(int cpu)
+{
+	unsigned long capacity = arch_scale_cpu_capacity(cpu);
+
+	capacity -= max(thermal_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu));
+
+	return capacity;
+}
+
 static inline int util_fits_cpu(unsigned long util,
 				unsigned long uclamp_min,
 				unsigned long uclamp_max,
 				int cpu)
 {
-	unsigned long capacity_orig, capacity_orig_thermal;
 	unsigned long capacity = capacity_of(cpu);
+	unsigned long capacity_orig;
 	bool fits, uclamp_max_fits;
 
 	/*
@@ -4997,7 +5006,6 @@ static inline int util_fits_cpu(unsigned long util,
 	 * goal is to cap the task. So it's okay if it's getting less.
 	 */
 	capacity_orig = arch_scale_cpu_capacity(cpu);
-	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
 
 	/*
 	 * We want to force a task to fit a cpu as implied by uclamp_max.
@@ -5072,7 +5080,8 @@ static inline int util_fits_cpu(unsigned long util,
 	 * handle the case uclamp_min > uclamp_max.
 	 */
 	uclamp_min = min(uclamp_min, uclamp_max);
-	if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
+	if (fits && (util < uclamp_min) &&
+	    (uclamp_min > get_actual_cpu_capacity(cpu)))
 		return -1;
 
 	return fits;
@@ -7453,7 +7462,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 		 * Look for the CPU with best capacity.
 		 */
 		else if (fits < 0)
-			cpu_cap = arch_scale_cpu_capacity(cpu) - thermal_load_avg(cpu_rq(cpu));
+			cpu_cap = get_actual_cpu_capacity(cpu);
 
 		/*
 		 * First, select CPU which fits better (-1 being better than 0).
@@ -7946,8 +7955,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	struct root_domain *rd = this_rq()->rd;
 	int cpu, best_energy_cpu, target = -1;
 	int prev_fits = -1, best_fits = -1;
-	unsigned long best_thermal_cap = 0;
-	unsigned long prev_thermal_cap = 0;
+	unsigned long best_actual_cap = 0;
+	unsigned long prev_actual_cap = 0;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
 	struct energy_env eenv;
@@ -7977,7 +7986,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 	for (; pd; pd = pd->next) {
 		unsigned long util_min = p_util_min, util_max = p_util_max;
-		unsigned long cpu_cap, cpu_thermal_cap, util;
+		unsigned long cpu_cap, cpu_actual_cap, util;
 		long prev_spare_cap = -1, max_spare_cap = -1;
 		unsigned long rq_util_min, rq_util_max;
 		unsigned long cur_delta, base_energy;
@@ -7989,18 +7998,17 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		if (cpumask_empty(cpus))
 			continue;
 
-		/* Account thermal pressure for the energy estimation */
+		/* Account external pressure for the energy estimation */
 		cpu = cpumask_first(cpus);
-		cpu_thermal_cap = arch_scale_cpu_capacity(cpu);
-		cpu_thermal_cap -= arch_scale_thermal_pressure(cpu);
+		cpu_actual_cap = get_actual_cpu_capacity(cpu);
 
-		eenv.cpu_cap = cpu_thermal_cap;
+		eenv.cpu_cap = cpu_actual_cap;
 		eenv.pd_cap = 0;
 
 		for_each_cpu(cpu, cpus) {
 			struct rq *rq = cpu_rq(cpu);
 
-			eenv.pd_cap += cpu_thermal_cap;
+			eenv.pd_cap += cpu_actual_cap;
 
 			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
 				continue;
@@ -8071,7 +8079,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (prev_delta < base_energy)
 				goto unlock;
 			prev_delta -= base_energy;
-			prev_thermal_cap = cpu_thermal_cap;
+			prev_actual_cap = cpu_actual_cap;
 			best_delta = min(best_delta, prev_delta);
 		}
 
@@ -8086,7 +8094,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 * but best energy cpu has better capacity.
 			 */
 			if ((max_fits < 0) &&
-			    (cpu_thermal_cap <= best_thermal_cap))
+			    (cpu_actual_cap <= best_actual_cap))
 				continue;
 
 			cur_delta = compute_energy(&eenv, pd, cpus, p,
@@ -8107,14 +8115,14 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			best_delta = cur_delta;
 			best_energy_cpu = max_spare_cap_cpu;
 			best_fits = max_fits;
-			best_thermal_cap = cpu_thermal_cap;
+			best_actual_cap = cpu_actual_cap;
 		}
 	}
 	rcu_read_unlock();
 
 	if ((best_fits > prev_fits) ||
 	    ((best_fits > 0) && (best_delta < prev_delta)) ||
-	    ((best_fits < 0) && (best_thermal_cap > prev_thermal_cap)))
+	    ((best_fits < 0) && (best_actual_cap > prev_actual_cap)))
 		target = best_energy_cpu;
 
 	return target;
@@ -9490,8 +9498,8 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 
 static unsigned long scale_rt_capacity(int cpu)
 {
+	unsigned long max = get_actual_cpu_capacity(cpu);
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long max = arch_scale_cpu_capacity(cpu);
 	unsigned long used, free;
 	unsigned long irq;
 
@@ -9503,12 +9511,9 @@ static unsigned long scale_rt_capacity(int cpu)
 	/*
 	 * avg_rt.util_avg and avg_dl.util_avg track binary signals
 	 * (running and not running) with weights 0 and 1024 respectively.
-	 * avg_thermal.load_avg tracks thermal pressure and the weighted
-	 * average uses the actual delta max capacity(load).
 	 */
 	used = READ_ONCE(rq->avg_rt.util_avg);
 	used += READ_ONCE(rq->avg_dl.util_avg);
-	used += thermal_load_avg(rq);
 
 	if (unlikely(used >= max))
 		return 1;
-- 
2.34.1


