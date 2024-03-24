Return-Path: <linux-kernel+bounces-113967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 459BC8887A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C8D2864B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815C1141991;
	Sun, 24 Mar 2024 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMQsNr2I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1111F14B077;
	Sun, 24 Mar 2024 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321078; cv=none; b=VjXwNL+n4HP4oCZK28yI+08z4KKGI6etTdrBbsoF6I9btEsJgTIOk/IcX/EatxwsBMC7emO5eB6cGzT8IzWg3HgvgbQLXC58l+ZtiTnS2mN2Jjo2xMmKjjcbLMGZoyqiJguMEHEy/omfPUdc2jFhCxoByhhwZgGuZ89hA7N8FHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321078; c=relaxed/simple;
	bh=4BL+nhp8W4vtBjDVb8FRYuXmV/nZ5/pDZL5T4yDC2Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8Z+kwtGnJzRk6hfUXQ6c0OPdJa1GzQbfClxB2xKQx5QBsnQq0G1LI1tkH+recVVHUWeKCsoJlmNtv9f686k2uwsT9ylwiJr6w42k4odPsxkU/le6ZbkZDMJWgbmRHpd1uldxSKcTzo+s46XyFsjVjSfCyaEU5yudC2iP+fgBas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMQsNr2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25590C43390;
	Sun, 24 Mar 2024 22:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321076;
	bh=4BL+nhp8W4vtBjDVb8FRYuXmV/nZ5/pDZL5T4yDC2Cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mMQsNr2IVyUhd7u/hGB7RTYyfhW9NMmXMPq6n7Fpx5GoA1//bovwO4I1857ie7EMq
	 JVRqyVRDTMrvp7QqMwQCTZ5sBzonRQby0NHkkJW8ttuFotgS94nXcUMnSlbvW3Xmrx
	 E4bxydrPcuLeKbi9ejYZlUaTBuCJe2YkFU83wwfIWEU2Xo1MD13IUW5fc9Q66JFIjd
	 9/SxVSPfZDdNc5q/BzAt86kMiht+uTaJClJ62syxIdEeQfRlygmXMw8/lNyNGjS9bv
	 yKffc5Buw8cW1ys62Xo8AtijPm4cyALfcXMqK5QrUIzue/3jbAqQkKB1VhvEZJqC9W
	 +l2IWoD/6OOWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 640/713] thermal/drivers/mediatek/lvts_thermal: Fix a memory leak in an error handling path
Date: Sun, 24 Mar 2024 18:46:06 -0400
Message-ID: <20240324224720.1345309-641-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


