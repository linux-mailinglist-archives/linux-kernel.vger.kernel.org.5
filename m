Return-Path: <linux-kernel+bounces-141223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8411E8A1B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A002288552
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7824320537A;
	Thu, 11 Apr 2024 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eC1tdv7U"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5712C204A10
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850232; cv=none; b=pZQq7F2bCATcGzOqGZkW4NCrA74UMpWwIMhRmJMLXJGD3RHYq7B+NWcXMyYV0wy2YzMfqTcN/fh3apirbVkuK1kbC3vzXdP0R6DBf2ROR9Mc/OWj/MPt5cA6fdHbb4qlMxbH21ioRP7qAflPbw+YMJ2m7HCkfoprakJTtIwiaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850232; c=relaxed/simple;
	bh=UMggqosULg5752cqa95i9iJARi5Q6wzh/nFYd55Lugg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXgdizVSEprlRmVOej7ZDz84XJnVgRwcwqmpBmvMrKuPSt7gQ2NSYCMGsqqZWY2X5TA4JhjbWiUyOiWQ6qoHsLhW0J3SWQzRK+gsD8fN3ZlwoKo1uHduKOUJl1nwAduEdEclfglPt2nsXp+x81LTZFgPrnXKKpdZIIkAiphU5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eC1tdv7U; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69708039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850230; x=1713455030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+zMONw+XuavXi4H+iqiLRXmWKO3JrdzsvcOsYY+R2U=;
        b=eC1tdv7UkL5/5SVazBe5jYQD2kRMzwVhKYunXeWVWHgQZSRteUxug4q2tS0ggkhEbH
         k9BiSX53FUE7J28+5So9NfY9gVVxrZAySruiI6cVL5YVMwoS7kKXBj/3SiYm0Ryg5ylp
         ZOwDRcDOvgv5XXGgrxwlXnfz/xZcP5MOLO2DRgswmG+SF/RK0ifcUWju3adhMEusW14Q
         8vR5nr/BcOLLmCk7vp1LuRRXYpb2zBh7BpR+071LxcoU801FsSR3tDsTGT+nOou6DlFE
         BfeFp9CmitwB3d+MTl8zcBXu2vlRGwcKMIhKPQjk5a9Uf1q+nsw/feVtMEejwyih7mGz
         /JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850230; x=1713455030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+zMONw+XuavXi4H+iqiLRXmWKO3JrdzsvcOsYY+R2U=;
        b=QuPXcKLjAWXIFsK3x8GC8MSlidL1JEYoZyy3/q7z5A3hJhkq7b2t1K321ciZ4AY2ud
         9YXcnnEyC22LQIb22YKg9XbyNTAuk1ZAGvLXU6hI5b/V1td+Ms+V6a5Pic8SxrSeggwr
         wLXK1+bhMIDaqwW3g1bxqYsHHjUtVRbKRo3ytVVxmRv+V49gXh3ZURNSz3/QiWDZl5cT
         i7OMd67mdcOKM1yCHMRUm+R7CjkESM7nqJU0dyGhInqwSkYNdWYQckZBnLdxXJSrmF6j
         Svtv8//a4fiH7pIeXl2BLK2ksj2OH2xP1iTx1xGuGgAApxxuC1TUkthXFHXWbQl8TpcM
         lYsA==
X-Gm-Message-State: AOJu0YyvKdmV9RlvMJY83CNvdp9uVE4DvZLnghydZ66bm6RnNIAjotH1
	pqZlUfSChVfPMRoJbXRrwyPG1nlXAsV7rSi2wofZnxXRjqdRCUMqXG3k7qYH6HqlllgcuXH37ax
	N
X-Google-Smtp-Source: AGHT+IFX/j1GBEWVL2id0KYwira3udzeGr7D/E9GmGrm8vmPN9R5UdjIjkOlECFdtNJ2YoIDMDqY0g==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr212988iop.1.1712850229998;
        Thu, 11 Apr 2024 08:43:49 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 436/437] kstrtox: remove (now) dead helpers
Date: Thu, 11 Apr 2024 09:19:36 -0600
Message-ID: <20240411153126.16201-437-axboe@kernel.dk>
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

This drops:

kstrtoll_from_user()
kstrtol_from_user()
kstrtouint_from_user()
kstrtou16_from_user()
kstrtos16_from_user()
kstrtos8_from_user()
kstrtou64_from_user()
kstrtos64_from_user()
kstrtou32_from_user()
kstrtos32_from_user()

