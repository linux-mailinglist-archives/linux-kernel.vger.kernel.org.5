Return-Path: <linux-kernel+bounces-58302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4A584E447
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4E1285855
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39307E569;
	Thu,  8 Feb 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhcle2eZ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4F17D3F6
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407329; cv=none; b=IKXT+sMeVdMeoGX7hLgpPT4sRXWnItzkFwEN9VfHzxrSpxgL8sRO9+SCg5ch+Q2dtnTSX/DU8yYhrK6CgOp76heSV05XDYGKoGtY+AVaTio1xtmzFNG9u+NMTnYJblLqwdMCKyqtS88igzI+mxeXDqnvWUrWtNeoTpzQzwPIe0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407329; c=relaxed/simple;
	bh=JiNY7UD5yChmAMASqdU3YDYjcAqL6joPoUB8j2lzZeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NtaWVYqmfCS+cKFoahN8/MINzKLOtIGkMRxWV8Jvej8kizhSFA9s53k7We/gxZjrElJWwoztTiTvL2p00dq2GtbHvbx6xvcmNbjNcIP6ZC7dMy/a4fJX/VOQjdTjGkuseVAPXpemsG4ItdeEbxUAstAbHfaJKAnWsBv+DYDUphw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mhcle2eZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so302251276.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707407326; x=1708012126; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1MPoST0g8AYkDBhG2VsbV1sslw+0urv81QcaeUn+juw=;
        b=mhcle2eZCdtlsc9l4HKuZLLrbhdElCfqlSSGlxuTHyUP2BtmZ7p5AU0/XAD3sUDP5p
         u9bTEkLBQoOOPkSRAdoTWHRxwZpsK+7guY5NPpB3rMJSh3fSnPVAr2hT7Ddrz56yZk4G
         DNi+4+GaQuUZv8oul/z5l12kkLF7XXIphLgBIGVE4TafxE4izKiHQOcD0A6PDWSKKaj+
         jrgpOBsFxB5rg0mSuS9nHwcpARZTnqmBB0QrchKn1U6UpW8tyYvTA9USN7ejt4Ww4PiI
         l2JdWLDXvXhkVWx+jF1sFcDNNpTrQTrB6SVJCgbAVyepNaLwr6F0+BMx3ukzQugPyx1U
         elJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707407326; x=1708012126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MPoST0g8AYkDBhG2VsbV1sslw+0urv81QcaeUn+juw=;
        b=vnEdLScBDriw7gvyxiIj8e6BjiMyKP0sHt3VJ96zPbRor71SZCSQ3S+bCRJ2YeQ3BG
         aYmynycneEw5oFQwJxeCGvS+eBQJY50PrBfJqbhWRpTMGvfZaR9LYBQ49swozdsUVg4P
         Qh0vQw+mKT0EeJR0aVocnmBNA5LMqyTPpH76813uWZZIILyzMOWMoGYMA88u+etfcLMf
         dsPDmip8NpDxCOOPoH89U2eTidxpTcHPgKEIIvzGlxIYH02Wl3SKlTpiYA2AG0uV1V8t
         nQ1OO8Gt7VKKyCZ94kOLfFmZ9t6rkOXOMbEl4EPxgrX7e6oiZNASAFxfcuyiy5L+diSw
         UMVw==
X-Forwarded-Encrypted: i=1; AJvYcCXGv9O/C6J3mkE+DMBi9GnfD1MiecFkbglClZpOq/CszXgTdPD+8l7OE6DLXvc91ccIj7JKBOkZ5diL1t3rZy9XNgiLrOEI0L4q7FbE
X-Gm-Message-State: AOJu0YzU4IiJofZhPTPml3hrV2FUOlmGWGWbTJ8eM1U5mb1W8px1xWZy
	PrNIe2XsEM1MkEo0y1hCtppuuVsAFKLzguDJ4yt5pwNJSl9vVyJhs/fwqAAFhmA1GqjF1VflF5d
	xT43zYmgj8oA/Zg==
