Return-Path: <linux-kernel+bounces-144282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D4B8A441D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F201C21522
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754451386A0;
	Sun, 14 Apr 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioHE2FeA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA0F13665C;
	Sun, 14 Apr 2024 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713112655; cv=none; b=MuOC+BHHL8nHMCsKfWmLtB0a1YygpZkhelqhUeYux5+KQSrNIWBCJFu4qyf8qGNHEiSUmG++sZTNOi0ahnB831nljxAvFU2QKR6Tg4AjGSOa+4AbUe9CVE3XUXUYoEhF9iE9SFmvoJcDdNdznzeXgxGuHwS1tGJIerUUjcaV6bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713112655; c=relaxed/simple;
	bh=8FxyQDrDkLV87R/73jNam4JGkAqzpFBP89GlA6wO7Q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FKB1r3YpeeVPEtRFz13qcW6CavBA59ZOrAUCoD2FKq/Dw2WZFeTCdp2LL0zNY8R/1hOYdAKbOgD/GjAGOLX5goBjooTv87dzWWyPLOlpc96XmBk7peJSoljaVELFtd2cxyDMBVpSgE02jp+0Adj40X7/57cchsVZgFlNbZ0mXZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioHE2FeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E01C2BD10;
	Sun, 14 Apr 2024 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713112655;
	bh=8FxyQDrDkLV87R/73jNam4JGkAqzpFBP89GlA6wO7Q0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ioHE2FeAEDw0+ahb8HY6NFpxgtgIGWxwE4Q+yubionYMMlRQ7gziO6B5UAB0YR4Tg
	 GEdu7DB1Gc2dEFWoC2h+9e9nbvTj7ScYg99X9U/adhgg/IKcTHRNCNJUgpHiB+VlzN
	 SfKXDOPm8mbjL00oPYsjtxL3j08fBGqWOM2ku+IRYuXQdV3Jud3uOtAvzDwCsLDa7d
	 GizBufZzBu93l9nWwwim94wif//j18LikgB17SAFd0HUatnhfjcfP6PjVPCpDkRqeZ
	 SVCJ6DwlNIJhY1Qd6ajPLzh+GlZvRMsEaZYKIQtSpGitohakYnZ4oKoTGUMCE76sKw
	 wUIhn5ltpn88w==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 18:36:12 +0200
Subject: [PATCH 14/18] backlight: tdo24m: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-video-backlight-lcd-ops-v1-14-9b37fcbf546a@kernel.org>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=803; i=krzk@kernel.org;
 h=from:subject:message-id; bh=8FxyQDrDkLV87R/73jNam4JGkAqzpFBP89GlA6wO7Q0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHAX/k2/D+kcnyA6+1reXM/8pHT2wciKmhkg+u
 URCGgbFt9+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwF/wAKCRDBN2bmhouD
 11NnD/wOz2KK3FakG68xnNgo93NOUs2plxArscPwAndKmRQnvAqcaTR/URyeZkEPsjF2U35aVuE
 VYarm9v+evFVFe28+iewTan42SxHBlFJ7uT07CXVN6QOYp7S8pq15aLQOGgxlSZFbR5vGmvGzMh
 A7rASh6O0dKGu4Hgxq71tP7SstOBQQSFChzOchld+R7ZIoqJPpe6i0XAxmRYQ0tLraPySTdbEPa
 q0wSv/ct0GugXecwSW35oKrh8YHbRD/YZgUk8fZfkgcxxxEjbF79ovAeh3Ml71wPHaJK64cs/95
 3vP4IaeiV1bW7Yupi65hKDQaR1Yz5iO4zlW/82Hz8xpfJ5apszt3CeqZajKYJf+5zKVLr0MecRH
 O4BmoH5d8x1EsO0/pbUR5casDmtJke2MTrO4BOaQvHfjMpR4jrYbfs542gKaC7H19Ye5qrxX9VB
 bPms+T0FCnoaOSNdavDN4hfr1WS1ldx5r9tk27dxC+qHow5yQ8I3s77Ob9S+cloVXRrix89jpeK
 lMRTkkro54vQoVQ8+AeJWfc21vIxqNDQyrIoSAawu/AAOCXADNsP12TdgSJwVnDQVbKUhbTby1W
 1/lZITTfqZT2iSScZyrn0W4AQWP7wRh6iMCFuFGQeEZ7hhonN0KDi2YIYviByOQ3qtGmWiRAZCD
 GcLjhVeobVDC2Tw==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

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
2.34.1


