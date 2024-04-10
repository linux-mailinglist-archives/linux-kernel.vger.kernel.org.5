Return-Path: <linux-kernel+bounces-137870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF4B89E89C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5528D285ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40622C129;
	Wed, 10 Apr 2024 03:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="ca9fpLQJ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E5620EB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 03:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712721331; cv=none; b=u3h73RsTpCIOVbRttjs8AQf21FKpm34HdTNrZPy3Ch73MimRZ8fMEhjXzZ4/LZOHT2IO2sUJIY2Ka5fzB6dpT3U4ose0WlqhqKhL+IzOewVeJldIP/gYLzkhpSrDlu1GQQunKFFVMtyV5YfLr/Vqs7mlKY/WS3fSMrnLFYiZmnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712721331; c=relaxed/simple;
	bh=Fr+H5H+9OyxP/eMdoUL16dMlUuiEjVQJD40MloRhEwc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QbxJECZ35Q/l5ePgZuvc/5wCCHJwRRM0Hqh0N4MyhgyupvBrmzMPaX6NEPm3eFf6SF49z3FFsl+44WTwonNd+Eoq9FUQx+TSYxpZT/dLFHsR/WRPyVaBUKS3LAxKCvkNXYaSt6COM/dljNqU1x5+mhtMB8CBf8OlOhJUFfjLgDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=ca9fpLQJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso3197860b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 20:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1712721329; x=1713326129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yl8nuM83q3FvVMvZFRYv9k4mezej2QhOdeP7NWCHhgE=;
        b=ca9fpLQJkymwtBa8ihV5JYKixxk3q2U6Kx64SKsBUqCvhzcUqE6J1KKqDBBB9Edwlv
         Gt0bprITylOrcLSAR68fz4uxJCSYohAjWYohZvJOZSRV13QnVV7OXAeYlVFjb7j30eWl
         yrJSg+JrUgpFmhRfX1mw/WKiySskFrzEYxkzV3xDYJ3IUzmpk1jk1iY7D7GoZ7e5xp3E
         nOwnNXollP7T2CdJLQasuXqH2tPZoa9NSoQLiQOXlM3S09jQ9Q55brCSCI7sIZGSB6tO
         X/QNdfs0pX+reOD4DsPhxGEmwhwNmh9mWM9Bt3Ey+1GZoH12HbGXJ+vzuM6YaKOz1Cpn
         fs4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712721329; x=1713326129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yl8nuM83q3FvVMvZFRYv9k4mezej2QhOdeP7NWCHhgE=;
        b=M1BmkWyN25ThWBKcszig9BYC0hYpRhhhnvfKTTvYFJVtGT5aoDh5mGTDqc+8CqoGsh
         wJzHVtSidSwyVLGQ+kuMExt8eyz5yVPQ5RNnJJR5lPpkpuWyIMu0MVl1MzSZSfeAxZ4Y
         auonrCpklao3lSyVRmNcXe+dLx429jgrfV8EkI8BbkXDHKSJgj1BlwiLUU/bh9aKDMmn
         UB3tHUitZ7Smz0hieQ4p+8j+StH0ZyOHQDXJvnwV/ONUdLgBrnfB28Vdn+orzup7es/7
         q1uuJa3csXeGjbjhJXBB6dNNFyS4WLRuwJjzZUZWf52OcH2Hcz+O/tFkKG0ztzp+hQx9
         ykNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXciRy2ArAf44bOjXebtpSLiX9Yr4w5dJEx97SaPMCRSoPgC7WKFjmqW/N2/7qB8UPLtA11XPRBbrZXA9khBqyZXqN5n9FgpFZInn07
X-Gm-Message-State: AOJu0YynqEbsHEN2nk2RFDVcJEgjmvcF4XJCGLMLsTAskUwNxueRxKjO
	+Gt3oaRgGiGolsNUuCbRbVsG2Whdb9m9a37VQSgQCbLmU9Uu+2N6+Q1wEugE77g=
