Return-Path: <linux-kernel+bounces-65892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE8E85536C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1198028F0AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CA813DB99;
	Wed, 14 Feb 2024 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j6pGp4mA"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9B313B7B7
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939969; cv=none; b=J340HHIKPqbVvCdwME6FnKblCmbjpKPxyEfUFFjWHVAy549uc99T7D46wOQ0Mv5j2oPSAEHQIRHw753OccIsLYz6g4hBJjLwyJWZK9nN1vHhV3YW2rTJf8Ino5na9T48IqVq++idH4iJ91W6grxDUbVyKyC4vkBJo8jyCQ5lT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939969; c=relaxed/simple;
	bh=XRea/mEhcbAGWa9Y4NibhO2kDjISXokmQWKcnCxCkCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dzEscKXKxESlYY94P9fIsDrTVmROHFcHC0Tz7Ttzw/vQ066mC1Y/PIj7lyp266mwz/+kvGlRtBjrrvuzEFgGYs2VRZBD7LZ4n6bVCMXPnZh5SRkoOsQ8kIalkdd2lg129zXhlqrSH8PZ8YVlGg1HfXRpbv6TcSr0YpWtx03gZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j6pGp4mA; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-296d26db6aaso129765a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707939966; x=1708544766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jM19jkSsuav/2hSBnxgTz0qK403f31xS1I7deDtmjCo=;
        b=j6pGp4mAUI8QjQU/ezhM62Tcu7UvHyi3oVNUWkdR1h1/8YEbn9srwSIL7qHO8jCQHk
         LNcRvT/e+eUkd1XwOn2fHBC9WsF8019aXjeJmHOEpSrD+KVvKJkYgcVPB0qPU5LpMiZX
         fj8WyNv7kDxP/jAQqrWLG2EDqZQCinqTJLp/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939966; x=1708544766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jM19jkSsuav/2hSBnxgTz0qK403f31xS1I7deDtmjCo=;
        b=mhF2WPF6KR6pPeAMO4cXHmYyM1oPe3Lu7KxIBLTSepM58bsYuve9x7pxIYsw1iL0Gl
         lgr2SBVPJrKf7QUH5PLq/T7J+/T6mTbbwaC7AqFjzicAilv6OzmvjNbo6uEM7LKslZuM
         r/mgQ8iSe+bl3ACiuM9bx467KnX9Xkl+Yuj4FH0NAmv03C+hMZXbOCC4yBBVzANmavdh
         bBtCwNyfMIdbwBULHVD2TXC62/TfPnwdj/ru+SzU2iwHFkKHgEvUYbHIWUzl3JlkXdOF
         DJ6PHriWTND/fNIt/YXGYWlcMcVQwFMlIqsIv/dIVlTdeRhXXsKbiXaXdod4HnpSxapF
         loFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfE7kLMm0l1CN1SJc2IQPPrK61ARc6hQAA4Cct8U6sT+JrssrBSjKIyrBWz5EdCviRtszntWxFLF/nhsXn7Noo5h0iUG1a15W+ioN9
X-Gm-Message-State: AOJu0YwWB26VbpcXgkkP7bHeS/0wyWfMNJ3Y4L7gUlF05KLA9KB+ftFy
	JHvrwSWYeYeT6MwrdFG1JAPwZe8J8W/fNkJDNkLk7z23ZVGz68rd5nAZj2wc/w==
X-Google-Smtp-Source: AGHT+IG1BEnCT0dNA4a8fVl3B4GlNEFYN3BUqCrJsR1LiFYg1x0FRbzeVM1jPRNPwcIOIv8T1wUjjw==
X-Received: by 2002:a17:90a:ad09:b0:298:ca21:45e8 with SMTP id r9-20020a17090aad0900b00298ca2145e8mr3554808pjq.7.1707939966688;
        Wed, 14 Feb 2024 11:46:06 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a08c900b002966a13f2e9sm1794443pjn.37.2024.02.14.11.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:46:05 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Marco Elver <elver@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/3] overflow: Adjust check_*_overflow() kern-doc to reflect results
