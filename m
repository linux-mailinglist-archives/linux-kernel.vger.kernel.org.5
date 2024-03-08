Return-Path: <linux-kernel+bounces-96890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A826D87629F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215911F232A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB6C5D471;
	Fri,  8 Mar 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOaUczvw"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB7F5A4D3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895567; cv=none; b=YjneXp6wEipgEeEv4A7E5kZNoohUcMeTHIKewUS8PWGdx3yv/+HesLY+m5MW+EhjOUMF28I2zIQTYT51B9mUce68yu7bKJOfeOfyOVXyBF0jNz4C+Isq128Zboq1BSTWJ9LtNasKcFTctiyHRUq48KynbExNK2720S+kJStkLt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895567; c=relaxed/simple;
	bh=ubt7kAoCJQjP71eh+xekBt691hX9l2wuKxynxUyQakA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f7lzoQI8MCrK3vAJtAtD/ioV6mx7cVc66npLfUMLHiZMmZTGRG5jcviDiDYV6MimJHb1iWkF7Vtk2gVwJv9eRSNXen2WTF9xFA0a7YfCifMXTm8H+ahDFYhKfe+G5h6JdtHE593ODFHvtLRQ8hlCYcUU+E4Yh2ciZrwajuGMX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOaUczvw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412f1961101so16983595e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709895564; x=1710500364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEBAYWJaT1vEVYD8Qqh08dtRz0Ow84weCEvJx52ecWM=;
        b=lOaUczvwDt69QrrJM+3UAlPw2S2dtSG5vsxWmr/hTtIVd2XRyJ6m1qnTaUd9xIqa6N
         Uc2OdpdlAXAWwsdldoKiTnnPyYCTj8GM4eNqZPu/PG9i7Uopkg7/LlcZHIJbcFqFwEtl
         5+ZpPXW9PpTzgBmtaAmcM3fiGtZKoJRHL2dxDjoWI7hngTPCP0MD/L9IOVEl9bsU5tCB
         A4niiHb7qs5puENqR3YEG/q4lvewwwSbLlk+3j9T8WmPYfJiKqQyj46oWVwHVa2XLoe0
         ptHWHB7qL5kwkIaQmRbtJtT7t6WLyH+0QmipEXDVBEMu4SqkdowlL1I53tfVCf0CNWll
         Ra8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709895564; x=1710500364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bEBAYWJaT1vEVYD8Qqh08dtRz0Ow84weCEvJx52ecWM=;
        b=a9IPg+BhRtSZopxjcJZIg76KbHeEfTWguFSlyQ9/Cli6Y5bntX5fRHD2iPT9QAcSiC
         fFWorOMuQmwz4xuBS+3w7AQcfUCa+7lCJOq0rJnmh+qCT4Cp1kzFm/kYAndyIdOhaCe6
         4EtgjnAvRYdxrn0AOOwhQe04EOFxlWLOs2L4QPeAa/ohNpRdFqQlDAoVfqSmqNVoE7H7
         XWcuvQB/pFdjfPfPjV1JVerLxQlzgC3CqFec/KxnI/9M7s1ONC+is+pcbHT1lXY4q0fI
         +lJSjOpN4mv9JpKnuDe1IdddGOf+ym4z1et2ie/HTx8Th7LUq2fvpLrpt/2pr5LImKqg
         VCGQ==
X-Gm-Message-State: AOJu0YwNclhSotKgRMWi8NlxfJhMrxdzwsGpH6D43hSi0uWS807XW9Aq
	WoC9KTscoqI3kLuetkyH4Fv1HNuvcYOrHNULwy8mObU+WXdZnBZMUPiBva/BawU=
X-Google-Smtp-Source: AGHT+IHt7IXMkTppYRHHONS7SRn+JmAFU+BK9TC8Q97hQScX5vgM45fmvhEycV19jVnovOGF3zzJ0g==
X-Received: by 2002:a05:600c:3b89:b0:412:f196:1065 with SMTP id n9-20020a05600c3b8900b00412f1961065mr5918512wms.10.1709895563593;
        Fri, 08 Mar 2024 02:59:23 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b00412f679bae1sm5632382wmq.26.2024.03.08.02.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:59:23 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 09/10] sched/balancing: Vertically align the comments of 'struct sg_lb_stats' and 'struct sd_lb_stats'
Date: Fri,  8 Mar 2024 11:59:00 +0100
Message-Id: <20240308105901.1096078-10-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240308105901.1096078-1-mingo@kernel.org>
References: <20240308105901.1096078-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make them easier to read.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b567c0790f44..40b98e43d794 100644
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


