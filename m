Return-Path: <linux-kernel+bounces-79872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100F58627D3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8E21F21853
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D525336F;
	Sat, 24 Feb 2024 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpZhjaDg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FDE4F61C;
	Sat, 24 Feb 2024 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810396; cv=none; b=nDw/ZTipAbppE+s6CMZL3FTZEn7njsdTwWJqyO3UR4LnYED18v8s2R1m4qUYF+Xvc5js/QFpVQX33lcVJ3iwBwSErNGe3+DfiRbHbMJWnU+G8/emiwPPHYFhPDjYdwm2NXRW6NpIOrXLccMcwqXSB1NCc4SKsIYhe3t4enB0uhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810396; c=relaxed/simple;
	bh=pSvctDHxVCaAu+4cZjOT/I3a/3LHsGScFSRvh9RHyIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6y5z4+dsH1mgU+bknNA8rxeM69UzYTOBp2diQb9Q/b71jro0n9Fmo9XfKL4EqzD8uVOvxYstO3j6Evcz7MthQUq2Rn9MyYPAyCpiMfc3NulpzbjqUSm5JU2sORoE/uzBjJ8qtU9tu52QMLCMb/w5OIeZDNwg1osa7Yu+3at7hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpZhjaDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C405C116B1;
	Sat, 24 Feb 2024 21:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708810395;
	bh=pSvctDHxVCaAu+4cZjOT/I3a/3LHsGScFSRvh9RHyIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZpZhjaDg2p6x8qlEwryPeYVabJEhfdTsCKKHfi2OfK28kH1vqNiJQZuhx3maJFfpx
	 IIQ3w9tfNW5ZH8eMwKCyI4YLT6pXEjsyJOPvZNrgc/tkbgFETMfspcowjrtK3cnAbJ
	 cSQOQrNBKOSvQhkSh+YZDvuld/28VQpqQuzXcnaXg0bGWhmjjKiBhAaEv7Jmya2Z7P
	 FN8e5/xJ0EOYgVZgs96mMsTe3FLcP8bcq1PQYjTJaolcedu2lRUXLrBNfYHDNe8Wz6
	 rLpmitjWUgqE/NWZzBnZjhsG6QLKGDbuI/gHvBcOyc5iq78i2FrX7CisLDIAM9efQ+
	 UaBEmuzotF2Jg==
Received: by mercury (Postfix, from userid 1000)
	id 207071060EF3; Sat, 24 Feb 2024 22:33:10 +0100 (CET)
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
Subject: [PATCH v4 09/16] ARM: dts: imx6ul: Remove fsl,anatop from usbotg1
Date: Sat, 24 Feb 2024 22:29:41 +0100
Message-ID: <20240224213240.1854709-10-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224213240.1854709-1-sre@kernel.org>
References: <20240224213240.1854709-1-sre@kernel.org>
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


