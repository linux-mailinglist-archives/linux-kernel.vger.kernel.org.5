Return-Path: <linux-kernel+bounces-113062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC86888129
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A66A28197E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F141482F0;
	Sun, 24 Mar 2024 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKVxDvJg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B21474D7;
	Sun, 24 Mar 2024 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319870; cv=none; b=ImbxCN+nYQgZS+pjWwGgvsOWU6qlH9y+7bBlo+Ea4yCQ3IvtjK+qef+Wvq1cnensXF0Y7Q7tP79bJViKlwGCch7wOrVpklq5pQ4FEXF+ntardHPvwjYAEoqU+jlJnCdkGSDZTQVC0lk3/HJN31AOsMQAP6+QYaQ0QnCQQqGLxm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319870; c=relaxed/simple;
	bh=D+nadqxwlJrpxWU98ynFUoEvId/9NZQwyj9q4BxpIUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVsYq6sY4NS+tK3q1BVQASv08n7zoqFX6tCvjD/h6HIV0fiD0IHKwNA8znqe4gVr7/B1NWWetooX7Pz3jRfXo+Sk8E699GFhd/fC2fKhdT4KCm4EQiOvYvnbLA6eST+Xqlm1pGN3jeKMh2Ib5Uxft8tRG6dt/g1n5WuuwjQTiKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKVxDvJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6E0C433C7;
	Sun, 24 Mar 2024 22:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319870;
	bh=D+nadqxwlJrpxWU98ynFUoEvId/9NZQwyj9q4BxpIUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKVxDvJgTLCoJb4IfP7j+pFgbqIjAEAcScQRMKDZP8sIUizP22INhfpBrXzSjYLIO
	 umn4qxeqFLMP+EG5E50O9eERwogVs07bOca0kXB9PAGZVlOD/alALZGRp/UH5mtxvc
	 9EYtJO6Flo4tNYbd/yMnXnduUFKAvRRj9oHfzAX6+N/Sm0ushsSyB49UcLUGC9d8QO
	 ZnV+tMnqmpp4KoFoGq8YNJHxo4e4avCUel2hnzDjSXPAc2Vd8OloNLJQ/kBXbDAVdD
	 sPNInlRyFDwnZYyAL0//j7JNvITWEt4o1KhYbFCP4Bh+Mj2vuTR4Dln5dli9I0cRT2
	 sNm6g2yZTp63Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Fangrui Song <maskray@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 175/715] s390/vdso: drop '-fPIC' from LDFLAGS
Date: Sun, 24 Mar 2024 18:25:54 -0400
Message-ID: <20240324223455.1342824-176-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


