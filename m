Return-Path: <linux-kernel+bounces-145056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8208A4EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D94282D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAD06CDB3;
	Mon, 15 Apr 2024 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7rNnt4o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CE06E612;
	Mon, 15 Apr 2024 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183650; cv=none; b=Rd90qPFKs6vVZjARAMuVJGcuVabmT8b0yDixAcxWBuEjO6Fp/GgqN9/bWJMoNWUEQry9QVVdLb16kCyZYRYCfIZ7gKWKQaKzLnbDyeL96DbP1M4/oPRvsmEbXk7tmQFQ1QWJSPrJkGVOKGvDyGaFuVIwCEVODZLaY0OyzcNS1SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183650; c=relaxed/simple;
	bh=eLuBpJKWhyM4IlNLRbcijbvdvKbw+xEyERqd1eOHI0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q8z4nhaLle4Lw1kp7S2Uj9Ev0XRgM25/+rEPlZn6PYHTJQYbIcZQ4FyPZfLxB3aP6iPJAyaYedmmW6m4Umt5NXuBRzmJpPELzAtF0SfdaRToeVJDtC1vFoGGny/Z7bWYDDiRFLhEZOD/ghIXCk4Z7re2ECduk/wLJ6ZV1ArYnxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7rNnt4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE58C3277B;
	Mon, 15 Apr 2024 12:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713183650;
	bh=eLuBpJKWhyM4IlNLRbcijbvdvKbw+xEyERqd1eOHI0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7rNnt4oi5SBsEAOZbb234zsfmvss2yhv/ZCiVHEtRa9wACjgvLvKMPzMtU4nJnNu
	 7cKfrxmtQsJElyGYLFiDLW7az7bN/RvFHKatGpIuVAUwxRqDWdE0pgABqXJaASheUP
	 gMK3fRjJa+bk7tAgcyFlET1CVhEs3g4WjDEwEEBzo+Y/Q5yxi5p6xQC1U3/zsDpRWf
	 4UP/G6GUgPaH9J+kOCW8W9uyFrGJ9qluidrPUUjtYatSm/s2XbfZHUWAUjXO/VYfPr
	 zQUABzblNx0ze2zXNyH3lmMCS1YtB3huNrmDmU1/wilYGg2idfuHSpNT+GWmSHLwdZ
	 cq8sujwxUrcnQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Kees Cook <keescook@chromium.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] [v3] kbuild: remove redundant extra warning flags
Date: Mon, 15 Apr 2024 14:20:33 +0200
Message-Id: <20240415122037.1983124-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240415122037.1983124-1-arnd@kernel.org>
References: <20240415122037.1983124-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

There is no point in turning individual options off and then on again,
or vice versa, as the last one always wins. Now that -Wextra always
gets passed first, remove all the redundant lines about warnings
that are implied by either -Wall or -Wextra, and keep only the last
one that disables it in some configurations.

This should not have any effect but keep the Makefile more readable
and the command line shorter.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index c247552c192c..8b3f5b62b837 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -37,11 +37,6 @@ else
 KBUILD_CFLAGS += -Wno-main
 endif
 
-# These warnings generated too much noise in a regular build.
-# Use make W=1 to enable them (see scripts/Makefile.extrawarn)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
-
 # These result in bogus false positives
 KBUILD_CFLAGS += $(call cc-disable-warning, dangling-pointer)
 
@@ -90,16 +85,9 @@ KBUILD_CFLAGS += -Wunused
 #
 ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
 
-KBUILD_CFLAGS += $(call cc-option, -Wrestrict)
 KBUILD_CFLAGS += -Wmissing-format-attribute
-KBUILD_CFLAGS += -Wold-style-definition
 KBUILD_CFLAGS += -Wmissing-include-dirs
-KBUILD_CFLAGS += $(call cc-option, -Wunused-but-set-variable)
 KBUILD_CFLAGS += $(call cc-option, -Wunused-const-variable)
-KBUILD_CFLAGS += $(call cc-option, -Wpacked-not-aligned)
-KBUILD_CFLAGS += $(call cc-option, -Wformat-overflow)
-KBUILD_CFLAGS += $(call cc-option, -Wformat-truncation)
-KBUILD_CFLAGS += $(call cc-option, -Wstringop-truncation)
 
 KBUILD_CPPFLAGS += -Wundef
 KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN1
@@ -150,9 +138,6 @@ ifneq ($(findstring 2, $(KBUILD_EXTRA_WARN)),)
 KBUILD_CFLAGS += -Wdisabled-optimization
 KBUILD_CFLAGS += -Wshadow
 KBUILD_CFLAGS += $(call cc-option, -Wlogical-op)
-KBUILD_CFLAGS += -Wmissing-field-initializers
-KBUILD_CFLAGS += -Wtype-limits
-KBUILD_CFLAGS += $(call cc-option, -Wmaybe-uninitialized)
 KBUILD_CFLAGS += $(call cc-option, -Wunused-macros)
 
 KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN2
-- 
2.39.2


