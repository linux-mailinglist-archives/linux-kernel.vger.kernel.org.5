Return-Path: <linux-kernel+bounces-124690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323C5891B70
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB9F1F2C8FA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD598173D95;
	Fri, 29 Mar 2024 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF9khGBO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D73173D81;
	Fri, 29 Mar 2024 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715710; cv=none; b=PkevIAsAPliVQmukltn9A9PO8upYah1Rnn6lkHbAMwze1IKZKNF7pDEQZ2p/0Ws0hU/sMMTwLxvm7ORqaBIwwj64aDAo7duiUpok82bNfsm5HNI6ef/B9WPEBEvlHJv59LC2JbZhlbJZfJc+RKRKsBPqoP8R8J8lvCzuK4IT1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715710; c=relaxed/simple;
	bh=BwONR/zqN+f1kbGae3Kf+DFaoALpqNV58n1AullloRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRjIaV1XtJB2tEyZwIAgXAnmj31hMcZLeeeyRg61D3cCfobm1TqmQlS7K6PQBKX80WPDnmxyIIAnYpCNuWPmAxWqZlV4Tdml/BWHpFU33QA0TIh3rIabvttvr3uI5mgXtZ4IWchKeMFdPaTCh+p2DxGn8aJ14jf8Y9YTls18gYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF9khGBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9860DC433C7;
	Fri, 29 Mar 2024 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715709;
	bh=BwONR/zqN+f1kbGae3Kf+DFaoALpqNV58n1AullloRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XF9khGBO3mvBZOnEbYDLV2CCZAN+1Ve2o9kZHRn9/ZGSsF5FraqGjZyLwIcb0t0wn
	 UpAKkcve8ucVpx1SDYdrJgUFvlGNK9WqhELA7trYSkVwMu+d27zsnfIMMEqw10rVui
	 9HHxH3V6m2NnmW0VbLXjdtDy0TWnKiEylFNxCASv8EKmGKPvFN5pDkjU1YyqJ0OjKe
	 9dqvAi3tGg6yGnyeS/MzuyJtqQouw4apamZCW+tAdOQ6Wvwwsz91OcbY+KwsL8/YBh
	 OV2xC+i8yXJ1HPrir/K7dHYNLNf2ZviEToZAuBePPbV7St3Df1k+9VihNclxDiIjMn
	 FpVQyZVBeKUlA==
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
Subject: [PATCH AUTOSEL 5.4 11/15] sh: Fix build with CONFIG_UBSAN=y
Date: Fri, 29 Mar 2024 08:34:34 -0400
Message-ID: <20240329123445.3086536-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123445.3086536-1-sashal@kernel.org>
References: <20240329123445.3086536-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index f5e1bd7797892..362f2c9f9f7fc 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -13,6 +13,7 @@ targets		:= vmlinux vmlinux.bin vmlinux.bin.gz \
 OBJECTS = $(obj)/head_$(BITS).o $(obj)/misc.o $(obj)/cache.o
 
 GCOV_PROFILE := n
+UBSAN_SANITIZE := n
 
 #
 # IMAGE_OFFSET is the load offset of the compression loader
-- 
2.43.0


