Return-Path: <linux-kernel+bounces-116115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F73889C92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6288CB45291
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429FD3AB7BD;
	Mon, 25 Mar 2024 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZi5Z2zx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3130B280211;
	Sun, 24 Mar 2024 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323638; cv=none; b=JJI4MApbO9oG+radqntd9HQJK9br5Cman+0qzBBhLywwefyioqV4HME8wENe5uMo0/8R3mxHx0nr/oOHUHoWvML8cD3Va7emUBUkyQOphIy9HJx9dDkFJdCtrqOX1yUAILG6+1Qv+YPr1sw4s7IjNfgJSBFt71fIjNyuqacZzdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323638; c=relaxed/simple;
	bh=tfnOGd7pf3A5f59RWHth3GLkpWlXj5gee4oTcfvY3k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCU91bD19uTTdVpXibJrPCVANAsd5n9mkwkTH79PpyhsKnykYeB3XwrfyIy8sKi0RNHiZxwBIFzZWPBH4QNtJsQqK1vNuwlCM8B0QLHrTib6iHCWhS34XRMJrScAg1l02gBtYZZcYxLydW64kvFWpDn2zTbOupsnsIAzSF8jKSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZi5Z2zx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E621C43390;
	Sun, 24 Mar 2024 23:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323638;
	bh=tfnOGd7pf3A5f59RWHth3GLkpWlXj5gee4oTcfvY3k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZi5Z2zxzeRE3/FNc6bW1kRMmeK4NCHqvIgDUb1Enm3ZDml8+fwMH+GmCatTcaZ5m
	 OUEhGKYDFRyPq8lvWjZ1+r78RyRnMJXwMCF+draHTfjuiE2xjABF3TIujOCXGEItNQ
	 NXjvrokhN9h0R2U1wU3dCUxQwEeFRTa3EcA0+lwHzZP/zaw8Bj1NV7JJ2cPDwftZWu
	 rqRtsNiIwbcI5CFrFsQx2dDrnVxeEnFA8gK3pnJJ1FxCQCAP2tsPjhMO6NBw0LnyOm
	 Ra+QYWGtDduxWdFLY4WVpld9rVcdIxHYZXdiyZXkNIWFuX/3NtiEv6Z2tLNJ+35uYo
	 fmipVoDKlCRMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 009/238] MIPS: Clear Cause.BD in instruction_pointer_set
Date: Sun, 24 Mar 2024 19:36:37 -0400
Message-ID: <20240324234027.1354210-10-sashal@kernel.org>
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

[ Upstream commit 9d6e21ddf20293b3880ae55b9d14de91c5891c59 ]

Clear Cause.BD after we use instruction_pointer_set to override
EPC.

This can prevent exception_epc check against instruction code at
new return address.
It won't be considered as "in delay slot" after epc being overridden
anyway.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/ptrace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 1e76774b36ddf..2849a9b65a055 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -60,6 +60,7 @@ static inline void instruction_pointer_set(struct pt_regs *regs,
                                            unsigned long val)
 {
 	regs->cp0_epc = val;
+	regs->cp0_cause &= ~CAUSEF_BD;
 }
 
 /* Query offset/name of register from its name/offset */
-- 
2.43.0


