Return-Path: <linux-kernel+bounces-48092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1693484571B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AFF1C25662
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F63160881;
	Thu,  1 Feb 2024 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="do8gZS2U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210A160866;
	Thu,  1 Feb 2024 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789550; cv=none; b=V9/tTwodrc50ES3QzRZenZPMTl0HKst3J1QVmpa/EuXrvk4/jK46Wytf+48fb9PMYhWPsVyW5wbmQj3YRHsezrPfZHg/2qnyBqpD3eldDCXmn7uWKS7O/Mecu9wq/LCdzx50E2R9Uw01xSCilOahUcOj2NxiqGDCdfA0dKdyTkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789550; c=relaxed/simple;
	bh=1vbfNovCyxvWc1PBLYclGrDiXSIWmEZA5YvornwGSpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=inP2K4ZeiDJjpbQwoPQo/Yd9AFe31snr25/c3r4aclVxufD2j1jt3Ew9gpJxQ8n0F7ljVfJPgKVMl/BmobU1KEhYySz+OGyU+HkN4QEzr/GZXzVNf3wfwC6Lz8ve7ImGnaWAL9MhijKjbRPIFEV79IYTPGxT2C8EYsGgyO9gXD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do8gZS2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E5AC433C7;
	Thu,  1 Feb 2024 12:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706789549;
	bh=1vbfNovCyxvWc1PBLYclGrDiXSIWmEZA5YvornwGSpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=do8gZS2U9kvnSFjL9B0q0/fwnJAocRkD4uK1LgS1keLJMDw9mm8X9zfEHzXqWgkZj
	 NrenoEnFL1lKPRX7kHcX08wyiWcjZX0a4SGQZmrcYD4CkbHs64sHBCG4NZesHGAi3f
	 gwrmsyVvRDriufzGHZ6RDpukpAcTmn5kWrV5DrY2WA7NNFYQhvfo/tcUTmsUZdeQcp
	 Q77Z+lucpbAmGiwAVTNSl8bZ3G6l0ky6X8bISZw4MYsHum2eAwM/br6Ivccxp+6RJj
	 5Ndo3JCeni0wE4vZvPa3tYZ8Obl+hmBlrHetEkZ9IQYU305dWqQxo6UtDaqy3h7EV0
	 34I4wIbNxAqmQ==
From: Roger Quadros <rogerq@kernel.org>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	r-gunasekaran@ti.com,
	b-liu@ti.com,
	srk@ti.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/4] usb: dwc3-am62: call of_platform_depopulate in .remove()
Date: Thu,  1 Feb 2024 14:12:17 +0200
Message-Id: <20240201121220.5523-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201121220.5523-1-rogerq@kernel.org>
References: <20240201121220.5523-1-rogerq@kernel.org>
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


