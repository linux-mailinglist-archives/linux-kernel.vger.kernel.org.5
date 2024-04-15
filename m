Return-Path: <linux-kernel+bounces-145711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005738A59E9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B961F2268F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EBB13AA32;
	Mon, 15 Apr 2024 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PwFqBZ/6"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CA713A885
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205720; cv=none; b=JbEe8ygECZUJMLo7Zti1BD49yoEzCd6BF56+tWHUMlGMFwy+izEuRyPLolY6NWTRK0jp/uEPiT0KoJkHqTiToxEsmQA5UwcUE+W5/6o4n+wl0pabX+Vfzm//7b9SMYoqv/V7D0dhVz1Qd7JRD9P1wK6AfcHh84GSmDWf5CosFA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205720; c=relaxed/simple;
	bh=4IaXarYUXpxYCg+9pmqyG/50QxJWM9J7LtrSTXLIMJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eZDWr7LbXkzL2lhxnVqy4Nn+CW18YC2eraRucouJsfFFDlObQ/NoNZ+eBvAIWbUNU4unNlyBT8VChqVVC8AH1hz8HEZ93MtwplUILM6WjAQA8eatmvDctS3X+3vE7+bgBy+Uk0GguIdBVKH6keFlm2GgQlRrP1zR8mLhm6d5ps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PwFqBZ/6; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2945955a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713205718; x=1713810518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yAq4RH8QyUKSZD7HeQ0W2c2SC+MgWA2yhvwhd1FAErE=;
        b=PwFqBZ/6a6Q3QXMzqCM42I38gX6xtUSXs+aFtkvTIuajQXALCqFMyn6jq392fgC7eO
         hzf+LizncwHDt17B574GGbWgAiSPar2lHu1Ldi4m7TEnY99m2r/3CSTA6cCGhV3WrYjZ
         4FzMR9o5ZCCc6FydJbgh3SYUEALYQq2jS+vPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205718; x=1713810518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAq4RH8QyUKSZD7HeQ0W2c2SC+MgWA2yhvwhd1FAErE=;
        b=AyL7E6Pfl9wb7L971lNqTL7GVTCl+makdYgBmUgvLdy1cN4pLMK1iGhGTjsCOwZOPp
         y1pWaOX0Vy1OFR1dxbYCVA1AnDlRmNU0mbWORNY/1PpAmL9L898o6yGJi9aS0joIcseM
         UaQ8EYBSN5Okj6ydvN9qYSdziaS12H/kRJlpVNeSqc6lCGmO00Whgs+wP4RsEmDoZasC
         oltp3XlUjIByDFmixoJOwF/vdbDYWbwXiGH4HzAMkP59JtS1GEc87H++UgeAJdL/cBFF
         zHH2300yhWMqjRA32i1imEDyyfJabITm686lhp1BhEmjCJ0H4GRTTfGwayNO7s8QqVnn
         XGFw==
X-Forwarded-Encrypted: i=1; AJvYcCUOcp1qD9bH2znlXTaRHnlBVnLZMbD5Djz5T6D5Gl7QG0UvESa0XXBvW+uTkHPfoW1n0ulcpMtEtmLntA/rXU07sWsooZacrYFUARFy
X-Gm-Message-State: AOJu0YwuQdeaIU1YPADELo/6xvRSitxk+YhezJAwQes4H+u2xVo42W5X
	TtuOt8QdH0aD6jqhhRIjcT3i6diHFD9kD0lkl7DQi0M+4/lVYpl7i6juGunlXw==
X-Google-Smtp-Source: AGHT+IEYFs7fnXkSELd0hZrVih1BisoxrSCEEdxjz9aIBiqqyuW6IhT9v58YdP08kVYsR/hIWnkrIQ==
X-Received: by 2002:a17:90a:a014:b0:2a2:37ed:24d5 with SMTP id q20-20020a17090aa01400b002a237ed24d5mr9504791pjp.2.1713205717610;
        Mon, 15 Apr 2024 11:28:37 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090a3d4700b002aa783c7749sm225542pjf.41.2024.04.15.11.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 11:28:37 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] ubsan: Add awareness of signed integer overflow traps
