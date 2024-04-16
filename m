Return-Path: <linux-kernel+bounces-146764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B3B8A6A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6331F21833
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744FA12B151;
	Tue, 16 Apr 2024 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="owORLR12"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715F12BF29
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269742; cv=none; b=jdJyo733QkCfCRwB+f/qHw8ChSuwesKqprquSqMspWdLQs6y05btbXrOhmoGQ4iUUlj9d69LBBWJuXI1D4jwzVUZn/Qn51enkNkKAEM+03YrftHZNzQq7hj5uL7sW9l59IHgEtn8d/910nXMnU2/2KTjCAFcLyyI4/8DMhRXqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269742; c=relaxed/simple;
	bh=RG9FrqpOf7WbjmJJz8QqVZnfuVsS9/NaC14Fu5Zb+ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JL2W9G2pO16WU1uBnI4AG4YGqIwtmXEl0IvYw3eixBbP30hCoHTO8bZB2xpOPkZWYLWCacTbMLQiMw/GtcMg/RZKO7JN5hztNiamVQ7s45z0ZIKgj6ttCvohboqP8Y2i08KEl9CA8yPKVrJySYG2+r/B4NoY8F1XBCEtbR/MkxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=owORLR12; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5f0a485dab9so372451a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713269738; x=1713874538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tn8L7Kj7xLJGqKx7jb5AwYrGu1BZjVWnoiTJPrrq0So=;
        b=owORLR12QMVsGgrsVx6FgVXKUof0kex0BiBBje+9s49yFD+aoPWbi2cDhDAhp1P8OH
         KIPlXKT9BI/dZWskUBTCATE42I5fDvq8u0sbjhlB3r9EHbrD836xfrabIWVAldH1x/re
         TCMxDWfhGawMR/XOZbFMrLrs4gz2xY3eFGoKY0UT4hOic8duXKKRuBpaoppc09RzbbrC
         +2kO8xZN4d2yqNhdjQEDR9K9drltQBOjOgx9MRp0ecJwK9ttw21Pc87Wob1s3kYb2GOF
         bB5zgBUSAPMwxLs08aBVBAoSIKVMHq+U5Hy2jq1i4IN+iXXNVCMB4qhEJZRLeJY5WRge
         Liag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269738; x=1713874538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tn8L7Kj7xLJGqKx7jb5AwYrGu1BZjVWnoiTJPrrq0So=;
        b=MkAUuZKO4UAyYPT3BbJjvTVJSiqn31Aja6hf+Jgbh7OdkRg4PpPHMXt0Z3WYIJZljI
         9d5sgwknDLio3kwLCapiFPsk2vKJmx/t3/86h3kUGDsxhvdiW5k5doFVuL3VGioYHJ8t
         dXTaCy9CSduSv4W5aKh/G4GEZlLX4Mld6e4GJjhiUK+JL9+4X5mmHGruVuCdf5LWrAbS
         ir7R2PcxiBCQGgNhMgYpxroco1IEry7IPGWOLZ6vvcZBIFGgGjEL0ZrGevjeti8A27rY
         3iWSMqJc1E4c8X/O0HUEy8WrCIv+pBsl7cvHDWdjka8SNGtBGmCsTLuaGJCbk8Xi0wwo
         vJTw==
X-Gm-Message-State: AOJu0Yymy1ospmyoOxArVoDFkH4CnW8Q6od4OXeJDttPxHVd/2XSBslV
	/rru468pPvmIanErPh83e44e23XLIp52c8ZjhaHXEdf/vwhahMnndAHXS05T8MEmV0sIehP3xXc
	h
X-Google-Smtp-Source: AGHT+IHxW6aW0PxXuhIyhTHTYRuVxyaLu2t34mwID/dWVGQtCCT5fRQR0E1e+inB2kl18UPNghhbnA==
X-Received: by 2002:a17:902:e84d:b0:1dd:da28:e5ca with SMTP id t13-20020a170902e84d00b001ddda28e5camr14826585plg.0.1713269737731;
        Tue, 16 Apr 2024 05:15:37 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d12-20020a170903230c00b001e43576a7a1sm9584693plh.222.2024.04.16.05.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:15:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	tglx@linutronix.de,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] sched/core: have io_schedule_prepare() return a long
Date: Tue, 16 Apr 2024 06:11:20 -0600
Message-ID: <20240416121526.67022-4-axboe@kernel.dk>
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

In preparation for needing more state then 32-bit on 64-bit archs,
switch it to a long instead.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c           | 2 +-
 include/linux/sched.h        | 4 ++--
 kernel/locking/mutex.c       | 4 ++--
 kernel/locking/rtmutex_api.c | 4 ++--
 kernel/sched/core.c          | 6 +++---
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bdbb557feb5a..77faceddd5dd 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1849,7 +1849,7 @@ static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
 	u64 now = blk_time_get_ns();
 	u64 exp;
 	u64 delay_nsec = 0;
-	int tok;
+	long tok;
 
 	while (blkg->parent) {
 		int use_delay = atomic_read(&blkg->use_delay);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c2abbc587b4..dcfc2830ed8e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -317,8 +317,8 @@ asmlinkage void preempt_schedule_irq(void);
  extern void schedule_rtlock(void);
 #endif
 
-extern int __must_check io_schedule_prepare(void);
-extern void io_schedule_finish(int token);
+extern long __must_check io_schedule_prepare(void);
+extern void io_schedule_finish(long token);
 extern long io_schedule_timeout(long timeout);
 extern void io_schedule(void);
 
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index cbae8c0b89ab..4a86ea6c7f19 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -830,7 +830,7 @@ EXPORT_SYMBOL_GPL(mutex_lock_interruptible_nested);
 void __sched
 mutex_lock_io_nested(struct mutex *lock, unsigned int subclass)
 {
-	int token;
+	long token;
 
 	might_sleep();
 
@@ -1026,7 +1026,7 @@ EXPORT_SYMBOL(mutex_lock_killable);
  */
 void __sched mutex_lock_io(struct mutex *lock)
 {
-	int token;
+	long token;
 
 	token = io_schedule_prepare();
 	mutex_lock(lock);
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index a6974d044593..ddf7f7f3f0b5 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -547,7 +547,7 @@ EXPORT_SYMBOL_GPL(mutex_lock_killable_nested);
 
 void __sched mutex_lock_io_nested(struct mutex *lock, unsigned int subclass)
 {
-	int token;
+	long token;
 
 	might_sleep();
 
@@ -579,7 +579,7 @@ EXPORT_SYMBOL(mutex_lock_killable);
 
 void __sched mutex_lock_io(struct mutex *lock)
 {
-	int token = io_schedule_prepare();
+	long token = io_schedule_prepare();
 
 	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0, NULL, _RET_IP_);
 	io_schedule_finish(token);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6a6c985220b1..63f6d44f460c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9032,16 +9032,16 @@ int __sched yield_to(struct task_struct *p, bool preempt)
 }
 EXPORT_SYMBOL_GPL(yield_to);
 
-int io_schedule_prepare(void)
+long io_schedule_prepare(void)
 {
-	int old_iowait = current->in_iowait;
+	long old_iowait = current->in_iowait;
 
 	current->in_iowait = 1;
 	blk_flush_plug(current->plug, true);
 	return old_iowait;
 }
 
-void io_schedule_finish(int token)
+void io_schedule_finish(long token)
 {
 	current->in_iowait = token;
 }
-- 
2.43.0


