Return-Path: <linux-kernel+bounces-26887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD26582E762
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307DD1F2205F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BF2358AC;
	Tue, 16 Jan 2024 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9EXW2fa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C5835884;
	Tue, 16 Jan 2024 01:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EE5C433C7;
	Tue, 16 Jan 2024 01:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367304;
	bh=WQRFE7obRikoh+urB4RAi+YwuDaWNuZq71lZUINQMuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l9EXW2fa57+pwVSD82uOsxSCu6aX4rmWVRXiX3Ia6GdMGfvHCLz1wvPwmtKEqQw9Z
	 Qv10Toi7IKTfi1uZMYsM8/tdoXuxUfblg6aZ8V64zdeBBCbkYpyMRdb79t7Z4Qx3f4
	 jo/gXHA8/WNjvXBwWf3JUNOmtpBykBuMyL2eVIQg1HqgwKBX5PJC0pD4qVC7m4Fmaw
	 Nt2jlYGj6TWylSlOHxCTIEMP/olS8mrdsELSrosmc7IWpCQ/K+H1k43w2uEscpT/v2
	 UblCaqhYyFuF9TEDqLMgcHrQXmYs8rtAg2U79/lXbnEvffDWc84dW6zfOvEInZy1wx
	 WrFdTfAM9RWkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	oleg@redhat.com,
	gor@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/9] s390/ptrace: handle setting of fpc register correctly
Date: Mon, 15 Jan 2024 20:08:08 -0500
Message-ID: <20240116010819.219701-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010819.219701-1-sashal@kernel.org>
References: <20240116010819.219701-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 8b13601d19c541158a6e18b278c00ba69ae37829 ]

If the content of the floating point control (fpc) register of a traced
process is modified with the ptrace interface the new value is tested for
validity by temporarily loading it into the fpc register.

This may lead to corruption of the fpc register of the tracing process:
if an interrupt happens while the value is temporarily loaded into the
fpc register, and within interrupt context floating point or vector
registers are used, the current fp/vx registers are saved with
save_fpu_regs() assuming they belong to user space and will be loaded into
fp/vx registers when returning to user space.

test_fp_ctl() restores the original user space fpc register value, however
it will be discarded, when returning to user space.

In result the tracer will incorrectly continue to run with the value that
was supposed to be used for the traced process.

Fix this by saving fpu register contents with save_fpu_regs() before using
test_fp_ctl().

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/ptrace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 34ca344039bb..05e1367c23d5 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -413,6 +413,7 @@ static int __poke_user(struct task_struct *child, addr_t addr, addr_t data)
 		/*
 		 * floating point control reg. is in the thread structure
 		 */
+		save_fpu_regs();
 		if ((unsigned int) data != 0 ||
 		    test_fp_ctl(data >> (BITS_PER_LONG - 32)))
 			return -EINVAL;
@@ -773,6 +774,7 @@ static int __poke_user_compat(struct task_struct *child,
 		/*
 		 * floating point control reg. is in the thread structure
 		 */
+		save_fpu_regs();
 		if (test_fp_ctl(tmp))
 			return -EINVAL;
 		child->thread.fpu.fpc = data;
@@ -1006,9 +1008,7 @@ static int s390_fpregs_set(struct task_struct *target,
 	int rc = 0;
 	freg_t fprs[__NUM_FPRS];
 
-	if (target == current)
-		save_fpu_regs();
-
+	save_fpu_regs();
 	if (MACHINE_HAS_VX)
 		convert_vx_to_fp(fprs, target->thread.fpu.vxrs);
 	else
-- 
2.43.0


