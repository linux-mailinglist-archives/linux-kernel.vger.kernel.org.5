Return-Path: <linux-kernel+bounces-116065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBC5889543
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC661F32EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F42282A76;
	Mon, 25 Mar 2024 03:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etQ7rCGT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDDA1774DC;
	Sun, 24 Mar 2024 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323482; cv=none; b=QRhhAiIQLd+DBHD9MtlSlZbMJU9B7lLIsAy2DvhnFMi6pBdo2Y3L19xfQ8B+cZCzFCJOR0rLvdAfZgJvIH1oIjBa6mCkToD2+R4Ypc8bGQYHAsSvQEkt1TAsr9v7GN2BGir+CI6MdMJqUoH6yFQ8cp8eXFB8cupHQZVE3FLFjkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323482; c=relaxed/simple;
	bh=J5+ydmUTB6GHW5Flj4avryRijwC5zl0W+aYGABAuqX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgJI91quu4wW3SLzgNHa64jxsqGhpYm0Gi98J/0cipWuAxK/762FiRwnflJaN+o+PvIPYQAuUK1wW0eUBi///+fo6xl5lwvdiYgGWqje43bzpY8wzYF/UHikiJrj2mkg/fYYmaG9JQlYsCIj1h3rHtROzQVFZcn73V/NaKVYwKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etQ7rCGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BF7C43394;
	Sun, 24 Mar 2024 23:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323482;
	bh=J5+ydmUTB6GHW5Flj4avryRijwC5zl0W+aYGABAuqX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=etQ7rCGTULQhHPdfo1fZcQ7/S2J6TGGeXyTxPEGGQEyC6xcukaXaga0G+gO9LvbLH
	 ELvqCmzOUNR7X/LOcnlH6f6B/H0O2dEZ/7PmpHDYxOV7PEsXT3CX/xidMgFuLvfKn+
	 gAvTayKe84diRQUjCyeBP3H4kG7nXMpAlQs0vhF/RKvmH2WXcXX/l6l84PI+rQUegT
	 WsObAzhtmBKQHnq5YLnVb/URI/TsaoSeip4QG3j1eNaI43g/bZWLj2jcdEbKiqTjzk
	 F2/nXprqXpEE+ME6L2sKY32A3osCV6b7NBW5NRQCKgxG1QIvISewVQO0yqq4S0pGJ5
	 pO/PCYTN09rYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 187/317] pinctrl: mediatek: Drop bogus slew rate register range for MT8192
Date: Sun, 24 Mar 2024 19:32:47 -0400
Message-ID: <20240324233458.1352854-188-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 0c16b2c756bf3..f3020e3c8533b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
@@ -1346,7 +1346,6 @@ static const struct mtk_pin_reg_calc mt8192_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt8192_pin_dir_range),
 	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt8192_pin_di_range),
 	[PINCTRL_PIN_REG_DO] = MTK_RANGE(mt8192_pin_do_range),
-	[PINCTRL_PIN_REG_SR] = MTK_RANGE(mt8192_pin_dir_range),
 	[PINCTRL_PIN_REG_SMT] = MTK_RANGE(mt8192_pin_smt_range),
 	[PINCTRL_PIN_REG_IES] = MTK_RANGE(mt8192_pin_ies_range),
 	[PINCTRL_PIN_REG_PU] = MTK_RANGE(mt8192_pin_pu_range),
-- 
2.43.0


