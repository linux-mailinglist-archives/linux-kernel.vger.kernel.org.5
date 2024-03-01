Return-Path: <linux-kernel+bounces-88298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7E886DFD7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABC72871CF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7DE6CDA0;
	Fri,  1 Mar 2024 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbFKmpd4"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFBD6BFC9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291401; cv=none; b=Sypj9bUhraZG1YGkft5fHIoTSXZelUYzb5JRPfiZX/dT5CaNQ/H0JIEJ7jennwXBTMHSpBM8jIVKvVEtGyEkeorvsBDkniw86umk5+OY/p3+v2JcCa+G6giSkOuuf7gQEURvxBpAb6AILmadrfyZGFNdoyN4nDxzi995Qoo6tFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291401; c=relaxed/simple;
	bh=NL0X0BOz7ZVywJyCc8r0y4XYQQ5/b+5FbeyYJW/2ZGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CmiTcpc10ZG68EMACXkMYnre6mc6wOS0/Q+slAcPxFbsAGsxwbyLUS/vBtPo1pj4T8BS1tQqHYF5SpFH6Sp1TNc9SwUgiar+/ZXXFuPMqcY5O5xDmpIrWJLOkUPBJxGJj/UrGYLdnKW2xplYPKG+31dcVcFI/Yqq5d9iBXr9R/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbFKmpd4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412a9e9c776so18625105e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709291397; x=1709896197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRfa5V1eCtQKvE35o3iYx+TIdATo30V6vBwFI6v4hE8=;
        b=TbFKmpd4+yaZTeo1bSuDisQWTqe7TJoUlSZeQ901Mc12vtk4b9UvMUypBBQZxOG28P
         uQuKIKQOl1RvI3kHa9QDez1jo8HF1CX58MBRJJWIyLI41QACZKi+wWuKrPtY/kI3Puso
         uofkgtS66ATQEZNkF4nlPcoq72O16E9aH/CH3Dms6L3fsE5IKkY6RnwCz9klYXUOB5JM
         mSmYx5UrM0Sw/JMjywxMN8X0hTiHMNvSK2ffvuJrCVPboQgM9X6EmBeDgYf5BpebWlHQ
         1epxAKhEOTH1vHaIMFctj2OCUIGpW5EhpYy/hItt4c9Xmw57xjVV/TcA5L13Y10NpB0w
         nmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709291397; x=1709896197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PRfa5V1eCtQKvE35o3iYx+TIdATo30V6vBwFI6v4hE8=;
        b=mzpZBbkdeZTQXeMYvjMdffjlnhwEg+h5GRS3SduqVksHCzgul9WV0Me6gpdajR3uJc
         HTFqjwF8a4JFmvPidLXRq6d6nBVO4BmpmErXvu/lA4uK2OmdPhxfVwL/qN5las+yEB2B
         rBVDK5ImZKBFpEbFudk2m1ON/9fO/UyzUyJUemXGde5y300hUQiFybhVRqxINzwVdc7J
         KPoVHznYafL8p7ieKXT7n+I8gAk9y90jUfAvonSHtf8pnNYI7xPPQZWDdYVu0MlmzHPQ
         S3TgrlRI0iZ21vCbIlO6gh0h65L9P5gFyub6FXVlEdgxF+QgRkyXwh8LCDowlKbf6/91
         V1yw==
X-Gm-Message-State: AOJu0Yw1Jf1AeXsMFlfV75OcUu4xQmDMnRoWavBWKPczqNfT5v16sy7S
	IfiTcdG+BBHkbR5zNBerz2qDd5o3SHSY55+ptlINOXXHl39Gliva0EPa9/1E8qM=
X-Google-Smtp-Source: AGHT+IGiJ2USHyCH/RfQda37Ym4O9RsMrvKdzLVxNbbICBgCvKkfRS4AATBIZsdjCzTrO1XyHeiBRA==
X-Received: by 2002:a05:600c:1c28:b0:412:b6a7:ecf1 with SMTP id j40-20020a05600c1c2800b00412b6a7ecf1mr1507519wms.0.1709291397207;
        Fri, 01 Mar 2024 03:09:57 -0800 (PST)
Received: from kepler.redhat.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id b20-20020a05600c4e1400b00412cad66f8fsm490264wmq.44.2024.03.01.03.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:09:56 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 1/7] sched/balancing: Switch the 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t sched_balance_running' flag
Date: Fri,  1 Mar 2024 12:09:45 +0100
Message-Id: <20240301110951.3707367-2-mingo@kernel.org>
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

The 'balancing' spinlock added in:

  08c183f31bdb ("[PATCH] sched: add option to serialize load balancing")

.. is taken when the SD_SERIALIZE flag is set in a domain, but in reality it
is a glorified global atomic flag serializing the load-balancing of
those domains.

It doesn't have any explicit locking semantics per se: we just
spin_trylock() it.

Turn it into a ... global atomic flag. This makes it more
clear what is going on here, and reduces overhead and code
size a bit:

  # kernel/sched/fair.o: [x86-64 defconfig]

     text	   data	    bss	    dec	    hex	filename
    60730	   2721	    104	  63555	   f843	fair.o.before
    60718	   2721	    104	  63543	   f837	fair.o.after

Also document the flag a bit.

No change in functionality intended.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6a16129f9a5c..64ae3d8dc93b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11633,7 +11633,20 @@ static int active_load_balance_cpu_stop(void *data)
 	return 0;
 }
 
-static DEFINE_SPINLOCK(balancing);
+/*
+ * This flag serializes load-balancing passes over large domains
+ * (such as SD_NUMA) - only once load-balancing instance may run
+ * at a time, to reduce overhead on very large systems with lots
+ * of CPUs and large NUMA distances.
+ *
+ * - Note that load-balancing passes triggered while another one
+ *   is executing are skipped and not re-tried.
+ *
+ * - Also note that this does not serialize sched_balance_domains()
+ *   execution, as non-SD_SERIALIZE domains will still be
+ *   load-balanced in parallel.
+ */
+static atomic_t sched_balance_running = ATOMIC_INIT(0);
 
 /*
  * Scale the max load_balance interval with the number of CPUs in the system.
@@ -11711,7 +11724,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 
 		need_serialize = sd->flags & SD_SERIALIZE;
 		if (need_serialize) {
-			if (!spin_trylock(&balancing))
+			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
 				goto out;
 		}
 
@@ -11729,7 +11742,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 			interval = get_sd_balance_interval(sd, busy);
 		}
 		if (need_serialize)
-			spin_unlock(&balancing);
+			atomic_set_release(&sched_balance_running, 0);
 out:
 		if (time_after(next_balance, sd->last_balance + interval)) {
 			next_balance = sd->last_balance + interval;
-- 
2.40.1