as they are no longer used in the code base.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/kstrtox.h | 26 --------------------------
 lib/kstrtox.c           |  6 ------
 2 files changed, 32 deletions(-)

diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
index 229e0162849a..2fa469860c42 100644
--- a/include/linux/kstrtox.h
+++ b/include/linux/kstrtox.h
@@ -98,15 +98,9 @@ int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
 int __must_check kstrtobool(const char *s, bool *res);
 
 int __must_check kstrtoull_from_user(const char __user *s, size_t count, unsigned int base, unsigned long long *res);
-int __must_check kstrtoll_from_user(const char __user *s, size_t count, unsigned int base, long long *res);
 int __must_check kstrtoul_from_user(const char __user *s, size_t count, unsigned int base, unsigned long *res);
-int __must_check kstrtol_from_user(const char __user *s, size_t count, unsigned int base, long *res);
-int __must_check kstrtouint_from_user(const char __user *s, size_t count, unsigned int base, unsigned int *res);
 int __must_check kstrtoint_from_user(const char __user *s, size_t count, unsigned int base, int *res);
-int __must_check kstrtou16_from_user(const char __user *s, size_t count, unsigned int base, u16 *res);
-int __must_check kstrtos16_from_user(const char __user *s, size_t count, unsigned int base, s16 *res);
 int __must_check kstrtou8_from_user(const char __user *s, size_t count, unsigned int base, u8 *res);
-int __must_check kstrtos8_from_user(const char __user *s, size_t count, unsigned int base, s8 *res);
 int __must_check kstrtobool_from_user(const char __user *s, size_t count, bool *res);
 
 struct iov_iter;
@@ -119,36 +113,16 @@ int __must_check kstrtou16_from_iter(struct iov_iter *s, size_t count, unsigned
 int __must_check kstrtou8_from_iter(struct iov_iter *s, size_t count, unsigned int base, u8 *res);
 int __must_check kstrtobool_from_iter(struct iov_iter *src, size_t count, bool *res);
 
-static inline int __must_check kstrtou64_from_user(const char __user *s, size_t count, unsigned int base, u64 *res)
-{
-	return kstrtoull_from_user(s, count, base, res);
-}
-
 static inline int __must_check kstrtou64_from_iter(struct iov_iter *src, size_t count, unsigned int base, u64 *res)
 {
 	return kstrtoull_from_iter(src, count, base, res);
 }
 
-static inline int __must_check kstrtos64_from_user(const char __user *s, size_t count, unsigned int base, s64 *res)
-{
-	return kstrtoll_from_user(s, count, base, res);
-}
-
-static inline int __must_check kstrtou32_from_user(const char __user *s, size_t count, unsigned int base, u32 *res)
-{
-	return kstrtouint_from_user(s, count, base, res);
-}
-
 static inline int __must_check kstrtou32_from_iter(struct iov_iter *src, size_t count, unsigned int base, u32 *res)
 {
 	return kstrtouint_from_iter(src, count, base, res);
 }
 
-static inline int __must_check kstrtos32_from_user(const char __user *s, size_t count, unsigned int base, s32 *res)
-{
-	return kstrtoint_from_user(s, count, base, res);
-}
-
 static inline int __must_check kstrtos32_from_iter(struct iov_iter *src, size_t count, unsigned int base, s32 *res)
 {
 	return kstrtoint_from_iter(src, count, base, res);
diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 111231cb4148..e8a603954396 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -438,15 +438,9 @@ int f(const char __user *s, size_t count, unsigned int base, type *res)	\
 EXPORT_SYMBOL(f)
 
 kstrto_from_user(kstrtoull_from_user,	kstrtoull,	unsigned long long);
-kstrto_from_user(kstrtoll_from_user,	kstrtoll,	long long);
 kstrto_from_user(kstrtoul_from_user,	kstrtoul,	unsigned long);
-kstrto_from_user(kstrtol_from_user,	kstrtol,	long);
-kstrto_from_user(kstrtouint_from_user,	kstrtouint,	unsigned int);
 kstrto_from_user(kstrtoint_from_user,	kstrtoint,	int);
-kstrto_from_user(kstrtou16_from_user,	kstrtou16,	u16);
-kstrto_from_user(kstrtos16_from_user,	kstrtos16,	s16);
 kstrto_from_user(kstrtou8_from_user,	kstrtou8,	u8);
-kstrto_from_user(kstrtos8_from_user,	kstrtos8,	s8);
 
 #define kstrto_from_iter(f, g, type)					\
 int f(struct iov_iter *s, size_t count, unsigned int base, type *res)	\
-- 
2.43.0


