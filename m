Return-Path: <linux-kernel+bounces-124626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1C0891AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CC4284D05
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAEC15E5BA;
	Fri, 29 Mar 2024 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjKXchGl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ABE13FD8B;
	Fri, 29 Mar 2024 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715574; cv=none; b=BZbpP7xJkuZJcZ6yvsGoBfVRKXI+7n61twVua8e8D/rvSH0Jr9Rx0LRQZ2sUEPR8FVfG1ThrqJw5OsHMCi6txOZrw2EZ9s1yPnxTh9zhsD6uFlDYTu5l4h0JJJtHVymehRutfEv9peHGoYjECKT8xgu2gKsoTGjeDXAf32XH/LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715574; c=relaxed/simple;
	bh=sQkVl30sdVY6EK+DB5C9ADEQCWIPNWJaMiTM9v1dMv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpNrTlcpPG86RS0cHkxo48bXFZXMeXy4qhTpMrZBqll5DYaZVVlf76B2NjrwhNHOP8uMXArzWqYDiRUVsRpXvXQ8T74YqI8ZyccTY4apTF6NeaEXwlGLyqOTzPdbctWh02v0AaxQIbCpKLfppmeERl0PijGp425+IMCr+9E19OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjKXchGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C68C43390;
	Fri, 29 Mar 2024 12:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715574;
	bh=sQkVl30sdVY6EK+DB5C9ADEQCWIPNWJaMiTM9v1dMv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XjKXchGl++Y4v2I0K/uYpqKySpM4THg5sFqYiQ/EGyfXtfwvMineK5vRdKYilyKC3
	 NyAtIHFOyKeSAIGu+o9gLsy+R4kk0NK5Q2MI1hPj/4QYJ3bVD+eZ8KhUs45X+80Re1
	 11hB8VW7eZFmT0IekqA9BB2dQCTWG4S9kKs3k5NfTLbwqMmiG2LxasXWL7DmEVgY6T
	 SAK+E80VflpvOQu5TZv8x1KTwTFu9j2Bx2EEi/QWHd7/5kNSDyClSzEX3y5qE03AOA
	 KVCKszga1cmCrRu3XEu3iCcHkeUl4rJZMxapcu/uxm1ddCVdK3IuztZ7x5OCp1d7FW
	 nPiZEUmq1rHhw==
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
Subject: [PATCH AUTOSEL 6.1 23/31] sh: Fix build with CONFIG_UBSAN=y
Date: Fri, 29 Mar 2024 08:31:42 -0400
Message-ID: <20240329123207.3085013-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
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


