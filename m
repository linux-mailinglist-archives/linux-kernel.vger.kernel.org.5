Return-Path: <linux-kernel+bounces-163205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EDF8B6728
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933B2283974
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE4520EB;
	Tue, 30 Apr 2024 01:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pIUnrvPu"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794AD17F5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439194; cv=none; b=P3OlU3ILhOEiOgQiOEh/MG5Po++8QHJBLYcXfpkMW7yD1AevGgfyRfLaaRYxE1nagFGGC92GlH7zo22ntweJoq828W8Ph3ga+4t3yM8illAeAVA2dbWZI0lYGNsQlWarjr+AslfyTDWnk1xEp+D21U/x3TBrT5/r2h7btusInUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439194; c=relaxed/simple;
	bh=CQZ+rutb34tlCcqKjJD9BEd+5QtdQSwRC5IuvL3355o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jdUxGCP3Y3SxZsd9IuIocicdGHa05Jghr76pUDvKDVPa8FfxWEcf+UuK/V8CUMKTC1o0qWXYh4ayg4fsDvzQQbe7LSLNYLDT/pKfZ5pI6CPhRddkNc0m7AZMRLKupRzUxX6frv2xFx7rC9zAIaK0rgqTWJc1SB7JQ3LmLz+4PsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pIUnrvPu; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-60f1bd44f4aso3221847a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714439192; x=1715043992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o1ppiacHBGt4deDldEbdpGFMwipyVa+kEjFesHxd+4M=;
        b=pIUnrvPu19HKo6KofwgjMrtkwNpbkF3GtTZC7LSI0Om2iqrAKRwaSaKeS6iw3h9UMV
         ZdMho5vD2PhzadZJAxpE6ayXw1XlXLRsMNaxMSlGjHUfExHrEeg2fHjwScmIDonSCXH5
         uhEydjFRqeuauhJZV2SZWAPL+tLh/TDI3sj8Oe0fbCy+wN5eQeciKbcvhhLBX20/q8Fz
         OGa03/tm23pzRyVtNSL2kJtBf5nReYZMmgMw5j5TZZbGKEwaMYS6Lb2SIW+JIWjT/TzY
         zNkIIM1KBvItOnmFkiYt64OsREUPs9D9bXObKwV394b6NiRULc5/huPoCimnwff1BUUv
         eTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714439192; x=1715043992;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1ppiacHBGt4deDldEbdpGFMwipyVa+kEjFesHxd+4M=;
        b=g3467SoeVcI/Gn3K/KDyRptVeiIVBZXnzM7YtV0akz+BxEx3Sdgqw5QHfJbmewujzX
         +mpxQPvWbNaybf6kuFCAOj4SJdcO9dbf6Kcx2iE34EHtdXA874cEvfP72HJZ5rz/8Xtl
         DeeszPOpHaMMPKMcxQ/iVR7FIvUIwJ0l8ZyLHHHOaYrfLutpGywPsBtV0Zj9Vpr2xXkM
         oRFwWoDdDA1a6weyiz/+Ws580azslk5qM8WXE6F0cMrHDBgRYZTtliVQVvx9d+eQWWc0
         ZpoQsqprafec7PA0hsxLwJcqnLBAvc2H8Im+CtRnHc22PDXOJg4zukdtw97rnqyuCU+B
         YuOg==
X-Forwarded-Encrypted: i=1; AJvYcCV15CYwuziDoCLkhCqBD/gjuU/BYfp+kKhMxiKI1FfhlFPY6U+kDZFeOPtRflvE/Nbe2p1hQjm/SwWyx8wZpkTakE/suq/l6fKfaJVY
X-Gm-Message-State: AOJu0YxIc7pEwlhJUgzUlRcxc5WzS6BCyBn0b3aCIOva3PgJ9dG3X9ac
	9wrGVYkFihixIh8BvOdkafcDvHA9j4Z6Q40Lr93CxzD49iwWTVbE45+yC7em9+8xrqM8inWP7rP
	Hyw==
X-Google-Smtp-Source: AGHT+IH3du7DU4SSas1waSsGTfaKPkaIxmUOV3AAlzhPD+DO0cmHY4Fhz82mZzN9VrX9rQfmrW+YUUXg57Q=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:33c4:0:b0:60a:869f:3a6c with SMTP id
 z187-20020a6333c4000000b0060a869f3a6cmr2542pgz.5.1714439191602; Mon, 29 Apr
 2024 18:06:31 -0700 (PDT)
Date: Tue, 30 Apr 2024 01:06:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240430010628.430427-1-edliaw@google.com>
Subject: [PATCH 6.6.y] kselftest: Add a ksft_perror() helper
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


