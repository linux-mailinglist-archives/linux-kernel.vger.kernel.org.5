Return-Path: <linux-kernel+bounces-87013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFF486CE3E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B8B28408E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D5B1574C3;
	Thu, 29 Feb 2024 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4xnvjp3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29451574AF;
	Thu, 29 Feb 2024 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221865; cv=none; b=oE2Mb8ZvD4N5iNw5z+MTg+6SLjWxHUeS0kKNoou3lxTaNmIRFxS5LZDWTS72IPDjzS/t36H53az+cHZW02FiVXL9+QHmMsrDO+BCiGFSmxaCIlSgqVPl4fv50jhy3tnkftFJODqLuKtlB843bk+GE/C7V6n24eFcR8Hi0TcNx9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221865; c=relaxed/simple;
	bh=YPRtis0IXaoNDc9pCeoWs6Weo9a+oWw+h2fuU+s0gXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOIVulkgwPYnmba42f4nc3Q7JLsSiRt7Y3yy9iEJE5CGZkghf9erp6ZhJOkOEUNEl5ciCPEJerZ997ttecAI5oYGJFBoctyfvwk7M7zSOvn14MphAZCkK5IcvcGmScbstta5x/ZSUJ+8WxdRaZtchA7BX5weKYSIiGAfSd82g1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4xnvjp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE607C43394;
	Thu, 29 Feb 2024 15:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221865;
	bh=YPRtis0IXaoNDc9pCeoWs6Weo9a+oWw+h2fuU+s0gXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4xnvjp3S3ctd9aQ54QdMKqdjIUACDGSY2NE4GvGVjXMsBqUj+ETPG+sFpNPv5tc7
	 zq7RfqAdJU8kGe16kBCJIMTPMm8hdQc/2HJdWSVgorZP+sUHDLz4cvSW5+3oCMJmdn
	 iUo+GGb3F6+q4qzPKueZfDlYs9SqCp4vjEHF+/gRTPvGCbYk/gxvr4o1ohc1AzY6Ic
	 56mHZjJ+d+lCBFgQzGvtr7eVmZFqN1tW0Ih4rAir73k+aSfaxL5tRHUHE6Vjq+V71f
	 4ezABHJongtYfJUMLXjbwXlmrle+/QwSKPpm3gcBL3ywS4R7v8DrXveBAn12OMQTd8
	 vTdE1d7/6srzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>,
	oleg@redhat.com,
	linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 5/7] MIPS: Clear Cause.BD in instruction_pointer_set
Date: Thu, 29 Feb 2024 10:50:54 -0500
Message-ID: <20240229155057.2850873-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155057.2850873-1-sashal@kernel.org>
References: <20240229155057.2850873-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.149
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


