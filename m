Return-Path: <linux-kernel+bounces-115000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D33888C74
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF78E1F291F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4F82E5EBA;
	Mon, 25 Mar 2024 00:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXiIbMVr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BCF17C1AD;
	Sun, 24 Mar 2024 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323762; cv=none; b=cAP2Gt37set3+897amFK2TXKRwgpVyFDrIc/HBsTsjQapTcPaf6xUnYMalgsNz8/zZbsGOq+DIsTyGF8acRBT5tTn+AtLdm2cyyhha+AVe/+6T5EW16e0QWpn7fWUIacSRkflweqXnx80snwMPcj/VXQgNVxRbn30h9yQsdPdcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323762; c=relaxed/simple;
	bh=J5+ydmUTB6GHW5Flj4avryRijwC5zl0W+aYGABAuqX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xin9ItnW6cFwM3uMHGie9A5p3Q0iL0zdvoaTUiBHVPmtkH0ySbGdO0If7lg8zwYUptEJ0i5krdYneWYp0HWAV/Z3yBA9/5OFDqz+tPZ1A8YUfbSiHq7jVTTijFXEZaBIVqv8TlX5W071W2kayzZRstwH9f+gWc3mXjsFUjBYlW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXiIbMVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50C6C43399;
	Sun, 24 Mar 2024 23:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323761;
	bh=J5+ydmUTB6GHW5Flj4avryRijwC5zl0W+aYGABAuqX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LXiIbMVrn9aFZI9gyfoB+RoKKRWvmbhZFXtLq8hfoRsO8ait6bjEvkDtVpbXHaQaF
	 ivIv8f9R+dx+Z6IcolwwhYm/x5s7+rG4jTmxQz+JaZnfy9NCUdzMzz1Vi0BEXD14ND
	 bCHSqGC8nKbEidpT4iVC5SMpdKbGGyviNyDTVsgX2fZLplw0D47MsXuh4ERSlKY/nm
	 jAyu6JdheRknh05Cso+xNs2w55pSlBm3jaREE3GwYkhc89KLeNkxgiWqXv+MISG/Hu
	 SCI3fW0/A/dKMTyKA+m+ATZIlI8KUJyG9apiqwiMqcEoZpCWN7iykAeBgPfgwj1Vcd
	 8nN9P3OBdBkAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 136/238] pinctrl: mediatek: Drop bogus slew rate register range for MT8192
Date: Sun, 24 Mar 2024 19:38:44 -0400
Message-ID: <20240324234027.1354210-137-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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


