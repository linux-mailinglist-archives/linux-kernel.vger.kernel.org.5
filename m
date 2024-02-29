Return-Path: <linux-kernel+bounces-86992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08E286CE01
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE271F254B0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D177F1433CD;
	Thu, 29 Feb 2024 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1k3wvIj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147A51433B9;
	Thu, 29 Feb 2024 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221819; cv=none; b=MPGmw+LwOKsRz8hGwjESuQrCjWwO4iaOYKsSZ4cLpi6ZxI3VDvPKvdWnERnwaKYJNT5ayE12fvbuPDIYHfXUlKgyLxC4dHUzq976G0TsqJ4VRGZODT3BPzhMVRrPFn6sohzbFBhS4pVl+RqMu68T5G0mHA5CpzzyOXGcp0tiRtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221819; c=relaxed/simple;
	bh=YPRtis0IXaoNDc9pCeoWs6Weo9a+oWw+h2fuU+s0gXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7ENV4ynVyHiZ8PwNM4HRofGbSHfHXWpS5dqNUUDS1m4N+DIdPcxVFkTgZher0F14VgLWWOCtXAVxZMp3OET9K44SAvaTBahtLD4VoK+6OPVXpGBrnCp5zMnGBlxKHQ5+EhkPf08SRawVVuGb4NYKzcwACAdPsvvy9SHiKmXMCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1k3wvIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0655C433F1;
	Thu, 29 Feb 2024 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221819;
	bh=YPRtis0IXaoNDc9pCeoWs6Weo9a+oWw+h2fuU+s0gXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1k3wvIjnFD/5wlJ8aNy81kMwnwCKh6KRarZb/gC9wjf2AnsHJlE5puVMivr9H+UZ
	 JIGNibzto51UgnBwD/1uxRB/hqcEqLswFWOL9Xkh18ipUAjpVWiReUBe/q8qUjszxn
	 0WrwPF7uvaFNWLx+HcmP4wmDfsx52amqJ9lGYbKZ8wqTBKmt/+vdXlAKieUsA3Moxh
	 UMAc/5bRZFf27WgVqfBcPpxzXVq7wWxfbgvZJ6wGArLxESumVnm1s5+Ez/WVxtHMvL
	 VgivlQhjjP8loL356lM3gVa4o2a/aKxFgzLLjV90pEvd9le6sDrHYXiS2lDIYnE7Za
	 cVjyYsFSUfXkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>,
	oleg@redhat.com,
	linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 17/21] MIPS: Clear Cause.BD in instruction_pointer_set
Date: Thu, 29 Feb 2024 10:49:37 -0500
Message-ID: <20240229154946.2850012-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154946.2850012-1-sashal@kernel.org>
References: <20240229154946.2850012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
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


