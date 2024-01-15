Return-Path: <linux-kernel+bounces-26579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC5582E3C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9ADD1F243CA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF03225A2;
	Mon, 15 Jan 2024 23:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBIrzaag"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC317224F0;
	Mon, 15 Jan 2024 23:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75539C433C7;
	Mon, 15 Jan 2024 23:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361266;
	bh=at6iJ8/JmB5fMrZTnj3WD6s2Lp7JvjqkNj9Iy0SaKos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GBIrzaaguzu0ZhB5Nbm/cdtpjwzJ7hk2XoUy77QdfH0bFoVOVFFIYZlmj36pL7aWy
	 Uqw0YUnafMB9zBsJznChjlMX5BL8Uo9woD/cx0XbnH/XS6IKXMkokn8Y44W0YSDkzL
	 vpWSlYxzotZyQoHYitHqq51baAgzT1VrdOs5FULXudsaxGq4GCM2fc0PnhUquF1w33
	 X6dbU2kdA3bB8zJ5otaF5Lgtn9UaYa200PQkAc3kWV9lGH6T+Y23FAnKDfqzCBSHBW
	 BFontwSmmlnydN+9JZJXwuHf2H84IRHMiqthfqB1B4aVpZ6iqFBa+kRvxABlFmyQeD
	 w0CnV1KrTVB/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com,
	vishal.moola@gmail.com,
	arnd@arndb.de,
	christophe.leroy@csgroup.eu,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.15 09/12] powerpc: pmd_move_must_withdraw() is only needed for CONFIG_TRANSPARENT_HUGEPAGE
Date: Mon, 15 Jan 2024 18:26:54 -0500
Message-ID: <20240115232718.209642-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232718.209642-1-sashal@kernel.org>
References: <20240115232718.209642-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index 9e16c7b1a6c5..da15f28c7b13 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -459,6 +459,7 @@ void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
 	set_pte_at(vma->vm_mm, addr, ptep, pte);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * For hash translation mode, we use the deposited table to store hash slot
  * information and they are stored at PTRS_PER_PMD offset from related pmd
@@ -480,6 +481,7 @@ int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
 
 	return true;
 }
+#endif
 
 /*
  * Does the CPU support tlbie?
-- 
2.43.0


