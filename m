Return-Path: <linux-kernel+bounces-115030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990E3888CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9821C2A048
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2514A1C1AD4;
	Mon, 25 Mar 2024 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2/LG0j6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0E217CF59;
	Sun, 24 Mar 2024 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323808; cv=none; b=gTthXcjy9piKcNC+csOITM9AGCfpDcpnB493qggMvNd0HRujydcZ9nT0iVfepBp7pPxeyXevm+xgO+t/l9yj5tV0uY3whQfl6m2Pr4miyiCLPMNfbVLgSVXPxXV8+eqmK+IXU13QuniDJ+UHQ0+/munR+k43C/TOnOUwe8D1GBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323808; c=relaxed/simple;
	bh=3seKHVoN8/gBs3/qRcJQnELvobzcetvAIc5iZRBAZi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0NsW2OZuRZAj5+QFjl6FE0XoTrvwGU82aMTgGylbETI/JiL25Ual6XE1ZlblVCHNTYw3yNMFySNIagALr1e88rIT5YoNgHC7Zjo7E5eTjwx/2LVIoXjtcmOiYRLW0DMVK5VYktw50teXTuo1IL8KPCETNAF2smjeg/pPSVvfTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2/LG0j6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EA7C433A6;
	Sun, 24 Mar 2024 23:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323807;
	bh=3seKHVoN8/gBs3/qRcJQnELvobzcetvAIc5iZRBAZi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c2/LG0j6kqMt77qnX4DZLavIBiGLyyFQRZY0MxGfCFqiRHvKanRlHfiJVzsl3is4N
	 0J2b+GHKgb1TYwfglhEjlFBn+7xEd8gqDbh6DOCe93E1sjvhIgLax5LkIFxNUTzTvX
	 +Al6CcqRDuP/O5PSXDrpD2e2W0srrjqV3Ogx1XQPfuGbbUhQZdk/0kMAw05MPJwUC5
	 h+p802ZfDc6E3tb85Iq8FUPV0FIgvJr0tZuIxwf2+lYYV/MwYg/PYjEEJy69XW0bT3
	 +lU/PK1cWjYciI1ZELlxCHjZODbXBHQpbUTUFHp0trypsnYtmsU8Sgbb3hWePJXdq3
	 D/zi0WtHIpn5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 185/238] backlight: da9052: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 19:39:33 -0400
Message-ID: <20240324234027.1354210-186-sashal@kernel.org>
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

From: Daniel Thompson <daniel.thompson@linaro.org>

[ Upstream commit 0285e9efaee8276305db5c52a59baf84e9731556 ]

props is stack allocated and the fields that are not explcitly set
by the probe function need to be zeroed or we'll get undefined behaviour
(especially so power/blank states)!

Fixes: 6ede3d832aaa ("backlight: add driver for DA9052/53 PMIC v1")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20240220153532.76613-2-daniel.thompson@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/da9052_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/da9052_bl.c b/drivers/video/backlight/da9052_bl.c
index 882359dd288c0..aa00379392a0f 100644
--- a/drivers/video/backlight/da9052_bl.c
+++ b/drivers/video/backlight/da9052_bl.c
@@ -117,6 +117,7 @@ static int da9052_backlight_probe(struct platform_device *pdev)
 	wleds->led_reg = platform_get_device_id(pdev)->driver_data;
 	wleds->state = DA9052_WLEDS_OFF;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = DA9052_MAX_BRIGHTNESS;
 
-- 
2.43.0


