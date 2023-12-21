Return-Path: <linux-kernel+bounces-7917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FA881AF23
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F611C22BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01214CA49;
	Thu, 21 Dec 2023 07:08:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881114F8B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: bizesmtp72t1703142306tblaxfeg
Received: from localhost.localdomain ( [58.240.82.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Dec 2023 15:05:03 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: 90EFqYDyPxDH2HniTLYrCGVM0lzrYT3J1RBkPF9OpvfqEomvd8LqAX4a2tFyP
	xSskE1SPFeB1dab/nMJmmyK4Y9eJfkhfxTN0p1KXoy1nOMYslvqKxIyVlwSEdJqNvOCLDKF
	XgQjKtBH6p+699LlifhZnx/2Idjh20GPiIVkwyMC/YeBMf+kAXAMnlTWMAGy3JthyNUPf4X
	Ft7TWogOJrWFV8LOOodC4XwVZntDYS2OxioYlfK5J/FJ2gHyayBMBSZyYpwv8pqHwalauHu
	JXdc1ul8HXjoERHkBWfjEK+Gnx8f1iQEs/0MrQwSOarrEwGRQYFUSBTCh58CrslSZtFUWVB
	/kU/RXtpsjPVKXkEIjE2v9uqMsUT7k08Os/cDOx
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7023690611978233006
From: Song Shuai <songshuaishuai@tinylab.org>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	andy.chiu@sifive.com,
	greentime.hu@sifive.com,
	conor.dooley@microchip.com,
	guoren@kernel.org,
	songshuaishuai@tinylab.org,
	bjorn@rivosinc.com,
	xiao.w.wang@intel.com,
	heiko@sntech.de,
	ruinland.tsai@sifive.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: vector: Check SR_SD before saving vstate
Date: Thu, 21 Dec 2023 15:04:49 +0800
Message-Id: <20231221070449.1809020-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0

The SD bit summarizes the dirty states of FS, VS, or XS fields,
providing a "fast check" before saving fstate or vstate.

Let __switch_to_vector() check SD bit as __switch_to_fpu() does.

Fixes: 3a2df6323def ("riscv: Add task switch support for vector")
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 arch/riscv/include/asm/vector.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 87aaef656257..d30fa56f67c6 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -190,7 +190,8 @@ static inline void __switch_to_vector(struct task_struct *prev,
 	struct pt_regs *regs;
 
 	regs = task_pt_regs(prev);
-	riscv_v_vstate_save(prev, regs);
+	if (unlikely(regs->status & SR_SD))
+		riscv_v_vstate_save(prev, regs);
 	riscv_v_vstate_restore(next, task_pt_regs(next));
 }
 
-- 
2.20.1