X-Google-Smtp-Source: AGHT+IE8Nan1uCaJHug2RBjceERk4R9+9qTdLW2q08muXcPrNhxeAussQfhnPOBYaHjyNRTtMgh/P0qbCDqR2bA=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1b88:b0:dc6:ec15:5f6f with SMTP
 id ei8-20020a0569021b8800b00dc6ec155f6fmr340204ybb.6.1707407325732; Thu, 08
 Feb 2024 07:48:45 -0800 (PST)
Date: Thu, 08 Feb 2024 15:47:52 +0000
In-Reply-To: <20240208-alice-mm-v2-0-d821250204a6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208-alice-mm-v2-0-d821250204a6@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4643; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=5Gt2wgkxBTJYGkfZMpeUeH1SE3k+76BKAUtR156EeQ0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlxPfTuQDsKBYaMhTNxSmNY7PLIkKVkVnXBgh2h
 FRUyBw0ZDOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZcT30wAKCRAEWL7uWMY5
 RrCTEAC0DaTqeHguZBQPjq0PPyT3rF4dgf8yp7QxrvoiztTXntK43kWYjtU6x4CoxRG+Lfp6NCx
 ahAklS4wQAQLPnwFB7n84XdxDQiFmRKJNiDdfrZtYj9+37q3KZnmt4B0N9TU2/tv2596QUrr7g5
 8FHFh2cgpuJV3O8Gb9U2movzF0Y0EBrHeg7p8AhkHNs9taPgH7S885BL8gs2rLzgkPYKf1sNY/C
 5hA4aJH/a9yzOjOWaRmFlkB1kZRm4KiftHLzWE3u3ZMHhfwXiLR9fMIvCjoKUcGfYAYHunM3gkc
 guKnoQhyh9Jo/b2AwXr5KVNQFbWpKIpRAFkieNgtgtxoFyYag+hQzN+8zEukWaMv/Tcw5nn2l7G
 fTgEJjZLgfS18WZg8tIiwBGCpb7CGApvnSE6czD3O116L7MaFZgsyQ18xEcrnwnisEh8jGkEpRS
 mcAYoaxEnBgCGDCF7wRrOWQGk60Sl2TD38A8wJYuhuz/XZ5kzXa0TAu7H4id2ZqjQ2Vt4E+07s6
 ObN4KfrT1dPCAm9M80Bn1u4Emonb0v4S5nykU0Awlen1fu+wttxiLdNlG+zwcaHELAt39pm2Spf
 PfDE4plBBAgcYG75I1TyaKWvyIb0JcNlLzTdXEskioQXW+n0ByNOrNohTMoZoXiY2vxVWX0YcK/ CE7RtNd2PYweYRQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240208-alice-mm-v2-2-d821250204a6@google.com>
Subject: [PATCH v2 2/4] uaccess: always export _copy_[from|to]_user with CONFIG_RUST
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Kees Cook <keescook@chromium.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"

From: Arnd Bergmann <arnd@arndb.de>

Rust code needs to be able to access _copy_from_user and _copy_to_user
so that it can skip the check_copy_size check in cases where the length
is known at compile-time, mirroring the logic for when C code will skip
check_copy_size. To do this, we ensure that exported versions of these
methods are available when CONFIG_RUST is enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/linux/uaccess.h | 37 +++++++++++++++++++++++--------------
 lib/usercopy.c          | 30 ++++--------------------------
 2 files changed, 27 insertions(+), 40 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 3064314f4832..835aa175d0ee 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -138,13 +138,18 @@ __copy_to_user(void __user *to, const void *from, unsigned long n)
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
@@ -153,14 +158,11 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
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
@@ -171,25 +173,32 @@ _copy_to_user(void __user *to, const void *from, unsigned long n)
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
2.43.0.594.gd9cf4e227d-goog


