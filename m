Return-Path: <linux-kernel+bounces-115968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A7D8898EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1221C31E91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0AB3941C6;
	Mon, 25 Mar 2024 03:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ure/p40F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C42232112;
	Sun, 24 Mar 2024 23:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322256; cv=none; b=svnf6pzCD74HXhIo2yx0Spg8GZ+rh6B1CNsZ77HlYrkcn+zJTchAM/hM4ZGdZGAuZBo16b5+8By/Mwx+YW4yih6b+MXcfhXCldWULlXyNcGlJ0413SfRkVyFfQNXyioYLvn87vpQG7OB036YeGvzRcLPQx+biaUUGuDtGdFEyT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322256; c=relaxed/simple;
	bh=E/cah9PJnZMr4jy1aYat2RUIWf/zWUgYO97GdOL/LZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjYEjttCSHcAfzXMEgjkflKua1QB7KpujvNZCMiR6eGYKgGWTb8hNm0Ebyz1NV+jAUVDnId0Nv8Ipl7V8gcqoHWvNrJS2lor8jt7SmiHbgnOONPVbik0OStkqjVd0xhmK0Uj3s9+DsJ5rnFqYNOKUY9xMw2vYrrHK2B85LZ+mcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ure/p40F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B5EC433B1;
	Sun, 24 Mar 2024 23:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322255;
	bh=E/cah9PJnZMr4jy1aYat2RUIWf/zWUgYO97GdOL/LZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ure/p40FH+XdS/Zx8woPqlA/uNv5cBHECG88R5KYq0q/aZbZPViz94/HEt3NqbO/5
	 LpCHfZq/NPR0PM6Wb5VRFmuOcmp+mYz0I86nnGpC9OWOXoqZsPN9UcCgc67L/bSLMM
	 4xHsvcOl2HVHUaot6NicEJu5FqxI0fEIFfEhLgJFZTiCVvBc9yTn+okHPbLmskW6U+
	 Zf0q/kCVS28kN0pBMc6vaVLlEIbxJH76gC7miEHNRQ38TXaKGg6ePawhyy8DA6GG9Z
	 lhb0L4mKMCCqQYk4RTd2OgLSsNWAK/a4Pwk43LOz43H7dfps6XdqF6HHTdQSuRXUr1
	 2lK1oVMXone/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 337/451] leds: sgm3140: Add missing timer cleanup and flash gpio control
Date: Sun, 24 Mar 2024 19:10:13 -0400
Message-ID: <20240324231207.1351418-338-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

[ Upstream commit 205c29887a333ee4b37596e6533373e38cb23947 ]

Enabling strobe and then setting brightness to 0 causes the driver to enter
invalid state after strobe end timer fires. We should cancel strobe mode
resources when changing brightness (aka torch mode).

Fixes: cef8ec8cbd21 ("leds: add sgm3140 driver")
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Link: https://lore.kernel.org/r/20240217191133.1757553-1-megi@xff.cz
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/flash/leds-sgm3140.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sgm3140.c
index d3a30ad94ac46..dd5d327c52a10 100644
--- a/drivers/leds/flash/leds-sgm3140.c
+++ b/drivers/leds/flash/leds-sgm3140.c
@@ -114,8 +114,11 @@ static int sgm3140_brightness_set(struct led_classdev *led_cdev,
 				"failed to enable regulator: %d\n", ret);
 			return ret;
 		}
+		gpiod_set_value_cansleep(priv->flash_gpio, 0);
 		gpiod_set_value_cansleep(priv->enable_gpio, 1);
 	} else {
+		del_timer_sync(&priv->powerdown_timer);
+		gpiod_set_value_cansleep(priv->flash_gpio, 0);
 		gpiod_set_value_cansleep(priv->enable_gpio, 0);
 		ret = regulator_disable(priv->vin_regulator);
 		if (ret) {
-- 
2.43.0


