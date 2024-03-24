Return-Path: <linux-kernel+bounces-115590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84446889480
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 310EEB370F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC16A25083A;
	Mon, 25 Mar 2024 02:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFwpfl1Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90BB1E5F46;
	Sun, 24 Mar 2024 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321294; cv=none; b=cQRjEwmSingKTfgiIsNrZXj6ZJQyLjLs2mX/komJXNab32tmsa1AJC8gRrhb3CzCV2dbUgdfCom4ctpMMz4UH4B60gTXNIUfFIKJYmLNKrsifO2zwpaypTRwlGvd0hP7X5gzsUrn6lv+WGfeGFfme10wzFldiAgq9pBUG5k/4/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321294; c=relaxed/simple;
	bh=XGGSvzBJNfmfnhL9G/6nyYMIHVzLF9YEZMutrFl1KtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdgbZJ3a8Hqm20lplPnR9txvH0pVGZx3B9yPDGGxoDqoy57j1uSLCz3mhgjaHQpGvJLctWsHxmGixfFAiXMQ6j4bsr7QuEwyBc0iksG0ArxN888OIiTSic8vE83tCs03vNjhJAtMMqKTalcd+pJlTh5I2awH88RzLkOq/BKcA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFwpfl1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CC5C433F1;
	Sun, 24 Mar 2024 23:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321293;
	bh=XGGSvzBJNfmfnhL9G/6nyYMIHVzLF9YEZMutrFl1KtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mFwpfl1ZHRtY0tx6jL0dakenpYTwNapYZYsJbbD+UcMZBPK0ixf8IwPSFIK/UE0ue
	 6mI0lRnyqyD79XCObobhpibkZ1gNzvgUHQ/NvvPU9b66TjvyRNqQTz3yYy76LsyZYT
	 kiBfZgyM0aaK/cuA14QTg2oE61A9uxQBhRvstHocmfGYbkioST7t5uQEH7zXBj3Qkb
	 f4+O+vEqNTuU4ZQ57RpYhj8MbMDs9DNcGgDq2Q+BT2XVZO7HiYWn80KI1o/HOiVB9F
	 0gXS/Y0nlc/6DMuovMIzGFQ49LKEY08/IGoxduc54u1Ap5XA9UZxC9Srl9EDKRJXU5
	 axjVvsCP99gHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 016/638] MIPS: Clear Cause.BD in instruction_pointer_set
Date: Sun, 24 Mar 2024 18:50:53 -0400
Message-ID: <20240324230116.1348576-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


