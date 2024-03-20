Return-Path: <linux-kernel+bounces-108749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FC2880F84
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49011C222F8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B6B3FB93;
	Wed, 20 Mar 2024 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2pZTFNp"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250153FB3E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929957; cv=none; b=HhOPD/Ye2rQo/CmA6nzdHDz3z5NZ7FDiyB5hW4EhaQB9dHffsINiFxgiZ732Gyw4RqKb3U+0jdwSwXo2jMj66+/bUVO9BiGn4b3W7F7WqP5sWCaU+NmOLmfun683FWSbBlx3ozr4Pv6eGKfz8z8FckI0K5PKfYirKfpnOfUxlC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929957; c=relaxed/simple;
	bh=1EIpz4yJ9MkmGLF66k9fV/vMpELprPghjdX4s9eLzt4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y1JHlSyFbpP5lNV+IlJL/wsFsdIQBQ+izWzhU6VAci+mMldg0qXZc4/IvA2nl+He/5rgRgDDvH6PcnTxijAttVtgUY4Kgz4+mURlXTvoHcHWfNwFDnzlq33kIR3wYE5jRYZ2aFgyevRxkQjeenE+PauE5Aktdd7YUOrNIldTpMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C2pZTFNp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso8490341276.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710929955; x=1711534755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r71MCuDGNYKDimxiIJKs3mOhEvECUDV+QG0xkV6mxh0=;
        b=C2pZTFNpMa2RVlBYnp3u2ImzjvWhPs4R5cYh+VwooiVG6PDYZZmeHkjVZh7i3Mg8fU
         P7TD+bx+iO5onztxEQu0sA2r5AlbyTMcIL+P0NOuUa7FC+SPOAaHWtbTwnvnBFSUaE1r
         GhVdz+16qDTJbjOt6ZgPsPiUWf+HGSNegcgq+EZf8rc3h2SGwyBuVhlUPRTKZkifsmYY
         8YPsSAMut38aJGpYbHpYU6vSymO0nCDHRfSFscxiGWizpyyNKUADiIPePw+yfwRw54DH
         XAVGNy2d4+IhA75bmHUDRaszrH8yfwU6m9jKiUx87+s4WAuP2yxwkfqkTVewpX0YVvW4
         QKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710929955; x=1711534755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r71MCuDGNYKDimxiIJKs3mOhEvECUDV+QG0xkV6mxh0=;
        b=uTlxwIck9gVWuynz+yTko2ukS4uN1Ep1pQ5Qv3GDow04oUCqKhHfvHc4dJ4hqIacld
         SUc1ap3DkByBbgdKjgvBcrhHa1TuouckZeEu7+p1PtyK20hFRaAc6rDItys02+UzhWLS
         er4ETrR0Hr6uwwTIQtc/yVwk8YHIzhCHHyWuezlKG63iDx2dKHyfpDlvkGBC06d2Zj5N
         XmOSK/Kp3tnCGfCso0WUPClZCitD7ZaDc4ZNhln7Ni+8z5w/Kn1eQmyd0Fj+WMXT6Y9J
         2TeWoID5SgWnsVrKK+LlDhgWuE2/JnugdGydYrQ5WFA+k9ZY0GjYnSVSDQ9WpwtKWimX
         LcOg==
X-Gm-Message-State: AOJu0YzDGw+OoOOJaSAlzy92bmMnVwMu+036rOzElKiweTxukBkjoPz2
	fwTWWcgxdCpwKXmKyEvnCYXMUnnpFWNgNLq2NnqLSX2NV8c1HXwqTBRdajMlc7ibRjgIlQdQ+vJ
	gaw==
X-Google-Smtp-Source: AGHT+IGiFjO7C+gTehD6m6WxUP0v54ngFYmvEURPJrqbwSTJrYhYcYDkQLRaGgYDZMxUmBfW4tcHUqyzYLs=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:2234:4e4b:bcf0:406e])
 (user=glider job=sendgmr) by 2002:a05:6902:1b85:b0:dc2:2ace:860 with SMTP id
 ei5-20020a0569021b8500b00dc22ace0860mr915079ybb.2.1710929955165; Wed, 20 Mar
 2024 03:19:15 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:18:51 +0100
In-Reply-To: <20240320101851.2589698-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240320101851.2589698-1-glider@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240320101851.2589698-3-glider@google.com>
Subject: [PATCH v2 3/3] x86: call instrumentation hooks from copy_mc.c
From: Alexander Potapenko <glider@google.com>
To: glider@google.com, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kasan-dev@googlegroups.com, tglx@linutronix.de, x86@kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Marco Elver <elver@google.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"

Memory accesses in copy_mc_to_kernel() and copy_mc_to_user() are performed
by assembly routines and are invisible to KASAN, KCSAN, and KMSAN.
Add hooks from instrumentation.h to tell the tools these functions have
memcpy/copy_from_user semantics.

The call to copy_mc_fragile() in copy_mc_fragile_handle_tail() is left
intact, because the latter is only called from the assembly implementation
of copy_mc_fragile(), so the memory accesses in it are covered by the
instrumentation in copy_mc_to_kernel() and copy_mc_to_user().

Link: https://lore.kernel.org/all/3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp/
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

---
v2:
 - as requested by Linus Torvalds, move the instrumentation outside the
   uaccess section
---
 arch/x86/lib/copy_mc.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
index 6e8b7e600def5..97e88e58567bf 100644
--- a/arch/x86/lib/copy_mc.c
+++ b/arch/x86/lib/copy_mc.c
@@ -4,6 +4,7 @@
 #include <linux/jump_label.h>
 #include <linux/uaccess.h>
 #include <linux/export.h>
+#include <linux/instrumented.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
@@ -61,10 +62,20 @@ unsigned long copy_mc_enhanced_fast_string(void *dst, const void *src, unsigned
  */
 unsigned long __must_check copy_mc_to_kernel(void *dst, const void *src, unsigned len)
 {
-	if (copy_mc_fragile_enabled)
-		return copy_mc_fragile(dst, src, len);
-	if (static_cpu_has(X86_FEATURE_ERMS))
-		return copy_mc_enhanced_fast_string(dst, src, len);
+	unsigned long ret;
+
+	if (copy_mc_fragile_enabled) {
+		instrument_memcpy_before(dst, src, len);
+		ret = copy_mc_fragile(dst, src, len);
+		instrument_memcpy_after(dst, src, len, ret);
+		return ret;
+	}
+	if (static_cpu_has(X86_FEATURE_ERMS)) {
+		instrument_memcpy_before(dst, src, len);
+		ret = copy_mc_enhanced_fast_string(dst, src, len);
+		instrument_memcpy_after(dst, src, len, ret);
+		return ret;
+	}
 	memcpy(dst, src, len);
 	return 0;
 }
@@ -75,6 +86,7 @@ unsigned long __must_check copy_mc_to_user(void __user *dst, const void *src, un
 	unsigned long ret;
 
 	if (copy_mc_fragile_enabled) {
+		instrument_copy_to_user(dst, src, len);
 		__uaccess_begin();
 		ret = copy_mc_fragile((__force void *)dst, src, len);
 		__uaccess_end();
@@ -82,6 +94,7 @@ unsigned long __must_check copy_mc_to_user(void __user *dst, const void *src, un
 	}
 
 	if (static_cpu_has(X86_FEATURE_ERMS)) {
+		instrument_copy_to_user(dst, src, len);
 		__uaccess_begin();
 		ret = copy_mc_enhanced_fast_string((__force void *)dst, src, len);
 		__uaccess_end();
-- 
2.44.0.291.gc1ea87d7ee-goog


