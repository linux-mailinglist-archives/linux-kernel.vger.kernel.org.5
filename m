Return-Path: <linux-kernel+bounces-46647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE65844242
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A2D29188A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF49D12CDB3;
	Wed, 31 Jan 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Jc1x8QU/"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7019912BF2F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712632; cv=none; b=nwXT8CcGJkuZKGFQwzppxjgCkzZKHeLYg7I4364oyQ5mw9WX2CGDUjZN3ViBDhNm9y4w/OZTng5OFm5Hh+hFvmr+Viv0obaz9ONQHgHV7jwUpjkrKwQXZcJn6zLXlY+CrqektSSgfSQBlwDcjVqCmk2GDIJJaB4hVErCkg78A0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712632; c=relaxed/simple;
	bh=umpocJWf5sdD6KVHur6DHtXj065kZ5d03l7Q0U/QxVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R8nQCnl+amHXbXQXV6uk0mEHS777lPmCRiQin6TMuMuyMf37XGmsFS7F1XTcg5HbHLZEhBLS29nMvf5h0f6DFu5xHMQp9F2tAuc/jyEBJDJffDeizvOo5M9dLGGBCCgoivSwGoNayv0zI2TUNgqFgoC/Ag8BNlhwi5zCNBGEj+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Jc1x8QU/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so74838f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712628; x=1707317428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Jvf9nXlMJHAHzKXh9T8RT5jLeZd8an9dEEZ2B//5ko=;
        b=Jc1x8QU/2itwitU2fjQN8DkWymtSAiVabWRaop/7Jj6/sbVWiszbvilFq3vi8gbo2I
         j2EPZThYlkvDe8onTVtfojIENB7/Oaxwkqu7UE1W7NdYeTIThm2Y2xEE2m8R4Q95CaNv
         HVKqauN2/VYTryv5TLpSmux3Y/Drs5m69bYp/cfsFoYX//s3b3FlCq81U7v2iTGj7Gl1
         60coRFWfC9Xu/nSS1ghKKWQYc2m28CDYzcjhZK0OLAUQAAZKf/AFvVpTTd/MQkU1DHs6
         hEl5zcKjaZm4hSpmPPQsG94f9RzSej+U2ZfEK5w4kxIzMroP8ZR5s/jTNFmBEHiJRWCo
         YVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712628; x=1707317428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Jvf9nXlMJHAHzKXh9T8RT5jLeZd8an9dEEZ2B//5ko=;
        b=gWl4H4jEya4fGcTrcnrNj8IrF/yGe0W9c0pAojDgNRley/cmGCIiPis3l3n6BiELke
         T1C2uGOhRNVwHZIXpZ7Y+OuuyMB6DYRFU3QUBKm3c2+rp4NtVImrXzHdymPyOGQSpY51
         O6lp6gGW9xXjuuf4gZ8h1ZoXEcsdYTp3910qWdLeDWvKUeFpd+2qZWtDDEv3NVISEbMU
         N6xn2hBvUwQDNzP2Jm6s0VLWX09ihBId+zMAWVA327VPfOlGYPVUEUfM1MSppNtgx0kC
         f5gYM4Mxth98k9NkphukPA2SQ4urYOPr3oGQS5if1KNvn2isE6GmeInh1bREzdq7VpM3
         tSBQ==
X-Gm-Message-State: AOJu0YwpzFHoAbvcfZssiLHFR2Ixmiqtm7q//bSoJk33EDKP0ThMj1J0
	Dfvkx5x2XIO35TWPf/lqnT03T9rC2RUU7D2uBf7LIoNJVaR6fntC8RxCeyXhPH/e2NbBf5TdZK8
	v
X-Google-Smtp-Source: AGHT+IErzmTCF02S0nLMWQuq6l20CJSXtE4UDfo7LCRePleyR/1FKHPmAtjeVXeqNdbLkvTDpnmCkQ==
X-Received: by 2002:a5d:6889:0:b0:33a:e6dc:2e98 with SMTP id h9-20020a5d6889000000b0033ae6dc2e98mr1304973wru.5.1706712628284;
        Wed, 31 Jan 2024 06:50:28 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:26 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 14/28] swait.h: move declarations to swait_types.h
Date: Wed, 31 Jan 2024 15:49:54 +0100
Message-Id: <20240131145008.1345531-15-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131145008.1345531-1-max.kellermann@ionos.com>
References: <20240131145008.1345531-1-max.kellermann@ionos.com>
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
index 988ff0f0f84d..7fadcd30e505 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_SWAIT_H
 #define _LINUX_SWAIT_H
 
+#include <linux/swait_types.h>
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock_types.h>
@@ -37,18 +38,6 @@
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