Date: Mon, 15 Apr 2024 11:28:35 -0700
Message-Id: <20240415182832.work.932-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2297; i=keescook@chromium.org;
 h=from:subject:message-id; bh=4IaXarYUXpxYCg+9pmqyG/50QxJWM9J7LtrSTXLIMJA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmHXHTHDcH/rU4DwAuIfF+PqCgsKiEy9TvwjM08
 XaKWEaXez6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZh1x0wAKCRCJcvTf3G3A
 Jl3xD/45m2S6t9LECpdwfjbODqtOouLN0wH8zb51Op56fbm9xeMQ7e80mdvP9yjErlwPLyih6Nq
 WfX0zqyYp/Gw0CjTr1zZjJogFYt4k333uYlpI6JCqDJhZllXGNRInNm/dGGBADxaV7X0Mco9ATn
 u1gG/Q44QaBb2Knh1jm/NJ0fp1SdQe5NlYnx7lGJ4CpDwrugHDoxhJSEMyuW4IVcfMEENgEm3dy
 VvCXyvJlBwu7CbYMiP7RQP/n8libLaaZGbEbuf1NvtUdTBh5VSe+ZHyijtjWHzd/6idddE9Lhze
 Eu3oEPod5bbwDi/hBLQGpUNs2hdz2cryApPLcojSwYjOFxey2dzxr7bXv3SPXhXwQikMYB8nIKt
 DhLJgg9T+HsQyPnWVR9a3eTKSvJHKlzrGEaGGLiruPfM2CTPaWNnjpjSCw3xLVS/OprkO8xYwCY
 +JDjW4Yz4coVscDJMVx8JtEpxa3a3XefNYfvSlSBLpe0VUkkuO77Des8sdKZ5H2kVBr1YC7RVsu
 7zd6Lwv25OlcbntxMxul7cqG8NL8jo1CYaIIly768LWa0eDPEWB5VWTbErLWxYnZ65TmBzCUdvL
 YTAAneczLiTe+5u0Ga/AQUDykSyQPvWgaEpnR3boeAtTqqqgyFPlxN33mThPUwoh6qMbGBa8XEk
 E/kf3ER sCidHZYA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

On arm64, UBSAN traps can be decoded from the trap instruction. Add the
add, sub, and mul overflow trap codes now that CONFIG_UBSAN_SIGNED_WRAP
exists. Seen under clang 19:

  Internal error: UBSAN: unrecognized failure code: 00000000f2005515 [#1] PREEMPT SMP

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/lkml/20240411-fix-ubsan-in-hardening-config-v1-0-e0177c80ffaa@kernel.org
Fixes: 557f8c582a9b ("ubsan: Reintroduce signed overflow sanitizer")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Marco Elver <elver@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: kasan-dev@googlegroups.com
Cc: linux-hardening@vger.kernel.org
---
 lib/ubsan.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index 5fc107f61934..ad32beb8c058 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -44,9 +44,10 @@ const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
 	case ubsan_shift_out_of_bounds:
 		return "UBSAN: shift out of bounds";
 #endif
-#ifdef CONFIG_UBSAN_DIV_ZERO
+#if defined(CONFIG_UBSAN_DIV_ZERO) || defined(CONFIG_UBSAN_SIGNED_INTEGER_WRAP)
 	/*
-	 * SanitizerKind::IntegerDivideByZero emits
+	 * SanitizerKind::IntegerDivideByZero and
+	 * SanitizerKind::SignedIntegerOverflow emit
 	 * SanitizerHandler::DivremOverflow.
 	 */
 	case ubsan_divrem_overflow:
@@ -77,6 +78,19 @@ const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
 		return "UBSAN: alignment assumption";
 	case ubsan_type_mismatch:
 		return "UBSAN: type mismatch";
+#endif
+#ifdef CONFIG_UBSAN_SIGNED_INTEGER_WRAP
+	/*
+	 * SanitizerKind::SignedIntegerOverflow emits
+	 * SanitizerHandler::AddOverflow, SanitizerHandler::SubOverflow,
+	 * or SanitizerHandler::MulOverflow.
+	 */
+	case ubsan_add_overflow:
+		return "UBSAN: integer addition overflow";
+	case ubsan_sub_overflow:
+		return "UBSAN: integer subtraction overflow";
+	case ubsan_mul_overflow:
+		return "UBSAN: integer multiplication overflow";
 #endif
 	default:
 		return "UBSAN: unrecognized failure code";
-- 
2.34.1


