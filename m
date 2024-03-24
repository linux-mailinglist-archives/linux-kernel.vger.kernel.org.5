Return-Path: <linux-kernel+bounces-113280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D2588830F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0463F1C231D2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EAD18C9CD;
	Sun, 24 Mar 2024 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJBZyrsi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6C18C220;
	Sun, 24 Mar 2024 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320081; cv=none; b=hdPXrg5mJF1U33V9IFunQQLnmliMXDrADmuCamKQUf7KEJwn6ua4U/mXxL/5vrlm21LuRbATRLXlA+KMhjXCefEM4dbuwWBc/5x7nUiEwwQtuk9fv2Vgadwt3ynTJZn+ZXkVt03e/sHAoqlhxSI6fCdrEgkExnW1VLuEdq2O9DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320081; c=relaxed/simple;
	bh=i6qbJ0YigLE3yuZNNmqK6Rf7CvUlWxagcLz5SoaV904=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkRgilwQ/co63ps1pWTbQv+DQKLQIjhEyMNm4j1OXoQcSFKQM9v2b9WX3Rh568FuCchhWU16h2mZFuyieALOSl07dZXpiM4d+WaCwQ90RcJ4EGJAOtSd2QFXlpmb95KwPAMJW4xaJsz30u1/tb6Znroe+W57EO7A8JMyqAbYNAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJBZyrsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E08EC43399;
	Sun, 24 Mar 2024 22:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320080;
	bh=i6qbJ0YigLE3yuZNNmqK6Rf7CvUlWxagcLz5SoaV904=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CJBZyrsigbHvBUEUNRc7cGemNZ98NP6fy5O5R/LlUATIXv3YNTVe4VzsWzLnem5rP
	 t3g+dJ/VJRiGH8owtz1wy+g+xtaX1V3BQETq52ZJRqcUkAy/XbgWP8CelPXFcTRqcA
	 bUTEwMBbqcPwJuKt5ui/9eBaz54DM1Fwys7HITiW71JeO/0ffHmZuBGJOqW23nxRWa
	 2Npi+8CvELsLCVgXEfBthDaOHidDjROOoBBX9Jd0AIARUNFtf7qepNfI8fqjlClUms
	 F4NYVsKpvGOWwbz5lJbjgnAKcFhTM1t1P0Q0+0tIbRcTbKlWxSybSoxbbLwiYrPdEG
	 WsHdy++AdaL+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Julien Massot <julien.massot@collabora.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 389/715] media: v4l2: cci: print leading 0 on error
Date: Sun, 24 Mar 2024 18:29:28 -0400
Message-ID: <20240324223455.1342824-390-sashal@kernel.org>
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

From: Julien Massot <julien.massot@collabora.com>

[ Upstream commit 58ab1f9e140006e9e5686640f1773260038fe889 ]

In some error cases leading '0' for register address
were missing.

Fixes: 613cbb91e9ce ("media: Add MIPI CCI register access helper functions")
Signed-off-by: Julien Massot <julien.massot@collabora.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-cci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-cci.c b/drivers/media/v4l2-core/v4l2-cci.c
index 10005c80f43b5..ee3475bed37fa 100644
--- a/drivers/media/v4l2-core/v4l2-cci.c
+++ b/drivers/media/v4l2-core/v4l2-cci.c
@@ -32,7 +32,7 @@ int cci_read(struct regmap *map, u32 reg, u64 *val, int *err)
 
 	ret = regmap_bulk_read(map, reg, buf, len);
 	if (ret) {
-		dev_err(regmap_get_device(map), "Error reading reg 0x%4x: %d\n",
+		dev_err(regmap_get_device(map), "Error reading reg 0x%04x: %d\n",
 			reg, ret);
 		goto out;
 	}
@@ -131,7 +131,7 @@ int cci_write(struct regmap *map, u32 reg, u64 val, int *err)
 
 	ret = regmap_bulk_write(map, reg, buf, len);
 	if (ret)
-		dev_err(regmap_get_device(map), "Error writing reg 0x%4x: %d\n",
+		dev_err(regmap_get_device(map), "Error writing reg 0x%04x: %d\n",
 			reg, ret);
 
 out:
-- 
2.43.0


