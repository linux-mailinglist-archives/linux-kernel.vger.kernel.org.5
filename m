Return-Path: <linux-kernel+bounces-146763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAC68A6A89
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39422813EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A6912BF17;
	Tue, 16 Apr 2024 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AkAkzVLp"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610C312AAE2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269739; cv=none; b=I8/ZjHI77c2Lh/2mRwX42F9OKy/SZ8mm1K9m7xX9wmfWABEw04c9QVNMFpzrZzMqjkjWq5Q/GbGXFRoyo8el6E03xLVN1WqCm720T0UVxQHoh1qzZjs53SsSn+IN8m/8EFdl3k6WwWFqxVYKiBb1r+vNly7PXLPITcayndBwCrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269739; c=relaxed/simple;
	bh=LFTwl+KaNR01xUhsIjDuW6dm42jh/bpLqCuATv5koSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0BXcjcNwmP96KuJei/da57Fo890Au135qVqxcTKdpui1lVcR0oUD6nmBaCl0+3e5MXq6H5u5DMj+37Sna2433It3t/fQPbZxcKqWLqMouWVNgA+9vHY0BOwqhxw60GIUYrwjySL0rnWmefeAtnBtejMBMQt8KLXIwww88Eq4uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AkAkzVLp; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f013c304bbso377151b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713269736; x=1713874536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8FZtLez5NK90qpzb7pJiE/cmJLi/g0rDQRNg4yxT3c=;
        b=AkAkzVLpXD7vhIZlLh9bC9VAHIHGZf5OSN8xvZhdYjiuYE5WWs0OEv9ZnbKASq7+dp
         aUA/u0VxKpJBUMOnbVPVtVsikuTPc4VVd+v7I6lr77Mxz8C2Dn5X7AgNRxGS08ivFNbB
         ubOSIG2Fg0d3gHblVS5WwMUqTvbA5qJBDUSwexlVlWWhSKzcnGH21OGx90RAM7QwM6Do
         W0cVAkM/EhAMT9BaCB9cjUFhD/bh3NloKvTNBSwBWPxPTkxFKSh1xM/9Q3uKMzGkLmlj
         nRc8o8Z5QNbqLbCDPrMehe38mpqKU8WuVlSyCSBae/WgRo6cBpS+Weos0KbUdBJEAOwo
         uA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269736; x=1713874536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8FZtLez5NK90qpzb7pJiE/cmJLi/g0rDQRNg4yxT3c=;
        b=n4iFyByZYn3GmIrVpjrr18LjWVXv1e6liAb0rg0uxjJUJlYuQsEQnsQKsT9vmIu9vp
         h5mojnGXN7/zOqTNuP2PoJwubOQ2u+c0A+qyMI+eP/o7PzIgoRe7xJ5DGjZdo8jSLQ0h
         zYztH4mq7ONyH0u7sPkKqL9QzCaR6NxSEOdR6BbgciR7hiUDQqF7lWjLf0mFDs43hO9I
         rfHj8i+If30wKLMGH6HbGD8UsWwHHmcIS6hHAsZSR7z8PHIe4xfNuZ4/yD3Qq07B3dlV
         qXZQCein4kPHA2XUL7NCyMecWFSbRgArkRFqnDbdIL2Vso/l21FNktxKdLXgx219ilDc
         0jaA==
X-Gm-Message-State: AOJu0Yy6dTjMlAWYkn6w8sfbU5VvVei9b7MrwFATTckM87vN1sQVQl0N
	WjqT5o54WTMz2hntZ3JStkHFaAlgBVou+dWi+JuOpYihAx6Y6tKnKviPLREo+j4RoMWQccKS/bc
	o
X-Google-Smtp-Source: AGHT+IGFn1ukMhmFaOaV3SngWL/VAPF/owOpZcgy22GXhm7nBqiZcEQ4Emt0z452eARBAlN6Qn3iVw==
X-Received: by 2002:a17:902:ce8d:b0:1e4:344e:768e with SMTP id f13-20020a170902ce8d00b001e4344e768emr15013803plg.5.1713269736213;
        Tue, 16 Apr 2024 05:15:36 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d12-20020a170903230c00b001e43576a7a1sm9584693plh.222.2024.04.16.05.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:15:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	tglx@linutronix.de,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] sched/core: change rq->nr_iowait type to atomic_long_t on 64-bit
Date: Tue, 16 Apr 2024 06:11:19 -0600
Message-ID: <20240416121526.67022-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416121526.67022-1-axboe@kernel.dk>
References: <20240416121526.67022-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for storing two separate iowait states in there, bump the
size from a 32-bit to a 64-bit size, for 64-bit kernels.

Note that on 32-bit, the number of tasks are limited to 0x8000, which
fits just fine in even half of the existiing 32-bit atomic_t. For 64-bit,
no such limit exists, hence play it safe and make it a 64-bit atomic.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/sched/core.c  | 14 +++++++++++++-
 kernel/sched/sched.h |  4 ++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 977bb08a33d2..6a6c985220b1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3723,17 +3723,29 @@ static inline cpumask_t *alloc_user_cpus_ptr(int node)
 
 static void task_iowait_inc(struct task_struct *p)
 {
+#ifdef CONFIG_64BIT
+	atomic_long_inc(&task_rq(p)->nr_iowait);
+#else
 	atomic_inc(&task_rq(p)->nr_iowait);
+#endif
 }
 
 static void task_iowait_dec(struct task_struct *p)
 {
+#ifdef CONFIG_64BIT
+	atomic_long_dec(&task_rq(p)->nr_iowait);
+#else
 	atomic_dec(&task_rq(p)->nr_iowait);
+#endif
 }
 
 int rq_iowait(struct rq *rq)
 {
+#ifdef CONFIG_64BIT
+	return atomic_long_read(&rq->nr_iowait);
+#else
 	return atomic_read(&rq->nr_iowait);
+#endif
 }
 
 static void
@@ -10065,7 +10077,7 @@ void __init sched_init(void)
 #endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
-		atomic_set(&rq->nr_iowait, 0);
+		atomic_long_set(&rq->nr_iowait, 0);
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 387f67ddf18a..c2802d066615 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1049,7 +1049,11 @@ struct rq {
 	u64			clock_idle_copy;
 #endif
 
+#ifdef CONFIG_64BIT
+	atomic_long_t		nr_iowait;
+#else
 	atomic_t		nr_iowait;
+#endif
 
 #ifdef CONFIG_SCHED_DEBUG
 	u64 last_seen_need_resched_ns;
-- 
2.43.0


