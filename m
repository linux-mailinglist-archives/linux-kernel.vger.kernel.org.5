Return-Path: <linux-kernel+bounces-64076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E778539DA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8EB1C226C6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6443C60B8D;
	Tue, 13 Feb 2024 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC9BhcIQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B76088C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848684; cv=none; b=cWWPxT201/W52RPtEaX/b1UfkAP1aP2WYeVU/1H02HE2+Eyc4kD7Sfpt13SPtgPvn9NfZj0C3Xx4oldqnc/XP3eNoV5ILVjr6aMSGERHVg5dNgLcbMPPYWRvXN+apI/X0DIncs0CvovjiiAT95gMwhGpFECKuDgeFvn8yyKBj5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848684; c=relaxed/simple;
	bh=I5zIgI+QjhRatSLfoEbbhZ6aVR0T34jHoAcGOwHYwms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z9Gxm8TWblX8cNnmL8PEnCbL9T6lRw0HxvyOq4cSn+Jo5KACX0hPRtrj726psAK4cFCl40vgZuP55aVwlIktP3x8Zckxyeu9y+EV7fNKUKsl4mfKwy/3oBccTFk2dpMHOn0+Ew0gmc9zWHmSDTFBa57ZzCeP6VcmXAAVLeKc+qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC9BhcIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448DFC43390;
	Tue, 13 Feb 2024 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707848684;
	bh=I5zIgI+QjhRatSLfoEbbhZ6aVR0T34jHoAcGOwHYwms=;
	h=From:Date:Subject:To:Cc:From;
	b=HC9BhcIQ+NObwtf5QsVwZyOrTCF+0RQYLbPCWl0k9nK7j7t1qrSVZFxsRE8C2f6OS
	 V3f/Zg84eOx4aCvJov0C5MVIfkY7puH4t/vHlN0LMwuWhNjiLfa7cD/6VG87rHz9sA
	 Qf3PS0At/k2vVwP1bQQE/1T0JstsiU8bQuFaDj9sj3GnB/LAmPm5tN+cFRLX/MrEyv
	 xiOwTazzt73c0aYEctze2VCyEoSDoXEs6Sp17QUpMFMf9kWa/JZ26bIYFfIDPc32rt
	 FlunKZo+2u6/xnHFHQU/m3NDxU41KfZOzyVLqPaPKd06h6iE1tBPVtUKgMSLDdVpYW
	 h1EGSyDiiAU1Q==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 13 Feb 2024 18:24:38 +0000
Subject: [PATCH v2] arm64/sve: Lower the maximum allocation for the SVE
 ptrace regset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-arm64-sve-ptrace-regset-size-v2-1-c7600ca74b9b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOWzy2UC/33NQQ6CMBCF4auQWTuGFkKoK+9hWBR8QqMCmSGNS
 ri71cStm0n+WXxvJYUEKB2ylQQxaJjGFHaXUTf4sQeHc2qyuS3zdNjLvSpZI3hexHdgQa9YWMM
 LbE2bO1u7ysFQImbBJTy+/KlJPQRdJnl+16L5fH9w8R+Ohg3brmi9KeqqdTheISNu+0l6arZte
 wOGU3DsyQAAAA==
To: Will Deacon <will@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>, Oleg Nesterov <oleg@redhat.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4370; i=broonie@kernel.org;
 h=from:subject:message-id; bh=I5zIgI+QjhRatSLfoEbbhZ6aVR0T34jHoAcGOwHYwms=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBly7PpI4cciiXeYNP+EEVt3Y4INFoiOrI/rWmsp/ke
 3UYsdwKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZcuz6QAKCRAk1otyXVSH0ELxB/
 4/7F5im0GANZp1+aO+MD+khEacxi3g7TQuULUlLOSRa1Bojd1b3COou7f4YXUN0PfA2Nms6UDEGtse
 z0+0djdKCZS0xxNiE66INGT3SPlZh1evAmLNIvEgTT6FR02VAoUNj1XP8q2tF3x/eBqtUvtCt4oQjd
 95JbNESua5OhDTwmbZ070bPLFi8LMylPmQLDy8xPyl0EVM6M+KykV4jnFDfXUJdycE43Ej6sEJy2J0
 OmLwCoRvrSzdNxk5M5/NNRpx9XjC77PdNpBbFLP6WfmN7Ik+5ZhX0F+Xjftj/wmm3MVNIAR02LAAOL
 KGimltgZ7MekxKVaCrCD6dd2SL+ZQF
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

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
---
We should probably also use the actual architectural limit for the
bitmasks we use in the VL enumeration code, though that's both a little
bit more involved and less immediately a problem.
---
Changes in v2:
- Specify the value using the size of the bitfield it goes into.
- Link to v1: https://lore.kernel.org/r/20240203-arm64-sve-ptrace-regset-size-v1-1-2c3ba1386b9e@kernel.org
---
 arch/arm64/include/asm/fpsimd.h | 12 ++++++------
 arch/arm64/kernel/ptrace.c      |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 50e5f25d3024..481d94416d69 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -62,13 +62,13 @@ static inline void cpacr_restore(unsigned long cpacr)
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
index dc6cf0e37194..e3bef38fc2e2 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1500,7 +1500,8 @@ static const struct user_regset aarch64_regsets[] = {
 #ifdef CONFIG_ARM64_SVE
 	[REGSET_SVE] = { /* Scalable Vector Extension */
 		.core_note_type = NT_ARM_SVE,
-		.n = DIV_ROUND_UP(SVE_PT_SIZE(SVE_VQ_MAX, SVE_PT_REGS_SVE),
+		.n = DIV_ROUND_UP(SVE_PT_SIZE(ARCH_SVE_VQ_MAX,
+					      SVE_PT_REGS_SVE),
 				  SVE_VQ_BYTES),
 		.size = SVE_VQ_BYTES,
 		.align = SVE_VQ_BYTES,

---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20240202-arm64-sve-ptrace-regset-size-21b0928969e1

Best regards,
-- 
Mark Brown <broonie@kernel.org>


