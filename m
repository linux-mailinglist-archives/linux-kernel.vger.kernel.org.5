Return-Path: <linux-kernel+bounces-96921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47606876318
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031F52828D7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501025F56A;
	Fri,  8 Mar 2024 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRg32m8F"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E145E066
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896729; cv=none; b=pfQhgbcPajTYX+xmHkufWjLixbzomK+HQfUim/4TpVVxbJdgZ6a3LZEYYYmwh37dVe5WBDpAqujJDoq6ymIzQfya+f+iXxWNTEfJGllqck3qBIHqmlIjaxEKsXqggP5Z/mPAB/wRzr68aoTzy3Qy2RN1bFXI2waJ9ShSI5ccN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896729; c=relaxed/simple;
	bh=3TPeEYMp0yyN8WNSLogtpkRpVWIYbmF4zEhIzBhjpnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DUxnzJHkTQrHuTMADBSPFMAXYkaDWEE4NBSTL5Q2phAeu/9KK65xUHjNgkbetaI1Hw5KEWluyarzCv1nJ2g5ahenq2Qv1hJTPFh6lb6UkIQONeKpwMwI8ykrxn7GIwKqa+Tjpxt6S/zTpGRV7jUMaZ23ROJQykzJY59mUvIrr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRg32m8F; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e4c676f0aso1260423f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709896726; x=1710501526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOvd7yJCsrm2lekArZtftwEXy7qvg7yRQDw3i8wVqcM=;
        b=eRg32m8FL4Xp9pQ0UVTsmOsgohtf4n80odaEbSJJjay7VUT7XoRLiXSM5VwraM3wHX
         3NBPqmuJZpArMjjw4DroMJoaG+xZ/NdH304w7KHaIznDRl2uvzNB4okVSpuZ6aTLFGIT
         QLr33bvc9KlCIHYN+OwsS83rBTjDT3owC3kqLYGz//ZixSw7YRys9aSlZD24Aqn7GBBk
         Pq44MT0ys9722Z6cPFfNTV1cgVsFir/vNqcwkkSL5IX7TABcxG2M9AY06R8kBv6eG4ZI
         uGQbkHi2BBMRyPA8IIjAJQJ7Jy09sVTKE+eSbkd52t3N/+zizwfp6wxgd9e2MoaVw6jB
         TbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896726; x=1710501526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JOvd7yJCsrm2lekArZtftwEXy7qvg7yRQDw3i8wVqcM=;
        b=cUQErTG4bqrwo7rIikbFjI3TBJEHI8BjxVgYKBhtINKhdbjEYCe//h0kknc3KRwfhx
         23XJyRIOz3mxfwAUJ1hsgnuekr1Wjti3NNl/RePIzt6U7+b/ANuyJPGeSD4JnOjp1oBg
         Xkh54en8fPcNyHCuwa9muej+lhbO0zE0C7nxxTlqDZBsZRNgk44i0GYP7w0hoi+a7/6P
         tkf/+kS/NZHDGqGQiczqB8H6aa919u/8RFuXaH2PcsFSf+MJj4JESHiCpUg3YzpB7vzi
         Ki6hqDmT2Wr+SY+QFyAjJw+DVOzvDgGfm9NNttX0ruNXjzAD1AhPX8es+o3x8Y9J1PTn
         sjnA==
X-Gm-Message-State: AOJu0YxQxZoVnp/paOAAUk7CgxoEgHohdy8VcMq88/bfExzkbeG/2y/x
	BdU/0kdTlH8aui8KejBIT6RtTVsAOsTQ9vnDEy0tR631dkI9jf6TPj0/IRWCmxg=
X-Google-Smtp-Source: AGHT+IGpBp7GqhUTGDTINFIfxuSQRWKuUPNeqRuDFXz548rHE6K1eT/bIN1DSn6d+ChVRcXdkEYfWQ==
X-Received: by 2002:a5d:6603:0:b0:33e:3b95:d80c with SMTP id n3-20020a5d6603000000b0033e3b95d80cmr10402445wru.29.1709896725738;
        Fri, 08 Mar 2024 03:18:45 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id v9-20020adfedc9000000b0033e712b1d9bsm2523884wro.77.2024.03.08.03.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:18:45 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 13/13] sched/balancing: Rename find_idlest_cpu() => sched_balance_find_dst_cpu()
Date: Fri,  8 Mar 2024 12:18:19 +0100
Message-Id: <20240308111819.1101550-14-mingo@kernel.org>
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

Standardize scheduler load-balancing function names on the
sched_balance_() prefix.

Also use 'dst' instead of 'idlest', because it's not really
true that we return the 'idlest' group or CPU, we sort by
idle-exit latency and only return the idlest CPUs from the
lowest-latency set of CPUs.

The true 'idlest' CPUs often remain idle for a long time
and are never returned as long as the system is under-loaded.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d0c3a091d7d1..4b3c4a181a91 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7160,7 +7160,7 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
 	return shallowest_idle_cpu != -1 ? shallowest_idle_cpu : least_loaded_cpu;
 }
 
-static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p,
+static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct task_struct *p,
 				  int cpu, int prev_cpu, int sd_flag)
 {
 	int new_cpu = cpu;
@@ -7936,7 +7936,7 @@ compute_energy(struct energy_env *eenv, struct perf_domain *pd,
  * NOTE: Forkees are not accepted in the energy-aware wake-up path because
  * they don't have any useful utilization data yet and it's not possible to
  * forecast their impact on energy consumption. Consequently, they will be
- * placed by find_idlest_cpu() on the least loaded CPU, which might turn out
+ * placed by sched_balance_find_dst_cpu() on the least loaded CPU, which might turn out
  * to be energy-inefficient in some use-cases. The alternative would be to
  * bias new tasks towards specific types of CPUs first, or to try to infer
  * their util_avg from the parent task, but those heuristics could hurt
@@ -8201,7 +8201,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 
 	if (unlikely(sd)) {
 		/* Slow path */
-		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
+		new_cpu = sched_balance_find_dst_cpu(sd, p, cpu, prev_cpu, sd_flag);
 	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
 		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
-- 
2.40.1


