Return-Path: <linux-kernel+bounces-115755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ED4889765
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFD629D928
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A728016FF5F;
	Mon, 25 Mar 2024 02:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8mWsz5a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B0B1448D1;
	Sun, 24 Mar 2024 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321953; cv=none; b=gZf9hia9vr0PJJo1KWylbt4nWN5HRq7Wo9r/AiPvwOGBAr6/CGOOKsJWco/bAK0uDmLhGTIkhwizFG9UkYg2b18ggKoJ+eAKmMTAZTYYuMaa1LxYIptA28mND3CMI1T7OZFGPYAisfi4XU5XW3nSHwDQ4Rub0yyhiBOsBn1I+tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321953; c=relaxed/simple;
	bh=YPRtis0IXaoNDc9pCeoWs6Weo9a+oWw+h2fuU+s0gXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6Jv/2fWKEXzin07cl7DK/cq4npvm/sIqyYO52TEaMGiWBuMkuYJLGR4mOjX9Prn8PUx+9j/pKch3mwqlZGO8y2oUOnOzOFNj+n3Q14mjBWyc/rXv80f3sTmphCrYAV6i+vAwI780mUICJhm39/1b6I2/d06ETFJ6eSLZ2VRjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8mWsz5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9B8C433F1;
	Sun, 24 Mar 2024 23:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321953;
	bh=YPRtis0IXaoNDc9pCeoWs6Weo9a+oWw+h2fuU+s0gXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C8mWsz5aKd3xKGkewsn6OOz4RIFLkV8gSOntopDqq8Yv3iSDLou5rU14lhseAoCda
	 9kLb/0jkdQJhoKpfBu8+qA8tv7gF7Cb151NWFf47aEZ/zJ9OYhziBT3aeX6Ms8JLTG
	 pPITfrbeY6Y+1mwVBb1RUIIFvuqWK/50A0t3bvzKbCAPc1ysE1FkOOAi1sXlCGIYA/
	 9Li4H1/e82V5DnOhcJVbyJ/aiFn+hRAXEnAE7ErrVE4Yvw+ucoIWbYkYN6mjp3U8q7
	 kwH1iFf0R0R/qtgGtusMoxW9EGvKIXKBasjz3t2EUmzZH7lGhaETRg5w9tU/Cxbbbd
	 /Gr/T4TbClzcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 025/451] MIPS: Clear Cause.BD in instruction_pointer_set
Date: Sun, 24 Mar 2024 19:05:01 -0400
Message-ID: <20240324231207.1351418-26-sashal@kernel.org>
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


