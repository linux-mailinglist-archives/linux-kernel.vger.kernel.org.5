Return-Path: <linux-kernel+bounces-113559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D85388854B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9672CB2317E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BBE1C5AB8;
	Sun, 24 Mar 2024 22:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl0oYw0y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF921C4B04;
	Sun, 24 Mar 2024 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320361; cv=none; b=qETOlOtPc7qtNMNfIvvL7FbrL/jnLeCPt9EAS2UkNKSHezp886FD9nJZ6Nf4YWTCNUUSfbnKI7WwFFcBopn8xZO3VVDWYRInWPK/+DkCw1eWRdXm9kEfBhQIjiyPhpCp/IsBpFUdvHKtpwOYIj4TFRxbntHKOLueU/oV4Vee2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320361; c=relaxed/simple;
	bh=QSd/rPvy0AGEzL/3UhUypo+X8oPGOL0/YBA1xIlL6MU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slb45JASWoX6jI5U24I86Ifu3+cERKEJW+Tu8ZKxvFxOc6MpQHZlD+DlKVXNu9GWIrOA13tY2w+vfp0DykWMm7WiACVugIhTokFrOEqHSUVVxYsyC2bzfFTf2AX0R54xZa/S2DKY5j/a4tdFvN/sGqOh8rVyWnIjY+JrMlbSDbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hl0oYw0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97A7C43399;
	Sun, 24 Mar 2024 22:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320361;
	bh=QSd/rPvy0AGEzL/3UhUypo+X8oPGOL0/YBA1xIlL6MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hl0oYw0yci4LODvOZjXXvGiRY9sxToGfxKiq5yeBHPbkqmpR11rgRMyNccap0djpV
	 TdB5HnK/hDmyh8QRNtLnYv4O+hY86f+Yfgk4lkrhKrTRDJ5fBat6TuySQynNljVle8
	 EQoVIcq9lmxb/gvjlHWEwH2Cac2Rw1fCo5FbbNaS48nrGNPiLnbEPT8DR26XnwErxO
	 5p9rsdkvyU17L2ynayZTDFRbp7omS+wp7gDdrxbkcRoHZYCgvNdU9nof8F/8wXP3Sj
	 hb1qN0T+0sKrPTUGNLl+K9wxLs64EpXpFniq+hqWajmXQnnCvzGMAH7S9zMhNYzLgM
	 4jwT64EXFr6Lg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 668/715] riscv: Fix compilation error with FAST_GUP and rv32
Date: Sun, 24 Mar 2024 18:34:07 -0400
Message-ID: <20240324223455.1342824-669-sashal@kernel.org>
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

From: Alexandre Ghiti <alexghiti@rivosinc.com>

[ Upstream commit 2bb7e0c49302feec1c2f777bbfe8726169986ed8 ]

By surrounding the definition of pte_leaf_size() with a ifdef napot as
it should have been.

Fixes: e0fe5ab4192c ("riscv: Fix pte_leaf_size() for NAPOT")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Link: https://lore.kernel.org/r/20240304080247.387710-1-alexghiti@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 6066822e7396f..3422ced8a07fd 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -439,9 +439,11 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return pte;
 }
 
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
 #define pte_leaf_size(pte)	(pte_napot(pte) ?				\
 					napot_cont_size(napot_cont_order(pte)) :\
 					PAGE_SIZE)
+#endif
 
 #ifdef CONFIG_NUMA_BALANCING
 /*
-- 
2.43.0


