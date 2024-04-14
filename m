Return-Path: <linux-kernel+bounces-144279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAC98A4412
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF341C203DF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E7D135A73;
	Sun, 14 Apr 2024 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mvk23GC5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D643136659;
	Sun, 14 Apr 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713112640; cv=none; b=NaUiTbusIB4yjiDeK2667xjwxGA457Bu1UvUIw38bVIAfIz3BNlN7aW4qUmmKgmBAOVP8Gx9grNpkX+LVEJOJHEs+lXuXhL9adwpoTorDKauB2iYWbOrrni+urgIeZ5YjzQ+jFPAhOrMeUIXp9e3A8n7QF/vs6jWKNB981g94JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713112640; c=relaxed/simple;
	bh=tv/dXn/1EbAmlxq0rha4TdMh0Fw2XbAyNvTO8VxWrfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HPX8RooUODrghZ5K03q1eqqCEtlSt7PekQIl/CX8DMUuPyXhhUNP+B1UW1pWwZlLzC5FdMU2I/mV7nFsT892liyvcxsLUOz/R+wzvYM5WkT9Y/sLQhNIyam/YJ2gVKBcEeM/VTirHdMt69xp2I1ws1Ds/ClpUWvHQGqn18/wvDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mvk23GC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378A8C2BD10;
	Sun, 14 Apr 2024 16:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713112640;
	bh=tv/dXn/1EbAmlxq0rha4TdMh0Fw2XbAyNvTO8VxWrfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mvk23GC5o/KR5hw1yWUHcOQ0JLquZS2XLwKhnOVYMKdirBuGyTwcfaN+spOOlHrFV
	 a6cr5vzIwlqB5egzmrQwYLc6P1H2wfSvzfHvfKIBoeX1CEmuxxeFb56EI76gmNQaEI
	 OBtOj7EPggVqyMDdUXVBH4BZMNlUSgmmFZwe2oEq+82xrXyFNF0ONBA5HfMU1NFNS5
	 HTksyUGRMQnqSn/vCP90kw5M3HLyAelC6oth20SikqrU9jreuozYkWligLWjHHRHil
	 W/yQCP+mrAw4PHkL1cQMy6q9N1hs/r2E7CDUcwFH23dAdsV6P24WfPebZwAzJaK1Dc
	 bRckeg1m5mLVQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 18:36:09 +0200
Subject: [PATCH 11/18] backlight: ltv350qv: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-video-backlight-lcd-ops-v1-11-9b37fcbf546a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=749; i=krzk@kernel.org;
 h=from:subject:message-id; bh=tv/dXn/1EbAmlxq0rha4TdMh0Fw2XbAyNvTO8VxWrfY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHAX8wDeoy2AroJzqYcLrxCU3NYrvz7HErxPGr
 bgi9VsTRwOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwF/AAKCRDBN2bmhouD
 1wjsD/9/W97+MJ3uicCNV/2XKOLdqkedzANr6kez8MtBavyVmvfC7h0iTZH5yIeMMNDuVPLg9xT
 ZWPrX9sav1psnR44KEwM0h1eamFmVqIBcO49w6A6yA2mEdaC5PI2UggRle/lrpMJfNx7z89k6HL
 yRZEGh1dG9p+OfIccTjIy2p3+e4nvjUA8eshh4buTQhZgD8k3e6P2fwE7zpVP3jUkabpT3I7g4z
 Brc6v1wX/cqVTD1A8f7kf7nF68Ocb5f/ZN7hxrFl+9ljz7aaNrLVswNe0EuA3sX22q4sqooOtRj
 x2DFZHEEJCICFDYwINUTGTYi7EbSz5Ne/o2zv6r1//DGOENjl100DakAHSx3mqoETEQv1ohC4HK
 yGsqQrCfUqH02396CosOrt/6DzZZnjXi7yrNUjW7CYeeBOC+cY/L+lOmi7uMVETNBaNz08HtntL
 xyXS9SnIZnlmBDh3wrdJgfrAKeYQJyCjc0pBm+IVcehLZgR9TbbBGo1NshoJ7Y4pMDN+EiaebtW
 PB/y2PzhKkgcvcZEQhO8OHrBMapLFrsW+Y637iBopoU3U5XfZ504XV7CouHJpbUO/ai+iIyQakX
 YaQ/v7cjq3l+OEHiFPm6iXt4ip1pXARzNmoevjl1yM1B8x+Ehfp7CMmB9A+lRahHdaJJmIz4I+L
 fPjRr4wPjGU4WZw==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/video/backlight/ltv350qv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/ltv350qv.c b/drivers/video/backlight/ltv350qv.c
index d54f501e4285..cdc4c087f230 100644
--- a/drivers/video/backlight/ltv350qv.c
+++ b/drivers/video/backlight/ltv350qv.c
@@ -217,7 +217,7 @@ static int ltv350qv_get_power(struct lcd_device *ld)
 	return lcd->power;
 }
 
-static struct lcd_ops ltv_ops = {
+static const struct lcd_ops ltv_ops = {
 	.get_power	= ltv350qv_get_power,
 	.set_power	= ltv350qv_set_power,
 };

-- 
2.34.1


