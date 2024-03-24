Return-Path: <linux-kernel+bounces-114557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 034D4888B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CD81F27519
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC289296164;
	Sun, 24 Mar 2024 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkiU5o5F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B29E22D88B;
	Sun, 24 Mar 2024 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322192; cv=none; b=O6aiG1tuh1Qe6Yjm/TcRhy/52tivBEH9eIQq/vCJZ6QlW7wJ/xmLYPzaVcCMtZ20nWqej59pWiB1Lbu1cEnWGbyrOuwgBiRjl5v0Ul3kmbxCpbbX/p+nN9j8Z3cX9nMNrk6usQkvhSrdyccsBksNMwJBrrzJDt3OGyq7Bc37y2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322192; c=relaxed/simple;
	bh=uSB86LGFh++wXiUW5JVdLhlUehdvKKv6f020iY4A+x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sB8ZXoJx0/vbefNVSZCyAEVXAvMDIETgrEkUYrqidrK3ckbvT0u7Z3Px+Xko/4uRQfaPNBN7D6ZUAQnh0MYkQPE/u6tH1jQzoMHfEWLVSjimuMX2WM4U+3pl4n4PHhN76eVBgqhN60WZotiDzVH+8t9vj4gvg2iMa7W579yDqYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkiU5o5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF16EC43394;
	Sun, 24 Mar 2024 23:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322191;
	bh=uSB86LGFh++wXiUW5JVdLhlUehdvKKv6f020iY4A+x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XkiU5o5FfepC9ahQ9oLRiS8T4vu5Wix/rHjRLv2tFEVIYubqDNqPiQOr/tSv+iczS
	 aC1BmirrLs9txwGIZN7mdxtBuY8FZgcD+ZJJQ7d/hPosBmWf7dCsa5az0PW0SGZAxJ
	 ubzC0236V7DhYA4IvzMmPC5PI/eXsoo3Qo9A9dBXVF16rtaZ6gji9Ez69g9zqOOvD+
	 eAxXk2OS25UFzZa1746nGXGS9gkKQV0KODIjbO6Nnz8m6sH++dyyJfsIwc6gOqEdKD
	 6QHR1+sLoaNxf6PFcVi1azZ969YxOvQvzs6ErynsjRap0DCRlj1iwM2jjCtKgTKGT+
	 qe/MTVI5q5fcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 270/451] pinctrl: mediatek: Drop bogus slew rate register range for MT8192
Date: Sun, 24 Mar 2024 19:09:06 -0400
Message-ID: <20240324231207.1351418-271-sashal@kernel.org>
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

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit e15ab05a6b3ed42f2f43f8bd1a1abdbde64afecd ]

The MT8192 does not support configuring pin slew rate. This is evident
from both the datasheet, and the fact that the driver points the slew
rate register range at the GPIO direction register range.

Drop the bogus setting.

Fixes: d32f38f2a8fc ("pinctrl: mediatek: Add pinctrl driver for mt8192")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20240131071910.3950450-2-wenst@chromium.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/mediatek/pinctrl-mt8192.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8192.c b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
index 9695f4ec6aba9..f120268c00f56 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
@@ -1379,7 +1379,6 @@ static const struct mtk_pin_reg_calc mt8192_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt8192_pin_dir_range),
 	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt8192_pin_di_range),
 	[PINCTRL_PIN_REG_DO] = MTK_RANGE(mt8192_pin_do_range),
-	[PINCTRL_PIN_REG_SR] = MTK_RANGE(mt8192_pin_dir_range),
 	[PINCTRL_PIN_REG_SMT] = MTK_RANGE(mt8192_pin_smt_range),
 	[PINCTRL_PIN_REG_IES] = MTK_RANGE(mt8192_pin_ies_range),
 	[PINCTRL_PIN_REG_PU] = MTK_RANGE(mt8192_pin_pu_range),
-- 
2.43.0


