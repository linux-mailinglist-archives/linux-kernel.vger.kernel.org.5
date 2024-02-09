Return-Path: <linux-kernel+bounces-59633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 575EC84F9D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849881C227CA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ED482888;
	Fri,  9 Feb 2024 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="GtpeMLCW"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7A27BAE5
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496865; cv=none; b=KT4ZWsZ8+1f7/OMNE5re+sbhaZXZVVm5wkIjcCDTI+vTihEVTgZLHDoOn0eni45vVxgKYwA7F6+TflWbgz+iD04Zg/1YOm6w1M850MnbRBwvt+a8GU04V1WgLb4khPm4SX/ceCOp3SN5Qn9/yXt+cIZQJGFTbPvRqWjO4WDFmyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496865; c=relaxed/simple;
	bh=8E0JnpIDpqJTAIa7eziWdB8a1njbnn7OwwrjBeNl/Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Delu9qhJ7FecCYcgJlop9yIrp6Uk+ZRCPPfXqh1Dqjb6REydbKgOduhqxdo6ijg3/dLvi6/jyvJF1PU/YZw0yMwxGhzM4jvGYNS2cF9QJZAdUjRW1GrGSol6bK6FqdKRjtjqzglWgc6RHzZecTwzS8Njsf7h5oasg3noAVU/oTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=GtpeMLCW; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3864258438so206026766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496859; x=1708101659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjsOhN8aSrNAMTgfG/Xy/2KiT6HC8gp9GBm4gpWbj44=;
        b=GtpeMLCWrNSyngKv1QSew5KaM/SR3bLHcNzWTrNX22T5ST4Y6VwOiNq7T7CoC6dvim
         8KsD0wWRZ1Baj6ir2enCacXkyhWtrGpHNoFa8ZMeKTPPPQGo+8ZV3s3Ep5rCIznQTEsr
         dn4j/2WIOHuLhpM3f8iia8Q0f3k0z5AgKTJ6JRzJZ7G5duKBfaMkPI1cRKMQhgx5O5GD
         xOirmU09IdXzrJORvBP5qUajOupH5ZinbreeDnOliSBvx6pXAmrBkuV3lhuOZhO/LVab
         CdE3Z6k/S4wibiI9X8T2616Rev3Z9TGRH2kGT7zj3k2ejUxWfl1rCmONHaSbz3lDUacz
         7xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496859; x=1708101659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjsOhN8aSrNAMTgfG/Xy/2KiT6HC8gp9GBm4gpWbj44=;
        b=S/iANoWj5V2BmfYiKHHdtFXQFXwq9ohS/ZoVTLHKxegQ8wIupMqL6UwjSsXOAkMjTz
         HU37Usbk6/hjnyplPz+5WSRWVNOM/EWdAnmzrmpSvkp9g1OOZVo7Ns+2jtLQIeL0t9r4
         AlE0gs8v/JUepZg/z826V4NoRM3C22V0QAyRqspHku9nn2UJYNR5sdZxecGNPPu0EjoE
         GHlJBtTtOd3gHmjh81nDAuAg9Nam3+v6A1iknq6my+B259Ufpyn5qRs63BKWnTT34dT7
         8G5mwfXfPhIFUK0viAwRHMTq4vO8XbI7/J+M5uA4YBlA8vX2DoAG8mG0E0c3idwJ8QYw
         WD7Q==
X-Gm-Message-State: AOJu0YyZy131uhjQ2NXEI5PTIYS2+/EDFbfnQLWypOrco6prGpNzaQoO
	Q0hzkyhe9ebo2Al2yu4bnz9atS0tMzEP0t9rQCBnbaktNjiRP/UCPf7N9gT5Gw+DolQn2KdGiKB
	S
X-Google-Smtp-Source: AGHT+IGIbeEXivLbl5RfcesSa20ArX3uNZ3lQkyt3NpM+wV9NGVE6Bp1l623i/pUMu6Ba5kqdQImMw==
X-Received: by 2002:a17:906:796:b0:a38:9911:cd2e with SMTP id l22-20020a170906079600b00a389911cd2emr1452524ejc.3.1707496859300;
        Fri, 09 Feb 2024 08:40:59 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:40:58 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 14/35] swait.h: move declarations to swait_types.h
Date: Fri,  9 Feb 2024 17:40:06 +0100
Message-Id: <20240209164027.2582906-15-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209164027.2582906-1-max.kellermann@ionos.com>
References: <20240209164027.2582906-1-max.kellermann@ionos.com>
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


