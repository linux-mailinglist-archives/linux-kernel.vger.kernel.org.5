Return-Path: <linux-kernel+bounces-149764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70AA8A958A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAAEC1C20DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382FB15B0E8;
	Thu, 18 Apr 2024 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mbfVh5m7"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE8A15ADBB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430780; cv=none; b=p+I+FIBWf8d1G0gCTcqb5M355HN0RXfV8R9+pJbuvFE3eaNag6jsEVgKqp0se36+XDTlT48+0oREng/REV9pzFjHqrbh10PRUQjmXpCyAI/6+RGbhUOqYu1Qpm5J2Qd8zxojCk9irWkouzIOUtaUrPgqcbkbEBavauFQ9YMiqd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430780; c=relaxed/simple;
	bh=MLZbMFrdM327Iliqelcm2H6dceUinbo2Qrr0nzN416M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ujL/Nz/8YeU6ruACUIEz+HUnuzRUvZVcAYmtJeaumGxF4hz73AroYW48jOtyoJvi1kTSj1C9CQ8eF1Hod7oYIz6cqBfCfZBjawwFwhOoOKEVFgf5bOFVCpdCljsnp9M1ionB5SG+/ecL8rHPKrQnE8Da9jxwXAj01sR6MP7naX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mbfVh5m7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso1207833276.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713430776; x=1714035576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MXu0ivdSThjPNuQSvbrqR8EgqUkoc/lgNPsqzGk09fE=;
        b=mbfVh5m7hOGpfGhG1YlQAPS1XMw5wBZmexgAcT7GiZ5pu5EkUkEO2YNGBAvZ1uBvdN
         onVuHCo7bXVhC8t6HTC0uCzrTbP8zqHAO5WSMoY5845fTVpo+NDaYDATdLZx71QyCKcx
         lECyehnElthO6FS1N9M2Rymm9a6fc2Wh2L5QtVImI8Ri8qEDOIi3iiF6A3Vazn/5Ixy9
         EVl68wv0NIghyCgTRbDp375FBFC5LtXxmSy9NiEWcLtDWPxJuh/MJGzSz6JAzz7KodJS
         FyEV2HsbyrOs+GgDky2zF9Lt3lAg6Osoe8LvUrj03745tICGAyRWWqdXhCsTNTG7kwhe
         UshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713430776; x=1714035576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MXu0ivdSThjPNuQSvbrqR8EgqUkoc/lgNPsqzGk09fE=;
        b=mIGiaTunwgQButO1gY3MISmSitkJcZg83URqDbdnMZjYZcdjJVJr7gJQnCrQcWDvxN
         kEiUNchFrTCewPQ0vKj6/S+JuiTsH4RVdDruHgthipa7x8DpXMZhF+7JqnIjXpYoSTMy
         fSBaKUDC8pq1/cZbuOA6kpAAuLZKv3RUfuax5TCvyhLGFM3uvaCcBzSjAPftOEHXn9zk
         Y3V3wnreZA44ntpp7vUjJCxOR3oy6yuYpwkpwCHtRwd+u3k6bnNkIibeof6yCX5a1UGA
         HpaS09h7gRrMzjnFlQ78COf9C7QnX6Z6MP5xVqLNzykXM87U7/7b4oADVQwzfbsC3BTm
         9OWw==
X-Forwarded-Encrypted: i=1; AJvYcCXkO/i0Kn2XwN11hc3p64CzMGF7mqKNIqwPH5VwYXyLqIEwpNN20k+sRtGbvh+VntsnuCeb6wglVIOAZb2+qsrTHFzkhmnpjluxq/3w
X-Gm-Message-State: AOJu0YwQbwdcJbvo1+cGNpJZz9UZ8O0etup3ydaig+dWzXElXzrjjpcM
	YYZxWTdMdxHS6Wl1tIYalm1CMFOmNF7SoRIUZeidDYtrAB+UksG5/ZEtPy482yJl6GCceeWqRwN
	4J8JPWdAuN5zJTw==
