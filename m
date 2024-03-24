Return-Path: <linux-kernel+bounces-113692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094CF88860C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A59E1C25137
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B1A128365;
	Sun, 24 Mar 2024 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6j0PA5u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B314387E;
	Sun, 24 Mar 2024 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320669; cv=none; b=ir+nqaxChBljtBvSOLkt0llLjLyYsc+ctdgOxrdWbwgBHyYJRWtmQJYrtIkC/jO9n9WC6Zhh4AolTqJPJ/JlJ8Z8dLbiPD7JPv2vpBsztqMtsOy2hvWB6oCC/Q7l3ivIOC9yeWKl3/wIFPNsvrsGeIrCSADooBOv+ePvOtRXJNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320669; c=relaxed/simple;
	bh=D+nadqxwlJrpxWU98ynFUoEvId/9NZQwyj9q4BxpIUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4e2z7mIiUjEMZOe8HqGDIPKkke54cbfgpjadecyyiIZUw3EzZtGRj6V70AAuo8hPprNufNyrgTjy7STe7q2Cp2JDzjjewy32UJvj4b3IXSM+fbhbE+D+RjqqCPtRdhTfLb6RrbTL20dtzrf2UvKx+ts054O83zDkkklksYNQQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6j0PA5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF659C433C7;
	Sun, 24 Mar 2024 22:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320669;
	bh=D+nadqxwlJrpxWU98ynFUoEvId/9NZQwyj9q4BxpIUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A6j0PA5umaUbgdyqPU4vHgrBjEf4mJSktaInLgQHGZcCrc32Caf5CWkXUg71zBV+B
	 +Ay1c4FomIjxDCoeQsdHrFhpmLoPDG34jePUYVkvi+HYmtqPOKtmzaNVoviRGemxPb
	 DEJzVo0ZAE4/AiqsO2zDJHVbJQKLcwA9aHaIiTkmy5zd7ac4kSu1LE5oW0Fl2eys6f
	 bk/ONZFHLjT5L0RYL9oUyS1EldZTfZAVEnlf02rykSJRjrFycypqeOV238rzBC0YNn
	 H+rbn7WEjq1b0aOVSCuPnKlCTwANZMDfBxjtaCzatx4uLkpy2vIgKFqWWmHHVyib0C
	 hZ4T3x/xN4pCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Fangrui Song <maskray@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 232/713] s390/vdso: drop '-fPIC' from LDFLAGS
Date: Sun, 24 Mar 2024 18:39:18 -0400
Message-ID: <20240324224720.1345309-233-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index caec7db6f9668..b12a274cbb473 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -22,7 +22,7 @@ KBUILD_CFLAGS_32 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_32 := $(filter-out -mno-pic-data-is-text-relative,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m31 -fPIC -shared -fno-common -fno-builtin
 
-LDFLAGS_vdso32.so.dbg += -fPIC -shared -soname=linux-vdso32.so.1 \
+LDFLAGS_vdso32.so.dbg += -shared -soname=linux-vdso32.so.1 \
 	--hash-style=both --build-id=sha1 -melf_s390 -T
 
 $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index e3c9085f8fa72..caa4ebff8a193 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -26,7 +26,7 @@ KBUILD_AFLAGS_64 += -m64
 KBUILD_CFLAGS_64 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_64 := $(filter-out -mno-pic-data-is-text-relative,$(KBUILD_CFLAGS_64))
 KBUILD_CFLAGS_64 += -m64 -fPIC -fno-common -fno-builtin
-ldflags-y := -fPIC -shared -soname=linux-vdso64.so.1 \
+ldflags-y := -shared -soname=linux-vdso64.so.1 \
 	     --hash-style=both --build-id=sha1 -T
 
 $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_64)
-- 
2.43.0