X-Google-Smtp-Source: AGHT+IHKkMs0JkqFR7sXLavUkJ3Sj5i44MhlS+uWvhi0+CrDkKCUU6L0hoSYvA0vQvdDAcQjWQBH9Q==
X-Received: by 2002:a05:6a20:f395:b0:1a7:a9ab:a72e with SMTP id qr21-20020a056a20f39500b001a7a9aba72emr1589220pzb.9.1712721329276;
        Tue, 09 Apr 2024 20:55:29 -0700 (PDT)
Received: from localhost.localdomain ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902e2d100b001dddcfca329sm9747639plc.148.2024.04.09.20.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 20:55:28 -0700 (PDT)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: peterz@infradead.org,
	mingo@redhat.com
Cc: acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] perf/core: Fix missing wakeup when waiting for context reference
Date: Wed, 10 Apr 2024 03:55:06 +0000
Message-Id: <20240410035506.599192-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In our production environment, we found many hung tasks which are
blocked for more than 18 hours. Their call traces are like this:

[346278.191038] __schedule+0x2d8/0x890
[346278.191046] schedule+0x4e/0xb0
[346278.191049] perf_event_free_task+0x220/0x270
[346278.191056] ? init_wait_var_entry+0x50/0x50
[346278.191060] copy_process+0x663/0x18d0
[346278.191068] kernel_clone+0x9d/0x3d0
[346278.191072] __do_sys_clone+0x5d/0x80
[346278.191076] __x64_sys_clone+0x25/0x30
[346278.191079] do_syscall_64+0x5c/0xc0
[346278.191083] ? syscall_exit_to_user_mode+0x27/0x50
[346278.191086] ? do_syscall_64+0x69/0xc0
[346278.191088] ? irqentry_exit_to_user_mode+0x9/0x20
[346278.191092] ? irqentry_exit+0x19/0x30
[346278.191095] ? exc_page_fault+0x89/0x160
[346278.191097] ? asm_exc_page_fault+0x8/0x30
[346278.191102] entry_SYSCALL_64_after_hwframe+0x44/0xae

The task was waiting for the refcount become to 1, but from the vmcore,
we found the refcount has already been 1. It seems that the task didn't
get woken up by perf_event_release_kernel() and got stuck forever. The
below scenario may cause the problem.

Thread A					Thread B
..						...
perf_event_free_task				perf_event_release_kernel
						   ...
						   acquire event->child_mutex
						   ...
						   get_ctx
   ...						   release event->child_mutex
   acquire ctx->mutex
   ...
   perf_free_event (acquire/release event->child_mutex)
   ...
   release ctx->mutex
   wait_var_event
						   acquire ctx->mutex
						   acquire event->mutex
						   # move existing events to free_list
						   release event->child_mutex
						   release ctx->mutex
						   put_ctx
..						...

In this case, all events of the ctx have been freed, so we couldn't
find the ctx in free_list and Thread A will miss the wakeup. It's thus
necessary to add a wakeup after dropping the reference.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 kernel/events/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4f0c45ab8d7d..01dfe715f09e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5340,6 +5340,8 @@ int perf_event_release_kernel(struct perf_event *event)
 again:
 	mutex_lock(&event->child_mutex);
 	list_for_each_entry(child, &event->child_list, child_list) {
+		void *var;
+		bool freed = false;
 
 		/*
 		 * Cannot change, child events are not migrated, see the
@@ -5380,11 +5382,25 @@ int perf_event_release_kernel(struct perf_event *event)
 			 * this can't be the last reference.
 			 */
 			put_event(event);
+		} else {
+			freed = true;
+			var = &ctx->refcount;
 		}
 
 		mutex_unlock(&event->child_mutex);
 		mutex_unlock(&ctx->mutex);
 		put_ctx(ctx);
+
+		if (freed) {
+			/*
+			 * perf_event_free_task() delete all events of the ctx and
+			 * there is no event of the ctx in free_list. It may step
+			 * into wait_var_event() before decrement the refcount. So
+			 * we should add a wakeup here.
+			 */
+			smp_mb(); /* pairs with wait_var_event() */
+			wake_up_var(var);
+		}
 		goto again;
 	}
 	mutex_unlock(&event->child_mutex);
-- 
2.25.1


