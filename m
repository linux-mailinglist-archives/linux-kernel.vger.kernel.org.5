Return-Path: <linux-kernel+bounces-26552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E1982E381
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6CC1F227B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A271D558;
	Mon, 15 Jan 2024 23:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T31pJqXy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514C51D548;
	Mon, 15 Jan 2024 23:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B032C433C7;
	Mon, 15 Jan 2024 23:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361130;
	bh=Ee2M58ju22NFHa0mTwMmantjdpgOnjaWSSmCDC5AQnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T31pJqXy3/97Wf1eTWHruuXdZvlAyym3nsYUrh99qzLzEQlD/NNf/ChHZGgr5iTN4
	 b9Hv9pGXNY9dQ7VvxV2zImL3s9LBLpYjuQvZtCdSulrU4EbFvEKPjG+shiJxkFaNnj
	 ynGxoN2pXkvlVCKZ+Z2bHHl97DsOpGdERdHhbc7Wqp4033Jrjq1wLRFmDqssz1gJUE
	 80cNX4KA+ipCE4hXR0rZYDA1eJBLCnEkuKVCmr9hEaqcWx5LVXM8T7eq55oVQ2/NVz
	 cLKVn6j3M1wn2VWSagrjB7km89TNTy/A3waTfVNfvGV/tIXiYLYCCyz9hUZN+2Mjwn
	 osJkgo10uy9mw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@linux.ibm.com,
	arnd@arndb.de,
	vishal.moola@gmail.com,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.6 10/14] powerpc: pmd_move_must_withdraw() is only needed for CONFIG_TRANSPARENT_HUGEPAGE
Date: Mon, 15 Jan 2024 18:24:33 -0500
Message-ID: <20240115232501.208889-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232501.208889-1-sashal@kernel.org>
References: <20240115232501.208889-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index 8f8a62d3ff4d..926bec775f41 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -542,6 +542,7 @@ void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
 	set_pte_at(vma->vm_mm, addr, ptep, pte);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * For hash translation mode, we use the deposited table to store hash slot
  * information and they are stored at PTRS_PER_PMD offset from related pmd
@@ -563,6 +564,7 @@ int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
 
 	return true;
 }
+#endif
 
 /*
  * Does the CPU support tlbie?
-- 
2.43.0


