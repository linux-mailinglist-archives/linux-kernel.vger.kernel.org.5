Return-Path: <linux-kernel+bounces-96917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F84876310
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD58282C69
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99CF5D478;
	Fri,  8 Mar 2024 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBxLU06K"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A65A7B4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896725; cv=none; b=oqOP3Mu37LI7iFRX2TtkWx/rFuzH4fd+pxk207x7TmDxAfbCOB+2QfFT32abTvebcN/vjpS7a0lZt3GK52K+mi9lUmNywdUXqfJ/P8aYABM97lKM7IYXS44xayd92lUZL7pRzy5FTlASek9ImQCsNR1XCjSBRSYUYTJJpOKyzdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896725; c=relaxed/simple;
	bh=XOlHRZpNJzJOGTfiYeMtDAQDbibFUKlq+BfLB1rIyVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rSIes/+TttJdH9CuliAZrUo5RzbtIBpJUQxJBoWGVIM0udeCsKL+CLdHcmEXVjgtB+vFRfrOu3joi30fUkiI4DSYQNABAfs6poo+INkAvTBURda2qzZUuRlOisflFTrTk5DG8B1ag8jr8P2byyHVlq/fJ5QKsAfiS0QZlKRfBGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBxLU06K; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d36736d4eso1327781f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709896722; x=1710501522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+S+y+K7L4kzFDSnrRYytcE4IP6j1WnNg2t2ez9J4+8=;
        b=QBxLU06KXeAwxDRQ3aw/7HAC/OnnRm+NYWB1Nob26V32lM8Qy1EovI0/0tUWKARsF5
         NYAuUdrJ2991Xm9NUibT1Iv1cZ1pf+MrNthkelRRpenoF+rZ2B3hGIWrVIPYErgLCEUD
         YiM60A559sKFv+/hfcIz5rGa9Aw2oj0BxFYJDUS4wjsB73VVDhORu9/l0BZzFvS4unST
         rkOf0/acv6RtC7dJzzExK8fFRRLgHCys/aA2xRqO4l0gnpIcv3KKnERH9fS5dMXWQ2Ji
         st/P+2xNaIYvysmkPUj/SxpLHN3LpQkVhPTdQTMrgMe4SQXuFp86v1ydR6H0076H/L+R
         agjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896722; x=1710501522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u+S+y+K7L4kzFDSnrRYytcE4IP6j1WnNg2t2ez9J4+8=;
        b=urL06Jcci1d7D5eUbQwsKooLUwW/qexCn41exOKjl2zdWQyEtWra+gNKQQFXJiOqHC
         pMlY/fZx/kimMhJLFzthi5u3Fd+M3f8nrHVKlAQ7Fsw2GeE4rjN/BDQj1RcGdHhjXfv4
         bnR5SBHt/7d0yh8iSxTt7px6bsYvZUfltMkukfBKt3bGvAUm4WNKMxOAoVNCyyV2pjz9
         z21vFrCs6iStKyAUP8bjvGwn3XN+pViaXh/BaayT9XBzb8XSjVNyXa+spes6qipSVR+g
         gjPNhoNfOWGfo1gUnQgFatPF6r8j3vRu7/ix0sH895TWC9MlYhNLC50mtB0+lywj7E9n
         LLDA==
X-Gm-Message-State: AOJu0Yw7qMgmw3W8HpDxZ0gLQdQayHe7RiFVkBXvnASv0J4HCbvQmktK
	8VnUUlbfSCnGnCXyBNvxeCNKykvtDVc6EE+gJDP9lMvTTSnTVkq5UGcU8Pz/l38=
X-Google-Smtp-Source: AGHT+IGJ/u2kq/nAqCIem9ztFPRflJ6RtzgIlNhFNk3aSHzFqjhVYTzgNLoh7hT0ECLBgwX73TMiHw==
X-Received: by 2002:adf:dd8a:0:b0:33e:7938:9e65 with SMTP id x10-20020adfdd8a000000b0033e79389e65mr605299wrl.18.1709896721557;
        Fri, 08 Mar 2024 03:18:41 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id v9-20020adfedc9000000b0033e712b1d9bsm2523884wro.77.2024.03.08.03.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:18:41 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 09/13] sched/balancing: Rename update_blocked_averages() => sched_balance_update_blocked_averages()
Date: Fri,  8 Mar 2024 12:18:15 +0100
Message-Id: <20240308111819.1101550-10-mingo@kernel.org>
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

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 8 ++++----
 kernel/sched/pelt.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 96a81b2fa281..95f7092043f3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9411,7 +9411,7 @@ static unsigned long task_h_load(struct task_struct *p)
 }
 #endif
 
-static void update_blocked_averages(int cpu)
+static void sched_balance_update_blocked_averages(int cpu)
 {
 	bool decayed = false, done = true;
 	struct rq *rq = cpu_rq(cpu);
@@ -12079,7 +12079,7 @@ static bool update_nohz_stats(struct rq *rq)
 	if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
 		return true;
 
-	update_blocked_averages(cpu);
+	sched_balance_update_blocked_averages(cpu);
 
 	return rq->has_blocked_load;
 }
@@ -12339,7 +12339,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	raw_spin_rq_unlock(this_rq);
 
 	t0 = sched_clock_cpu(this_cpu);
-	update_blocked_averages(this_cpu);
+	sched_balance_update_blocked_averages(this_cpu);
 
 	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {
@@ -12431,7 +12431,7 @@ static __latent_entropy void sched_balance_softirq(struct softirq_action *h)
 		return;
 
 	/* normal load balance */
-	update_blocked_averages(this_rq->cpu);
+	sched_balance_update_blocked_averages(this_rq->cpu);
 	sched_balance_domains(this_rq, idle);
 }
 
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 63b6cf898220..f80955ecdce6 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -209,7 +209,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	 * This means that weight will be 0 but not running for a sched_entity
 	 * but also for a cfs_rq if the latter becomes idle. As an example,
 	 * this happens during idle_balance() which calls
-	 * update_blocked_averages().
+	 * sched_balance_update_blocked_averages().
 	 *
 	 * Also see the comment in accumulate_sum().
 	 */
-- 
2.40.1


