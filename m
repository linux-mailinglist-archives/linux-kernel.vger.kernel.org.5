Return-Path: <linux-kernel+bounces-90352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E385086FDFB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3AB281F78
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9BE383AD;
	Mon,  4 Mar 2024 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMIuax/L"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D052249F1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545733; cv=none; b=qS/BcxueVmTamn2Jjd7upY3VBGUm5b0FkBz5x/+1/swL1DYSo7NmN/8LWokXXMrC58j/rcnRAvvNd4/CxaKum5dGA1QTguOvGdgJ6sIx2VTChk3MOndlVNTT0kNQ6atjS5ub1dY0yJ3VHKRge/lCB+KX/Zr1Pz1u+FghqXXnWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545733; c=relaxed/simple;
	bh=gMQWIQDH7C8bNgMKp71YfGIO8qskGuiF8UVttyGNS/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VY2cUjoLMjp1DQPDz8jIgeFy9DZ5lx9fkIfTkJBZTMA5dDTW40RdoKJ8jhchtliEwLvg6S6VfOpTOSgy5b/tnv0RreGAk2TX7cQepRzUwayHbgBUeYJVv//whmWp6jer8/FyAQEXadx2pfc5pL0o8d4MZs2bLnBxO0JyS52gsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMIuax/L; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a44e3176120so171965566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709545729; x=1710150529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBHue8vJcmz9qFDlC9AIElMkx8kDde5GI/q8mPS7dVg=;
        b=JMIuax/LDBQ7VYyOu7dCBSjaz4WA58e4XLpKm0UYeFG0XhxUbItyds/+FeWLkY7269
         /4CcPrf7sTFKPUX3WGvyGtK4rIzK3EQETOqGz9yWod0Zi37NkmuXtCJ6YCmcYRs4fV/T
         mKfx8mo6h9vFYpy6G04DsO67VFqMGSgwQr5Z1A6RoAGjLYwIZDVGXlL2S4sCasVS6qPh
         5V5q5+1HKvSDFqolNyBW4/Den62JfcvAXv0Hhl7bi2V/IF1yYnk12lZGdYrUNcbO0UTs
         5ApFIcglSpwKo7W0riXNzjbFqmn7HbLcodq8g0mZq4I4vAL08wQY0+Yf/cALmCcOcvOf
         Gc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709545729; x=1710150529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sBHue8vJcmz9qFDlC9AIElMkx8kDde5GI/q8mPS7dVg=;
        b=iX/rCkrO8Fd8BadYvLGV/SpKQHx0RGMHAzyiNwZITw0ZdCLI7pLE500bEuKnHzQl9A
         k4a18995kscTd4uGa+rrZlEmxXXKXaQpLtwnB47Cqw1VSWlZF0j+AyRDfcDduW0ev1ud
         wRGjQHCozfHuQgA7yEEJHOSTshqg2qSn4+jAl8BaXsLrWRcpMb573yY/QwPU9rZH6EVp
         ypsYW85GL3q1x4PkjE1UEb9B7F35nKKdgwFkpmFsDBJa9+BDJ7lw/YFErMQrDWxB+coA
         ykK5vERv4UNdS6+0ocVUaedmg87Cqnl01Y3tMaXEkOTcgrbX2g5oDSW0HurArglhVJNV
         LubQ==
X-Gm-Message-State: AOJu0YxeASBgVJp0YDq9Xb19vdrUA/baNnG5vzdUsuqW2BibKgHh1W2X
	CalFBHtBUOxD10mnppz3/rOR4xc+HHOE1q6sbU/wXPSpghNevm+41dZTtxTFGiQ=
X-Google-Smtp-Source: AGHT+IFiVm1lZuNk09qzx0SI9MkhxwhhzZrt8l8A9lGkk40fmR8uIIcUEINTDaScq3lXPk8C5H3ZOA==
X-Received: by 2002:a17:906:f35b:b0:a43:fb64:e21d with SMTP id hg27-20020a170906f35b00b00a43fb64e21dmr6699556ejb.7.1709545729583;
        Mon, 04 Mar 2024 01:48:49 -0800 (PST)
Received: from kepler.redhat.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id s22-20020a170906501600b00a42e2bc82dbsm4569839ejj.169.2024.03.04.01.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:48:49 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 7/9] sched/balancing: Vertically align the comments of 'struct sg_lb_stats' and 'struct sd_lb_stats'
Date: Mon,  4 Mar 2024 10:48:29 +0100
Message-Id: <20240304094831.3639338-8-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240304094831.3639338-1-mingo@kernel.org>
References: <20240304094831.3639338-1-mingo@kernel.org>
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
index 18b7d2999cff..fc4b2df7ddf2 100644
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


