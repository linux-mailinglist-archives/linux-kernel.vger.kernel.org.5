Return-Path: <linux-kernel+bounces-115635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4287688A3DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2956EB66878
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE4D34D476;
	Mon, 25 Mar 2024 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1X/D/wW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2874E204FA3;
	Sun, 24 Mar 2024 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321475; cv=none; b=NEFWANY/ZZLvs0uE/MQIxOT3vwuf50hpoI8hx98MexElxYbBN6MED33an7gStVMKW5OMJ16t07B6glaguIajxXcV+x4qVhp7knQckpJCUegEJnwlyVurQDWR79+y2/8HOm6KHDzpk5Y3CjviduvQ0P5/MN09BNjBurMNs3B1LTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321475; c=relaxed/simple;
	bh=6czK7Hn3MnAD3YyAV5TfrDyAIetWQpDb15+Q7U90avU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWt82T/n15AhyT+Owdq0WF4Kro4NwjuQMMqW0vbnUEcbKFoPkvUHz2ng+lW3slqbD2+0esVxknUqfkggrJC+ofLthvS6CASyzsnug0ZwUulJWTAyy+cJ7ioc8cI18HKdUVWAo9VOcL7TA9J1ArFvF+yyvdJloCaBcEC5sXy8fkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1X/D/wW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E74C43390;
	Sun, 24 Mar 2024 23:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321475;
	bh=6czK7Hn3MnAD3YyAV5TfrDyAIetWQpDb15+Q7U90avU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1X/D/wW8CTHryYYqDDX+Ns6qQlR4NS9SNGywjDpuj+JSviAMIQtOkkMWM7h44fli
	 oOhCGwTYbB/SyH9NmqXno5JlsJflNOjUr55EFUS2osVofDr2Wrh3qYg+55Po6XgeEs
	 o3lUzMFt0X4TEMCzPuAVlOEJ9+Z+2a/W2oGEWbdP82VgB/2FDUqahHr3BCdRs9drW7
	 XFEcc0mwlyyU19OHNJcqIkTZ7Xbjqbkp/QlvpXYcWeS67O8UMYiKjGihVQ0j7ocfjm
	 dpTeF/Yl0W+iS49FjD5aF5V4+z6kWsocnPhMPPFPY0c9mlV/XG0R3jC3CQml969E/x
	 yQYCdaHn/Frtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Fangrui Song <maskray@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 200/638] s390/vdso: drop '-fPIC' from LDFLAGS
Date: Sun, 24 Mar 2024 18:53:57 -0400
Message-ID: <20240324230116.1348576-201-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 23e868b79a6c9..c4b14a8700d88 100644
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
index fc1c6ff8178f5..11f798e6cfea7 100644
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


