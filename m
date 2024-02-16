Return-Path: <linux-kernel+bounces-69434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7254585890E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C98B2BE48
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41D314E2E0;
	Fri, 16 Feb 2024 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIlkIdZV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2B914AD19;
	Fri, 16 Feb 2024 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123022; cv=none; b=Jhq5PoO49rxntbT45eQfoHqZ34KhSSxlXdZ5pw+VcpncE/47wWi6ISdRMON9q3H3nMj0FQNStInfI1AgpaOjiE/7yVr6BGPkaoWwxIXIWv6nF8YBYOaIijgKDHhimSKsagfiKtrwCdvtPqra+qffCTzCE0JR7kG0EyjJLA9Tt8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123022; c=relaxed/simple;
	bh=pSvctDHxVCaAu+4cZjOT/I3a/3LHsGScFSRvh9RHyIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLI/8OG9DZFJgoU3hlLx3OkqLamVyPC8rYO/m1qFAg36CX1rqzXHnqFi9tbJSHnf6PDHKsvmXvEQ/RUWZ9Zdd/wurjdz1ufmZB/Oj8xEUs6vf4wlNvms35L6KG+n0dCGuiXJB09Rrkh7O2ELWLYBgqPBONMLq0L8ZvQOj25/1+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIlkIdZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0150DC433B2;
	Fri, 16 Feb 2024 22:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708123022;
	bh=pSvctDHxVCaAu+4cZjOT/I3a/3LHsGScFSRvh9RHyIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KIlkIdZVYsGFndwc+i49nctXF2P6Sex1V3QebTY+frX2qx/HM8JPDu39KRb/iuvsx
	 5E8H88kNy2MSh7SmKzy6SEWrdv+JrJmGi8+eSeMT3wQprW37wRGFIJOGfoGhlgADEk
	 XiXnW6yjOigDWxY2/5+4OP3PmpwN9jEPJAaqsN6snVLQyw0haL1VrKGNa6ux6QyJ81
	 K+UpXSyadiFBXvjlT7drMOZyfzarOnU2FJe9ljGzDGRMmnILUqz1NP9ObGVITDOtma
	 OxQ7hPUwOrOdSWP9QX50EGr7K/keiTLV5kqGvdmiomqrgRj2/ybgDLgXD6kd905Fv7
	 eVPbjjhuidsoA==
Received: by mercury (Postfix, from userid 1000)
	id BB93910633D5; Fri, 16 Feb 2024 23:36:56 +0100 (CET)
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
Subject: [PATCH v3 09/16] ARM: dts: imx6ul: Remove fsl,anatop from usbotg1
Date: Fri, 16 Feb 2024 23:34:28 +0100
Message-ID: <20240216223654.1312880-10-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216223654.1312880-1-sre@kernel.org>
References: <20240216223654.1312880-1-sre@kernel.org>
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


