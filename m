Return-Path: <linux-kernel+bounces-34484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C112837CD2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415EB1F236D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF0715A48D;
	Tue, 23 Jan 2024 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ShOf69Of"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874DC15957D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969745; cv=none; b=lGNE2g3jzUiyp0UI0kOY9tGdicJ87AJ1EcjdDhwPM+O7cKgX9rfKYYP91PDjJM0NsFzVv8xQbV4uotlVC5H09hU8UA6g5bjfON43+2OwYV3OrTSAkU82SxTaMKGRS2BCVsMnt8zi8+ZRgqoQxncnjBJNJzhiZUNlxsO/XweoMDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969745; c=relaxed/simple;
	bh=XAQoOIkQjY0zMk+dHWbybC5ZKFK8/5G+noOqaOKWewg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nx/ShDgcBAzM0nbh2DFcsey9dyyuzXr7GPl00pW6o0RDKKD88+C59ePbKEWREXoDICoHFFunZFnHlU4XTe7F0xeERsTGfxBHcXjTv3hDDiQhAnyZv8ctoD2UxkAsCSpyn7x4yDhMwanw/oxpW8O7TDVp/LIiGD1uSUg4DBq0UHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ShOf69Of; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ddef319fabso2473576a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969742; x=1706574542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNxK54+O9qfEZ1Gy1nh3zm9qMlmtWIma8ubsBMOVD0k=;
        b=ShOf69OfcQK3MJYztlKLI877DhjdHbYi2/Zlsm5AsMg0GHX+tT8m+ngD2wgLIfA4O0
         nImvmLjDw8BfkXweYJdy/WQp3ZDCBwwd2CVSc1lwHu0d55H1E8//sPa4Sp/ZJt8V4qXA
         Pc64VhF9OovKn0bzIoEVJnVrHv7NN4hJyelkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969742; x=1706574542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNxK54+O9qfEZ1Gy1nh3zm9qMlmtWIma8ubsBMOVD0k=;
        b=w8lNXfkJzUKyAex2SPvLpGK5TV+gNRIYLl++1eBQkbU9yetfc0fgBD/V5w6oTZOkYG
         yTSisc11WgVoSgpCohXB44c5877zaxd98J34C56s9xw6+5QWFBNnjYnHOeqSqUq5H3ih
         V1BgFYXJyupEoGGuUBKuaQMXseKydDZBTNMzkANWZg0B4RldcxGzZqRj4G7QDCEXcoTB
         5n8lpWpOqj84dYTxIMpR6BxaiTO+xndqYCTJGIW+cJqbTtyidB5TsObPYNagFnSj8bVd
         5zz4jupQ2aMSTL3g2CD0usmwfIcVnbw9HbSd2GVZRVggid6AE9TSTxgYFUjG3kiwoSo1
         K4LA==
X-Gm-Message-State: AOJu0YwD6oGDZjgMk36i0YFhHrs130gTv+I7rN62Spn68owD6UNT/D/X
	3XAVI8NfRJ/o5YuA5enLwLin4gOwcmT6Nbn3Mq7wBgOogi9mh8MaAGkBY1bKAA==
X-Google-Smtp-Source: AGHT+IHcKjQ9UWVfEMd4sCRoJ2KtUV8UZ+BQlmqhwHtwPzVxiVSMYPk7EMWK2rX13yct/KygbUM6ew==
X-Received: by 2002:a05:6358:9999:b0:175:cfa7:953d with SMTP id j25-20020a056358999900b00175cfa7953dmr2519120rwb.2.1705969742666;
        Mon, 22 Jan 2024 16:29:02 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p42-20020a056a000a2a00b006d9b345092dsm10156378pfh.156.2024.01.22.16.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:52 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-sgx@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 22/82] x86/sgx: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:26:57 -0800
Message-Id: <20240123002814.1396804-22-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2369; i=keescook@chromium.org;
 h=from:subject; bh=XAQoOIkQjY0zMk+dHWbybC5ZKFK8/5G+noOqaOKWewg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgGQbHPFRGmKfOSqdiDbC4Thjjraj19mraOw
 mYJ6/1asvmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBgAKCRCJcvTf3G3A
 JsV0EACtnE13DJYW39J+GQUGo6U7VyUEWVQUS49LQ2SDzwdXizpn2bSM1TD02w8fnZIg0T6dkIk
 v/uDGtBM5IvLYD9W/W0jEpmhzAdG3rCoxz5P/IaK0izr0ev2nRnLEAnRjls5Y+sr7+uYnxPBkLx
 vgOaQ8DpjPOITXiVEVX05AMXq7EyJqcY9Ezs0MOXXetGTp7Om02ibPyP1ZZeJRDDn7vudS2CvSj
 /021pIzhlYeQdy6yp36Tb06pZaWpA0yM4BpfbJydZsqbLhJvVfb4I9kxAITxQ2hQkCr+k+KJQ7f
 7DbxPtmjFxbBeI2Nr4HHzaBnAcC2jSKos5rOoDtFlmQbqPvvoCdECsT29X1GpVHcsdVbLSqCkye
 YG+mBHrck+3CbY98P8Wowb0X5QYxLYOzFAUvdayNvpPrjp7kXjS+WubEuciOESOQrR5XymxwtfT
 tgm2igGs6tSKzMwxgihy+EnugBGZvADHPfykwok5xs70n1j7Py7ft4hm4dc7bF0J9rp9FcHZLPO
 VXKlESGWh24+cIwXYytA7Bhr/MeIdG6E1eJabICXAoqT+G2UbB0fsoheVYNp1dxVCXNEUe4Duwp
 uaRSmri6nG+++OLuEcJ19Cr7UmHD0KInl/LFpj1P8CQVt+gP6yXr1JJVkzo0gtKh6N0o+9ONWa+ RloYCNoTLChVTjw==
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

Refactor open-coded unsigned wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-sgx@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/cpu/sgx/ioctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index b65ab214bdf5..4b8f6c9f8ef5 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -350,16 +350,18 @@ static int sgx_validate_offset_length(struct sgx_encl *encl,
 				      unsigned long offset,
 				      unsigned long length)
 {
+	unsigned long sum;
+
 	if (!IS_ALIGNED(offset, PAGE_SIZE))
 		return -EINVAL;
 
 	if (!length || !IS_ALIGNED(length, PAGE_SIZE))
 		return -EINVAL;
 
-	if (offset + length < offset)
+	if (check_add_overflow(offset, length, &sum))
 		return -EINVAL;
 
-	if (offset + length - PAGE_SIZE >= encl->size)
+	if (sum - PAGE_SIZE >= encl->size)
 		return -EINVAL;
 
 	return 0;
-- 
2.34.1


