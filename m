Return-Path: <linux-kernel+bounces-34509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77065837DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2172028DEEB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E109137C2C;
	Tue, 23 Jan 2024 00:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kfSIlFZA"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9F75FDBC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970167; cv=none; b=MDxr3OXV9IEAZmQmPOoQQt9LdWHTDuUp6rWS4MbYetPWNowLebbQdpjxlH9e/hySVLULBoUl7CIxIRNp2FzE9r4utDsoDBPExwC7syeoUZ1t72Dwd7kxMUysvQcVCwOn6sez9O6KhwBkouz/ZHlAqHzyppXsuPoxUB/WYkpQrd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970167; c=relaxed/simple;
	bh=ZK9PQLCXLKqeI6EmNJVF0wuj6cnB4GzhbTbrgojBZ9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bTWU2Sjr5FVkZWlMvFLaeJkvK5l2HVUy25yGXDlBdfI8ODj4rjsOD4HMVmRJ4F+YWD37MIfGSQ8cLMJ3giYMcCcmeHVNfRW/mRKJAcbmlReDPOZwQWhwmxsXiV4aPtEfxVE4Lj1y3s5ZpHKiQofbRgwcl+lg6UZu7LBrGLNJeOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kfSIlFZA; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59998b4db22so490411eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970165; x=1706574965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6q/05jnWeDl9wgQC0c2qm9hOe5mPaDwj5Q60EimLqQ=;
        b=kfSIlFZA6fnZU+ngo0vOwEzFDExHHTpN9Sow18ZXhBmwklUjezd2BJwZiMKy0piJTl
         4S/GC0HoUkS+YyL+Os4PbRA3MBBX89iR5oWnbdTnM7yJzHxrTZIRFmOU53gEIPpylooi
         prjdon2a1bSZf5Zp3sMoN16NHSNlQWhdqYDCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970165; x=1706574965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6q/05jnWeDl9wgQC0c2qm9hOe5mPaDwj5Q60EimLqQ=;
        b=nJqpH2V+l8I+31ujnjz+c+n+lYPMAZNJRruLam3SYa6nKKmRn1K6pU6K6lEKhUpAgt
         Ntoc1yZ/1zFwqBY+AjLHQ3z77kyHy5mj0cXGL1fUn6nZy68qkpK/MOr5bolsx3OiJjxb
         DyRRFfk5lTq9EDBneU6TiK4PGodsAqODuTzbw5+zFO28ts6YSxv/hFcdVPA2jAC/CegM
         Mqiu1D1lli26SKgJkOUYOY9O1eJuYLGh0QLSnC4d7GNP+ip3y+mYHxngmMOdPA1QRfvy
         foEQvd1L+m2Rc6fi6A+Un5drjbIdWI8eVb84woiQuOymbem9MtLWGn0q35VnSkkR5AXb
         AKTA==
X-Gm-Message-State: AOJu0Ywsl8gHkC6XmPEe83XMZMVe8QxBH1q4LzEtFa1R76TB6tsbeCJ7
	dfKuhUS0J2rrxkJU7spssv3lUJz44fJpRPtVjmANjkZH79ZP0pr4cSNkFqzoMA==
X-Google-Smtp-Source: AGHT+IFKzSLUEO//rfGN7z0yklmQ5nmdIr50yIhfprlff4HJFkLJGsjAr2HPDwPu40EicdjBjXXTcQ==
X-Received: by 2002:a05:6358:6f89:b0:170:c91a:b466 with SMTP id s9-20020a0563586f8900b00170c91ab466mr3835144rwn.23.1705970164998;
        Mon, 22 Jan 2024 16:36:04 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 8-20020a631648000000b005ccf10e73b8sm8711311pgw.91.2024.01.22.16.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:35:59 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 73/82] sh: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:48 -0800
Message-Id: <20240123002814.1396804-73-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1873; i=keescook@chromium.org;
 h=from:subject; bh=ZK9PQLCXLKqeI6EmNJVF0wuj6cnB4GzhbTbrgojBZ9E=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgLPxEAqie9ltCp6SXpHxJz4a8frf9JpRCdW
 Ks3k+P95JSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICwAKCRCJcvTf3G3A
 JvckEACcdyYY2SIWpI3UA8mAOkYcOxPIionsaXUa6hl6QfIhatPHcfLoS0jDS13mORx6DesE8QR
 cEMphGUFZaW309UODp7aj2yCE0TFoSPXkaVTK17BfmoRQIwhtk0f8XfbAE5ingmsTuXMtAnJOsC
 TuJCmFXEgdPGKvUH3Xb36aFDcfbo+XCAUnEJNX2SZCgGukPkeLLLbjS8PvuLCJtMMEnECnnR1B1
 G/OOQHRWemIAHGZHOxhqiqTULKLtQDEb9ah+eWfzVXVhPlSrg2dTXOvPz6UzqYDBuoGKwF5BOIt
 eXzxRTA/iyaVaOWQawo8BpS7RbJQO6ZgXrwtWcTjjEheh7JWOgHGzCIKRfW2kG45QTP3evtFpIA
 kOvZdB51R6QuF6t47RBV550QbgsF80t2UmsPYjsToEE0nPBdZ26Iq3l2lQxqDG1fxHv71r2LzjW
 DH+rai0uNuRUpzJ7IMpon9RPoW2yuFaProOmaiX21mVY9baklpdewo53p9mh/6iRCJ/vuUq/xSi
 kmUDoE7kbNyXIda7pkfffdCgpbBKQDzjA8F8iTmT9Zrw/O0z3Om2bC/qlgXNnZQLwenVATU5Qrj
 1otM6joYjNE87mYWGpZ614abu55pynw/87WeqCPNKZuArSS6+IqDTjPVGcwDtTjK4KqNff/y6iO TlhNUzg3ntPt4Qw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/sh/kernel/sys_sh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/sys_sh.c b/arch/sh/kernel/sys_sh.c
index a5a7b33ed81a..e390caeb8c00 100644
--- a/arch/sh/kernel/sys_sh.c
+++ b/arch/sh/kernel/sys_sh.c
@@ -66,7 +66,7 @@ asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len, int op)
 	 * Verify that the specified address region actually belongs
 	 * to this process.
 	 */
-	if (addr + len < addr)
+	if (add_would_overflow(addr, len))
 		return -EFAULT;
 
 	mmap_read_lock(current->mm);
-- 
2.34.1


