Return-Path: <linux-kernel+bounces-65001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCC585466C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050761F220CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3F717C61;
	Wed, 14 Feb 2024 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8c+f7gA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC7134B7;
	Wed, 14 Feb 2024 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904114; cv=none; b=Sr3NYNxq3w0poUbjr6FoJVEka2ZB9JlzWo+wR0+VO2a2nC6idHOf+KJlwkmqkxsFbmzAB2E2/1upWfSpWCRHGo+KeyMLySN1x5DC9Ey/hnJURWyPEyEF0ulQWIfFUjzQqhxnjf+2R6/33NCcFlsZy0Gd6IELgnffNqiG+Fd2UgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904114; c=relaxed/simple;
	bh=X6q1RJmRQMsVDI4YiUe1YyTnSAgbGDQ417oRLZK4lXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uWNsOqT3ii+ra9H2TymC8JpFjYGWcX39yDUc+o0CIv7sgbG7M6uC/2anaGgJgSUnGeT6XnQRMZnRgQvm0Us1mPEQfNnPY4yJZWtt6rVZ4i0l3nVkJQoYJATrnPSgIs2IRiwqE8TQTyk8c5hZviF0flWOLccL/F/KSLCdlmBSBS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8c+f7gA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BBEC433C7;
	Wed, 14 Feb 2024 09:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707904113;
	bh=X6q1RJmRQMsVDI4YiUe1YyTnSAgbGDQ417oRLZK4lXI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c8c+f7gAoInFPPuMVB4yAtDaQAsBeQMYAs1JZDObosYWgmk6ShzYpJeNLtasQJkPH
	 5GZqqFx0ZokEJUKJsNIon6mxzdy8buXVPDmy6gpzo53reFivF1XJMgn3nSYpgZj76L
	 DkJ/DA3Y5g4Wg3ksoLXBz2f/SWar0SCM62zmJnvm9XBbWCrH1IAj300Gx8dh2qh/Ol
	 iMLV3SLaZ5JcsaHjUpmOgOPyX+UkgbQSs3/4bjZZYLqSVtx/tjh99t8ZWIo30RgU6t
	 TaowW00cSEOT9nTSNRjiXati2xRUenFmUqvsXiV0raQYHQjELbxshpOv1WGb/LNN6v
	 XqS6wQxJMvq8A==
From: Roger Quadros <rogerq@kernel.org>
Date: Wed, 14 Feb 2024 11:46:46 +0200
Subject: [PATCH v3 2/5] usb: dwc3-am62: fix error on module removal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-for-v6-9-am62-usb-errata-3-0-v3-2-147ec5eae18c@kernel.org>
References: <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
In-Reply-To: <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: nm@ti.com, r-gunasekaran@ti.com, afd@ti.com, b-liu@ti.com, srk@ti.com, 
 francesco@dolcini.it, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=X6q1RJmRQMsVDI4YiUe1YyTnSAgbGDQ417oRLZK4lXI=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBlzIxm+plz9xtRjCi0mKOJqe+jko1TMnexVm8D4
 lVjylqMW36JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZcyMZgAKCRDSWmvTvnYw
 k7LDD/0aKob4z9hUZeVJF/q1v63kbVkPai6rpB8aVtdKAK7hM2JeVP57ozvkWCIryJJ4I13aV2d
 cQV/C+ivi4BluDvr+zPm9PtddmGfuF390+KyfwM6BRwwZBag3IKQtPRv14Q/HXTfp6iXgZQvAQI
 xYWuRBxojnoQDL4i7X5CzdF1XImo/4PymMnZS/BGaAk7aV6o+vL2lZqlYlqJFv6bMLB3AtCIL6x
 56Yvxb8lfCrrBaZ455mKCO5kMS9WRw+MoNCJZ6RYGwe97L1rD4foauUK1QzIs9wB6+Tr9NyuHki
 92quRgRF+axVYAmA6s0L1bj2nuvEnfCFOBbN0kGuxCM1dTTuyR1ZorR/vKxxQweIew0qWbeKwdE
 nOHs8UWZhoiVs9DdTsuBcGzdzTVcVPAPkgwxZ8nAmAATCe7+D4RFH2thsKqDVUgW/3EJzyfXlf7
 2a6WtfIGgVA897S2A5mvPx0zErxkrYO+E5CEtbYSZe/yIfL626Ajy1ZruMwSJW61dxxHj0v9eD7
 pE3Gee2tInjDs2Ag3HMnSPwFbven8qDKuvop0S0nCaDv138wt19ot7D9Z1O7ssSTwmkTtFEs5Lu
 0s99/fqcz53OgrH4UOh3crXi9ezqypu3WIYZTAFcnwtzeY6Q/w+ZVQp+aCqdADij0M6VtcQOwRr
 QGrpEfxBdSIn+Cw==
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

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changelog:

v3: no change

v2: no change
	https://lore.kernel.org/all/20240205141221.56076-3-rogerq@kernel.org/

v1: https://lore.kernel.org/all/20240201121220.5523-3-rogerq@kernel.org/
---
 drivers/usb/dwc3/dwc3-am62.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 1bfc9e67614f..600ba9cfefea 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -273,6 +273,11 @@ static void dwc3_ti_remove(struct platform_device *pdev)
 	struct dwc3_am62 *am62 = platform_get_drvdata(pdev);
 	u32 reg;
 
+	pm_runtime_get_sync(dev);
+
+	device_wakeup_disable(dev);
+	device_set_wakeup_capable(dev, false);
+
 	of_platform_depopulate(dev);
 
 	/* Clear mode valid bit */
@@ -281,7 +286,6 @@ static void dwc3_ti_remove(struct platform_device *pdev)
 	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
 
 	pm_runtime_put_sync(dev);
-	clk_disable_unprepare(am62->usb2_refclk);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
 }

-- 
2.34.1


