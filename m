Return-Path: <linux-kernel+bounces-84140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D563786A2C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CA82871FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EA85579D;
	Tue, 27 Feb 2024 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fHCiwZyr"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5116755783
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074020; cv=none; b=mztzGaaytYUk50oYcPR6Hlkp62iKZvsQ1RDr1DkwqJprl+tTtRpvOHJdooM8K6lztSXp7Rz9brVVi4Scd/uzWvJ8+DwUEARqaVGl9EPAjHymBxMyrsCI3Px84UdroBFGmHFIlvi5WXN6ei5YY9egKjw+23+Y2PQA5iKd508ioWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074020; c=relaxed/simple;
	bh=9Fi67i95/kAeREHqLFvk3tyaog6fahIgnSjOjLdnjT8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ynm6pYE58g7aaLWI4+jCt6UhtZcZD1Wims2Yc+Vyydmj8yE5EYS4sYOMI6GvXy+kXJitU/eXrKdBeGxoGRkR2TercJxLmh+UP0e1sZWua0SjW/tkLZ/E6kMaxk4dn264iRRihuyAT/LySQYPgqjd3Uygy39F7VSY+DJb9domqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fHCiwZyr; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so3340503b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709074018; x=1709678818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLVwRTSD9ZA8wnLZflOwUZvL7Dh0SCpTGUEycKGf948=;
        b=fHCiwZyrjoe1pAMv04eVduZbZwUkAR2iLSHd0nvXsQbZTvo9ivE/h2UX/r5Qas2ruA
         3EtggsaA3LAYxJdbFnLZWDYPftdwFOUgfNIwmDomzMmzxAGqcUbSINZ/p4DU0r+rNyg2
         RM19tmMshoCd0dNAQIZ4/svtafzfio7sGRV8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709074018; x=1709678818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLVwRTSD9ZA8wnLZflOwUZvL7Dh0SCpTGUEycKGf948=;
        b=jXiR40Qzk8CyYtxt6yeD/GTJb0ZbaXPpXNvDyoKq0+4XjpNetxfaEJUAtWZ/VghG9j
         A4EfSq6+drnCtnv7ZsCL/4OK7tUUR8stVvgLBuDe820/dCnt6th73lX/JDlC+lv0FCpA
         mdPLYuXAt6PGm8jbUOy9GCzc9reUyHnoEcruXMAOflg3iKJ6Sb+B1Zk+voAZnYEgEh/D
         blAzYhazWpEueuJgMN+RfX8+qsHHux7Bn5yANaPgE4fJRwIrId8LcKpwjsaZrO4OlhTb
         ODAj4BJ3c98VPMZwT9M5DH317K8eWyup/bH3zGLY5rIdnpFcIZULSF8yr2Yem5rQFnqi
         Vw+g==
X-Forwarded-Encrypted: i=1; AJvYcCX10reWm0qAue2xytGFfabZf7U3yW3+kGdsPRprIj4+ses1+S+qQmzIa7c6un/6nttR/Y3JI/uxyBTNnl9KwPC1viMyUC36mGb6V3ar
X-Gm-Message-State: AOJu0YxEsjzclYYBzNDq5ZMLLUaD+4T2xIC5XRhtkE4GKRLDlp5CCm1A
	l7fxnUO5DEHOKy/o534vRF3lpyTay1agJOmYSaIczEgXQCNRYd5VjQyuMFWvyw==
X-Google-Smtp-Source: AGHT+IFL7/hUbHtEX+C8ENjORP0ILArfVaCkvARMjulurnSQ6MhJue6ixDwTvfM+Se+ZdgDRLrC+uw==
X-Received: by 2002:a05:6808:114b:b0:3c1:aace:475e with SMTP id u11-20020a056808114b00b003c1aace475emr4314155oiu.1.1709074018445;
        Tue, 27 Feb 2024 14:46:58 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c10-20020aa781ca000000b006e4ce93dc28sm6462431pfn.104.2024.02.27.14.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:46:57 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kees Cook <keescook@chromium.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] lib: stackinit: Adjust target string to 8 bytes for m68k
