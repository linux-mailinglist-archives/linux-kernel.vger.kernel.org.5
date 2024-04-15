Return-Path: <linux-kernel+bounces-145055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EE48A4EDA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BE11F22E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377746DCF5;
	Mon, 15 Apr 2024 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSrP0dWT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799A16D1B5;
	Mon, 15 Apr 2024 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183648; cv=none; b=U98HmTXd72ftqLnemWmStu+D6GsnXoKgED/MvbYiqRs1dFkEthm9TH4e9DjwZhIa/1U0urojYNGetufgY8CIsJ1ONC2JxS7DqmN36yhzgQwqPgzPrGxmd4bhfSp+M/Xpb471A9duaOPLrzXXH4WaU5Xu/y6OmvofVQQBg1j8NrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183648; c=relaxed/simple;
	bh=9rWj91Ui3yXdrYdI/xJnn3eqhuI+T44/0BgWu41vBio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mjjR0whXUB7c3Kru21/N4HPBDOh4T//jYlu8zQt8GM+x3uv9WeWAVKEd6pklE+RCIYTPO9GpjEoVHR0eS5XHwG3x/OG7ShNi5GTyd4YtDUKeJnmmTzVGYvmRj0mMuOo6hOfLraQ1vxtg9N77rKnEn/1c3p0P043mwMgSR+1NghI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSrP0dWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CCFC4AF07;
	Mon, 15 Apr 2024 12:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713183648;
	bh=9rWj91Ui3yXdrYdI/xJnn3eqhuI+T44/0BgWu41vBio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSrP0dWTMu2/IdKx7qvepoKhAnZ7EOl7KGN9Nh/Hq9qybD2qbUBwiDqqbEiLlvdJH
	 bBzACt7BoWDybOEUMOq4C3MJcjoCuhq5567XE1yXGNv1DkpBds7ZzvAnwaHzrFjXeH
	 /9CA62207RipTTXueygEh1xelWDTACJah/x/3AbQ6R8xFAZ4OLJK/EI94lW0VP0Rz6
	 NJrXuFN6CYP1YHqq9NbxyrlAKoJaA0gPVKh/xod14ayxUkh0YdqhVQ5gpx9YOMcLse
	 jd0WyIBPS8hpm1bPZqPHLKyMH7Q13Avdjn3f8aGR8urL4iOIkfyRCqZvN6iFQT99CN
	 g5bh1Nfz7PRWg==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Kees Cook <keescook@chromium.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] [v3] kbuild: turn on -Wextra by default
Date: Mon, 15 Apr 2024 14:20:32 +0200
Message-Id: <20240415122037.1983124-2-arnd@kernel.org>
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

The -Wextra option controls a number of different warnings that differ
slightly by compiler version. Some are useful in general, others are
better left at W=1 or higher. Based on earlier work, the ones that
should be disabled by default are left for the higher warning levels
already, and a lot of the useful ones have no remaining output when
enabled.

Move the -Wextra option up into the set of default-enabled warnings
and just rely on the individual ones getting disabled as needed.

The -Wunused warning was always grouped with this, so turn it on
by default as well, except for the -Wunused-parameter warning that
really has no value at all for the kernel since many interfaces
have intentionally unused arguments.

Acked-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index c5af566e911a..c247552c192c 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -82,12 +82,14 @@ KBUILD_CFLAGS += $(call cc-option,-Werror=designated-init)
 # Warn if there is an enum types mismatch
 KBUILD_CFLAGS += $(call cc-option,-Wenum-conversion)
 
+KBUILD_CFLAGS += -Wextra
+KBUILD_CFLAGS += -Wunused
+
 #
 # W=1 - warnings which may be relevant and do not occur too often
 #
 ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
 
-KBUILD_CFLAGS += -Wextra -Wunused -Wno-unused-parameter
 KBUILD_CFLAGS += $(call cc-option, -Wrestrict)
 KBUILD_CFLAGS += -Wmissing-format-attribute
 KBUILD_CFLAGS += -Wold-style-definition
@@ -190,6 +192,7 @@ else
 
 # The following turn off the warnings enabled by -Wextra
 KBUILD_CFLAGS += -Wno-sign-compare
+KBUILD_CFLAGS += -Wno-unused-parameter
 
 endif
 
-- 
2.39.2


