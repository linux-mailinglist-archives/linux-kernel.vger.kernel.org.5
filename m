Return-Path: <linux-kernel+bounces-34482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB564837CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9841A28A4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46895159575;
	Tue, 23 Jan 2024 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a9JLKB2a"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A14158D8A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969742; cv=none; b=NxR3zk8SYu81D2r4OvdMndeUrdm+4aYMUvEbQCXT5z1aLCSPy49Kw/EptTaRmPwtgO8rdSr11ju7FQJ1Wour80HkQ8wBSYyYUDYUKeE7M9iGzzzwCShaoTD8TA9cr0OX/Q5d7YpE1PLzaKnNVoRd0KKSOVDwabFR2y9pvA6OdBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969742; c=relaxed/simple;
	bh=KXulPh4t4RiYFM61WwrsfgMxfDXtkwo2mrzOGlAVyok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3FYD1xevt00MJ/Th32mDk1Ygg7BMzYV4nf5E2DxckILOvZZn11jWe4xDRPmZb0lXWnqDpAoJCS6euhCA6cqYzNptvwxOT70rFf/j4J37evII6o88CHl2vHHf+YUbYQREzvlQfvVIkYh/YPdw78PvjLWOXzPu8pmOZVY4FdX3Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a9JLKB2a; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ddf26eba3cso2445261a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969740; x=1706574540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYPePh3YDAX5XeUL0YItedWtvGPjAEL8L/FW2KUYqQo=;
        b=a9JLKB2asiiC2oxI2X2Vud+WSqjrEcwmdrULfbgjYyoLE6Lk1/sws4gcifbIALZvSM
         vdhss2aHv8lxOZx35d4nGg0pBUi5vyow6o0ZYW0kcMCcOwqDnoL+tnOFHmgD4UV6Z0Ku
         WrISTk1pzTCz73nd6bR/36Vnm0YkjnVEtzbwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969740; x=1706574540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYPePh3YDAX5XeUL0YItedWtvGPjAEL8L/FW2KUYqQo=;
        b=p8LE6zVMLXwtICKvdwGPtRws7aZAxNaN/3lwR70heZ7WuKVZN5fqBAc2St3RGlI+JU
         ALygRLfhN9NppNgjsoUfzE2WmcaMDSm3rDpvCSnE8pEe4v0Tem7Ne++LvAK/dq/lOIpk
         39+QUNTD7w01kXC3w0CUxBAmGg9MJUU16vJt9LZiTsk6BaSgb8J34r38zBtGjtkXSy7S
         g1ZtsKJoi2ogpfr4RM3X4H6m2DiZ3q59YNmFDQJQu+XZTAQkgl9/cF55SvtH0OTGpX3z
         zpXoXTAXZ0BTgmD3xO+yTl1FJDJna4WOQowYDyvXM4qULToxBEKt1JgXv2MvrwVjsjEM
         g9Yg==
X-Gm-Message-State: AOJu0Yw5G9hO73q6l8jNMlbl0HnIfEq3GbeSLHYKqipi3JbkmNidSoOE
	QfRWHQatm2wJZv4rE/dlBgFgbR0P1df2V7Hx8iwDFLqeR+zoLqRBFpN5OKIepQ==
X-Google-Smtp-Source: AGHT+IFMstEscoBrN0aJQvkfd72cl9+1Jfzh5pj8esCqjdIwXGP0lIWzK3WICAOAdiZSyvHClGKcsw==
X-Received: by 2002:a05:6358:d142:b0:176:5364:4c11 with SMTP id jz2-20020a056358d14200b0017653644c11mr1705146rwb.18.1705969740238;
        Mon, 22 Jan 2024 16:29:00 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sr4-20020a17090b4e8400b00290d1fe7004sm1125pjb.27.2024.01.22.16.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:49 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Joel Stanley <joel@jms.id.au>,
	Alistar Popple <alistair@popple.id.au>,
	Eddie James <eajames@linux.ibm.com>,
	linux-fsi@lists.ozlabs.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 21/82] drivers/fsi: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:26:56 -0800
Message-Id: <20240123002814.1396804-21-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2068; i=keescook@chromium.org;
 h=from:subject; bh=KXulPh4t4RiYFM61WwrsfgMxfDXtkwo2mrzOGlAVyok=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgGVuv+cx3dly309OCp0+qc8WOYsn33imp7w
 Era4ZtrnxCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBgAKCRCJcvTf3G3A
 JpxaD/wP0LVNx2em0pfpaFXC0tZD/FxxSF459U6XlRqkrqEKIO6/XBj3CX9EWp/TE005lzpc2N8
 +Lc4PJNwg6U/eOU70DhuzHbs8D4nlr4wf3TTdZrsyXO0gCVwv5qrfsz3rm69M4EflEjIN2dRsoJ
 T5hnFI3MQO4+iyiyBwSTAeEN1zN5PfiNBZyJQ/RbxU6y9hNJcfeaygZQLNELazPfzJg1gfA7h+X
 M9AH608Ag7OMHnQ/4P1gxYCwXpBF4fndGeeZW0aUW52myuvy3UBHiDNy6FnGILcAjJLe1lewKma
 K5K0wRZNO07RRdU71tSQDU5z8S6HhYWUQGHqMx11ubZamRt1q+ElS4USRGPyEogYbr08zGG5XNJ
 j8y1M6rdhGvpoO8GGjcNVeboA9LLCmkVNB4M+gN8yVtF8Dczbyl0sWbYvoesORKqvr2+t7VZELV
 AaSQmDgSAOTHrbYNZDGrZVxfowG/eHplD+Fw9oZIHuXHD4w2FuKcbOUzlq81MVW0/cgoejXmh/4
 0KUkG/jAHr0SfhYT0xvd015htl2LisW1Ma9fki+q2+kVV2h1Na7pn2PkxHlQ2pDDL8KVci3x/6H
 HttpHX/GSMfBm9LWUvZmaY0DRHHgMo7l1f9pb1A6YSdSejyOiQRR47YeFnuIbj4Wi2MfKXSZYKs bbHmMsPpbu9phdQ==
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
Cc: Jeremy Kerr <jk@ozlabs.org>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Alistar Popple <alistair@popple.id.au>
Cc: Eddie James <eajames@linux.ibm.com>
Cc: linux-fsi@lists.ozlabs.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/fsi/fsi-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 097d5a780264..46b24d0aadc6 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -381,10 +381,12 @@ EXPORT_SYMBOL_GPL(fsi_slave_write);
 int fsi_slave_claim_range(struct fsi_slave *slave,
 			  uint32_t addr, uint32_t size)
 {
-	if (addr + size < addr)
+	uint32_t sum;
+
+	if (check_add_overflow(addr, size, &sum))
 		return -EINVAL;
 
-	if (addr + size > slave->size)
+	if (sum > slave->size)
 		return -EINVAL;
 
 	/* todo: check for overlapping claims */
-- 
2.34.1


