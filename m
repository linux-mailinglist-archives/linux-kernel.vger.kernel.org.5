Return-Path: <linux-kernel+bounces-62842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DED668526C4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EA55B22E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C8C6A336;
	Tue, 13 Feb 2024 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WP/DvuEd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09AD692FF;
	Tue, 13 Feb 2024 01:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786235; cv=none; b=ObTn5EPqpZlp+t9XiKTPjdhemprpi7VIphIz1DVEIem8ek8S5mYp35fEHLBTYjnM4KR2BA88VZuCNhmjN7Yhb1XC/Xe7BEH1IV/0KadyYSyMgXqmTOun4Kdew7qyQi1xg3GQOEcVLVpGMZH+4lvwZZS2avmAMFl6oveHcr/kHwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786235; c=relaxed/simple;
	bh=pSvctDHxVCaAu+4cZjOT/I3a/3LHsGScFSRvh9RHyIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbviJTrIJa+p9PfqFG1+g67KfOnL7z/+wsEFS/JHHxdZioThleE39h5PKLtJdQT5JLL6pgADDXV8JGWBQcFoQ10Af6PWe2f50qOo5/+Eo+uGxMI/lCPPKVECIE2OyUjsGDGQrlD5xmOny/sMuZoKMVSN5ZbJq7oy+lirlY40rYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WP/DvuEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8B3C43399;
	Tue, 13 Feb 2024 01:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707786235;
	bh=pSvctDHxVCaAu+4cZjOT/I3a/3LHsGScFSRvh9RHyIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WP/DvuEdP2yZwW7/I6LJRn5k8K8J2czcQ8L5O3VNIQE6QH1HbnIR5nzJqr/hOsPvm
	 ZDQCnQ4gTVfrCPpP6g3tirV5rJD4B3JeMR03dtFh9F/rvZB40s96TYCFNYf314qlE3
	 3CxbXyWM6ZVJZJVqjwJ4AtGfRLJ6Z8CkPf0606/6XiPIvYKu+YgtzCM/vvFBWuix+1
	 QicoKhdeYMJ39nDPvQk0q9zKQOSX4ePnOP4W1zXe1yk2Ko4woIQB8hBAJMqoDimuQM
	 PHRMgeRaeUsMkm/29+HuzDYYPIIHMndpxMIklH8Z/CyY/SqLUHTwxAbie3+mWSoNJD
	 Dy1H8K/YJXmxw==
Received: by mercury (Postfix, from userid 1000)
	id 58C5F106D638; Tue, 13 Feb 2024 02:03:49 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/17] ARM: dts: imx6ul: Remove fsl,anatop from usbotg1
Date: Tue, 13 Feb 2024 02:00:59 +0100
Message-ID: <20240213010347.1075251-11-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213010347.1075251-1-sre@kernel.org>
References: <20240213010347.1075251-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fsl,anatop should only be added to the usbphy nodes.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
index a27a7554c2e7..9eb4eee0c272 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
@@ -855,7 +855,6 @@ usbotg1: usb@2184000 {
 				clocks = <&clks IMX6UL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
-				fsl,anatop = <&anatop>;
 				ahb-burst-config = <0x0>;
 				tx-burst-size-dword = <0x10>;
 				rx-burst-size-dword = <0x10>;
-- 
2.43.0


