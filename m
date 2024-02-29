Return-Path: <linux-kernel+bounces-87005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD8486CE26
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C3A5B26A42
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB749151750;
	Thu, 29 Feb 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPeWekLZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DD515173D;
	Thu, 29 Feb 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221849; cv=none; b=oqXf9MS4R0hTsNOZOSkWyJ/Vt8YO79wfezX50tSRiCs7qc0UY4mtTRRGpBwz8aXAUJB6elPHz5MAexOc4vISgE1hBt4i5ZlG8Z8/+S3xILrFTnQtJOfx3EpXWvu2qvQM6/+GYTzKb5hRz0K8l7mcB5egJnbIk6iQdX7zS7TDFxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221849; c=relaxed/simple;
	bh=YPRtis0IXaoNDc9pCeoWs6Weo9a+oWw+h2fuU+s0gXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIRfSCp2bh3G9d8wV8ZV7tivvMbM+2eVkjnogTQEEryvPyy2ZlWf/HWjdt+XIbnN3/ApBYNHt0/ZJmgLkW2xhcdF7JQX4nS9sIp+DKDDUjdcz9s88qpKAIFYLU8muEoOQjZLVyd3HAQCjdSxlDe7QPzliylt1Rqu1hpDgrwsRGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPeWekLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A63C433A6;
	Thu, 29 Feb 2024 15:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221849;
	bh=YPRtis0IXaoNDc9pCeoWs6Weo9a+oWw+h2fuU+s0gXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lPeWekLZNj4fOT3pUynOoO0EdYRb7IsXOZ3PvwweEIuJRacOFuSJaaUzgPtbncyVN
	 E4Pptuf8HulbjJB7AoGTQN9ftmOrQc8EBR241T6nW6cthFW7a3O/o+2Db2UB7MPa3Q
	 2KF44fhtXUFnbi3iLZUE6GdeG/Mo5L3xE4xjO1DjTfH9TGaAXMdSvUSCWTu3HA+GRM
	 Zi5eA/vV4AIjTOTpCl8YxW3Jc4bgy9zQyFdHH2pF5+/j+qoSPJHPes97qoQqC1Sjaf
	 bWEQH8Y+Wx/7EzdmESlHLvDYQuqihtt33bG0K5JJ7GXuaiku8tSD+oVt/wDvycEfHC
	 5b67EsyRAIgMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>,
	oleg@redhat.com,
	linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/12] MIPS: Clear Cause.BD in instruction_pointer_set
Date: Thu, 29 Feb 2024 10:50:26 -0500
Message-ID: <20240229155032.2850566-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155032.2850566-1-sashal@kernel.org>
References: <20240229155032.2850566-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.79
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


