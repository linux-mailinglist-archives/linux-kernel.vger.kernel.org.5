Return-Path: <linux-kernel+bounces-103463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296B587BFAD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32831F2344D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6F671B4B;
	Thu, 14 Mar 2024 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oack5M/W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF360DDD9;
	Thu, 14 Mar 2024 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429157; cv=none; b=ZqF6NFL5f7lgovwRmzS+TUQcoXQI3CmMF6mzXAucdWqttzPudb9ijrLMwpYVeazb+JbCgz9ZMS/3RM25D5nAvYt+7vKyHFzT+EnHwtzKJFr1xLfyiqrJw4cpmK/3eKcGStPh50vK1PqYw6LEn6c5T++uFd+ckB0ucEmNIT3zV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429157; c=relaxed/simple;
	bh=Sq4BX5nCnQbeNMS1RtfpnrqJt/dcI2CBuZ/qi1DiqU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shQLooQqpLnbFnn+9AhpVdRqK0eA58lknOiS9FyfwtAb6JMchX4hfFtD8JcdLpWC+7O05C6rBwdpSv0uB0bzrk1PjWpTrmhVRxV4gx/Ns2w3iAW3uXqtRQwnB+Fgq3834S1S7tdLB8XeXk4oyP6pPM6aEEkbNP3sFvGE22yfvXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oack5M/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084F6C43390;
	Thu, 14 Mar 2024 15:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710429156;
	bh=Sq4BX5nCnQbeNMS1RtfpnrqJt/dcI2CBuZ/qi1DiqU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oack5M/WdKQ8fmUxvx5L4jrUbRLtqn47gAx6wV+xhim0Uspor2HZgxqimphibTCa7
	 pLmpGC8UgeN8dk3E8ZEvFWeveoXa/qRj5jkAjVzkxOp4+07/6gevbU+YRhD8P6vN/y
	 Emm59/VXoKAwW5xUqFVP4Ioi6HegcNpAh1916FFCvP55ohO+cKuH9F/JeZB7TlQCCp
	 VGzQNf3tRt5gDz3OGI2S0i0jIAmdNaTEyB5dTygjQrmhND6t3/yDfkF3UhgwHjZ3o8
	 Pi9HZSZinVwUEDaDtAJNkhY5WzJcyFO3jRy59CGl2U3Em5gEJkhzuflH3v6MQlXzMI
	 9cvRE2fCcJkNw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Qiang Zhang <zzqq0103.hey@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jinghao Jia <jinghao7@illinois.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	x86@kernel.org
Subject: [PATCH] kprobes/x86: Use copy_from_kernel_nofault() to read from unsafe address
Date: Fri, 15 Mar 2024 00:12:30 +0900
Message-Id: <171042914997.151113.2962249725455796854.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315000753.a448251fce0291e041f76c13@kernel.org>
References: <20240315000753.a448251fce0291e041f76c13@kernel.org>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Read from an unsafe address with copy_from_kernel_nofault() in
arch_adjust_kprobe_addr() because this function is used before checking
the address is in text or not. Syzcaller bot found a bug and reported
the case if user specifies inaccessible data area,
arch_adjust_kprobe_addr() will cause a kernel panic.


Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>
Closes: https://lore.kernel.org/all/CAKHoSAs2rof6vQVBw_Lg_j3QNku0CANZR2qmy4eT7R5Lo8MFbg@mail.gmail.com/
Fixes: cc66bb914578 ("x86/ibt,kprobes: Cure sym+0 equals fentry woes")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index a0ce46c0a2d8..a885eea3bd34 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -335,7 +335,16 @@ static int can_probe(unsigned long paddr)
 kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
 					 bool *on_func_entry)
 {
-	if (is_endbr(*(u32 *)addr)) {
+	u32 insn;
+
+	/*
+	 * Since addr is not guaranteed to be safely accessed yet, use
+	 * copy_from_kernel_nofault() to get the instruction.
+	 */
+	if (copy_from_kernel_nofault(&insn, (void *)addr, sizeof(u32)))
+		return 0;
+
+	if (is_endbr(insn)) {
 		*on_func_entry = !offset || offset == 4;
 		if (*on_func_entry)
 			offset = 4;


