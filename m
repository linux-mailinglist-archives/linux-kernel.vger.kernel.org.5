Return-Path: <linux-kernel+bounces-124268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1530189149A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45ABD1C22315
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F0F4120C;
	Fri, 29 Mar 2024 07:55:36 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637839AF2;
	Fri, 29 Mar 2024 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711698936; cv=none; b=jH7Du7kWcuFjdR9tGDhVKY/tyLYPySMXbQSoj0E3b6SvF5DWGzqlSC+nuHs67PJJa0YZq7TtYu/HkjKSZvToOA4Q8STQYH9omToNZuLd9+wl7AQcSkqQyImIoEERu7e9JYiM7v9E+c6PzAyvwapZLZj1GCOXSid06SnQPc08T4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711698936; c=relaxed/simple;
	bh=9RbpFOmZNtG+oc8wrHRkcj9NkTXvGKOwACb0jmOWopY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=VIGy8T09bY6+rYi52diQlhDZ4xw4Y5wesAGK8iltwABwKtVlCOTpazzCfmQWa7eUOI/swbRChAbeOlNhUJW/4EOf5X3CdL5V7y4D80L6NHTbsHjPkQgivyqTFJ2v5doUoca7b+5P4y7KFC0KoVgV9zFOo8UN9a2jCnL5Yvx0jQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 01E5F1A0923;
	Fri, 29 Mar 2024 08:48:32 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ABF8E1A02BF;
	Fri, 29 Mar 2024 08:48:31 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BBCE2183ACAC;
	Fri, 29 Mar 2024 15:48:29 +0800 (+08)
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
Subject: [RFC 0/3] Add i.MX8Q HSIO PHY driver support
Date: Fri, 29 Mar 2024 15:31:30 +0800
Message-Id: <1711697493-16151-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

i.MX8Q HSIO module has PHY and mix control regions.
This patch-set adds i.MX8Q HSIO PHY driver support, and provides
standard PHY phandles that can be used by i.MX8Q PCIe or
SATA driver later.

[RFC 1/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY binding
[RFC 2/3] dt-bindings: phy: phy-imx8-pcie: Add binding for i.MX8Q
[RFC 3/3] phy: freescale: imx8q-hsio: Add i.MX8Q HSIO PHY driver

Documentation/devicetree/bindings/phy/fsl,imx8q-hsio.yaml | 143 ++++++++++++++++++++++++
drivers/phy/freescale/Kconfig                             |   8 ++
drivers/phy/freescale/Makefile                            |   1 +
drivers/phy/freescale/phy-fsl-imx8q-hsio.c                | 518 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
include/dt-bindings/phy/phy-imx8-pcie.h                   |  26 +++++
5 files changed, 696 insertions(+)


