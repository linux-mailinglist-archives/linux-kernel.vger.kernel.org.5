Return-Path: <linux-kernel+bounces-113292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64428888329
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C141C22F52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B60518EF9E;
	Sun, 24 Mar 2024 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM2SGsCP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82C318EF82;
	Sun, 24 Mar 2024 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320092; cv=none; b=WNHqn2QPMyDtQDLjgz/Cc93fYgwFq2aOkIrCyop+nDjOSRyT1ijeAdZ+jAQA6R31mfxwBgu14H5Wl8lOYZvKeGcOzGcjjCTy78kjqWYXjFq4bYlneKEmamIZfAoF5/okWBVovI2kBSgXi04Zu9XGpQPYhkvuKQbaZNr2tY2UVFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320092; c=relaxed/simple;
	bh=Ie+uzGtluX698sd7ls4ng58ghZb0o8no6h5usjuWX5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hc0ORehsjD047LdgMWJKv0wz5xdcLaidtGLgTeOLqRHl6MtO+PVLjGpnpgll5CP/h0VRuucLtGV8AbGDZNUXMwPIzDOtcveb3dSjiW/LbHVS1+RaMOtpu5bmPmbdRu6l8aUcJXOTK0Gb0/yfqGX0/fc9eSQ32WimOtPKBDxCJ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM2SGsCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E727EC433C7;
	Sun, 24 Mar 2024 22:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320092;
	bh=Ie+uzGtluX698sd7ls4ng58ghZb0o8no6h5usjuWX5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eM2SGsCPP79sQZqKcAHK2DDpgKOYQavcnystNnBt803njma7cQpJiv78xbmd8+3ag
	 Ql8t1QWZk1UOMQzYcLptaq6ntnPNcK09gdQWMotwBKzUASHKlLgU2XReeZ4PC0E7CR
	 tI4YuXH1sJkfGno8TB+5U2vfGEGu+fjuyhSuUTyQQHWBZmk1YU5GW5X1rNTEbjIaus
	 6y9rKfMEHyjQmHHLzH12e3YKjx0Wi/sga/v7zRvRtTKxgEwsjj69LUgqQHy5rwqxGS
	 RvX4BTL7mPgk2bg3wgmTQU+PDvC7HAjjV4T7vqDkKREqN4DlznujZn0Ib4RfOeaWI5
	 VcONtSlug3/jA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 401/715] pinctrl: mediatek: Drop bogus slew rate register range for MT8192
Date: Sun, 24 Mar 2024 18:29:40 -0400
Message-ID: <20240324223455.1342824-402-sashal@kernel.org>
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
index e3a76381f7f4e..3f8a9dbcb7041 100644
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


