Return-Path: <linux-kernel+bounces-38798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAE783C621
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E66F4B239FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337A26EB4A;
	Thu, 25 Jan 2024 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ij1pUEAQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3CF6E2C9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195455; cv=none; b=YB4C3RzlHwka7FdbgObfuvkKLXH1KyO3uOyGxaRpm0qa9zKejovjRVlUOFq+39TeMnblrNvigTF7jtLp7CaT8IDJE6qQHrkdfPCfIZRaRvXYN+5tBDv/jK3SB5I2hQ77jYxNdOzlfVLTepyDRn6JDxZka0cx0W9zQ1sY2oste7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195455; c=relaxed/simple;
	bh=aiagvA75HtW5poT6xWiLeVnkWkTmbI5Tbf6wRBi0vHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Os1aHSOYUIuhz1ooiWkK0vby/xkB80fuGorsktWd791fNgTYqYyznQYyO7B8vOXphIIWTHxdOdrB83I4NAk0ac2Pv5127/eQWMEdqVaJLvs+gQ2BD+mMa0MN82UTDFmG3vGyt2Amo+upoDyl1lTOxe1H+J0fZ9DxloO+nf2o5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ij1pUEAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3394CC433C7;
	Thu, 25 Jan 2024 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706195455;
	bh=aiagvA75HtW5poT6xWiLeVnkWkTmbI5Tbf6wRBi0vHw=;
	h=From:To:Cc:Subject:Date:From;
	b=Ij1pUEAQqNLvjJQFRqvQCVYs/CBS9MkCzvkpTxre4q0x05oixWvMoB4acBW5xjCxU
	 rWNbwMb04w6sj36leFQHmm9IYNesSR8Hs8/3EvGy7ZWf61z0/i/7NcJZSGXlvUFlpZ
	 EM52ul/U0h7BqugeRktj6OFfeflFxBN/4oqNrBAjFMQcibapWIdttHHPl9IVz+TPO/
	 bAOXsB2FescT/oFQWxOZ5Ee7U9ZUgTHFqOes+UrO+2XFBRocCW2RUxHt9P3SkTJkYy
	 1rr5HnEdhdU0OK/p8PbpvLFCSdnzuYMT25ou4uslnTTA7t8d7iQi1+Zfv1wRDeUQHp
	 QDOJ+f4e+y4aA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2] riscv: mm: implement pgprot_nx
Date: Thu, 25 Jan 2024 22:58:06 +0800
Message-ID: <20240125145806.933-1-jszhang@kernel.org>
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
since v1:
 - rebase on v6.8-rc1
 - collect Reviewed-by and Tested-by tag

 arch/riscv/include/asm/pgtable.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 0c94260b5d0c..c931863bbd1a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -591,6 +591,12 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
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


