Return-Path: <linux-kernel+bounces-124993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C30891FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36892B2A1AE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D10A1B1968;
	Fri, 29 Mar 2024 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brTWtpQ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89F015217E;
	Fri, 29 Mar 2024 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716582; cv=none; b=T3abqEJjoGmkONQDgLE9emWb3f1ZfL1m6dy1bKQOabDRJct8H/lzr8bqi0jb/vyOssstFfdvUIC10V6wFcvsZoUYgTPpiEuO+4cblBDGrO9m60YiYGyQg1KHpgjvRp/XtkdW43dRyOn0AK1MY5UYsU95O2xXzzFosTMTjd0fB2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716582; c=relaxed/simple;
	bh=ORrkXhOEFKtoASG7lh/cLzIJoH6liO4TrWq0yY57hWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSeb6Ollq2I5XBj/3z2x64yH6tsKosFdYHCqhGHJAUYhrFvJMXwIZVNXjZ/nuIEhp77OejdTKZNCkA9a6WBax7f02Nt2nhIi7Gxkgex0quC9E3ZRBy6JcqGJdVXcER1Imz9kjhTbjNHxWdkHgacb+mKG3UOwdeVT0vH4dvx6GKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brTWtpQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F046C43399;
	Fri, 29 Mar 2024 12:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716582;
	bh=ORrkXhOEFKtoASG7lh/cLzIJoH6liO4TrWq0yY57hWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brTWtpQ6FwnccTAwgOSairdaB/yXBHG5QfvusuGjjBXGtLVKnD1ym9csrbS6cjxR9
	 4Klpr8lVeQ/Pl0jASMG3/TjJKlWKtEQjhhgwWdPMx0J5UJkvKiaqUMPQqLdOOyt9lm
	 tg7w+qSGiugweDWNvTgo7PE5TUtoSnOUUyKSEc3W+U/QFn6TWATfmHJit9WPEzCQen
	 d70eJo07LrrG5hbEQM2BsnLJaYuk7OJCEGhsBsL3ins86JqfDzjx6yXaDXevIR2Y+Q
	 NwQnKV0rY/QYm/wJ+m3zqu7UjFrgAEC/AO62akI5M1kWkcShRPcyhaA1Ku1O8bvGiT
	 zGs4N9dlK/Fdg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <n.schier@avm.de>,
	linux-sh@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 22/31] sh: Fix build with CONFIG_UBSAN=y
Date: Fri, 29 Mar 2024 08:48:39 -0400
Message-ID: <20240329124903.3093161-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit e36b70fb8c707a0688960184380bc151390d671b ]

The early boot stub for sh had UBSan instrumentation present where it is
not supported. Disable it for this part of the build.

  sh4-linux-ld: arch/sh/boot/compressed/misc.o: in function `zlib_inflate_table':
  misc.c:(.text+0x670): undefined reference to `__ubsan_handle_shift_out_of_bounds'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401310416.s8HLiLnC-lkp@intel.com/
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <n.schier@avm.de>
Cc:  <linux-sh@vger.kernel.org>
Link: https://lore.kernel.org/r/20240130232717.work.088-kees@kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index 589d2d8a573db..edc9dc36115dc 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -13,6 +13,7 @@ targets		:= vmlinux vmlinux.bin vmlinux.bin.gz \
 OBJECTS = $(obj)/head_32.o $(obj)/misc.o $(obj)/cache.o
 
 GCOV_PROFILE := n
+UBSAN_SANITIZE := n
 
 #
 # IMAGE_OFFSET is the load offset of the compression loader
-- 
2.43.0


