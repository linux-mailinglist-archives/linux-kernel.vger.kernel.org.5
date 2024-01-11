Return-Path: <linux-kernel+bounces-23880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EBF82B326
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFD2282B09
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D1050266;
	Thu, 11 Jan 2024 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nisoBO3t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20E50250;
	Thu, 11 Jan 2024 16:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF60AC433F1;
	Thu, 11 Jan 2024 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704991201;
	bh=+q75K7vH+apl/4khPV5F4/P02Rn9eXRp5swe8VqdbCE=;
	h=From:To:Cc:Subject:Date:From;
	b=nisoBO3t1G8MJenBLBJYJ2eSEgRZVUq3hy1k9wblBpjYRq49J2U8Trc7cenwMFKoD
	 3fxzoBofSwVs7ITy/TjLNPaea/32K4rN2BCcjh85+OVBm1xHpWSmOz/eQ9LQ6CUus4
	 EBOU7aQPA6giO+jqE6Lb+/WQttoBbo6D7kwnqbFhINYaw/arh7ixFbzzIGoSHdv7WB
	 hfAP4bG8eWc9fZNHm0AkX/T8DEZS/lykAIFzleSMKMfuppPwknv/MVdFV1rIawBJIE
	 6WR1U3s4xbbCRn3a2PAgyk766sJ0TWo6zc2y+SAO0xguzUZfboIJkFIy84zApH1D6w
	 JPIcRA+euir/Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Keshava Munegowda <keshava_mgowda@ti.com>,
	Roger Quadros <rogerq@ti.com>,
	linux-omap@vger.kernel.org
Subject: [PATCH 1/1] mfd: omap-usb-host: Increase size of buffer to include all possible values
Date: Thu, 11 Jan 2024 16:39:49 +0000
Message-ID: <20240111163949.1976778-1-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid these nasty W=1 errors:

  drivers/mfd/omap-usb-host.c: In function ‘usbhs_omap_probe’:
  drivers/mfd/omap-usb-host.c:706:54: error: ‘_clk’ directive output may be truncated writing 4 bytes into a region of size between 1 and 11 [-Werror=format-truncation=]
  drivers/mfd/omap-usb-host.c:705:17: note: ‘snprintf’ output between 24 and 34 bytes into a destination of size 30
  drivers/mfd/omap-usb-host.c:721:56: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Werror=format-truncation=]
  drivers/mfd/omap-usb-host.c:721:33: note: directive argument in the range [-2147483640, 2147483647]
  drivers/mfd/omap-usb-host.c:720:17: note: ‘snprintf’ output between 28 and 38 bytes into a destination of size 30
  drivers/mfd/omap-usb-host.c:731:55: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 9 [-Werror=format-truncation=]
  drivers/mfd/omap-usb-host.c:731:33: note: directive argument in the range [-2147483640, 2147483647]
  drivers/mfd/omap-usb-host.c:730:17: note: ‘snprintf’ output between 27 and 37 bytes into a destination of size 30

Cc: Tony Lindgren <tony@atomide.com>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/omap-usb-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index ebc62033db169..949feb03d4f8d 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -699,7 +699,7 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < omap->nports; i++) {
-		char clkname[30];
+		char clkname[40];
 
 		/* clock names are indexed from 1*/
 		snprintf(clkname, sizeof(clkname),
-- 
2.43.0.275.g3460e3d667-goog


