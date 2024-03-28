Return-Path: <linux-kernel+bounces-122433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC39188F75B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920B41F24C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D214DA15;
	Thu, 28 Mar 2024 05:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtQ40G4U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC4B47A7F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711604367; cv=none; b=tZNMMu2+Hlr0ORFd+lQvkudk4kvrkklciAJ2TEFxiqtC0xN8NEGgWjrqEJys7ygjQeu+seKdYwNyRLeC8MqtHG5f7RYCUHqfqQ0r+62ShJdAGXfF1Vwq44UM7ystAg2DYZVEBysMwogV4anojQFQY4mdHn+E1MW2ELaBmqJSte0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711604367; c=relaxed/simple;
	bh=zF14u9ZN6FPEsFmQUkS2tzuVfrv7E203xtVo9XywqN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FAmfUQlZYFnI+RkrG2zwZut81IfqoLnG2ap4Q83emmMW/bcJGOHr7wMPDrxcxFir1+/opmxxcxJ+za/Vn9LGcaAqNdILzuXlw7TE6e1vQkn2EpWreoWOJrpQ1DNFf9XYt60iOw1y4BojVV3JAlJhrHV6VKdgt+mKxTI6SMlrPwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtQ40G4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB83C433F1;
	Thu, 28 Mar 2024 05:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711604367;
	bh=zF14u9ZN6FPEsFmQUkS2tzuVfrv7E203xtVo9XywqN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DtQ40G4UJfjy9f+NdwreIgdjjpg9ESObFxGohzU/XPu9wcKDbfUUfbUp/fr1SsoAW
	 YlHON/WFyH2ZmX99LI4k5gizNA1hbtNI3435VBeSjcQptREcyacH1RMiYrtBDI2enW
	 8Q6OvI0Xpd6oyOUOz3n3ZuaFJpo2eM4UUBAsWWSUF3wy5anLzHCmvL24n7BK0CarJw
	 g7dyebwap6MxsjcaZ1wH+Ea35rhvTenTPKmm33Fyf9iOtz1Y9t/uILD7OHe45Em04G
	 LxTqmZ5wjQ8QcEgYQB0BN0+44udKOqeHSr8iK7ByTqrsE4PAqpdDeJ4lZl9X8vYq7f
	 NkPnPtKmKAVIA==
From: Vineet Gupta <vgupta@kernel.org>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Vineet Gupta <vgupta@kernel.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH 1/2] ARC: Fix -Wmissing-prototypes warnings
Date: Wed, 27 Mar 2024 22:39:18 -0700
Message-Id: <20240328053919.992821-2-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328053919.992821-1-vgupta@kernel.org>
References: <20240328053919.992821-1-vgupta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

| ../arch/arc/kernel/kprobes.c:193:15: warning: no previous prototype for 'arc_kprobe_handler' [-Wmissing-prototypes]
|  193 | int __kprobes arc_kprobe_handler(unsigned long addr, struct pt_regs *regs)
|
|../arch/arc/kernel/ptrace.c:342:16: warning: no previous prototype for 'syscall_trace_enter' [-Wmissing-prototypes]
|  342 | asmlinkage int syscall_trace_enter(struct pt_regs *regs)

Link: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240325/testrun/23149630/suite/build/test/gcc-9-defconfig/log
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/ptrace.h | 2 +-
 arch/arc/kernel/kprobes.c     | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arc/include/asm/ptrace.h b/arch/arc/include/asm/ptrace.h
index 00b9318e551e..cf79df0b2570 100644
--- a/arch/arc/include/asm/ptrace.h
+++ b/arch/arc/include/asm/ptrace.h
@@ -169,7 +169,7 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
 	return *(unsigned long *)((unsigned long)regs + offset);
 }
 
-extern int syscall_trace_entry(struct pt_regs *);
+extern int syscall_trace_enter(struct pt_regs *);
 extern void syscall_trace_exit(struct pt_regs *);
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/arc/kernel/kprobes.c b/arch/arc/kernel/kprobes.c
index e71d64119d71..f8e2960832d9 100644
--- a/arch/arc/kernel/kprobes.c
+++ b/arch/arc/kernel/kprobes.c
@@ -190,7 +190,8 @@ static void __kprobes setup_singlestep(struct kprobe *p, struct pt_regs *regs)
 	}
 }
 
-int __kprobes arc_kprobe_handler(unsigned long addr, struct pt_regs *regs)
+static int
+__kprobes arc_kprobe_handler(unsigned long addr, struct pt_regs *regs)
 {
 	struct kprobe *p;
 	struct kprobe_ctlblk *kcb;
@@ -241,8 +242,8 @@ int __kprobes arc_kprobe_handler(unsigned long addr, struct pt_regs *regs)
 	return 0;
 }
 
-static int __kprobes arc_post_kprobe_handler(unsigned long addr,
-					 struct pt_regs *regs)
+static int
+__kprobes arc_post_kprobe_handler(unsigned long addr, struct pt_regs *regs)
 {
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-- 
2.34.1


