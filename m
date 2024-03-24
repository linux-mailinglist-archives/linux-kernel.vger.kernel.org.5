Return-Path: <linux-kernel+bounces-112533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79C2887B3C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 01:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C33D282580
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F181A38FA;
	Sun, 24 Mar 2024 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="rSO/h7Ba"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFFA646
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 00:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711241181; cv=none; b=F4NrTvwp+juM++rHyTMroF1QhyFq1UxlbFIDNJNcYP/h5MXyP3TevZHhF7R61GoXvj4iNuq5WCuP0i5vSdZjPaSmjj4yt8nr7QJbleo9D/5X4hJyKMEXQwbXFiTzZ7NACMI6AZ7P5N45hiBSWERXU3Hds0RMlqUZE9mVebHJkuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711241181; c=relaxed/simple;
	bh=AOzbBt2px6IAhcB3mpW6y/UMjXJbufYujPoS27Gf5Iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NNJD7uItgOGoirUWryLVasCU6Z/PNuOBzr4h9ZNtX0Fd25qOLS0VdJ8ScSxDUN4P/n7k7jjKqUqpITB901mnukg+VA3jIKZNL0AgParzTPHlMDqy8Tsc+0lhFS+OGevC3T+EJcm52NeXVyff1QTO3GIB5L37+zuZY7577tTSMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=rSO/h7Ba; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-414850d5924so2241085e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 17:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1711241177; x=1711845977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUO5KvfpRMNgU51mJbx/1qemdCABN5ekHEl8L1wBADc=;
        b=rSO/h7BacU42KdbBCR3IMJduQyOUfCg49ENfWp0xDsMv5ZacId324ORTo5PUxmV3iY
         iqb9BAwF5VZd3DRjtCtQE5d2l2t28fNLHFt+Wp3CIPfjAEtGPxKVtGOlzO3FweFvRrhj
         bOiy+VLa039w8/VfXvofjsdC6xiYX08R2k4YhPRnbbUmFFLZb6aBexv4hZC69gHZhioW
         VYHr05igavVX+OJ4dW9/+5UGutCjOmH9VuojM7b6ljc55kLKdOe3aGAgoRKqJuTuoPJg
         F2XC8+urUOaSaR2CQi20IEc+pke8DMWzzTDNE/1LrxGaTxv8vbve/WWYxg+K9VzJiQJW
         tQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711241177; x=1711845977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUO5KvfpRMNgU51mJbx/1qemdCABN5ekHEl8L1wBADc=;
        b=q0mP5RFXmRmFtGY4RSINJWzv1VG/QyDeLnxb1tIrV+Xw/BdCEMjDOwEm/oV/kUxPyV
         MmQ6FseonEQn8/CbYGuaKiT+WKqadCMkqM0Kp6WhR2OjHjZU/ztmD7Jr5mKxpy9ahTxP
         bkSmRRJOf8JRA7f/hdml77RlOmLtLB8wp+BgBBkj1LTSaM0lZ2AaoZRVCU/86N3nj2qH
         atbMy10L/gGiz9OHjhXyNqJnchUZ5TKRDe2hliSziLHNQmFNZae+n0mcetX8Wc6ANEpE
         r4QXcZfDsqUTjLLoW5p6tVt8H6h7PHtwHy6U4ES18L650X3K1LAd5yqQXL0u4Zgx6ocI
         iiUw==
X-Gm-Message-State: AOJu0Yzp/eQ5DS1fAwgw+UWt55M8iGIZZcyU/gfnEHQbBnpeYjFlmbSw
	DF3kTv/rs3ZRdbI4RbaThho9Qv0V0QnMHWKzWfw3I66goLWR1wM/30wKxKeAZoY=
X-Google-Smtp-Source: AGHT+IEhh9sC66eyja7PpoxKhCyQwdcZ5Jis9V7utN6IHA9uELFaU59XzgYJAC6tAoLuXSRog35tLw==
X-Received: by 2002:a5d:4e8c:0:b0:33e:b7d4:892f with SMTP id e12-20020a5d4e8c000000b0033eb7d4892fmr2101700wru.20.1711241177719;
        Sat, 23 Mar 2024 17:46:17 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b00414674a1a40sm3778179wmq.45.2024.03.23.17.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 17:46:17 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v8 3/4] sched/topology: Remove max_cpu_capacity from root_domain
Date: Sun, 24 Mar 2024 00:45:51 +0000
Message-Id: <20240324004552.999936-4-qyousef@layalina.io>
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

The value is no longer used as we now keep track of max_allowed_capacity
for each task instead.

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/sched.h    |  2 --
 kernel/sched/topology.c | 13 ++-----------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f77c00dddfe1..4f9e952d4fad 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -917,8 +917,6 @@ struct root_domain {
 	cpumask_var_t		rto_mask;
 	struct cpupri		cpupri;
 
-	unsigned long		max_cpu_capacity;
-
 	/*
 	 * NULL-terminated list of performance domains intersecting with the
 	 * CPUs of the rd. Protected by RCU.
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 44ed3d0812ab..63aecd2a7a9f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2514,16 +2514,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	/* Attach the domains */
 	rcu_read_lock();
 	for_each_cpu(i, cpu_map) {
-		unsigned long capacity;
-
 		rq = cpu_rq(i);
 		sd = *per_cpu_ptr(d.sd, i);
 
-		capacity = arch_scale_cpu_capacity(i);
-		/* Use READ_ONCE()/WRITE_ONCE() to avoid load/store tearing: */
-		if (capacity > READ_ONCE(d.rd->max_cpu_capacity))
-			WRITE_ONCE(d.rd->max_cpu_capacity, capacity);
-
 		cpu_attach_domain(sd, d.rd, i);
 
 		if (lowest_flag_domain(i, SD_CLUSTER))
@@ -2537,10 +2530,8 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	if (has_cluster)
 		static_branch_inc_cpuslocked(&sched_cluster_active);
 
-	if (rq && sched_debug_verbose) {
-		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
-			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
-	}
+	if (rq && sched_debug_verbose)
+		pr_info("root domain span: %*pbl\n", cpumask_pr_args(cpu_map));
 
 	ret = 0;
 error:
-- 
2.34.1


