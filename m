Return-Path: <linux-kernel+bounces-150830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4698AA561
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94DB82817D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3E91A0AEF;
	Thu, 18 Apr 2024 22:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aqs5FGO5"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292AC199E98;
	Thu, 18 Apr 2024 22:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713478515; cv=none; b=W8zkzTakqehivOLTVHWWK6xrBJYHXnhHXyUQTeBU0dgFrTV42s5HFDRX9Xk8c4pGSgT4h2guudYX9TAoTIok1ZUMuTtNc6t/uYxi1F7OuMAv7npeYT7RK7fIft103wlBuF0EY/c2pJ/YR60Rcit8/wIlwPCeC257CDAPtNtSFXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713478515; c=relaxed/simple;
	bh=F16f7m+rXA4gqWpAX3hVUPiuUj/nL5rhRES+7nViR3k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jSDmiSdsBBaW2Ge1uv8AWwcYA1o0e66XHDd4X4/DerB2L4hB5CBxxn0ZcbfAwoNl0x3lWBGFOuz9pVmcQf3wZ1vFwI+t4eSwlcD7TVw93n+40uxvsNJHSL9N4JMFlQtvUfTkIryh49XRKWrAzmPGSnddqu51eCSfu37W86Ba19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aqs5FGO5; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43IMEH8O054612;
	Thu, 18 Apr 2024 17:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713478457;
	bh=kEuyqCXrDydWu1snvJbTAmkNKiY15UuzZvoSw7vyxXo=;
	h=From:To:CC:Subject:Date;
	b=aqs5FGO5h3fONrjTiVETv7F6Ia+Ye3e7ioACqD8jNxL0hePrVHn79atWKdIPqiuCE
	 JICbtWkIKFRVaRWxEA6ktxn08/cOeqVUFQwAzjVbAr+IN9rirPDRZ5WUeSTZC9CoOm
	 4v62gSA1XNcOPBeAOrehqZOIseIQ8DIig9z3qW4U=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43IMEHbA112329
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Apr 2024 17:14:17 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Apr 2024 17:14:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Apr 2024 17:14:17 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43IMEHqo111027;
	Thu, 18 Apr 2024 17:14:17 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
CC: David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH 0/7] Enable eQEP DT support for Sitara K3 platforms
Date: Thu, 18 Apr 2024 17:14:10 -0500
Message-ID: <20240418221417.1592787-1-jm@ti.com>
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

This patch series adds eQEP DT nodes for K3 Sitara devices:
- AM62x
- AM62ax
- AM62px
- AM64x

Also enable eQEP to be built as a module for ARCH_k3.

Judith Mendez (7):
  arm64: dts: ti: k3-am62-main: Add eQEP nodes
  arm64: dts: ti: k3-am62a-main: Add eQEP nodes
  arm64: dts: ti: k3-am62p-main: Add eQEP nodes
  arm64: dts: ti: k3-am64-main: Add eQEP nodes
  dt-bindings: counter: Update TI eQEP binding
  counter: ti-eqep: Allow eQEP driver to be built for K3 devices
  arm64: defconfig: Enable TI eQEP Driver

 .../devicetree/bindings/counter/ti-eqep.yaml  | 10 +++++--
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      | 30 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     | 30 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 30 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      | 30 +++++++++++++++++++
 arch/arm64/configs/defconfig                  |  1 +
 drivers/counter/Kconfig                       |  2 +-
 7 files changed, 129 insertions(+), 4 deletions(-)


base-commit: 534ad093bb80f19c20b251a89f09ce1a0e3d4f2d
-- 
2.43.2


