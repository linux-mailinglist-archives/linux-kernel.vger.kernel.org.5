Return-Path: <linux-kernel+bounces-115954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EA88898DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B7929EF4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DA916F28C;
	Mon, 25 Mar 2024 03:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb0focdz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEC122EAB9;
	Sun, 24 Mar 2024 23:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322204; cv=none; b=Qfy1dA0H2ETL5hRR/97JPU9mOhl0+28pRrfvl1SkzlLzdKquj5efJrl2l0PpCzJau4iiuQDibNcfWUkbXOcLGClgIoH6ojrOrsvcD3S8Z0ZC4w754wneGrukh4RQHLiuy6VYnsuyGcxw0efgVhRVaIqd9V3Z1f6xRAYSofYYflo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322204; c=relaxed/simple;
	bh=j0BsWfsz/7LR1h9iVniZvi0VCdSuwLjHwSQAz1P8cxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8IrUyOshxlJRKc1u2Tndk7kfGGWr9u9oQSbQlqqIBhv13Q91uFbrnHEGJr15BmS0nVlLW2okdJzednMkyU7evKGQdXP+NDPpt+mpSDZmJ9jIeQp1MHWn3RXu5R60MgEkBSjBJd59aD8STJ4dgDc61YXzAr6IZG5bRQ/4WJwZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb0focdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EFBC43390;
	Sun, 24 Mar 2024 23:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322203;
	bh=j0BsWfsz/7LR1h9iVniZvi0VCdSuwLjHwSQAz1P8cxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lb0focdzvzY5z+bv2I9kn5ZJCAaelM5kKTCmYt8eghGGpZkQsbpUtm2BWbykNbwGB
	 mx1RLVBQGUPndbzeq7XLxhthg1AQRc6PFWsZ7qEfCPYhw4Da/wPlwNNJ+ZvhUJhFBp
	 zkKrFluSN/rEPbGP83UAPBpS3JibUNcOV8UjgkSqWmjeYHqmtXWfmknt1C+NzxaCed
	 LkFlOhugM2HG2TxwYi9vxr+xerJMWjQZfSg6f1qUaJ6zCB2oWAuRWPVKDLqvAzBkYD
	 JairGPIFJmlClBcfAlCFmWAF1lErZPXbZgGJyVmDLOTt/SILnTZzDsn6HI/IojXDAa
	 3q9HNFMY2sMFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 283/451] clk: renesas: r8a779g0: Add Audio clocks
Date: Sun, 24 Mar 2024 19:09:19 -0400
Message-ID: <20240324231207.1351418-284-sashal@kernel.org>
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

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 8dffb520ace48bcb996db049540c78261730213c ]

Add module clocks for the Audio (SSI/SSIU) blocks on the Renesas R-Car
V4H (R8A779G0) SoC.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/878rhganfo.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Stable-dep-of: abb3fa662b8f ("clk: renesas: r8a779g0: Correct PFC/GPIO parent clocks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/r8a779g0-cpg-mssr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/r8a779g0-cpg-mssr.c b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
index f89cda70f2cbb..d0e8deacdd0be 100644
--- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
@@ -177,6 +177,8 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
 	DEF_MOD("pfc1",		916,	R8A779G0_CLK_CL16M),
 	DEF_MOD("pfc2",		917,	R8A779G0_CLK_CL16M),
 	DEF_MOD("pfc3",		918,	R8A779G0_CLK_CL16M),
+	DEF_MOD("ssiu",		2926,	R8A779G0_CLK_S0D6_PER),
+	DEF_MOD("ssi",		2927,	R8A779G0_CLK_S0D6_PER),
 };
 
 /*
-- 
2.43.0


