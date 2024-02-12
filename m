Return-Path: <linux-kernel+bounces-61495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3231B8512E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCA61F2722B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C4D3F9ED;
	Mon, 12 Feb 2024 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="MjKcIvME"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21B03D56B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738952; cv=none; b=GssCKUP9oEX0FwP6aWa2unO5ihukCUvLLN04Cx9AE3RHXlmHsjNmtb6okK4Zy6X9BYw6gYbEunrVJ7oODSxpYEEStJqEZjkfmT9fmJ3VUQEDNTC16nSsfCheGCNfsrbPnYpw5K6abSaKfwiG78WIW8Q2RE/hE9u0f+ajIz/EiWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738952; c=relaxed/simple;
	bh=HgB9s5w0AlPuLVyJkL0iJmSauVG9XEFFZWYHG9S9I54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NWsrZk7VlgsFNljW2WG2iXBQ84YkhaGA869mj4CJdOyUfbyi8tKRbcNn/3V9T62bK4psFHO87vPdbBe67mm8HRB94V7rJAUI4kY2zputvdj1Z8WJ+v0VH4Xi+MjHJLR4Y4J83C3aFVt1rgTBldlckb/zDOYlCqwUWO88ZyZvISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=MjKcIvME; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3c0efb9223so362684266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738946; x=1708343746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwHtii56Sk9j6aWasrwO47WYwdkHuwukNe9vK4w9g6U=;
        b=MjKcIvMEj6GI+242IXYIhPDq3gWGejbRorCWdr2VGuxyS9VfAihI8yCltyASxiNGw5
         RiY9qjzYR9QQXeInT5mCGYqGA6b9tAMw10z3Yev4dPeufOT+lbSkcblKTOYh2PHM1L2c
         lPSCHvG6pX4T4MRaVOWqQRcOPNUFF3LdI+qdPLwRBv6F17maJhHsmNV4m5xWPeEzcsk0
         +8kX2zXkmCcIG6JuzgL5eTsyaufR1XLMlJFEo3cjBI0mJOi9aXAMKX8npq+NSjpXOAf/
         bZZKl/D2t1cMUMPB7xfwuEjyXW+ZsNVnn2JZB737UBi69p+FiV2DHUvAFD1mrs1eM/oY
         jtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738946; x=1708343746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwHtii56Sk9j6aWasrwO47WYwdkHuwukNe9vK4w9g6U=;
        b=YSCje8s78Mo9p784xh9pQ4uu9+Y22RNr5pq9xETYnKhyUM8zKgPhi7RYt5eD1k+QJi
         xUa/ohieYMHN0x5+F/5EqX2M3rBsOTGmqsfgvW2luHBWbEfJbY+BMWd52HjsO/m9tP9Q
         AsC/HUbqQwr1BSduQWOUZNAARJY/I/igYxNc4ebjqLV/H8oEcuCc+kdT2JtVU3/l+hUV
         T2R5f7wGlTqWfGgLA7nJesEhjUm9zZZXmP/bWUfaaLyNWvOupmTZOrzoX0LCLAPiE1xr
         BF8GGulzuSbpMPFEiDBvYym1sLCbLax8qrSFSG78TAfm97+wAl5dSTcRPsvT2zM3iG32
         DQWg==
X-Gm-Message-State: AOJu0YySp3LEmL2bGvKbnVOYTVWZIobzcpeKRwt3z9vXsSeOlW54jw8R
	Cr2DqXnTBvyOoNd2HaDGvM762ALTVGCeygTYH0pBwFrGeZVjmglJegZMNGvnFGESGu9koVnLPQ9
	d
X-Google-Smtp-Source: AGHT+IGLjrpz6kDuR74Vaa5Extl/98UmFILMyehb0casYz1o3PgktFwDjIxJweP+vhlGJvNFLF8MEw==
X-Received: by 2002:a17:906:3e0f:b0:a38:532a:f72b with SMTP id k15-20020a1709063e0f00b00a38532af72bmr5490068eji.17.1707738946790;
        Mon, 12 Feb 2024 03:55:46 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:46 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 34/35] linux/kernel.h: move PTR_IF() to ptr_util.h
Date: Mon, 12 Feb 2024 12:54:59 +0100
Message-Id: <20240212115500.2078463-35-max.kellermann@ionos.com>
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

Reducing dependencies on the header linux/kernel.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/kernel.h   | 3 +--
 include/linux/pm.h       | 2 +-
 include/linux/ptr_util.h | 7 +++++++
 3 files changed, 9 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/ptr_util.h

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 6f436367dd16..e323fe139cc8 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -32,6 +32,7 @@
 #include <linux/sprintf.h>
 #include <linux/static_call_types.h>
 #include <linux/instruction_pointer.h>
+#include <linux/ptr_util.h>
 #include <linux/wordpart.h>
 #include <asm/byteorder.h>
 
@@ -39,8 +40,6 @@
 
 #define STACK_MAGIC	0xdeadbeef
 
-#define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
-
 #define u64_to_user_ptr(x) (		\
 {					\
 	typecheck(u64, (x));		\
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 34cf20dd1ad1..cccf320b67f6 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -9,7 +9,7 @@
 #define _LINUX_PM_H
 
 #include <linux/export.h>
-#include <linux/kernel.h> // for PTR_IF()
+#include <linux/ptr_util.h> // for PTR_IF()
 #include <linux/list.h>
 #include <linux/workqueue_types.h>
 #include <linux/spinlock_types.h>
diff --git a/include/linux/ptr_util.h b/include/linux/ptr_util.h
new file mode 100644
index 000000000000..7469aff978a9
--- /dev/null
+++ b/include/linux/ptr_util.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PTR_UTIL_H
+#define _LINUX_PTR_UTIL_H
+
+#define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
+
+#endif /* _LINUX_PTR_UTIL_H  */
-- 
2.39.2


