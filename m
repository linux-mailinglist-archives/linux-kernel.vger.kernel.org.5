Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545F67E6039
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 22:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjKHVx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 16:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHVx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 16:53:26 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B7B258A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 13:53:24 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5bd0631f630so160181a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 13:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699480404; x=1700085204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8+1RUn6ye/V5oCXpT4AXN5Yt2m+B7UnFQxMDOfZORrg=;
        b=XcVaQsRAQdI7aRmQVwJ0NyQGgdhNuLJ61Cgdkn9wCXn30j5CmhU+lIo5+X9g7tMnBi
         E8iemZZGHVFoKGwpXh+WWbY6FOOjKsvN9EI7EIz2LWehttpGZU8/LVH4ngT7AffDlKUS
         PdwI+Gokukiah6uC6L9PEb6IrPFcMsyzJzZArAd+BJcELZ8FIRO9F1LPU3x54CSPZJlp
         FhZuE2XwDoyVR56ihP5IoyzM7X+60UlxMYyTe8MqsULsZ9r9BIwkGUSSaIQbAQR7zCoc
         b9fzbQpZBV105EV4VzYQf9pJtHYIbB8RFxzws2wxvou3quqqlFtJqvaQSvuJwvvJY/bb
         UFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699480404; x=1700085204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+1RUn6ye/V5oCXpT4AXN5Yt2m+B7UnFQxMDOfZORrg=;
        b=uq6TX8Qqq6qvRHJnP5HCOPcODvY8LNbM5iqmBW+/iGkVNgnuFspGXUfkUZ/LGpELt3
         PJmqLfd4v3kF0VzB/Odj/+OrT6n9DWr8Z3kQNmdnUj32FFObHZfzONmHRNAg4hrQkHzw
         iY4DjMZZ/QTy3qeYL+qefl/a2g4XpBVA7nMkvMdsjgc+T3eAn3DThbGuHqLZMMi+5uo8
         h1bHHfbLo40Fyluz8Q4g3rnVhnPU7q7+VosAlq2sLxN9LQH+6eO5IBK3IoRykOAZwgQn
         ybiyVOXF9oa32ovPgVhl7g2I/uLR1cZv+XZZOCVrnWYkyLOBmxLV++GxdAo8zxmX3s1A
         ek+Q==
X-Gm-Message-State: AOJu0YxZ6EneREZY//FJ4m29UEHMmoBXymwXLeomcqW9FY5r4zWNsGqE
        5Wih7gtlAGHlpoPL4XiWzcEsUuKIZ8E=
X-Google-Smtp-Source: AGHT+IE/XmW31pGR0Fd40lkQo3F0PWhZ1Fp3t1e0BasAmBW4Co8zM3MPBhHSzkH653j565vjM0RO7A==
X-Received: by 2002:a17:90a:d717:b0:280:2a3f:9938 with SMTP id y23-20020a17090ad71700b002802a3f9938mr10158599pju.12.1699480403564;
        Wed, 08 Nov 2023 13:53:23 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:555d:a196:40f8:b293])
        by smtp.gmail.com with ESMTPSA id z23-20020a17090acb1700b00280cd18c161sm4469pjt.53.2023.11.08.13.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 13:53:23 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] locking/percpu-rwsem: Trigger contention tracepoints only if contended
Date:   Wed,  8 Nov 2023 13:53:22 -0800
Message-ID: <20231108215322.2845536-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It mistakenly fires lock contention tracepoints always in the writer path.
It should be conditional on the try lock result.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/locking/percpu-rwsem.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 185bd1c906b0..6083883c4fe0 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -223,9 +223,10 @@ static bool readers_active_check(struct percpu_rw_semaphore *sem)
 
 void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
 {
+	bool contended = false;
+
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
-	trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_WRITE);
 
 	/* Notify readers to take the slow path. */
 	rcu_sync_enter(&sem->rss);
@@ -234,8 +235,11 @@ void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
 	 * Try set sem->block; this provides writer-writer exclusion.
 	 * Having sem->block set makes new readers block.
 	 */
-	if (!__percpu_down_write_trylock(sem))
+	if (!__percpu_down_write_trylock(sem)) {
+		trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_WRITE);
 		percpu_rwsem_wait(sem, /* .reader = */ false);
+		contended = true;
+	}
 
 	/* smp_mb() implied by __percpu_down_write_trylock() on success -- D matches A */
 
@@ -247,7 +251,8 @@ void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
 
 	/* Wait for all active readers to complete. */
 	rcuwait_wait_event(&sem->writer, readers_active_check(sem), TASK_UNINTERRUPTIBLE);
-	trace_contention_end(sem, 0);
+	if (contended)
+		trace_contention_end(sem, 0);
 }
 EXPORT_SYMBOL_GPL(percpu_down_write);
 
-- 
2.42.0.869.gea05f2083d-goog

