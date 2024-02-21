Return-Path: <linux-kernel+bounces-74412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8739785D3AA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1F51C21CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FA03FB2D;
	Wed, 21 Feb 2024 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGexlX5D"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A015F47A5C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507725; cv=none; b=iyiaW+rT/+rTPdZQP1MH1sqEwrYI1GLjwrqEjy8m5wJBqS4vFIK9LEYZDnQ4IFBZ7Nb6fC699Wh927MIko4dWPqbIbfbVKIeqncsnKZwqQ9cpe/5D70GUwwCxcEzd3Ca7n1kesV2Mh1cw76qJflNrj3djEYkdK4l2s/3tHFy9pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507725; c=relaxed/simple;
	bh=MALY8PY87om1B5rM9PQyZB962vp0AzyA5B9YGRQAQS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NdTpx34DrchJ8Bi2Wu96GQBFc8mN3LdAwN27BpKNIH5kdS2Sth9jRmrlzP56D9PA8t2+DQ32dfjR2tFCKPLuHODUMZHH/sTJRGxoyJEVbSNouiAQHhjbB3XcXjYAWrkbtDbH7hhjN52COH0SzQ105EXPTkTDT1sTdr2vyNZpTJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lGexlX5D; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so8825702276.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708507721; x=1709112521; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UtSX1a4twDclpP0XCHq3xRlg28EKI7v3CFBboD2ALTI=;
        b=lGexlX5DBntYPjEQG6RjJ0FVsKToWINsWjjn43Ml34EhA3IoPvQpeE+rqHUk3I1I/h
         YznQjIDQnf+vGqDW/kE++pZBmelMsM/USqvYQHr9gSb8/+c4pFYCh7xQghyqkqpDjBSJ
         CK6jy8ETBZ8fpAclaaj8ACUDL7WGn0N58iow8E2+Hu5NljOEGw0Ji+v+2zJS0XvqjevZ
         ddlYiladtiHjXz/w5QM5wsloX3M1b1R/10seHUoVMyoQsDzYexETHOm7y0xkt4FASDMm
         tweykBtRw4lxmqPktku7Bo0UQJ7if4UHTAXpEBAAJMdODHBZDVEyJBzLvszgVsi5PiM+
         yf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507721; x=1709112521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtSX1a4twDclpP0XCHq3xRlg28EKI7v3CFBboD2ALTI=;
        b=sKva/MEZvD+xTq0YF3x7vndCNnG5fX+A9SYd0yFqIo8is/6vxMztfZTJh9M7yEOKJG
         6bMcUXv9+jsr5i2GkU17UPe/bwKnAe/XBou0rFg1PJPyLdXnXSLkRbLRsTuZTH3emwsc
         1O71U1hCfyjnHduBmObsRsSTe6bDI78No5DSg9zwO5DCJQLVg41Ua5yyUzTvZovuVOB5
         aJpOkqJjdIIQKU1cEnb7fua/ZVJKIH9O9oPnd7VJCClDqGPKJkhpgi9lF3W7iZGxs6Q0
         1B1lEXxccLBmN2pF8nY4/+B5KO6u15Io9gFJq6BYE+xMudquFVetqPbEOzevnfYpUOYb
         oTaA==
X-Forwarded-Encrypted: i=1; AJvYcCUo8IFVAf498MmRqpU8XZjw3+djzC65sC8QyOMgG3+q01ugUwy8UCo1ipiOA7dUrvaGdc+D+rNxXmr3ZDV8b5jVZldvQ06eU9SEGVHJ
X-Gm-Message-State: AOJu0YznHre0hRqJ6kb1z9sxkq7FgFL36FQYo+seesKGDWvzN9nP4051
	6Y04MlEW5jsplM+tt4SOS7SEdbhrlWqS9rTP1AgFktL6joQiZ97VRk2gN0CRwKAnO1DJBJh0U28
	pr70RtwmOLg==
X-Google-Smtp-Source: AGHT+IE+u4BHsnTY4zBV9uwlLnSALfH2VACViqUl+6ZdsI4Ll1wRpv0qUeWfBww+/YNGvG/0sUR+LBCAIAUp6Q==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:4ce:b0:dc7:865b:22c6 with SMTP
 id v14-20020a05690204ce00b00dc7865b22c6mr618682ybs.8.1708507721736; Wed, 21
 Feb 2024 01:28:41 -0800 (PST)
Date: Wed, 21 Feb 2024 17:27:22 +0800
In-Reply-To: <20240221092728.1281499-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221092728.1281499-10-davidgow@google.com>
Subject: [PATCH 9/9] kunit: Annotate _MSG assertion variants with gnu printf specifiers
From: David Gow <davidgow@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Kees Cook <keescook@chromium.org>, 
	"=?UTF-8?q?Ma=C3=ADra=20Canal?=" <mcanal@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Matthew Brost <matthew.brost@intel.com>, Willem de Bruijn <willemb@google.com>, 
	Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>
Cc: David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Daniel Latypov <dlatypov@google.com>, Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

KUnit's assertion macros have variants which accept a printf format
string, to allow tests to specify a more detailed message on failure.
These (and the related KUNIT_FAIL() macro) ultimately wrap the
__kunit_do_failed_assertion() function, which accepted a printf format
specifier, but did not have the __printf attribute, so gcc couldn't warn
on incorrect agruments.

It turns out there were quite a few tests with such incorrect arguments.

Add the __printf() specifier now that we've fixed these errors, to
prevent them from recurring.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: David Gow <davidgow@google.com>
---
 include/kunit/test.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index fcb4a4940ace..61637ef32302 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -579,12 +579,12 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
 
 void __noreturn __kunit_abort(struct kunit *test);
 
-void __kunit_do_failed_assertion(struct kunit *test,
-			       const struct kunit_loc *loc,
-			       enum kunit_assert_type type,
-			       const struct kunit_assert *assert,
-			       assert_format_t assert_format,
-			       const char *fmt, ...);
+void __printf(6, 7) __kunit_do_failed_assertion(struct kunit *test,
+						const struct kunit_loc *loc,
+						enum kunit_assert_type type,
+						const struct kunit_assert *assert,
+						assert_format_t assert_format,
+						const char *fmt, ...);
 
 #define _KUNIT_FAILED(test, assert_type, assert_class, assert_format, INITIALIZER, fmt, ...) do { \
 	static const struct kunit_loc __loc = KUNIT_CURRENT_LOC;	       \
-- 
2.44.0.rc0.258.g7320e95886-goog


