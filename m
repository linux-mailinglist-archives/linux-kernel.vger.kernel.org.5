Return-Path: <linux-kernel+bounces-60742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7CB850911
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A2CEB234B3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE9D5A0E4;
	Sun, 11 Feb 2024 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="BMhfRUqp"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D995B69C
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654632; cv=none; b=oJDUYKNjuwWTLxNtacsWqSa4ctGbvVYHU9srveueCZ9jJJowfEH1MDbUQwoTccETCRmyXpO4fNMv8dYnBWxYbWqe7tBuofq19l7Hc6MeAYqioa7DTMpQWRlUBQ1fkMcP8j3swgxqzs20mblGvn3WhOsmYnzDryd/Yckb87hqH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654632; c=relaxed/simple;
	bh=8E0JnpIDpqJTAIa7eziWdB8a1njbnn7OwwrjBeNl/Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rB18RDLDTe1kn61turNiY9z29/dlmzUJcuqahPSh2Wk2f5GF6yhIfhYxqJjvtWKI+rvE9CEB0JV4iNjwmE0N/o9NB51PLhcjvyj3+E8UNo+buScauWhrDKOOLmHtQ/RYl/QDXXBucwkT57BG+CEvylLNQsmP3yRPIJj5eGZn+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=BMhfRUqp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-561587ce966so2460041a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654627; x=1708259427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjsOhN8aSrNAMTgfG/Xy/2KiT6HC8gp9GBm4gpWbj44=;
        b=BMhfRUqpNRfpp1FxHj1Af2akLDZJbMSb23pQQEm940KchsPXBbSfmCH+I65DF4x3OR
         PjzReCVVH/3vv+xaUE6EaMuDMNGnGhE+d+E2IXiH8ze5/XLHYj5GQGO5imahCnTjeceR
         Fph+LQcr2OZpDGbN0tw257XawsIKyEad0YbnXrQ7ezvie0ggmYb5fnABsZBW2pBXd5gc
         b4lYSWJnnmFY5LUVzzvJq3oK/OZzORojKWGt7SQi/gmnJ8P9xN3fH+OweTtMneo1pJor
         9+vdnSx+8x0QR/6O2y7JuZqcSPCJ7aGMhAuAIbNcQCTYhNlbBhTjBqeTKwBm8NRDIr8p
         S3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654627; x=1708259427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjsOhN8aSrNAMTgfG/Xy/2KiT6HC8gp9GBm4gpWbj44=;
        b=PAUAMh72mjpotI/5I0dQwPevjGle2/pcFV3ILWIltSYJ1iBhWrqkUf4nj0CJalKCJM
         rHTnJIaqtvsdGrRoMds+mJZLcDkcyYPZs+cnFKYVgYUCeJkU13g8mpeDf+J/ZUB3l/Iv
         N3CBWPGRbekG5Rha+BuNK2XGRDECHKD+5ygcLNfyTaMP4GrFa0rLIBIhfpuXF/bKPW7C
         JrAmVkGM1bVtxtQjxwDiIyIOFkMCNuqkfAY4zzFSZJLSiy6W3Ao+g1B4IdA8E7An936H
         vhsemKa/0ZTB8dzq59TvFidPTALOjhD/3z3ZETecK2L21S4jOBHxFPXiajwQNNJhDh6x
         siHw==
X-Gm-Message-State: AOJu0YzuQ3uxamiIIruvi4dQef5np9C2l1rGJFGNLpSoLw8N4F+c04aw
	yc/g3X9p+sscjUfugOwUY8nKkbCFqU9qbDo6CjDf+k/k/k+sB8iInyAWcvNhPri+Xj1XpGTt2Ur
	4
X-Google-Smtp-Source: AGHT+IG+fxHKw+poR5xpBO+cVQy0VoXYfzFmDjkJbSPW0EamRmL/W2qmk1Ma9Rk06NF3QRH7K/jkbA==
X-Received: by 2002:a05:6402:5518:b0:561:66a3:46e3 with SMTP id fi24-20020a056402551800b0056166a346e3mr2923559edb.10.1707654627556;
        Sun, 11 Feb 2024 04:30:27 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:27 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 14/35] swait.h: move declarations to swait_types.h
Date: Sun, 11 Feb 2024 13:29:39 +0100
Message-Id: <20240211123000.3359365-15-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211123000.3359365-1-max.kellermann@ionos.com>
References: <20240211123000.3359365-1-max.kellermann@ionos.com>
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


