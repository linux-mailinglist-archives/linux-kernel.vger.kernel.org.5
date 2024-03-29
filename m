Return-Path: <linux-kernel+bounces-124649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A22891AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56671F29F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3014916A1E8;
	Fri, 29 Mar 2024 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiY1/JF0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC8A85C65;
	Fri, 29 Mar 2024 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715627; cv=none; b=oDtEx5CICknFTVJGmzjcXYI9OTqn+EqjnR+bbNlufEa0I1KXUEg7a6Ufs7JmZEjk6Cn1X9KoMJ9V1CqkWpHU9ckV5xIfg7I6VjN9zngpIbCgsiI+I/ralrxrsezjHi0JFbY5Mbu47Ypk3rWpX/B1mzvonngEk2443tF9jHTuFF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715627; c=relaxed/simple;
	bh=ORrkXhOEFKtoASG7lh/cLzIJoH6liO4TrWq0yY57hWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCM0CAaeFxDpJLsth9isczIGrU/sliWujOj5QGro7+xYrEt/26/ouLsqLDc3NPuR0wsBnNIvfG49I0eb4Co/xzgvkXqFRk5hry1q5eAP02WwD6WiHCTcdD08IdcOSVFL3KdCyHH9XssRObLBnWf0w9p8oD7k5GAtDhZuJLH+m6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiY1/JF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2EDC433F1;
	Fri, 29 Mar 2024 12:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715627;
	bh=ORrkXhOEFKtoASG7lh/cLzIJoH6liO4TrWq0yY57hWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tiY1/JF0XIXwDpo1OMVG1lqTDJn1IGaLfLx/MTCcVGrstYtpEafEOaXoSufbKu23r
	 sesDhIKgMmc3lfJoZSJTyk3wmNCA14i07AlU9XhJ00LGoX9/USSAoN/7sS+dzfm9hH
	 X4zkTvCCIclE8MkndveFqNUPdz7qxiP6gNoppjUybQ9YFQ4MGih+eW6HI29+uBRjGS
	 k48ew7STGzGpSh537/ytoo4OLf4bUUNSUiB91wyEVpwlroELMhjmwvA/reJkrq23yC
	 e6TjxqHnvYm/jkEIue9dHQJ7w3TRCwmfEhc0ZIoWxOtqBy5oa3JjYM44AHbI1zuoFL
	 0OUSn2MEx3acA==
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
Subject: [PATCH AUTOSEL 5.15 15/20] sh: Fix build with CONFIG_UBSAN=y
Date: Fri, 29 Mar 2024 08:33:03 -0400
Message-ID: <20240329123316.3085691-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123316.3085691-1-sashal@kernel.org>
References: <20240329123316.3085691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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


