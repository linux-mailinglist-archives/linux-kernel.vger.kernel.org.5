Return-Path: <linux-kernel+bounces-113291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E54888327
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753671C22F52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9945A18E0ED;
	Sun, 24 Mar 2024 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZsXZZZX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C959318E809;
	Sun, 24 Mar 2024 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320091; cv=none; b=GrKKOc475O9jfLLKbddjE4pX15Amp5Fh6HEFr+0AmTDyuLH6LICyOkXulLe3js0fYRceX1MWkJQA08C4+1F70fQ6Wje1NaFtTgeJ9mBm/uVKhHqUOA+p+FdJvdnykdjtEmTHYSHrOAQgOZfJluvvJtoln40rDJ86OdABBUBeBQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320091; c=relaxed/simple;
	bh=Zec8QF+NmLIC7REopIU1XehcsypatEp5JuO/SuUNa/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7goN+Kg2FrE4522zF6l+0UHWsMAECSk2zdSDU1dR1R48L4RsJ8rrCCzQ7Qk8HBhTW9rgHhdmCNwd27ZWF8lWkb0r+CHosUm0qC8+E66g2Nakwf7s9FO6ejz4YwATe4XIaBjISPfd9e+ig+QV8FJ9HT+YAqIzAGT7lOp9anUM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZsXZZZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBA0C43394;
	Sun, 24 Mar 2024 22:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320091;
	bh=Zec8QF+NmLIC7REopIU1XehcsypatEp5JuO/SuUNa/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZsXZZZXEq0YDn4+J9AU2NdXbp0EeL7Fgt2rD7s02T+yig2LCPb0zL8rJdGbfaiNY
	 vC+6+7Ucfu13J31Wx9ZgXq8qdLlILCAyaZ4eXjowa6otJBLcgW9E9BkIzJ9SETLEdp
	 UQY1uePSUKM+i2Vn0wUC1VdXTxLV6hyMSvAKoIErqLS2tu7pBMp1dTT1a2Ddr9ILSI
	 wtBFtKtCUwbm3ZRlJeSMLuqWFL9hgD9xaR2Pg5bawIwfWsjnwZcUsv0c09irJ+lB9k
	 mIOFknOHLS3gG7vHxzX2iSI8JKS2VBCub51AtfG3H0XDIWQ7fsZ4HceGnfuasoqpyK
	 6N82EUpZ6Nawg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 400/715] pinctrl: mediatek: Drop bogus slew rate register range for MT8186
Date: Sun, 24 Mar 2024 18:29:39 -0400
Message-ID: <20240324223455.1342824-401-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 7be591591cce5..dd19e74856a92 100644
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


