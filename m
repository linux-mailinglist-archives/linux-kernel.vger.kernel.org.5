Return-Path: <linux-kernel+bounces-34523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9B7837DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27201F29254
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07937161B6F;
	Tue, 23 Jan 2024 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LSpKdMVT"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F011615AB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970183; cv=none; b=H8xXS2qIs6r9C4uQxPZ81Gypjlz5k33I0cpFB83Syc6TnlALXI3oL8jlxqPGP6c3SASl7TpTK/Ge6fxe3qeGfSnsM0VA6BBl7oSeezaQI6VqBTG5QDja09E+w1sMK13rZJ2HHw+FICsRPD5J1UwMbZM/G960gbp6rKBfJpExul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970183; c=relaxed/simple;
	bh=gGIR1+eHbOSAQms308Zk1nT40iClIFMbQz6VhnPDbi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R0x7I36F1RHnMVYheM7msp5O39HGrpzYyhQLjynUkMKBLGVbodNVltCLV2hQ5hFYCuBsmOEwQXpFFD7tPw5ak8Nya/qNfVZxJ3j5hhubPjf3SbnhyV3+sMb7Yd0mSDP7A7CRGGfTNtkyZU6f3WSlpWkL7EabFMiyHmxKuYsRH14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LSpKdMVT; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9344f30caso2312081b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970181; x=1706574981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjTv0JWp2wh4DoATrj62+gp6F7EFeXqYtPy6neelVk8=;
        b=LSpKdMVTgnaJngWZZM9cZACINZhuUWpsBOaJC4R2h/mzYdw2bD/VjReb/rDUXf1i+M
         y5uIk6CUGtLsjZ7/Q69R/859sv11u2pwsQAWM96NYyH2lFyvfG1fpzhn6ah78DR5QKlN
         Q0xy6dDDQ75nHiN1SbySf9Elp6WYAMABNUNjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970181; x=1706574981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjTv0JWp2wh4DoATrj62+gp6F7EFeXqYtPy6neelVk8=;
        b=lSWZ2hS7lDuiiMjQk7YoJNftTdty1BnPsN0/X3Ph2lHkZDCa03L3afaevKJ3WDNY4g
         RCE+zRuSqqyDBUQ73NTN8yp5W1+xmcQmoeLlXr9tWF9GoPFQZty16XNwqhzsXerrDlM4
         +7uHWW+XWzXCb6sBxweKs7pTOqsvm1rmM4RJYO0qWTt3e/QI8ivx2qM0GsvsuzFS+ipC
         xSrbUpjV1BFI9fs3FNSmgjRFDYrfB38Joi7AOChXkJxJ5t1H41INXNbdTT8DYkzYqwy0
         gvHZJgqGxBalTiYevrPH+K4lPhefUkhEkkx3ztWcMZxiYWOhWLzX769kOUuI39ern9Vn
         4PCw==
X-Gm-Message-State: AOJu0YwkwTP7MpGjI8UOR5kjkgSuHI5qiXO05ZownYFP3UJkpFJHZYTN
	6IMQLupsGRJrQtNuZfdKaa7bQlPt65Jr4w8Zyvh1CkvnPoRyvgHHr4h4qBIYvQ==
X-Google-Smtp-Source: AGHT+IEdiv0sQvhk5DF6DmJpOnGI+AupQQxjyZFGDT/RapAwhNquQoSG7WtikHFZHphx3/AnNJEzKg==
X-Received: by 2002:a05:6a00:88a:b0:6d9:c0a4:67eb with SMTP id q10-20020a056a00088a00b006d9c0a467ebmr7154515pfj.35.1705970181078;
        Mon, 22 Jan 2024 16:36:21 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r11-20020a056a00216b00b006dbce4a2136sm4727845pff.142.2024.01.22.16.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:36:17 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
	dingsenjie <dingsenjie@yulong.com>,
	linuxppc-dev@lists.ozlabs.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 60/82] powerpc: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:35 -0800
Message-Id: <20240123002814.1396804-60-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2692; i=keescook@chromium.org;
 h=from:subject; bh=gGIR1+eHbOSAQms308Zk1nT40iClIFMbQz6VhnPDbi8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgKZlRqKBNSnPKaV9Q+qNDqro5fLhpWmnwga
 Q7YzUH80IiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICgAKCRCJcvTf3G3A
 JrbeEACw9Qm/wbTPg4Z6IKIJQxXVouLRzxfnSHgzNiD276XXnPVJrJiBcSCvmSL7fpJ9SDej5TV
 9PYH7UGkT6J3bCE8PLoBp5JqS24+wSC9f6aqnuqpGLfoi5P3MxHPufDB9EbUyasJgVcGybCxci6
 sMhNpj+acmdoPvOc6m5jx5a7RAAA/ym1iJPdj0+2ccaR5cIeImnNF30sRViNQzozLcnn4DA1H8p
 XENTLdbPf/j0h+wTxLu70B2HUAAQUyBzLfpb9waKCwX03HXJ0lwpxUXvZgA99nbb0tmF717h1lV
 mh1AktyNwBxm0tJEUEWQcHUqY2a19p5L9QI5ZPhhISQsaZIBGWdlB6vjLPvnUgSTZ57SpVnQ+8g
 vENCyDxuI3pWKiz9shHbiKHxOL67K4hYdaQNF9iB3J7KpvCE6JfKuIeBURpd1JrU9S+z3MGRo8V
 Hkk6J4qgEhi5rzMO9I2yhzZGMl2+5U1RhdSdwRY0ol+lsIsKnCKDNTXAbw07S9zoYa4lmNyPvwM
 HT3G5UCgsab2bqAvSQ9I63Fr+lt7BaHqGREuxYKUun/1NWDIQhhH1CFpy8K2kKFqJjqxWDH6wj5
 Yzpr1wcFOCzLytejNRGkB2uIRgzQqhzzbhg+XbUgDUjc/mkGvnLvsVMVLP96m+FIehjUX0J6mJU BDk7KOdYQY3UuXQ==
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
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Cc: dingsenjie <dingsenjie@yulong.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/platforms/powernv/opal-prd.c | 2 +-
 arch/powerpc/xmon/xmon.c                  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-prd.c b/arch/powerpc/platforms/powernv/opal-prd.c
index b66b06efcef1..eaf95dc82925 100644
--- a/arch/powerpc/platforms/powernv/opal-prd.c
+++ b/arch/powerpc/platforms/powernv/opal-prd.c
@@ -51,7 +51,7 @@ static bool opal_prd_range_is_valid(uint64_t addr, uint64_t size)
 	struct device_node *parent, *node;
 	bool found;
 
-	if (addr + size < addr)
+	if (add_would_overflow(addr, size))
 		return false;
 
 	parent = of_find_node_by_path("/reserved-memory");
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index b3b94cd37713..b91fdda49434 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3252,7 +3252,7 @@ memzcan(void)
 		} else if (!ok && ook)
 			printf("%.8lx\n", a - mskip);
 		ook = ok;
-		if (a + mskip < a)
+		if (add_would_overflow(a, mskip))
 			break;
 	}
 	if (ook)
-- 
2.34.1