Date: Tue, 27 Feb 2024 14:46:56 -0800
Message-Id: <20240227224653.work.603-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2886; i=keescook@chromium.org;
 h=from:subject:message-id; bh=9Fi67i95/kAeREHqLFvk3tyaog6fahIgnSjOjLdnjT8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl3mZgX4RYYkhnet9g+fNYxlAk16036/x70gZOB
 gwF8N+55sWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZd5mYAAKCRCJcvTf3G3A
 JpHzD/4/WTvgh1uRidbb9W95fV24HgJlTmIR5Dxy7PCQrI4dYNV+OG8l4P7CbVXbAfW5xHELhEW
 SmPi0XdYHDlXEWGKOMeqzD8H399fuUfIenhcw/ahukDnvSc+4tt5x/5QCB4q+01me6BIETQOxnm
 jGT4eFF4rEYOmRjx5g1PoQx13kdH5MqWHRxI6uyYBi0yoomwckog4OoDIxAK+euzD/KTnYYqsN8
 5uQ71dcFzRdTsZJkYmZJzFB/r0RR9Plk0WkVrDiJ+XgJcDuwbtjQDHiDk3V9VRI8BV5vLfeIWx8
 BNCpEdJ5KKHCcEso+n69DN7I2O1uQLP4vvWg0k3dQgB/h0bhW+61xwoz7DLmren7abhpZXToMTw
 FtY0DLy9PUzRBFCSwVm3BSIjW7yHT0/GGRdgU1ZrLWpxGd2WY6U3bR+G4uHu/tg4ljRGV8hb8JV
 vqFqp6ywVMeSEZnKipNmYs37+/Dj6y9NKelGdcFO7XoW8uenDUyJMlmVkNSMF2tGzIh3CPVVJpK
 Jc9MsguYXiTk4UKN4kqqOV2VRaKDYFm5DIEIDeH55i9V9MX2+n1vTg/uABHwNqXsJpIAKfQ1d8t
 u0h+9GCBQO5SAdMVIco8IVfK9M8IMiPZWNM5zG/UaYa914WHH4LO3OuBInpAWMM5gxGdwGYPqOy
 Pednaz4 9+/FuD2Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

For reasons I cannot understand, m68k moves the start of the stack frame
for consecutive calls to the same function if the function's test
variable is larger than 8 bytes. This was only happening for the char
array test (obviously), so adjust the length of the string for m68k
only. I want the array size to be longer than "unsigned long" for every
given architecture, so the other remain unchanged.

Additionally adjust the error message to be a bit more clear about
what's happened, and move the KUNIT check outside of the consecutive
calls to minimize what happens between them.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/lkml/a0d10d50-2720-4ecd-a2c6-c2c5e5aeee65@roeck-us.net/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---
 lib/stackinit_kunit.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/stackinit_kunit.c b/lib/stackinit_kunit.c
index 05947a2feb93..dc3c68f46f0a 100644
--- a/lib/stackinit_kunit.c
+++ b/lib/stackinit_kunit.c
@@ -63,7 +63,16 @@ static bool stackinit_range_contains(char *haystack_start, size_t haystack_size,
 #define FETCH_ARG_STRING(var)		var
 #define FETCH_ARG_STRUCT(var)		&var
 
+/*
+ * On m68k, if the leaf function test variable is longer than 8 bytes,
+ * the start of the stack frame moves. 8 is sufficiently large to
+ * test m68k char arrays, but leave it at 16 for other architectures.
+ */
+#ifdef CONFIG_M68K
+#define FILL_SIZE_STRING		8
+#else
 #define FILL_SIZE_STRING		16
+#endif
 
 #define INIT_CLONE_SCALAR		/**/
 #define INIT_CLONE_STRING		[FILL_SIZE_STRING]
@@ -165,19 +174,23 @@ static noinline void test_ ## name (struct kunit *test)		\
 	/* Verify all bytes overwritten with 0xFF. */		\
 	for (sum = 0, i = 0; i < target_size; i++)		\
 		sum += (check_buf[i] != 0xFF);			\
-	KUNIT_ASSERT_EQ_MSG(test, sum, 0,			\
-			    "leaf fill was not 0xFF!?\n");	\
 	/* Clear entire check buffer for later bit tests. */	\
 	memset(check_buf, 0x00, sizeof(check_buf));		\
 	/* Extract stack-defined variable contents. */		\
 	ignored = leaf_ ##name((unsigned long)&ignored, 0,	\
 				FETCH_ARG_ ## which(zero));	\
+	/*							\
+	 * Delay the sum test to here to do as little as	\
+	 * possible between the two leaf function calls.	\
+	 */							\
+	KUNIT_ASSERT_EQ_MSG(test, sum, 0,			\
+			    "leaf fill was not 0xFF!?\n");	\
 								\
 	/* Validate that compiler lined up fill and target. */	\
 	KUNIT_ASSERT_TRUE_MSG(test,				\
 		stackinit_range_contains(fill_start, fill_size,	\
 			    target_start, target_size),		\
-		"stack fill missed target!? "			\
+		"stackframe was not the same between calls!? "	\
 		"(fill %zu wide, target offset by %d)\n",	\
 		fill_size,					\
 		(int)((ssize_t)(uintptr_t)fill_start -		\
-- 
2.34.1


