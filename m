Return-Path: <linux-kernel+bounces-114449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3216E888A87
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEEB28C471
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ADA179669;
	Sun, 24 Mar 2024 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qO7zpYPw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1150A1420A0;
	Sun, 24 Mar 2024 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321870; cv=none; b=BHgpSc7UW6+ctbsWLqYNEJUN0+UVS1T/g7lY7TBDmhCQUBr+mbt5o0G1U5aYtDQGOfCM/6GFHuGnAbkd9zm5kQ8Q21NdPzZbRgmavMSqwg9P+Vh16+UFSAt2qgoSvnVn5Qmj7UfkypfLSAfL8ZRST7EVJheMjgEOaWjc8n2e1Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321870; c=relaxed/simple;
	bh=ELHBAbs1fF3g04g0c/StxuFke/EZ7CLJiWHlfB2oJnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chgN7RBf3WpP8zOC6s7RN7beF/xsbsz3iBmBt+wRaT0hpchKEiN0gQ3g3NvhYNtW4ZAHQcu6qjmXWN5MBZlYm8hOjUF+xQntjt4t26ekK3I3GQWi4a+qurncPOLcEH7CyTCuxypfh82ueNNzc1P3vtGmGbiMAoJeV83TrEIPgZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qO7zpYPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352C7C43390;
	Sun, 24 Mar 2024 23:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321868;
	bh=ELHBAbs1fF3g04g0c/StxuFke/EZ7CLJiWHlfB2oJnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qO7zpYPwLhsajtTLX9YBVPtzZ7dAk4NrOVJUXgsLOw1ZLUcHYko/N0JF3f4dDBOJb
	 QOa1RxYZy8aHwoWIlRzSTmJlQ5GZyP3jpH9eXx5N1LJJjCt3EbO+3/Kadx2JfZ80m4
	 zpgDEvx6/NwURiJO3+GRixlInTiZYpjwzVq3dtjBA7NuNEyaOwIRYN7V/qCDVJLibh
	 4MawjCypE3DPhyh2UPVz0scIGLBEXtctPzQQnhs+ORr/jKHX6n/4QjaMQ7Q+fPMHhq
	 zS7GxmHNKZoKTEMrgUHwps1Cgb++vp8C0OW0U8VyJScCYF9fTvq1tyvfOOHtCNwPTx
	 YFpuUD/aC5dCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 597/638] riscv: Fix compilation error with FAST_GUP and rv32
Date: Sun, 24 Mar 2024 19:00:34 -0400
Message-ID: <20240324230116.1348576-598-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index c00bd5377db9a..2793304bf1b76 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -438,9 +438,11 @@ static inline pte_t pte_mkhuge(pte_t pte)
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