Date: Wed, 14 Feb 2024 11:46:01 -0800
Message-Id: <20240214194605.602505-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214194432.makes.837-kees@kernel.org>
References: <20240214194432.makes.837-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2828; i=keescook@chromium.org;
 h=from:subject; bh=XRea/mEhcbAGWa9Y4NibhO2kDjISXokmQWKcnCxCkCA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlzRh7r+ya4r7uEt9x8g08cu6WVWLE7l1GWFkDZ
 9tMyyEzBZiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc0YewAKCRCJcvTf3G3A
 JokeD/4syUq1+l4y9hFWnYnriJZrkny078pHVb3PIOY5XYIudZ7ZTv5wuMAwVzHjGujXsmINAAO
 pvn3kJa2F6Fu75yGUOsdFeG+YwFY6VARtUIQDEgUtoGl9ulfw/jzOViuCCPRtZ8VE+6yAsrz34V
 cI4G7wA8IuprJ7z7dYaOGt6npq+U390i9v9w19QuSX6Q61KrNl2Oj4Sd8WAuCWs6xnUj2fGa9fy
 No3EaO924o3xaALxo8oKz8difZ+2TlvzxarU3j+wXtuwKLtE8xtUYcJRQoRYcWtZPH189hLRZZ/
 OSs3HhcGiJyzihAAVr7oRL9Q323ECK+cbgVhHgVUNE1qrQbI8kEbKqWmqqdaEeLO1CjQVfeCbwN
 tlSPBwgtAkSvDTFssmMwHj+PI2dg8R6nNULk/ZYzsgBjABA/VYd6gNSmGE71Clc7t6OoJ1716iR
 ccUkN/TTWttr2MhLMa9f5sEsqFKd49BxDylTAqgO6NvD7qAbqb8V69oJ22k9+67QhFLnxAKNNxp
 kAsCJkher0VmBPGWFR7dK9KbrTYa5hPVrdKrjzTOphv+FKiWzPs5+dS4UfNQF0Ani7da/rQsisj
 LgY3RieGWc9W3kAP7vFeEf9JkLj7p2aAp9dVUDMObMj5wbTzD6+sK3QbS5kqou0OuVJTG3LO+6T H3GIukbfitb4mnA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The check_*_overflow() helpers will return results with potentially
wrapped-around values. These values have always been checked by the
selftests, so avoid the confusing language in the kern-doc. The idea of
"safe for use" was relative to the expectation of whether or not the
caller wants a wrapped value -- the calculation itself will always follow
arithmetic wrapping rules.

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-hardening@vger.kernel.org
---
 include/linux/overflow.h | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 7b5cf4a5cd19..ad64d810c8aa 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -57,11 +57,10 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * @b: second addend
  * @d: pointer to store sum
  *
- * Returns 0 on success.
+ * Returns true on wrap-around, false otherwise.
  *
- * *@d holds the results of the attempted addition, but is not considered
- * "safe for use" on a non-zero return value, which indicates that the
- * sum has overflowed or been truncated.
+ * *@d holds the results of the attempted addition, regardless of whether
+ * wrap-around occurred.
  */
 #define check_add_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_add_overflow(a, b, d))
@@ -72,11 +71,10 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * @b: subtrahend; value to subtract from @a
  * @d: pointer to store difference
  *
- * Returns 0 on success.
+ * Returns true on wrap-around, false otherwise.
  *
- * *@d holds the results of the attempted subtraction, but is not considered
- * "safe for use" on a non-zero return value, which indicates that the
- * difference has underflowed or been truncated.
+ * *@d holds the results of the attempted subtraction, regardless of whether
+ * wrap-around occurred.
  */
 #define check_sub_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_sub_overflow(a, b, d))
@@ -87,11 +85,10 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * @b: second factor
  * @d: pointer to store product
  *
- * Returns 0 on success.
+ * Returns true on wrap-around, false otherwise.
  *
- * *@d holds the results of the attempted multiplication, but is not
- * considered "safe for use" on a non-zero return value, which indicates
- * that the product has overflowed or been truncated.
+ * *@d holds the results of the attempted multiplication, regardless of whether
+ * wrap-around occurred.
  */
 #define check_mul_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_mul_overflow(a, b, d))
-- 
2.34.1


