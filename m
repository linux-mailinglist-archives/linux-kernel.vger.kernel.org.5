Return-Path: <linux-kernel+bounces-163194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1678B6708
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4A81F23B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D90E6AA7;
	Tue, 30 Apr 2024 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GaYb4yUX"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CFF33D1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714438166; cv=none; b=RCpA61whepzzUUMbH6Wq6blIWSbeey/nDYASHR5DSeLpA5BHcB171vT8I33geQHr24rv0xl1BqpfjNCaNFdkvd52DYCoyk6CbVdF9cVhLyG+/tLIrNNtyetZ4mGONECRlQIsjNiUJ3H8p6P0+rMqLxRi2Qgo8tsLrLoURA/SL9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714438166; c=relaxed/simple;
	bh=CQZ+rutb34tlCcqKjJD9BEd+5QtdQSwRC5IuvL3355o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Qd2O7EelKsg5LMyP5SulqJpdRsGTg+nwHSNV1PtyCz7lQi4o0n0lFkJFmyyc3SQgHcxBpseUm9NJ1Phk8TaEh7/KhmR3eD4ial/O+gPKXXGITv6h2RN9nND76cWnhAwoRY/SES4Hd3Czg05kNFiyF+13k25qyEcJmuJXcLpTSpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GaYb4yUX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bbd6578f9so43573117b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714438164; x=1715042964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o1ppiacHBGt4deDldEbdpGFMwipyVa+kEjFesHxd+4M=;
        b=GaYb4yUXbCmmbmZV6ysZZs3f85p6iLWfuWgI9fS5K2ZeZmCp4PxqsgegMZtVKPTZW+
         Yp87VNUXr2ekbURwSsyjeAYb0fxIDLY0jiOLbNjH8dPRFZ/WTKGF6/3I5Q/2xWeTYSXb
         EXQvwPHeIKgoqx4ADeEaf9NuFygAycrodBhZQ8Na55etqhDBb+tH7Ib7G67yct/saZUW
         Jytl5bsyBo1I+W8m5b/9LL0HTY74A9Xc6GwRT24tvpK3Sf+jgdbXzP3FjJkqwBhjw2vr
         29o6eQlK2J5ZXkejW4ZPAPu0zFcZbTOVoLGN+eDa1fL1r6VvEqHYsUfVTAUQcoUdh26u
         QdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714438164; x=1715042964;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1ppiacHBGt4deDldEbdpGFMwipyVa+kEjFesHxd+4M=;
        b=ElHT5KOrmG+52uRyn00IakGSf7xubBiZzUp0M3v0nqBbhA0TVvO2T1FCRXaKgviM+h
         7P9+jwu9qVuX/AC9tm6MkZ3rmxORwJGMSRebvCPdGuyQIPSAPK2Ir5efyljtfy9pPmQx
         yy0O2TBeBR5LgtSEqogbDQK19sspTMgcexOIvx6DF+adEpYMUU//yWqeT2yCtf4Au0hi
         H10yCRzqJDJclcM4U8cnbouRQtwkWNEOfJXU79dhNG58NDk19r1ka5OZCqHiYhipFhMp
         W43Qi0lxshsQHUd/fINGF0sdrvXzaYBog4nKsLwkTX9ZLeQVL4i2TxH6+rjA+JI9m+Us
         2XJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBQPD+CWjlVYiCQ/B8tKc0tYDYpUchgIOc5kB9A1ImkgnRh1Y+LyjVsWnlHByd+3SpZerNe+ZQqj/JTORbNaXw/qF+BcVvwmoiPLwR
X-Gm-Message-State: AOJu0Yyk0iTepLrLG5NV9rveCnMO7Q0SV7EVGeUV/byHh9xgtJL9d7/f
	+KXMPVAa4DvIT8I9shrH4qwXt3eAByT9884lydOtS25rSLSKW5U4s9CUU3kGRmNBqpFpyJQnywS
	cUg==
X-Google-Smtp-Source: AGHT+IENnLlqrYtXCXtylGWiSBp8/4kI2FR3F2c3tGK00X6zJWwQq7PGDw9yYT+bwAFRgrPuE9Ry+c7gJvM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:20ca:b0:dc6:d233:ffdd with SMTP id
 dj10-20020a05690220ca00b00dc6d233ffddmr4176106ybb.0.1714438164494; Mon, 29
 Apr 2024 17:49:24 -0700 (PDT)
Date: Tue, 30 Apr 2024 00:49:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240430004909.425336-1-edliaw@google.com>
Subject: [PATCH] kselftest: Add a ksft_perror() helper
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc: kernel-team@android.com, Mark Brown <broonie@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Edward Liaw <edliaw@google.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 907f33028871fa7c9a3db1efd467b78ef82cce20 ]

The standard library perror() function provides a convenient way to print
an error message based on the current errno but this doesn't play nicely
with KTAP output. Provide a helper which does an equivalent thing in a KTAP
compatible format.

nolibc doesn't have a strerror() and adding the table of strings required
doesn't seem like a good fit for what it's trying to do so when we're using
that only print the errno.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Stable-dep-of: 071af0c9e582 ("selftests: timers: Convert posix_timers test to generate KTAP output")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/kselftest.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index e8eecbc83a60..ad7b97e16f37 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -48,6 +48,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <string.h>
 #include <stdio.h>
 #include <sys/utsname.h>
 #endif
@@ -156,6 +157,19 @@ static inline void ksft_print_msg(const char *msg, ...)
 	va_end(args);
 }
 
+static inline void ksft_perror(const char *msg)
+{
+#ifndef NOLIBC
+	ksft_print_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
+#else
+	/*
+	 * nolibc doesn't provide strerror() and it seems
+	 * inappropriate to add one, just print the errno.
+	 */
+	ksft_print_msg("%s: %d)\n", msg, errno);
+#endif
+}
+
 static inline void ksft_test_result_pass(const char *msg, ...)
 {
 	int saved_errno = errno;
-- 
2.44.0.769.g3c40516874-goog


