Return-Path: <linux-kernel+bounces-34547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0582D837ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A2CB25D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4CC13D509;
	Tue, 23 Jan 2024 00:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h0bylp0f"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B542C13B79D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970766; cv=none; b=uk6K9QIMewlabmdT23Bb/vnFfib42pz36lz2lCmfPcmKIKs926GLRpSNvCEz2ib1lyYREl/gB6pdtz5TVON+tcNDuaDW3Dsf9ACFGiNK+D59ozEZoiY9ZtO8Ohej7fiVw1OaNGJxWOiilOi+7eg3FYa5RPGxZBKcQea9ixwum34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970766; c=relaxed/simple;
	bh=S3lE7Ai2Kf7cSpp8TfXi2drtS9rqiWeq8QqsQWJ+YHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XxJpo2skReAC73/ByslZMXI6aMBflc+NN37UdDDH0mydUjsmDUOJmddvBzHUZrYOklrwnAArDcSzDhZPLKjGDFXRaIzQ9JVAjJixattDu0mZM8anvPWqC81hSqlqy3E3Ll6YgwTgurBT7SsAwnfPWlret9xEbACV73s6ry53jl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h0bylp0f; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bb9d54575cso2649785b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970764; x=1706575564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MA2z3IWjgPLju653GpnPneuk8sSXMYIY7MDwgOrEeUA=;
        b=h0bylp0fFqwPx5/BKMBfmW9USISNvvpat7KoDOX5suv4LUlXw9P7Q3Sxv3EjiwwCTE
         cdMxROs0Fyiallp3UyEZVE5/2Sb+yBk2Ec64nZq1M4Cz5J/W14VmMQETuvQtAkPgxVvl
         F6uD1ygL6z4fkZcaIzqI//b2tj7OGwZcVOFaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970764; x=1706575564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA2z3IWjgPLju653GpnPneuk8sSXMYIY7MDwgOrEeUA=;
        b=l5sKtT7swwLh5Trr1UtiYUA1SkDsfIiOCBejgaL/uWLpC+UxVW6T+broo5UcM/ORQk
         XAE819u2RCmgPs3yEa1QWbYWzHMyc9kU98X//QroYOrmiOs2KLtztXUIXyzGR1XBSfyw
         UeLYLb7LbdtHmYB6UGeLAlpJJuH8NdWswZ/Xw9goZrnpf5d+0BVl9GWUPNho/qYNkI03
         F3oHajoeIs1SqUlMj43WLnssPNL/wRie7XsIw0nkYXi8ADYAc973nDEbGvkWVUMckwVn
         +UE3O1MHdSS/anYu2JtacKzQCnqKK3bc6QVLLQBcWHTZ3uhXflrbxTCBDvA0BlSZjV+A
         W7RQ==
X-Gm-Message-State: AOJu0YxG6HqrI1YWz795YBWd+oEjN/BL3NVkhYk7uQOJi+RTDIDuQHLA
	VFclCc0dOykPMGQPCGdpI/bJ2vqBLfDOBZ52KN0oxwm6vvSSJYnySzLK4RHkBg==
X-Google-Smtp-Source: AGHT+IE82MRtpWX2VuxmOTfFHh+1PdFwz2wQFqX8x+zaJmrylEg5bhZ1KNGEdB6W0UvaQn+s9Twnpg==
X-Received: by 2002:a05:6808:2129:b0:3bd:bc0b:c87f with SMTP id r41-20020a056808212900b003bdbc0bc87fmr1947843oiw.4.1705970763993;
        Mon, 22 Jan 2024 16:46:03 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fm27-20020a056a002f9b00b006d9af7f09easm10145496pfb.29.2024.01.22.16.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:45:57 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Aditya Srivastava <yashsri421@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-crypto@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 46/82] crypto: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:21 -0800
Message-Id: <20240123002814.1396804-46-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2489; i=keescook@chromium.org;
 h=from:subject; bh=S3lE7Ai2Kf7cSpp8TfXi2drtS9rqiWeq8QqsQWJ+YHQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgIFrBJhDm8/jRsFp5KXXGFXlyQFO17YIpWk
 HrPa3eVKkyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICAAKCRCJcvTf3G3A
 Jv49D/46BDju32aQxhOHgZ6jc2ZxPYAa53gwYTEJs+crMQPxDAN2g9jCf9nyc2aDOCuLyDxZWKv
 rBrW3Ld9k2n7w4TWBQjl2B89slARHYYcfCgy71yrkGMpZhP+AVm/9C/sLAH69LUI9ODAmK1q12F
 LkTNTAnPMY6dinzgDjQ+tllqpakQz2Ah6/lrR3H3r7Re7yOd3Xe48z9tLhWRDb2kjaYYw+t+yE8
 SWyHOWVvBt9a8zReyFGDuTVfk7XOf95taKBrnX+O0UonyU7lyjzXWBNobIV1c66tELuOSswIo/i
 1kTJjl33xCiawkV/3eVMtvKZSUrQtFkckdg97HTQGJLKfLRzsfuWCEk4D7kgZ34+moGOI552zpo
 JTeh90ye5RwpqdtGoFBHCcs8+SfYFKRqtWwXtfj+iT5bvKGS318taLFS8/8ewnoI6V5dfbIxPwS
 FKj0LY8yDtgFnuDBJc+KqgeeCLIbsUeaYVQGccyMg+wbILzGUqTSbFLhtOLuBaPRT/hAcSexQ0Y
 /zji0LX72YqpF4NiRVweeuBbx2CTHDIuhko3l5ci0fTQhzvn+0kcjMjikO8YqQPgE/0IfdQ4o7V
 KPl6sJgP/PwfUOy6JiC5Xva6wJJ7Zh3AmgEWDbmyjPyAX4iD9JbKa+gndk+Wkk1RABXlj1qz+UT 3sDol/meOz7ZHoQ==
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Aditya Srivastava <yashsri421@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/adiantum.c                   | 2 +-
 drivers/crypto/amcc/crypto4xx_alg.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/adiantum.c b/crypto/adiantum.c
index 60f3883b736a..c2f62ca455af 100644
--- a/crypto/adiantum.c
+++ b/crypto/adiantum.c
@@ -190,7 +190,7 @@ static inline void le128_add(le128 *r, const le128 *v1, const le128 *v2)
 
 	r->b = cpu_to_le64(x + y);
 	r->a = cpu_to_le64(le64_to_cpu(v1->a) + le64_to_cpu(v2->a) +
-			   (x + y < x));
+			   (add_would_overflow(x, y)));
 }
 
 /* Subtraction in Z/(2^{128}Z) */
diff --git a/drivers/crypto/amcc/crypto4xx_alg.c b/drivers/crypto/amcc/crypto4xx_alg.c
index e0af611a95d8..33f73234ddd9 100644
--- a/drivers/crypto/amcc/crypto4xx_alg.c
+++ b/drivers/crypto/amcc/crypto4xx_alg.c
@@ -251,7 +251,7 @@ crypto4xx_ctr_crypt(struct skcipher_request *req, bool encrypt)
 	 * the whole IV is a counter.  So fallback if the counter is going to
 	 * overlow.
 	 */
-	if (counter + nblks < counter) {
+	if (add_would_overflow(counter, nblks)) {
 		SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, ctx->sw_cipher.cipher);
 		int ret;
 
-- 
2.34.1


