Return-Path: <linux-kernel+bounces-82950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 663DB868C21
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F291F2358A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCAC137C20;
	Tue, 27 Feb 2024 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmRsNwsK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD0913664A;
	Tue, 27 Feb 2024 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025876; cv=none; b=QH5NnnHhwBat7h/BDQNRmG2RBMKH+Kbv22eHCgPJiHckuTeCXkdLQhLrZZyyxSw8/8FWOr3wxT8jC2S6fZKdXQ2qge4rS5mao7ehl2jvuk/4FyU3qCW1AGla8fSOBreYbw0A2vaYwXehbui3mid+3aQ+BGgt/Ax4LcKvE/XQlao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025876; c=relaxed/simple;
	bh=Sz9nJ+PulDCcEx0CakS2YZwWogDhSl4ZmUdI8Lrp4Vo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aAXf4+cRxo1qXSvGkbI2/ewUZ6cvUopXdUTWHwSdn2FRiZ2MwqCYomJCydtwUfnTAxAM/uIG03rFKFcfdQNF+8oY0RJ6LxbU2VzSM+kxEKd6l7HDVotRuW7/56ATRSuuizemsm3PHY14m04xcAzCLpVqmOc+/eU0A+LPiACk/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmRsNwsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8023FC43399;
	Tue, 27 Feb 2024 09:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709025876;
	bh=Sz9nJ+PulDCcEx0CakS2YZwWogDhSl4ZmUdI8Lrp4Vo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PmRsNwsKtvGQ9cJ80zmJ0HP44AZeJirwM22t9rswcm01rqqa0JtweHmavVDeIpLLk
	 konkQW5imB6yfX2fZerQcHHxgeeOVSrToy3cnyOKho4yTxtqbnlCgeQ/owHO8kpZ0G
	 RHtes9HwMz3ieabI+DMUcPR1Z8BwLkXVvZYVZjb6iwjzFFhnRBkvVFRrcpcsQYquLl
	 AmIELSLt8R7dRprg4NRTkaQm03AjDwXGHuI8ToVSRZS3mHdHZcYL23OYnAQhSNmDcs
	 KFs6EdseKZ4rEGTkgevzeMiaFYU/PdjRYTmEXcqIHYpKUGjaah9TDAFiyqIJy6PtMI
	 tDQhs1lpHzofw==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 27 Feb 2024 11:23:48 +0200
Subject: [PATCH v4 1/4] usb: dwc3-am62: fix module unload/reload behavior
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-for-v6-9-am62-usb-errata-3-0-v4-1-0ada8ddb0767@kernel.org>
References: <20240227-for-v6-9-am62-usb-errata-3-0-v4-0-0ada8ddb0767@kernel.org>
In-Reply-To: <20240227-for-v6-9-am62-usb-errata-3-0-v4-0-0ada8ddb0767@kernel.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: nm@ti.com, r-gunasekaran@ti.com, afd@ti.com, b-liu@ti.com, srk@ti.com, 
 francesco@dolcini.it, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2306; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=Sz9nJ+PulDCcEx0CakS2YZwWogDhSl4ZmUdI8Lrp4Vo=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl3apLdZV3c/YRSrpT8MJFKw9rBW2nha4QHRRpS
 NaW1tkqrM+JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZd2qSwAKCRDSWmvTvnYw
 k7GZEACZjsNT+oAr16VuQSY/QKXAhqsRqg/vlQYuM6jZlUwflmfwRz+VCn2tddGa/uYE/uqT9Gm
 ihLdaH6OngFnDLnMBdFArcbl1evom77uA6g9veSc07gkULgwyo+VqlTS4kAVXx2hyQS0kz18RoV
 wjZxmaP9kDUo0oFwl0VFC3FLaWgMUFUGOvUVyrilu9UF0CfsUep2qPcENqeemiVYfyXXFeCBvO8
 OHt15Uky6dcBkcTfANO65g9pPc8rqwj1rUNozOVeaO+BY9j/z3kjGnxxB5HXO+Y3OsYDDMriYDX
 ivcw7mHcOi30XmCxUUjNzTZ1s/azrhVGlHQ+xbbyKhXQ8Bpgt4Die8vpmBaceSsRv2TPyOwec6O
 d+b6UqPhnUygsskZwkzCEofmr9Z2V2XcB7Z5PpOXKmMr6usO9A+F3xf37ylhFYmPlb6ZgFaXfhS
 ojdK5tHut0M4UIoxIIrSNVkh1kVZOouvXxqkOuQ1d0bUVl/ts2ZyERXwjje4Na7JwHoYd73Hrrm
 3EJtZcfkCpYFqIVz6QOdASrBSuOfAMPqc4RDeovx02dECkuR0e4uH2EEBYXzqvS7iVhdUu8e2Qd
 HxFcxXFNw9BSlG4Li/Dh8hGNgB/KeFQC0VI4X+8hD0PE181FErJYomsLeyJea1XcwsHGvejrnKk
 lPGopMG5MC9/7FQ==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

As runtime PM is enabled, the module can be runtime
suspended when .remove() is called.

Do a pm_runtime_get_sync() to make sure module is active
before doing any register operations.

Doing a pm_runtime_put_sync() should disable the refclk
so no need to disable it again.

Fixes the below warning at module removel.

[   39.705310] ------------[ cut here ]------------
[   39.710004] clk:162:3 already disabled
[   39.713941] WARNING: CPU: 0 PID: 921 at drivers/clk/clk.c:1090 clk_core_disable+0xb0/0xb8

We called of_platform_populate() in .probe() so call the
cleanup function of_platform_depopulate() in .remove().
Get rid of the now unnnecessary dwc3_ti_remove_core().
Without this, module re-load doesn't work properly.

Fixes: e8784c0aec03 ("drivers: usb: dwc3: Add AM62 USB wrapper driver")
Cc:  <stable@vger.kernel.org> # v5.19+
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changelog:
v4:
- added Fixes and Cc stable.
- added of_platform_depopulate() changes here.
- drop wakeup disable code.
v3: no change
v2: no change
---
 drivers/usb/dwc3/dwc3-am62.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 90a587bc29b7..f85603b7f7c5 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -267,21 +267,14 @@ static int dwc3_ti_probe(struct platform_device *pdev)
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
+	pm_runtime_get_sync(dev);
+	of_platform_depopulate(dev);
 
 	/* Clear mode valid bit */
 	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
@@ -289,7 +282,6 @@ static void dwc3_ti_remove(struct platform_device *pdev)
 	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
 
 	pm_runtime_put_sync(dev);
-	clk_disable_unprepare(am62->usb2_refclk);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
 }

-- 
2.34.1


