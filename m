Return-Path: <linux-kernel+bounces-140765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038498A18D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC321285EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC5439AF8;
	Thu, 11 Apr 2024 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="McIhebS8"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7C82CCD7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849504; cv=none; b=hxw9yIKClyIhwVrIxNvocgX9uVLCxwrpaaL2GnojzhsMFcGf4X20JsqhHfSJyh/KCrzdY5uOAVRjfPuc3JbPTc4IGrySM3r2CRFN1UsOQVNkjrLoRJd8qkslBd3zGy0+ZqM6XLVYtHyZOQM+c4jMfc1i+oGSGEfjDBI/CAZUzrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849504; c=relaxed/simple;
	bh=K4xrpBkBULCPGCK6Fk/4G7Z9fGrD0D6lk+vhi/Trff0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ru3DOo6zJedyISEBQkU3uvncmN3OI3yeCRAWN++dgr9hcrqUOgNRZpIxiXviFx4TZJEMTLij4UUwzL+OudfQQ0UmfQNqmeXMxDP5268TuVl4we/LicNZQDBsjftdGTj8RPpLUnBNzDq+okklZtMEEON8XiGNgRTpfHXQrdC08OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=McIhebS8; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso57929239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849502; x=1713454302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCogxoXjyeDKdqdv8xf2XbvXdN+C9HMoIzzJ43HJyBA=;
        b=McIhebS8/O+HgZ86ruanw3ewFK9mjOZ/Zdu5E6+ZGquDJkSbqGJl+61hQNmkqRx6Zn
         J0QQR7mSIOHe9y5ZwHXCGjriSY7yWgoXMlw305BY130uh6OokGYw8/y+EOVPuLPHbzZ0
         tqSe1WTZw15z3Lzom9U3Xv4m5Yx0FYC3IDVkhKngjWSV0zOx4YKQ2JFbmjpfUHtKg5hs
         536AnFy5xsMLYnvPXOIpnDdhbZ3720TrjHqo0dAWs4kKI+MQqpC4svEQ/pRi+rmYbQXC
         FHXKuS5sjoMPsGL93i5u/vmUqKVCpesKM6ytj0w4Xv9g+1i90IW/v8AKkHZM4eYVwkBh
         l4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849502; x=1713454302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCogxoXjyeDKdqdv8xf2XbvXdN+C9HMoIzzJ43HJyBA=;
        b=HvGto1ckKaCZIn/W8jagNKYv9bpiX9FGmDinrWYY1XgddF9tdnwht2hhW/rDtak1UM
         cDzjG7MH0jrDw2enIFfvSJ2nj5KMXQjdavE08LP889KLnqSQfhTiPHaUJuOuQwbJt1Vk
         Ys48YgG4Z+NYTlH+91iFeuWFwnWk0c7O0Jp22mPtq5ecWD1NoWY9bUOkYEaf5iWyWVvs
         Rot7JdqTrAsqWocBCtA3rJBpNmnCuodCLqdlhOvFwWctKJ4KKGrHkDte+VAnCmuLQMCG
         L6ZOakFuko3yqJjoNHoyODp9LlEEKZjoL363EtQQIN3PXwxGM4dEcT+jFSMKcT2dkBNs
         1A6w==
X-Gm-Message-State: AOJu0YynLpJebshXPdqS1gS4FxkjVfVWrn1T7r1O0flNt4SJ4nfxnQll
	mELsSjvMiVB+AWKpcSwznKhFP4w9NvAfoELvKQr9iI6mII/b9tuKR6umPc3Sj8vxOVKJTMwLqRB
	I
X-Google-Smtp-Source: AGHT+IEtZS1r6Bk6xm7fg8NTSPTSjrP+olCBtoLNIzwnalxIr/A8HbHVHSNMkkkWKwX0QphZrC3QiQ==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr197551iog.0.1712849502160;
        Thu, 11 Apr 2024 08:31:42 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 008/437] kstrtox: add iov_iter versions of the string conversion helpers
Date: Thu, 11 Apr 2024 09:12:28 -0600
Message-ID: <20240411153126.16201-9-axboe@kernel.dk>
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
 include/linux/kstrtox.h | 25 +++++++++++++++++++++++++
 lib/kstrtox.c           | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
