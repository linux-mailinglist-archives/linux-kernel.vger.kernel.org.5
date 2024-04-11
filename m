Return-Path: <linux-kernel+bounces-140846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059E98A192E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D801C20A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196CC1353FD;
	Thu, 11 Apr 2024 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0KOMKACr"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2B01332BD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849647; cv=none; b=HgCkN6FVzYP1atKnwcQp2KDHke/fx+/tYjwY8V1W0qdUOjbaskuUwtJwXVpsuSYQIDpU/OgEq1/KEpa4/xkY0yvUSuKs65y6+gtbYrjOun7WDav/P0o8TDLsENvkf6JxjtNU3Fbpggf2yWKtoO8zoyofi5rk18EBxyaM1NyHYpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849647; c=relaxed/simple;
	bh=Qar3/vvrpFOmManApyEpAOBw2M+pqPcvhgHpTd9sh64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQ3HU363xYeKhgUJ9YUv1dS0+KXUvK0adM1wDLPWdQ/SU6HS9ZnQIx+kTtY8Ep+hvn0ePQBQD6LX8wveRVwNkXlMUta2lzwu8RSIz4UAV9LhQLUTLbG9F0A0aBRDc9Y3bzBoUWqM6OQzMxFU04A+pLOKTK0htXE/w2VUZWaS1HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0KOMKACr; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58008139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849645; x=1713454445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjrSkmmvxEk/YQX9m0GLB+6VRfRvSoF5s9NnsEDntYc=;
        b=0KOMKACr0N8/MVr0hWNjyYLgHiBlra3mCEQXC03Mixy9XLCCYlMJ08ZI5zh7NWGKxl
         gmOMEYZygVushnCcGuUjDikHsbopWIWH5fU2idGaLlajhn58ZfSzmf7ZkLmged/RGboQ
         9Lmtu7e9Ft/I4aYNz5D9bP37a9XeFC3hEWYV1tqTpa47Do+3kqq5k6AH/xYsORVROYjT
         67LvDiHeEbJctJmlPDhEeIlZKGxKw29FAIhH3YX4O+P97waQxZCivrUg4i8sBpDyLGIS
         Wym1egnWanjAHThHpBNhdyr+lSg73Yf5aIKoO/nSXrIRCxz4UM9FEJGDl5VIeDVbS55D
         VwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849645; x=1713454445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjrSkmmvxEk/YQX9m0GLB+6VRfRvSoF5s9NnsEDntYc=;
        b=K1wV1b7b/kOxv4Na77j1kBjMlqrgqHGQGgmIH7UgzVgT7GzdA4VHjg9Bkm4TzZx9EA
         dsbtggWvSlc1l4ZQ311YiqEdmvb23aksc+SkfNyLOVAlBxtVDY5/I9I0/lzxHAmu3zAm
         DcYDbTcVjCDmYZWECwjvEH25WoAaYRs9vV49f/EwpzzgqK3ChMjT4g+aKTD3OdAPla8T
         TOq5JNoz88LUNQ4SCzcMhY0CBgYMVmYFI10vktVQy/J7fmmuNZ/ftkWM2UBvbf9R7vsW
         J9oWdUsOY6z0k/TpsTPpGCJsqeanotWqAA0N4vNEmSPixvXxBEl9nyQeQx1nVcjmBHbf
         udmA==
X-Gm-Message-State: AOJu0YxABLVngs8EFigg3Qi3RK2kyDlmPm6/3roOPlkdvMqe2XLuW3R2
	EEw/vUJQY/TbSiv9NUuSz997xaLDY0o1IPkOeKqYpyjM80PmJV/Q0ZAYSr7Mim0ZTxUzKYDg40f
	x
X-Google-Smtp-Source: AGHT+IGd+n0H0fLE9apDgdDk1Edcw/nfNCHOo3VKhpf55iZ6FHABfA3gUnaPp/TcQ+ymb76jqOrqTw==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr155211ioh.1.1712849644717;
        Thu, 11 Apr 2024 08:34:04 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 084/437] locking/lock_events: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:44 -0600
Message-ID: <20240411153126.16201-85-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/locking/lock_events.c    | 18 +++++++++---------
 kernel/locking/lock_events.h    |  4 ++--
 kernel/locking/qspinlock_stat.h |  7 +++----
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/lock_events.c b/kernel/locking/lock_events.c
index e68d82099558..1f1efb123a1b 100644
--- a/kernel/locking/lock_events.c
+++ b/kernel/locking/lock_events.c
@@ -20,6 +20,7 @@
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
 #include <linux/fs.h>
