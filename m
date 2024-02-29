Return-Path: <linux-kernel+bounces-87030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4E586CE71
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCC41F2152A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891BE160622;
	Thu, 29 Feb 2024 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWlr9yFO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD75D7D419;
	Thu, 29 Feb 2024 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221902; cv=none; b=owh5jy1kHxcD1nk9lHRsfvIyHMfVne7jXCfIQMRPrWhjY0T7Rj2GPuuqtMPrgPiKoEf1TJ7HYCotV8X78WIpRNtAvjU5CqrRiUfP3Q8+vM15TO/Yxlx0m/gTvHEVD09xZGzRV9ulxi2P7L6fK5iv6Aa6/2xIx7/Lh1RZtgcWpXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221902; c=relaxed/simple;
	bh=/nChahqELmINXvbQzfOoAMqupqs+JnDqhzIcM9K/gI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0tIPxbJkVVScEvWFJ3mZ0OM53lvdRMxbGIQ+g2TxFuxOeierHTHrmm/A+p0i8hEfXWrH67fvGGx+W3kSVDMqpAa0T0ViEv/8hLS87YQDrsz5up/bo6jU6LDxQ/baQ2lyUq65DOS//4Uipxl56UBNdB8qxpP1Xi1tmX1087c/dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWlr9yFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C725DC433B1;
	Thu, 29 Feb 2024 15:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221902;
	bh=/nChahqELmINXvbQzfOoAMqupqs+JnDqhzIcM9K/gI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KWlr9yFOSyugN+cXAYHT5UrPxZFEmHGVDrq/W3UicbTm7wCiV42wW9LiFO4062oTy
	 /K0vdQ7BrrVPcZA7YNMNS/oCINZV1V/qDBHywMkua4Jo84LyV1dyJWEOdMl77pYkoG
	 PTc73dIJzTb9bI/23iLHHBqFCl2431nwnw/g0rjE5HbLt1jzvoe56miLyxt5X0fr/r
	 AePwhELhJYw8BkVy+IDic+tz494JIgA5vb+y+OYnDsOWDmBVV6TSLYlRzqx4VEtemo
	 TyTrmd9JMMzUOYWa8giuVHgEvd41gwOQOmCa1Wrx+i6lpvjJVr2unDKpDYEH0zHbJ8
	 JtOYvepcUbcoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>,
	oleg@redhat.com,
	linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/3] MIPS: Clear Cause.BD in instruction_pointer_set
Date: Thu, 29 Feb 2024 10:51:37 -0500
Message-ID: <20240229155138.2851458-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155138.2851458-1-sashal@kernel.org>
References: <20240229155138.2851458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.307
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
index b6578611dddbf..e45c082e12316 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -65,6 +65,7 @@ static inline void instruction_pointer_set(struct pt_regs *regs,
                                            unsigned long val)
 {
 	regs->cp0_epc = val;
+	regs->cp0_cause &= ~CAUSEF_BD;
 }
 
 /* Query offset/name of register from its name/offset */
-- 
2.43.0


