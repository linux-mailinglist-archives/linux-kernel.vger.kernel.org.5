Return-Path: <linux-kernel+bounces-88304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73D186DFDE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1EF1F235B8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBC56EB56;
	Fri,  1 Mar 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOCObmiD"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8FD6D526
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291407; cv=none; b=J5EuqM5Ub1Wsif0yq+k1ILC5cIvsGf6eDCrDEOm9Enzx9T9UH+WlPRsMPpe5IsCQ5pA91D8TPKDe2xiKhwI005wUe8uAiBNkVDbOAzNH5kl3xAxqURVyWdsUkb+ZfQu9xXEAyFHmZDYBYizojr8Wm7unDWi1NqRM3hz43URyGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291407; c=relaxed/simple;
	bh=VDa2JdCTxD1j1f4It6rpxinY5I86VrDhb2Fk6B2iY9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/1yW2TK/bsmmt0qo+/OmPwMJ4MMVxlGOk5IzuCDnABXEx6jFWh2LEutB5bJaEbkQMqgcS1xg4/kGqUuijnelm6T+OP30l/+oRgS0KnqMA2/0gPYrgXPPckp++SutK9VlmFhRhtFxXO4r5wo0fmYh26qsubpfiDt2lHJJYaE1wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOCObmiD; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d26227d508so21790631fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709291403; x=1709896203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYC87+AtGNvd7VAVI78DNZ/P2pttTkG+THLM0HRfjPU=;
        b=IOCObmiDfhvDuoi1Jc+G60zlPKDmuyZO/bJcuY1w9hdKepoHbxTuvsLjTM3v31n1t3
         6zc5UMVJot1uEl51+a19zLT/KenmxlO2Rv83Y/NHT3+Zff4w10N3eQSat3jmP8zWa58Q
         1/vo6z67YDg92fbKGvCQMWp2G1J2vuPnFSB1y/bmKEwr/xXr4sttdrcMTpadPeJkeVPW
         m9acDMJS+YGgUvAiNDjVM8wDh08euYNp+g0yzDMAfyvY41col29znCinjP4zA8ORNWpL
         mX4mNdrncXP66T2cURanOaIoJ+7j+1300aQZmeS7UOKUX/zY5ay5ckSp96jnRd7EodBk
         Ukvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709291403; x=1709896203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AYC87+AtGNvd7VAVI78DNZ/P2pttTkG+THLM0HRfjPU=;
        b=uSz73WCRkY5tAplsTHa/J9HxPvfZuWeKqeJFGFd+DP2oRLfl9Z7BqAIAo0CdPYKZFX
         iFtNVZhbchj616yDBPnBn43l8JMI9vIcgiVP1W5FVTwmxr7ml/bCddmABk/MC6AuEaoP
         G5pnMHk3z3nk/8USfKSyZaW1v0jgRr5Cd1B3wWwDu2W6qy729Lc3YnPbcnPPtq35lNvK
         NV7r0CD0VRAVbcAjTDjkWyafpANKZsJzDinYidT3KNHhEn0hCRUvTTdfXnA7cFnzfkYw
         t5gtBnFLSmGjHRYx0QZcltzjeTYmWHN8l8btEhRraIhNwWVigXWts5GEAYDPDHmcNxPN
         VzIQ==
X-Gm-Message-State: AOJu0Yw4Gy/N348cKBeUHnMyAuD/tad+4kkrNMSrtAXZoDGV9GfYNdhK
	7w3XadccFylxTb7A42rC/N/j28ZsYEiyP5AO6n/pBOgrN+QSLKlDpXxhWoz7ySU=
X-Google-Smtp-Source: AGHT+IH7nifUptW1CrFkd5gTff5Mf2tDV3sUzIfmtyxGXQUuH5Stu23h9ATuk4h00ru+ghdyUh98gQ==
X-Received: by 2002:a05:6512:1193:b0:513:2447:d110 with SMTP id g19-20020a056512119300b005132447d110mr1238559lfr.62.1709291403428;
        Fri, 01 Mar 2024 03:10:03 -0800 (PST)
Received: from kepler.redhat.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id b20-20020a05600c4e1400b00412cad66f8fsm490264wmq.44.2024.03.01.03.10.02
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
Subject: [PATCH 7/7] sched/balancing: Update comments in 'struct sg_lb_stats' and 'struct sd_lb_stats'
Date: Fri,  1 Mar 2024 12:09:51 +0100
Message-Id: <20240301110951.3707367-8-mingo@kernel.org>
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

- Align for readability
- Capitalize consistently

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 99495c93e094..4e58b9334d88 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9433,17 +9433,17 @@ static void update_blocked_averages(int cpu)
 /********** Helpers for find_busiest_group ************************/
 
 /*
- * sg_lb_stats - stats of a sched_group required for load_balancing
+ * sg_lb_stats - stats of a sched_group required for load-balancing:
  */
 struct sg_lb_stats {
-	unsigned long avg_load;			/* Avg load across the CPUs of the group */
-	unsigned long group_load;		/* Total load over the CPUs of the group */
-	unsigned long group_capacity;
-	unsigned long group_util;		/* Total utilization over the CPUs of the group */
+	unsigned long avg_load;			/* Avg load            over the CPUs of the group */
+	unsigned long group_load;		/* Total load          over the CPUs of the group */
+	unsigned long group_capacity;		/* Capacity            over the CPUs of the group */
+	unsigned long group_util;		/* Total utilization   over the CPUs of the group */
 	unsigned long group_runnable;		/* Total runnable time over the CPUs of the group */
-	unsigned int sum_nr_running;		/* Nr of tasks running in the group */
+	unsigned int sum_nr_running;		/* Nr of all tasks running in the group */
 	unsigned int sum_h_nr_running;		/* Nr of CFS tasks running in the group */
-	unsigned int idle_cpus;
+	unsigned int idle_cpus;                 /* Nr of idle CPUs         in the group */
 	unsigned int group_weight;
 	enum group_type group_type;
 	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
@@ -9456,8 +9456,7 @@ struct sg_lb_stats {
 };
 
 /*
- * sd_lb_stats - Structure to store the statistics of a sched_domain
- *		 during load balancing.
+ * sd_lb_stats - stats of a sched_domain required for load-balancing:
  */
 struct sd_lb_stats {
 	struct sched_group *busiest;		/* Busiest group in this sd */
@@ -9465,7 +9464,7 @@ struct sd_lb_stats {
 	unsigned long total_load;		/* Total load of all groups in sd */
 	unsigned long total_capacity;		/* Total capacity of all groups in sd */
 	unsigned long avg_load;			/* Average load across all groups in sd */
-	unsigned int prefer_sibling;		/* tasks should go to sibling first */
+	unsigned int prefer_sibling;		/* Tasks should go to sibling first */
 
 	struct sg_lb_stats busiest_stat;	/* Statistics of the busiest group */
 	struct sg_lb_stats local_stat;		/* Statistics of the local group */
-- 
2.40.1