X-Google-Smtp-Source: AGHT+IGse7NZQ2hEZ3xo8zQMgk9GxHVA8CNqzQiXXjRdYigAwKQOE+Tfaeop+mtM1YJnE9wBINVVlzrjz7ZKuzM=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1141:b0:dc6:5396:c0d4 with SMTP
 id p1-20020a056902114100b00dc65396c0d4mr546819ybu.1.1713430776218; Thu, 18
 Apr 2024 01:59:36 -0700 (PDT)
Date: Thu, 18 Apr 2024 08:59:18 +0000
In-Reply-To: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5122; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=x1NaT6C4DcUL7cPQ6UUi0mTx75zJnB9XyZJjsIRI3Ns=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmIODuRjVdfd6NY/1+Lcn75vkKinRf3CAdt5vul
 8uvXQyrNxSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZiDg7gAKCRAEWL7uWMY5
 RsQMD/9U/ASnGmCDYMWUzDaCj6mk7qk2+xp5uBW1ucNBWrMyAEFMHPc5z03wfq4unBKyUtxuda3
 cVebYAtbaZbp63wjQikTVnWr0A/vRMMbHK4rrmsUpppJWFebPLU5dwepofmDp1dUe4AsB7b4v44
 Jn+7LT1sf4rD/QVa/iBoA1/HkJF3dbe5DL9LlCgW/jjTpTjCZF6vyyTPBonT3KKig+kGVf/mDXW
 SclM6B4dwaEHWE0iDwimbzGZ8olTZkYgOFHe27YIGru8D0vpepxeUE/iWloev4BSDHBgwwgmQKq
 LBBbgpJsR9jRU8oDstOfLK8AsYQxwhrvsJ0jeTIETH+3NwaB4KRpj1oMXBoKKLWZub9Kp9t+A5M
 X1bYRKt82+DXipxSeLK3h6XfUzxER09cfcT8U+Q2yixZ9gATa3U7PDUwp6JuKVlkr6Z1CMWH2Fv
 iy2Rj3azGJ9KQTkRTM2WpdQzShrIQPxjmkLdeub4Tr8oN+5W0UT/ywuAUF9UDsEn/+0N5N71PpP
 m+0Dpv35ERh8DmxzzX4Vsoh/qEjJlG2mAloMcUfjjyMt7ooKb3Id971TlasNffkGf6yIaIsBpXl
 79SLRmMpdwi7FC/KENaINLCDuv9cayQySDvWxrjE1LMAvl61aKImCYsNgbngS3vnO/CiR+/W2Hv PVWyg3BJIZCYi/A==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240418-alice-mm-v6-2-cb8f3e5d688f@google.com>
Subject: [PATCH v6 2/4] uaccess: always export _copy_[from|to]_user with CONFIG_RUST
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"

From: Arnd Bergmann <arnd@arndb.de>

Rust code needs to be able to access _copy_from_user and _copy_to_user
so that it can skip the check_copy_size check in cases where the length
is known at compile-time, mirroring the logic for when C code will skip
check_copy_size. To do this, we ensure that exported versions of these
methods are available when CONFIG_RUST is enabled.

Alice has verified that this patch passes the CONFIG_TEST_USER_COPY test
on x86 using the Android cuttlefish emulator.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/linux/uaccess.h | 38 ++++++++++++++++++++++++--------------
 lib/usercopy.c          | 30 ++++--------------------------
 2 files changed, 28 insertions(+), 40 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 3064314f4832..2ebfce98b5cc 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -5,6 +5,7 @@
 #include <linux/fault-inject-usercopy.h>
 #include <linux/instrumented.h>
 #include <linux/minmax.h>
+#include <linux/nospec.h>
 #include <linux/sched.h>
 #include <linux/thread_info.h>
 
