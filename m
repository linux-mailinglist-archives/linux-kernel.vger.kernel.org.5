Return-Path: <linux-kernel+bounces-114602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDDE888B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C521F27985
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4D9187886;
	Sun, 24 Mar 2024 23:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GePFw/zK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5C52320F9;
	Sun, 24 Mar 2024 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322254; cv=none; b=mUTJBPLuvg0cEPGkzfxNv2AM6lft53HadJdaR2UxlxvOYeY89eLkuY8f5oIeAU8Z6Zttg0GL2cgCPh0uUN6ZsR/rlmlxQJErq0fpMtf1mMlkZHwSKCXi3AserjoqmmQwkNiDMs2t/yqyf9o4Yc1wlpUM0NS5B90/996TPwn5sZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322254; c=relaxed/simple;
	bh=mIawM34SyUe/jITTtu9oMA7VpVwbYfWknznEoE42JIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaJzD0xqfZ0gndRN5rTCdPVHiO2O0NtgoBbZJS+eNXsfpWCrWdQgBHQZSk9CYX5pdPFkfJ6rq4/gG3NM8dk5VdDNS7Xp32ol+Nm0Y6lsiObLRGMMeq6YgrsOA5u+5PEulBE9nrtAqOFqyIW2q9ZfJbZjN666CrUU8YoYuEERkRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GePFw/zK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA81EC43394;
	Sun, 24 Mar 2024 23:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322253;
	bh=mIawM34SyUe/jITTtu9oMA7VpVwbYfWknznEoE42JIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GePFw/zKWqH3mfsJml5y57SSdjMOr7uY2EUK8BnXeodUGxfcTVGcuJ/eILmVwc5qi
	 5nQMWN0o3wR5mrICERMZ090B4RITFtW5/v4BaQsQQG4ah/S+CffgOAJS4NHx/ZMpHu
	 TBu9iEAj/lj8vI3rj5OXZzT5Si5rS4rvNGK8mIxT07ojWd8DCtLKXZduIdZMj2/YFR
	 o0mGoECCd0PrT1GI19pWq49ak4WWiXQ32jM0iS6BmJSzFbGDhAjT6NMBP7hsKVGZw2
	 UpDxgB44+E4NSzx68uge9mtnQXNsilwUhc9EMkfnbw91+DEymTyBkoqlP/EMcQjK/n
	 HEDN346CIiuNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 335/451] powerpc/embedded6xx: Fix no previous prototype for avr_uart_send() etc.
Date: Sun, 24 Mar 2024 19:10:11 -0400
Message-ID: <20240324231207.1351418-336-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 1830e1ac1f8f0..107a8b60ad0c9 100644
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


