Return-Path: <linux-kernel+bounces-115956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 420AD8898DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C8C1C30852
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B659926738D;
	Mon, 25 Mar 2024 03:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElzOcUZm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1376022EAD9;
	Sun, 24 Mar 2024 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322206; cv=none; b=C0rXl+sI0AbHi1MdYlmfaBDNq8TVJ/Q7xbqBh09nezQ2YFknvCBZaJ2D0I5+BfqrR+s6PHaB+vg7FP9EsHS8u6jWtcMxmR0DH34P9Vh2/R1wRhOyKExf5TDYrRKvnXLacE9TB52vxCe7Yx7/5W61Jrkt4U8cUMgr/W6ZzN7IypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322206; c=relaxed/simple;
	bh=ktpIHlHNCEjQ9wvQusTfRCapO+PTvuhBGSZwWOVx4FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUhDYpt0QvOPxSCPzlBoHt6aucanUHYFJL1IE9g5xa+Nz6ycxqSBSXxYOrM816fQWvYNW5eOuBgzwfq0GNANGexh575aYeUgvphBcpMkGVkxUFEIkdQqQznVFC4UqVE7CiAOe2Ce48JBkOwQbV9/C48dIkOS8rHSEYGrYsfh38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElzOcUZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6945EC433A6;
	Sun, 24 Mar 2024 23:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322205;
	bh=ktpIHlHNCEjQ9wvQusTfRCapO+PTvuhBGSZwWOVx4FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ElzOcUZmHkO0n+lguWe4Wvo9CLfq8BMeP3JcApZYmad6W4Y7ErH0Dt4QiBn7nEhiC
	 LJHhTK+vJoskDtyREw5E5YXdZcmKEFnsCvRPyjTlPamX9okrItMUIDaZ87ynZD8m++
	 Up83C7J3C1J0FhDUqnJewA2iB2NJXmTNHTv5fSGPIwc/en4EV1uPDn/6Ql/QVfvmh2
	 NdZdtusMN9tObrJJs9eg0mB7534B+fU/Czyi5lhJ7mOk/+xCPaWszSXbI7d+g4Rv7q
	 hEEF4T1r0vXqlpusQsqFk8c3jrNbbqa4lqrLnhtWDeCJ1ZDjjkUI+Sd3gJZ3uoc6Pe
	 Hp3DQNTRj+7HQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 286/451] clk: renesas: r8a779f0: Correct PFC/GPIO parent clock
Date: Sun, 24 Mar 2024 19:09:22 -0400
Message-ID: <20240324231207.1351418-287-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit d1b32a83a02d9433dbd8c5f4d6fc44aa597755bd ]

According to the R-Car S4 Series Hardware User’s Manual Rev.0.81, the
parent clock of the Pin Function (PFC/GPIO) module clock is the CP
clock.

As this clock is not documented to exist on R-Car S4, use the CPEX clock
instead.

Fixes: 73421f2a48e6bd1d ("clk: renesas: r8a779f0: Add PFC clock")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/f88ec4aede0eaf0107c8bb7b28ba719ac6cd418f.1706197415.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/r8a779f0-cpg-mssr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r8a779f0-cpg-mssr.c b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
index 27b668def357f..7a49b91c93710 100644
--- a/drivers/clk/renesas/r8a779f0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
@@ -159,7 +159,7 @@ static const struct mssr_mod_clk r8a779f0_mod_clks[] __initconst = {
 	DEF_MOD("cmt1",		911,	R8A779F0_CLK_R),
 	DEF_MOD("cmt2",		912,	R8A779F0_CLK_R),
 	DEF_MOD("cmt3",		913,	R8A779F0_CLK_R),
-	DEF_MOD("pfc0",		915,	R8A779F0_CLK_CL16M),
+	DEF_MOD("pfc0",		915,	R8A779F0_CLK_CPEX),
 	DEF_MOD("tsc",		919,	R8A779F0_CLK_CL16M),
 	DEF_MOD("ufs",		1514,	R8A779F0_CLK_S0D4_HSC),
 };
-- 
2.43.0


