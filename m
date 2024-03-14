Return-Path: <linux-kernel+bounces-103466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D63C87BFB7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22FC283C4C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C204771B24;
	Thu, 14 Mar 2024 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrvLywuD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A1171738;
	Thu, 14 Mar 2024 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429456; cv=none; b=iWtkAO3UyPjDoIP1tVeTLCoH6lZYULt5amvyOI2jBxrbPTZUhWwiuwzbe6UDXrpEOXgtwYwzBpi1iSnT2D3J15fDiMRy9MD7iaSKtSWCvq4vBs4fgoTxHywTfxPWoupZK0T8/cyqJ+EBta5XPIAsW/IRyBWcckCJim/+J2DlPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429456; c=relaxed/simple;
	bh=FhmOMqNZWbah0/RhspM9QHHJPs9OQYwnR/APviYefvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlrUFLPA18fVEOz//+GFnk8PHL0pMU6fUW0wBa5O7bqj0mR9eSJlXsmkyn418Bu8WIxR+sqrq9l/HQz7ETFLaWYMDLxCEI0wc4jz+LtzVoLhafzRV+XuiMeh5OVf3oBu4S98ipcTMfaQRuIW8Zghbn0jNPHDn528Cdw0EiyvaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrvLywuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71839C43390;
	Thu, 14 Mar 2024 15:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710429455;
	bh=FhmOMqNZWbah0/RhspM9QHHJPs9OQYwnR/APviYefvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FrvLywuDM/2n2cTmn6OA+qXZViNFe8Rh78EIBwqDZvjtBB14ChvbEn5ATiLTfu7Op
	 JcA2ko1mlUUTXOFk7hEiIgUAdo5f3zCiGv6UJHgwy68Veu8EwARS0BRQceUaLKGY5n
	 paX3JTPYI0C9wNIIob4SkQdlkbeOFTbk2N2vwvhZBh3yEniWB6Bu2vcS+d6NjuE6eC
	 NRpsYN3/VoxHL9XaTuyMKerc9RsfltuxOcRNz1lm9lNyOrOu8RnuIE9TAKO4s5AKjR
	 tT4kkWapmpX1xdlodEdnfbmA6uK/CeI0HbLD1rJWSt9ZpafdygRu12Ub8in2fG8sZR
	 a/Ipwn9FMBhHw==
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
Subject: [PATCH v2] kprobes/x86: Use copy_from_kernel_nofault() to read from unsafe address
Date: Fri, 15 Mar 2024 00:17:30 +0900
Message-Id: <171042945004.154897.2221804961882915806.stgit@devnote2>
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
 Changes in v2:
  - Fix to return NULL if failed to access the address.
---
 arch/x86/kernel/kprobes/core.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index a0ce46c0a2d8..95e4ebe5d514 100644
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
+		return NULL;
+
+	if (is_endbr(insn)) {
 		*on_func_entry = !offset || offset == 4;
 		if (*on_func_entry)
 			offset = 4;


