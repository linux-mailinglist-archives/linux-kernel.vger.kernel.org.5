Return-Path: <linux-kernel+bounces-77843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29210860AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7671F251B9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E863312E45;
	Fri, 23 Feb 2024 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eV3OchLK"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B785C12B8F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670436; cv=none; b=OiOF4vhxUWpqv6b3q8XL8+LEp/sfHOfLazQH3WjfkRfiM7+3YO1XftkkIBwtl6MDRJJaTfVThwgkR4qd0Px66KXn65z/7yhG6ey2ykj4Er2WH3WutjvhFgCcRTz60PtRDpQ3eYgOYTUO9RPmlTXxm0qGbOy/zRWhotEh5XT1Z7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670436; c=relaxed/simple;
	bh=Jyw2KgNMUcRwAe/3vjo2g69lJx3RZu+Q5aJy6+FMHow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lctlHG87eSdU1TuIndQkVjy9lI73XvP6m1bn4/QwT7p3XfKJsc842Y0TQplev3JSkvU8KYW5NtE+00hSsudnWUUFdTdAU72MsrrqA1ThHFxkAD7yurT6Bca8HhXQ0JLTt+nek8+586v1w4YfRkWcqS977HKae2bvY+9uJhZdDg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eV3OchLK; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso491523b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708670434; x=1709275234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VlAxTgaIbiVQpF/ZQwxp07S3UGXkKE5YGd7hWgHUVZY=;
        b=eV3OchLKQ+IJMkX7dilqyGYCScwsDzzATI15T2ioXpCYg7sE7CJ3DvJ5Tw4ScpHbPI
         VXcb/cNPMWAMwWkL1VeT6gj9CERkmGGJ4LrDbcjNQUlWAhOsnb3NHYGDn2+YqYDH6wdS
         WxbvYEkNQeuPMMWxzWwFix74opGCymt2Khveo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708670434; x=1709275234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlAxTgaIbiVQpF/ZQwxp07S3UGXkKE5YGd7hWgHUVZY=;
        b=e9GJiyU9otjZHyA1QQgkBWf6VRl2Tw1yeKwEPTsmnXKE7rpxq4gBdMwAVl6RaOye3c
         GFKX1ZXLBoTuKsgbNiehDfN9dCnRt8zNSNFykWYvK4ii2YWbaLgRxapwQ6x0VsX8CvBJ
         YFmQNW22jIghGSPBYxkHyi2b9JriSm0k6vsjLLzaacL9R8nvg+5NjE1hsOQEPJr/0zMC
         Mp5/Zq49O/bE+/6Pa1UXql8/wXmGDz/sl1Qgus0wTYhtjA8kAevPzHU9KD2vw+52n+Oe
         pMWhtffm+JV+muNVGxlIRMkMwMlmCMuv9LB2obrAlN0r2vWXdwZigZFues3j305WL7M+
         1jkA==
X-Gm-Message-State: AOJu0YzPgSsiPNpoKtumQsVCsEFQaSD9vdRmZ8RWnSuJSXAqd0L0mGKM
	mFKPuHVojX75egZxAyH4VIbNvdqiLRExhkA99deJUsviNUluL1v/lJATWQeZDQ==
X-Google-Smtp-Source: AGHT+IH4UFzwgV0g9dgBCvcLiwOp8510IaCSr0SQ/rg50PPnqosFI2z6O/vgddexixApZQrnaAjOmw==
X-Received: by 2002:a05:6a00:4307:b0:6e4:5ff9:f037 with SMTP id cb7-20020a056a00430700b006e45ff9f037mr2262350pfb.12.1708670434104;
        Thu, 22 Feb 2024 22:40:34 -0800 (PST)
Received: from localhost (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with UTF8SMTPSA id fm18-20020a056a002f9200b006e484e13454sm5653680pfb.32.2024.02.22.22.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 22:40:33 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Jason Ling <jasonling@chromium.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev
Subject: [PATCH] arm64: ftrace: Don't forbid CALL_OPS+CC_OPTIMIZE_FOR_SIZE with Clang
Date: Thu, 22 Feb 2024 22:40:29 -0800
Message-ID: <20240223064032.3463229-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per commit b3f11af9b2ce ("arm64: ftrace: forbid CALL_OPS with
CC_OPTIMIZE_FOR_SIZE"), GCC is silently ignoring `-falign-functions=N`
when passed `-Os`, causing functions to be improperly aligned. This
doesn't seem to be a problem with Clang though, where enabling CALL_OPS
with CC_OPTIMIZE_FOR_SIZE doesn't spit out any warnings at boot about
misaligned patch-sites. Only forbid CALL_OPS if GCC is used and we're
optimizing for size so that CALL_OPS can be used with clang optimizing
for size.

Cc: Jason Ling <jasonling@chromium.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: <llvm@lists.linux.dev>
Fixes: b3f11af9b2ce ("arm64: ftrace: forbid CALL_OPS with CC_OPTIMIZE_FOR_SIZE")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index aa7c1d435139..6b96d75a3a3d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -198,7 +198,7 @@ config ARM64
 		if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_OPS
 	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
 		if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG && \
-		    !CC_OPTIMIZE_FOR_SIZE)
+		    (CC_IS_CLANG || !CC_OPTIMIZE_FOR_SIZE))
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
 		if DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_SAMPLE_FTRACE_DIRECT

base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
https://chromeos.dev


