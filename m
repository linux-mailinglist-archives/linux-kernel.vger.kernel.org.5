Return-Path: <linux-kernel+bounces-156374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC848B020E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996371F234BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB196158D85;
	Wed, 24 Apr 2024 06:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5MdHish"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA751581E4;
	Wed, 24 Apr 2024 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940530; cv=none; b=SnDvPdRsPcY+8Hitv+i9gqJEEv++vZ0hpN3N4yPe9tDw+8q1iZCFlRFHRq2rC3jwK7ZECm7JEbEf06JfZRs0D7y11KhLKfL8P0yr6nn7jr8IC0c+UP82aP3UjURnDdWDJgeEfRISaYMZxGE0dXUd3kTNtEG29F3teX2AFvMLWLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940530; c=relaxed/simple;
	bh=Fx9+dUHugEQySUivGavZSc1jQG9pzqOGcKVq50f7j2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UGU3SYeMQjR+HFgHa6DQMcVkjKdaiPi0N5YdwxikRjI6negmxchgZyoYikdrBt+y1FefgXUl7J4auu+QgF/a5vWcitDzpisHyG10cBEEJeNJNj6qzZu4yA08u+5mGL+PzA3ylTfL63mmyQ0zL4cj47V+prtOGzjGbESXDf2A1Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5MdHish; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7EEC2BD11;
	Wed, 24 Apr 2024 06:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713940529;
	bh=Fx9+dUHugEQySUivGavZSc1jQG9pzqOGcKVq50f7j2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U5MdHishgJ7jQagQc0oTt3q1QOqH2/YaBbWOsX/kSypATFN6H2FDXnXnce+5Qt8ma
	 bQuYpEM/YxQ0hc0YY0vYeb494KBDiE9FkvGNNNKHtvwP21IB7Pvk/WSr/qlMq4bzJ9
	 brtVSf1klRCkbmWsXOgGcrje1XjF6IyxaY9dChM83od3NikWEe3xKOVIBj8LaLr4+m
	 adXWN4wUE3QuN93zxStXYJqZvjanr2Ir7HUAdIjrTKc9Yn1HQM5NY6TCP9B1sB7NA4
	 kJ8zBLp3p69hUMRqpY+Ehu3xn/KGFa20+gGISmMEpRF0IBMx3GEYk17ktnue6AMo7U
	 OaYmhuIroIuug==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 24 Apr 2024 08:33:36 +0200
Subject: [PATCH v2 10/19] backlight: lms501kf03: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-video-backlight-lcd-ops-v2-10-1aaa82b07bc6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=krzk@kernel.org;
 h=from:subject:message-id; bh=Fx9+dUHugEQySUivGavZSc1jQG9pzqOGcKVq50f7j2k=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmKKfmegAveF22d8Ic3BYkt029VxOLUxwbx0Erk
 cyS30bVh9iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZiin5gAKCRDBN2bmhouD
 1/mEEACTdRL9YoPeEkKv/321ctqh2JcRaDVJvy4M/Z0yDp64Bjc8Ge/LNAUdYGKFaNA999LVNIb
 bQnlLpyj++sZITizJiSMmWzmzKOarsz9C/kdLgkyBw0iJB0jZvxMonKKpNZeG6ILnHqh3ztwbvh
 4rOkavZXKswgw/0Qzy8M47HoJVs84v/xs26CUs+beDV4iDxbWV9VuKL9dC5UEhavZA6cLiDGXmE
 XHRTtYJT+bMhneRxXMSjwp/miVymK23j7b6gsPVA8P173TUGf7nDd8WCD5CsJkbAzm6lnRX1287
 VxkbGRENRt3waOXqhIu/7AqUoG3H7/cEnNL442qZwvN6/JHxd7zpaFH28Lo25TVL5cu/LXLk3VA
 bEExJIzJ2QEG9HKP9qWZV1aGkQ6ncrAA3idx++XvoNwIUBz4tcS36PWuTIPZxHNnFEA3NUV0reX
 2BRxaGs/6gD5WxOn00pIrfU8f6OUSALhMmRwypItHFOUV7BcYIwmeplzF+StNmMHtKpCJoN0b/0
 KDU18UcqJBK9X6kzV/rf21rDci8Femxz3FnboR3Se4D3K/7VbYZ4SjAx336swksupEIzfFSnmfH
 GA+ZiA/9w0p+ZLmr8rfq8orfRxv5w7KlqNQieD+t79zNYAtrPnlOopk+vDPsLUo1JAGuMaAEF9U
 2dVimO3LQyq0JAw==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/video/backlight/lms501kf03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/lms501kf03.c b/drivers/video/backlight/lms501kf03.c
index 5c46df8022bf..8aebe0af3391 100644
--- a/drivers/video/backlight/lms501kf03.c
+++ b/drivers/video/backlight/lms501kf03.c
@@ -304,7 +304,7 @@ static int lms501kf03_set_power(struct lcd_device *ld, int power)
 	return lms501kf03_power(lcd, power);
 }
 
-static struct lcd_ops lms501kf03_lcd_ops = {
+static const struct lcd_ops lms501kf03_lcd_ops = {
 	.get_power = lms501kf03_get_power,
 	.set_power = lms501kf03_set_power,
 };

-- 
2.43.0


