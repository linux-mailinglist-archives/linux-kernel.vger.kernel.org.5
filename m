Return-Path: <linux-kernel+bounces-139533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7A08A0407
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB365283C84
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FC11CA80;
	Wed, 10 Apr 2024 23:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2bAxsRGs"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935D23AC16
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791608; cv=none; b=E5jlAIkYGh8F2BYnL09YLYP5uIV4KeDIXffxHYILWc/lGOKWYnuAjgyhwFz2eaWyP7YBRuV8HxAHcEzxgaP+lVz7aRg3ygOfmuEQ+9XEh3rxrdoEYf5V4g00flsoQoWvj7W5s2zmox2vKCrMkU6Z++lmnh7t+hgEubzxZvw1g98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791608; c=relaxed/simple;
	bh=QVx11GFaCCb7N4Yio7fGICCAENUW3V/BWi5Vnx+PoZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o6iG0XDjnszWftYqCoxjMOdFt7EugBJEfNPWkuLHm3M3fsmltQuPfkim6JizmEeQlTh2Cdtr8HSl69XrSDUKEupX+Cd12HtIx0DyX1pJumg3aXGdmwJQuagBn5CtWlmmLNQRlhaQLJJRUmHJQOeDmKx1wfw9nl2nBaTw4pOft6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2bAxsRGs; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5f0382f688fso5170716a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712791606; x=1713396406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YqMlKesOrPLSfKThat23VwjdSe9gCiof2Hkve//abGE=;
        b=2bAxsRGs/vAdnVweQ+LLBJ6rSvemZw9Iv/VYWQij7estfWltypbn51JkVgHb1z30DK
         JBgx063VJ4PIkSTROBL5m2smau21aSUKqVbV5G+3mMO4K+U3YTPNcHFECyKGjC/RMKNP
         939UEp98XTzhXBqV5So7ZxkoEdsKeMRFYdYw6mDFYG/6+9T21ApLAL8TBuMKDOZrwif5
         fCsp0urUhTy9yIsz9u6lYmKf41xhWUYDASELO7KBeSA5mIpcOY+yoqA87mATeThAhn2R
         hX2Z/ARNtPrYrGAC31tdF4MdoNIHqxWqng8wC/8qhvual0Aadqnf40bSMgqcbq2C+Pya
         U7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712791606; x=1713396406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqMlKesOrPLSfKThat23VwjdSe9gCiof2Hkve//abGE=;
        b=IT9YBbA3QA+cTSbqF/s0kmUj2nbEjiXrW8EuZGwKU2gh7nlI2cBJCNG9Kd/Nkmjgow
         miNLN6LVEV0AwP7EekF6dPJkASjbHrXBiZcjxK7fHo4TsXZd0gWtatn+gvP4hYQvLC7k
         RJxU6YJ9+bTKzxRjVCj6p0kc7lSwvgMoJdT3QbzyD5RdOiLxVjhw53/w7KhXNKTZLRIU
         QfW3oYNhLF5Nj6nfUmSFIGXYW/ncjO5RCvDqC1j8SNFacV2D1njEEaWp+UKLLncBvrUU
         ewqYaaB3OqTLsj5puFB76bGBoHQgKsW6gsaxPLQZ9veXRiHZnKbXjx4/IhKglgUP/tAt
         hJDQ==
X-Gm-Message-State: AOJu0Yza5cNj2uaWmqM2t6KnhqOXiAGluAdqFn5xJHrgpbmaypHB15Px
	VIIB8PC39O56f3CzmErV1Uq3UnVVZSbHT9CwCvO1J/unXPoRvbr+nBS56s7hxPJbdPhPg7JEJR4
	gEIn8j8vUJlO+bIwIUpGk0DybcyuooZWA0BAoswyL/w9twwq4bCko+a3RqJUbgT7jjZtpl0FJE/
	ByTLGrHPakhliClqJFvCgP/eZo0IrY3wtbQFLpzGrh9EW9
X-Google-Smtp-Source: AGHT+IHouF3P+iPzjB2QiKGl6ZZPLBEONmG9rrx+ed3xbWsI4elR12lweA0nFbIvZPSYd5HufyBuz5M+ZKmN
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:e80c:b0:1e0:feef:5c1d with SMTP id
 u12-20020a170902e80c00b001e0feef5c1dmr311262plg.10.1712791605672; Wed, 10 Apr
 2024 16:26:45 -0700 (PDT)
Date: Wed, 10 Apr 2024 16:26:30 -0700
In-Reply-To: <20240410232637.4135564-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410232637.4135564-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240410232637.4135564-3-jstultz@google.com>
Subject: [PATCH 3/3] selftests: timers: Fix abs() warning in posix_timers test
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Shuah Khan <shuah@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Edward Liaw <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, kernel-team@android.com, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Building with clang, I'm seeing:
posix_timers.c:69:6: warning: absolute value function 'abs' given an
argument of type 'long long' but has parameter of type 'int' which may
cause truncation of value [-Wabsolute-value]
        if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
            ^

So switch to using llabs() instead.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Edward Liaw <edliaw@google.com>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: kernel-team@android.com
Cc: linux-kselftest@vger.kernel.org
Fixes: 0bc4b0cf1570 ("selftests: add basic posix timers selftests")
Signed-off-by: John Stultz <jstultz@google.com>
---
 tools/testing/selftests/timers/posix_timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 348f47176e0a..c001dd79179d 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -66,7 +66,7 @@ static int check_diff(struct timeval start, struct timeval end)
 	diff = end.tv_usec - start.tv_usec;
 	diff += (end.tv_sec - start.tv_sec) * USECS_PER_SEC;
 
-	if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
+	if (llabs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
 		printf("Diff too high: %lld..", diff);
 		return -1;
 	}
-- 
2.44.0.478.gd926399ef9-goog


