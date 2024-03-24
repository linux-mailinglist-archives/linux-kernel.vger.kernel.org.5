Return-Path: <linux-kernel+bounces-115949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEF48898D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1D52A84C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055823913EA;
	Mon, 25 Mar 2024 03:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9Is21ta"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496B22D89D;
	Sun, 24 Mar 2024 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322191; cv=none; b=nBQFeA8Sw8QN4if+ACcruKsOW2LT0/OCwNdAT5P98qKwAkhBvDLqlk8IyTry8/GTtpou+IClDYki/1/to1zeET/8QVoHYVvfNkffR4c8Kl86KcQOPZxnbJfrnSViuGm5WbccgmKPtHgxdjxI/IjontGlvT3rleIEm597uv1QFGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322191; c=relaxed/simple;
	bh=RjDm9ULGYGXR/Ui5vm0FWksgcl8NMVnW5oGvvsNB4/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfMW/dff9hn8sPI1+JvGvOx51q6nMEooOWavFJPxsh0nbrCSOuF3CQZ/fFLIvu4tMPheHq6qlzzOHnLB/ybK4ENxCdLja3sMtJgoKrEdVYiODN3rzeyrpIFXxhevT3qoCJww7JzyoGSn47yg6kWy4upklpr/HuJK7BFCV9FRaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9Is21ta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3706C433B1;
	Sun, 24 Mar 2024 23:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322190;
	bh=RjDm9ULGYGXR/Ui5vm0FWksgcl8NMVnW5oGvvsNB4/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o9Is21taKvL3UXPK5qVKY7guQA8XpkKq1K+XCk1JWmJDchhbAu5941UVbzUCmiyY3
	 6oOl2asS1evoKgsiBDcqQBBG73siY3D5EVI2mpo/39NF4DQfsazx2c62WDCReNAlEw
	 q/Kv3n+zRKO0cK6wbQCU47zZmyKQITaY7ubaI6GC/HnApCLFbUwfoV2JZd47Dr0Wg0
	 d7WYHDD4LYbWw8zGOFkMdB1KxrgycU5bvq46SzJBwjeNcse/3RdZsZorzKExxKtmSR
	 Jo67Mm/6Saj93lZJVSl4P4RoCbiYJaCK3ox/Dp6J0PX6H1MPSbf/GO4I7uwpebEXhT
	 PEjLmeBgbfxvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 269/451] pinctrl: mediatek: Drop bogus slew rate register range for MT8186
Date: Sun, 24 Mar 2024 19:09:05 -0400
Message-ID: <20240324231207.1351418-270-sashal@kernel.org>
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

[ Upstream commit 3a29c87548809405bcbc66acc69cbe6f15184d94 ]

The MT8186 does not support configuring pin slew rate. This is evident
from both the datasheet, and the fact that the driver points the slew
rate register range at the GPIO direction register range.

Drop the bogus setting.

Fixes: 8b483bda1e46 ("pinctrl: add pinctrl driver on mt8186")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20240131071910.3950450-1-wenst@chromium.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/mediatek/pinctrl-mt8186.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8186.c b/drivers/pinctrl/mediatek/pinctrl-mt8186.c
index a02f7c3269707..09edcf47effec 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8186.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8186.c
@@ -1198,7 +1198,6 @@ static const struct mtk_pin_reg_calc mt8186_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt8186_pin_dir_range),
 	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt8186_pin_di_range),
 	[PINCTRL_PIN_REG_DO] = MTK_RANGE(mt8186_pin_do_range),
-	[PINCTRL_PIN_REG_SR] = MTK_RANGE(mt8186_pin_dir_range),
 	[PINCTRL_PIN_REG_SMT] = MTK_RANGE(mt8186_pin_smt_range),
 	[PINCTRL_PIN_REG_IES] = MTK_RANGE(mt8186_pin_ies_range),
 	[PINCTRL_PIN_REG_PU] = MTK_RANGE(mt8186_pin_pu_range),
-- 
2.43.0


