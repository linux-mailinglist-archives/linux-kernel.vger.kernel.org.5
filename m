Return-Path: <linux-kernel+bounces-96916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24A887630F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF821F21E97
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2376155E60;
	Fri,  8 Mar 2024 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oumpr25P"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5F95A114
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896724; cv=none; b=FPG26OFLGEiDyLAvOnEntjr4rZocx+DuXXZWYGZ3azSds8KBvjQ/+2wkQTrfp7KEbUDSp2P3A3A9u6OCNOrjlTTT5mqErKF2kud6GebBys6AZdDOMZ5OlU6Qa3deYDGo17o8qBcQZXExi6rUtD5KcoCySOEjYMag9Rjh0ffRKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896724; c=relaxed/simple;
	bh=nWAdE3F7BRDWOKYU1dGhEL/Gt6Pz2HaqkBWrYqkdxp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y5m7olh09pafXHkEkM98LipgSNoLd9OXsxsmFDNnDWmH76KRl55756aRH+u2akGEPy3yzYviWvDvBw/JD+4i++HqXCiWToEKgB3HGzqEcP9Ikn99x6RR/ac17eR9/9Deb2zi7kvdQwuMsjv2mJh7sZot3frOf5TSA09oNGfxNGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oumpr25P; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e742ca96bso845907f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709896721; x=1710501521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaLG7QIIZcpDrCdrmpaWSCsV5vJM+SYzNheYz5z39lw=;
        b=Oumpr25PvoZJ7/A7adE7BKPAB12VmQJLHD8zrz5TLIAXgC4ZpFarUdtAVL5dNPxRki
         Nsd1geKvK/PRs6m2ZRICvfEXjWZbZrqSQVZWL2+Pte35uFQPFgZXYYKILDS53Pduw7Cv
         cX5Sr3nKEps4wduUtzYSsvOW6jW7iAqZPMiAWyBHO4n6siAqdwUzAoGmJ2uoax+8uNIO
         lE4F2qkCIK4M2ND7jKA1MMiP4XLkwpIUwx1GISUP0GC9Y0asmlnYS8f4FKWlHmkXqRbt
         YYzrezUtoi97kcIT9qpMiv9SSbOzYPRV7Oty9BLt5Lqe/vqqJDlRHWvd+FB1aMAm2yEJ
         KtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896721; x=1710501521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FaLG7QIIZcpDrCdrmpaWSCsV5vJM+SYzNheYz5z39lw=;
        b=RXFlldWwl8iIwljKjWaWcucaOIOY5cWgo/adAo7JEHQnMhLs+0s6NuiRYrsQMipzvK
         A+cPITz6rEXtrFQs9z1lFuQZbINlZNw597LkYDdq9tSeVcsL3xc+avx/Kcz4qXYiiKv0
         UsISxKRwXfxZhxyEU8ANnfh5pmNxO9DK3KpIFT9wG6Ghvp1uqC5VrX+gzMY1pHff10XR
         XH8vGGFbhxbEp720EMFY3AcZtkBAn3H/EOnlGCvABBOaFiwVrO9LhrzAYmU4ruwz4vsO
         +8LWoXQNkJPPtMttlrzSu4ZmojLptflHsdAN6uOLdBqL4o92nvQIXBwlxGnqEQ9o/3vp
         WfBw==
X-Gm-Message-State: AOJu0YxMWmh60oaBN4bPdiylFTzI4S2vXQ8RMwFVkQvTJ2ZuCH7r++Ok
	mSoJGgwUtSYM9gydR/v0LOqKyI8t7JdMReecn6M1k5EdHEAS3q345eFB67piU5g=
X-Google-Smtp-Source: AGHT+IFXgOHB5yw+2wOuJyhg4nDRg4hMhK9Enpf8qfhH2sELiIf/nEuwlKOzbxqiDy6pzhYO9nwu4Q==
X-Received: by 2002:adf:cc06:0:b0:33e:6ac:691b with SMTP id x6-20020adfcc06000000b0033e06ac691bmr15139587wrh.9.1709896720464;
        Fri, 08 Mar 2024 03:18:40 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id v9-20020adfedc9000000b0033e712b1d9bsm2523884wro.77.2024.03.08.03.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:18:39 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 08/13] sched/balancing: Rename find_busiest_group() => sched_balance_find_src_group()
Date: Fri,  8 Mar 2024 12:18:14 +0100
Message-Id: <20240308111819.1101550-9-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240308111819.1101550-1-mingo@kernel.org>
References: <20240308111819.1101550-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make two naming changes:

1)
   Standardize scheduler load-balancing function names on the
   sched_balance_() prefix.

2)

   Similar to find_busiest_queue(), the find_busiest_group() naming
   has become a bit of a misnomer: the 'busiest' qualifier to this
   function was historically correct but in the current code
   in quite a few cases we will not pick the 'busiest' group - but the best
   (possible) group we can balance from based on a complex set of
   constraints.

So name it a bit more neutrally, similar to the 'src/dst' nomenclature
we are already using when moving tasks between runqueues, and also
use the sched_balance_ prefix: sched_balance_find_src_group().

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1cd9a18b35e0..96a81b2fa281 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9430,7 +9430,7 @@ static void update_blocked_averages(int cpu)
 	rq_unlock_irqrestore(rq, &rf);
 }
 
-/********** Helpers for find_busiest_group ************************/
+/********** Helpers for sched_balance_find_src_group ************************/
 
 /*
  * sg_lb_stats - stats of a sched_group required for load-balancing:
@@ -9637,7 +9637,7 @@ static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
  *
  * When this is so detected; this group becomes a candidate for busiest; see
  * update_sd_pick_busiest(). And calculate_imbalance() and
- * find_busiest_group() avoid some of the usual balance conditions to allow it
+ * sched_balance_find_src_group() avoid some of the usual balance conditions to allow it
  * to create an effective group imbalance.
  *
  * This is a somewhat tricky proposition since the next run might not find the
@@ -10788,7 +10788,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	) / SCHED_CAPACITY_SCALE;
 }
 
-/******* find_busiest_group() helpers end here *********************/
+/******* sched_balance_find_src_group() helpers end here *********************/
 
 /*
  * Decision matrix according to the local and busiest group type:
@@ -10811,7 +10811,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
  */
 
 /**
- * find_busiest_group - Returns the busiest group within the sched_domain
+ * sched_balance_find_src_group - Returns the busiest group within the sched_domain
  * if there is an imbalance.
  * @env: The load balancing environment.
  *
@@ -10820,7 +10820,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
  *
  * Return:	- The busiest group if imbalance exists.
  */
-static struct sched_group *find_busiest_group(struct lb_env *env)
+static struct sched_group *sched_balance_find_src_group(struct lb_env *env)
 {
 	struct sg_lb_stats *local, *busiest;
 	struct sd_lb_stats sds;
@@ -11274,7 +11274,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 		goto out_balanced;
 	}
 
-	group = find_busiest_group(&env);
+	group = sched_balance_find_src_group(&env);
 	if (!group) {
 		schedstat_inc(sd->lb_nobusyg[idle]);
 		goto out_balanced;
@@ -11298,7 +11298,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 	env.flags |= LBF_ALL_PINNED;
 	if (busiest->nr_running > 1) {
 		/*
-		 * Attempt to move tasks. If find_busiest_group has found
+		 * Attempt to move tasks. If sched_balance_find_src_group has found
 		 * an imbalance but busiest->nr_running <= 1, the group is
 		 * still unbalanced. ld_moved simply stays zero, so it is
 		 * correctly treated as an imbalance.
-- 
2.40.1


