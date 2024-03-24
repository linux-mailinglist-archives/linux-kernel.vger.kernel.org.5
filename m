Return-Path: <linux-kernel+bounces-116289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F36A8895DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916FC1C2E56F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965D23CC1DA;
	Mon, 25 Mar 2024 03:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6t/Vo+w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FBB5D478;
	Sun, 24 Mar 2024 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324147; cv=none; b=uHDBOoCl9RXw0qrIht9DQOc4OUnmKMPbQ4404TfWMcOaJLR3GhauCMugoOxF5h2ERb+IOmFC74Zc6YqA4J/JDLBZK8gHnbLBbuG8FhGEacxWH/I910tuJXilW4kNdhRWRYdN7Sh25FvmD4c+ZKhIkyomP4zMIYSqPv+OkoCdIUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324147; c=relaxed/simple;
	bh=IgTe3n66YGsLtCAM6MmQvEeSa0QRWAfowfES3Es53+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXM2jXmV81yEoJWAvkni+w72AYzaMA3B2GlJ5FqWqlnhl1JtQtLp7fuDzHxmJKbt87dPfzsu2FrK9YSf+WvLjQsY6wJbfc0zSWak9c3tI+AoTqCzDYQDXGCNdR51AkV6WIDt6k/5U2GKZxh/Hd+XNrhqKoAleZlrlKu8ywK0c/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6t/Vo+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B858EC43390;
	Sun, 24 Mar 2024 23:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324147;
	bh=IgTe3n66YGsLtCAM6MmQvEeSa0QRWAfowfES3Es53+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r6t/Vo+wmcpRO6jJ1yvQl0Ynb1YjzM4w7TybMR5SdyBkGB2KBWFjzXfrNedVmqyu2
	 76a77XVPi4OOpUdgM90piOO6XgZtvBj3KF3Ub4gs551RdDWS8gntSvm6ZcbQybYMt9
	 57WDvateeoxoQuedByB1GKffTdyc1Opt/T3c7ovfUijUrAwCUlGmfHKJMkzqc6X9Xa
	 rLiZUXwI9KZZqY+fwMfsCXycDyaBzvLXwXHgiPoH1GIl3NVL0QM7MDY2Im9P49Rgg+
	 Ngy61ivQBB85xOhVyZc96JQGcgZyR8q+Ug2MumVDHYCqrlXus/QKzdw7Tq5VTRb6zv
	 Nk4tKmL+E4UVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 143/183] powerpc/embedded6xx: Fix no previous prototype for avr_uart_send() etc.
Date: Sun, 24 Mar 2024 19:45:56 -0400
Message-ID: <20240324234638.1355609-144-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 20933531be0577cdd782216858c26150dbc7936f ]

Move the prototypes into mpc10x.h which is included by all the relevant
C files, fixes:

  arch/powerpc/platforms/embedded6xx/ls_uart.c:59:6: error: no previous prototype for 'avr_uart_configure'
  arch/powerpc/platforms/embedded6xx/ls_uart.c:82:6: error: no previous prototype for 'avr_uart_send'

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240305123410.3306253-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/embedded6xx/linkstation.c | 3 ---
 arch/powerpc/platforms/embedded6xx/mpc10x.h      | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index f514d5d28cd4f..3f3821eb4c36b 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -97,9 +97,6 @@ static void __init linkstation_init_IRQ(void)
 	mpic_init(mpic);
 }
 
-extern void avr_uart_configure(void);
-extern void avr_uart_send(const char);
-
 static void __noreturn linkstation_restart(char *cmd)
 {
 	local_irq_disable();
diff --git a/arch/powerpc/platforms/embedded6xx/mpc10x.h b/arch/powerpc/platforms/embedded6xx/mpc10x.h
index 5ad12023e5628..ebc258fa4858d 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc10x.h
+++ b/arch/powerpc/platforms/embedded6xx/mpc10x.h
@@ -156,4 +156,7 @@ int mpc10x_disable_store_gathering(struct pci_controller *hose);
 /* For MPC107 boards that use the built-in openpic */
 void mpc10x_set_openpic(void);
 
+void avr_uart_configure(void);
+void avr_uart_send(const char c);
+
 #endif	/* __PPC_KERNEL_MPC10X_H */
-- 
2.43.0


