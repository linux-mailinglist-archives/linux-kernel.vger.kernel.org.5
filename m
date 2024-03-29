Return-Path: <linux-kernel+bounces-124701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD8B891B91
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970512930B3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671DA175CA5;
	Fri, 29 Mar 2024 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkhOdnye"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A9F14386C;
	Fri, 29 Mar 2024 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715736; cv=none; b=b/jQUpxaju5azwbhbqaK4g9xVIbBEexEEkqXbPPTrVjrxHg9iSfP5j3cfCfulX9UaAN2zNc8TJMbN/eC6C4p2IFAB05N/IK7Atd5QPqsoEgf9ITGbE+XbQUMa6JHk3GdjCmLYKZXrtab5Zxjc6dOwe95ZdxrYDdqv8DnQgO5mwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715736; c=relaxed/simple;
	bh=BwONR/zqN+f1kbGae3Kf+DFaoALpqNV58n1AullloRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oj0Op0w5DVj0hbkEQ3RVOXwAb6UCLeMKCsXreQsDdRib3W24QjiNCsIw2aI4AapefmFFVOLb5Bqm/ih2YQNf5IqIN8E2ZZffh5pzNEu++SRHvo4BGLryDU9oOIOIsHeiAn87n4RJjYVJcAn1Hh11E6YUXO0cN9bXe1E99gBxY6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkhOdnye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21030C43390;
	Fri, 29 Mar 2024 12:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715736;
	bh=BwONR/zqN+f1kbGae3Kf+DFaoALpqNV58n1AullloRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QkhOdnyeQqjRUZDer8umprdl0sfQOhXmqXB4WjwkWaC5KE/Q1CLr6VEgWA9ADpZdv
	 c72N4RY+5T9+fLa9oxY5GS3IbHvElnFGP1QrQWN4tN42BxrivH0n6nIdYSiVWMAU5j
	 4PRoAt90U8QCBgLb/mLiAHcYGN3oqvkSOJ+S/HtolsmMyoY8vDKC9hJ33OyQYZBMcV
	 xR49uGIb/r8LK3wEvYmfnLH7yxQlyanD4FqVtvOH+PUDk31FJpMUVGuJEDsssurzdT
	 lB1TW83Xar1OP1Yn+yud9TDr6mrjUZfS6AHEdtQCER/Hc/z6bslxxeDyeHyKJfVUTo
	 xpM7HvGyvNiGQ==
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
Subject: [PATCH AUTOSEL 4.19 07/11] sh: Fix build with CONFIG_UBSAN=y
Date: Fri, 29 Mar 2024 08:35:13 -0400
Message-ID: <20240329123522.3086878-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123522.3086878-1-sashal@kernel.org>
References: <20240329123522.3086878-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
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


