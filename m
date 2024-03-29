Return-Path: <linux-kernel+bounces-124919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAAE891F99
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8ECB2E8BE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361C14C593;
	Fri, 29 Mar 2024 12:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQzTxuqW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635B936ACD0;
	Fri, 29 Mar 2024 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716431; cv=none; b=R8OkdB3gVCntiqUwTYYj+no5DqL1ZHcOx1Yb4nmitKgFtp9YFZqQ3bbVD6zIGT5t9bZV+P3V3zQt8F9pAohyOFSN1HfDfOHQk0KSn4rQBCpa2rwG2+5mgi0trhY94oLYX4dbBtxqeJcXXJcF4SLeJ/9dXghvnA2DUm5zI2h0XHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716431; c=relaxed/simple;
	bh=sQkVl30sdVY6EK+DB5C9ADEQCWIPNWJaMiTM9v1dMv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnzL3fX4kVxrDIAp2lKeYSA0ZihRWj775+uK/Shhm+1g6j100F6gX8M8uTYXzMEqw/xEwzKta+3AQeTDwvQJXiyQvZX4P361bMu3Q8adyYIsmnk+DLTddmJMb3DROvPmJPFu89BsO1QBRVdmNdIfytecM7h47HmNzn4jKGhqRuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQzTxuqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE14EC43399;
	Fri, 29 Mar 2024 12:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716431;
	bh=sQkVl30sdVY6EK+DB5C9ADEQCWIPNWJaMiTM9v1dMv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQzTxuqW2N5P0I4rNJbLK+/QkWa3r31Udp2bdLCC8TmU16OF78vzayxN1IrQdm0MQ
	 VzsAveq4V+QU8mfi2Zmr+32g9Gc8dy0G4/ja6jQIWXaldr+1dG07VDMfTohbVX6DYT
	 Z+F5X3KILS8hSc0VFY68Kirk91OU2cw6ID/tmpApRugwZDJKYXzqAn3LATJcO9/48L
	 vBTDf+g+ifSUjMcA6YbUC4WtepdbUkIEKh5ojA1hGiXVewy+edxbf6DxZIkXqawpcG
	 8cQTXbmOgsdqlgcRyh882rNufgy3TrJkIiJyDN4NJrlxadWTR4STPSH1LaZc8KurOd
	 OSwwBi21wB2Ww==
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
Subject: [PATCH AUTOSEL 6.1 35/52] sh: Fix build with CONFIG_UBSAN=y
Date: Fri, 29 Mar 2024 08:45:29 -0400
Message-ID: <20240329124605.3091273-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 591125c42d49d..ec3e78c5bff1e 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -19,6 +19,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 \
            vmlinux.bin.lzma vmlinux.bin.xz vmlinux.bin.lzo $(OBJECTS)
 
 GCOV_PROFILE := n
+UBSAN_SANITIZE := n
 
 #
 # IMAGE_OFFSET is the load offset of the compression loader
-- 
2.43.0


