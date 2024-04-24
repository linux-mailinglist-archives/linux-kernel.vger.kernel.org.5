Return-Path: <linux-kernel+bounces-156381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AF38B022D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85A6283B60
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646FD15957D;
	Wed, 24 Apr 2024 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFuT8NXJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA0D158213;
	Wed, 24 Apr 2024 06:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940575; cv=none; b=CkpHKxhP5U1142fhjJ01MnmGAjLwe8EZnWoIzydZiBjUlzcG26eYauDkjJMmvyi6hrdClB59UtaAq/ceau2ov60ZMC24r28wk36gIHIjdgiqPUUmg2I4ctqshlsH/ULYDyZ6aSV5ynXAY5AihxmBdpwnb+7usn5gc4rwpOVjEVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940575; c=relaxed/simple;
	bh=/YPEE/2rx+omz6upF3/bxcsvp1W87Sbaya8j0gn1t6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cvSQwoU/ntCtT9nlUtQjvRbXD8gnQ/qzJsghSDRWRWdaV4ubZd5pCPdXEOXBWOfnoqu5uS8bTmw2GJM6862fPx0axjQv52nBInnlPQMBXkMRl9dcUP2q9QqYsKNV6Y9dPmU1kx1+478PAy2SYhMteR6qn5rEmTZiUBpHkuF05Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFuT8NXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44D2C3277B;
	Wed, 24 Apr 2024 06:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713940575;
	bh=/YPEE/2rx+omz6upF3/bxcsvp1W87Sbaya8j0gn1t6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CFuT8NXJ/hHnZoY45SJJvt+s5B2CBoVVYP/YFem6QLsn0Rqlqhnmr7v79ZNARUJfR
	 FNjSmuyixH77Bu9hQk07WEc08pFi5mrX8C7S55ZjWS+1BvXFuoO0IzDZT1xgKVVSfs
	 QWEwGQxi9CcpxXfa1CFEGlI3ZMpjX7fBlWBvXe2zNVq2M5NTc6liA5RuBvbye5I5Nj
	 09O4M9lXKLJoGSLRiQYH4jX8lFr8LrnDSU88n3w1vFkhBnj8usrATzYOAZMtig0Y8T
	 z1rs8iqXKn2nkSh8BqVoZ5E5jVvGA62HCIWtmKipT5ylX83JwJX14CG2rH2lYmLR9o
	 LRoxjzZmdYLXw==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 24 Apr 2024 08:33:43 +0200
Subject: [PATCH v2 17/19] fbdev: imx: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-video-backlight-lcd-ops-v2-17-1aaa82b07bc6@kernel.org>
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
 linux-omap@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=881; i=krzk@kernel.org;
 h=from:subject:message-id; bh=/YPEE/2rx+omz6upF3/bxcsvp1W87Sbaya8j0gn1t6c=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmKKfs4bgpP3d2adOd0Ir7rb1GXy79RJ+CIs4xW
 9qxa5vheUWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZiin7AAKCRDBN2bmhouD
 1/sFD/sFck3lF4eDnbOwltOZWg+sb8FGMQ+UKhyG8MYCkP7iEPDWJ+nvoqoTam9oXUqVV2lb0WP
 9VA7xERiTmIqdf9UHS5odRp1AyWKRpjYktpYM3i+OjOfc+5zYyQsCjp1BxBGvfjUFQxW7NyND1Y
 pnkY2JR3Xzx5PT91BsutcolYkS9ikkuj8cFjPQIox996BZOqu+IqNzy8KwrIpnv5dMYIdLwsz5u
 kY+qinBwuY7ES7Pxb/kl5GsQ1FK9DrLRv+GwFtRI1xQQvAS2cHzigsq4SLZy+noZpHIElBJmVLb
 LAoOc7l4EQVD7rZ3OMHj/Clfl5u0TqZrOcqxGOt450Y/IWDnKTrLW7NyFne4chqmm5Tde/d9XM/
 gs60ono6oOct7BZJDqOnPJxMl1AGlnoC61vDdTsfDp1qGwgIPENKdMCeH0RC3tPpLXwpRqVKTTP
 iNNeWSkf8buHSq7vvu+5+pJCwcYOpvQLqDMie4P07gOr7cA2GeSPKQL/5WKCpynsOIsPv8qSkiC
 pWZ/i4WxD7ntQkg8FtBOQJWNSOEOl5bwfaktFqMRValfbmVUmi49/zuWHwYMcMpBGpSdDHnBbeB
 hXkFOFihyxRoR6n796SgSO5rLVKi7jcyZGyQnbDW60hXKR6lh5AjCiGDHcW7Anvd8cD+7STNxiK
 BOYfUd6hCxn1ZeA==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---

Depends on the first patch in the series.
---
 drivers/video/fbdev/imxfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index a4dbc72f93c3..4ebfe9b9df60 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -857,7 +857,7 @@ static int imxfb_lcd_set_power(struct lcd_device *lcddev, int power)
 	return 0;
 }
 
-static struct lcd_ops imxfb_lcd_ops = {
+static const struct lcd_ops imxfb_lcd_ops = {
 	.check_fb	= imxfb_lcd_check_fb,
 	.get_contrast	= imxfb_lcd_get_contrast,
 	.set_contrast	= imxfb_lcd_set_contrast,

-- 
2.43.0


