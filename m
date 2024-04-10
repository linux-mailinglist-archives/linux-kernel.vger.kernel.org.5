Return-Path: <linux-kernel+bounces-138566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B306489F3C4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531CA1F2A634
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC4D15DBC1;
	Wed, 10 Apr 2024 13:13:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5509157A43;
	Wed, 10 Apr 2024 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754797; cv=none; b=aipThA/Q5QAbbpxNFoqFSAGgEK7MDrjpC30HoQ8U1V0GQo52EibpGl7M1ijVAK6GPVKagd9kC1sKbv6hxJPjhUM1/VbU0cvG7+oQ1TtOrCflu0gR1lkg8WfBHAFbpzzwXAN+E6tAF0C118Autgzlwb6dZT6v9bzEbT6F044fPJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754797; c=relaxed/simple;
	bh=q+2ZsW/z1cIJaAuFufmwzxUPgQDmh1sFna8GkV828NI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZWpaxt4y+jfjMkI0dml9L/9ZQct+7QMakr5V70aEBPrm/xZsjQ9weYiPJOb3IYpy7qO3Oy6We15kPVZCSmEYIIR4HRdj1N81nWpAgxG18xeZFAujPdYUgz2aDj827VBH2wVigltY1SPUvICf0/iBTjmMov7NVg0WHhJYMPjXFHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBD5C433F1;
	Wed, 10 Apr 2024 13:13:15 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Select THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
Date: Wed, 10 Apr 2024 21:12:56 +0800
Message-ID: <20240410131256.2165746-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

THP_SWAP has been proven to improve the swap throughput significantly on
x86_64 system according to commit bd4c82c22c367e0 ("mm, THP, swap: delay
splitting THP after swapped out"), on ARM64 system according to commit
d0637c505f8a1d ("arm64: enable THP_SWAP for arm64") and on RISC-V system
according to commit 87f81e66e2e84c7 ("riscv: enable THP_SWAP for RV64").

Enable THP_SWAP for LoongArch, testing the micro-benchmark which is
introduced by commit d0637c505f8a1d ("arm64: enable THP_SWAP for arm64")
shows below numbers on the Loongson-3A5000 board:

swp out bandwidth w/o patch: 1815716 bytes/ms (mean of 10 tests)
swp out bandwidth w/  patch: 3410003 bytes/ms (mean of 10 tests)

Improved by 46.75%!

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d52a95195e7f..41ddc39e1fc8 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -69,6 +69,7 @@ config LOONGARCH
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	select ARCH_WANTS_NO_INSTR
+	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select BUILDTIME_TABLE_SORT
 	select COMMON_CLK
 	select CPU_PM
-- 
2.43.0


