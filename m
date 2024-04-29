Return-Path: <linux-kernel+bounces-162959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634628B62C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6C628398C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FA013AD3E;
	Mon, 29 Apr 2024 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TiUMKNt8"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C7617597
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419826; cv=none; b=Lw7BZL3MJHRIijCe6MyhebEF4OLcCycjE5a1edyikGJG3CpJGCARaeEGAzzW+uENvC/e7OuGwb1GWSxhSE1cO3Ic4GginKF0eVyjVFwJwHbDNdJ3DDBjWgHxH4CF5ZWc3hbbQJTxqXavivTN8Ni9/zlXSabArpEw22IC33eWv2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419826; c=relaxed/simple;
	bh=GzYQquZtF8F0UCCwehYpS7+bOLrS47ikty216klT3dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X8D/TN2luUnf3S5c2QjtnK6WjMjopCXsDpWau1+IXz782jqJdTxxhuNDX0SyzKvcQ78JLTrIhfomxkAtEbqVgAOLI+srABymy3MYLfG/ttBrPz7L+WO2nkflqNHJr6dmxMBzLt/E+YLjiYbAiYyfoSqmEUHR1ADna8hynsoPGEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TiUMKNt8; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b27c660f91so16734a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714419824; x=1715024624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otPR4dXeRXWcAXnWruvS43ZNV3eS/x5LH+123jbXlqc=;
        b=TiUMKNt8dFJ4Xv4UvBCCGcGu+YglpkPZX748+BQ0r7bO5Z8Vs/cwTYQ4ivQTIWlw6E
         kPPPs2+QoPqZ87yPVNRhf2XrVej6xss1ZSwTFiYuneDoqQkV8Gs6mOVJwheLjMSyRuWx
         DzkOb7VV9bLttTkTA8+RcN7U1YFmkbt750TqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419824; x=1715024624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otPR4dXeRXWcAXnWruvS43ZNV3eS/x5LH+123jbXlqc=;
        b=OqoJJOo6/K1nyvnFsP30Yx0iuiJysFe1zZ6I0pCvmsThbbWK//SfohDZRJI9OoGdks
         I3wsn+VCYstBH7TEhwvqLJCfycOv0c2vrUlhMMYXLE+Wrk+Z1KmPLBHQOb2Hv6nRAfK6
         NOeGp7kCB6vEWORegG2mmD+5AVPTT/bFi6sF7bOlPzVmTU5tV3mKXr3bTAHbMGRta5vQ
         gxbzKuhZf9ZuqAPIHZqVvy/lGIKU+8Tf/I4HaTeYbpToPXr46DTQ/1jZxdIOT5IFgAgO
         HSzEISr6VqmEmUA3L2DtAXqrSXfogVFCR+0Py6+ydQTVPgtwfojAcBUuB5JwkCMzhLfM
         b09Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6wAhWeWgv1rSHtAUk63gAzwfv+YDKdCSpwjpJ37iVIPTN56JA6op7wm9YMdw0D2OKFZ93SyZLUkRNQj2rLWDuNE17A2vBF5lO9pYj
X-Gm-Message-State: AOJu0YyC4WSanXV2hGk7pPg42WK2qUQil7yS9cMovC6UrBhjF+XiUzUN
	W0TJ7WKlyNFPt8S3Q0aqaxR8/03eAcykq8GIx1YeHYtK8Dj5u2qvTLYgxPwfjw==
X-Google-Smtp-Source: AGHT+IHAKpP40EtJrVx6f8RKp3tg35tYjrloyE4mT5cO5VfP5jL4BJiIUxyQB6ipUGsXnskqYUja8w==
X-Received: by 2002:a17:90a:eb02:b0:2a2:9b37:367a with SMTP id j2-20020a17090aeb0200b002a29b37367amr10075252pjz.39.1714419824483;
        Mon, 29 Apr 2024 12:43:44 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id em6-20020a17090b014600b002b16d9ab430sm3008510pjb.3.2024.04.29.12.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:43:43 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] kunit/fortify: Do not spam logs with fortify WARNs
Date: Mon, 29 Apr 2024 12:43:40 -0700
Message-Id: <20240429194342.2421639-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429194019.work.664-kees@kernel.org>
References: <20240429194019.work.664-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=keescook@chromium.org;
 h=from:subject; bh=GzYQquZtF8F0UCCwehYpS7+bOLrS47ikty216klT3dg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmL/ht/xDIv4y4i+JPHwtNCbLZWfqsyLg6nbhjx
 IJsn9pE/y+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZi/4bQAKCRCJcvTf3G3A
 JoFoD/9172DQtDzDQxs4bjGGOYab+1EegLgpEK2YmJvABHtD2I8nNIVuRlrIdDfQGOWCqoICExJ
 zVVTUQqTc9wveXXJtHFuF9AiCt0PoNm8xefFoz/Xlh1UGHjTAJqJIyncN0NR4Xs7lpt5bgDP5d5
 Y30loWV+NGZ3X41eq9hSDpF1Q11S+FGd1HzhT74oPpSJa8W6+RxgUrosZI2JDxbKTe2ZBbkVtUb
 BvFDzEb4N1Ru+eWvHMt0aEa+07hRVy6om0J+bstBwJ+ov3lVYv99DMGFYw9qbEUfuLTZK5I6sTd
 sL+RxJhFNShnqf+Si6WumZVN/Jgvf7fSb9LRD2LE+4V4oZCR6+pVZTrw2WPpwKk2AEfmT3xavWA
 ypJJ/07cOJOz/9t8pPb0Cy/o0/rJLzU1F3au4uXWhAZruoF1LsZD81fy1G3e/XkbAy1H3H2PA99
 mglmy4of+9BT3ChwVrSXKx9ucEuww0Tw2ZaqktzHQycE2apxJVAgjWdGmeACJt5/1KLg7vIzk1b
 cNPtrKP+srnKaxWS55g8Q7o3YqYPtS2fgZYOaButrY8yiSQBpoEJyNSxuyWye46d0zTZrcc+X5u
 SRQet0ZZxCp8BZRmtQPXAhaAkiHVJ2kuKJC6EnwFnDci8OV9DalVWyJcegkApv6QWocFpWyPQnO 7vWupGNdSmBn8qQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When running KUnit fortify tests, we're already doing precise tracking
of which warnings are getting hit. Don't fill the logs with WARNs unless
we've been explicitly built with DEBUG enabled.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: linux-hardening@vger.kernel.org
---
 lib/fortify_kunit.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 6f9a86c94538..bbbfc2238aa9 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -15,10 +15,17 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+/* We don't need to fill dmesg with the fortify WARNs during testing. */
+#ifdef DEBUG
+# define FORTIFY_REPORT_KUNIT(x...) __fortify_report(x)
+#else
+# define FORTIFY_REPORT_KUNIT(x...) do { } while (0)
+#endif
+
 /* Redefine fortify_panic() to track failures. */
 void fortify_add_kunit_error(int write);
 #define fortify_panic(func, write, avail, size, retfail) do {		\
-	__fortify_report(FORTIFY_REASON(func, write), avail, size);	\
+	FORTIFY_REPORT_KUNIT(FORTIFY_REASON(func, write), avail, size);	\
 	fortify_add_kunit_error(write);					\
 	return (retfail);						\
 } while (0)
-- 
2.34.1