@@ -138,13 +139,18 @@ __copy_to_user(void __user *to, const void *from, unsigned long n)
 	return raw_copy_to_user(to, from, n);
 }
 
-#ifdef INLINE_COPY_FROM_USER
 static inline __must_check unsigned long
-_copy_from_user(void *to, const void __user *from, unsigned long n)
+_inline_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	unsigned long res = n;
 	might_fault();
 	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
+		/*
+		 * Ensure that bad access_ok() speculation will not
+		 * lead to nasty side effects *after* the copy is
+		 * finished:
+		 */
+		barrier_nospec();
 		instrument_copy_from_user_before(to, from, n);
 		res = raw_copy_from_user(to, from, n);
 		instrument_copy_from_user_after(to, from, n, res);
@@ -153,14 +159,11 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
 		memset(to + (n - res), 0, res);
 	return res;
 }
-#else
 extern __must_check unsigned long
 _copy_from_user(void *, const void __user *, unsigned long);
-#endif
 
-#ifdef INLINE_COPY_TO_USER
 static inline __must_check unsigned long
-_copy_to_user(void __user *to, const void *from, unsigned long n)
+_inline_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_fault();
 	if (should_fail_usercopy())
@@ -171,25 +174,32 @@ _copy_to_user(void __user *to, const void *from, unsigned long n)
 	}
 	return n;
 }
-#else
 extern __must_check unsigned long
 _copy_to_user(void __user *, const void *, unsigned long);
-#endif
 
 static __always_inline unsigned long __must_check
 copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	if (check_copy_size(to, n, false))
-		n = _copy_from_user(to, from, n);
-	return n;
+	if (!check_copy_size(to, n, false))
+		return n;
+#ifdef INLINE_COPY_FROM_USER
+	return _inline_copy_from_user(to, from, n);
+#else
+	return _copy_from_user(to, from, n);
+#endif
 }
 
 static __always_inline unsigned long __must_check
 copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	if (check_copy_size(from, n, true))
-		n = _copy_to_user(to, from, n);
-	return n;
+	if (!check_copy_size(from, n, true))
+		return n;
+
+#ifdef INLINE_COPY_TO_USER
+	return _inline_copy_to_user(to, from, n);
+#else
+	return _copy_to_user(to, from, n);
+#endif
 }
 
 #ifndef copy_mc_to_kernel
diff --git a/lib/usercopy.c b/lib/usercopy.c
index d29fe29c6849..de7f30618293 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -7,40 +7,18 @@
 
 /* out-of-line parts */
 
-#ifndef INLINE_COPY_FROM_USER
+#if !defined(INLINE_COPY_FROM_USER) || defined(CONFIG_RUST)
 unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	unsigned long res = n;
-	might_fault();
-	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
-		/*
-		 * Ensure that bad access_ok() speculation will not
-		 * lead to nasty side effects *after* the copy is
-		 * finished:
-		 */
-		barrier_nospec();
-		instrument_copy_from_user_before(to, from, n);
-		res = raw_copy_from_user(to, from, n);
-		instrument_copy_from_user_after(to, from, n, res);
-	}
-	if (unlikely(res))
-		memset(to + (n - res), 0, res);
-	return res;
+	return _inline_copy_from_user(to, from, n);
 }
 EXPORT_SYMBOL(_copy_from_user);
 #endif
 
-#ifndef INLINE_COPY_TO_USER
+#if !defined(INLINE_COPY_TO_USER) || defined(CONFIG_RUST)
 unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	might_fault();
-	if (should_fail_usercopy())
-		return n;
-	if (likely(access_ok(to, n))) {
-		instrument_copy_to_user(to, from, n);
-		n = raw_copy_to_user(to, from, n);
-	}
-	return n;
+	return _inline_copy_to_user(to, from, n);
 }
 EXPORT_SYMBOL(_copy_to_user);
 #endif

-- 
2.44.0.683.g7961c838ac-goog


