Return-Path: <linux-kernel+bounces-61475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6628512C5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520971C219CB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D963B3B797;
	Mon, 12 Feb 2024 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="MO53C63R"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BFB3A1B8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738932; cv=none; b=V0RMU4tNM1FTrUGPOQr0uxinrc2tcxQ2oivgImUIBcq87wymSNxWMtTBT6RO+e7YWG3AzyRlUwI3K/TIv6pvshRdx6k33uYJRIVJ8JIxhqB6yANcPeFO2NSCZCJID1Ai28Aw3qRjfEVRrO1PyAoT1lgu+2gX2mvViZQEVWzfo/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738932; c=relaxed/simple;
	bh=8E0JnpIDpqJTAIa7eziWdB8a1njbnn7OwwrjBeNl/Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eh9nWJgzjzYRLOFJPZeTK+MDoUlLWPUNveBEsGKldG3KGy+0W+FPmWWIyDu/6qHWBT8yCFbFs2jh44yOBn9ZKAmtGt+pgIhVXcBYQxCVFs+O7nDhK1EndTV/1vfyClCwtl4tlbR8URiQClWwKgKJYDtnjEG3oqFwZU/CUd5sQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=MO53C63R; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a271a28aeb4so386143466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738927; x=1708343727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjsOhN8aSrNAMTgfG/Xy/2KiT6HC8gp9GBm4gpWbj44=;
        b=MO53C63R6D5tZkUiKwO0QVmm1d832ChMYvfsPvXRIrDSuaEMiXPaI90sT5NqWEGQI4
         WMqrsYRXAAXSGvoZCGIhnhMhNKyePkkede6w+RAh3bMt+rT8zK9WBxm5Q5HswQBCwVMx
         Tr7UdiUet/R0Uip17P8WeNzYd1g9U238lW1/kDXDR3Q3YYrIRdOZXd+KFz1iDAqokOdA
         dGPBm1cbIV28Bex8FhKKxK7Mt5ibfgMsyl8VBWDbZyMv28H30IsAKTeOOyih2MFlgh2P
         M85PpdxMYQ10JYOrRfoZzF14WLW971tjeTce85mJwAsGFjl3iXv5yhNhNXmOBaziuii/
         T5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738927; x=1708343727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjsOhN8aSrNAMTgfG/Xy/2KiT6HC8gp9GBm4gpWbj44=;
        b=wTkfXysS2SbJzfijKbodIjUZJ7sipcHJbIAqaWkrDQKBAnWPusYWQAKh2TWpi2+bmy
         vRXZZx2n/4DPUbWtw35cXp78i/oxLal4MlUPf8ROPqoIZmoScKWfJQrNqyFNu8Moip48
         JExiGNoLRvigEBGXQxj1ZIBNMziZuuNl1CwC5lrqP40szFGCbhuw3Jo2mZDNB2RsCR1b
         B7mjgfNF7jAkFESemkKBBHGJaWwPVfYtvjHZ5vD7YQMPurjW1q5Z5JEZKBVUDs+e5KuF
         0/CjZv/MVZpuF6TqHo/bHqYSbD2zVJ7cOr7OpkKO5tfgYbViADzd8SZYufNnSQWYx3DE
         W5+A==
X-Gm-Message-State: AOJu0YzX6k9+MARdC62Zs8Yzdhjz4xcF5uyEHpJdaPnyjMxlD5O2Hl1u
	aa5EEd/ciDOSkZXOqDecCDqkapm3dvV3AUT//3TsHNDPgswgvtmiOZVddP8YQz2LVje+mq7pv6p
	y
X-Google-Smtp-Source: AGHT+IFO3ZIT8lUVwCFR4BPXjZ2XmWa/Yl0cEiQIddVDtoQET0n7ZJeLx7cMpWW3C+SVf/kan3ncEA==
X-Received: by 2002:a17:906:b259:b0:a3c:6052:2f53 with SMTP id ce25-20020a170906b25900b00a3c60522f53mr2900710ejb.37.1707738927381;
        Mon, 12 Feb 2024 03:55:27 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:25 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 14/35] swait.h: move declarations to swait_types.h
Date: Mon, 12 Feb 2024 12:54:39 +0100
Message-Id: <20240212115500.2078463-15-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212115500.2078463-1-max.kellermann@ionos.com>
References: <20240212115500.2078463-1-max.kellermann@ionos.com>
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


