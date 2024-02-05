Return-Path: <linux-kernel+bounces-51983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D56E84924A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F32282A7D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B668A94A;
	Mon,  5 Feb 2024 02:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="HGwYy25D"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8A38F44
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 02:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707099101; cv=none; b=Wa+Lho0ITo/CH/OCQMo1VqXZj9TRELfkS5zOpFVXocRMT84RCaV5CjpxllJJbEOremanmUNVyX9qMvbGGVjUlhYR5QpGW3csgjxvDRtfZgG6c8aeGMLAV5Ahv7mFmBrvBw+GPEJ3Z4Cj9FMPOgJQ9YEPQyllhTEa/tlO8M4bSjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707099101; c=relaxed/simple;
	bh=GmmdOiK7gVSr1LuIyV2fgmVs0Usd923RUm0wZ55KmaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fF0eBKqyJ292nqDhBodBCnzw4OmjFTAFUcPqw0Y7/riGd28ue0qqjzKESRCMsfx8KoZ7TYEMo9MawBGJCqh3JTDgd79JKBBb0vS0AZiR6hVqme+S+o8t74oAQ63E9Mz8VszX3pF9mOmqRTwUBtVqfLqvhrqkb9q8foIHUl+Yytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=HGwYy25D; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fc549ab9bso23183735e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 18:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1707099098; x=1707703898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9mX0v9j5yCCNZk00rdpSpL3Xv1Bq3f+smlHRsHH9HE=;
        b=HGwYy25DvHfrDcryE6K//W4sL0nIrHqKCpRPo9nEwuQSpdkDQ/6gliFCNS1pHvud6+
         DR4Np01BHdgVEiq6sY1qDIDDAWhuLdv9prvDtJrvx9i4AEf156viiMB96ph8TR1qUhzW
         imx6TWs4PEZSezCn0Y2xtuuLJjpFeLLHWAKDkIjIsT2ye1a1bCa1TsJa4yzBKvDA9vjq
         TabhyD1oXRbgfJhtiz5DpX85VabyWErM2B+S5qtsioNK5j8LHMIKglTWPYQhdWveugXH
         wplwv375P7JRdeBGAIOPWp3xx5WTuywk36WcIm/WOsjiLgxmDOgLp5BjYjCLtaf1hNnk
         xX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707099098; x=1707703898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9mX0v9j5yCCNZk00rdpSpL3Xv1Bq3f+smlHRsHH9HE=;
        b=NUF2L/YNYtFq/rWgyMGnykMN5XyCl1ZMd4ZryOmnb2fTJbrsOW0G6eATGEzHfX7jmF
         N7Eo20obhNNlSZ1b+CpiyQXrU+C+txFQ5KiQ+xuPLUMFr866NRWsAuVbc9QeT/vAHu2v
         s7krhEg7+rsv3OSVEqnEgqhoXIpYQFLrsMzQZgAd3jbjMeaoQ63QVGuuKAwno9HgbQfU
         wBdgC56z8958CYn/s5hQIc1f+LhmqVtrUMxbPDoSY5NybE6caAFZXYv/RStZOkAhVolF
         cduGumISSgvWVOIWLnk21Zl9YoezsDnf9PPHHxgC60kfY/5mHyI8MTJLQ7Na4dZcRkx4
         rJSw==
X-Gm-Message-State: AOJu0Yxthzu9XBdRdMQvVdvOa2x7Ec58D9hF6EDH1xpqLxBJH6a2DhUI
	obaHePGXegIJveF++2khey64sd32HInHQ2GUJ4jKQPtZT/06N9QXsHyKp98urVXfdWt5Id8KWYp
	N
X-Google-Smtp-Source: AGHT+IFqNIdlSbia0S9hnXbjw+Vmh40AmzDM1ejFONviqhcvAAIOH7xLfmxI2xMTA/8kjzhZCdMsbg==
X-Received: by 2002:a05:600c:4750:b0:40f:cce4:38dd with SMTP id w16-20020a05600c475000b0040fcce438ddmr3953703wmo.20.1707099097808;
        Sun, 04 Feb 2024 18:11:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVsqRFzOugBcUFYXU1cgdMRhqVuCuZ5zsy8WuswXaNaupOAIqfQSC9wwFk8QWFNcCdsuK9tcWFgv7oWAETNYDU6C3g+ErEmGqH+8U+shhih72Pfhc3YPLoMBW2wnwNwZfrBPZHWd0yG5EdyqLOz6/c738Osh/UeGzj1wQCeRKeMwJvc0F8jZCgU9kHBOqWiO9DsdYxbADgCrK6kFr3QCa4YSxLBMNYyBQ==
