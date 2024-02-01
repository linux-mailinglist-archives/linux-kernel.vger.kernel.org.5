Return-Path: <linux-kernel+bounces-48094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C977884571F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080511C238D6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8441F161B5E;
	Thu,  1 Feb 2024 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z476S7EF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C44160899;
	Thu,  1 Feb 2024 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789554; cv=none; b=YD52ayZpGpU4uG5RQmtnujtYJCQPW7oQRLWMhA6p0/HYj1LcGCGFlRxfmzHf7HfVrIsW8cFnOKJT0UHuKL9blB7I0WTwDM5OMSrj5hvmJu1wVg/ceFA+Y8qsOhKEzyjGwrqIl4wZcUwrojN2YTbaHQAXiixTJYQQDwWFA3IEw50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789554; c=relaxed/simple;
	bh=Qfbq+sSZxjAM/hD8kTbPYklUiveqLxLWC3K9/YiS0nA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WCSRILlNeAe+IzncV6r2a/9LSViEAlw6AVkmH3w7z6FT8NLTwIWZOkXXjmCWdRumhD2+0TwZTVJiXIn9DL2n4xpIWDe69jK/uwlME2VI2ljYRNqCXd6aKwqV38C43x1hWMYT5mc2Fd2q6CBthMbQ6WzS43Lab+KmFDT5uJbTdzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z476S7EF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FCAC433F1;
	Thu,  1 Feb 2024 12:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706789554;
	bh=Qfbq+sSZxjAM/hD8kTbPYklUiveqLxLWC3K9/YiS0nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z476S7EFyvaNHyNGCa3WqeFNbLqRxCzcnu5y+ulWZ3GlLGBKVnFxa2yremgbIkQFt
	 OpNscSzEANRIH3vI7cTo8XXbSZb5nMCgHsCreqla9060r5IlAVc3iL/SZ0frpc/LFa
	 oFTRQs9m+RSz+TepjBeqUJioiO1StzsCmQzjOMGpViBgq+Zwf/lwv2fTqILUFwFBrm
	 q+uWKkEhwewRrgWfLv53uLqzDuQ8wGEcldlNzwfBWcoru7LpUxp9vhbNf+R0qJQZzE
	 afsK8CvHj20puC6AuQKKl1kD8HPYmA6M9HSa6GZh9pcXljFoqln5zpZKFx5TGfUjJv
	 JANEIODaR8VMQ==
From: Roger Quadros <rogerq@kernel.org>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	r-gunasekaran@ti.com,
	b-liu@ti.com,
	srk@ti.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 3/4] usb: dwc3-am62: Fix PHY core voltage selection
Date: Thu,  1 Feb 2024 14:12:19 +0200
Message-Id: <20240201121220.5523-4-rogerq@kernel.org>
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

TRM information is outdated and design team has confirmed
that PHY_CORE_VOLTAGE should be 0 irrespective of
VDD_CORE voltage.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/usb/dwc3/dwc3-am62.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 600ba9cfefea..af1ce934e7fb 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -97,7 +97,8 @@
 #define USBSS_VBUS_STAT_SESSVALID	BIT(2)
 #define USBSS_VBUS_STAT_VBUSVALID	BIT(0)
 
-/* Mask for PHY PLL REFCLK */
+/* USB_PHY_CTRL register bits in CTRL_MMR */
+#define PHY_CORE_VOLTAGE_MASK	BIT(31)
 #define PHY_PLL_REFCLK_MASK	GENMASK(3, 0)
 
 #define DWC3_AM62_AUTOSUSPEND_DELAY	100
@@ -162,6 +163,13 @@ static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
 
 	am62->offset = args.args[0];
 
+	/* Core voltage. PHY_CORE_VOLTAGE bit Recommended to be 0 always */
+	ret = regmap_update_bits(am62->syscon, am62->offset, PHY_CORE_VOLTAGE_MASK, 0);
+	if (ret) {
+		dev_err(dev, "failed to set phy core voltage\n");
+		return ret;
+	}
+
 	ret = regmap_update_bits(am62->syscon, am62->offset, PHY_PLL_REFCLK_MASK, am62->rate_code);
 	if (ret) {
 		dev_err(dev, "failed to set phy pll reference clock rate\n");
-- 
2.34.1


