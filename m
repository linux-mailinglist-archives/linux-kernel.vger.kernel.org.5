Return-Path: <linux-kernel+bounces-108745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAD7880F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C381F21ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09E23C6BA;
	Wed, 20 Mar 2024 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iQOMFP5U"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD393BB50
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929939; cv=none; b=GDlBGQknxIQhXyiFOmAV6svY3CC3QWeS923ZVHKz+8ogDH6TdXL/0VrkbOqVMs722rzHllgeJNFeJY8n3/tPnSUPr4ifGEsgHzywp+oIy/Q6nNEeECacCBdI+txIat0XrC8tJS/W9SykpVxGfyhM2r0BXs2/zQ9fAy+xMZ8zGfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929939; c=relaxed/simple;
	bh=AmAmCe23OTfeKAUnrQCYn3TUQz3Ynnj28Y0Z07KqhW4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rK5S+K+TnlcBHXtNi9YMjv69u0QW4035PakI/QgLHtusWfUQoQRvpsCYQa3ngDm5RhUWLJyy8nwKOGH3o3vS/YPP4P2Ox+tf1J7eRQMOCSTW5RqV4uQJptAu53d6N8o51M5t6a/JcumPd3t0O/pziXPU7RkpgfmjMB933jrf+xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iQOMFP5U; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-559555e38b0so4162692a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710929936; x=1711534736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pe97FWHITdYkiCtSSFDy2YJv9pSAbWKeZZSBy5Rk1y0=;
        b=iQOMFP5U4iw6oP25OGP2qZaurAI92VB639kebcVe75DUBSRnKufnKTtyq+LJ+nDTl6
         dcpYNKmbJASQ5QbXT7JBCGMHdEctVNKlgi7jHIn+PUKYo0B/aG/HY5ofmqgwCBuHbPrR
         IhvqOY350VoVyOxmtN+KEe4vKA+kgMUKUBSCjNcxozQBI6RfEIEXOAkfWK31axtCjfz/
         VU74PlfVOi3lsTTpQd3kHqx3diSvgxWpmqZqzs4mLw/BTzCjViK/wyKAn4uDBXKTuHYr
         wtRR/mI37yB+TX3InBGAnnNwN+7Trbvg8FBDZJ1i9gNS5ek89fB1NdUAPu1YrOQ2spW8
         iyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710929936; x=1711534736;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pe97FWHITdYkiCtSSFDy2YJv9pSAbWKeZZSBy5Rk1y0=;
        b=kiOavtW5YmrkmClOS0gIV8PJyHlh8kFcGpZnqOtIt3oamemylMhcPm/krAMgbhBRpJ
         tLDYVcF+iYAS5fOxcaxuCiTc8aAuwiUi1ROFAPjmH/wLl/pf7sKoHtUcEzQZg8iqXiLV
         AC1Gv0ZIHw7bnX7gR5okpUo76X9nfxg2uqhSxbZ0bbTIzrQtiOtK3p14DbUyeBl9/QvI
         hP/UzNwk5Td2Sfvjs1vRoh3lzdaaJRkLsqP7pFxh6jl9LTz4QA5J4zZ26eR7ww+6+cgf
         +flWhjgcSyOjAVL9k9q17WmgJvEXXAqJPkzS9+VnxrA8khtea/ZnW2xJDFu5J+umhKWJ
         et9A==
X-Gm-Message-State: AOJu0YxIrYDPfy+1sktgEBPOaHGrjUldF+a+qVxIfD0GtHy0tdkcUGx7
	MlzdYgWGWoibd7TThJtOOZio3jvGvub0KDCiXsn6HfH2WZmcgfsLQ/HM9V08rtNDSi9TcioFy91
	Ybg==
X-Google-Smtp-Source: AGHT+IFgq13bXMs5IFwZBCUn9d8o9CaVR4UgE59VD0DZm2aj6+589s0p0zY44eyaCf7x/WiMresCTSv8JYs=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:2234:4e4b:bcf0:406e])
 (user=glider job=sendgmr) by 2002:a05:6402:3893:b0:568:a515:30e8 with SMTP id
 fd19-20020a056402389300b00568a51530e8mr77979edb.0.1710929935435; Wed, 20 Mar
 2024 03:18:55 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:18:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240320101851.2589698-1-glider@google.com>
Subject: [PATCH v2 1/3] mm: kmsan: implement kmsan_memmove()
From: Alexander Potapenko <glider@google.com>
To: glider@google.com, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kasan-dev@googlegroups.com, tglx@linutronix.de, x86@kernel.org, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Dmitry Vyukov <dvyukov@google.com>, 
	Marco Elver <elver@google.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

Provide a hook that can be used by custom memcpy implementations to tell
KMSAN that the metadata needs to be copied. Without that, false positive
reports are possible in the cases where KMSAN fails to intercept memory
initialization.

Link: https://lore.kernel.org/all/3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp/
Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/kmsan-checks.h | 15 +++++++++++++++
 mm/kmsan/hooks.c             | 11 +++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/kmsan-checks.h b/include/linux/kmsan-checks.h
index c4cae333deec5..e1082dc40abc2 100644
--- a/include/linux/kmsan-checks.h
+++ b/include/linux/kmsan-checks.h
@@ -61,6 +61,17 @@ void kmsan_check_memory(const void *address, size_t size);
 void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
 			size_t left);
 
+/**
+ * kmsan_memmove() - Notify KMSAN about a data copy within kernel.
+ * @to:   destination address in the kernel.
+ * @from: source address in the kernel.
+ * @size: number of bytes to copy.
+ *
+ * Invoked after non-instrumented version (e.g. implemented using assembly
+ * code) of memmove()/memcpy() is called, in order to copy KMSAN's metadata.
+ */
+void kmsan_memmove(void *to, const void *from, size_t to_copy);
+
 #else
 
 static inline void kmsan_poison_memory(const void *address, size_t size,
@@ -78,6 +89,10 @@ static inline void kmsan_copy_to_user(void __user *to, const void *from,
 {
 }
 
+static inline void kmsan_memmove(void *to, const void *from, size_t to_copy)
+{
+}
+
 #endif
 
 #endif /* _LINUX_KMSAN_CHECKS_H */
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 5d6e2dee5692a..364f778ee226d 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -285,6 +285,17 @@ void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
 }
 EXPORT_SYMBOL(kmsan_copy_to_user);
 
+void kmsan_memmove(void *to, const void *from, size_t size)
+{
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+
+	kmsan_enter_runtime();
+	kmsan_internal_memmove_metadata(to, (void *)from, size);
+	kmsan_leave_runtime();
+}
+EXPORT_SYMBOL(kmsan_memmove);
+
 /* Helper function to check an URB. */
 void kmsan_handle_urb(const struct urb *urb, bool is_out)
 {
-- 
2.44.0.291.gc1ea87d7ee-goog


