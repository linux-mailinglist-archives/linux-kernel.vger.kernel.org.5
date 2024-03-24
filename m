Return-Path: <linux-kernel+bounces-114727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E1088922A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDAE81F2E47C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1DF1A0AE6;
	Mon, 25 Mar 2024 00:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzoR4bmA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7568A272968;
	Sun, 24 Mar 2024 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323310; cv=none; b=DhIN6fqOrwqT76fWj3z6vgZnAYJdfZl8xHhmnS1fOpqBwmFI3tauIRmnG03eceLV05yMW3moi4/wh30iBzmyMhOL0jJ9esMhTXrO+iAUzOZhLO+WpE64enuGcV2yTlLbqh0v8afvztXCqMOqOBtxLbX+xkqsI4Zgr8pGFSIhq7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323310; c=relaxed/simple;
	bh=YPRtis0IXaoNDc9pCeoWs6Weo9a+oWw+h2fuU+s0gXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLb47c7/cN3kZ2td1quwm7iLY0I2TXAlnIzN/+ff9BZjsGJbJFW3gKpBinXF0SaRkbS7qZn2clBCpCmbtmc625C5YuknX8GjPWsL59cUZXlnax858nBSXqz8nRlzVz9MsEoIqhJRLIKWflOTKxJEy6Cd8VcOv1e22EWGj8DP8kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzoR4bmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B0EC433F1;
	Sun, 24 Mar 2024 23:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323309;
	bh=YPRtis0IXaoNDc9pCeoWs6Weo9a+oWw+h2fuU+s0gXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BzoR4bmAyg5A7JU4XOWEnOX1PLPXV2/gj1sPvMWO2pFWgZcgUIj9QG0KLhATiORYj
	 YoAHE5Eekm+gzPRgeIIZeIL/epms5uOBUye1x2XpjxVRpV3jTJiqGq1t7H4DQ6f/Dy
	 XpvVdgMSAhbsoFmFx8SeFaPZqjJOUnfmb9sPDAsgLz+boUkGsaxXY1ey4A0Uh4Dpyz
	 jg+7+DQ84iWlsYMcyb7o0RByuwn2FESAAc8fCwQy7Sg7lvkhJNXWKYTQ1qMCiIzIyE
	 A4eRhZlqhkWVpAv9v8Q3DYDnWZJ9zMIwOrZMd6ZgpmDtBb26m81Ggf8Ws5Ye7Aoevr
	 qU3Lp/raA5LIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 009/317] MIPS: Clear Cause.BD in instruction_pointer_set
Date: Sun, 24 Mar 2024 19:29:49 -0400
Message-ID: <20240324233458.1352854-10-sashal@kernel.org>
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
index daf3cf244ea97..b3e4dd6be7e20 100644
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


