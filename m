Return-Path: <linux-kernel+bounces-114318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48354888A00
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77ED1B28FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F332655D6;
	Sun, 24 Mar 2024 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mS9ZZNiz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981192114A6;
	Sun, 24 Mar 2024 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321708; cv=none; b=Dfn0ckmAICI+zAIWOpmSiZSW0eCBhuPQDKrobWVvHSBallOHMz4q4RAPgqb9DjGfI8RPAZOmvOGwCCZwPIwMEhORT08lfO2tRMBfEia+gX6liv94s70vPe37GhyGU32Ofb7NXNR5FQTGwnXY/pgfoM1kCLNGZwRbNf8Q6qifONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321708; c=relaxed/simple;
	bh=9EArykFpEIy/MTPK8XwsMVYLwhLAw0osXCOlEx433lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNPUmIZeBkhw8i60g8bg3I00uJi7Jb4Jvt01g2EWVaTDEYj9w3gQM/NCoHIC3xs2rXa553PtsuxUbAsiHCaPqcW3JEcuV61mtzXfipIWuTcD3u7kNEtUsYSSvTioAvZXKoZcsj1kZbcQ5Hqz3SCVo5sHjm7AVh1KR5H1KaPv2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mS9ZZNiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF258C43390;
	Sun, 24 Mar 2024 23:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321707;
	bh=9EArykFpEIy/MTPK8XwsMVYLwhLAw0osXCOlEx433lU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mS9ZZNizPoy+RhMZ9bEm+SL7ZYdnufsjHXj/ayPZpm10lEsuV4ilLAfy4L2/PbRSM
	 UqVTuDQAfuKafIxMo3Pf//YdE+TnlwM6Yf02jA1v+DtDM5WVfENr1Si3Hkb8T39Rwo
	 it1gZ914chhSho429EcKP/5KFJJK1Bdm+A2fre0Xf+PJ1dNQ+7uGdCGCsMxd1SYH70
	 s8n7HOHHXVgfz722gavMADTWnxOux20Jyyxe+h8zAgwdG1XqmLktJXPqcNh9IvG4QF
	 rNvxMitKPdNaiNJy//GLrLk7qxoraBnIfQBzu+3zg/i50e7ANsg9t+5cffiJLu6nma
	 WARt+TTw9r6oA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 436/638] clk: mediatek: mt8183: Correct parent of CLK_INFRA_SSPM_32K_SELF
Date: Sun, 24 Mar 2024 18:57:53 -0400
Message-ID: <20240324230116.1348576-437-sashal@kernel.org>
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

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit a65083fa663a335008e34f65e184041174a9dc7e ]

CLK_INFRA_SSPM_32K_SELF has the "f_f26m_ck" clock assigned as its parent.
This is inconsistent as the clock is part of a group that are all gates
without dividers, and this makes the kernel think it runs at 26 MHz.

After clarification from MediaTek engineers, the correct parent is
actually the system 32 KHz clock.

Fixes: 1eb8d61ac5c9 ("clk: mediatek: mt8183: Add back SSPM related clocks")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Link: https://lore.kernel.org/r/20240219105125.956278-1-wenst@chromium.org
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mediatek/clk-mt8183.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 6e23461a04559..934d5a15acfc5 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -790,7 +790,7 @@ static const struct mtk_gate infra_clks[] = {
 	/* infra_sspm_26m_self is main clock in co-processor, should not be closed in Linux. */
 	GATE_INFRA3_FLAGS(CLK_INFRA_SSPM_26M_SELF, "infra_sspm_26m_self", "f_f26m_ck", 3, CLK_IS_CRITICAL),
 	/* infra_sspm_32k_self is main clock in co-processor, should not be closed in Linux. */
-	GATE_INFRA3_FLAGS(CLK_INFRA_SSPM_32K_SELF, "infra_sspm_32k_self", "f_f26m_ck", 4, CLK_IS_CRITICAL),
+	GATE_INFRA3_FLAGS(CLK_INFRA_SSPM_32K_SELF, "infra_sspm_32k_self", "clk32k", 4, CLK_IS_CRITICAL),
 	GATE_INFRA3(CLK_INFRA_UFS_AXI, "infra_ufs_axi", "axi_sel", 5),
 	GATE_INFRA3(CLK_INFRA_I2C6, "infra_i2c6", "i2c_sel", 6),
 	GATE_INFRA3(CLK_INFRA_AP_MSDC0, "infra_ap_msdc0", "msdc50_hclk_sel", 7),
-- 
2.43.0


