Return-Path: <linux-kernel+bounces-57328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3130F84D70C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9241EB24060
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4933716F;
	Thu,  8 Feb 2024 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7CJ6x6X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCDE36B17;
	Thu,  8 Feb 2024 00:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351314; cv=none; b=IjOl5zlWOSNbzd6+/9hebujTerZ25wJhqmOXVTCGsG7IFNxWQy+bE9xXdWDXpdPmujRnZEtUlVyCZ785CYdP070y6QH0CHxSSaIt5eJDvrYm5iukq++rAetwvtxyzwncHELHVQTEwNdlLDcp5/jK5W+KdzHTj0F9rYBBaVBGTfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351314; c=relaxed/simple;
	bh=CCi+rDw2ejcWvZ1EnjQItxIQNAEtlo1/MQkx4v+uHWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YLqXxBF5Hp0SPIY+9f0gMiEuffrtWnIGc3V/r5H4fY5T5/HHk2nTUaO89i7Z7vQm1ou9nM28jXTImO5ZFnWB/Tt2GUImbQOnxTr09IUyS5pSLaFEoNsek12oTwjUEhdD68IBn25aIBy+TwWCrh128WecOV/qocRSJMuBOiAFKpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7CJ6x6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8BBC43330;
	Thu,  8 Feb 2024 00:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707351314;
	bh=CCi+rDw2ejcWvZ1EnjQItxIQNAEtlo1/MQkx4v+uHWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T7CJ6x6XIWpT6ltuWuNXD3Isgp2jG34gY6hwPmQwC59BaC9OcNZWXyf4u5j9S7ZzA
	 dJS1H+RWe8ZGSsOw7gfvO8tebgFZGrpP+0yb6iKf45+YmT0CFD3X5TSS6eigcScAPQ
	 fkBygchQOo5eFx1AF9/bUBSe2iTSE4HCANpCJ5gQIqC7u3Qhr0vMd3dk2gNZ30foVJ
	 o16BsHgHhozDLipNHM+KpF5HSLDYk5cSFwdouOY3MOwtG03sq0KV9+Ds0DoH/3HVux
	 HbfyU9UB8W/c5aGrwizpGyilUu3CVy5RYQq+TiInbcFEz6OAgq8c65y0cAVcPynUBO
	 6SrO7tb0HW28A==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 07 Feb 2024 17:15:03 -0700
Subject: [PATCH 11/11] s390: Link vmlinux with '-z notext'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-s390-lld-and-orphan-warn-v1-11-8a665b3346ab@kernel.org>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, maskray@google.com, 
 ndesaulniers@google.com, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=nathan@kernel.org;
 h=from:subject:message-id; bh=CCi+rDw2ejcWvZ1EnjQItxIQNAEtlo1/MQkx4v+uHWI=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlHZDlcu6wyHtW0mmT9myax7ljYBO69LD6vjC9bn6pz7
 1+5ruFJRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZhI7lqGX8x5F768tA/muHWQ
 7f3Ph9aN82f9iFvVZqi6+I5f962f0SyMDHffRdYYZLmkq3zt/xzLfrH40kSl3KWyi2S0/QxDf/Q
 s5wIA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

ld.bfd defaults to '-z notext' (although it is customizable with the
'--enable-textrel-check' configure option) but ld.lld defaults to '-z
text', which causes issues with building the kernel due to the presence
of dynamic relocations in sections that are not writable.

  ld.lld: error: relocation R_390_64 cannot be used against local symbol; recompile with -fPIC

Add '-z notext' to avoid these errors, as this is expected, which
matches other architectures.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/s390/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 73873e451686..994f9b3d575f 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -15,7 +15,7 @@ KBUILD_CFLAGS_MODULE += -fPIC
 KBUILD_AFLAGS	+= -m64
 KBUILD_CFLAGS	+= -m64
 KBUILD_CFLAGS	+= -fPIE
-LDFLAGS_vmlinux	:= -pie
+LDFLAGS_vmlinux	:= -pie -z notext
 aflags_dwarf	:= -Wa,-gdwarf-2
 KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
 ifndef CONFIG_AS_IS_LLVM

-- 
2.43.0


