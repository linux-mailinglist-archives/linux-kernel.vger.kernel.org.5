Return-Path: <linux-kernel+bounces-65003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9513854672
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6101C22299
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC0E18E01;
	Wed, 14 Feb 2024 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDFZgPSb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109591863B;
	Wed, 14 Feb 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904118; cv=none; b=CNUFq5sPrad3Y2PUNnSdJavFU1NF3q3KphYTMshw1cbhx5xosOLyXmWl7bAn8YraNwSmFXnkKkdmyppYGafMVyw0KHWXXy7vuImESB3Ci8krk7Ib2TzPm7wQu7xstoheWYdEZJUMLrl3KSzhu8shsliqKZiqECSdWJ9YVRYTQNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904118; c=relaxed/simple;
	bh=jyYmSrgq2fdCLWgGVgy9+gpU9CJvUIBFv3KADPN8uts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ql3r20ODy+CPmuHc8cAa1r9FWHk5rvPrYL6Lv2Iq1+9A7Hh02p4buZu0BJhRsTybnl59ZDHj3txgOvB+hQwf3mVCW+jQMu6hBcJaysfOIQNFW3x4c6dNzeyz8tlz0NIYdB+zl0LGAj1Rwz5SZ3L5zTXO2Rh+DKy5dP/gXzqfILA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDFZgPSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2ADC433F1;
	Wed, 14 Feb 2024 09:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707904117;
	bh=jyYmSrgq2fdCLWgGVgy9+gpU9CJvUIBFv3KADPN8uts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uDFZgPSbEm5k3mx27ZY5ed1oi2eB20QMowucxsA2fuwmn1DJSksHdbFFuepBdXCsX
	 5PIHXC7XHU18sqPjWd18jEv4K5owHIXxdDfduOFEBEwPlM+II+50Svs+h6a9QjKsmS
	 av51FuySmYlWBYAe3TuIui+8AhA/JqkzJ/2iXDDSd+cpkAuIM7A4BuToQTWL6DUTBF
	 Rr/5yj9xk8BANbhc3pylIdEZpcB9c1H405DEcudmJ8UrYm1rhd+zSMHMvL/8prM5t8
	 RRBTctpLSKAbJGmG6WPHiua/mYL7ggV1yAcPCl3JvR7GVFsA3BCElu4+mkRMDzuMlx
	 mCOIxMvVdRInQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Wed, 14 Feb 2024 11:46:47 +0200
Subject: [PATCH v3 3/5] usb: dwc3-am62: Fix PHY core voltage selection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-for-v6-9-am62-usb-errata-3-0-v3-3-147ec5eae18c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=jyYmSrgq2fdCLWgGVgy9+gpU9CJvUIBFv3KADPN8uts=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBlzIxmwGvMIw/xVB+Dla8X7O0q+r5a7e6aLKOIM
 n7hUHxFuRaJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZcyMZgAKCRDSWmvTvnYw
 k6DKD/0XW5DQ0cDZdTSQd/96rgY16YDvYIGnuBMTDx9gaY0kQTfiZE2xYACRHd4qLW1YaDYFSQI
 m8g1BVIjKGVrYTS7T8d0cAaNPqw98p/zW+0yIWDdhOWPWtwwjVWcxU7bXdvF3mz6gCyb+xP4F5z
 OgjkVL5GpBigYsaOM3plHu4+NJbC90P4Kx3NW+G8V6d/6KhmsKVlYTzPh4nVpLKlnYrxBhvOeav
 eZhPj3E+23aR0aY7+LeWPNIcekDju3xk94f2G/1+NF7d/N18odQdseSGTacfSSKXjZZ+BOf1/Mr
 3oV4qn3YVRx7cET9zcgOYC8gKhMTE/4FGkXvDjXjO5xOrzy1AsOtsMASkqtR0fvU00RGnpYGabc
 sDTJ7Y8f1CjzDtcRCRh4xTmDiCY+E9hxFOqSOQQUjOdzxk+rL8fHwkjC3hE2s2kM4N4wREAyODC
 XSrDINIu77a6AJ7ryfwN9ALeI64H0ctkoAcemtLB2LLMi1+6k2SpqPGI7T43ly5pES9+6YMIS5P
 X6ckD7IXnKli6WlxBY01RUfpM0BDOlupxCikMUUHtXQvW7S8slfym+vMJtTvT2BNpVtHV5HfpXi
 qTr9trE/WF16Ou1YiPsaldxwWDQJ8b24HADaSpTR1QQYQZJ52Id90HW68EFJcbktPH6ZL4JAhwa
 +KwEdNhrOR4GQ9g==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

TRM information is outdated and design team has confirmed
that PHY_CORE_VOLTAGE should be 0 irrespective of
VDD_CORE voltage.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changelog:

v3: no change

v2: no change
	https://lore.kernel.org/all/20240205141221.56076-4-rogerq@kernel.org/

v1: https://lore.kernel.org/all/20240201121220.5523-4-rogerq@kernel.org/
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


