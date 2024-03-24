Return-Path: <linux-kernel+bounces-115523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78427889413
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32ABD2942C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5290923E428;
	Mon, 25 Mar 2024 02:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/RNymGR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402991494C9;
	Sun, 24 Mar 2024 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320975; cv=none; b=MCOV1bXpYMyW5wqEuZ6tr5sO6MbkvbtHq2H5Kbs9oSlu/gMBIA5k+ix5fhnorGyfAvTI3Q5p45NBQx4i3Q63PnRqp2pz0oRbtliLJNlfprQxiWYatew5rAYRGAc7vGb86aO94ndR6ixo490p/AC++pfob9K2CDro9m/+7aLguLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320975; c=relaxed/simple;
	bh=BVxqDOGkjiqVTfeT64Ga21KsBYVD4zSSNx+FiG8WTA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYq+hKoJ0i9EnFB8jWnsWqxQTQRrD38g93oXpFTBfc7l4KyESg4HHW22lzXhGg+9Bnl1LoC9XI1ER/o6HZEAvJdhqHGJEPiOKsZqQfe+B9/WiTVcJPoqyehZWX4pDPwacdyGTSBtQoSmxc10jqBLOixjnHNnk6fQfT7oFKU84PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/RNymGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BCDC433C7;
	Sun, 24 Mar 2024 22:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320975;
	bh=BVxqDOGkjiqVTfeT64Ga21KsBYVD4zSSNx+FiG8WTA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O/RNymGRjEe9zCrwC2qK/AzHRc36hMRvh3zL8dnFg8hW9Mb6OnJ6Cl0VUIg0ydnIT
	 YbIs6TNMR6XkGzQVtU1L1q+ZVKRx1JKcyLH0clDsgkaTgFXWm+BFndNf4x0yZeTjzw
	 iDSxKs8zXV81tJ5wrfzjjzQhliBFafRU9rnQHlA1JrDxwuG/jSrH6WRvmt6Jwq/Lr5
	 +tJL4GuweOK7YTKx4uYnvfINcxotZ0anv4mFcUhO1cdTggxgxhpGDqzeY42JBxDej2
	 K4w+GDxKYJ9KAGmd/dp2OQRVLlE5w3CQ+XW/gGqc1RvnDW/9FTrrPiJST5Ld0uTNN8
	 jk74jsDBkPsYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 538/713] powerpc/embedded6xx: Fix no previous prototype for avr_uart_send() etc.
Date: Sun, 24 Mar 2024 18:44:24 -0400
Message-ID: <20240324224720.1345309-539-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 9c10aac40c7b1..e265f026eee2a 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -99,9 +99,6 @@ static void __init linkstation_init_IRQ(void)
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


