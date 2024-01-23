Return-Path: <linux-kernel+bounces-34511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112AA837DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE00D28EFE3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA571386BF;
	Tue, 23 Jan 2024 00:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RAxgGIe7"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50A1137C40
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970170; cv=none; b=IuUc+bKZ8MFm4+Ctiiln6b23ZBjSVc7P9NgMt5rcFr84DYyj8AvE2aZY2G1dW/jbCS6dP5whVsNisrXsy/XAhK7baf/m4oG5sG10URRN6Kb4qIOK3UuusomrNgK/6rGz3LB8v22MnzP2EUntbKIgG2TUirMVbPg+HtbUGhnPt9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970170; c=relaxed/simple;
	bh=t5NjTIyb78Owo8zdIrnO+cNPZQCmas8okHDaZcCW+8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rIuzpxNqSDfbp3DJI0PVg5ppP2Db0ihLxs97K/k1AuxmWXbi/FHw+d5dFi+7JTy+ClrpGdaCe0ac/gd6Gr4yymoqLMI82aB2w9RsmPfAu6b+2SbylCJfcypO0qXrK9R9FFx/Y+L7vIV5KONGPs75I0M5IMpFNRKBVjSVErdrxzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RAxgGIe7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d7431e702dso10719335ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970168; x=1706574968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7ZTM5SgKNIL4BhjlzbkN6VUe2+U+pKLPfyRCBZRraY=;
        b=RAxgGIe7WpZkyy1/QIFTkVXwi6QA8CPIs5r29T/otOrJZOPxH21Qa5Tj8m3RlYy0bs
         3LN+MybCVhxFdCBWuEQyLGQZ/VVkh0+mpkQn2+Zf2avlmGyhq/G1RjywwWg7kgyv/4Km
         RMGLGV/nM5b4HYjpBLnA9FUGjnX4+z+2w4Ni8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970168; x=1706574968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7ZTM5SgKNIL4BhjlzbkN6VUe2+U+pKLPfyRCBZRraY=;
        b=h9EAfD+2naB0SbBkKS1i2F1sls+1J8GJKLxxrELXHenGGqqqcMH4dogbzrmGXJy6TN
         77uEMp4lXfEO8zkaVnftqVyFNq9EftFDgujwABIxaeTarlpF9j+6QbwU7a8FM5GA1bCu
         8n9hH/p98HZZkX6Cog3gtUy4OQvxbrCZaa6UoT1C4PuBpq5exUQv9q0VHqwe/o8aK21P
         vy9iQK6FJ5WefPxohCpOooIEv9hBiycQ3exVZm/kBw97BaBHvmbUP239qq9cpjuq648k
         31YsM1k4nHf6ycVuixTi7g3M6ynvuo2w9bKe5lOpdmVG6sBp6T7K6fFmWsfyUn0dV0Cy
         oPTw==
X-Gm-Message-State: AOJu0YyLLMz2FrQSLjlUPjdmv2jCt/opKGi6Ja6yXY+NFlonwoLQGRt0
	PgYvJHW3vgOGEbFOXgGQFsq+0y0tdFRTLwoU0IvBK2GAu27e8eHLNF/q73Wotg==
X-Google-Smtp-Source: AGHT+IHma0YydFHbhFfrWsggKZl6acEMucYTfJQJ8bR7gd8MhZKLGwEpOVissYArHVSd6tQkC7YMdw==
X-Received: by 2002:a17:902:f80d:b0:1d7:1df6:4511 with SMTP id ix13-20020a170902f80d00b001d71df64511mr2230166plb.136.1705970168258;
        Mon, 22 Jan 2024 16:36:08 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bc1-20020a170902930100b001d6f33c6541sm7744955plb.285.2024.01.22.16.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:35:59 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 38/82] arm: 3117/1: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:13 -0800
Message-Id: <20240123002814.1396804-38-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1869; i=keescook@chromium.org;
 h=from:subject; bh=t5NjTIyb78Owo8zdIrnO+cNPZQCmas8okHDaZcCW+8I=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgIgNjftYd6KqWOKIJFbI/lZsVWsVXrAIYuR
 7MY5dEcPb6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICAAKCRCJcvTf3G3A
 JsJMEACd02wCA8LfA0u8syRk4/Rp0JpgNpsiW+94NxRf9Xb/Oa1P5P/23a62lAN63yHc33ODE4L
 M3ih112Dkk/GdYQYFQoseAYyd9wEwaRrK6OoELlJ0Ze4FwF5E9bPBzZBN+AToRmXDARPSePbk6Q
 HZi6hgbD4OnzpQBqRmCSRJL0lJyo2ziVbh5BXwDaxazgKG1QvTQQhuL4CBsH8QymXeO1WoobbQk
 26Lf+jshILYsRLrtCn0FlcZsh6mlBSxO0KJ4CUeMdPyXb/n97DlDo9ZRsMvL5zEVKBIg+JxLLAB
 eiERpGMH5u8wbAPvM68kknVE/5x/EhJxjD/72ZmB8fLPsBwqyfIi9/nCtDWqnxR+s8y62/FagId
 vKwupeZJckFZhlj3FplDpT5AgCdjiYDr04S5TE2z7ZeLF88go9lfifcAgNHiaMV2wVUow1AxKoR
 zhpXpqgauLnNTNDDvyIpLRyEB2bYOzXIbRViZ4g9pC6cZ61woUKFcXLKdlAzNydxV8+S0EGFsPY
 LlHwmd9SZ6ywdnnVcm7iVBZb85cRIWlqIuvHSZrpSZPbpuYmgm1uUl3D6tLwHejiVVkF8Aj/osn
 muUmAXMDNq1t61UekRGqmWwWEgZp9DdjcwBm/v9dRMK2z0ksyJYYhrFC7XUBmm6XVbRptGwp9ZQ Cpx0SvAPk2bRjTg==
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
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/nwfpe/softfloat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/nwfpe/softfloat.c b/arch/arm/nwfpe/softfloat.c
index ffa6b438786b..0635b1eda1d3 100644
--- a/arch/arm/nwfpe/softfloat.c
+++ b/arch/arm/nwfpe/softfloat.c
@@ -603,7 +603,7 @@ static floatx80
     roundBits = zSig0 & roundMask;
     if ( 0x7FFD <= (bits32) ( zExp - 1 ) ) {
         if (    ( 0x7FFE < zExp )
-             || ( ( zExp == 0x7FFE ) && ( zSig0 + roundIncrement < zSig0 ) )
+             || ( ( zExp == 0x7FFE ) && (add_would_overflow(zSig0, roundIncrement)) )
            ) {
             goto overflow;
         }
-- 
2.34.1


