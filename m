Return-Path: <linux-kernel+bounces-114882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E683889279
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D2D1F2EE73
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6262CCB95;
	Mon, 25 Mar 2024 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OesXNjn1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28F6178225;
	Sun, 24 Mar 2024 23:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323533; cv=none; b=cXCIyzl23TPU9RJSdKbttReS97xx2RiPBIODPGjns7ZjtiH5DXdWivy6Nxm9sXUTFBLD2X5pg7NOm82i0YtMVUx7EThY8Z5+C4kSf9WzEJesQOdytAyHUxqVDvui43rMcNvQB7VT1MgwDkPht85hxN+17li/EDksX7okzIdQop8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323533; c=relaxed/simple;
	bh=pMdHfEJPF4luFhRiGcb1AzhESd99fBwnet8Jpx1Fw9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8kUAg2a9yoC8cXMcYRV2hWOOWTeHX0hTDAfJ9qznJyX11vEt380FhHaQBXx/srg5Lva1W7rYple29Zu6UnXWP5er6EzzdUfmIITVlEs0hlEitSe4Jss/Z7pt/XFIprJ4D8kTMtOzS7xu+k2fArpbTch2QImCzQi+BA3k+fl3vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OesXNjn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265B4C43390;
	Sun, 24 Mar 2024 23:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323532;
	bh=pMdHfEJPF4luFhRiGcb1AzhESd99fBwnet8Jpx1Fw9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OesXNjn19nHAyVxWZZNi9juK5Q+5/k+8w7P8d+xOH8upjR7kzENqeOupyLv2ObL3N
	 9ZJfYoCz+iCbG7lqyHmSPABEAfM344SiPiSMiCY/3dJHm0DQJYjBo4RHX4fPa5VHYU
	 z54wSos05d41iu3H38hQnAGW5L03MmWPPTiUTI15QL88wy+KJ8ejbNsniMifdREwt3
	 RM0c+siVSHA1P9ea4/y5TsMYCfstLfXMutDgrQ1TGpkeQtb8MjLykLDyCW5DOZoI/x
	 NT3x4rAcLaJwKsQA61iC9RK51eWNdIpgHdriNj+xmxhFA4p1Jl7BOyOCkBYyyzcO/W
	 YYXoC/1qvrxVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 240/317] powerpc/embedded6xx: Fix no previous prototype for avr_uart_send() etc.
Date: Sun, 24 Mar 2024 19:33:40 -0400
Message-ID: <20240324233458.1352854-241-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index eb8342e7f84e9..ac3bd4a3216ce 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -100,9 +100,6 @@ static void __init linkstation_init_IRQ(void)
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


