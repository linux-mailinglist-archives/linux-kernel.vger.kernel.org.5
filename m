Return-Path: <linux-kernel+bounces-34508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A679837DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6011F26FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9579A6024D;
	Tue, 23 Jan 2024 00:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CmEqp64l"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD875C91D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970166; cv=none; b=pPUzfqW90fXfNbet9PbMhqiwSGKAM6M0J5nVVcHOQipZ6DBUEPFoqyZOwJlIJpcZcjl0F3AeYqgXyT0LSVXHaVPkjBVnxK+IpPr8Ot0AqtGuUC/jaKIz0YalrMejfeipvXaZ/O8o6VA/21YK76RyoNWfOI+fL1jU02JE2u7p3v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970166; c=relaxed/simple;
	bh=MKnCIiYxMUg6EMcU4GoE7nb0L53EnELIMYzEtk5B3VI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m6PLuMMskEnLH5L18uwAVRBI5EDcBwfJpUDMu/0ta0GnnJjSonosCSIv/mJlYtuLN/uCSH2aTx4gt323kg9GZnvAtW3sO97jDuU/KBshKnFjt/WnnyCfgzjJKHXeL6gV94JI07o14a5T7LCiWLmI7F8O4kyEIH11xKVJc5QkNso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CmEqp64l; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6db599d5cb8so2838871b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970164; x=1706574964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oR81ltEJY1+adfuk1StzztmzyEgwb5jSI4QB5TV+ifU=;
        b=CmEqp64lzaU8ccRUlsbzVUt4PNkbi/BLgNiMcTfa72d+yWt5hBonV3jVtTHuCSvLVI
         0KXZ8nE9/612vqa13GHZw+0HEop5Zg1S/VaX6RMGqLELIN0TLWEmHmMlozM2mqEEFCxr
         sbULU9ipB0Oxz3g7e0w7yjLYkljoqpxJ4A1qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970164; x=1706574964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oR81ltEJY1+adfuk1StzztmzyEgwb5jSI4QB5TV+ifU=;
        b=A/HK1IkjhatKAtCBJ9B8pNUBsc22Ik90C8YgTliH9J8jV2SpOm4ff+q9oYqc5u3P66
         JAta77CvtPPEpBj6f+DeX/D35siTebRWzaWzltrisYI/xjIK+hQT/iGUd+fiXYE8T6+u
         nHyW9QSIGVlbIXRPRGmZqqGpk+UfAsaiTGWKsDmIXfKkkwLNe4/an5WwP//3dqqchKoe
         ZRWpJ1MPDPQzRTR4HCryMfsoqVctfSwmg/If65s0//UqAgWbwACJIJqLuWydvlnoAxWl
         MdrE2VVBq/F9H9FMqJ0Ov2+eg1UqkFHVghi5WVg1GyBxTPDfWTORF5746d2qWZhBwi5M
         Y3Aw==
X-Gm-Message-State: AOJu0YwGmEAndqd/NxkU69UB2sPo4p6ZzOnmGauuwjZ70wnS6cBq/sab
	Y8a6LTFh/DKb0JdqfbBH3QIyzdmiV2tHo6UUSSxN1XVcXXsNtrj+Z5G2wZK+hA==
X-Google-Smtp-Source: AGHT+IETzqCGXqh477w/Vt9X12Qb1US/a7Y7KVrRlOIsy+HxOGDJxNfQvSuTk1cc7EBIelGSQhNLMA==
X-Received: by 2002:a05:6a00:3d08:b0:6db:d3ae:c000 with SMTP id lo8-20020a056a003d0800b006dbd3aec000mr2323879pfb.58.1705970164470;
        Mon, 22 Jan 2024 16:36:04 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fa20-20020a056a002d1400b006dbdfb7624bsm2604635pfb.170.2024.01.22.16.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:35:59 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Song Liu <song@kernel.org>,
	Yihao Han <hanyihao@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"dean.yang_cp" <yangdianqing@yulong.com>,
	Jinchao Wang <wjc@cdjrlc.com>,
	linux-snps-arc@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 31/82] ARC: dw2 unwind: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:27:06 -0800
