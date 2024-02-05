Return-Path: <linux-kernel+bounces-52615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A26B849A71
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF5D1C2120C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F821CD04;
	Mon,  5 Feb 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oAP5NDby"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D221C2B2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136530; cv=none; b=pN3ADbOHGebP0vrBwdWZ9LJL0kPFTg1eyWk3dY/nd6zDBtdAYdFQwgECdd7p5Ni0RX8XU1mJfYDmrk1iLEOn0aUjMWQUkUi2uEqmkvK1S97t+SaYaNq8of2R4P15AfXLYEjUYuA5IF31Vd0v6TJwYsVT4dfLNdI4kLOagZih1ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136530; c=relaxed/simple;
	bh=SCI5AVp/xP0K3m/Awqe4PFOk3LYWSNoQ5BQ2wUkaFRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y1oCFKUbLjRAJZvH6ZO3W2bCgDnJdSgp2FCJFOBDzmBarWT9HZvnHZieTt/itKZJMR8zoZ3c2UaaSXM820mjTOt5Nl3mfJikAe6+x8Tp4wamgDr6WWYFNQCesUz2snYTPbN1H03E83VCODoRcO9K6YtCQ/d09RDE8+7CzMpc8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oAP5NDby; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e0353e47daso833086b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707136528; x=1707741328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5JNANRkgim7oX9erlFG0aAyh/IbhwSXSNW8ijW6EiU=;
        b=oAP5NDbytlUEJbHmz7Jlie+xzHOo5gxHYx9jxDHMIRp80EjA1mB+uHxaTsYJn9Uhyz
         uJ13m1cBTGRTQSlY623KGbJLPENs6jovpNb8cyqEdPcizwtboe5vSLZmhw4U5e5OdJnK
         X9oDpGi0uLLbJ6qTT546qKNZA+T2m/JYjNfXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136528; x=1707741328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5JNANRkgim7oX9erlFG0aAyh/IbhwSXSNW8ijW6EiU=;
        b=tbteeoANXgo9ko0JKrSt63bGB1oUcVqEkN5o4S2qQXVI1vm8X9jHCbHQ1lqs3B6HgC
         puxJUzsrFqL/6UYG1mbgBQlyoNUiC8Xdhw1NzxiAFt1F5R2eM9iTw9QcpeL1UqWkmion
         t5f7QutaO96JkFmFJ2aGwuXqZhpwwtoF4KuwfkesviHINHGfMGj6vQtR0tqcvvTx2VUR
         1AdX17nVb5RcxeLQnj3hykER9/IjuB45cpfRLLe4Yw+D2v8gqxtarAeGA1ozkWmC1uYB
         FwU7HIWj4BqWZfjFFveT/mfBw98LMhDXCheN/zADY59KrygesusdcA4pLj56lp7RycxB
         rZbQ==
X-Gm-Message-State: AOJu0Yz6uFf5tOEwYasA6+6+5b1+Vx++/TkB8ki09Jgqlwh5X2mlpZlF
	fxt/n4AkpeN700dM+qmMYSxB/a5/OnSEMSu+S0fQovCMv/QsH/aZxkwaO70NZbTz3ZWcDB3riSm
	dPA==
