Return-Path: <linux-kernel+bounces-155452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF168AEAC7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6B528BB48
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2F513D50F;
	Tue, 23 Apr 2024 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RbimjSe/"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C961913C83C;
	Tue, 23 Apr 2024 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885472; cv=none; b=cBat/olyDPQEgTLFCJotvT6poRMo+MdNaj2ezEN424QOTZFFXjDnCAZhLUtJloCHsnR6wJyh+wRWsQRfXxK6khx+jg3m7AYfqAHmlxx+ic5p6bLQFXFoShGJSj730oBTPmist8hEQhfI2pLSl+Y7+pu1qpsHGAAiX/o4WloD3Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885472; c=relaxed/simple;
	bh=1x+LblrzlgT7FOM4PcS3qZR5WjRxwBpw68LzmJnEJF0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kzh6uAV8JSGI2BrMj0V3kYSvN14on6hQKZlBO6xTODmpAYtB5t3Nr/fi19UARwnFRdKXzI6siTZ2ug/FrfD3DzJEceu/5Sb/3kprQffX+7IBDrsqPWbIF07jjhGdFNG2IruzH+v1HGBRffnX+wuNO7lAwl3gD5ZXAJtnEi4a558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RbimjSe/; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43NFHWLx078977;
	Tue, 23 Apr 2024 10:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713885452;
	bh=zzRbZ9Al1Q72Kx4hGHS16o5vcAmBP2xsme3WdUzdqdo=;
	h=From:To:CC:Subject:Date;
	b=RbimjSe/+UpXox7wb97v5jpNAKD+PPGnx1lWO/9doAqYZIi3nVq4kglYj/jFUq/gS
	 5pBTy6odIX8+ZLKzMqwOkdEr0lsyMrl0hlzrgqvo4bqniXZqGmIYgpMfH1YiA1ebRg
	 HotvVgY/lHNCXKSm9Cn6VazAzLufZedWTNZSTGcQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43NFHW7n098202
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Apr 2024 10:17:32 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Apr 2024 10:17:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Apr 2024 10:17:32 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43NFHWYG080176;
	Tue, 23 Apr 2024 10:17:32 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: Conor Dooley <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhavya Kapoor <b-kapoor@ti.com>, Dasnavis
 Sabiya <sabiya.d@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v3 0/5] MMC fixes for TI K3 platforms
Date: Tue, 23 Apr 2024 10:17:27 -0500
Message-ID: <20240423151732.3541894-1-jm@ti.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This patch series includes MMC updates for various TI K3 platforms.

It includes support for enabling UHS/SDR104 bus modes.

For AM62ax, add missing UHS support.

For AM65x, fix ITAP delay and OTAP delay and clkbuf-sel properties
in SDHCI nodes.

Changes since v2:
- Drop patch 6/6

Changes since v1:
- Drop patches that remove HS400 mode support
- Add patch 6/6

Bhavya Kapoor (1):
  arm64: dts: ti: k3-j721s2-main: Enable support for SDR104 speed mode

Dasnavis Sabiya (1):
  arm64: dts: ti: k3-j784s4-main: Enable support for UHS mode

Judith Mendez (2):
  arm64: dts: ti: k3-am65-main: Fix sdhci node properties
  arm64: dts: ti: k3-am65-main: Remove unused properties in sdhci nodes

Vignesh Raghavendra (1):
  arm64: dts: ti: k3-am62a: Enable UHS mode support for SD cards

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi  |  2 --
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts    | 21 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi   | 26 +++++++++-------------
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi |  2 --
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi |  2 --
 5 files changed, 32 insertions(+), 21 deletions(-)


base-commit: 534ad093bb80f19c20b251a89f09ce1a0e3d4f2d
-- 
2.43.2


