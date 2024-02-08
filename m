Return-Path: <linux-kernel+bounces-57324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB8D84D702
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815B01C21F1D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A1F360BC;
	Thu,  8 Feb 2024 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0j6x3wg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D3F2EB1A;
	Thu,  8 Feb 2024 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351311; cv=none; b=t+mEIzB51CDH75GHh5CKpqmB+uoa9rGPqC+mxKLXC9LhhAqB3bK6VOiO1GgxeZvxCCmC5Gf/9VYxqfKEYPKZCT2ywtOTarLqV75W2sfL0FBQ4eTESFcfEfGaTVWNpt3YsmiJ5tvIDOzs8w4nC2gYnRXBh893WyXFxPqs2U9eKn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351311; c=relaxed/simple;
	bh=KHxjzg2nVnCz7Xo3WUiDpqO3qL7wZjCy4cl0c4riXaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZI1Iir9c7Vwd4EcGWDZkyZhitNfiGTJFKlSFe2k0Rgcmj4f7RSOdXvNvhqK/KbkgyF6OEjuOohHaRsrV9Ijpxr3nhbAN6urLcg+i1xK2npn1eXW/hJqXWy4BTm3eZtnEIcD3e2DbDclbrzbDslljVz/Adx6koTOeKJh4H3Om+J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0j6x3wg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9E1C433F1;
	Thu,  8 Feb 2024 00:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707351311;
	bh=KHxjzg2nVnCz7Xo3WUiDpqO3qL7wZjCy4cl0c4riXaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T0j6x3wgeIAg+/sh2h0RKM4Eb75pwg5NNVAxncktwO4c8LZqCo9lHNA5Mxrg0hTtk
	 A6gqYouoa3iGNuKrj9Q4M6Y6cPfb4VvZ2fcqaMnaKULBon54kQgDlXburcQHSX93vB
	 vPmBdFys+MBUOH91KeTR6zXvW8Al5NTth/rRwVDjuuFRSYpUT4r1XxoAkWVR1XmYHH
	 xVlXZAoZcU1v2rvn+g7HU0j9CXq7Cp5naBsa52Kz8rq0ViFvQ8KULzEU8A3BOglyzr
	 1qyp9J85Wr0HEKGFpW2L43w9nm/W6RUry6cK/OkfC/nPWequsNvL/6BuFKW+VucOxz
	 1PRXZZmXX8eQw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 07 Feb 2024 17:14:59 -0700
Subject: [PATCH 07/11] s390/boot: vmlinux.lds.S: Handle DWARF debug
 sections
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-s390-lld-and-orphan-warn-v1-7-8a665b3346ab@kernel.org>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, maskray@google.com, 
 ndesaulniers@google.com, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=nathan@kernel.org;
 h=from:subject:message-id; bh=KHxjzg2nVnCz7Xo3WUiDpqO3qL7wZjCy4cl0c4riXaY=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlHZDlav+Rd4Nvj9u6e96vjoowWO/O+Hzha1M7MIPl3G
 4Ph9WPOHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAi/WcY/kpEP1aSPDft2HyR
 nkMfTNZLGr6fdJcxJ+HwqRmGhvvO8r1gZNjJvSnXsELt+26e9M3q51kXBNUXtmhvPTjTeasd82w
 nGRYA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with CONFIG_LD_ORPHAN_WARN after selecting
CONFIG_ARCH_HAS_LD_ORPHAN_WARN, there are several series of warnings for
each file in arch/s390/boot due to the boot linker script not handling
the DWARF debug sections:

  s390-linux-ld: warning: orphan section `.debug_line' from `arch/s390/boot/head.o' being placed in section `.debug_line'
  s390-linux-ld: warning: orphan section `.debug_info' from `arch/s390/boot/head.o' being placed in section `.debug_info'
  s390-linux-ld: warning: orphan section `.debug_abbrev' from `arch/s390/boot/head.o' being placed in section `.debug_abbrev'
  s390-linux-ld: warning: orphan section `.debug_aranges' from `arch/s390/boot/head.o' being placed in section `.debug_aranges'
  s390-linux-ld: warning: orphan section `.debug_str' from `arch/s390/boot/head.o' being placed in section `.debug_str'

include/asm-generic/vmlinux.lds.h has a macro for DWARF debug sections
named DWARF_DEBUG, use it to clear up the warnings.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/s390/boot/vmlinux.lds.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/boot/vmlinux.lds.S b/arch/s390/boot/vmlinux.lds.S
index ff8c62d84f98..83af17bfe630 100644
--- a/arch/s390/boot/vmlinux.lds.S
+++ b/arch/s390/boot/vmlinux.lds.S
@@ -122,6 +122,8 @@ SECTIONS
 	}
 	_end = .;
 
+	DWARF_DEBUG
+
 	/*
 	 * Sections that should stay zero sized, which is safer to
 	 * explicitly check instead of blindly discarding.

-- 
2.43.0


