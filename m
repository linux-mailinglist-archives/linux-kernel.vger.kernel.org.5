Return-Path: <linux-kernel+bounces-156371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A65B8B0201
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35131F23917
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7249157E74;
	Wed, 24 Apr 2024 06:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCayOCb9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B80157490;
	Wed, 24 Apr 2024 06:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940513; cv=none; b=AWJpYtj6a3Rw+TQhQ1nHjDYKPA/zEplDRI9KFlUt+aNPVU2kDqCARVX7nf+YqOMF2SPd+waFFE47yP47qReorKcS15oIK2LOQw0BfFr33VDb8MW0W3IUX4IfNB+mNPn17sEtbyh/nDHAy+jgL5i2ahhXj+P8u4qssG7L2GrAM8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940513; c=relaxed/simple;
	bh=TF3caa3ZqGW3NOgH68uTY4reTmb6e8Mj1fQjLmrYPFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PiIJBlIQRzldJETjSPl6txTWctxEm7hfwYQa1VZTnvlIlZwrOA+oDDJ52dxLLZT2ai43fHmYn7feluTZtDGCDVRWDheB7cIY/sIztil8Q6CGSZEk4w3ApUu6wyuDpN5NqKI+mS+78WRKsuBiib40TrERj4vudCGOiq9OlhzGrlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCayOCb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C3BC113CE;
	Wed, 24 Apr 2024 06:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713940512;
	bh=TF3caa3ZqGW3NOgH68uTY4reTmb6e8Mj1fQjLmrYPFk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CCayOCb9PaArobK20b5rt2Apv3uGztGWPWg7AGtnOiYsaPJ44MPBZUGAvea4q2aj9
	 El2R2kIOgohiK3WGUGJxBookhaU7W7uIqaAhrLAfc2X69AQi0tXDstcyHNy7+6LDTq
	 LMiUk96lUECfWxGKDBreCGWP34bBOk4EEsfgOXCX4c2hVTrFR23cw4C4wrPpNkftke
	 ZqHlPBm8mGkdfMoamHgw7Nj32lJiNxLKPKkhv35yzqYApF9opngl9YvH+N+ryj+4GP
	 V9VjLY8NKr6Lf2h1mwOj0MrpMp1jmKoGeVnU94JIUl+wQlH+Dvdomb3IslDkjdyEKQ
	 R7JnBo9b/gwMA==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 24 Apr 2024 08:33:33 +0200
Subject: [PATCH v2 07/19] backlight: jornada720_lcd: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-video-backlight-lcd-ops-v2-7-1aaa82b07bc6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=913; i=krzk@kernel.org;
 h=from:subject:message-id; bh=TF3caa3ZqGW3NOgH68uTY4reTmb6e8Mj1fQjLmrYPFk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmKKfj8UNY1aT9ESBvK1M93qQMu+fYxYjOr7aSL
 3soc8KBncCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZiin4wAKCRDBN2bmhouD
 1+B6D/46M9kvA0YB/oh5w0eEzslAekOrDicFVVYkd5oN4eY32nh3e6ZLWNrXU3OQE8mKNxtbwrr
 B/jfvQBcUG51Cq5ZqPSnP7jH5WrJqtI6wOyYcbBrf5MEaKDra9Tgzd8S4W6MLQFiJxFnYiSRSoS
 p4n1rw6QCZlE94mT+TmbcxnMcY56g7u7wIuo3JuyTQV7uE085BxiST/AGsgzaPECNh1BS5i07Mw
 iC+0jNRv/yuGq1ngxpGudmBygCQahTp62C13OXqQuuAMsQUt0gGVT2yy53YV/FKzvUUshSNfMN3
 W6cZ7FmNBfNmQW6IgmonfwTCXs5FI1ZiCZvVdX+nxobwByAZNmVjuRgfgcwin9IkRRKr+NRAuYr
 ZeCpPXhJrafLq52cBlaB/nW6+mfzj0ZZ/vqXln+JME+zNc9PszI8jfvyCS0pi0Xc0O1pbLAtcsG
 NtQfOeLHyRM+k8NNTAADHjUj6GX4lWSDwzLJxIzUEjn30PGDO92zl1yJD1jRT/wpbc5396hsCbn
 bY+kCuVhRtB/tuNjuE+2m62Rx10fi8QlKsILeunGAW8gup8ZR2Xf/dDkDY57CTN6lqK8VJV2Gnl
 Tcc16z9wKL/LltQsbkI2CdjRe1lrEqFaPq87RBvHcaPg5OXld+gXMrbGGgG0ZOV5ukg3aivpgxj
 j6X7VZuCGqonl8Q==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/video/backlight/jornada720_lcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/jornada720_lcd.c b/drivers/video/backlight/jornada720_lcd.c
index 6796a7c2db25..5c64fa61e810 100644
--- a/drivers/video/backlight/jornada720_lcd.c
+++ b/drivers/video/backlight/jornada720_lcd.c
@@ -81,7 +81,7 @@ static int jornada_lcd_set_power(struct lcd_device *ld, int power)
 	return 0;
 }
 
-static struct lcd_ops jornada_lcd_props = {
+static const struct lcd_ops jornada_lcd_props = {
 	.get_contrast = jornada_lcd_get_contrast,
 	.set_contrast = jornada_lcd_set_contrast,
 	.get_power = jornada_lcd_get_power,

-- 
2.43.0