Message-Id: <20240123002814.1396804-31-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2495; i=keescook@chromium.org;
 h=from:subject; bh=MKnCIiYxMUg6EMcU4GoE7nb0L53EnELIMYzEtk5B3VI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgHizE4jMkQP4lVaRSlAN3nsXgRBmjv5Yv2Y
 jUxJ6mHsSKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBwAKCRCJcvTf3G3A
 JmQYD/98DgXrMI+bVIn8YEHNHDNyYFr5nzpnwmbjD3Sz8E9MWTiYwicpEwQnGO0Q/EEzKTOvBS1
 4Hrkrn3ocbughedFtxfFOlwivI79gd1rpJeBTQfjE6Py7r2/Y+5ESY7vktL0eRN9NBt4TvZl4Ja
 BJEGqffrG4McZdVzS59Cs0V6bCR+ihTOANdUe5VnZxVI3T/yT2UMfU7oWks2nWbulsUBccyMyaA
 cTvuGVwjKhkOZ9GLFj4CSu8RRzdKqCIeV4Eo9xnX02e7J77HX6UA8x3vLGyiWkvjOc7su6kypgd
 HOXyYTssc0iCHLUP8pVZE7n0YY6/clIuUL3Zu9934A8kkqPAaGkWp8JOWXZq1DnWiMrf8Ko6g8A
 w/SqcWooHJjVJiCWn2yrzhLzOYrCvBZ1266Y5Gi4uXt0nnNU4tPTM6HGXBhBzzKuIzRFEuxvwpK
 lzDMBUArU4Wc5iU8hESGejpfFvph+s6wkXFTOr9m0Zmt/3V50IO7OIv4z3iQyKjPExWQN+8ziw7
 xu2jcMJPbiHfLSLeLG7nr8rS6FFeYHwxbtX+hVwlYoY8+FWuoHvVgBtffkKaVAs7jrO4Qc9zOrz
 tLMrL5nM0Nox/WHEyYVc0R9XtIdpSXrz8wODRMyNbYJWdGbjPCsBw7iksSGfPcmy58Ox3u8RP0h BsHK0ekMlxhrX9g==
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

Refactor open-coded pointer wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which
removes the redundant open-coded addition). This paves the way to enabling
the unsigned wrap-around sanitizer[2] in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Song Liu <song@kernel.org>
Cc: Yihao Han <hanyihao@vivo.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "dean.yang_cp" <yangdianqing@yulong.com>
Cc: Jinchao Wang <wjc@cdjrlc.com>
Cc: linux-snps-arc@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arc/kernel/unwind.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
index 9270d0a713c3..8924fa2a8f29 100644
--- a/arch/arc/kernel/unwind.c
+++ b/arch/arc/kernel/unwind.c
@@ -612,6 +612,7 @@ static signed fde_pointer_type(const u32 *cie)
 		const char *aug;
 		const u8 *end = (const u8 *)(cie + 1) + *cie;
 		uleb128_t len;
+		const u8 *sum;
 
 		/* check if augmentation size is first (and thus present) */
 		if (*ptr != 'z')
@@ -630,10 +631,10 @@ static signed fde_pointer_type(const u32 *cie)
 		version <= 1 ? (void) ++ptr : (void)get_uleb128(&ptr, end);
 		len = get_uleb128(&ptr, end);	/* augmentation length */
 
-		if (ptr + len < ptr || ptr + len > end)
+		if (check_add_overflow(ptr, len, &sum) || sum > end)
 			return -1;
 
-		end = ptr + len;
+		end = sum;
 		while (*++aug) {
 			if (ptr >= end)
 				return -1;
-- 
2.34.1


