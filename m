Return-Path: <linux-kernel+bounces-10487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9538681D4F5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5067D1F21480
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A30DFBE8;
	Sat, 23 Dec 2023 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jipBEsw2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a7otgDy5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01DCFC03;
	Sat, 23 Dec 2023 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 23 Dec 2023 16:09:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703347789;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bT6h0tGdiOTZ3K5/IhOutd8TItu/QUf8/c+iv/bvYKQ=;
	b=jipBEsw2xZ9YofDD8+6CrKiJwWABMlDR8SJPq78Q2hBZJKLc/TyRUdqMb782SKUG6acF6l
	2Xb1IvW3OD8wLs0W5620pi/fZbmTiDELOiwbgdW2mzsFPNPP95jmDKPgxbpPb66nLr8Iux
	orxOyVkveMSxM3daCGCNF1yEdnPuED/IausmOe/aMP4TSQxNUVFNwxNs2ckDELdQKhNjH/
	CErRcPqTJwySnYPVb6xOKP/PZChPa2TyKzUSeQflGz7KY72yCemhOCK96hJQzj3ISrycPY
	IapCln2HhUSIqzoTOUaFX1IdtrIgP1031dyTuRqh6caRMTVTtCsFPaTFKoEA6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703347789;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bT6h0tGdiOTZ3K5/IhOutd8TItu/QUf8/c+iv/bvYKQ=;
	b=a7otgDy55+CoGiuCBRYNXxxCob1f647k060+fa6cX7/qUc7T6D66aS6AGURJAOFbzxkLF4
	Ig6u4KMGHaxbRYCg==
From: "tip-bot2 for Pierre Gondois" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Use all little CPUs for CPU-bound workloads
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Qais Yousef <qyousef@layalina.io>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231206090043.634697-1-pierre.gondois@arm.com>
References: <20231206090043.634697-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170334778858.398.14876709177297398482.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3af7524b14198f5159a86692d57a9f28ec9375ce
Gitweb:        https://git.kernel.org/tip/3af7524b14198f5159a86692d57a9f28ec9375ce
Author:        Pierre Gondois <pierre.gondois@arm.com>
AuthorDate:    Wed, 06 Dec 2023 10:00:43 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 23 Dec 2023 16:06:36 +01:00

sched/fair: Use all little CPUs for CPU-bound workloads

Running N CPU-bound tasks on an N CPUs platform:

- with asymmetric CPU capacity

- not being a DynamIq system (i.e. having a PKG level sched domain
  without the SD_SHARE_PKG_RESOURCES flag set)

.. might result in a task placement where two tasks run on a big CPU
and none on a little CPU. This placement could be more optimal by
using all CPUs.

Testing platform:

  Juno-r2:
    - 2 big CPUs (1-2), maximum capacity of 1024
    - 4 little CPUs (0,3-5), maximum capacity of 383

Testing workload ([1]):

  Spawn 6 CPU-bound tasks. During the first 100ms (step 1), each tasks
  is affine to a CPU, except for:

    - one little CPU which is left idle.
    - one big CPU which has 2 tasks affine.

  After the 100ms (step 2), remove the cpumask affinity.

Behavior before the patch:

  During step 2, the load balancer running from the idle CPU tags sched
  domains as:

  - little CPUs: 'group_has_spare'. Cf. group_has_capacity() and
    group_is_overloaded(), 3 CPU-bound tasks run on a 4 CPUs
    sched-domain, and the idle CPU provides enough spare capacity
    regarding the imbalance_pct

  - big CPUs: 'group_overloaded'. Indeed, 3 tasks run on a 2 CPUs
    sched-domain, so the following path is used:

      group_is_overloaded()
      \-if (sgs->sum_nr_running <= sgs->group_weight) return true;

    The following path which would change the migration type to
    'migrate_task' is not taken:

      calculate_imbalance()
      \-if (env->idle != CPU_NOT_IDLE && env->imbalance == 0)

    as the local group has some spare capacity, so the imbalance
    is not 0.

  The migration type requested is 'migrate_util' and the busiest
  runqueue is the big CPU's runqueue having 2 tasks (each having a
  utilization of 512). The idle little CPU cannot pull one of these
  task as its capacity is too small for the task. The following path
  is used:

   detach_tasks()
   \-case migrate_util:
     \-if (util > env->imbalance) goto next;

After the patch:

As the number of failed balancing attempts grows (with
'nr_balance_failed'), progressively make it easier to migrate
a big task to the idling little CPU. A similar mechanism is
used for the 'migrate_load' migration type.

Improvement:

Running the testing workload [1] with the step 2 representing
a ~10s load for a big CPU:

  Before patch: ~19.3s
  After patch:  ~18s (-6.7%)

Similar issue reported at:

  https://lore.kernel.org/lkml/20230716014125.139577-1-qyousef@layalina.io/

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Qais Yousef <qyousef@layalina.io>
Link: https://lore.kernel.org/r/20231206090043.634697-1-pierre.gondois@arm.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 823dd76..1d561b5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9071,7 +9071,7 @@ static int detach_tasks(struct lb_env *env)
 		case migrate_util:
 			util = task_util_est(p);
 
-			if (util > env->imbalance)
+			if (shr_bound(util, env->sd->nr_balance_failed) > env->imbalance)
 				goto next;
 
 			env->imbalance -= util;

