Return-Path: <linux-kernel+bounces-60994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203D7850C33
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0F2281F91
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B4C20313;
	Sun, 11 Feb 2024 23:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fTsUXvP0"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248B617BA4
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693350; cv=none; b=RDlG9sDsuIFwno0TaMOYIQjcBUd4AGQtbHdCTX+kFVMxCaZRSW2RukT04Wrwf1L+tn0QWm4hu+oayI+XPkzCW7msBbWqOF2T/6VAndHSN70daal4pgY0g48pgG6X/7oSWsidJR1f1sRYQl03kIKVHBkBgJ/u4Z6ax2eBOX5f0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693350; c=relaxed/simple;
	bh=8E0JnpIDpqJTAIa7eziWdB8a1njbnn7OwwrjBeNl/Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SJ2AyLYknpXiUHkYy0CYAZkCB2ulZFSzt105ekVpYD43+LJ01joBOnl/NW11sP7qD7JJ0rMuRK3q8WC3NWw8ZinKnqmM/q7nQlKrHSgn0YAFGkge/W8OPMKJl924FBeAM5cvtgg9Iv+zf3wtOaN97Qbi/wSiv0kbZVfQWJPc2R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fTsUXvP0; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51186925925so912771e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693346; x=1708298146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjsOhN8aSrNAMTgfG/Xy/2KiT6HC8gp9GBm4gpWbj44=;
        b=fTsUXvP0w87TyqsT0jwBQdC+Oi68Ad8/npPArItiOf7Rj003JOhoDeF7ACesyGE7VW
         qUL+5pInAwC9gEk1YzNJO6yqG4CrSCm26xJA73H0WzozS6oyuox2Vs9NGfc5Y3vuZzZ6
         sX3nHOnKx6mSeGHnaKtA9ABqOAItHmTAEQKawGLR7F+4iGEmbGVbGEWigxZ0uwKsZJFY
         iiMJX8Uu9biawYrZXOkce4he1lGhpUhF+DNyMjtG75dckcJR3UMFvvHzaI+YBXf2Ec2a
         fxTwAwwG7sZWOU2vD/XvUaRcTc6i1UOOWX0H7gR0agVYDJNN2wgNg2SsBPJKOK5Nn0lX
         htVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693346; x=1708298146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjsOhN8aSrNAMTgfG/Xy/2KiT6HC8gp9GBm4gpWbj44=;
        b=w4mQLNHDte9pLtpE1nTjcPA8q6WIg2nh9w4qsvLA6sQKkrCRYOE40ZYMxGFhZTps1l
         iALleyqouLsGq4eWxymfnignzZmcJgtRzlghC3HmeQF26bz3c6ByhpBJ8qgTK7f86TH9
         Hfqv521AoqZ8ii3YbSYgLStMuJ9+ETDKk3m75Lje5kYQHVDqXkWgPqjgguYQgQdOhap0
         NXjkzDMASGho+D8yxDW6JFtxMEM35BG1Hoxqbe2AzRWr3LDl2S+6YLHSccbeIHrFn0Sm
         2iYpvX28Ho8gzp0EvG61PYmsY33pFYEHSZ9lvJ+Ci+mRwCTxyPa7mBATI8eEy9HAgwin
         jC/A==
X-Gm-Message-State: AOJu0YyIdaxKA0LurJeSLI0sQUcRb8TtHXmihwWJGZh37ztJiMQLl5wI
	WauRudujw6YuCiRADU8qQh3bj86JWw4YB1QGRn0Le4JPBESRYCbEIJPcnSHf9tGa17Ttd1KiKKL
	s
X-Google-Smtp-Source: AGHT+IFiaXHjYzh2QYZgN7cFH6a1/4HnD3mqks6bvJ55ezBcCSG84sI1rvRHY6AZxi7IISotEGUxhQ==
X-Received: by 2002:ac2:5607:0:b0:511:769b:f0ac with SMTP id v7-20020ac25607000000b00511769bf0acmr2941770lfd.31.1707693345989;
        Sun, 11 Feb 2024 15:15:45 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:15:45 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 14/35] swait.h: move declarations to swait_types.h
Date: Mon, 12 Feb 2024 00:14:57 +0100
Message-Id: <20240211231518.349442-15-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211231518.349442-1-max.kellermann@ionos.com>
References: <20240211231518.349442-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By providing declarations in a lean header, we can reduce header
dependencies.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/swait.h       | 13 +------------
 include/linux/swait_types.h | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 12 deletions(-)
 create mode 100644 include/linux/swait_types.h

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 68c2e30edb1c..4a4a240b337e 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_SWAIT_H
 #define _LINUX_SWAIT_H
 
+#include <linux/swait_types.h>
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock_types.h>
@@ -38,18 +39,6 @@
  * wait queues in most cases.
  */
 
-struct task_struct;
-
-struct swait_queue_head {
-	raw_spinlock_t		lock;
-	struct list_head	task_list;
-};
-
-struct swait_queue {
-	struct task_struct	*task;
-	struct list_head	task_list;
-};
-
 #define __SWAITQUEUE_INITIALIZER(name) {				\
 	.task		= current,					\
 	.task_list	= LIST_HEAD_INIT((name).task_list),		\
diff --git a/include/linux/swait_types.h b/include/linux/swait_types.h
new file mode 100644
index 000000000000..316038879a37
--- /dev/null
+++ b/include/linux/swait_types.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SWAIT_TYPES_H
+#define _LINUX_SWAIT_TYPES_H
+
+#include <linux/list.h>
+#include <linux/spinlock_types.h>
+
+struct task_struct;
+
+struct swait_queue_head {
+	raw_spinlock_t		lock;
+	struct list_head	task_list;
+};
+
+struct swait_queue {
+	struct task_struct	*task;
+	struct list_head	task_list;
+};
+
+#endif /* _LINUX_SWAIT_TYPES_H */
-- 
2.39.2


