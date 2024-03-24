Return-Path: <linux-kernel+bounces-113528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B0D88850D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34CC31C2378C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8961BF500;
	Sun, 24 Mar 2024 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6RC1KYW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562C91BEDD1;
	Sun, 24 Mar 2024 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320330; cv=none; b=ettySKOIeUN2XzEFmWBbfVfj3VM7Ya6q2mWTT4vl6k/iahIXArTn1tW3dnKZlvmHLt4liCPf086+IYYxwr41nEhuedubtiey+MANHw29Ii+Z/L7YruSz2XiOO6CWkGOxMPuLhFxQ3b/g85YR6XF/8GLX2DxqZQDO8YFnHtchAwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320330; c=relaxed/simple;
	bh=4BL+nhp8W4vtBjDVb8FRYuXmV/nZ5/pDZL5T4yDC2Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctQVVjm9bUnDJsgFyWfIJuXHSaB7QyVQmAldDHq4uiG5fM5hFYmULWrKFbZEIJzzYelIXgeaoHHVtKIDGKJl5zfGnWBfjV7IJkzmSZquRExOiCIFuDe9zCFRjmJx5C5ODWlgsfw9h8O6sOB0i9dhD8JhIs4PFtx2ZIx/7/aQ9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6RC1KYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AC0C433C7;
	Sun, 24 Mar 2024 22:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320330;
	bh=4BL+nhp8W4vtBjDVb8FRYuXmV/nZ5/pDZL5T4yDC2Cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T6RC1KYWnUGJ80cgKDbviQW2TegS5A9vP+y6aW4o+IcZVT3wTbS4wVJZFRw1V6dqZ
	 243B1XeNK2WgYdRu+ZNHi7FRAXvHGo5XCkddM7K82MZrtRK2WKkM6M+O5b9XNgLk3J
	 yvwnibbuBsdGEzDYGLN3YEnv/cOiKQUBkbQx73M4xa63Ha4QxmLsqV8IIrjSO9QPwQ
	 k5cHvdkJVHwo8pX/+owzRS6HO0Qy7MkgF0jwGdtSKuwAjcJOxsflaUyrFNY6ssSqS4
	 6UoYwiW2Zd3DIppwDuY+rqZsIL6bYGt66ioWR392iBYrStnB6GuzV4MdqUD2NCvUcd
	 AvDgK/B06D/Og==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 637/715] thermal/drivers/mediatek/lvts_thermal: Fix a memory leak in an error handling path
Date: Sun, 24 Mar 2024 18:33:36 -0400
Message-ID: <20240324223455.1342824-638-sashal@kernel.org>
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
index 98d9c80bd4c62..fd4bd650c77a6 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -719,8 +719,10 @@ static int lvts_calibration_read(struct device *dev, struct lvts_domain *lvts_td
 
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


