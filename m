Return-Path: <linux-kernel+bounces-125655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD24F892A39
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BFC1F221CA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274162BB0A;
	Sat, 30 Mar 2024 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMzKNsWc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D12200DA;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792677; cv=none; b=uMpLqWXCLVtz4fQaIvlNM2Ofhp/wV5QAciXitAUA4I2TGy9PZH+qNRclpGsAfAlGCdmuqdyy3i8yqnH4KHLoDBVjQpeD6aBkJn1mcR8HxAaxnLkLa/GVhMNZ7z93uN+CHsyf3gG+ozltxhGYpwzGtzrsg0/jbyvnOYD2+X5z600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792677; c=relaxed/simple;
	bh=T3eeH+zoBspeTvtzab9Ckmy0OMDrNqIq1L29N8s6Q9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gjnJ4LRjW2v+xMTfEaQ8L+N/8iT+dpdwC+q6yYTExMnBku0lG90y4KKh6a1TMZWeogzt/nxuQeq/SbxVfA8sb6+B7PphidGD6YXznkem8WYaAgNa48FA9JYm5ZiGkA7xijN6vgvo3Q6AbTnhdymMeB/NFnE0M8NQPw/7/hvohVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMzKNsWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14627C433B1;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711792677;
	bh=T3eeH+zoBspeTvtzab9Ckmy0OMDrNqIq1L29N8s6Q9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FMzKNsWcXILkg9NWP1RWTaH1sDIfOWEVXCZqyKVhJyGNJeV5I9ntBz8pNirUMV+rw
	 7+yP/7PGQSHFc4wEaM1maodIVNi5iSUBTvsmhaHdKR3vu+WFeU3C7uTQW+e9KbolUs
	 6NqlLfB4XuyYsFeIe8wV1J12hfpgjlz7YB8e1o0Fzw2NKHn7+W0/SB/Hh9AI+Sh5Dx
	 jUE0ac0twcHgKNx1yZC8vQOKuUKihoQFmUtjSFT+zKhMS8R0FNYqjKnQnzYJyc5xAr
	 4/hgpNgeZQGLZNffUGVPlAAAFnhTH60fP9KSdwnTAAoHRFnqKey4f9AsZ+z4Ge8LlP
	 ouHMS1W257asw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB3DCD1291;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 30 Mar 2024 10:57:41 +0100
Subject: [PATCH 05/10] sparc64: Fix prototype warning for uprobe_trap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240330-sparc64-warnings-v1-5-37201023ee2f@ravnborg.org>
References: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
In-Reply-To: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
To: Andreas Larsson <andreas@gaisler.com>, 
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711792675; l=1615;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=sf6irUkOpJPOHLMvdHazAyqgENdDMFjW8tXTw6Ir0YU=;
 b=Gfn8FAdb7ELFmL9Xcub36vvtnz7E7OCSYIXAo8fV5xyY4x0+njqdmCR+uM9iEVVY8///Z73EpFA4
 RPXfaePaAJcWQc+Vj5Y6mTgZtSJLBCRZRV1jUnnsJYbTcN+SmQ1Y
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with
 auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: sam@ravnborg.org

From: Sam Ravnborg <sam@ravnborg.org>

Fix the following warning:
arch/sparc/kernel/uprobes.c:237:17: warning: no previous prototype for ‘uprobe_trap’

Add a prototype to kernel/kernel.h to silence the warning.
This is a fix already used for other trap handlers.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/kernel/kernel.h  | 4 ++++
 arch/sparc/kernel/uprobes.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index a8fb7c0bf053..8328a3b78a44 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -40,6 +40,10 @@ int handle_popc(u32 insn, struct pt_regs *regs);
 void handle_lddfmna(struct pt_regs *regs, unsigned long sfar, unsigned long sfsr);
 void handle_stdfmna(struct pt_regs *regs, unsigned long sfar, unsigned long sfsr);
 
+/* uprobes.c */
+asmlinkage void uprobe_trap(struct pt_regs *regs,
+			    unsigned long trap_level);
+
 /* smp_64.c */
 void __irq_entry smp_call_function_client(int irq, struct pt_regs *regs);
 void __irq_entry smp_call_function_single_client(int irq, struct pt_regs *regs);
diff --git a/arch/sparc/kernel/uprobes.c b/arch/sparc/kernel/uprobes.c
index 1a0600206bf5..305017bec164 100644
--- a/arch/sparc/kernel/uprobes.c
+++ b/arch/sparc/kernel/uprobes.c
@@ -18,6 +18,8 @@
 
 #include <asm/cacheflush.h>
 
+#include "kernel.h"
+
 /* Compute the address of the breakpoint instruction and return it.
  *
  * Note that uprobe_get_swbp_addr is defined as a weak symbol in

-- 
2.34.1



