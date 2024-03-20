Return-Path: <linux-kernel+bounces-108748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86C4880F83
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB18DB21392
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A496E3FB2C;
	Wed, 20 Mar 2024 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0olECfqL"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A80F3D54C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929954; cv=none; b=YiDO0PJsVsYX8XN7nh9SUrj2XxH2ywuZffFGkyd9weBEweKn1WuGa+3SA9DnK4MD06b3sRqGfNZqkECBCQ5n/ISvjo2OeB2HyjFB5xmD+AFIts6tKXPTSydxv6XcqQfNfoWAdDaowkyJUjP4/GjgU4G4p2/3APw78+3llA6RSkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929954; c=relaxed/simple;
	bh=s/w9iCv68HNMLj67aGzBK977nbP9lfQGe1BaWia27tk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lavvNerqv+F1sG01VegpnvDrntS+jHQ4/IpyrspkfYHV4qKLfy2FBOyUBL4lfWPlVcJ7XtrpGeRIO5FHyChWV+DpWfZI1nTH1mxvXRFUJgYxukWOCG1s3gary8UmI5gumcJJvOvISe9eivUBd0x6aEL1tYhPVZDzNZdCYNQzM+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0olECfqL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso9967141276.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710929952; x=1711534752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m0vBJz04bRZVs+p5tf5O60PjHz2OHj3PY0354SOIqxk=;
        b=0olECfqLcSe/nAe0AZRbn656dVOlwE1xVnZ6LzKAW+PxLyGnFfgZZdMh9bGAYdQ3q3
         KSD1wSvdH31j0zubem12gZ0C/90Y6PoXJcgiHUWVlDNEoQ3noXhBaANZBml3E5hPZBJk
         3ISlCh+SZAQs1EIyUH9EY/hKEwk1E49rKAS+xzu7Ui5V+12R9CTrKcZEOJLOt/1xh1w4
         4W4lcV/TcRTtCHK+NHnNyZTItHpaW7uUjfMrnKtUof1samJl8urE32LyUTU/O2MvymWb
         LR8G6S+gKAB+2L0Gfu0SCgLQnrJI1g/qBsE6teVj+UTulj+A4sdfyiZg4TPv4Wwt/tyH
         Nd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710929952; x=1711534752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0vBJz04bRZVs+p5tf5O60PjHz2OHj3PY0354SOIqxk=;
        b=VvDkq6BWWigZ+884OYKDhawjeatyRI9nTkuHhyJBV2AmUmXbLOP3YzkoygyQxIBBmK
         vfed0WRGn/5S1IftLjTlodeLQ9q5cQvZDCw8M+4IPNSeIFFfOHRbnh2azQ9nrQG4uayo
         3tnWUyTGgSA5lFT1543eqlGKAxMpkmLEsOVZzupTRtsNcDbWNw9o4eesNks3rVNG9WrV
         CPPR7U4pG//QTzQUlMdv7Ze4+DG4YSa48wAyfgSNd2y65wDjNXP9ut9aNaiuq2OjFc7G
         3ftEnTGglNotuWsUqHhIw2N3Ge2H7teAIb8chp4/B4QGOKD/x/COp2c0WGUGJxVLCbf3
         fuTw==
X-Gm-Message-State: AOJu0Yw20+WlcmGxynzVJovBFk7A0x/5Sx6jg0m2hGsvwJbzPA6ZTJ8H
	bD32RhlIHl10zXlbRgm4tbI4VcQrS/TujjFDvZP+uMPdCrRbi82bqsZZkPqenQA5M0Go/hR8eVu
	08A==
X-Google-Smtp-Source: AGHT+IFG8zJJFsZTjI1YIaNEwrks7akz88Yk5exPnSeBisyx550nfOfPmsTtY3RfUy1vhUp7VkINpS74JxE=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:2234:4e4b:bcf0:406e])
 (user=glider job=sendgmr) by 2002:a05:6902:2484:b0:dd9:1b94:edb5 with SMTP id
 ds4-20020a056902248400b00dd91b94edb5mr625397ybb.10.1710929952333; Wed, 20 Mar
 2024 03:19:12 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:18:50 +0100
In-Reply-To: <20240320101851.2589698-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240320101851.2589698-1-glider@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240320101851.2589698-2-glider@google.com>
Subject: [PATCH v2 2/3] instrumented.h: add instrument_memcpy_before, instrument_memcpy_after
From: Alexander Potapenko <glider@google.com>
To: glider@google.com, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kasan-dev@googlegroups.com, tglx@linutronix.de, x86@kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

Bug detection tools based on compiler instrumentation may miss memory
accesses in custom memcpy implementations (such as copy_mc_to_kernel).
Provide instrumentation hooks that tell KASAN, KCSAN, and KMSAN about
such accesses.

Link: https://lore.kernel.org/all/3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp/
Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>

---
 v2: fix a copypasto in a comment spotted by Linus
---
 include/linux/instrumented.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 1b608e00290aa..711a1f0d1a735 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -147,6 +147,41 @@ instrument_copy_from_user_after(const void *to, const void __user *from,
 	kmsan_unpoison_memory(to, n - left);
 }
 
+/**
+ * instrument_memcpy_before - add instrumentation before non-instrumented memcpy
+ * @to: destination address
+ * @from: source address
+ * @n: number of bytes to copy
+ *
+ * Instrument memory accesses that happen in custom memcpy implementations. The
+ * instrumentation should be inserted before the memcpy call.
+ */
+static __always_inline void instrument_memcpy_before(void *to, const void *from,
+						     unsigned long n)
+{
+	kasan_check_write(to, n);
+	kasan_check_read(from, n);
+	kcsan_check_write(to, n);
+	kcsan_check_read(from, n);
+}
+
+/**
+ * instrument_memcpy_after - add instrumentation after non-instrumented memcpy
+ * @to: destination address
+ * @from: source address
+ * @n: number of bytes to copy
+ * @left: number of bytes not copied (if known)
+ *
+ * Instrument memory accesses that happen in custom memcpy implementations. The
+ * instrumentation should be inserted after the memcpy call.
+ */
+static __always_inline void instrument_memcpy_after(void *to, const void *from,
+						    unsigned long n,
+						    unsigned long left)
+{
+	kmsan_memmove(to, from, n - left);
+}
+
 /**
  * instrument_get_user() - add instrumentation to get_user()-like macros
  * @to: destination variable, may not be address-taken
-- 
2.44.0.291.gc1ea87d7ee-goog


