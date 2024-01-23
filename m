Return-Path: <linux-kernel+bounces-34510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E80D837DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33EF1C28BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486ED137C4B;
	Tue, 23 Jan 2024 00:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fRT0qu1b"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F34C5FF06
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970168; cv=none; b=UL/xlaJR812Vb9a/qWiMjus+qOT9oEd2W/uxhsyQklw13KDGSn2mS1JGtgyS1BZmDbSlMsiVZ6yZOKo29m8W71N05yYGfO0rLmwQ621Ac8vJaMU9Q0z91W6CqJIKT2RrYLPhxeyMnUQ5IQpqbTv3yfH6oL0co1+v5CjJekmjSz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970168; c=relaxed/simple;
	bh=08gzPVNqKaIThrka0PRUXmbx8gcHwrKCAMm1CuCF8P8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p9s5P26sa9O9POCmeqBQWflJzqGM7AAQ8y8FiWOkANmCML+90dlMytDjFJsEQLvlOs4i+5Qfg2/2edySYEykVTHUk/0Wef5cMofTxY3Vbj06u7Cdv854xQpnYibvYZC0WlPgRb1abtDsU1jhNh8jXmtW9LVtuts2ndnXwGEuVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fRT0qu1b; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d73066880eso18989015ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970166; x=1706574966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0IWBalbPa7nBe+7qRPGByHWNgNICkmEQCfSed9PR50=;
        b=fRT0qu1bXS9ZtGZoXpSXONIkIFh7UtLb2IsyepAXfL2Ah8wh6fmE1Rw/ORb449ACUy
         l+r4Qk61/jFFe+d7sn6aEOzHuwc1rlvgXkxYKqu0ue9qh1HG3yPOQbdHILED/U1EvK8a
         eVemySHgabNAisfyG01oG9nwc9qNLUogv+eAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970166; x=1706574966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0IWBalbPa7nBe+7qRPGByHWNgNICkmEQCfSed9PR50=;
        b=pd2Z+l9OTMfyzt/ikDFOADdWxA0VqlPeiQj8yW7da4nk9GX8KdytNdxeMbjPpyv/Vx
         wJfRqnc9BhFWpyRiQzbCWDRQwIWv9f741sdjj4NZn2CoGR/Z++i+gg4ZTtjogGgE1noh
         u9dAEUfkRKa3JzP/A4YDCOHy5rgYzPuc90oCxbLkinh5JxEj+n4C5ja1Mt0+xECjyv82
         9Ozx09hM8nlJCJIbNEAYCP/9ElyHUiYPs65gPn/mRWWAbV7p6PpuL5MuHx4YrX7Seo76
         hnfDObekY+ce25fi/yYQJ8aJvMivupWmBejup2lm7OhsCogAf9JiRgVCjJ3OFJ0XJ6I0
         oFYA==
X-Gm-Message-State: AOJu0YzasmZpQsZKzUp6i3RExrbMG4DI0YIzOMXRoSAHHmwbaut76L+u
	EEiMsmWEj8QrMRfyvtQSXmC4yKiAPwCv6DccEXT/Oxy/O4ZmJ6N2CyLJ2FBScQ==
X-Google-Smtp-Source: AGHT+IFAeQqI3FFXQ9+1Lb9KSwrHLPJKfBRcl5zF9RvXxq3cLLHLHaogLpM0B8iNqUxW5Y7pLSv+tw==
X-Received: by 2002:a17:903:482:b0:1d4:79b6:101a with SMTP id jj2-20020a170903048200b001d479b6101amr4643124plb.41.1705970166511;
        Mon, 22 Jan 2024 16:36:06 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902f29100b001d707a14316sm7490995plc.75.2024.01.22.16.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:35:59 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@axis.com,
	linux-crypto@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 39/82] crypto: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:14 -0800
Message-Id: <20240123002814.1396804-39-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2049; i=keescook@chromium.org;
 h=from:subject; bh=08gzPVNqKaIThrka0PRUXmbx8gcHwrKCAMm1CuCF8P8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgIRQrU4z+xZKgZEZXKAJfo17xdTxqMyiWe6
 GGw7oiVmY2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICAAKCRCJcvTf3G3A
 JtNlD/0d9ZXpSr+O/WY+Z8RnA0WFcmb8q8dHDR+pV9DASBchjSH3T7j/DJE7/4sN+voKM6jipuP
 +b4X/XvukaDPGcJID6ZCEETKBPkMpdxZthLJ9z3AD+pID8v8vvqxW+pRFzY4po/kjeOset6zPFO
 7YxbAUWVwSXk7QDgV3gYX/lK9QILRqXGRAhvOcubjgDREfAc2MbuJk4ItNqk2WcMnk53cEFtYji
 lJKFR1cHbwVPaSk2x/UmWTY9FIg9orR7rjJtFSCaZPayWmA4lNONN5MKTyl9QbNbB6LkGju5DJM
 Hd0T890SCjvldjd2bfSaiG9wW3fOFHydZMzdTnzla2TMofjeNAsC6odLW9rM59EO6ovdpQJ1M0y
 4TeZl+acwIvrGJuRvXNx0Nokuls+m/qhpft8nMxOcVOmd3BVu+jgvguImnYNwmX/2gdr1tHBEEq
 uBNgF0pN3/zlUJqLU6Jaa55akZsk3vMrVRP+A2Tr00GdajqCWKlEYuwX7N2mQ+PojwYVoKRfsnA
 wgQYhoKfgkZAFdaSlsNJcKY6N951w+i8ooSo5xvTH/8LATZEBNEZ30239h/apCk/ho5GUZ/fXJM
 RLglccDfc4V+1WVhsOdPVy53he2MDI39X+mro/t056xBMjwT3L1D9ZvHF5GnpW4GVJs19uUshk+ ZHeju5Fy9h8Zijw==
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
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Lars Persson <lars.persson@axis.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-kernel@axis.com
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/crypto/axis/artpec6_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index dbc1d483f2af..cbec539f0e20 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -1190,7 +1190,7 @@ artpec6_crypto_ctr_crypt(struct skcipher_request *req, bool encrypt)
 	 * the whole IV is a counter.  So fallback if the counter is going to
 	 * overlow.
 	 */
-	if (counter + nblks < counter) {
+	if (add_would_overflow(counter, nblks)) {
 		int ret;
 
 		pr_debug("counter %x will overflow (nblks %u), falling back\n",
-- 
2.34.1


