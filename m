Return-Path: <linux-kernel+bounces-107850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEADF880279
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B71C1C23134
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8B912B72;
	Tue, 19 Mar 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zRUH3r6c"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1EEF503
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866226; cv=none; b=mRk951JXIm+SSFFShdn3R2JKUjcd6QusfX4gTuIUHUJoB2rGVgI58hBDEa4y/bM3FXXmoYXVFPp6BuXjLqiPSgtiK0IGy9wrUXETVYz5qPcrq5N3D3VvuuQ2e7froDPSBOOcxCdZxfOtUxhZob8kG+Jyjs8Tcbevb4IZdzT0v7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866226; c=relaxed/simple;
	bh=O6tXVs+34cEh+tLprQCEZh7elrA+qTEPzdN8iNoCkbY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uhm2WR5YOCezN1m94XCthDkkK9i5gPTPZWBvbKxhG5+y7N5VE4ekg/EdYMhYLRSB3cb+G8/MlNAJeFBoy5/cnd+BysJQxFvjIn0ASSShTtVsrMrH1PAGbA9xktOFdERE3zpDSOkP7MgGnjdyB9oCIhZw+ujGcJbgmCdPcqRf0mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zRUH3r6c; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a61b31993so99512537b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710866224; x=1711471024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k4w49nfOoRyLntHEj6xF46Ct9MhFoMry9itEqGksxZs=;
        b=zRUH3r6czim+O/J5uQipDiYy4w47vcarkwx8Ioq3WhPFvkXPA46YHZVGmZo9CKE8a1
         c4ICnYBEfCdwrtJxT8YwbfRomRQYgSqiSpwKFh9sBtotNkRuVTV7M3A01/A0HPKdNDsF
         e01HAYzA8AwHqHUTs+9Kb0xpu99gDYSo239gyE+Z+MFKPus7teSNi4WPJlzhgMPZAtlT
         RXjCXHSlVGQFsOmxHO6gHg5YSqRE58yd6C8wSgbvQ/re4PflKhESzQNfFKlgeicmybVd
         iIxf+4/rKJyAx3PBdlshg8wUViMg6nog3VLaCghHKlV2jzpNGDPUgOVhWBm95PxCu/gF
         2pdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866224; x=1711471024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4w49nfOoRyLntHEj6xF46Ct9MhFoMry9itEqGksxZs=;
        b=qKVemtl1XXbBg/Tsm6bETQH8yAVRPwpUc63TTLZDRJCz87D2KvnrSrTFW9tQTSpi2H
         S9A5x7pqNvgEVFmZFf6Ylrg4I91WPvMdclxsSPJPHR9Lz360kBaLML8Vg+Cpxq/iVf06
         bRlV2A/GWm+J1tXlhtBInGFivITArvONaCbcfpu+SQsX4ffv2M5ZZP/30QS2nkDaqwpA
         fyKL3QU4Y9Euc/ZvTLuM95/itXYBliLVLOj9dXsQZiraau0Qx9SEPx3na/HbmkeoYfFu
         m2o3nfVZLUaZBhcq2i+h+OiTRVYI8KhmK41UWYNWMs5ovZFmTHcDB7YPMlyJNZ3+Lf4P
         P7ig==
X-Gm-Message-State: AOJu0YyhQzHv0yaTUuxfy+sfB6+HtEoojB88PvG6vrYBd6TKrzK5fwTU
	f0jc+/CSIE7RIXrFqSBfOeCNj8HtqLXmbDNFcl52yjze61Td4ev34qxgYuUj7PusIlRQMxHLSML
	Xvw==
X-Google-Smtp-Source: AGHT+IE2b5132XOPzd/fmc5XbsJpCg/epKdPr4l7eMqrWTqkXllllbtWoCJvakx0igbVQQYRl57Kyez91XQ=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:2234:4e4b:bcf0:406e])
 (user=glider job=sendgmr) by 2002:a0d:d413:0:b0:60a:3d7e:2b98 with SMTP id
 w19-20020a0dd413000000b0060a3d7e2b98mr825284ywd.4.1710866224161; Tue, 19 Mar
 2024 09:37:04 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:36:55 +0100
In-Reply-To: <20240319163656.2100766-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240319163656.2100766-1-glider@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240319163656.2100766-2-glider@google.com>
Subject: [PATCH v1 2/3] instrumented.h: add instrument_memcpy_before, instrument_memcpy_after
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
 include/linux/instrumented.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 1b608e00290aa..f5f81f02506eb 100644
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
+ * instrument_memcpy_after - add instrumentation before non-instrumented memcpy
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


