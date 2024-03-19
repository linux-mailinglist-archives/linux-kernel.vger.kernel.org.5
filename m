Return-Path: <linux-kernel+bounces-107849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72803880278
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC567B232FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFB9620;
	Tue, 19 Mar 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQvR/kLP"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8F3847C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866224; cv=none; b=sgbo6NP062hT17+W8FfGahaEgvkU9Wf4Iw9YsjIipGP7fKPKKOjoLpixUtEwyrsT0co4E44KfZFSrOeHj43peebZU4iHnThiPAm8zqdA7j544KrRk0MO1NsWLJrVmdeaqhfDDZRYZNTVpisRQr5NpACUhdEh8i42xJAGRgGWjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866224; c=relaxed/simple;
	bh=AmAmCe23OTfeKAUnrQCYn3TUQz3Ynnj28Y0Z07KqhW4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aYk7u4q+KeEFRau3F71IOpoV1PDbSIVquh/mfHyyG0dSGhy4giF1tQ1Wd61sZkwecEvcagXcTIsIS6EcQcgxi1g2F/ffFa9TtMzNRXDlfl7oog6/iV7BJyW9zSzCRD7xP8xSb4nmeIFOgv8nWK1uYRPPF0l+iheeuB54eE9vjQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dQvR/kLP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a2b53b99eso124173077b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710866221; x=1711471021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pe97FWHITdYkiCtSSFDy2YJv9pSAbWKeZZSBy5Rk1y0=;
        b=dQvR/kLPsdwHqpzPSxWzG8Fw3dy8rzUQ4vQMpfA7a9EMj/A7AycNoVmva48D6CvOG0
         Z7j4mNbz24jf2vyx4NryZFnLDGA7eWUOm17geHF7l5Vkb0Bew9PNVOtsRyJVppAXv1Xo
         HyAz5wYYgojxCLHcrKsjIXLoEiFSZ9ajQ9RBlvkWfKYsg3W/H9AEJF+ewFDiPlpnAFXS
         JWwWq3bnVPNtCjAdz4+YH0gI8GdyuSqkddBN2j/kMFbEWFyHMEgT63ca9ywVxvctSzZZ
         zkG5/VAy1HPbbdjDJRnfrJl/7tJofcKDlBBrzuOWVK3dgRCqAdN0mfTi+6Beu6XTzCfl
         /cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866221; x=1711471021;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pe97FWHITdYkiCtSSFDy2YJv9pSAbWKeZZSBy5Rk1y0=;
        b=CnQZ7g9dj9mc9TvZ8SYXCoWS5T+05xYeZp8WDRYrRiX1wCvph13SbkWAWNU2uNvE+T
         hpRV+ct98CY3lZQL73VRqGVQy4ytEcEX2wAXsEjZRuMyzj7e99cep2Q5EY7yDT9qYshC
         A8ow5uirvt/yTYk68VsD5cDnP2sDrtOuGCNSWK89ffW/b/cuUduct7IuO2rLyyIvlAdR
         w8Tf4C/xvHBttIPGL/xBMjdU0bc5CAEqK0557EDfExVtSWYNBmh2YhiZWkVwM+/VytGN
         XL3uavAfdpdP/tjiwOvGh0DG1ZivyaKb8QPmagv8vQqwqOez4cLICfsHuOGuAwPoFr1A
         eEmA==
X-Gm-Message-State: AOJu0YwxNdUGakytTGaU+xyliUG7Y0AtxAP36o+mLgScU0a7hW/MZi8C
	8oPE94EWeZI1gPIXT1jBi5LZLqVhHfeLdgDRyRA+VqZ3w6MBZ9EaF/Neo1dO7xgRHWloI3ZHgQp
	/gw==
X-Google-Smtp-Source: AGHT+IEz30VBiIgqKB2uLCoDK46fqUug5yjDscbPTqKHvlX6fQbTCw7l6zHUNahzxmdhiA2a5cr8piuX0n4=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:2234:4e4b:bcf0:406e])
 (user=glider job=sendgmr) by 2002:a81:4941:0:b0:610:c60a:bd27 with SMTP id
 w62-20020a814941000000b00610c60abd27mr1741328ywa.0.1710866221483; Tue, 19 Mar
 2024 09:37:01 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:36:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240319163656.2100766-1-glider@google.com>
Subject: [PATCH v1 1/3] mm: kmsan: implement kmsan_memmove()
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


