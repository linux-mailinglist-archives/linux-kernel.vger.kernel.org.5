Return-Path: <linux-kernel+bounces-156378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862168B0220
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCA44B245D5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025961591E9;
	Wed, 24 Apr 2024 06:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsIwK7G0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D193157A58;
	Wed, 24 Apr 2024 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940558; cv=none; b=FJcg0O8gm1VBy3N0Cdz2sRSu2wHvbhPJ44fHlUrI6qCeNxtJIoy+n08nVgaF4D0i8is5eY69mSoJBpyKzRq2+0OnKcOS7zY2UuxHVKTEFBvIM8B9VLDriSapJsHXl70dTgDTXsfwgCQaWNwCyrZc15nVXZUQ7H1EHWmMjupuom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940558; c=relaxed/simple;
	bh=TlUGfQe5SGDRa6cwwzTDSZ6FsJSUi6EsphJ+q93qN/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xd2pDdNuSS3lmMENUOmqNcl+tpTmKnZ/V3z7OJvSBNXaO9tcCtBc2d8W8W4Z8/svl7GRgXOz37UzCMvzC30zkUHrafHfwiMwq4dMQP7lVZNB9+V6Rpy8FjGUH37iDbaEFIC2/24KQJo3nqgoYzeaa/YFcG8N2WLcGcl41lBU3Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsIwK7G0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5920DC32781;
	Wed, 24 Apr 2024 06:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713940558;
	bh=TlUGfQe5SGDRa6cwwzTDSZ6FsJSUi6EsphJ+q93qN/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HsIwK7G0yXnAxxyfQ+wQcwoQk/4yUS2LdPH4FKJGrWzlciwhAtdBVg95x/JPzAfRW
	 aJVhOqs8jJvTYuNRI2PtP/7yQ9hYP7kZ8k5zhcYSccGepWoxYyYtmMdPnp4AKzQc9x
	 wmVS3bhjvQlIEmQZl+KJmYsC99TeutGTS/VSS8UDd1FpL4Fi/m33M69345wvNGpjBR
	 JXaQlB4xjH/YcCeep4/x+bevEvzYb8GKJsshafPEWh4EW4ZPqtwngZPajMscSgvjDM
	 qBcRZvIXVLdUE3ghRApjYr+FteiZrt2rlH/rZ42LsX6MH63uXurG3MjBJBH2iH8PC3
	 qn7a1dWl3JLiA==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 24 Apr 2024 08:33:40 +0200
Subject: [PATCH v2 14/19] backlight: tdo24m: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-video-backlight-lcd-ops-v2-14-1aaa82b07bc6@kernel.org>
References: <20240424-video-backlight-lcd-ops-v2-0-1aaa82b07bc6@kernel.org>
In-Reply-To: <20240424-video-backlight-lcd-ops-v2-0-1aaa82b07bc6@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-omap@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=862; i=krzk@kernel.org;
 h=from:subject:message-id; bh=TlUGfQe5SGDRa6cwwzTDSZ6FsJSUi6EsphJ+q93qN/Y=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmKKfpYdEeSv3NcL65O52Q6sWA40KLmS3LlypmM
 OWgoUME4sOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZiin6QAKCRDBN2bmhouD
 1xsTEACQ1ir52MqKvyLooUpgZ69W7Vwikg8JCHqlcoiyVcgCWdpUzZt5PSobFmBfGYPOBT3CtrE
 6AKdHck9Bcl9qlJIYFWc8H6WmpVpJ7uyO7b5fFhyHQmohr/Jjebk2BkiD+RiT7moRTXQbcSHU/X
 BK26dGd9VuLqr/fAyrVu1byw0k+ker7bphkHXrCPEm8BH/VZtxCjptsjm/Wf0PQ5oT87Uq6kvUo
 +Rgix6XL4qmAn9Drge+Wg0oK4siwsa7IbJgmee+ZRoGDIUFX3fwRYBakJxzCiElYIHUwL78s8Tk
 XaJNZkfYdiPEunSClGsmL0wC1uqE/Rq+5vkjMlzHkkVIboJKGVOxfAmBRJ2k7WPs6AqLhdmuBiX
 RxTAPgC9DhnleQBOygAchT748699qwddqkjB9xJs+811kV4fy+JenWmaFF0TAP/gViuDM8o2fag
 1spjPgvbjPE88zBZcwXIu2PCzGgxbDt0K2wMKX27jexKjl1k/pKqEvVeJ3cAxN+Dmtw7Qk67jbb
 8xAoutLG5wjGC6AlmmE4Hd/oFBq6b/EnWPzc1we+iH8RbeBnLoxViR10wH//2pm1DWv7XprURiG
 3Jrl+u17N9mH0f5b1BjoPUrfjp2iAtquui3kHbzgLBBzyOTe9TY9rnJB5DikjW0Vn/nV1/VitcY
 X7HBISQB3Eu9csA==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/video/backlight/tdo24m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/tdo24m.c b/drivers/video/backlight/tdo24m.c
index fc6fbaf85594..c413b3c68e95 100644
--- a/drivers/video/backlight/tdo24m.c
+++ b/drivers/video/backlight/tdo24m.c
@@ -322,7 +322,7 @@ static int tdo24m_set_mode(struct lcd_device *ld, struct fb_videomode *m)
 	return lcd->adj_mode(lcd, mode);
 }
 
-static struct lcd_ops tdo24m_ops = {
+static const struct lcd_ops tdo24m_ops = {
 	.get_power	= tdo24m_get_power,
 	.set_power	= tdo24m_set_power,
 	.set_mode	= tdo24m_set_mode,

-- 
2.43.0


