Return-Path: <linux-kernel+bounces-52270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80520849618
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A741F21149
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE1112B93;
	Mon,  5 Feb 2024 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AKRgZnK1"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D7D125AF
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124358; cv=none; b=Hb9FjeYLAC7vwJ1u/voKGuh8PeEn7OH37X3jG0H+uOvLzkiqUQcYSNTiUl0ZIwoAAnuW1E+zErI0pLabdoZQ0nVqiTPgL6yJmm8qQbcrMhwNGdilAoX4pOzdvxGkm0/B6RFckn5bmvfkvyEdcTX5sccX2lO0ZYJoKjlI0N++nbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124358; c=relaxed/simple;
	bh=6Jgp3vxxK3Vk/XDvje4qMUZMER6LkaJQhb8c5Sf9IQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LRCmKM2W/xZi32nf9whPNdQmbM2vkG0d9A7CcY/TocG7H6BifvlkJqjvxfoh95WXUP73J7KI4SgZBcgmywZmvxxqcmKkGvyyYq7gmQDrJYnZlZ7S3jfr5vB2YHKtqHz6WlRGuAMx1+SmlibMzgH/6lN+nVp6SfO4aBCd7F+eylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AKRgZnK1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e0353e47daso680939b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707124356; x=1707729156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QphZTJ2YkJ63c2lk2h3jm8PAaMKsJdXhMlN0zVjn/Jc=;
        b=AKRgZnK108PcD0RJAOQMZ9c4jNRKuMEECNY1exC3xIpk12XFzdRMUAISbgQvLo2dWO
         Y4dFQ15xwhSefVADmjYZfzFGDoZqm6x4nROmTozHji+4xfJ+IuQ8HPZkQHHzhZCpzKVX
         T9oqssFWZSWNKZKtd/3+BAU3gVvx84iGP3Igo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707124356; x=1707729156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QphZTJ2YkJ63c2lk2h3jm8PAaMKsJdXhMlN0zVjn/Jc=;
        b=gyeJc9fzBn1YROAFpWED8eviw1vB0CpjM41hyBA/7aWtwf3vF3IwO8nCTF+o1PyvyE
         k4bOzubKWOU7xEzHAVC1pZAbq15n0CRE42l7UX7PxVn1rY8CtoVEmv9p/rdPt3CcfIYe
         5oJL1bX2PMMmd0cqnRd7TttZJE8m0w1D1dBMiVYDCoc5S9iTSAQL3MnMVBOXHH+XnmAs
         K+VyAqrQ2w84gulPGvti7D9//e5hAQPiTABMUr8Oj7HtwthMfuPv4P/zhl7w8ZtTbOec
         z0cPIhecKpu9n3Ige0jDOi9HdBqD5LVRzQatdP1sZvPmL58w/FMAykVf/vndXRHozHCu
         hl3g==
X-Gm-Message-State: AOJu0Yy4YypWbKMrQhkV5GTW+1dTMYJsFziIUH/azk3GX9TFEy7otbsp
	pT0RA5K8tOKetEYZfyxH0OqcH+3UKvzzWZ4A7FJRKeXBB3gsSyqSp/0WHAQm4g==
X-Google-Smtp-Source: AGHT+IHYePIwMXQ5LnKdC87eHR7+eQN8ewi36ob0kN+ulnyepujcsGs7yqagT8Wlwbtsv4L1mHGUNQ==
X-Received: by 2002:a05:6a00:1f14:b0:6e0:4c5e:68ab with SMTP id be20-20020a056a001f1400b006e04c5e68abmr987347pfb.1.1707124356282;
        Mon, 05 Feb 2024 01:12:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUgam0Sy5mL/Gq2M+QwdBOj/Tkb86Y/ythxRWM59BxWOi6iob5C608oCLu52Q4+Us97eO6CBhRL83AlT/vHwDTKdeQsltJ8HgqjsQxU2ngNVyvzV7ggO9nFIQrcsgAg/Lx6bs/pMFVPe+K5XEp4mScgRTfNnw4h866xuwA3QyBoVHvDbrYXKXid8lm4dUl5B42orbB3xVs1mdF1egmie9Fe5xsoaPuJwg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u26-20020aa7839a000000b006dfbecb5027sm6351600pfm.171.2024.02.05.01.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:12:34 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Mark Rutland <mark.rutland@arm.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] overflow: Adjust check_*_overflow() kern-doc to reflect results
