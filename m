Return-Path: <linux-kernel+bounces-114321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF058889C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450EE1F29D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F5416F0C9;
	Sun, 24 Mar 2024 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8lIqyZX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0C2114B3;
	Sun, 24 Mar 2024 23:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321709; cv=none; b=rIvDADnUd/wZWnvQAfEYHnefHglAVn1qGnTu06VRWl7c5DUed8bRysvQ8k129z1fVbqDKNs1yHHus5CaAfvU6QVfNEqufYa7HPk/RoiLvneg3d5P4YqQrMEGjUNe3FwFjejmFbvEqiZ87e4qnNdKV494h9C/PxiqAhVmtdeVgxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321709; c=relaxed/simple;
	bh=H2gboN4lFyZoPhuYF6uDqvUvDVm/a9twxrSa4OJarhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFLnYLyvW80eUu2kgRcph8Fu+eFY5/NyxF3NAEKUL/yV5KCqyKXRIVOWusJ1M4SxEn5Iwweo/kkoaSWluRP/bQb2jYFL0w8YmoDrSTZh9zOyUBbrQ9AJ0rIP7LDWD+I/T553sIcsVJSIQTnCMT+54zfmhbPYX3qmViI3cYnFb2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8lIqyZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2B2C43394;
	Sun, 24 Mar 2024 23:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321708;
	bh=H2gboN4lFyZoPhuYF6uDqvUvDVm/a9twxrSa4OJarhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t8lIqyZXhj1S4bjTmagZcu8VcKMBIDeI7id1UaAEmxkABh74XCL8Y9OKrJBULm/HU
	 nCwfej2Co/wJOjOdsib52rmV4j8uuNb0ts79SbOnUi6X/Px8Vh7/KqCazx9faIwxSY
	 OJWmNrUaHih40GDq2EmXTq85NBOA9+gTXrejIRmTU2Em7d8QhM8h+LsoQIxuWYOPot
	 Iz/6U24rPSwP78na1LFaonCd0ukeG1cxgNKqYdI5YsevVa1LVjp1gOWan3brI6wy7W
	 Wx6MPpKX+EjhvHXONWPLus/kqcR/hIJZEU49Z6t6b81UxwpqIGudQWBn0sD1RMoMFx
	 a18LClW8SQdyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 437/638] clk: mediatek: mt7981-topckgen: flag SGM_REG_SEL as critical
Date: Sun, 24 Mar 2024 18:57:54 -0400
Message-ID: <20240324230116.1348576-438-sashal@kernel.org>
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

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit aa690050c00a251ab69e3c5204d582833d0b958c ]

Without the SGM_REG_SEL clock enabled the cpu freezes if trying to
access registers used by MT7981 clock drivers itself.
Mark SGM_REG_SEL as critical to make sure it is always enabled to
prevent freezes on boot even if the Ethernet driver which prepares
and enables the clock is not loaded or probed at a later point.

Fixes: 813c3b53b55b ("clk: mediatek: add MT7981 clock support")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Link: https://lore.kernel.org/r/fc157139e6b7f8dfb6430ac7191ba754027705e8.1708221995.git.daniel@makrotopia.org
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mediatek/clk-mt7981-topckgen.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981-topckgen.c b/drivers/clk/mediatek/clk-mt7981-topckgen.c
index 682f4ca9e89ad..493aa11d3a175 100644
--- a/drivers/clk/mediatek/clk-mt7981-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7981-topckgen.c
@@ -357,8 +357,9 @@ static const struct mtk_mux top_muxes[] = {
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SGM_325M_SEL, "sgm_325m_sel",
 			     sgm_325m_parents, 0x050, 0x054, 0x058, 8, 1, 15,
 			     0x1C0, 21),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_SGM_REG_SEL, "sgm_reg_sel", sgm_reg_parents,
-			     0x050, 0x054, 0x058, 16, 1, 23, 0x1C0, 22),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SGM_REG_SEL, "sgm_reg_sel", sgm_reg_parents,
+				   0x050, 0x054, 0x058, 16, 1, 23, 0x1C0, 22,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_EIP97B_SEL, "eip97b_sel", eip97b_parents,
 			     0x050, 0x054, 0x058, 24, 3, 31, 0x1C0, 23),
 	/* CLK_CFG_6 */
-- 
2.43.0


