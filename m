Return-Path: <linux-kernel+bounces-114425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED027888A70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288B21C28B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05E0176FBB;
	Sun, 24 Mar 2024 23:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0oST6yn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372AE21D120;
	Sun, 24 Mar 2024 23:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321848; cv=none; b=Ntb7dkDLgMOl2CM7TmGQMfEUiZXRDLiDwzG5vKz7SEnxt2zBiedm2jb/jtDHj1IZliSwtZ2LwlsPYIS4L60AKdheg2lZQ6QYiq7FnM6MPNHvIL1ddgPMTrM2w/RqdHQTLbZKZ5jUndQP7kAH6hLdxsTMv2wk6WKQYNnKn1/rVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321848; c=relaxed/simple;
	bh=Dvr3tZ42njaTxgTfU6F1pzRudY4kUGdagclzeVCey/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7NJFvXTpUPhR8LMDAGJCf4dkWX/pe/JhIyUqbePqOaJBpmGMeEleW/GVLvrehu4rxyaeuNDSLZka0YEoT7K4Xut5nh+qwAb86RbKsTv1OoDxgd5hZWr0b9J0JUQWBhpxK1gaqhEsJeulKY24jGl1fE6hiKzpN0J8lnYUjj1D14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0oST6yn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491FAC43394;
	Sun, 24 Mar 2024 23:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321847;
	bh=Dvr3tZ42njaTxgTfU6F1pzRudY4kUGdagclzeVCey/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0oST6ynpEAvD3X/7JccX+5TwzhsHvdhjP1y5CM4rb28owv6cCEyXsqSpBpXlg52D
	 vGktpj8i3tCtjAG8x96LUflaVPH1ON4oiYYoKpZQlGmpwc1KT8Y9yaEHx93myUfx47
	 aqRFH8XB/RfBZUL4tOKGmIhx56Nz7sr4cFhGkurnTz947X6PptN24seUeoVdA/Z5Je
	 dyevNNtipLEtGVCueED89qZxDVwVkQqOrj2KasIebF0MgJHEwBrstTSMoJPzU5EnIf
	 GIxOWVX61zgZBgOBwFTYIfmqqPmPwYFstypO1cVyuatJiZXQhZIRXkenIKjKA2fKAT
	 TLEnUd4tq2+aA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 575/638] thermal/drivers/mediatek/lvts_thermal: Fix a memory leak in an error handling path
Date: Sun, 24 Mar 2024 19:00:12 -0400
Message-ID: <20240324230116.1348576-576-sashal@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit ca93bf607a44c1f009283dac4af7df0d9ae5e357 ]

If devm_krealloc() fails, then 'efuse' is leaking.
So free it to avoid a leak.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/481d345233862d58c3c305855a93d0dbc2bbae7e.1706431063.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index effd9b00a424b..a4e56017dda3f 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -679,8 +679,10 @@ static int lvts_calibration_read(struct device *dev, struct lvts_domain *lvts_td
 
 		lvts_td->calib = devm_krealloc(dev, lvts_td->calib,
 					       lvts_td->calib_len + len, GFP_KERNEL);
-		if (!lvts_td->calib)
+		if (!lvts_td->calib) {
+			kfree(efuse);
 			return -ENOMEM;
+		}
 
 		memcpy(lvts_td->calib + lvts_td->calib_len, efuse, len);
 
-- 
2.43.0


