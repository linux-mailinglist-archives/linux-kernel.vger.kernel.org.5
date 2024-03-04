Return-Path: <linux-kernel+bounces-90346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D57286FDF5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70D41F21973
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF606224EE;
	Mon,  4 Mar 2024 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQJ4W/fa"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEF0249F1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545727; cv=none; b=SCwQtEiyNpPmmB0j7DR6WNE1HoAB/kwGxI1KIfn8vcawh4VzHQh+DweQdJVsJpJrDHqovpXkB50l1x5YTLhaeYcFjFEwFVBbEb4E2UBgTGgkNQd5r1r1cG3ZTOoX27Z/fccjY0s2XAg+qSZlW8uUPrGk9u2zwvT8uRmgsEwa2Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545727; c=relaxed/simple;
	bh=NL0X0BOz7ZVywJyCc8r0y4XYQQ5/b+5FbeyYJW/2ZGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tqvt8FKmfs1rrn1wLI7/bZaQ1OFdmWkcVXcY9bvTRwAsXLmsmAEkUPyGMOuAUIiK1KaAtcm/g8X9gK0MoLquykEVNvp2Li+OIorreFIsVhIxofN7u4kMhcoGEueejrkqtkscHBTP/aBFAJwBh2fYdZ2blut8wbLfEd8k3I8TVRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQJ4W/fa; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so635254766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709545723; x=1710150523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRfa5V1eCtQKvE35o3iYx+TIdATo30V6vBwFI6v4hE8=;
        b=mQJ4W/fatDtMSbNByqeVC1RFOiQBlKcMOWxA8PmfMEiE3lRsJnlIBAUJDV1dfaURnJ
         uohkLnR5dako6shk0ZG+OM6QCLBo35nD7TZe80Se3kKG7/E1lUjxuAeRjcv2sy/vrlYZ
         LJIidLr2SvdJ4p4uqpokt/010YO6YLlI6GQCGRQxsrD+O5Wf5YaYnVNSqsT6w3Vqarki
         N+WbeIGMPLbBvpoc+3AExM1K7rs8eoUOG9VyZr62yIqv1OLVvPFwpdbLZu1Gsqo76hPH
         zCxEmUAT/SB7N1AYinKx1FkMqytmI/zzE+Oc+WFJq6JlrZEFUSpn4uEtulvx22CZyua1
         eMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709545723; x=1710150523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PRfa5V1eCtQKvE35o3iYx+TIdATo30V6vBwFI6v4hE8=;
        b=tR2dX2tJJRahN6pqqnccWuL2n0jrAo5H3nZBxB7xk3Q8norTobstpUlMjdowN5b6/j
         eI1rahyL5KNzSAIEno1r/BZ4/ByXA8KMYLRw1S0UZ/UUQg6NS3ESuGLoRyuUNP0wjkl+
         NwJ+n7IseevDxR9VYqJICnPlARs9YNa8qYpmas4pUo+LhtJ7la6mzb3atxc8IBvOC0zk
         h4RtxceppoUSI4A5ehy5Hz+5UpV0moKAMfT+J7fomP/LFoNSPcvqmtxmyh9v1BWD0jRR
         m8iJk4upQ0q7+1UBcmjv1Conx7ODzWGDTWEXunD14zTMlFRoBuy8ROS8eRx6PKQ3Qs5E
         kA3A==
X-Gm-Message-State: AOJu0YzIIGrehYyq01VQJvXwhJL2qpavkihYVy4lzDg2BMFN4a8PXJIJ
	VARjxbP1h6uiAKMKsnZssgW8vh0OZW4OwR1rUfbMDs80+4prtve/M+lpwqZ2maA=
X-Google-Smtp-Source: AGHT+IG3FrZJUDTQ/cSxrdKEWOX1gTAVyQNE5NnJ4ilIzZcjXgY9mLDazaJkChHravh9KZKHQ4KVVQ==
X-Received: by 2002:a17:906:f190:b0:a44:2134:cba9 with SMTP id gs16-20020a170906f19000b00a442134cba9mr5448481ejb.69.1709545723528;
        Mon, 04 Mar 2024 01:48:43 -0800 (PST)
Received: from kepler.redhat.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id s22-20020a170906501600b00a42e2bc82dbsm4569839ejj.169.2024.03.04.01.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:48:43 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 1/9] sched/balancing: Switch the 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t sched_balance_running' flag
Date: Mon,  4 Mar 2024 10:48:23 +0100
Message-Id: <20240304094831.3639338-2-mingo@kernel.org>
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