+#include <linux/uio.h>
 
 #include "lock_events.h"
 
@@ -58,8 +59,7 @@ DEFINE_PER_CPU(unsigned long, lockevents[lockevent_num]);
 /*
  * The lockevent_read() function can be overridden.
  */
-ssize_t __weak lockevent_read(struct file *file, char __user *user_buf,
-			      size_t count, loff_t *ppos)
+ssize_t __weak lockevent_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[64];
 	int cpu, id, len;
@@ -68,7 +68,7 @@ ssize_t __weak lockevent_read(struct file *file, char __user *user_buf,
 	/*
 	 * Get the counter ID stored in file->f_inode->i_private
 	 */
-	id = (long)file_inode(file)->i_private;
+	id = (long)file_inode(iocb->ki_filp)->i_private;
 
 	if (id >= lockevent_num)
 		return -EBADF;
@@ -77,7 +77,7 @@ ssize_t __weak lockevent_read(struct file *file, char __user *user_buf,
 		sum += per_cpu(lockevents[id], cpu);
 	len = snprintf(buf, sizeof(buf) - 1, "%llu\n", sum);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 /*
@@ -85,15 +85,15 @@ ssize_t __weak lockevent_read(struct file *file, char __user *user_buf,
  *
  * When idx = reset_cnts, reset all the counts.
  */
-static ssize_t lockevent_write(struct file *file, const char __user *user_buf,
-			   size_t count, loff_t *ppos)
+static ssize_t lockevent_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	int cpu;
 
 	/*
 	 * Get the counter ID stored in file->f_inode->i_private
 	 */
-	if ((long)file_inode(file)->i_private != LOCKEVENT_reset_cnts)
+	if ((long)file_inode(iocb->ki_filp)->i_private != LOCKEVENT_reset_cnts)
 		return count;
 
 	for_each_possible_cpu(cpu) {
@@ -110,8 +110,8 @@ static ssize_t lockevent_write(struct file *file, const char __user *user_buf,
  * Debugfs data structures
  */
 static const struct file_operations fops_lockevent = {
-	.read = lockevent_read,
-	.write = lockevent_write,
+	.read_iter = lockevent_read,
+	.write_iter = lockevent_write,
 	.llseek = default_llseek,
 };
 
diff --git a/kernel/locking/lock_events.h b/kernel/locking/lock_events.h
index a6016b91803d..0210d1abc4d7 100644
--- a/kernel/locking/lock_events.h
+++ b/kernel/locking/lock_events.h
@@ -58,7 +58,7 @@ static inline void __lockevent_add(enum lock_events event, int inc)
 
 #endif /* CONFIG_LOCK_EVENT_COUNTS */
 
-ssize_t lockevent_read(struct file *file, char __user *user_buf,
-		       size_t count, loff_t *ppos);
+struct kiocb;
+ssize_t lockevent_read(struct kiocb *iocb, struct iov_iter *to);
 
 #endif /* __LOCKING_LOCK_EVENTS_H */
diff --git a/kernel/locking/qspinlock_stat.h b/kernel/locking/qspinlock_stat.h
index e625bb410aa2..efaabdcfcddc 100644
--- a/kernel/locking/qspinlock_stat.h
+++ b/kernel/locking/qspinlock_stat.h
@@ -33,8 +33,7 @@ static DEFINE_PER_CPU(u64, pv_kick_time);
  * 3. pv_hash_hops
  *    Average hops/hash = pv_hash_hops/pv_kick_unlock
  */
-ssize_t lockevent_read(struct file *file, char __user *user_buf,
-		       size_t count, loff_t *ppos)
+ssize_t lockevent_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[64];
 	int cpu, id, len;
@@ -43,7 +42,7 @@ ssize_t lockevent_read(struct file *file, char __user *user_buf,
 	/*
 	 * Get the counter ID stored in file->f_inode->i_private
 	 */
-	id = (long)file_inode(file)->i_private;
+	id = (long)file_inode(iocb->ki_filp)->i_private;
 
 	if (id >= lockevent_num)
 		return -EBADF;
@@ -91,7 +90,7 @@ ssize_t lockevent_read(struct file *file, char __user *user_buf,
 		len = snprintf(buf, sizeof(buf) - 1, "%llu\n", sum);
 	}
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 /*
-- 
2.43.0


