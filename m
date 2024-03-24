Return-Path: <linux-kernel+bounces-116196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29726889D76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8DD1F36D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537833BB1BD;
	Mon, 25 Mar 2024 03:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doycezXX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A00B17C6D1;
	Sun, 24 Mar 2024 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323803; cv=none; b=trLZ1XVwOavlWm6IMU31X7wi6f+yDXQpiupBUOWgkAnAv97H4t55AdWmzpXkxTQT1exHAKeNS3Jpr6/uBZDU44x3sL7SeWazlMZh0ZzbAfabIHWxHiIXvjA1SY+MNHh3pCU1uDnWZb8b87JKEdd9FbJCjPIvMWjA7BTR+aBwdPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323803; c=relaxed/simple;
	bh=IgTe3n66YGsLtCAM6MmQvEeSa0QRWAfowfES3Es53+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXV/VfLjxjYln0q3+scZcw+NJNs3YKhsNjsHM+J3RUepudkOzg++z3Dls04wChuwE2N4ZkLFri5zR39qSeoWtmCmjWRQHiSciQbt3GzuT185FotrS0I33m2sPz54QqRfE1AWTyScyVmXfswZfqvkFy0XQX08l6i4GV6DDE8QWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doycezXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAC4C433F1;
	Sun, 24 Mar 2024 23:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323802;
	bh=IgTe3n66YGsLtCAM6MmQvEeSa0QRWAfowfES3Es53+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=doycezXXlvmx/NoUt4de8kgO2N5bO/j0LAXjJWP3ZN+QX2ZswWai5PgJjqSk6WymV
	 M9iMSpUO5jjbkNtE8xdAgtBXnn/O+zgqgw2cJbgE/zm1PjH/xdSPepRCANvPT1BBQL
	 yVK8GAp9R2JlfCIhJbnffoMN8pT089w2cwTlel10Tqlj5lP3qrSzywQNhbvhTgJyq8
	 3gxP4/Waec4p/FM+Gn6aokoPJPf3MBKMGdiWMC49tWEGtfxdq883+alom91KD1O8QK
	 JsM7GxqQL/FelSutURlJJH/+S9pzgsipzzkP8S1LNZiRy+y22HN58xHMPi2U+aT40l
	 Vm9O8O3ElSW2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 180/238] powerpc/embedded6xx: Fix no previous prototype for avr_uart_send() etc.
Date: Sun, 24 Mar 2024 19:39:28 -0400
Message-ID: <20240324234027.1354210-181-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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


