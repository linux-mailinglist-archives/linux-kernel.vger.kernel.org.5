Return-Path: <linux-kernel+bounces-26596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD4882E3F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0976B1C22373
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498B2250ED;
	Mon, 15 Jan 2024 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2IyQpq+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ABA250E9;
	Mon, 15 Jan 2024 23:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CD3C433F1;
	Mon, 15 Jan 2024 23:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361356;
	bh=xLrtWD9Zbl8VceMvpqhv1a/gkIaGxSe4zkjDPOTdAm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2IyQpq+qHFvHawgrpNIdeNBNTTkcsSTMihIQyIrDhkkvJ/GVLgQihoVVBsm/UBt3
	 AkizgGqVeFO5wD0as6z5MZ/pQs+FPjvpbUDB0RqDIIwO4Cuw3x2gAXiUdN+iVAiaoA
	 w+YyUIRbpIxKTIBWpLlEt4cfSGwo8VZxQ8lk9J2x+jMi/QpOvMV7D10ED7bNb8MYu7
	 sy+HWpt135bUS1wGV0Jb1GkSc7DAvy0JrecQ5xXrTrhd5G3R0homrslNqouxZ8zK9Q
	 /DI2AE07AAnXGJLlg809dKsdTyy/kjLre65HqxGT3nREaxRQ4MRwfIPKmc+753s7CG
	 45MLiHzxMF46g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	vishal.moola@gmail.com,
	aneesh.kumar@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	arnd@arndb.de,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.4 4/7] powerpc: pmd_move_must_withdraw() is only needed for CONFIG_TRANSPARENT_HUGEPAGE
Date: Mon, 15 Jan 2024 18:28:49 -0500
Message-ID: <20240115232905.210324-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232905.210324-1-sashal@kernel.org>
References: <20240115232905.210324-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Stephen Rothwell <sfr@canb.auug.org.au>

[ Upstream commit 0d555b57ee660d8a871781c0eebf006e855e918d ]

The linux-next build of powerpc64 allnoconfig fails with:

  arch/powerpc/mm/book3s64/pgtable.c:557:5: error: no previous prototype for 'pmd_move_must_withdraw'
    557 | int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
        |     ^~~~~~~~~~~~~~~~~~~~~~

Caused by commit:

  c6345dfa6e3e ("Makefile.extrawarn: turn on missing-prototypes globally")

Fix it by moving the function definition under
CONFIG_TRANSPARENT_HUGEPAGE like the prototype. The function is only
called when CONFIG_TRANSPARENT_HUGEPAGE=y.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
[mpe: Flesh out change log from linux-next patch]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231127132809.45c2b398@canb.auug.org.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/book3s64/pgtable.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 2bf7e1b4fd82..c4890f4b0b6c 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -442,6 +442,7 @@ void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
 	set_pte_at(vma->vm_mm, addr, ptep, pte);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * For hash translation mode, we use the deposited table to store hash slot
  * information and they are stored at PTRS_PER_PMD offset from related pmd
@@ -463,6 +464,7 @@ int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
 
 	return true;
 }
+#endif
 
 /*
  * Does the CPU support tlbie?
-- 
2.43.0


