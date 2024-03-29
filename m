Return-Path: <linux-kernel+bounces-124592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F738891A53
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFB5DB2415B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988EC158200;
	Fri, 29 Mar 2024 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRq0XMbx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B00157E69;
	Fri, 29 Mar 2024 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715482; cv=none; b=lKONmgbAy9Epb78sG9LUrOFnUXnbdXf4D9d/9kfQiICNiDghXiCYcxnrLom2tgIqhZr+2PAK7SODdgkCPPeoJVQp6iUqkU8nyTe4p2CJ17AMpzk771HuE31ATTv18aEjB9s/ec/ll2BFfmu8mzmGXerdfC64XEx5vLloVnU0YU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715482; c=relaxed/simple;
	bh=/+N/yT27Ws0m/5w/1cIOi4gBNiyyDit7r4do8MHX5j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/ve+BeQTbSBlNxUf37I/p3xZGN/OBNtTxHZbI6Psyyfus5ZPUp6X4JQO85n2uTPUeA3APEZYPhw26zQXRMPop8OXKqIAdhs0Yl5Rf/PqU6l64Ka64EwIj8BZvKdL7S8YeoqWxaQiY4Ta3lgfK+OD3f/3vs+NI0qXsAELIrZLUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRq0XMbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2ECC43390;
	Fri, 29 Mar 2024 12:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715482;
	bh=/+N/yT27Ws0m/5w/1cIOi4gBNiyyDit7r4do8MHX5j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oRq0XMbxeacfQ7Qxt2nuC9NbeqUEtOfJJgeb+80qYHOudLXyVPQTEeyog2wO66CuN
	 gCtPwPtsHETanlR9BmDXq79QYpCQhit5mB4C+WJAfMguDdc6XBEnfoqltOC0UhH+SA
	 Lkvpf/Oju3fpsfzbvNYRQ1jxAYY0Ic9l7Q0+MINT92cyUY5ucHW0SZ49WtweEJcDA/
	 +ni+hK6ppzHGaeM3h18b7qv7ZnqCk7LPpVQsrhV5jW4Hs0yk7EeIuVXTMys5xBcV76
	 WW0yKZblIvooNaVpxY+yP2X9tVDg8T13XWF6cqeAGyAmQ1G7tAT8JgFFD19UfG/Z83
	 4Le56YhMapeOQ==
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
Subject: [PATCH AUTOSEL 6.6 41/52] sh: Fix build with CONFIG_UBSAN=y
Date: Fri, 29 Mar 2024 08:29:11 -0400
Message-ID: <20240329122956.3083859-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index b5e29f99c02c8..6c6c791a1d063 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -12,6 +12,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 \
            vmlinux.bin.lzma vmlinux.bin.xz vmlinux.bin.lzo $(OBJECTS)
 
 GCOV_PROFILE := n
+UBSAN_SANITIZE := n
 
 #
 # IMAGE_OFFSET is the load offset of the compression loader
-- 
2.43.0


