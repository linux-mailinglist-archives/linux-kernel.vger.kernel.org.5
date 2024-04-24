Return-Path: <linux-kernel+bounces-156380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDE18B0229
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515161C22733
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B8D157A6F;
	Wed, 24 Apr 2024 06:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BofvR8jm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B8D158213;
	Wed, 24 Apr 2024 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940569; cv=none; b=HB/XtuKGIcBpBxRh8nCZOVcusd+fNAbNwdWss+E9l8qHxSDrP51mpEGOqewQuSSeROYrydZbDyyvTqaQh6d8KCM3OgxctilQJDIbIUAnQjk/p7AS8P0Qz2NE06f0r6AQ0UHXS3iqoMPO+JyNfltdbbgHQGx6yE+BIxRgh/nsOsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940569; c=relaxed/simple;
	bh=QXNbru9NGCM4zVjapmJStHbmabBPmDui2fkd9b5Wp+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9Hyl441axlE01KVNIozfckAMLiQ2F0JjdQWJyG1R2+2uCpTRj/c6/fOBkY0Gx21B5sEK5NU3yZsW/N7ur8Gvj8lB+/IXlXED/o9Au0Uscer6HQJqFjr6+U5nNbuzYu+gWfA/0JX9vyhzl7EJra0lEQxT4q7B1ndY7kXlkrCbeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BofvR8jm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22BEC32781;
	Wed, 24 Apr 2024 06:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713940569;
	bh=QXNbru9NGCM4zVjapmJStHbmabBPmDui2fkd9b5Wp+s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BofvR8jmd7tGAhSPhM5vQMq26iwVvH5F3HW8ePprhNk19eXYDtHX6lZG/SWQDMYWg
	 XzZdv9MNMRMqOdIgNXyHaUzcKFEK/3eNOa2A/2qbs2TSRZ+TB9C3Ljy4ZeBe8bK3p5
	 MsGdvitCvClvDspseWz0bP0QjeTIkZNChzEXby5Pm6J1iYJwxxArKigy2Yb0/gmz1J
	 c3HI+AYLldLP0JD3XdxsNqbdZQ5HQmJLvcfGD1u6ALrV3urXjIIKvqSQHyQyvgKmKL
	 0y1TiqExvzM3jvCXFdAqB018mbkFvdQCXYYUGanZZKesrObijH7jX8Ugnb8MIG2t8b
	 CYH3Fe3fziadA==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 24 Apr 2024 08:33:42 +0200
Subject: [PATCH v2 16/19] fbdev: clps711x: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-video-backlight-lcd-ops-v2-16-1aaa82b07bc6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=917; i=krzk@kernel.org;
 h=from:subject:message-id; bh=QXNbru9NGCM4zVjapmJStHbmabBPmDui2fkd9b5Wp+s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmKKfrWj28tn3LWcrTWjpauc+CvW3QK/dCOFObz
 J+UNlWsn6iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZiin6wAKCRDBN2bmhouD
 1+mlD/9fb+7DnzYZGRX01UeoybWGZDF3nW2aZbNa/mxgyWvYxm2HUqUy6zj3+qcMguiOVh+mbnQ
 xZd1j0wOjnPh4DM2W1QiGwefia+jAQb8f+QYYzMLxLsaDYguizYmc6TpxD8xKdEfptig/ZCzznF
 p4jM81f4pLxrPvzonNCTfd8r77oKD+Tny77r99ccMpikICEumGkVdAA2x/kfnDDetDapyLWI7R4
 UnfBgk0IYvrOqEdIElmoAuQc2SBDxB2tD6//eQX3DbvKHiOosQPTtHJnCC9f9vffXQhkSXVwAMn
 wfQPHg3tbyiJtyAU1hlqv0O28v348tNwpbNuh6Tl4ziXWh10Fb5vIeSYfXKvlrIZeWGlT1zMP5m
 yca87NFkNv1xlip8NZdgbPCT6WdkLzaR9O84m6I53t87gUlI4WFv/96xiE6S9tJeohMvn1qdEm4
 ZgTisIG90u9f3z+qmFZYutXfS5rNdqmuYacwV5SxQ6Mw7nJaB+4BEwUWVz+VdMA0DGRwWyuTJj4
 Mxtww40VTQ9dDBJPDxGeBqD5W2GmSX3P9eO9lvoVDziI7jDH8HWHB2Qo4ju7VjADL9bDb6jMBID
 fosGm3DXO8XIC3PbvwPlWpnxriTNg3kfkEov7Lt7G+sB4SpElYFI3pUYdedgWhWloeK7Gy1axfI
 NFvp7r+k8E0izTQ==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---

Depends on the first patch in the series.
---
 drivers/video/fbdev/clps711x-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps711x-fb.c
index dcfd1fbbc7e1..6171a98a48fd 100644
--- a/drivers/video/fbdev/clps711x-fb.c
+++ b/drivers/video/fbdev/clps711x-fb.c
@@ -197,7 +197,7 @@ static int clps711x_lcd_set_power(struct lcd_device *lcddev, int blank)
 	return 0;
 }
 
-static struct lcd_ops clps711x_lcd_ops = {
+static const struct lcd_ops clps711x_lcd_ops = {
 	.check_fb	= clps711x_lcd_check_fb,
 	.get_power	= clps711x_lcd_get_power,
 	.set_power	= clps711x_lcd_set_power,

-- 
2.43.0


