Return-Path: <linux-kernel+bounces-116907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B82DA88A4FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C91E1F3B509
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E130D157E87;
	Mon, 25 Mar 2024 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTNU6iQC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3EA140361
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364891; cv=none; b=j3YAGjhSfIxOVvYHcvchfjrkKn2GvuSq84yfbkn52addtxqLt65aMZ9bVSdJiJo4x0ZLxmAkAdEdDMcPIw2lBIsZjpWGmNEhbGmUM89Nbft72K4FUvYoIkCklzrgtZffwBWTAYvXe+Wn7YHWiMj2cV1+Cywn8PtBCGxe9a2YynQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364891; c=relaxed/simple;
	bh=mK+a5fKSHAosIJ1vD42jVSju6aNIvU/ovsSMpFBzTcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abNl8W7Ol4W9kndd/p+xuSG+J8cohKCNw3M8Z92zfSSDOhxUS5y5wiQk51c1LcFRvzKw2Xfsj3fPpIk/h9qv95V9L1SpLS/ox5Hm1OpAomsjZf+x7ur1od84UM2+SvIHOQetv3Jx6Hz5Q+40d1ZFqo7UxxzqyMgLbQvJDM6hYzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTNU6iQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EE0C433F1;
	Mon, 25 Mar 2024 11:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711364891;
	bh=mK+a5fKSHAosIJ1vD42jVSju6aNIvU/ovsSMpFBzTcY=;
	h=From:To:Cc:Subject:Date:From;
	b=XTNU6iQCNHH0nf4EJwPkJQJ4Y7Q2vDWDhLL4ldDBVvtm7CAZBiEHtbrfLEdZTw386
	 zyDHEF8tzhEyizMK2ln7iZU/WOs3UxnTQ1X9DnCIU5uCtVt2LgFAysBHsTxpvLG8Y5
	 gZwi1hKkG4TYngUyw67VhKn5NA4kB/uC8/HGJG96dxHFKYoEhYdkTXNCdtldoEO+YF
	 0s0g5nCKiXvoUZXW/r+1hYRavWDKohfetk+wXYa4/FNmukCVygZYHvsn11XBBp7wQ/
	 rArulJehFnEQSPpcNIiXQVdjGkGfmhv3UluA3E3QpnndGANNxikA/BLpvuPsJHYeOU
	 sE161vCVQg7Sw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 RESEND] riscv: mm: implement pgprot_nx
Date: Mon, 25 Mar 2024 18:54:56 +0800
Message-ID: <20240325105456.1338-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit cca98e9f8b5e ("mm: enforce that vmap can't map pages
executable") enforces the W^X protection by not allowing remapping
existing pages as executable. Add riscv bits so that riscv can benefit
the same protection.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---

Hi Palmer,

This patch missed two merge window, I.E 6.8-rc1 and 6.9-rc1,
I'm not sure whether there's something to be done from my side.

Thanks in advance

since v1:
 - rebase on v6.8-rc1
 - collect Reviewed-by and Tested-by tag


 arch/riscv/include/asm/pgtable.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 97fcde30e247..9f8ea0e33eb1 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -593,6 +593,12 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 	return ptep_test_and_clear_young(vma, address, ptep);
 }
 
+#define pgprot_nx pgprot_nx
+static inline pgprot_t pgprot_nx(pgprot_t _prot)
+{
+	return __pgprot(pgprot_val(_prot) & ~_PAGE_EXEC);
+}
+
 #define pgprot_noncached pgprot_noncached
 static inline pgprot_t pgprot_noncached(pgprot_t _prot)
 {
-- 
2.43.0


