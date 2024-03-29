Return-Path: <linux-kernel+bounces-124864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857BE891D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BC41C2708F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E941C9EBD;
	Fri, 29 Mar 2024 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qznAJO2O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A911C9EB1;
	Fri, 29 Mar 2024 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716313; cv=none; b=TYrLfe4bEEvGticUI/kuUVgUjY5wGAj0mFgBOp6qNRQlogiEmbpHxIELUq2+eEhS3k10TJvHjD/qeB8Ej2AMDaaWPOIynF+EFKkFquJ36CyaO0ggr4IFAQTS88vi51QyPJVBuJZJOgEVIG7Qp7gi+e7c4PCeQz47rYCO8DxQquk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716313; c=relaxed/simple;
	bh=/+N/yT27Ws0m/5w/1cIOi4gBNiyyDit7r4do8MHX5j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B98bI8IoEdVTxbythAqwDqjCciZEAO38vnqVlLJKDuBbSgwcuaTtQOQYX8Jew2aXqitvj2BsIGe9k+SK1nZaZ9xtOyfvyZSduhKZC9pkLpfEdyAQa4opGyKEbTJsbPqJ+FhqXtJP7ynR0UiEb3y/FyWVySJkScT7X869gTBVz2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qznAJO2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4369C433C7;
	Fri, 29 Mar 2024 12:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716313;
	bh=/+N/yT27Ws0m/5w/1cIOi4gBNiyyDit7r4do8MHX5j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qznAJO2O4I6HCEmdAp/JtxeJyFpp0aGvMosvTJrE8vFcffPTdZljCDU3BCRK6buqN
	 gyrNB0PaQBsmGL77fopXvaJZLhUvvppqT93vpFsXsIpGaUmNeePhjtyG7InUkDuGqE
	 e7+5byH52/L9a2+mWpP+WX3f37YnTCmTbQnMUPvHGrb7zyozfwqIg0nJUU+xsyRbig
	 urXV+2iOXo5Wmb1WE3MSBl9iTPTUH6r1I66jEVadK/OZfWpY39EuU2KzduVg8Aqnoy
	 QHnP0VtP+UI5c/heSRPCnNKJwSVXfTTLjdMzKtD0djdnmjAFCsYWRipbXy05pC04Wr
	 Aa0Q62NZujHrg==
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
Subject: [PATCH AUTOSEL 6.6 55/75] sh: Fix build with CONFIG_UBSAN=y
Date: Fri, 29 Mar 2024 08:42:36 -0400
Message-ID: <20240329124330.3089520-55-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
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


