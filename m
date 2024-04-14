Return-Path: <linux-kernel+bounces-144270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75308A43E2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4451B2299B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E9E36121;
	Sun, 14 Apr 2024 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfLqAmbA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7708D433AE;
	Sun, 14 Apr 2024 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713112595; cv=none; b=nv4GpBcRxOw9HKqX6hCPhuBQUuPrQsyypvwet5v1wDzFkV1sdMQdrgbxBY5Wa5yDrp/OArbgPwOrglT9eLvcT1eEUQmO0m8tt9GErkY10o37St16BAGrILa0MXDWTyafoS3dlbNPEKkbioPOy/d8l19YcWFjGH7FHCQ/0q8q06o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713112595; c=relaxed/simple;
	bh=locImdr60u+fZ7AOjuj08IprumN1nXoXaa2rUh5Ga3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uKEK2Pn3RPz0W6ykVE3MWu+i0BOqVdNlBPCib1Z+9jt1v9cFtogtP4AOfnSlQLGD2fHJ7RnS2tpYCPLo7kYhnr96BIpGZONV0JjVUImuzVid7gfuDP0E79SIQLbz2igl5nZGYZCEA6gC3HgNINmWd0URa2nxpwdPerAMgynDzR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfLqAmbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE32C072AA;
	Sun, 14 Apr 2024 16:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713112594;
	bh=locImdr60u+fZ7AOjuj08IprumN1nXoXaa2rUh5Ga3U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sfLqAmbAeMWEejUh5U41VGNkb9k1Q2YKtH3wqONu820BgHz3Citcg4Lwk9GGBuh/X
	 HUMBPoNR1NIoC6GSmdcMeAvaGxxW/r9T65EtmX8XP0dPhSxhh4EABaPZV1Q/ODLZfA
	 7n2K/hCcDFks100ZjS9jTg2Ou5p1YlI2uyJKXBeeIxPLl6ygrGj3t5B7jzCnd89SpO
	 bo8cuqwPKNUG1GeZikAtAlrMsTxlqjZKt5jNyCjgQ50SrYffh9UMTZn5GxUUxfECyc
	 LmEhJP+P5pdwCPtq2fT3eO/olFcRNqTq9wExYTcdvbc3qk9G+qZ1gQklK6vpDwXaZ9
	 wUQRlQ0f9/1wA==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 18:36:00 +0200
Subject: [PATCH 02/18] backlight: ams369fg06: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-video-backlight-lcd-ops-v1-2-9b37fcbf546a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=791; i=krzk@kernel.org;
 h=from:subject:message-id; bh=locImdr60u+fZ7AOjuj08IprumN1nXoXaa2rUh5Ga3U=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHAX0G//dPGlem1jcu7wyCWx2iECQwgsLjz+Yj
 iMRFiGfU3qJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwF9AAKCRDBN2bmhouD
 13J0D/408JzyMPbhs0Mw1cq11iv6utAIyFxvBEUQbR2XuwCHtfstnxZOfqjhMAFI8QtQAyQmIx1
 RiXksGCaiUiokpVQHOJc6zvFll5pBn4RGyqgxPVCwlFlNPLoPnTvoYym3Z4VgjH1xupmLDYz6/D
 sUeFZwRwRiamVTRzBZ/7TJMqVxuweEmqFnY5HfaVPGJLMq1BSiK5mnfZpEiI92z/2lvtXj9AScj
 GEnyaoug1JyqbSjUWERCNKkPkNs9+8f3nbVH2fhJgrxCgakLdT3PrPrdftFzqWwaoIIxF9n9br7
 dPNhvfVAsqKaS4IMLmLVSs5imuZnr6tc62bnMNazLwENfgzxqKb8M9DI8mhr+qDsc7Uv9foYoHT
 HyRPXMUNxAPD6A9veDNODkDHJfm4ocmf4+Zx2WZ25sQ8pqPEFFY0tiYdsd2cYySpNqOoTSYetWr
 /wRI/hWv2i1eFEdtQWXlEP/TLN52GZKpL2YlwkEw9VasadFOhyY4JBI3WknQAufASV9HbQGOqxn
 Kjpxg/uj/dg8HhL3Qr5YTepKONcZXy9psyRKi286V1JEPU2JrqYhNgyUK669XCTZDlbhoDW5pZ0
 sRFKUX7DMdzrivAvdrVVwC568IterSQNqoY1cKuos++QJ7JeEkV5Ir2hXYbQh4xm9+seQ1ohSN+
 BdTYNwNnz7HvOyA==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/video/backlight/ams369fg06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/ams369fg06.c b/drivers/video/backlight/ams369fg06.c
index 522dd81110b8..57ec205d2bd2 100644
--- a/drivers/video/backlight/ams369fg06.c
+++ b/drivers/video/backlight/ams369fg06.c
@@ -427,7 +427,7 @@ static int ams369fg06_set_brightness(struct backlight_device *bd)
 	return ret;
 }
 
-static struct lcd_ops ams369fg06_lcd_ops = {
+static const struct lcd_ops ams369fg06_lcd_ops = {
 	.get_power = ams369fg06_get_power,
 	.set_power = ams369fg06_set_power,
 };

-- 
2.34.1


