Return-Path: <linux-kernel+bounces-144277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A968A4409
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C871F217D0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A3B137909;
	Sun, 14 Apr 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZFXhqSP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B726135A73;
	Sun, 14 Apr 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713112630; cv=none; b=kICO1gmJhqnlfNbqfyg0LL8CBFHXIK+3ASL9wkyGWtIx2FQ1ZO+JopfMnuWGe+rtGSvm9YfiDCC1/loTCG6b5ojzPsaMDDDrjJW8VzM9s7mjXYx78zzGi/DRN20GYI2dfQ2Y1Q27JRliizprD/GjO5Ea9nzLKxL3z2jLZ3kE8zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713112630; c=relaxed/simple;
	bh=9PRZuiekkNAzSDYyoMZolLynAx4ZVZkWrGnRjQUFxGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DXpKK62m+E0eCN3Dzx/LAfM858zs0t43N6Gepbnjrn81y8d65mABBCnbci/w4llFqPZpcBuQsFO/VGFR2aq2e9aw9RJ8BLlgVngIl4lwX9Y0Q7WsRimVPXUyluGQ9P/LxWmhC6QdW2oM2Pk1ZPZ5g9/9WvtWEFAWTRhOqquWjXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZFXhqSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E3DC32781;
	Sun, 14 Apr 2024 16:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713112630;
	bh=9PRZuiekkNAzSDYyoMZolLynAx4ZVZkWrGnRjQUFxGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aZFXhqSPvWeMNSNEVK9jBbYhQ7/ykvMFtmh8/7WmkWx0+6GNP7uebu5rSk4PWLfoj
	 RHVs4NrbmE5tCebdyZdYFveBZYYX2LUdbRtTcFuY21icrXMKwjASVe3mWS/JH0EZtV
	 p3N5LlJNzfpEPTVWKQAgmD3hX0gsLx2i2tXaH4csVONm4a7wro31zYqQwYxk0gk/ra
	 zHivWsWzhlcg4O7PoVKguZGY15Ww9SU5+xKQQFhba1gWLCRZqoQ3LxlaerjgfcmFo0
	 sIQ49WPX5rlDcD+/3PdRc9iu7riUSxZXBg1KyHNaob8x3Bf3kQv3al0gZOF4h9bTX+
	 K8zT5mleX93kg==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 18:36:07 +0200
Subject: [PATCH 09/18] backlight: lms283gf05: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-video-backlight-lcd-ops-v1-9-9b37fcbf546a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=751; i=krzk@kernel.org;
 h=from:subject:message-id; bh=9PRZuiekkNAzSDYyoMZolLynAx4ZVZkWrGnRjQUFxGs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHAX6j4+WaJabKOvGPBFAtq2KJPij4u46ouLft
 qSZwwZ1hNGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwF+gAKCRDBN2bmhouD
 13d3D/9w2H/c5pLxf94a+fGMQ1bPE6N27j2pCNIEUqOC+F4vkeQ+i4wYIYo+YnnRQRO4SIu6yOi
 tHS7F88R3e+IZudxqHl81/GbHe1xEG84UQVQqNy+qWg8Zu6aXYjEG6j1PikWqL1UJyF7vNMiT2/
 0+tOIti9JxEnMVhfZMHEg47MKVTb54DCTnDEwFGyDFq3LfGHNeCeiNsm37sPpjUwaK+fjgVDBFc
 a0jfsziAVSDDXG4fDIXFwQ/tqZcwakUTMecwPjIl5GSOYeifbNqK6A9Q19lzrTEW/rc2LS/mjvE
 OQtoUxMwDBK3Y+kRt/9QQb/memcRLxDqHQgYdiwQdUqtMKP5npFAP+NLKOqmHIR5MXwSB4Qbf8r
 7YgvtgvoyPXnUYSMnnLdY+YrbtO0KTM3pCa1osg3kyT1elsIKNeotXFaPZqBVNqG82UP5mq/VFZ
 PQrzPuAe2RfiQS6RSfTZjltN5Jf9A4+FN1r5HdEbQETnRqKEsfVMRQ+iHqUmpKd0CngN0y5BxNb
 4k8/OsHgixwXe2sAqfsQ4ZL3LmVWF8bwFprBqfj5YFQzkei3OXkgaB5QBp0OOb+kYRksBpKL+MH
 3jKD8W9plUIOBDI197y66/UMAyEa/uwsgNGWXGt8VtESBKvnTISYWzyJzbJR/09xqZ2xlnRhAsa
 F42j8B1JczV9iww==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/video/backlight/lms283gf05.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/lms283gf05.c b/drivers/video/backlight/lms283gf05.c
index 36856962ed83..a65490e83d3d 100644
--- a/drivers/video/backlight/lms283gf05.c
+++ b/drivers/video/backlight/lms283gf05.c
@@ -139,7 +139,7 @@ static int lms283gf05_power_set(struct lcd_device *ld, int power)
 	return 0;
 }
 
-static struct lcd_ops lms_ops = {
+static const struct lcd_ops lms_ops = {
 	.set_power	= lms283gf05_power_set,
 	.get_power	= NULL,
 };

-- 
2.34.1


