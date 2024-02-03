Return-Path: <linux-kernel+bounces-51041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F58848579
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9617C1C21703
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 12:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663015D90E;
	Sat,  3 Feb 2024 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3jUk3jE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CEE4C7E
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706962676; cv=none; b=jgwfkNj8F0QW0smuFs8sc0ETJMccUesPi6XAuTg6lr4VMNTyyg9m2ctrpD+5ybdnKeBlkpaNyE78SINizG6A99jRbvFEr/apAZ49uu2mdtXpHaJXMpxKDezQ72R+pKfrq417xrnWp+DHUHhvdB9AMWBs6HjCO7+uayewEF6i6k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706962676; c=relaxed/simple;
	bh=vy+gCofdcx6ll8+v76H/qPs2ENfC5pAt7yrvH4goBis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TEzpRB6+0o2+v10iowuhxq8ZpphhA5Yoi/wFQUfUeCyTopwYcOQXwsujTCHiTbNsBbeege0gRrwFbMcXjeldtIgnu6mn0W5kGuXgBSCQrFlciy+J90mqZj4HHxBO6AOESQbVqfLphHThUOa3CHfYJt14b2BcLsQsH7jCaJ3/LNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3jUk3jE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE8FC433F1;
	Sat,  3 Feb 2024 12:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706962676;
	bh=vy+gCofdcx6ll8+v76H/qPs2ENfC5pAt7yrvH4goBis=;
	h=From:Date:Subject:To:Cc:From;
	b=b3jUk3jED00JB4d5ZmPLNOyP7PzXe0rsAAE5eTu1E1dcIA8DWQEKfaAzIrpcaYIIE
	 Tzcg2CQv+SsSHq4iUWMvkbFe/boWL9GKTvOc0oWzq66kpntoQRo+XPHxUptLuWJgXN
	 b/JLuDbLJIDSddt+pUY0qgm74Kz7c/A0H3a4F0FQtQM22d17UtNBLPd1EWk0c/3hU3
	 EUqABCSUNtJTw9E1dniPW1FH1/bAx6ywPv1xn4wcgtqJAenCY46kjcwvoFS5Sa4JjQ
	 PBDNdMkYKYz7F2ByG7ppCfBNXvTMnJwGavjKZLOb9UhnjXjInBr7TCsvHDaQwIJgwX
	 Aeq8kS21P7EyA==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:16:49 +0000
Subject: [PATCH] arm64/sve: Lower the maximum allocation for the SVE ptrace
 regset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-sve-ptrace-regset-size-v1-1-2c3ba1386b9e@kernel.org>
X-B4-Tracking: v=1; b=H4sIALAuvmUC/x3MQQqEMAxG4atI1hNoi4j1KsMsqv5qFjqSiIji3
 S1uHnybd5FBBUZNcZFiF5P/kuE/BXVTWkaw9NkUXChdDiedq5JtB6+bpg6sGA0bm5zg4FsXQx2
 rCE95sSoGOd7993ffDz8dWJRuAAAA
To: Will Deacon <will@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>, Oleg Nesterov <oleg@redhat.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3817; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vy+gCofdcx6ll8+v76H/qPs2ENfC5pAt7yrvH4goBis=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvi7oIzODfqoTowIcCe0ki5UVSh/liF1VN7Wy4MNj
 T8lOzlGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4u6AAKCRAk1otyXVSH0BnmB/
 oCvkdlZlBANeWVDPRv1h2mmoJStN4LjG3Hm7mUn095rc5PRLvvFqaOpOvHst2WtJ3CaFypw2a1hE2G
 0k2PKlQJJqdzA/0wJPun5esVVS11Sy5lIy36KWMiUWVNh1uAJdAuSX30seGw2J3jAzlDCBJ2WmMYkV
 Q8bzdocPTcVjWvhZXk5Nad4lxh47ERNJbaZKW/T2RlYZxaaxXGNqezOlHo+7EkjGvPB9wI86Z4EUX8
 Q/VNbxDkOWYu9YeE0ffzoCnYxL8xivKvwNDoGA4IxFFXVi3/maO35o6DeI1Qu1IS01viFoI4f4eCca
 lQ5ZLbHUqWG5+jdHLabKFzLMMkun9X
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
 arch/arm64/include/asm/fpsimd.h | 10 +++++-----
 arch/arm64/kernel/ptrace.c      |  3 ++-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 50e5f25d3024..cf5f31181bc8 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -62,12 +62,12 @@ static inline void cpacr_restore(unsigned long cpacr)
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
+#define ARCH_SVE_VQ_MAX 16
 #define SME_VQ_MAX	16
 
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


