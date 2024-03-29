Return-Path: <linux-kernel+bounces-124785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CE4891C7A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075C01C24893
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C304188A79;
	Fri, 29 Mar 2024 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfKu8ngS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF1E18766D;
	Fri, 29 Mar 2024 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716139; cv=none; b=OFEpwwi8PwjZjjKsQJ60s9OcWopL7Wdg5FDWVbEkH/7hv3IgWMiA2jL5xQyjGTAoBDyYxuVXPtC6HZnNzdenGbAiWOCIm6s55hXpn/pyJ6WZL5MpU+8sIjRPNskIZHhYATBDd0XGnIWVLtkkKDwLSxBFXsFf2FX6K8w9B9TuP8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716139; c=relaxed/simple;
	bh=/+N/yT27Ws0m/5w/1cIOi4gBNiyyDit7r4do8MHX5j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaYFVHFbxpc+hvTka4hDgF1NmMLfAD+iBS6X8EX/pTp+dbVZWUn5fSEZF8IFnB77QZXFEcr5wpShcyS/npi5Z4sqGbSXh26ZhABDa3cAnZfTCzT4v6XlQcBnuDUiPesuhuV0/o0DQMY3r2qnMm9cRGa0ifeGgSPM/7SM4nlbRBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfKu8ngS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45546C433C7;
	Fri, 29 Mar 2024 12:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716138;
	bh=/+N/yT27Ws0m/5w/1cIOi4gBNiyyDit7r4do8MHX5j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RfKu8ngSytbWEPJw/Za+3CiYiZHIpl+rzScp/ybd1wXm2aDTY9ICw7CtPTSykb6qx
	 rsj+S/oGYupwwVXEAtSC2+ucqyAjW3oLPgM9JrgNpC0B+ry2bmnqGvPn+0Em8m09ro
	 ddG0gVJeSVxPLL0VWdLcKGIlI2BiKcTxz9hXwIgpbn1ck2buCC283rRqmkRBi3D4MS
	 1Xwbipz1ccjZfTHPICwcJ2Hvqm21+1tFee+DMAC/E5pSR6Cp4nuk+9y0b1CF3ZCDs/
	 /X5tUEXAon9jWTYHqPPqOzvwx5u+lYdatfu8Lya3v8+gPKko/oM/SOYG/PZAcg7iSx
	 5+q/Lg0FIw30w==
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
Subject: [PATCH AUTOSEL 6.8 75/98] sh: Fix build with CONFIG_UBSAN=y
Date: Fri, 29 Mar 2024 08:37:46 -0400
Message-ID: <20240329123919.3087149-75-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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


