Return-Path: <linux-kernel+bounces-115860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4692488954F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F2A9B216FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEB8158A2C;
	Mon, 25 Mar 2024 03:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYdkDIzI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFA7146002;
	Sun, 24 Mar 2024 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322064; cv=none; b=WH2e9XG71HjEMcD+A7lUZcbt72LZKy8yjk9S0qhhBmxSBr9lLPxO3gCBARdaLcvwJ1EkJt7XWMjAdeubENh9/5agJ4beyYfn7LZzpGIYU4PsQO/N8d9/cxr26DA+YnDD7g0QzEQEmblSTsFqBCCqI/ozkQClXP11muMROelMetc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322064; c=relaxed/simple;
	bh=Ty54UJkyHxXnxmNG3U9Di3z28hRX9+NIx75utLzM6ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAUWLBYfCSPedqTnnqLwlOIIC0K2wKcMJS90E+h7djzh/q7SbzoASyclC+fnHZVKwGxK57FRWkC5JsVgCCUqbZmmllERQB7HSrdrXCq0UGdgTY09P54NmdPndR/bu+dPi2xYn14nbNruR8X9wwEK0Xs8KlSmXz3+vjL1d6bURY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYdkDIzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C8CC43399;
	Sun, 24 Mar 2024 23:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322064;
	bh=Ty54UJkyHxXnxmNG3U9Di3z28hRX9+NIx75utLzM6ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bYdkDIzIUmPa56PY2k4ekwyr1LcmPKLvCjRb8sSfB7lnOJCWjg3gz/MY0EVnedY68
	 fDdSBTqfh+nO8FXUM9WBOnM11EKacLAoQpdDkbCkme71qHes6gtqbd5GMcWTbu+O6e
	 o1+ffpSLtzXZVqSnhom8Xcm1reGmuuSBnkBthM/wWW7TULBc2GemCWL82ccAXyh1Ig
	 /gX5SpWHCtZjq+FzrfWxdug4DKGT/fopnKTVl8+2HhU05k2gVqGpbsGKLGJerHAKK4
	 cKlQTDLW1Lt1xlGl5Fh/v5QRtuyf8q4XdPN4QxWxAlEUYF0ADio8YQXpywtr7l0i8h
	 9uzUoTr+kqLSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Fangrui Song <maskray@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 137/451] s390/vdso: drop '-fPIC' from LDFLAGS
Date: Sun, 24 Mar 2024 19:06:53 -0400
Message-ID: <20240324231207.1351418-138-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit 0628c03934187be33942580e10bb9afcc61adeed ]

'-fPIC' as an option to the linker does not do what it seems like it
should. With ld.bfd, it is treated as '-f PIC', which does not make
sense based on the meaning of '-f':

  -f SHLIB, --auxiliary SHLIB Auxiliary filter for shared object symbol table

When building with ld.lld (currently under review in a GitHub pull
request), it just errors out because '-f' means nothing and neither does
'-fPIC':

  ld.lld: error: unknown argument '-fPIC'

'-fPIC' was blindly copied from CFLAGS when the vDSO stopped being
linked with '$(CC)', it should not be needed. Remove it to clear up the
build failure with ld.lld.

Fixes: 2b2a25845d53 ("s390/vdso: Use $(LD) instead of $(CC) to link vDSO")
Link: https://github.com/llvm/llvm-project/pull/75643
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Fangrui Song <maskray@google.com>
Link: https://lore.kernel.org/r/20240130-s390-vdso-drop-fpic-from-ldflags-v1-1-094ad104fc55@kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/vdso32/Makefile | 2 +-
 arch/s390/kernel/vdso64/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
index 245bddfe9bc0e..cc513add48eb5 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -22,7 +22,7 @@ KBUILD_AFLAGS_32 += -m31 -s
 KBUILD_CFLAGS_32 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_32 += -m31 -fPIC -shared -fno-common -fno-builtin
 
-LDFLAGS_vdso32.so.dbg += -fPIC -shared -soname=linux-vdso32.so.1 \
+LDFLAGS_vdso32.so.dbg += -shared -soname=linux-vdso32.so.1 \
 	--hash-style=both --build-id=sha1 -melf_s390 -T
 
 $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index 1605ba45ac4c0..42d918d50a1ff 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -26,7 +26,7 @@ KBUILD_AFLAGS_64 += -m64 -s
 
 KBUILD_CFLAGS_64 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_64 += -m64 -fPIC -fno-common -fno-builtin
-ldflags-y := -fPIC -shared -soname=linux-vdso64.so.1 \
+ldflags-y := -shared -soname=linux-vdso64.so.1 \
 	     --hash-style=both --build-id=sha1 -T
 
 $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_64)
-- 
2.43.0


