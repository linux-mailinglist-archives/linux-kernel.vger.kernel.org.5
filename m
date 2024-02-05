Return-Path: <linux-kernel+bounces-52790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3087849CAF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0271F25D30
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AA72C1AF;
	Mon,  5 Feb 2024 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uz8UiBt5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40EC2C18E;
	Mon,  5 Feb 2024 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142351; cv=none; b=YjSkxp7p/0O9fhI08kHSAzXRCJ/Z9dj7Qo76cg+FHjbgEUKhDjHxxaW/h6YAk5YO20G/d8dCifbnVrz90MEcgUe0/C6w7S+Ec5k8y8cQjwOE8G9GIV08vAiZexJyJv/FJ6YI8+hX1yRSPdC8XXVKS2hQnyQwpIgmWrr7sbBXXxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142351; c=relaxed/simple;
	bh=urtEjxHtQ0tLs7UZipwqHGtE50M7Twxd9Gk6q8wZNtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZ0wWP59UQ7iSk0jJfrB7oh3lpIQDOEuXqhw57ETHUYIQnLMcd994svHVHLj2Qwnf24xNrH6wD9BWK6sBSuOhovUigRNI+d1wxiZCp56VKeA0yM3X20ZhENkmUqo7acIGNhxYVrJz0RtLQDFiIxsvGS9SwSXkiRrqR2GSpkzjYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uz8UiBt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEE2C43394;
	Mon,  5 Feb 2024 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707142350;
	bh=urtEjxHtQ0tLs7UZipwqHGtE50M7Twxd9Gk6q8wZNtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uz8UiBt5bRPMD4HwD+/olBGwvQbDaf/0O0BIuMXK2lvtCZzRVcfKhBWO7GjvmHfGd
	 1cTvJ1gBEB7iRlIinS68oLTnagFFXKL54o+vvQcWKKelUpALVxkD1VBLiuKwkwwhbc
	 jzU2wUfGJ+hWjRJJH2EeHH57OuDjfDfLY42ZXQtVM1INpo4oEI4bMTxhm7Pulj1l0t
	 rzXJzF2nDgV4c8CSXooChGuJshXlWAQnRNCuGSVPzwt2/gzDrR99YEqGlAqWrfx+6u
	 wIZPEhAlFgYLStapgZkjWwVfyq20lXpBs0/oiBPKuvs1aIXHA1p5aoNErdtTvLeMoe
	 K4CqkowwSzQzA==
From: Roger Quadros <rogerq@kernel.org>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	r-gunasekaran@ti.com,
	b-liu@ti.com,
	afd@ti.com,
	nm@ti.com,
	srk@ti.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 1/5] usb: dwc3-am62: call of_platform_depopulate in .remove()
Date: Mon,  5 Feb 2024 16:12:17 +0200
Message-Id: <20240205141221.56076-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205141221.56076-1-rogerq@kernel.org>
References: <20240205141221.56076-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We called of_platform_populate() in .probe() so call the
cleanup function of_platform_depopulate() in .remove().

Get rid of the now unnnecessary dwc3_ti_remove_core().

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---

Notes:
    Changelog:
    
    v2: no change
    
    v1: https://lore.kernel.org/all/20240201121220.5523-2-rogerq@kernel.org/

 drivers/usb/dwc3/dwc3-am62.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 90a587bc29b7..1bfc9e67614f 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -267,21 +267,13 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int dwc3_ti_remove_core(struct device *dev, void *c)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-
-	platform_device_unregister(pdev);
-	return 0;
-}
-
 static void dwc3_ti_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dwc3_am62 *am62 = platform_get_drvdata(pdev);
 	u32 reg;
 
-	device_for_each_child(dev, NULL, dwc3_ti_remove_core);
+	of_platform_depopulate(dev);
 
 	/* Clear mode valid bit */
 	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
-- 
2.34.1


