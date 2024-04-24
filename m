Return-Path: <linux-kernel+bounces-156382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0F28B0231
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1253F2815B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E526158856;
	Wed, 24 Apr 2024 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIQPaSra"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5922157A74;
	Wed, 24 Apr 2024 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940582; cv=none; b=tLtciTEDVWxs7opZGKfRkVYum4q0YmBfw0yQqYyi8IHv2WevCvBG3yOSevO7I5qDGhJ3/paQbnctlMzrxbE5b+5MLW9L9CkKSeOrdz7Y2bYZckV7kXivsv3FG9WBEPkBUSTgSNHDpIxyVu9o9F+0dSNa7WoM84BhmUhCONmyy/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940582; c=relaxed/simple;
	bh=pWTvPRblCBNixub9cvr1im1fK9AjWZstRNm/LOmLlSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=huk6gfTUxOo8cqlrdanczqLuYWwfb3yJ7uSM1JhGYiOiRvipzIkOHnKGoUIrinz/2wBgb+/KWFbWwJyCnvyGHfFpUag+f2C+YKZd6/upQENCyeRyXAxQF4OQqITffQ6f84veEBCRoTHy/KKCfmGlxuwafgwsZWvJWM+CI4Cafoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIQPaSra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF753C2BD11;
	Wed, 24 Apr 2024 06:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713940581;
	bh=pWTvPRblCBNixub9cvr1im1fK9AjWZstRNm/LOmLlSI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kIQPaSraYPpkNqJDLVq/3V71x9Avn1Y9IoOIrwoekLAQpP3c7BCJokvWe689hhPjt
	 COYj7mpX7bT2DrmY/MaiEftznTdE0IQb+PwDAStni00s/0oDChvHoMRXH2N35tbEjH
	 +vTXzQnQSBs2hXQ6cHZgWzu5yaTyoXS+0TqUqRBZEDosFajGodg3dtGv1DJ/3+Qel5
	 /LIuo0OYzuuWJptpSDZ4bZDGTQ3LZZYGCyPkd/AkigBZbs4WFyVaCw6LDXSsfNF/jS
	 oWEMEt0qIocGFIf6H0jpwz9yUzCPMnhvf8p2dWRQjGn/f5J9vgX95q7ojmjO5KOY/N
	 xMfRn+sgRCEWQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 24 Apr 2024 08:33:44 +0200
Subject: [PATCH v2 18/19] fbdev: omap: lcd_ams_delta: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-video-backlight-lcd-ops-v2-18-1aaa82b07bc6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=krzk@kernel.org;
 h=from:subject:message-id; bh=pWTvPRblCBNixub9cvr1im1fK9AjWZstRNm/LOmLlSI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmKKftmm3FnyH0c8ZapIjiaRSDuKNvLbICJ53Tu
 +qqRZuB/++JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZiin7QAKCRDBN2bmhouD
 1439D/4pVsJu1f3Xvi8hmVDQuIos/Maf1iCjIvbsiizAkfBoWwXCLqk1SASLj07n928Xg4D9SpQ
 WBE0WMVTqLfw4u19v+WqNunGMsUkIExGU+AAQZBGEKmVg5VxCLiAdSTnc07Ys8GdLD7S4UuymFb
 ijeT4ucSJ59hfRJgHHpIhdphNIV4CEYK7dd+hbpEhBYMF7w0ThaQqAxS+X1RMCw2nA1N1+/LyeL
 H4wKncClZmWa7dZoQMlN/wWeaP4m9rmdRmsSSdOuJhKthMlvQLM4kKIAsub0hbqFgsKR9BaoK1v
 wfTpyIGN4Ukejfgonf7bl+zV4brZKhGdmtZZMH5Avae76ZltNz7zAp4+ZGFNmbZQT36+gKyudNE
 YOxajN/1/XbXexKojbn/jxmt2vsqQOD5zf8MXOdPV7iXCJTOGGuc/Jt/a89ynfghenxeYUh1gTS
 1gRRzUrIVHGa93CVsI0JO9gSK9KwfWtCik2o2Fx3Iwp+A+erxOenVBDzQrSJgtDKTx2orjlm4OF
 OUFSay5KqPG34pStikdgKaP7JhV/lSSHIfMt62G6rjRFemrh8qdQPKkG+AY/BfMEdwV/jrdgAcP
 SLeU4QzlBmsVYZr1fFY/0Zmut4OB2Y9yEM9LaGkb27v2oIw8ro3o0JDOFfSm/1BkV5S/nzMfBCA
 FpjLE4ux8x06WZA==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---

Depends on the first patch in the series.
---
 drivers/video/fbdev/omap/lcd_ams_delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap/lcd_ams_delta.c b/drivers/video/fbdev/omap/lcd_ams_delta.c
index 6f860c814d2c..97e2b71b64d7 100644
--- a/drivers/video/fbdev/omap/lcd_ams_delta.c
+++ b/drivers/video/fbdev/omap/lcd_ams_delta.c
@@ -76,7 +76,7 @@ static int ams_delta_lcd_get_contrast(struct lcd_device *dev)
 	return ams_delta_lcd & AMS_DELTA_MAX_CONTRAST;
 }
 
-static struct lcd_ops ams_delta_lcd_ops = {
+static const struct lcd_ops ams_delta_lcd_ops = {
 	.get_power = ams_delta_lcd_get_power,
 	.set_power = ams_delta_lcd_set_power,
 	.get_contrast = ams_delta_lcd_get_contrast,

-- 
2.43.0


