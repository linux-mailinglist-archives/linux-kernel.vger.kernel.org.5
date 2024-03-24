Return-Path: <linux-kernel+bounces-112531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA569887B3A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 01:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C0C1F21BAE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6649117F5;
	Sun, 24 Mar 2024 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="ye/+8V1z"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C425625
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 00:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711241179; cv=none; b=dD34FrPykhFB8nSyjRGTL2tnYkAZl+/cmY8UCWIxkW/Qrd5qPHs+6zPHloPsfGD1vBcA1yRhuZTetKW7HY4rXn76hdhTNMUIjLfljBtT+Ecvr+EqQYlXeeRTrsJV2MMx34mN8/bhIspIF5Sy7vrgV6wgVNbBUXue1BnhSG7L1QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711241179; c=relaxed/simple;
	bh=RZZS1ahiS/h2qhBPp/IFChBOnTSZuyG6fr0nrFDfFvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pqfWS/rE+bPtINVsJQBg1wFO6S8Nw35pVO73EM60ehLUZLywyLDtDMgiFGIz904QhcgqjwoHw2Wq6Jw19n7azeelifR/sPIcfHiZNw8nTkvAdEju1/b/n3A09B8XvznNfkNzQoi8hktgUHMyp+VDnS93e8RJjcIO6DDtgvDJQ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=ye/+8V1z; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4147c4862caso15939805e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 17:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1711241176; x=1711845976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHUfTdaeXxCHn4zySRUikeyKEbkZDx+ZCbXavnvcml4=;
        b=ye/+8V1zPg4PsC3lPBxpwqBLAP5ydFrD6AQjDGKWo4kquaupOyQeJfGKolzRMHo8fO
         heLqMdtcRxP6cLNLZ7LeTydNgJnnX+uMtz0/oGpUmJmdsYj/wv11bFHLvAqjyaPO3Pgo
         7eGMNhQv2LkT4tm8jpgzUbqtzW/rv+4YrUcKtGT8YV3S+ErTNoHljMN1gftV5KMZGs9x
         kmRTlGXgE4xtculUq3rR1jvO8JoFD6EFOUrF1qJUuDQLRK4gdy/llrRlPSuG91aIEwGc
         t9N7W+9nxrHVUuep88mG5pc6pEsbb6p4uqY3SmgAFt+vO9cs1pAz65yssuGefL8WwiUY
         wQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711241176; x=1711845976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHUfTdaeXxCHn4zySRUikeyKEbkZDx+ZCbXavnvcml4=;
        b=XMR/cK/OUWkg+0dh9h+Cz5qGteJPAyIBJj0scKnSzaw8bMqsN3iql3UB2TsvzMpskp
         FS+JP+BddEWWnqiCIR0E8leUKbs52oUWH754St1W33oB7AYAjVGzJzkLn358iJE8d8k2
         WvyRWUiFViPeUZVq3/ExrKCUNO6UEQJZfd2l2+Sr+dY0SPcqDVv5j9CN4Z9UyhtmwsNz
         QFsznDNGCAIoIMwI2WCUw9/VQsBr6CpcQMMAA09II6rgIvEnxonRTV3UfJxTFxsS7zgm
         fcFFyhyBiB0/GNgopUOQlVJU85MuZQIToHlJEhjRSvHkJAf3xq8YK8RelDTuy1F3EPGM
         f7Ug==
X-Gm-Message-State: AOJu0YxzyUPxuC35Flq82xnqycqb0VAt0qsVPf+erJoOTyaDZmsoDmZ0
	mV+ZDsCTYUqC1IkntGQRZe6uxFW8G4fBtTt2hjnHE9G/DCf3SQjFC2XLVh9pZi1ThCsFVT8Wmv0
	pmP4=
X-Google-Smtp-Source: AGHT+IFYuqA5653aoYoTa8bCna+lvkbCCau75RH9JUkACAN+1dmPbBDGsUVrYhibS+ruKs+3er46kA==
X-Received: by 2002:a05:600c:4792:b0:413:e8db:2c9b with SMTP id k18-20020a05600c479200b00413e8db2c9bmr2442309wmo.40.1711241176089;
        Sat, 23 Mar 2024 17:46:16 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b00414674a1a40sm3778179wmq.45.2024.03.23.17.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 17:46:15 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v8 1/4] sched/topology: Export asym_capacity_list
Date: Sun, 24 Mar 2024 00:45:49 +0000
Message-Id: <20240324004552.999936-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240324004552.999936-1-qyousef@layalina.io>
References: <20240324004552.999936-1-qyousef@layalina.io>
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

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/sched.h    | 14 ++++++++++++++
 kernel/sched/topology.c | 43 ++++++++++++++++++++++++-----------------
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 41024c1c49b4..f77c00dddfe1 100644
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
index 99ea5986038c..44ed3d0812ab 100644
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


