Return-Path: <linux-kernel+bounces-48203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9056845892
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4491C26874
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671305337F;
	Thu,  1 Feb 2024 13:12:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FA88665E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793138; cv=none; b=LWi6hG2F0E23K4DfSJIgMzgtTZci3zWMCw9gXSk31I8LZKm6eX4Dm9lMoH8C5T6sjntN2Hyp8qO/4XKMbl3Ww9uwRjA9LEVKePDG+kXqaOx7aJ8tyjzLDrgm7KJDf2Vo26QIL2y8HJ2t2ieXB0067v2O/46ou2JwtjZcX6+SSUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793138; c=relaxed/simple;
	bh=fFtMnS0pExRU9XxAc52P1T23Oszmuznw5qpiL99BkH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZXS/h9AVZIoGu1bvxoKlS3kaaEG09XjSGrX0XPeeEhv6jO4nSwoSL+BXS68tfmpo0gMhsySc2OIfltwc2+9aG1hjrDCbtQHPonhAag4R8xTu2aFyj8jVOntL39Pb76se+GsHDissJax3JepmtE3IMiOR1gRDQhkUzW/SIgYwy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A837B11FB;
	Thu,  1 Feb 2024 05:12:57 -0800 (PST)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1AC63F762;
	Thu,  1 Feb 2024 05:12:12 -0800 (PST)
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-kernel@vger.kernel.org,
	David Dai <davidai@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Hongyan Xia <Hongyan.Xia2@arm.com>
Subject: [RFC PATCH v2 1/7] Revert "sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0"
Date: Thu,  1 Feb 2024 13:11:57 +0000
Message-Id: <b29e7df921ce07c2c2dbbde390e234d162756c42.1706792708.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706792708.git.hongyan.xia2@arm.com>
References: <cover.1706792708.git.hongyan.xia2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyan Xia <Hongyan.Xia2@arm.com>

That commit creates further problems because 0 spare capacity can be
either a real indication that the CPU is maxed out, or the CPU is
UCLAMP_MAX throttled, but we end up giving all of them a chance which
can results in bogus energy calculations. It also tends to schedule
tasks on the same CPU and requires load balancing patches. Sum
aggregation solves these problems and this patch is not needed.

This reverts commit 6b00a40147653c8ea748e8f4396510f252763364.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/fair.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b803030c3a03..d5cc87db4845 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7978,10 +7978,11 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	for (; pd; pd = pd->next) {
 		unsigned long util_min = p_util_min, util_max = p_util_max;
 		unsigned long cpu_cap, cpu_thermal_cap, util;
-		long prev_spare_cap = -1, max_spare_cap = -1;
+		unsigned long cur_delta, max_spare_cap = 0;
 		unsigned long rq_util_min, rq_util_max;
-		unsigned long cur_delta, base_energy;
+		unsigned long prev_spare_cap = 0;
 		int max_spare_cap_cpu = -1;
+		unsigned long base_energy;
 		int fits, max_fits = -1;
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
@@ -8044,7 +8045,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 				prev_spare_cap = cpu_cap;
 				prev_fits = fits;
 			} else if ((fits > max_fits) ||
-				   ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {
+				   ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
 				/*
 				 * Find the CPU with the maximum spare capacity
 				 * among the remaining CPUs in the performance
@@ -8056,7 +8057,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			}
 		}
 
-		if (max_spare_cap_cpu < 0 && prev_spare_cap < 0)
+		if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
 			continue;
 
 		eenv_pd_busy_time(&eenv, cpus, p);
@@ -8064,7 +8065,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
 
 		/* Evaluate the energy impact of using prev_cpu. */
-		if (prev_spare_cap > -1) {
+		if (prev_spare_cap > 0) {
 			prev_delta = compute_energy(&eenv, pd, cpus, p,
 						    prev_cpu);
 			/* CPU utilization has changed */
-- 
2.34.1


