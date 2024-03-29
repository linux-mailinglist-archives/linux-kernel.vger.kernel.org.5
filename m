Return-Path: <linux-kernel+bounces-124291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05736891524
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B137D288174
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC52D4AEDE;
	Fri, 29 Mar 2024 08:26:51 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E54F5E6;
	Fri, 29 Mar 2024 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711700811; cv=none; b=NykLO0U0LTJLWtnEks0/3Ak58eoV8tKsyDSMWq8zhA20OFgkOaSRjIXhXbKmGD4jzgzC9wgcvnRuxgMJlvKByFhHBGd7FQ7DeLC80Fj6rz8FBaVI7j05/GtY5lIsI29CR8DymM0GmamjbnoxxbhUXWjzMURV8554H8HGCdWJZ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711700811; c=relaxed/simple;
	bh=GT3TqbuTHmflkYsxFW2cZH4AlDvd4EQoKkjuf/1aGcY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=B0WA26jpryDkURgTlXdjkDzAXyBSHNzpP1CpdiD0bAFzKQdNYPjHCfJLkg8D0wiJKhsG1Wr0DVeYb1WnqZM7oer0wCVqiVIhpo3RUlxjVP3Iidw6S9/d0AeIMXMx1U4mdsTXjHDHFbfU7HReSeghuNgdF/yVrMUIpOQ70Ig8ks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D33A201359;
	Fri, 29 Mar 2024 09:26:48 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 22ED1201349;
	Fri, 29 Mar 2024 09:26:48 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 29A58183ACAC;
	Fri, 29 Mar 2024 16:26:46 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	frank.li@nxp.com
Cc: hongxing.zhu@nxp.com,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	linux-imx@nxp.com
Subject: [v1 0/3] Add i.MX8Q HSIO PHY driver support
Date: Fri, 29 Mar 2024 16:09:47 +0800
Message-Id: <1711699790-16494-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

v1 changes:
- Rebase to the 6.9-rc1, and constify of_phandle_args in xlate.
No other changes.

i.MX8Q HSIO module has PHY and mix control regions.
This patch-set adds i.MX8Q HSIO PHY driver support, and provides
standard PHY phandles that can be used by i.MX8Q PCIe or
SATA driver later.

[PATCH v1 1/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY binding
[PATCH v1 2/3] dt-bindings: phy: phy-imx8-pcie: Add binding for
[PATCH v1 3/3] phy: freescale: imx8q-hsio: Add i.MX8Q HSIO PHY driver

Documentation/devicetree/bindings/phy/fsl,imx8q-hsio.yaml | 143 ++++++++++++++++++++++++
drivers/phy/freescale/Kconfig                             |   8 ++
drivers/phy/freescale/Makefile                            |   1 +
drivers/phy/freescale/phy-fsl-imx8q-hsio.c                | 518 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
include/dt-bindings/phy/phy-imx8-pcie.h                   |  26 +++++
5 files changed, 696 insertions(+)

