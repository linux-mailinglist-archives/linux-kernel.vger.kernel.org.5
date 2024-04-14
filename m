Return-Path: <linux-kernel+bounces-144275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 683B78A4401
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA9F4B21CAC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8173137749;
	Sun, 14 Apr 2024 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeMMU6FS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E2F134CEF;
	Sun, 14 Apr 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713112620; cv=none; b=F8gAHPIu4MyR7Htu9cYi7oxhQZ3a4yDYvcvSzIwrDbnAq1GPHmWaBN3xsUCoVJoLk8dWnhp9kPhEun12V6YTyjOtiFn3RbLRjNz+jmj+36jGY3f1OrElPpVNeEPMXRDgOBBDB81IRQGHZaZhRne2dyc06c27tvrerM+MoZhRBcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713112620; c=relaxed/simple;
	bh=HN87+bnoUJAL7IlBvGeQL/RoDv/OEH0jaRmwzfxf1dE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MxxKYspK8G4wKn9qcBjBeADFTFgp27ZbrgSitHwMLO0me4vV8/fNHabjZEgNDQKGcJq8FCUnQiNQHmhSJCP7fY9WgaOoAyXxGC/vg66cW92aTF5a34FnspONBq1ST+nvhpLh4Zk23jVnh42e0/AYxXp99EXS4OFL0DKxVdlg8E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeMMU6FS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CC6C072AA;
	Sun, 14 Apr 2024 16:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713112619;
	bh=HN87+bnoUJAL7IlBvGeQL/RoDv/OEH0jaRmwzfxf1dE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MeMMU6FSWb5n9hNOQtljIiPMUHxLdVnXIpHcQ4mQCb31wxCOn9vrYkInsVSxQE0mb
	 gl038qVp8k8ni2CNLHitrFBhVHBp+LtvMIxuNb3g9AjojaFfQ+PxAAqntAfCOxe4Yd
	 eIj6ZOcImHweaGNDvMiQjdk1P6Sfaa7nRLBCR77KPQjKBZNeeE7E1ca9PKcotu6ukc
	 92vMmGiFwnoyV06M76Srj6SWlIJxVj7udTRTCoWxJdjNJ13i1qJ02PiAGWXbFENwMu
	 Y75c8lsxHLp1uZx42iuFm58w4RROfcX0sryFUTdOkoi0MPIblE/xZd5qpuAqJ+ouBj
	 2SLbOp4UINhvA==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 18:36:05 +0200
Subject: [PATCH 07/18] backlight: jornada720_lcd: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-video-backlight-lcd-ops-v1-7-9b37fcbf546a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=854; i=krzk@kernel.org;
 h=from:subject:message-id; bh=HN87+bnoUJAL7IlBvGeQL/RoDv/OEH0jaRmwzfxf1dE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHAX4+63bobZ341icw3RoZcjAGHReGX0i9wIJi
 qxC8XxXwnWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwF+AAKCRDBN2bmhouD
 1zvbD/9P5ixNHRF0z3le1iebM0IUN0QqF+OrzIxIRFZoqMeu2/JoSwNGddITeLUBxA5QZRhHi/p
 3pFJ6EbfJSae0rkUBvdNSER6Neaps4CeZP9av8utY5eHUO3G91ZdWokBHQXZ55Xhln83bOcxrSn
 dS2cvlRKH7spY4rdjwlGmGtIKZ6nlFGlKMZDExhqTkUkeAtv1xjp2aNUZ/NZTFcCJAzgzit1qdW
 nQAv2uio+RomHmQ9Hv/0AAL6QJb3K4CocFzc8n2RsJykmxUpwNUG4tGg/42faBH3b5HhvuRqdMj
 EB0oQsozQvsDD0LE6MoLg3/C1slaRuQqnMoavQtwEnfmBmpcDY5vEGcuoKii3erxv6snscGS0sN
 nR6lC9ea5D2GtetOkaa3+Ab8W6jWMS+Xb+VXG7PoGk+ZJhisqFiif6ndt1VbYSx1xDYP9RsPW8P
 QK0tMYmHdcMxARGDIaPERSTRN8Nc+oI4syOqUilqP/+fneEl21+SL36hcNIz1THLP+sJU68b9Mp
 TfQN8SU5d7zfRG2VVfjfbGSMFDmMloHeWXOAWMgVwaddilpFBA1ErnAFX5OgWrTQJ5WiWZfFuuK
 R/QRB6NucER1+0LB/Jdhq1oipAvXjFy9RrBS1+ZIvqllxNaASIDvDiB46KsUkLXTWaVexkOmOEw
 +vwRwZY7f9hRXZA==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

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
2.34.1


