Return-Path: <linux-kernel+bounces-45365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 266F0842F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901531F25627
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEB27869F;
	Tue, 30 Jan 2024 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MhAo+yD3"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E384F762EB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652380; cv=none; b=FTtWD5PhFAckqmK+BAODPiVdUbSCr09+UmEq45WtPy4NtvECUnz6yJQYWZrpoGXkOs0F9e8OqIqipSoEhqEcTeh7Nbvp/YJPcd6p4IG8m8mpm4DyOtLn1eQSnpVFQ9JxdjpUWF9L4gHGKtKNpx2jmTdMN+wXC/fJ/WIJg/IwPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652380; c=relaxed/simple;
	bh=mjbhQQsJHZNHQElAJyka1am+OsaRRifuj4xn9QRfLGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l8NEfrPsLCYQ03ewSKnsw0SBjao/+ylHCXhcrw93ahnBCA6hDitEWPwI7FVkagnW5FJW9hlWyFjiNnb3MZgFDGz+FxsO0PPDvZXARN740AhDL4dExYWdBmIdJVbijb9K/+U9SPWiQyEVNDhCsYxLymw0kgDm5eACOD5dmFT20/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MhAo+yD3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so3400251b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706652378; x=1707257178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXEWZ+ijn2Mktyo3GgFFo1opylml2uwjVnLpw+L5S/k=;
        b=MhAo+yD3yaTWH8UHw3ebbIh/luRgWzh6Pnhtrm+K8yG7sVe892qUaYABmE4jmoPlOd
         5m02QtNfy57NU8uQEFV1sR8TTIC1NK66Z0jtp3DFcHk0JZF17PnnVS3mzE4x74Ll8b7A
         4OrIp5OlKlVWa9UOSjcLknmAlb9tvlz48jvK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706652378; x=1707257178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXEWZ+ijn2Mktyo3GgFFo1opylml2uwjVnLpw+L5S/k=;
        b=p7BcVUNKXU4dDS0+AcZGN91kRQ6tXfuTVtOufupUahKaQski6gruITpGtx7+O+Tgsk
         oXcrO77tUlLvZaIy2/Mwen06NJzTJm1JxnSIcUQLewXvyg28Kpo8QrpTY+MroedyLAS7
         prsNoD5/mxfCcn2wm8VbQquyEANYvLZlm9BFNILJAPlCz8BlVnn/CooQfkJGAW0w0Wuk
         SspF1KTTnroWFN6Df40Xwdp4pV855GkHb/Vf7YI/U5aYQ+ZB6Gz6pJ6BeqnBELYZC/SI
         yAR8a/Kfqb/uVn4LtiQnsfRPm2CKaDBw4QsOTXm0g78kNtCTRKC2FFFBvPBpaumJU1Ub
         bRww==
X-Gm-Message-State: AOJu0YyUuTVwY+UJ1Gv4/NBFVQxjyNHIEHDPgJOY0S2w90SSecHcVLLa
	LCoL+BqYoIyEjoAl9raYc4GX/pd/N61jaMgpacJ8JRpkwJYDQH9eT2RxetLAVQ==
X-Google-Smtp-Source: AGHT+IEd3zXlvSGgZ0mXCE1XjkvID5hcRbGGUrHAh6e87yThPodvIALQNu/8HwwxXls7VIkIq6gj+w==
X-Received: by 2002:a05:6a20:c411:b0:19a:360c:75d8 with SMTP id en17-20020a056a20c41100b0019a360c75d8mr8249397pzb.14.1706652378406;
        Tue, 30 Jan 2024 14:06:18 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903014b00b001d8dedeb0casm4331642plc.180.2024.01.30.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 14:06:17 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Marco Elver <elver@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 1/5] overflow: Adjust check_*_overflow() kern-doc to reflect results
Date: Tue, 30 Jan 2024 14:06:06 -0800
Message-Id: <20240130220614.1154497-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130220218.it.154-kees@kernel.org>
References: <20240130220218.it.154-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2716; i=keescook@chromium.org;
 h=from:subject; bh=mjbhQQsJHZNHQElAJyka1am+OsaRRifuj4xn9QRfLGM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBluXLRXPWpxbxWBABUSnq7LV3ZR63LVVosG/CRP
 5ZzpJGG3mKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbly0QAKCRCJcvTf3G3A
 JsZ3D/47FGhmdQqxJrZ9wW+IfjOj5Z+/JJdT4A88xjMViD8m2y+sZ66ET8cpz0UxvZb8wc5ydbm
 kKGJkwmx2MxOImy/n06QpmWo+Jj6Hcb2x4MhjJrvG7QbIC8no338Da90doAljPBJQardE1fF7BX
 TAwaqrSw+31TcmCP/J6CJ3Zy1M7SMmYp0HdBNg7mIDikbW2FYa3oKBphdZXiLt38fjJJQf2jUFd
 CBKnBPtpk2Q42oSJwkvv0+WZj3zuvoFhIgRyLYf0i9QuXdQFK8IfVBZQi3UUcyJRTHJDYshhaTS
 yfLfrJ6F0nr8PdL9h2/IqewAUyNk+YiE0J1j+Ds70hYy9YypS/JaeNCvKq9n42FWNRatqLbtMEs
 HweyCRNsTPMccrf/ZSHVhW83m0QZP3tZ00lVm3rgNhL2Q/oa/pqerx8fp8YgQ/JgLeRgJt1eK2R
 ino8gJHkQp7HkP+owrvPQZBSFUjFFBc+7ZHhkOiOYDQ/1v7RZHuIH1CYRNyhzUdlSU+QrcgUX9F
 XfRFoAkuBd8qYpVccYsV+1/zKrZDgEW72okrPtTNzp1Rjo+eXk5QFw9bDTl/qo/CClNbY1F0PxT
 LKPYm7R9P1tk0jtAkCFen/ejWNEp8jvYos5ar8T5/53t/xYMN7kEw1Cj4gw2iJwJ5U7ELiklaKW B5/Vgg5InWPF4Aw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The check_*_overflow() helpers will return results with potentially
wrapped-around values. These values have always been checked by the
selftests, so avoid the confusing language in the kern-doc. The idea of
"safe for use" was relative to the expectation of whether or not the
caller wants a wrapped value -- the calculation itself will always follow
arithmetic wrapping rules.

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>
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


