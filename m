Return-Path: <linux-kernel+bounces-131438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3118987E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46EE9B2BF10
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEFE129A77;
	Thu,  4 Apr 2024 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLRtS9i+"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE9128832
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233930; cv=none; b=U6EEQeleFWsmSMQ2CcwMKaOchxQvZFBwcdxIag67dRdWBHyhdwbqci1FgyA3uHE9BAbWsg41rQyYcryG3iTJDAaPRn+0dupKMKHd6qh+x0PkAWCHAxFE1z8XSFJAJnP06Y+aH9F2uPydtSdcCiHpLIy25ESFoxl/k4WF6qobEgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233930; c=relaxed/simple;
	bh=LCmFZdYF/+l0SVNHm/nDN6l6wTxTp1jhws0CkfXtePw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FfTlwvZCC+5S2izSjHZNyoU+c++KslnQYpbwAxOMskfS4Q1k1IF1KBI1OdNrGy378Cy9BvIaBiwVKndsZJjXIEpH4ckeQJDYG1n27hbBC4bsF8xvNHJWSD74yU5aJzwSRt9KhtuzlIYSlJKpwdLw7pQ5CvZlQpVjuQVZk3EWMoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qLRtS9i+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cbba6f571so15540257b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712233928; x=1712838728; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XerkH2ynkf1vxp+fsqJ0qN8AZG46ak50/ECqEN32U0w=;
        b=qLRtS9i+Hpp3AoAJ9P2S6a9WNwWXQK5PdQigQeMkN8KusBsDj7EcoA9T0YPt2lp8QU
         jXUMmkHlLAIcYLgE7rEDbZh9unUgPCdg/G40G6rOIRVm9RlLbhri7HOgPuh0ByLmC1kX
         75tSZjjLwVztrhqlm5U08SlCVJMPRR7ffS65xhGEWxxLHYzTjonFCsYEn9Hbmg3gvFPT
         s8FAYEFgyw5kJkeK3MVDp/dhe9tJ0MOpaCUwliqVR2oWjo131F80d3b69XPYRkE4ISSd
         uswnYKPaBpNdBxRk+clQUa7OdmtEvMOet8obX3s5SHB4Ak83PKmonXnw2md4+XFr1aDB
         TwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233928; x=1712838728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XerkH2ynkf1vxp+fsqJ0qN8AZG46ak50/ECqEN32U0w=;
        b=pY+VvhStpGxtTRjVTphL5lhFZun/AhqFCYXjSDBm6rd0/0wKchR6Nk0M8Zh0OhJXbA
         9gmVqkxRWDQgqGzq4YxgAUFkeW2znENTo5c1riO7xhyxZy9Rt3xx3E0emN4WBQ+fSTV0
         PH4/fa+c4U51F3FlukAnB4ZIF8C16/r2YpHqR3yjQtgmK/kh+HifwhDNen0xH/+9+67y
         9m6EmEUT8FQF0TI9Zjnwff9YlXOGTX0/SUvaPEmMe+p4DW4u2580qL4JWx1j74RT4FmJ
         jy0yAoon6PbJPXeq4NBlvw2pWRhAGbjozOSxYLP3WFjvuvV6b/9ab7wV/9R6/McHViO4
         y3SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmRokNquwOZ+RsEYHapoGFCPlBOOup/tYDNn805ThwpTTCPp2hJ6LmvP0yBlV9Pi3vAnqQy1BuQZUFUzBGTL+321xZ/D2onRaRrWQ0
X-Gm-Message-State: AOJu0YylARL9XdsPoFPUO7dpHBwjqRATKj/OLcg54Dkz017A/lASPPVu
	Xx9Z4YABEXv8pLGL9lkTk7R6qC3KJ9JaDb1VmwFvGP892ZkaLbv8ey7hlb4opML2EIOHwZeSYQ7
	WMJizIvWxT6PsXQ==
X-Google-Smtp-Source: AGHT+IG0Bsq2KxhVPOQpSkN7RapTzL57jEs123Iy4spqtUcqzx174FkXstUUKG35PgzUW7U2kryjNQK8BX3zoew=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:124a:b0:dc2:1f34:fac4 with SMTP
 id t10-20020a056902124a00b00dc21f34fac4mr708607ybu.2.1712233928129; Thu, 04
 Apr 2024 05:32:08 -0700 (PDT)
Date: Thu, 04 Apr 2024 12:31:40 +0000
In-Reply-To: <20240404-alice-mm-v4-0-49a84242cf02@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240404-alice-mm-v4-0-49a84242cf02@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5074; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=fSgHfw/zkWrxiL7qQcuIRBGXo9AsMjuelkCO78cyAIg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmDp2+8k+koOL0GcIB850DW3ouuJxGlPR2MopoO
 q15ulz7hZOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZg6dvgAKCRAEWL7uWMY5
 RgjkEACUB3R7Sn1Mx7xhemoU2eWMaNTf+LDF5Kpe7cqJ9xnqMJgUM7WKETGwNBOqbI3f/iZTFjx
 aiQywDbimWtwIc1Drme1GlbihXwW0ut7WIvv+XyiIlfzJ6zyEg43G6KnkHgFJrDQNJUJasQnF1U
 rZ8fqDaarX/EyfixSMWxDOy5iBCJUUB9TejXbUP3TN8pM+eeWUcDj2Ri75ZLBBRyj0ZFHmNT+Rk
 CsyqnI08i6aYsXalL/ZbGJcbr5ZzMh9FHkY7WbwlX9kViCto4ryG5uD/OT/XqJhjfDSeoroEtpF
 0Pow3pGanpm1TogMELV6Al/8AYQxB2Ohtkto9Sraez/KsIwnHLWZUn7wy/Fy1122vwqDEDshM+a
 9ZnHdbaYeepLUl07i5fbfQJF+vspuYl4Vlw0Vy6wKf92sanv7LX0Ea51dK3p9t5ISZSCj+fu2po
 UKW8atf6Zd61GG+mkP56/s6RoAmb8FkFETpVa1TJr5E2AK08IaccRyTuge6riMTD3pco/tngGqK
 gUbxYKsknZcq6egCRWt2fr/ghJggswWqRlYTMwQfkqZbRxngZACZ4spgLjMfBhj/czoN1673bJ4
 GtDQCFA/FKvHXtKYpNaZPEbk0+O9ra4aNzGotNcsoVvFItYdR848PwQRYv2eh1kDTlnl46aFWAM NDdJ1cG5xmBxfGw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240404-alice-mm-v4-2-49a84242cf02@google.com>
Subject: [PATCH v4 2/4] uaccess: always export _copy_[from|to]_user with CONFIG_RUST
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

Alice has verified that this patch passes the CONFIG_TEST_USER_COPY test
on x86 using the Android cuttlefish emulator.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
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
2.44.0.478.gd926399ef9-goog