Date: Mon,  5 Feb 2024 01:12:29 -0800
Message-Id: <20240205091233.1357377-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205090854.make.507-kees@kernel.org>
References: <20240205090854.make.507-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2673; i=keescook@chromium.org;
 h=from:subject; bh=6Jgp3vxxK3Vk/XDvje4qMUZMER6LkaJQhb8c5Sf9IQw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwKZ/MG0B/D0l8I3Zre9ccIWewGWghw7fRDA6+
 Ex6geHfWP6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcCmfwAKCRCJcvTf3G3A
 JlIRD/0fNYHR/Q/t3GE6K/dcj/N/TszNOgrjmagwPMznODDeX79tpNgCnptKczo7nbLyqrusHDs
 TIOE89F3iInBnFUFCw/dDxOO3IPQftyBB+0R6nvUry3RuoAa5B9N5dvJj4LR0scO6epJkInmj1s
 0tcC7bpmXvIe5RR0U1gP79Ms9RkH0OdWYsFa42F8Y5TLgAgmUuxYGd/Ay1cjXj90L5stz1LFoha
 ZTeIQwRFErrw4nDerDgwL3xCH/9F4Ip057DBRTkBozjY1dz4yHmsstVcZHOr8pMUhCxSCslr9Ht
 AI/w9Aiqcnm/RVX7OxzwbbQUY9nY1nMD7M4zpAt54GmWQgsmHDjdEcTd340QvENDIWK6t9Thr9C
 l5aIvCdJbS0yuZsw41HZEKVNyN9wVCbJ3bBOOh0vvzZcY0sV1TxOuh2ZnvjgqcvMLefq3GqSGVD
 BMFRfRxwCgf982GZCTwxMXxzIqfgEw+MO/0YCD3b9M3sxkaGsvMzIkF/8MxjvOTYzo7dBvyv46o
 Y77HXbXzYNpVpp/Udn+QQl5bk/kNrZF+VTfNgQJqFi8uJRFTvACk8YHLOrSrv6QfoWhq5+Vwwjf
 vpuoU/S63IZrqSAVIb4car+GYeboncIq86glDnp5d/Z8DHARUQhpU1+oLYbRFa62tRcWQUdWrAU H5orQF7g3va7/8Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The check_*_overflow() helpers will return results with potentially
wrapped-around values. These values have always been checked by the
selftests, so avoid the confusing language in the kern-doc. The idea of
"safe for use" was relative to the expectation of whether or not the
caller wants a wrapped value -- the calculation itself will always follow
arithmetic wrapping rules.

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 7b5cf4a5cd19..4e741ebb8005 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -57,11 +57,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * @b: second addend
  * @d: pointer to store sum
  *
- * Returns 0 on success.
+ * Returns 0 on success, 1 on wrap-around.
  *
- * *@d holds the results of the attempted addition, but is not considered
- * "safe for use" on a non-zero return value, which indicates that the
- * sum has overflowed or been truncated.
+ * *@d holds the results of the attempted addition, which may wrap-around.
  */
 #define check_add_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_add_overflow(a, b, d))
@@ -72,11 +70,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * @b: subtrahend; value to subtract from @a
  * @d: pointer to store difference
  *
- * Returns 0 on success.
+ * Returns 0 on success, 1 on wrap-around.
  *
- * *@d holds the results of the attempted subtraction, but is not considered
- * "safe for use" on a non-zero return value, which indicates that the
- * difference has underflowed or been truncated.
+ * *@d holds the results of the attempted subtraction, which may wrap-around.
  */
 #define check_sub_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_sub_overflow(a, b, d))
@@ -87,11 +83,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * @b: second factor
  * @d: pointer to store product
  *
- * Returns 0 on success.
+ * Returns 0 on success, 1 on wrap-around.
  *
- * *@d holds the results of the attempted multiplication, but is not
- * considered "safe for use" on a non-zero return value, which indicates
- * that the product has overflowed or been truncated.
+ * *@d holds the results of the attempted multiplication, which may wrap-around.
  */
 #define check_mul_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_mul_overflow(a, b, d))
-- 
2.34.1


