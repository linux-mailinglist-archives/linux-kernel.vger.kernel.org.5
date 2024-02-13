Return-Path: <linux-kernel+bounces-62847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A960E8526C8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73C81C250A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE256EB5A;
	Tue, 13 Feb 2024 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fn/54Rq+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3880E69D04;
	Tue, 13 Feb 2024 01:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786236; cv=none; b=W9cFvDnqnu4GaSQ+Q7MXlHTcpD/DohkUEPqPmdWUQQbXwPTuQ3Xn69vhZgtajXg9Ff2dje8P8mcGxfTF26S3Ec1lhJ37QggPE6dfOz0zhBL/lbmmwqyS0UIKsyc9/v9PSpP+mKibZnXYw/INDyi+UON4VqfvDPNzEoRb/rp6c9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786236; c=relaxed/simple;
	bh=uCDHKIm6DTVG+Z7IiiCmTbgbHgtV7TTCN+RO8gz4Has=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XY1WvmStAWMCRXudCBKgu9HBWmdnPGIQuUtgmXFWK901DtB7I/WDds6GLrysp7CNb0mkYOtp24WkKgHJquLquLvdk1W312Jt5JteSchMRH2ZJ3GweLNlQCH6jgatmMyYepCiMMGhCM6VFHaMXN/KFr2elkdQztjl0n4FShwNkIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fn/54Rq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960E6C4166B;
	Tue, 13 Feb 2024 01:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707786235;
	bh=uCDHKIm6DTVG+Z7IiiCmTbgbHgtV7TTCN+RO8gz4Has=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fn/54Rq+ydOSWr5Nh+Nk1uxjofE0xBS7SiHkjGyJR6zkQLbo790oYtoUoPPpNjbtU
	 pJ0UnFXNKRvU2aMKTHq0xWqqwNnDyRXhewF9Lo1fUh8FNjase2GnBws+atmivjdILa
	 qhMAKEwqKW8BXtV28IdsaCNMzpuhK4rmyxixpyCABDV0AcoSVOd/i3QMqqIhyTIQUb
	 LsRZ3PtpZMyyJXJqR/wGny7N+qiVQCTtCQ2Iy84PfQdOOiuIImu4UnCnRvgTmX6FBW
	 Tez4IN8aXTBvh+hoPgBsOaRtEEd7pOeRRhEUzRHJ7Vsdw73+ksiOnYGdht+vQ7cFUn
	 aQ8kp6odSRHEw==
Received: by mercury (Postfix, from userid 1000)
	id 68C41106D63B; Tue, 13 Feb 2024 02:03:49 +0100 (CET)
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
Subject: [PATCH v2 13/17] ARM: dts: nxp: imx6ul: fix touchscreen node name
Date: Tue, 13 Feb 2024 02:01:02 +0100
Message-ID: <20240213010347.1075251-14-sre@kernel.org>
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

The nodename for a touchscreen should be touchscreen
instead of tsc.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
index 45b7605ac381..8aa365f837ca 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
@@ -370,7 +370,7 @@ asrc: asrc@2034000 {
 				};
 			};
 
-			tsc: tsc@2040000 {
+			tsc: touchscreen@2040000 {
 				compatible = "fsl,imx6ul-tsc";
 				reg = <0x02040000 0x4000>, <0x0219c000 0x4000>;
 				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0


