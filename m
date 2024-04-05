Return-Path: <linux-kernel+bounces-133648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9DA89A6A9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0840F1F26D3B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF301181496;
	Fri,  5 Apr 2024 21:47:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A44175575
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353639; cv=none; b=LNf6xNhk1rMCanWIKjCDPpvGiDGi6MV8m7A66ovVIEduNRDfbX/vmXvpzUKLKpNJZNkNUS9QDDjnupWOm+/qiO+G5X4MYltXK453/NXTH2hLKDtQXDwvPHwhaSR7X/BpzEc2Q2vlUKXnbC8vxhmmHxDuf3htQ4NLV2XphLJ4ckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353639; c=relaxed/simple;
	bh=1WGcyZoSiINM1IuI5/LvaH/2stxLwoA9me9eJn6xxyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=omsbG4scFbnNDKHJ8TNoYkAK96OS69ZMEHpqMnAIGGp2YLA0xpxOpx5UTR0K8sWlzKrQKyG56bUdI7rXrEpDH2pRQs0KjwTHhVvnwh4ngqhhn7oEFr3u0KG/5EE+OG18hYNm9UpvE9YXieNc/N2P9tL07qplhZ6TN7/3t5dCWKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOW-0002yq-D8; Fri, 05 Apr 2024 23:46:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOV-00Ad3K-9r; Fri, 05 Apr 2024 23:46:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOV-00FZoQ-0h;
	Fri, 05 Apr 2024 23:46:43 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v1 00/49] ARM: dts: imx: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:41:47 +0200
Message-ID: <cover.1712352665.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7546; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1WGcyZoSiINM1IuI5/LvaH/2stxLwoA9me9eJn6xxyo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHAh3dGYosiZSAMHJ1Z9MlCZ5Ea4yNVunFiVY Ky0Tebq1X+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwIQAKCRCPgPtYfRL+ TuzUB/90mdnnlAO+JFumLK2RhLfw4uukm+8bXN3SpmijDUA1cS50TGf6vd8zzGi4Yr2UUf9pR3k QOr97qNiHurHxTxJqjcYzRGqmy9a99hDzcaV0lZOQryTnMRMA3PDl0b+Jkv+PU26h22e6a10Y93 8C9KjpMfm1iV9F3C9R1uB6cBZJdhpo1M2g319oDyDl2ah6QnkDCyHIzncDbdjDkqBTpC+M8ctpt FtfAq1lmKErUYmyP+F/YZJcY9OfAM1hEJbdvyvY2uT5T0Q7T/GUz/vhVlEBkBrB/v1eBsG/rBeq JUd2WpZXLgDKXG38JPCZ0XDdxAEZgwL3biLN7f+Vd1AJA3Dt
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

this series addresses many warnings of the type:

	arch/arm/boot/dts/nxp/imx/imx6ul-pico-dwarf.dtb: pwm@2088000: #pwm-cells:0:0: 3 was expected
	        from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

that is emitted when building with CHECK_DTBS=1.

This completes the conversion started with

	fa28d8212ede ("ARM: dts: imx: default to #pwm-cells = <3> in the SoC dtsi files")
	4c6f19ab2aed ("dt-bindings: pwm: imx-pwm: Unify #pwm-cells for all compatibles")

Best regards
Uwe

Uwe Kleine-König (49):
  ARM: dts: imx51-ts4800: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx53-m53evk: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx53-ppd: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx53-kp: Drop redundant settings in pwm nodes
  ARM: dts: imx53-tqma: Use #pwm-cells = <3> for imx27-pwm devices
  ARM: dts: imx6dl-aristainetos_4: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6dl-aristainetos_7: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6dl-mamoj: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6q-ba16: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6q-bosch-acc: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-apf6dev: Use #pwm-cells = <3> for imx27-pwm devices
  ARM: dts: imx6qdl-aristainetos2: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-cubox-i: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-emcon: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-gw52xx: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-gw53xx: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-gw54xx: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-gw560x: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-gw5903: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-gw5904: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-icore: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-nit6xlite: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-nitrogen6_max: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-nitrogen6_som2: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-nitrogen6x: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-phytec-mira: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-sabreauto: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-sabrelite: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-sabresd: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-savageboard: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6qdl-skov-cpu: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6q-kp: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6q-novena: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6q-pistachio: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6q-prti6q: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6q-var-dt6customboard: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6sl-evk: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6sll-evk: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6sx-nitrogen6sx: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6sx-sdb: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6sx-softing-vining-2000: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6ul-14x14-evk: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6ul-ccimx6ulsbcpro: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6ul-geam: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6ul-imx6ull-opos6uldev: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6ul-isiot: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6ul-kontron-bl-43: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6ul-kontron-bl-common: Use #pwm-cells = <3> for imx27-pwm device
  ARM: dts: imx6ul-pico: Use #pwm-cells = <3> for imx27-pwm device

 arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts           |  3 +--
 arch/arm/boot/dts/nxp/imx/imx53-kp-ddc.dts           |  2 +-
 arch/arm/boot/dts/nxp/imx/imx53-kp.dtsi              | 10 +---------
 arch/arm/boot/dts/nxp/imx/imx53-m53evk.dts           |  3 +--
 arch/arm/boot/dts/nxp/imx/imx53-mba53.dts            |  2 +-
 arch/arm/boot/dts/nxp/imx/imx53-ppd.dts              |  6 ++----
 arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi          |  8 --------
 arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_4.dts  |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_7.dts  |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6dl-mamoj.dts           |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6q-ba16.dtsi            |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts        | 10 +++-------
 arch/arm/boot/dts/nxp/imx/imx6q-kp.dtsi              |  6 ++----
 arch/arm/boot/dts/nxp/imx/imx6q-novena.dts           |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts        |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts           |  3 +--
 .../boot/dts/nxp/imx/imx6q-var-dt6customboard.dts    |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6qdl-apf6dev.dtsi       |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi       |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi         |  9 +++------
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi        |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi        |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi        |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi        |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi        |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi        |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6qdl-icore.dtsi         |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi     |  6 ++----
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi |  9 +++------
 .../arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi |  6 ++----
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi    |  6 ++----
 arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira.dtsi   |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi     |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi     |  9 +++------
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi       |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6qdl-savageboard.dtsi   |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi      |  1 -
 arch/arm/boot/dts/nxp/imx/imx6sl-evk.dts             |  4 +---
 arch/arm/boot/dts/nxp/imx/imx6sll-evk.dts            |  4 +---
 arch/arm/boot/dts/nxp/imx/imx6sx-nitrogen6sx.dts     |  4 +---
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi            |  4 +---
 .../boot/dts/nxp/imx/imx6sx-softing-vining-2000.dts  | 12 +++---------
 arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi      |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6ul-ccimx6ulsbcpro.dts  |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts            |  3 +--
 .../boot/dts/nxp/imx/imx6ul-imx6ull-opos6uldev.dtsi  |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi          |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-43.dts   |  3 +--
 .../boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi   |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6ul-pico.dtsi           |  3 +--
 51 files changed, 64 insertions(+), 150 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.43.0


