Return-Path: <linux-kernel+bounces-82952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82CE868C31
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95A8AB2B545
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21F3136671;
	Tue, 27 Feb 2024 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEuAl/gf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22230136991;
	Tue, 27 Feb 2024 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025884; cv=none; b=GlLpbhjyIrqK80Y5HtrXPloI3dML06eUTma5c8ZIcxVPMdRv4p75BIzFAByZETqsoamtMUyzJfzl5X3Ad1gC0cNlFjXzwYSNlYKBYaPrsMkdMHwYqAZDB+LIrg/kRyk3wtwAxJ4oxqoEFvgT+/B/Pk3es/wkFQIHf522SZ8e6zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025884; c=relaxed/simple;
	bh=F0A6vQO//Uj1T20JqS9Pe7m1ckUNgr/dnHmSUeV0dxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pufW9GnmUczVH+hCoGceCoKf0keerEhZ3j51SdN5a9NKqccOH4rPWRWxNyZqENJU3RJ8AqVQUwbMJjHIJnh9RZct/ON/ia0d9unS0j+o4SK28fnfNSwzpWz7o/Uyg+xM2ww5j9uh8NH98RZZlcXIjm7O1g4rVKQGQ6RvG7Ymn9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEuAl/gf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B94C433F1;
	Tue, 27 Feb 2024 09:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709025883;
	bh=F0A6vQO//Uj1T20JqS9Pe7m1ckUNgr/dnHmSUeV0dxo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KEuAl/gf9cnj1JeOrE0UAaHbfEXn+dDGN8VWqcB/ap3oXjl9qQwnrDFWIRPb4jvhm
	 OrHH6d4u8OL2Y8KTT6a0FL78+cxoxLMmgPTdW6966RGkCrg96rQ21Eg4fjtXxDG51z
	 bzrNS+FF6jvkmxKmxO82ARzxTmNARv+hZwil3c92B60lJYp40MWIYeQdJ48brnFc+J
	 yNFdhk2xSryzqNGkCTL5laYmkFAshJATnNCMKUN9arzIoRX1OhxkAt7xth4RTFAnlE
	 SXvDX0DWMQ4eSd1STkcbIxLx3U+g4EI7DYAQ6RSkQ9lPTdzL4fh02J9x7/lt7brXXH
	 sb0fssCEsbEmQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 27 Feb 2024 11:23:50 +0200
Subject: [PATCH v4 3/4] usb: dwc3-am62: Fix PHY core voltage selection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-for-v6-9-am62-usb-errata-3-0-v4-3-0ada8ddb0767@kernel.org>
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
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=F0A6vQO//Uj1T20JqS9Pe7m1ckUNgr/dnHmSUeV0dxo=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl3apLluERQIpayJ8M4f8TJfsGLKTWS3+iX9aoF
 5FoDL7kQ0GJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZd2qSwAKCRDSWmvTvnYw
 k0LrEACbANZFxhPpAuN6pDPDVsOVulXzz8oEYIe683yjjBbIYpHKugkKFZ9WR/Lgbp4P9NRLQxb
 Obj1VuI7LEAvDptmyRKbvDMl9t3WnDUmmdYb/ednuGy7fz3H7ILBXG9khG9WRcXdZ9OSADUwdP4
 QMJ6yKkOPPgOHhEDNQgtLcKCvqQ9ezdyerpazkiH+GGCDUeEcWqNIYZMfdmgmPqQoqZbKMxy3js
 9kUupj0ixoDf2lTCGLQzdQKN6lIRDq9GSbcONIHV15kYiVdzsL3lqW66wK/rKSd6AWa2mziTd35
 PKYdTAZ5Ihk3FaFJKOWThguVdaHhDJqtRVzQL4xuZ3OWbnKOqMGX2hnkRURcVAchlALjzIH2ATk
 K4YcV3USrm/C5yB3Umi4Y/CiuZczJJAdfbfoGeaumLuJcCYZjC7XhIAAmZFFvADy4qUDGP0U/tl
 rxeBJDLZTpYM1VLwsvjBa71+up0XSwMPKmD//MGUWVwAqyQaceB1UhyNCYKJbflysrho0d/HZSi
 xMqACYG64YSJJR0vmnBYZlb/VI1RomkEy8hbFd1yaUNUZ/r2gTs6xTmYGkF3SiFG1QdGwkLdiqf
 FkTl5YPI2HcPQeRk4/H6I69daA7pha+E4UCxZvEwhlSQK+Hgb7PL8kUG4iL0C2W4dWWIM1zP4Fw
 2nPbkUVxCPctU3A==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

TRM information is outdated and design team has confirmed
that PHY_CORE_VOLTAGE should be 0 irrespective of
VDD_CORE voltage.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
Changelog:
v4: Added Acked-by
v3: no change
v2: no change
v1: https://lore.kernel.org/all/20240201121220.5523-4-rogerq@kernel.org/
---
 drivers/usb/dwc3/dwc3-am62.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index ea6e29091c0c..09b1f5a1c4fb 100644
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


