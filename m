Return-Path: <linux-kernel+bounces-86996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A7E86CE0D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B467F1F218A9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48742147768;
	Thu, 29 Feb 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilikQ2Lv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFC314775E;
	Thu, 29 Feb 2024 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221827; cv=none; b=DXoYC3m8IMBVPfRFaUGnErPDCOJfTZPu/r/lAiPEkaKXvpLj3seP+e7NUVYaFWpW/ppae4Dc2ljAbSdn9fb1WFVEW40FVT8+g6sUw7CPbUbVC0HPp1CwL9NmlsWuZuz5tOOeFlem5yJEvmDfYuIbELYON/TUFKBk7oEV5yREdLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221827; c=relaxed/simple;
	bh=6BgAatx297f53qjeaozbUH9QQCAVrbUuVPn8wwTue4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cn0QA6M/3J+BtPO6Dcd7TtgOVn4ctV6BoddQkx/bu5WNnVQSaDZw0+bHNSErSIqdNs4xJMuvYFMIt5syBuXReaedZeepOKDSd0eGXUdnLT8rxdYwrtYz4El7humXx7KtB/jGobKBunjTgjE0Q7IpGg/XrdfBtlGbxnGEwZz8+Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilikQ2Lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CA4C433B1;
	Thu, 29 Feb 2024 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221827;
	bh=6BgAatx297f53qjeaozbUH9QQCAVrbUuVPn8wwTue4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ilikQ2LvAQrOkuAYAuR1KzCDGRUuAc47kxqls35QSKY1k3f+XL9+zvlIJe7iPws5v
	 BV2KVt15pkTd/D+rFtfgsgxzC+oNL0YEyaK8SewRSd3pEXPRCLoKhaAY70JdpyzUiQ
	 Y0sUZ9dXQDnT6mEYRBoNlo0X9zDgY37VK/VGb0iSAY/XxVrUascCg/9fVIiQ77/Q3k
	 5/f5+tGOL2xXY/RJgHXhD7RMhyji9pTtkNOx3FQoF5Iax1sYCmcUi1dw4xEc9k6Kbf
	 9Pr1gyH1LZ909mPtqx6F1E9gF1v/AnHrWS8GNVHlvpm3A9Cm+3hXN4TnKVwCAWzh0r
	 9aRQdXema9wFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	catalin.marinas@arm.com,
	oleg@redhat.com,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 21/21] arm64/sve: Lower the maximum allocation for the SVE ptrace regset
Date: Thu, 29 Feb 2024 10:49:41 -0500
Message-ID: <20240229154946.2850012-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154946.2850012-1-sashal@kernel.org>
References: <20240229154946.2850012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
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
index 8df46f186c64b..9bc2b0c9a4fee 100644
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