index 7fcf29a4e0de..229e0162849a 100644
--- a/include/linux/kstrtox.h
+++ b/include/linux/kstrtox.h
@@ -109,11 +109,26 @@ int __must_check kstrtou8_from_user(const char __user *s, size_t count, unsigned
 int __must_check kstrtos8_from_user(const char __user *s, size_t count, unsigned int base, s8 *res);
 int __must_check kstrtobool_from_user(const char __user *s, size_t count, bool *res);
 
+struct iov_iter;
+int __must_check kstrtoull_from_iter(struct iov_iter *s, size_t count, unsigned int base, unsigned long long *res);
+int __must_check kstrtoul_from_iter(struct iov_iter *s, size_t count, unsigned int base, unsigned long *res);
+int __must_check kstrtol_from_iter(struct iov_iter *s, size_t count, unsigned int base, long *res);
+int __must_check kstrtouint_from_iter(struct iov_iter *s, size_t count, unsigned int base, unsigned int *res);
+int __must_check kstrtoint_from_iter(struct iov_iter *s, size_t count, unsigned int base, int *res);
+int __must_check kstrtou16_from_iter(struct iov_iter *s, size_t count, unsigned int base, u16 *res);
+int __must_check kstrtou8_from_iter(struct iov_iter *s, size_t count, unsigned int base, u8 *res);
+int __must_check kstrtobool_from_iter(struct iov_iter *src, size_t count, bool *res);
+
 static inline int __must_check kstrtou64_from_user(const char __user *s, size_t count, unsigned int base, u64 *res)
 {
 	return kstrtoull_from_user(s, count, base, res);
 }
 
+static inline int __must_check kstrtou64_from_iter(struct iov_iter *src, size_t count, unsigned int base, u64 *res)
+{
+	return kstrtoull_from_iter(src, count, base, res);
+}
+
 static inline int __must_check kstrtos64_from_user(const char __user *s, size_t count, unsigned int base, s64 *res)
 {
 	return kstrtoll_from_user(s, count, base, res);
@@ -124,11 +139,21 @@ static inline int __must_check kstrtou32_from_user(const char __user *s, size_t
 	return kstrtouint_from_user(s, count, base, res);
 }
 
+static inline int __must_check kstrtou32_from_iter(struct iov_iter *src, size_t count, unsigned int base, u32 *res)
+{
+	return kstrtouint_from_iter(src, count, base, res);
+}
+
 static inline int __must_check kstrtos32_from_user(const char __user *s, size_t count, unsigned int base, s32 *res)
 {
 	return kstrtoint_from_user(s, count, base, res);
 }
 
+static inline int __must_check kstrtos32_from_iter(struct iov_iter *src, size_t count, unsigned int base, s32 *res)
+{
+	return kstrtoint_from_iter(src, count, base, res);
+}
+
 /*
  * Use kstrto<foo> instead.
  *
diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index d586e6af5e5a..111231cb4148 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -19,6 +19,7 @@
 #include <linux/math64.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/uio.h>
 
 #include "kstrtox.h"
 
@@ -405,6 +406,23 @@ int kstrtobool_from_user(const char __user *s, size_t count, bool *res)
 }
 EXPORT_SYMBOL(kstrtobool_from_user);
 
+/*
+ * Like kstrtobool_from_user(), but takes a source iov_iter rather than a
+ * buffer.
+ */
+int kstrtobool_from_iter(struct iov_iter *src, size_t count, bool *res)
+{
+	/* Longest string needed to differentiate, newline, terminator */
+	char buf[4];
+
+	count = min(count, sizeof(buf) - 1);
+	if (!copy_from_iter_full(buf, count, src))
+		return -EFAULT;
+	buf[count] = '\0';
+	return kstrtobool(buf, res);
+}
+EXPORT_SYMBOL(kstrtobool_from_iter);
+
 #define kstrto_from_user(f, g, type)					\
 int f(const char __user *s, size_t count, unsigned int base, type *res)	\
 {									\
@@ -429,3 +447,25 @@ kstrto_from_user(kstrtou16_from_user,	kstrtou16,	u16);
 kstrto_from_user(kstrtos16_from_user,	kstrtos16,	s16);
 kstrto_from_user(kstrtou8_from_user,	kstrtou8,	u8);
 kstrto_from_user(kstrtos8_from_user,	kstrtos8,	s8);
+
+#define kstrto_from_iter(f, g, type)					\
+int f(struct iov_iter *s, size_t count, unsigned int base, type *res)	\
+{									\
+	/* sign, base 2 representation, newline, terminator */		\
+	char buf[1 + sizeof(type) * 8 + 1 + 1];				\
+									\
+	count = min(count, sizeof(buf) - 1);				\
+	if (!copy_from_iter_full(buf, count, s))			\
+		return -EFAULT;						\
+	buf[count] = '\0';						\
+	return g(buf, base, res);					\
+}									\
+EXPORT_SYMBOL(f)
+
+kstrto_from_iter(kstrtoull_from_iter,	kstrtoull,	unsigned long long);
+kstrto_from_iter(kstrtoul_from_iter,	kstrtoul,	unsigned long);
+kstrto_from_iter(kstrtol_from_iter,	kstrtol,	long);
+kstrto_from_iter(kstrtouint_from_iter,	kstrtouint,	unsigned int);
+kstrto_from_iter(kstrtoint_from_iter,	kstrtoint,	int);
+kstrto_from_iter(kstrtou16_from_iter,	kstrtou16,	u16);
+kstrto_from_iter(kstrtou8_from_iter,	kstrtou8,	u8);
-- 
2.43.0


