Return-Path: <linux-kernel+bounces-125038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F535891F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40ABC1C24051
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335C91BFB35;
	Fri, 29 Mar 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHlh5cqq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688CA1BFB24;
	Fri, 29 Mar 2024 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716686; cv=none; b=A9DMGHDJyxtnIC8tE/xiHll94WKOTXILA4XAyX9l3QVbd63A7WKOLQlTZz41715ik9+JUfGqkIQBa5pH/i5o8N58fGSgGLwCZhDzZxeJYBHK4wo4Aioy4K5IU2nJAYWMcUby7/lEKmk7gE+oH4EMa6S6LweRM3MnGqB6VqlkIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716686; c=relaxed/simple;
	bh=BwONR/zqN+f1kbGae3Kf+DFaoALpqNV58n1AullloRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMpiME0/wRMGwg2vFVNmJJ6zGB+1BFrjXsdIZR4Uys4WktY5A5cM1voNgY7vYdpKmvYqmpFjCkhHr+zqO8rQPBTdwc/0L/f31CdcIkhXljY60NlGYAS3OreS3DXNyxK2vLKfhGTbPQ/kehKLL7+AMVCPgremI0zmet3JJdcge/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHlh5cqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A85C433A6;
	Fri, 29 Mar 2024 12:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716685;
	bh=BwONR/zqN+f1kbGae3Kf+DFaoALpqNV58n1AullloRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZHlh5cqqlGWWs944sUzTw/pHXKwBd+Sc5IN44acdzeTo6fuPtZKkXidQvQht32Kbb
	 T84jM4VjgH6P0TmX7RG36c1WgqZwd4Vth/m9DJgPRfa/hV0cbnrNU8XOOrseqlSOFt
	 0/i4K+dbgJTC0ctxjilulekHIe/I3gBN/hT6/OfL2CnF19/N2t0N3Dy5e1biS8SQCG
	 h/FyedbFnH+qapd+KR35hgTUT2BcnGlljGSe6YZWnTbdxMXldWmJaGvDMyhtc7uJBF
	 RdvCwehkJKWsvlj6IKIu0MnZC04epwcShYPlOvvtycB+qos6BWatyFG1rpzSi9oWQ2
	 XOVcndreBSSvg==
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
Subject: [PATCH AUTOSEL 4.19 13/19] sh: Fix build with CONFIG_UBSAN=y
Date: Fri, 29 Mar 2024 08:50:45 -0400
Message-ID: <20240329125100.3094358-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125100.3094358-1-sashal@kernel.org>
References: <20240329125100.3094358-1-sashal@kernel.org>
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


