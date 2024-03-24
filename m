Return-Path: <linux-kernel+bounces-114281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF068888F92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F053BB37B52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E3116D30B;
	Sun, 24 Mar 2024 23:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPdRPHxK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A57F13A25A;
	Sun, 24 Mar 2024 23:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321658; cv=none; b=C92EiHK2Howe0pmUh6/xbbdO7LNL6PMRPla0Em40cFwGJa5ZLAWPLFqqG5lXa6Q4Lq8nUD81rPR8X2cJZyo0LC9bmm1Dkjn7ighIghdxX0rFEI60S1iI+S+lN3wNr7lR4bb/vKzYri9yoP39UAdeItLIp3xgLjtpz0+6C19tDXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321658; c=relaxed/simple;
	bh=RjDm9ULGYGXR/Ui5vm0FWksgcl8NMVnW5oGvvsNB4/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Us3e8DUJlAeLAQ6O9hh05j3ovvd4FIjLdr4fsrMd5SOYsgwGIDkJihd6UEwRGSGqSx/fEYPWHbpczub394fZj4+KwLJ1YQgAZkvP2d4OGwwaoqJT0p1lX01mPERqIi5RD1Xn7MP03M+R9+/4VRUrp3P1HYoofQkMjUnJ+yRG4YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPdRPHxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC00C433F1;
	Sun, 24 Mar 2024 23:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321657;
	bh=RjDm9ULGYGXR/Ui5vm0FWksgcl8NMVnW5oGvvsNB4/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GPdRPHxKZQeK96TkTWQvgnomqAzUkmbl/k2jd6mvd3WS7hXSkQq1wjJGpg+Dl8MDs
	 Hkb79brS/chELukfZfi0EaylKmYzFNLLoxHPDT/DBiM1gvU4r1glFHJG7lmdID7Zfa
	 nZwIQk1QAdjoooM/sV+OlgGOrk5dcpevIOy5a6XVpWsd66GUpC/BR1ZkMH5vlmxdIo
	 0J9bp8KN29f/qFclD04dK2+bFSCEnVSvwUTPoERinTesFQSicg5BVPFy7XI6MzeJ1L
	 fmtbRAa3WFNpdrz5bAEbw9jsh7RpZlzpuHBD22N39nt276uFGpGJabF/ddZMMEBvu/
	 obczjEfR4vjJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 386/638] pinctrl: mediatek: Drop bogus slew rate register range for MT8186
Date: Sun, 24 Mar 2024 18:57:03 -0400
Message-ID: <20240324230116.1348576-387-sashal@kernel.org>
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


