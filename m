Return-Path: <linux-kernel+bounces-114010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59268888F06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBBDD1F31637
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF08E14831E;
	Sun, 24 Mar 2024 23:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiSxFimE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B661E5F79;
	Sun, 24 Mar 2024 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321299; cv=none; b=BXw8tWsi5A59ajoDQQ/LkxhfGkMBDOYdh1P/LTgqh3qfjf/l9hE6M0tJKTcroBD4EpIeoFnlzctX+gN5W1k6nU+/jkwloZGN6KtRGAudo67QXGSuMz2ypmx/6nB37CMreWY9ZGv5Sa4UPOFr2XeIHV7KAy8+uAVICh2LnLE0yTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321299; c=relaxed/simple;
	bh=OutfAaxHplxN/6QYJB+BYOmAYda3+2Wj95CgSbf2Z1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtwKDdEAhI7Mj7YxvhlKvY+1o1Z18wuSyzxyr60VMitRn2nd0v3TJQY3K7FuINFaDinRRFKe/kGFVZw/cPa03lxeez0oIP1+I9nzl9pHk4vUqNd0Oa/rFyAuHJOb32QWuoFOmWPJKlb4opDOj0igfKNpab8Zbxv+btDQ802f7ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiSxFimE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1C7C433F1;
	Sun, 24 Mar 2024 23:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321297;
	bh=OutfAaxHplxN/6QYJB+BYOmAYda3+2Wj95CgSbf2Z1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oiSxFimE7PlITkUW3jxIL/Da4Jp0ZlQpxprJSC//1HbGe2LxYRtthEVytc2+Wi/+1
	 ZoO2ktxC1f3wG9dzKXQhGGZvGiyzlMA7WO5ch7R88g9Xp27Qdp6ZohlUX3cPYha7p3
	 C3PCKENd4Uv4QBe4JxSeoKuHNkkkdTK8pucDdkFD8LV3k5beIC961FnbtoysoSVhDR
	 Qjx4AoJTcJCKyT8CAIYftcdwV0q2A3gAM6d84iz4l04z3fpFir2rY6HUsh7NWCPIJT
	 YaryaFy2BxkLFhfjkkRpITw+eqTVmsv/MwVfOA6WVSsqMPb7QwqcAFJS2XJsIZ2Ia7
	 uKnL0Vp3AJKXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 020/638] arm64/sve: Lower the maximum allocation for the SVE ptrace regset
Date: Sun, 24 Mar 2024 18:50:57 -0400
Message-ID: <20240324230116.1348576-21-sashal@kernel.org>
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

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 2813926261e436d33bc74486b51cce60b76edf78 ]

Doug Anderson observed that ChromeOS crashes are being reported which
include failing allocations of order 7 during core dumps due to ptrace
allocating storage for regsets:

  chrome: page allocation failure: order:7,
          mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
          nodemask=(null),cpuset=urgent,mems_allowed=0
   ...
  regset_get_alloc+0x1c/0x28
  elf_core_dump+0x3d8/0xd8c
  do_coredump+0xeb8/0x1378

with further investigation showing that this is:

   [   66.957385] DOUG: Allocating 279584 bytes

which is the maximum size of the SVE regset. As Doug observes it is not
entirely surprising that such a large allocation of contiguous memory might
fail on a long running system.

The SVE regset is currently sized to hold SVE registers with a VQ of
SVE_VQ_MAX which is 512, substantially more than the architectural maximum
of 16 which we might see even in a system emulating the limits of the
architecture. Since we don't expose the size we tell the regset core
externally let's define ARCH_SVE_VQ_MAX with the actual architectural
maximum and use that for the regset, we'll still overallocate most of the
time but much less so which will be helpful even if the core is fixed to
not require contiguous allocations.

Specify ARCH_SVE_VQ_MAX in terms of the maximum value that can be written
into ZCR_ELx.LEN (where this is set in the hardware). For consistency
update the maximum SME vector length to be specified in the same style
while we are at it.

We could also teach the ptrace core about runtime discoverable regset sizes
but that would be a more invasive change and this is being observed in
practical systems.

Reported-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20240213-arm64-sve-ptrace-regset-size-v2-1-c7600ca74b9b@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h | 12 ++++++------
 arch/arm64/kernel/ptrace.c      |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index b54506d707380..7415c63b41874 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -36,13 +36,13 @@
  * When we defined the maximum SVE vector length we defined the ABI so
  * that the maximum vector length included all the reserved for future
  * expansion bits in ZCR rather than those just currently defined by
- * the architecture. While SME follows a similar pattern the fact that
- * it includes a square matrix means that any allocations that attempt
- * to cover the maximum potential vector length (such as happen with
- * the regset used for ptrace) end up being extremely large. Define
- * the much lower actual limit for use in such situations.
+ * the architecture.  Using this length to allocate worst size buffers
+ * results in excessively large allocations, and this effect is even
+ * more pronounced for SME due to ZA.  Define more suitable VLs for
+ * these situations.
  */
-#define SME_VQ_MAX	16
+#define ARCH_SVE_VQ_MAX ((ZCR_ELx_LEN_MASK >> ZCR_ELx_LEN_SHIFT) + 1)
+#define SME_VQ_MAX	((SMCR_ELx_LEN_MASK >> SMCR_ELx_LEN_SHIFT) + 1)
 
 struct task_struct;
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index b3f64144b5cd9..c94c0f8c9a737 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1499,7 +1499,8 @@ static const struct user_regset aarch64_regsets[] = {
 #ifdef CONFIG_ARM64_SVE
 	[REGSET_SVE] = { /* Scalable Vector Extension */
 		.core_note_type = NT_ARM_SVE,
-		.n = DIV_ROUND_UP(SVE_PT_SIZE(SVE_VQ_MAX, SVE_PT_REGS_SVE),
+		.n = DIV_ROUND_UP(SVE_PT_SIZE(ARCH_SVE_VQ_MAX,
+					      SVE_PT_REGS_SVE),
 				  SVE_VQ_BYTES),
 		.size = SVE_VQ_BYTES,
 		.align = SVE_VQ_BYTES,
-- 
2.43.0


