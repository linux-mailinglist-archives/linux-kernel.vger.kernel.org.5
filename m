Return-Path: <linux-kernel+bounces-52792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3A0849CB2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1A71F25D6D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF242D046;
	Mon,  5 Feb 2024 14:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbStuYSg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2F82CCD6;
	Mon,  5 Feb 2024 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142357; cv=none; b=dwlVGXVSUPlk6I3tpjOJR1KomVevWuCo+6H4ZfcDtvgrYjCawDSrzDLM3ni8wQFOddoOnEodpYJ9Y09VMzH5VWZotbrGQRmLrdZGmCkssaNPc+nsq/YuTon74RvK03kHAofd190cNRuzr/g2geYFV0J0b42hOU2ASIq2r5/pHX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142357; c=relaxed/simple;
	bh=S9XKJn2RHODf26m6srBV7+w5C4ie6RweVa74MFrSSxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HyvXUJwGfwkTC0AZsFDKGbT6B9yz1Q0JdbePq5l+TCA1ZYCIHo+cx1fWQ5po/1TqlM98Toa2xjUSu5RZWOg3K4sg8ouvekd5mq56Pl53Qgn8xW6LZ/P5Wc1OVQ0/M64DCAj/EJJTsGYkYeTHay6CFwv70JlmnuzHeyzFmJCAm3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbStuYSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC35C433F1;
	Mon,  5 Feb 2024 14:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707142356;
	bh=S9XKJn2RHODf26m6srBV7+w5C4ie6RweVa74MFrSSxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DbStuYSg62t/WWT1G6IEM5F0zJt80/z/9bkfIwQ4SvcYrR6MsoLnrgBJdGKd4aT8o
	 xuwJEpRpIKyuQs9T+D+kfZuv2zq4Gnd50nQZuBkTgj29F807nCrTYaa7htVmmC+7GO
	 1pmw0MdwtIYaxOEWjoMV7fliIdfhrz4MwdySohwq5dFHPku5kpSuwbFkloCQpyiSZV
	 ibOZ7BQ2CbDKY2kFGElNXZ9cfu6br+l686Pb/Ons7Xyt+F0MyzsbIpb+XPRFXn6C9N
	 t+qFKwSF1sGlmSPZe1yxNJtQs+Q2uxBfdIp91HMdHB7yim2W102QJJpCGgTvJEIjbl
	 9cclPjZ8ojutA==
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
Subject: [PATCH v2 3/5] usb: dwc3-am62: Fix PHY core voltage selection
Date: Mon,  5 Feb 2024 16:12:19 +0200
Message-Id: <20240205141221.56076-4-rogerq@kernel.org>
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

TRM information is outdated and design team has confirmed
that PHY_CORE_VOLTAGE should be 0 irrespective of
VDD_CORE voltage.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---

Notes:
    Changelog:
    
    v2: no change
    
    v1: https://lore.kernel.org/all/20240201121220.5523-4-rogerq@kernel.org/

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