X-Google-Smtp-Source: AGHT+IGcyv6oUMvzmDLTrZfuvHow7dYZGNngdUIPt9/kNHjY4m35Nv3RLQZaeWenbYTl6YwPkxUvvA==
X-Received: by 2002:a05:6a20:6f05:b0:19c:922b:13e5 with SMTP id gt5-20020a056a206f0500b0019c922b13e5mr8107466pzb.59.1707136528154;
        Mon, 05 Feb 2024 04:35:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWagow0Xuqfyuxmq8ypSMoRdf8e/fatW5Km0Cy9EIBfS8Bu8otndraIk1Rh+l1J50Uw+3uqo4+kLRteVP/c7c1JUENfvDvsQ+hMrhl1w1jU2SFpUwdWIdPI9Ng3sTrGFPIIzzPBu/YJOCLERL1TMLWN/oWbQcvGo5iWImJ4xtyYgPGGi7AZZFEGJtyHcI/UMBpAglK7vaUg2S0rG/28zLmr9RYcafYYGZ0ixHConRJM03tyoZ/qvME8mBVetDJggGibbRGWBrh4KKdR53Qkzfg24dqBvyYrvOSh8OUIo17dFzVqnEBZ4Ln2hbuMs9mJWxI9+XpsBsO0nUf3KYAOkzScVnndD5QEaq64qo4sGONV7ZPEPAwutGac5THprucFy/HSyFp8zJ+TZo+/ODwoIoGgyvOgOOTJ9KOn04NF42iqgiiO1A5InQdi7W1c3z9PE7agbvVqFvOTCa4wRa2yO+c+
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 20-20020a631554000000b005d8be4c125csm6881440pgv.80.2024.02.05.04.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:35:26 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Justin Stitt <justinstitt@google.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH v2 3/4] string: Allow 2-argument strscpy_pad()
Date: Mon,  5 Feb 2024 04:35:23 -0800
Message-Id: <20240205123525.1379299-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205122916.it.909-kees@kernel.org>
References: <20240205122916.it.909-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506; i=keescook@chromium.org;
 h=from:subject; bh=SCI5AVp/xP0K3m/Awqe4PFOk3LYWSNoQ5BQ2wUkaFRk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwNYLp7ZL5ezJvmcodRQbG2/1dyQRVQycV79xB
 /6BzOPeySKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcDWCwAKCRCJcvTf3G3A
 Jvo2EACPXKqow/a1M7hjAGcliIdGfXhiepw3TyxOozHwHyFCXonE4ajdHlUJPs10NbzydfvJN7g
 nLdam0lewEg/i3/kbxy4xNDPDUziZd8urp1MnoqrSxnPXxfieBSy0SCTjCijMcy1XhJ53bTP8VJ
 Xp0kj8hktnbsgJorBULPaACOrK3SbM5jvagSfNhnkAdfqro/ds2EMVlBNUVdyUF/gbWoor0NaiM
 DpMOv9I1wf6/UFA0xRJ4Kb9+XJOEvAbl4Qan9i1Zn+lIO3w4pG4A9HtCm5hysX8KV6hFGiKxbjZ
 FL5rRAr5YoBMLj5YFVXFBmogCV1il7zo39IGffAMXJ8p35Rg0DSCoC1jEIThnS92DfNLZq5q5ht
 hRB9o5XCsNTrkfbgjD4HHEAAKUqDCjem3uMdkjE42CuSPRN7z8YJ0yTvlGg+9RjNm463Jm0JDQU
 sXFFR35pDYH9r2OWO4i4xhIKRTZvFoXuV427qHabe3Qvr6EhracQfE6W5VlvrO3GwdQ2YS9oSe7
 XMMeWFatpxe8VL/1+itq2dnnt8iWYkwr/I2kjjyhfDcT1MBir9g+ACaU8QRv21G9Fi7Jkga4yfU
 a5QAwX2USngq3ZMAitufdkf+VgoUnUqzee4E0lP9gg7m86XYSeJrRiOQGNd8X9xehhP5bKi6TD0 TkZFNDYTgcD33rA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Similar to strscpy(), update strscpy_pad()'s 3rd argument to be
optional when the destination is a compile-time known size array.

Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/string.h | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index a21371aa2fd6..4f0f27013418 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -78,6 +78,10 @@ ssize_t sized_strscpy(char *, const char *, size_t);
 	sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
 #define __strscpy1(dst, src, size)	sized_strscpy(dst, src, size)
 
+#define __strscpy_pad0(dst, src, ...)	\
+	sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst))
+#define __strscpy_pad1(dst, src, size)	sized_strscpy_pad(dst, src, size)
+
 /**
  * strscpy - Copy a C-string into a sized buffer
  * @dst: Where to copy the string to
@@ -103,6 +107,18 @@ ssize_t sized_strscpy(char *, const char *, size_t);
 #define strscpy(dst, src, ...)	\
 	CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
 
+#define sized_strscpy_pad(dest, src, count)	({			\
+	char *__dst = (dest);						\
+	const char *__src = (src);					\
+	const size_t __count = (count);					\
+	ssize_t __wrote;						\
+									\
+	__wrote = sized_strscpy(__dst, __src, __count);			\
+	if (__wrote >= 0 && __wrote < __count)				\
+		memset(__dst + __wrote + 1, 0, __count - __wrote - 1);	\
+	__wrote;							\
+})
+
 /**
  * strscpy_pad() - Copy a C-string into a sized buffer
  * @dest: Where to copy the string to
@@ -123,17 +139,8 @@ ssize_t sized_strscpy(char *, const char *, size_t);
  * * The number of characters copied (not including the trailing %NULs)
  * * -E2BIG if count is 0 or @src was truncated.
  */
-#define strscpy_pad(dest, src, count)	({			\
-	char *__dst = (dest);						\
-	const char *__src = (src);					\
-	const size_t __count = (count);					\
-	ssize_t __wrote;						\
-									\
-	__wrote = strscpy(__dst, __src, __count);			\
-	if (__wrote >= 0 && __wrote < __count)				\
-		memset(__dst + __wrote + 1, 0, __count - __wrote - 1);	\
-	__wrote;							\
-})
+#define strscpy_pad(dst, src, ...)	\
+	CONCATENATE(__strscpy_pad, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
 
 #ifndef __HAVE_ARCH_STRCAT
 extern char * strcat(char *, const char *);
-- 
2.34.1


