Return-Path: <linux-kernel+bounces-59651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9EB84F9E9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3964A1F25783
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A1C12BF1B;
	Fri,  9 Feb 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UDaUf46p"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A93F7BB1C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496883; cv=none; b=PStYM4CMP8x7HES0H2M/e5/Ou47mRzRKo3AQ8I7E25O2m6bCQiA6OfZxF724d5d/BEnhuS5GViDO7Dnjx5mQgj4xuByrYPR3rBfodb/CJvNBo7BQo6nM7Cc+txtHJhdX26lwarv+rD4dQHvyLZy7fGYdJDZSWf5kb1/tVMk7x+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496883; c=relaxed/simple;
	bh=HgB9s5w0AlPuLVyJkL0iJmSauVG9XEFFZWYHG9S9I54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uUm4Zsaon2Oquu/IfyVDajc5JWTr4uKIJpv/ltCHiOQUv9KDR1imGUx9plPJZRJMny3q5dwfxntxXjRc1lKfn227x2ZGmE8cmFmNVa02Iw3Pg2RKar+2fflTIu3cqn5jtH8qFCBQjvUfitU1ZV8NGd1nlYCkk21aeD9e/JuyhB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UDaUf46p; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso1752573a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496878; x=1708101678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwHtii56Sk9j6aWasrwO47WYwdkHuwukNe9vK4w9g6U=;
        b=UDaUf46p4r7ACglzo08S3q27tOfCVYWlEenHCqB5PDcTDqEFIBrgdIUuXFaXnKBsgh
         mkkAnP5dpmdy+84TVTX8ZelZOx+kOUFWlwQ/ng/KBC0dIDDDcD9GJhSz2oQFyclJC/Nd
         yzJDLskv8qFtIh/YkIqcXDn0XrgFLmnMzGMROmsijm3bNNTy6Koq9U0drZVjWUy67XYC
         FA3BuODkEl0HLaoil5KgivXH+72RTEM9SQKU3CqSIivBHo2M9WywmqEmBcRcSwtOvjEy
         1iKQQYRBRQepK3+35SFKq5Jxh04/BnDvaQAoFFmeqiyFA6f6t0cNxzPWVuORqRSgyl/z
         HKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496878; x=1708101678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwHtii56Sk9j6aWasrwO47WYwdkHuwukNe9vK4w9g6U=;
        b=dGQxsVy81KzR9eiPmoAPwrnuuN3+7HH41kZxIRmywJxD4ohc/7B73+EoChprmK7ln8
         V3LDjl4NqAnJY2jjdcxxAQWLU9daRbGLGVf22osrd1Yca7rX3OE4k+Ge3b0dH4tfuJol
         26RGNWrl4lfb0XsGZuwzsYYdosYx6ghFv0+NlJoIQ01HK/jEzcorGUbLrI45rYmLc7m7
         Cyo6CAW9sTbsr5zW4vPKyvYeUFTXdaMfn4POHXWszxCe0uU0yYrRldu7MMeqSqeVdaQn
         ZHjOlN1h4QucLAzMLLuwLnBmdF9S46muqB5iy2CJ0gLLOTNC2CfLTtuN9KGy3M5jkf8D
         sz9w==
X-Gm-Message-State: AOJu0YzKSvU0U92OkzhMc8VcUAbgqHTcLRWReQaICuCOEa+h98zIVg3Y
	+gNB1ENjnA+uoOl4tODkJx4TACNmtz+x6IRlTWLVAClXIufU4BWsXUFRmDKvyqSVQ6nhphajrQb
	Z
X-Google-Smtp-Source: AGHT+IGU7MzJ0J3L4r1Bu2tCc0DkoZV9Wm79whKMaiibhW/v1owhxrMeJUnqwJFeZ7nDwZuxF0FnIg==
X-Received: by 2002:a17:906:5a95:b0:a3c:b2:3f99 with SMTP id l21-20020a1709065a9500b00a3c00b23f99mr1106849ejq.21.1707496878145;
        Fri, 09 Feb 2024 08:41:18 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:41:17 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 34/35] linux/kernel.h: move PTR_IF() to ptr_util.h
Date: Fri,  9 Feb 2024 17:40:26 +0100
Message-Id: <20240209164027.2582906-35-max.kellermann@ionos.com>
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


