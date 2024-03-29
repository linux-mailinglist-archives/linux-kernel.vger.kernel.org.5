Return-Path: <linux-kernel+bounces-124673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFAF891B3D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69B01F2A5DE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741A21703AA;
	Fri, 29 Mar 2024 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRNV2F3W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37FC1422BF;
	Fri, 29 Mar 2024 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715669; cv=none; b=OH/mc6DMqKrX+t9kuVxfp/kIGHxmzEXZybfbxT9B69YNZ997B4vE3T9bLvHpSLekKCQyRhltzSrRhOTZjFmy4RIWdYlYqNpmaDfRSxhK9mKCdv1ZIo/2dcuDVDR3jrtAXMqahobfulpQaWfIj3tB1Kb1eeowpEbMSxFEpX/zkn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715669; c=relaxed/simple;
	bh=ORrkXhOEFKtoASG7lh/cLzIJoH6liO4TrWq0yY57hWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJlsgBVTlxzfer1Es9RzkCX4NJ1+dGKavZSqOpO5RhPqKYW9pM6Rq/COL52UJ55Z9OnlvnJkhied8+NvcrvpIw9v1vx46CDrtQb/QzZo9OgVp4E70eJ0D1/ejAwYpSRCnZcPdWGHe6nmAINJ3XDjBOQbjA6gMvdG/xdLt3O2uqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRNV2F3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC99C43394;
	Fri, 29 Mar 2024 12:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715669;
	bh=ORrkXhOEFKtoASG7lh/cLzIJoH6liO4TrWq0yY57hWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qRNV2F3WPfDJEfBrKVMiyaqzMlNolYfcEx559O0as88kKa4J7iCq+kadjQzUSUMZz
	 y+kXqW/c8vSEjJYqfkE9jyYm6kkHmtV8dksTxRlrYp1OG1Te9sL5eIHy2Y91lpoFP+
	 bPoKXQs9mTeHWq3w8JS1roL/Y27h7s10uGHL2+ELICZjs5G3InzPsL3J79HYBHgBPi
	 PiSpU9+Ce9L4WFpEfWIHM54hVJYaB5dyXNJxVbMr5Dt3jRpbs9b76MOI3u9q/py5nj
	 Z7wqHpZP8a+NLK6pUDFbX9HcfjEGUjhwJkeoGgmhTJhKnFP+voq3CDsOCMA3PjlZNr
	 DxHwFc6gzfeyA==
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
Subject: [PATCH AUTOSEL 5.10 12/17] sh: Fix build with CONFIG_UBSAN=y
Date: Fri, 29 Mar 2024 08:33:51 -0400
Message-ID: <20240329123405.3086155-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123405.3086155-1-sashal@kernel.org>
References: <20240329123405.3086155-1-sashal@kernel.org>
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


