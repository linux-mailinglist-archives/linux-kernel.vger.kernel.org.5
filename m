Return-Path: <linux-kernel+bounces-96882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F79876291
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22AC71F24CDD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837C05646C;
	Fri,  8 Mar 2024 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPYPwYkW"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07F855E4A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895559; cv=none; b=YCgv0EM3m3DqPr1HHJ01zX3Fn6/9D3JM30kJnISNQMkcI1aVzG8gQIA+iLpHMH1M1mw2ndWWOK5UGx/JYn9rEINRnh17/hzxZRc82MSVLBi/b6+yVjVZ3W6wZPkGCHfw/fXAAsGa673Y+YJiDDN5QRB/LKJSvY+adVtwaWARAzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895559; c=relaxed/simple;
	bh=P89bbgCmoIwRYPsfqIuTxmk7ilKR2Yxvp8a3Scsu+m8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EAKUDmxsVmqZSEpKI0xPqcr3ObRi9YxxJmaMwGfjWy5Im5fsFDXBv0sB406G/0cqR1Ataz0eFA9Vq3ww7XiWxSS9VyiL+qyRNgDaqQ7g5Pkw+hxlAPrU5iZGqQPFk8VZeLKP2zoIlcEbsA+S9h08lLhv28p1kdthph1sPg78JsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPYPwYkW; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5132010e5d1so2677991e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709895556; x=1710500356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geif82Q8kuw7lCFHvfmZ/kVxJJq75wsWf5PRSM8TZn8=;
        b=cPYPwYkWJtxuGRak0smxx5lwBKtUuo3oVvPPCS8tWwhMhwwB1xqICEqWRoXoKFkKtg
         i4NvI2mg7y3jRykCr5ONP5LQhCV5K+MiuWMsLXCsPTba3DQY9c/DBd+KU/7MsFiWCF4M
         7fcnAejkHKP34MgQhY6BDeNfLNZFdRZJFRmnWixi+7X+w+RFQLx9pKpRfaQMoAQ2NYYf
         CnOossK7SV7qjFE+2QSJfEFit3J2H4rcbJ6FseO5Hi4DsjxhSQlqc3GuWQ5PiVjuzioU
         R3BOi8AdKp08CzqbA9kWYkxQLaNuSx6AYYJPrhFmKlb8lCI8oh38Ok71TO5wcZc1QF9O
         QiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709895556; x=1710500356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=geif82Q8kuw7lCFHvfmZ/kVxJJq75wsWf5PRSM8TZn8=;
        b=gh/dTB2Bu1IpPWXrRF/z9VqFevcahpgMs0qlczksurFWQP+x0w+Bs62lwplt+STrFr
         2+rQg6xaRMPoj4JKHSWAIaWLsAy5GH5RiEQvzyfpsVA3ITDK8fdK2KOqZkvrBQ8KCSPE
         NrE084rDUnAPM2ECX0P48kGE04h/xVc4LA/T3spx+FBjeZV8SXhwQj8NKA/IIuhFY5AI
         39mPpr7T1d6ZkX3vbIgYmoXaD7qyUcpDxzLcEP/Inhoduy9sOWcMz+yrs+XS9ZF2b+xY
         vPdbgyDKx5YEX+Sr5hJckVRwt6BoN/fT9pj22+KRMpq9mg9O6yGW8KfLZb8dPJYFHP7J
         rFhQ==
X-Gm-Message-State: AOJu0YzM97OCh00vbBI125p/1O2Jie2iMsMyHvjFijuTZApqPUjYtxqM
	ZP9juVis19YJxrwZR8+538CJXfae0CZVFxiyp5BMqbfbl78LFwzHGhBecgxBntg=
X-Google-Smtp-Source: AGHT+IHQ+tYPIIVHxAV8VyCd6JmA99ARRA94O1Vw78plqTCfN0Zb8vH25BaOZ/8g6jw/oxzdc2fpyA==
X-Received: by 2002:a05:6512:e94:b0:512:da6d:23aa with SMTP id bi20-20020a0565120e9400b00512da6d23aamr3716925lfb.67.1709895555429;
        Fri, 08 Mar 2024 02:59:15 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b00412f679bae1sm5632382wmq.26.2024.03.08.02.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:59:14 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 01/10] sched/balancing: Switch the 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t sched_balance_running' flag
Date: Fri,  8 Mar 2024 11:58:52 +0100
Message-Id: <20240308105901.1096078-2-mingo@kernel.org>
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
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6a16129f9a5c..2ef89b36aed1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11633,7 +11633,20 @@ static int active_load_balance_cpu_stop(void *data)
 	return 0;
 }
 
-static DEFINE_SPINLOCK(balancing);
+/*
+ * This flag serializes load-balancing passes over large domains
+ * (above the NODE topology level) - only one load-balancing instance
+ * may run at a time, to reduce overhead on very large systems with
+ * lots of CPUs and large NUMA distances.
+ *
+ * - Note that load-balancing passes triggered while another one
+ *   is executing are skipped and not re-tried.
+ *
+ * - Also note that this does not serialize rebalance_domains()
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