Received: from airbuntu.. (host109-154-238-234.range109-154.btcentralplus.com. [109.154.238.234])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d4524000000b0033addeabd6fsm6999800wra.18.2024.02.04.18.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 18:11:37 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v5 1/2] sched/topology: Export asym_capacity_list
Date: Mon,  5 Feb 2024 02:11:22 +0000
Message-Id: <20240205021123.2225933-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205021123.2225933-1-qyousef@layalina.io>
References: <20240205021123.2225933-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So that we can use it to iterate through available capacities in the
system. Sort asym_cap_list in descending order as expected users are
likely to be interested on the highest capacity first.

Make the list RCU protected to allow for cheap access in hot paths.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/sched.h    | 14 ++++++++++++++
 kernel/sched/topology.c | 43 ++++++++++++++++++++++++-----------------
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e58a54bda77d..a653017a1b9b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -109,6 +109,20 @@ extern int sysctl_sched_rt_period;
 extern int sysctl_sched_rt_runtime;
 extern int sched_rr_timeslice;
 
+/*
+ * Asymmetric CPU capacity bits
+ */
+struct asym_cap_data {
+	struct list_head link;
+	struct rcu_head rcu;
+	unsigned long capacity;
+	unsigned long cpus[];
+};
+
+extern struct list_head asym_cap_list;
+
+#define cpu_capacity_span(asym_data) to_cpumask((asym_data)->cpus)
+
 /*
  * Helpers for converting nanosecond timing to jiffy resolution
  */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 10d1391e7416..1505677e4247 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1329,24 +1329,13 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
 	update_group_capacity(sd, cpu);
 }
 
-/*
- * Asymmetric CPU capacity bits
- */
-struct asym_cap_data {
-	struct list_head link;
-	unsigned long capacity;
-	unsigned long cpus[];
-};
-
 /*
  * Set of available CPUs grouped by their corresponding capacities
  * Each list entry contains a CPU mask reflecting CPUs that share the same
  * capacity.
  * The lifespan of data is unlimited.
  */
-static LIST_HEAD(asym_cap_list);
-
-#define cpu_capacity_span(asym_data) to_cpumask((asym_data)->cpus)
+LIST_HEAD(asym_cap_list);
 
 /*
  * Verify whether there is any CPU capacity asymmetry in a given sched domain.
@@ -1386,21 +1375,39 @@ asym_cpu_capacity_classify(const struct cpumask *sd_span,
 
 }
 
+static void free_asym_cap_entry(struct rcu_head *head)
+{
+	struct asym_cap_data *entry = container_of(head, struct asym_cap_data, rcu);
+	kfree(entry);
+}
+
 static inline void asym_cpu_capacity_update_data(int cpu)
 {
 	unsigned long capacity = arch_scale_cpu_capacity(cpu);
-	struct asym_cap_data *entry = NULL;
+	struct asym_cap_data *insert_entry = NULL;
+	struct asym_cap_data *entry;
 
+	/*
+	 * Search if capacity already exits. If not, track which the entry
+	 * where we should insert to keep the list ordered descendingly.
+	 */
 	list_for_each_entry(entry, &asym_cap_list, link) {
 		if (capacity == entry->capacity)
 			goto done;
+		else if (!insert_entry && capacity > entry->capacity)
+			insert_entry = list_prev_entry(entry, link);
 	}
 
 	entry = kzalloc(sizeof(*entry) + cpumask_size(), GFP_KERNEL);
 	if (WARN_ONCE(!entry, "Failed to allocate memory for asymmetry data\n"))
 		return;
 	entry->capacity = capacity;
-	list_add(&entry->link, &asym_cap_list);
+
+	/* If NULL then the new capacity is the smallest, add last. */
+	if (!insert_entry)
+		list_add_tail_rcu(&entry->link, &asym_cap_list);
+	else
+		list_add_rcu(&entry->link, &insert_entry->link);
 done:
 	__cpumask_set_cpu(cpu, cpu_capacity_span(entry));
 }
@@ -1423,8 +1430,8 @@ static void asym_cpu_capacity_scan(void)
 
 	list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
 		if (cpumask_empty(cpu_capacity_span(entry))) {
-			list_del(&entry->link);
-			kfree(entry);
+			list_del_rcu(&entry->link);
+			call_rcu(&entry->rcu, free_asym_cap_entry);
 		}
 	}
 
@@ -1434,8 +1441,8 @@ static void asym_cpu_capacity_scan(void)
 	 */
 	if (list_is_singular(&asym_cap_list)) {
 		entry = list_first_entry(&asym_cap_list, typeof(*entry), link);
-		list_del(&entry->link);
-		kfree(entry);
+		list_del_rcu(&entry->link);
+		call_rcu(&entry->rcu, free_asym_cap_entry);
 	}
 }
 
-- 
2.34.1


