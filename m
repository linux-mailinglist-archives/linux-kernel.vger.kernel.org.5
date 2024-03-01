Return-Path: <linux-kernel+bounces-88303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82C386DFDD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57A51C2295E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315346EB42;
	Fri,  1 Mar 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH2QSPN8"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDE46D1BC
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291406; cv=none; b=SGk6BgxaQhjxuwdtqCW3C4gcNdpaprzYGF+S/79DuMzoqDTHq4jlW0TO1Iy4sT2OHberQy2W16cIGaAYs1HRbM3YFHjlKFniqqgaSh5G/+kJMs9rXmjr85RYFhU0Mh9r+g0pA+P8VceDrr+k1kuAadrIaUGqAQ4qu53QUOFLcLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291406; c=relaxed/simple;
	bh=trfivC8vG6hLXCya2zGOrWr40HQ6g3p1iNxASZJFkrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Reas5GSkfbmi26M3q9vZIxmLI1w9oO6Xfxo1UnNLAA/xSi+6fYE20HE9gXfiyneqOXnEpl74GrYsrX4V1gGjZ/MficJafIkGCUYkcHXJ8Eifufvk/RK6BOA4ql5+QZpjbkv/821DkohhliV5ZAdJV9prScMZdm8IygZ7+0eFmMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MH2QSPN8; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so20220081fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709291402; x=1709896202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsbzmPBgmd/PDvdJrOlCLNy3reKyEs/GH7VUyr30KAw=;
        b=MH2QSPN8McSPaZM8MAoLJ5plo31CPRlIOkIBmdIh3MV9T1SPLH5pIgPVvD2+mBPluH
         4ljb5w+Pp2e2WrviJz0IDVmoPNxfVeqLK6XpL+W0TdMFTOUCIVEeGNuHpFz3wgJJ8aDl
         v3Uwd5DX/bVpunGcGfSZuXRQ4xo7W8BvmIolA0PU7uFY5EZXh60q/vmUybCYaQ7s/WaT
         Jf7Nm2cIDwO1idutXsi0WFnaacX1fsMfTGSzUgMJ9EhxYVxvh1YgzAfQVIF2bBIpr7WE
         JpHwLLhc/ME7XbFd0vm4MF37wd4iUL22+A4goM/AVrsZ3pkws6rnH/9MATEWrPdlNdQf
         dVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709291402; x=1709896202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FsbzmPBgmd/PDvdJrOlCLNy3reKyEs/GH7VUyr30KAw=;
        b=HQdzrtbL2PvmMYZpfj5+PSLfmMwqTBKuaMCBiI7dFHYa208Hu7AhKY/5UUq1XfurFH
         bMYt3899RgK1HarD4uHgj1bN8uPmYXIU6xZh4AICzS5EM50e0RSj2W+0xlz62cL7qGAE
         AcXrPrW8OB0RiiJq/RNncgs3bKd7FNfghoW77+TLDBsZN+C5fJZe/8xeK6+iLqFJzelc
         0w4WI5qBbCMw6YT1E3aPTsXiXkIbtHknM3MK+CiyBAvHlI2VopkB7pxH9UCirJZ0stfi
         FLUhDTbG1wBTcgkv+takwsxYXWds4nOVd3uocbe2FMHLJztPUV0ewU5bhCo0OPYtOA9y
         dQ4Q==
X-Gm-Message-State: AOJu0Yz/oE8j1rgDfsIhU2Z17PCn0icsLM/sK41SKOZMBiyWdEnH+yBJ
	680WnhrWCw/t7Ns8+/hhQmCa6G7U/9aDM51teQplgfbtasA6gygqiRT2WTt8p/c=
X-Google-Smtp-Source: AGHT+IFm5psR3SfBycTnthdTG0tbEc2ft0NApkF4oN3RC78E9vOMGTa1BQgwiQGSSYr29Qe/VkoEfg==
X-Received: by 2002:a2e:b54e:0:b0:2d2:779d:3054 with SMTP id a14-20020a2eb54e000000b002d2779d3054mr931113ljn.0.1709291402467;
        Fri, 01 Mar 2024 03:10:02 -0800 (PST)
Received: from kepler.redhat.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id b20-20020a05600c4e1400b00412cad66f8fsm490264wmq.44.2024.03.01.03.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:10:02 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 6/7] sched/balancing: Vertically align the comments of 'struct sg_lb_stats' and 'struct sd_lb_stats'
Date: Fri,  1 Mar 2024 12:09:50 +0100
Message-Id: <20240301110951.3707367-7-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240301110951.3707367-1-mingo@kernel.org>
References: <20240301110951.3707367-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make them easier to read.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0e13b0016f33..99495c93e094 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9436,19 +9436,19 @@ static void update_blocked_averages(int cpu)
  * sg_lb_stats - stats of a sched_group required for load_balancing
  */
 struct sg_lb_stats {
-	unsigned long avg_load; /*Avg load across the CPUs of the group */
-	unsigned long group_load; /* Total load over the CPUs of the group */
+	unsigned long avg_load;			/* Avg load across the CPUs of the group */
+	unsigned long group_load;		/* Total load over the CPUs of the group */
 	unsigned long group_capacity;
-	unsigned long group_util; /* Total utilization over the CPUs of the group */
-	unsigned long group_runnable; /* Total runnable time over the CPUs of the group */
-	unsigned int sum_nr_running; /* Nr of tasks running in the group */
-	unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
+	unsigned long group_util;		/* Total utilization over the CPUs of the group */
+	unsigned long group_runnable;		/* Total runnable time over the CPUs of the group */
+	unsigned int sum_nr_running;		/* Nr of tasks running in the group */
+	unsigned int sum_h_nr_running;		/* Nr of CFS tasks running in the group */
 	unsigned int idle_cpus;
 	unsigned int group_weight;
 	enum group_type group_type;
-	unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
-	unsigned int group_smt_balance;  /* Task on busy SMT be moved */
-	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
+	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
+	unsigned int group_smt_balance;		/* Task on busy SMT be moved */
+	unsigned long group_misfit_task_load;	/* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
@@ -9460,15 +9460,15 @@ struct sg_lb_stats {
  *		 during load balancing.
  */
 struct sd_lb_stats {
-	struct sched_group *busiest;	/* Busiest group in this sd */
-	struct sched_group *local;	/* Local group in this sd */
-	unsigned long total_load;	/* Total load of all groups in sd */
-	unsigned long total_capacity;	/* Total capacity of all groups in sd */
-	unsigned long avg_load;	/* Average load across all groups in sd */
-	unsigned int prefer_sibling; /* tasks should go to sibling first */
+	struct sched_group *busiest;		/* Busiest group in this sd */
+	struct sched_group *local;		/* Local group in this sd */
+	unsigned long total_load;		/* Total load of all groups in sd */
+	unsigned long total_capacity;		/* Total capacity of all groups in sd */
+	unsigned long avg_load;			/* Average load across all groups in sd */
+	unsigned int prefer_sibling;		/* tasks should go to sibling first */
 
-	struct sg_lb_stats busiest_stat;/* Statistics of the busiest group */
-	struct sg_lb_stats local_stat;	/* Statistics of the local group */
+	struct sg_lb_stats busiest_stat;	/* Statistics of the busiest group */
+	struct sg_lb_stats local_stat;		/* Statistics of the local group */
 };
 
 static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
-- 
2.40.1


