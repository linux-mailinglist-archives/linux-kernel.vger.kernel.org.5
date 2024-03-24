Return-Path: <linux-kernel+bounces-114282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCEA8889A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A3EB2837F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CC616D303;
	Sun, 24 Mar 2024 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UALkSHqq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1247B20DD5C;
	Sun, 24 Mar 2024 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321658; cv=none; b=LaH523h/aGA5mvYraW+HxTRvZZn4gDy4HWhvcdb7bkPFUd4HV/62Xo5WnSXWEdW4LNrEF5ow2MGK3tgjK1qWOoLUmhhHJsEEyCpFGDON+ngwxw79Cyo252l3Yxr2CNDAjdThxDtUvRKdSmxFGAzBm4b+fn2To4dV1L56UIQpPKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321658; c=relaxed/simple;
	bh=CppLPCfjU49vHu7bNWvje6/foOrxod7vVRZITwIj2fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuVzQvil0oGmIYI9f8TaCGqonzId/BABlaapLn0MZY1KNiWLzkv7J+egrDuH9dgvPGlUhnvmmZWWlpvSrFXbzFp86fi9DV5OcJO5PyYJMNmsvXJ4IvDy605Jlno9oTOYzN3/SoEe1D/QFPD5QNgwAD2+IAzDLYYwPMjeyhwf/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UALkSHqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA77C433C7;
	Sun, 24 Mar 2024 23:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321658;
	bh=CppLPCfjU49vHu7bNWvje6/foOrxod7vVRZITwIj2fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UALkSHqqozHTR93Db/25SJKrx+yhSFgJ34Wd1HqSIBMxK8nFFkqEh4JzB40ueRU25
	 iv7xRJ9nxnqYcKVFDy0tMmF5QG+LflzNvX1WznKIm1ZwVjQ7rDNxPdjGbIIQetnE+m
	 WGdmbXSxY4PxDwteMVHGK0VJpb8v+HGe9YonLbTWcFCz403blWhUo50WkDqzhKgzdx
	 8aP7jU8UnXB3hSWgZTbHhuq9CT+Tuzzcveru5seshqCKiLjqRwSV5jM77FcT46QfhB
	 0y6Pl7YPTfSYGrYXR1xKLUorFanMU8Sc+1++zIV9Tez6dyKvF6n0ekNU+YJG0B3rxt
	 HUNmt+yKdfWkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 387/638] pinctrl: mediatek: Drop bogus slew rate register range for MT8192
Date: Sun, 24 Mar 2024 18:57:04 -0400
Message-ID: <20240324230116.1348576-388-sashal@kernel.org>
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
index dee1b3aefd36e..bf5788d6810ff 100644
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


