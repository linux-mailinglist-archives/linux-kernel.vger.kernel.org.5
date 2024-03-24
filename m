Return-Path: <linux-kernel+bounces-115567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9393F889C79
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC4829F27E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FC22EDFF0;
	Mon, 25 Mar 2024 02:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGJ5NQE8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049C91F23EE;
	Sun, 24 Mar 2024 22:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321106; cv=none; b=Kq1BT4CXa143PxVWnNpAx3qKVChigsKwDQ5DFdjL8Zxpy3GpToPFBxWhb0nIaVSxM6P/gEXFvt3CAjOzoLw0avTb1/RiaTRp/zYAnf3c6/CD+FF+rnKJtXWAaOBbmgx56RhfrTEyMvrEkMB2SI+wDxF5EfVSD1hptwHt8QbKJ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321106; c=relaxed/simple;
	bh=csFAl3hiYJjI5V/7nVcf/rnqXuYN6B7JCluFywskOro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgfHQyjSVbQVrN9E3zcoSEow8jMp5uiohnD1fUSr+Bsoe//OczmW8s4vv4Yxz0lqBdvh4h2mpp/5Isi0D0tdBfkigBMq0ozsr+SCPK+bNnpdyTj8LYgGuhJ8SIcuMY1628RjjwPbgZioB5i9OA2ThtqPv7nOLSQlXmtte/jkbl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGJ5NQE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4CEC433C7;
	Sun, 24 Mar 2024 22:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321105;
	bh=csFAl3hiYJjI5V/7nVcf/rnqXuYN6B7JCluFywskOro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gGJ5NQE8NccwOc4BIvovkVX7UgqCFPWvKAZevwIxPfmYjS/B0MiLXGiBke7/dScx1
	 vLYtx67sYy576j6LheZsY4jJFvhy6SO0e09PGrgDQtTMh77/y6iydDBsgUpFId3Mnn
	 wQ9aBShRNuXIJTmVqNjEKwiiKUJOkSgP/CuAlSNdg2qkXrI4vk65K/6gjRomHcVLWv
	 iD+R2DBWZe98rYjjWCT2FxvnqXf34mUeugGMzEKAfAeD/QPCSU8j1UDowJF3NytFzg
	 OscKmvd1X815UcrTt1joQlcXBSkz/6siuDgRkK5YBaN9bRrHkaO654od4Go1XvKEhe
	 Lsi/0Q3Gr6qFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 668/713] riscv: Fix compilation error with FAST_GUP and rv32
Date: Sun, 24 Mar 2024 18:46:34 -0400
Message-ID: <20240324224720.1345309-669-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 76b131e7bbcad..a66845e31abad 100644
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


