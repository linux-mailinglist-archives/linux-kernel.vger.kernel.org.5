Return-Path: <linux-kernel+bounces-113624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E71678885BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46481F23926
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EACE13FD8F;
	Sun, 24 Mar 2024 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3zgeMBX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3F7640B;
	Sun, 24 Mar 2024 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320458; cv=none; b=SlbzG0gtLOSevvGKU3QSz26Cdy2k2s+Bi+aNlMP/a+ASqxNitOtKQIdXJp5u4G3O65BEQ/09ON73YBGxrgqlOBryphWqFtAzl/RXWLcdtYEV3gopGdc2BeG0po3IC7F7sHaQ905YmEMGPxBGUB+hqt7n0pXMUr8INIawhjY46r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320458; c=relaxed/simple;
	bh=XGGSvzBJNfmfnhL9G/6nyYMIHVzLF9YEZMutrFl1KtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8KIgtRe86Ksm0aMUxYmX8xu5WWM9I/CB0CSGHLyE4Gm85QaRwq40wKnGVOLS8DLYezktgbA+2ednqtzuJIQFFq/n8zjICFoLFT+pW4OLPDYibClAfK1Koj6bHIxbwNkXhFFDKRt+F4/iQMjOyEbmmzvs2jjrvZXVX8AAnjM/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3zgeMBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A19C433F1;
	Sun, 24 Mar 2024 22:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320458;
	bh=XGGSvzBJNfmfnhL9G/6nyYMIHVzLF9YEZMutrFl1KtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k3zgeMBX1mlwl1fRE/NTMpvMapgYu7TCJ5/mh/8ZuA05/i1DoSSnglvbI8U4TZW5S
	 MXqV7iEFTYGAlMZvJN9B6w/c4bdKsApKqWd1Raiu4hjmy75dhfE7qKQS2zNQI0Xw8H
	 aydLc9Q+gVGi5DMtvl0CLVLd9q+GGOO2NI6ZyqbLU/hbMwJdgVrCzPgCPenn1RLAoV
	 EzN+f4WP4mmjl2ZdlZdSUtiuavkx6RyYmTqPQkDuMOjDZIxx5Kgq2+/WrQyVeS1NzQ
	 F4Ko+CBnhrLnIU51TQd9NCkR3njuY8EsC9UHfCv8D3zUS78sc3Wd4EIJpRZfeoD775
	 C8ooRDIlXNzNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 017/713] MIPS: Clear Cause.BD in instruction_pointer_set
Date: Sun, 24 Mar 2024 18:35:43 -0400
Message-ID: <20240324224720.1345309-18-sashal@kernel.org>
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
index 701a233583c2c..d14d0e37ad02d 100644
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


