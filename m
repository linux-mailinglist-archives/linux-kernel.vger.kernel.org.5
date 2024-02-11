Return-Path: <linux-kernel+bounces-60763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1007D850931
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C221F20FC0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC9D60DEB;
	Sun, 11 Feb 2024 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NBS/tyTq"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B84605A0
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654655; cv=none; b=diR9HVONqLq83BaS+vo99PcfTaw41mMomFFJhbURM2aqwW3G9KjSr/sDrg456TQ8ROqYRXedwcmAOKQLUMr6XbUd23Lkggz7dplCdUSVpFaAZuPoCXqouwfxGF5/ttpGRCUrMtESODeYWJdBwamFw4oEXkvv36TnvM8XyZVYZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654655; c=relaxed/simple;
	bh=HgB9s5w0AlPuLVyJkL0iJmSauVG9XEFFZWYHG9S9I54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dMpT2iVUa2+8SuSta3l/4mUauApm1fRjwpo+fbZ5LaK7MWvVo9NcKqrdXpNH7j/GN0ScSpuEcAIss0w8HBJ1DbYUgt9Gr5rFBNICW6OvK3fG/ClRW49crjb3JA4UY2ekUsYKNXCtvbtcQOO044s164Kl1LjFgyfm5T0LmuEeX7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NBS/tyTq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so2947615a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654649; x=1708259449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwHtii56Sk9j6aWasrwO47WYwdkHuwukNe9vK4w9g6U=;
        b=NBS/tyTq1Hk5fPR6h4ru1s2xgIKbQS9a8yXjjT3KsF8imj8g+JEqivWvLnn4cC/tVK
         uQjlcFmQMn5FAb8sMdu9TGryYB2AAq9mxGxmtWQ0uGE5jcT5EQ7s6kcQxQ7YmyX63bgB
         9RU/0IHYb+eEsSBDhLq75OTsWDCtng11R9upluSAMoEk56VOe8J44TD7AdhyNc8phAAD
         q6Z4UGnbRkQ8ZyAd5D8pHAG+ieSoy3tfJfQfq6hO4UlBA/AFbjD+YJDC9AGpYh3QREma
         Bgpd/MJJxOpyMDXgaNonN0bkc43I3+4d1cp124Jc1eW3tpnQDsIeOE+HznThh2MD4I0v
         D1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654649; x=1708259449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwHtii56Sk9j6aWasrwO47WYwdkHuwukNe9vK4w9g6U=;
        b=vDvExR2teMZXR0GC8wNV9ZFGr6PzoIg+C26MkJ927tP86lgsEsxXSEGV2fFWR9trWi
         +QHalcDJltUzH21iINu3KMg4tqa1bvVztdlwijCwHFr30gWmlbIIFaqsXQrPpI8dvrGn
         FuTSNzgC4acUACkZwEupoCJJJkdUt7S7HrSbagbwMh2nYprYODKtMCY8jTMR6oBYs19B
         LL5FhfiqG9GnrkfD9dztIVr3erIq9KuN0LinI76mQmuwvZfxSAD4J/cuHwPRzk2/nT9S
         Og9oxD2GPOrw14ls572BnI5Iiu/kyb1/nictI7js487UyJh0ReGRHO4JmiPAjlPWvqsw
         DHrA==
X-Gm-Message-State: AOJu0Yxa/54hNk6aY0Dc0NoXMpBwBTZBJMHxEycb6N82mioCLQVCdmxc
	HNGYqJsmoGDMd3hhIhj6ScB5eZKQnHfms98hUTc+q6EEyYzzYusubiSM+prTv6pdYKTbZ7MfJBu
	N
X-Google-Smtp-Source: AGHT+IHx4SN7HjAhHkNHy+i6tltC6d+Th5AiWnh+JLFUkgiUT1UvDBm0FMVlqPCur9ki3zysSfd6zg==
X-Received: by 2002:aa7:df04:0:b0:560:64f4:cbd3 with SMTP id c4-20020aa7df04000000b0056064f4cbd3mr2267489edy.20.1707654648967;
        Sun, 11 Feb 2024 04:30:48 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:47 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 34/35] linux/kernel.h: move PTR_IF() to ptr_util.h
Date: Sun, 11 Feb 2024 13:29:59 +0100
Message-Id: <20240211123000.3359365-35-max.kellermann@ionos.com>
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


