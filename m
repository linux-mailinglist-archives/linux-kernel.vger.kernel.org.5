Return-Path: <linux-kernel+bounces-113320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C71D888362
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD33B1C23813
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DDD194687;
	Sun, 24 Mar 2024 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIGg3NgK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8C119466A;
	Sun, 24 Mar 2024 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320122; cv=none; b=VQ41HLIXx2GAtileazO4rZvaQsNkeV5TaiGg452z7iuDCjLhjU/cda44mLjTi+OqxYGxMsX56OhXWTln8OfPyS0L2syuewHNE2JjXyuKEyclE03nFsxy7ZdFpF5OOVRTY0HcaWB93fA3r9CZSwAw3k3WVq5Wps1/bmnAeF9Lj3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320122; c=relaxed/simple;
	bh=+PUu5RM10hKszLtQ9PhN2GrdWiBPvEkFSKTRdD/60jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOOvr0XUAVCGoje9GEs+37VYcc1rb4mnty3HReO0/Nvxm4VxtzWtAw2Z8DjMARXYLlHZ10V7WGT1fxHOBeBJWO8jXiPoyjgd6V8uuP3ot86QsQOMUiUpF8OkuVa55Y6fJfjdpARUGonxmO34cCac4wpn2yqVNCb5t3LiL/Y1deE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIGg3NgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D5BC43394;
	Sun, 24 Mar 2024 22:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320122;
	bh=+PUu5RM10hKszLtQ9PhN2GrdWiBPvEkFSKTRdD/60jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FIGg3NgKnvfQthjsWLPPVD9HFX3ljHaQK9oQ+jR76zHKdBbN21c4iPPCYgdlEkbtU
	 vcBFPXIaADf4zgtVusO+pmQ90vn4JCBI4meVLeyxv/FkWWzLA46m9d1ceYo4Jp0tp4
	 S58StT6JBNygLapqDBvAuvH/ctAPYK25Uu5Nu3JKZAOHuct0ml5TiFcK3RRsgMaBzm
	 Kw+Eo33Yv6Gh4/qq8eNqSgmjKSxYjHJQQibV6k9XSLqf8gZjVapJTi4oqJWbFI2se+
	 Zy2qEWFlnis2gZRkWK3uIzqW8OFLCuCIIl/S2CXK9BlYR3/dKtgW4TtY8LbKpK/rlQ
	 C8oJfnm0o0gpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	kernel test robot <lkp@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 429/715] powerpc: Force inlining of arch_vmap_p{u/m}d_supported()
Date: Sun, 24 Mar 2024 18:30:08 -0400
Message-ID: <20240324223455.1342824-430-sashal@kernel.org>
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

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit c5aebb53b32460bc52680dd4e2a2f6b84d5ea521 ]

arch_vmap_pud_supported() and arch_vmap_pmd_supported() are
expected to constant-fold to false when RADIX is not enabled.

Force inlining in order to avoid following failure which
leads to unexpected call of non-existing pud_set_huge() and
pmd_set_huge() on powerpc 8xx.

In function 'pud_huge_tests',
    inlined from 'debug_vm_pgtable' at mm/debug_vm_pgtable.c:1399:2:
/arch/powerpc/include/asm/vmalloc.h:9:33: warning: inlining failed in call to 'arch_vmap_pud_supported.isra': call is unlikely and code size would grow [-Winline]
    9 | #define arch_vmap_pud_supported arch_vmap_pud_supported
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~
/arch/powerpc/include/asm/vmalloc.h:10:20: note: in expansion of macro 'arch_vmap_pud_supported'
   10 | static inline bool arch_vmap_pud_supported(pgprot_t prot)
      |                    ^~~~~~~~~~~~~~~~~~~~~~~
/arch/powerpc/include/asm/vmalloc.h:9:33: note: called from here
    9 | #define arch_vmap_pud_supported arch_vmap_pud_supported
mm/debug_vm_pgtable.c:458:14: note: in expansion of macro 'arch_vmap_pud_supported'
  458 |         if (!arch_vmap_pud_supported(args->page_prot) ||
      |              ^~~~~~~~~~~~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402131836.OU1TDuoi-lkp@intel.com/
Fixes: 8309c9d71702 ("powerpc: inline huge vmap supported functions")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/bbd84ad52bf377e8d3b5865a906f2dc5d99964ba.1707832677.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/vmalloc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/vmalloc.h b/arch/powerpc/include/asm/vmalloc.h
index 4c69ece52a31e..59ed89890c902 100644
--- a/arch/powerpc/include/asm/vmalloc.h
+++ b/arch/powerpc/include/asm/vmalloc.h
@@ -7,14 +7,14 @@
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 
 #define arch_vmap_pud_supported arch_vmap_pud_supported
-static inline bool arch_vmap_pud_supported(pgprot_t prot)
+static __always_inline bool arch_vmap_pud_supported(pgprot_t prot)
 {
 	/* HPT does not cope with large pages in the vmalloc area */
 	return radix_enabled();
 }
 
 #define arch_vmap_pmd_supported arch_vmap_pmd_supported
-static inline bool arch_vmap_pmd_supported(pgprot_t prot)
+static __always_inline bool arch_vmap_pmd_supported(pgprot_t prot)
 {
 	return radix_enabled();
 }
-- 
2.43.0


