Return-Path: <linux-kernel+bounces-48176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84040845841
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379B828A369
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B7D5338A;
	Thu,  1 Feb 2024 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yQoBzW5g"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A3B2134F;
	Thu,  1 Feb 2024 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792110; cv=none; b=ifIwZ2XjvufA++c+Dj01eaofYZiw0xjxRbbnB+785yjJcGJNDc+f6bF4fJSFzEnpGapDvync7bR9DXFDSfk+2EKWEMQ7aOtJQBdFpghw9qwhyEi2AthHuzqccOaMq0syCDQqrEOFOMxko7M6/QoIp58m+feYZBrnc0emZsox0sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792110; c=relaxed/simple;
	bh=F0QG+HX+GA+HXJhX/KToYgeGTqJkykSyyE7Up16UTBc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CsHHZ1CzS3vK+KUvcgsPXJ1hspPX+U5ERzNcOkngIy2dAtVL0b0rzph708IvxNtknVzhMyaeITxDd44J9qyowx9s0m75JN5qVKLCWViMIYbvWQm5TcSIEVdVtRcVbBxf522CoPxmH3irrlvIGm7srCobnGJJK0b/+geZq0kSGco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yQoBzW5g; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411CsrMl101296;
	Thu, 1 Feb 2024 06:54:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706792093;
	bh=sodrgaqu1kxUDJNx4GE0NQQ5b5C3Xq+q3hat/bV8by8=;
	h=From:To:CC:Subject:Date;
	b=yQoBzW5gm4HGB4YqteYQr9dpeEEUykk7XX+6i0sgW9M3RXJmAv/A6jtKuNyJrd3cC
	 hcirLCV2iO46QKYZbbF+KFlTn0NmaVX55XJ2lPpQ75UEIvmRMKJVC9hiS2L9kkBjhE
	 EtgPCNxBs2xHJUylSKrBiba3vnN+5orRD4TtBbSI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411Csr56055079
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 06:54:53 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 06:54:53 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 06:54:53 -0600
Received: from localhost (uda0496377.dhcp.ti.com [10.24.69.150])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411CsqQj064868;
	Thu, 1 Feb 2024 06:54:52 -0600
From: Aradhya Bhatia <a-bhatia1@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List
	<linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        Devarsh Thakkar <devarsht@ti.com>, Jai
 Luthra <j-luthra@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH 0/3] arm64: ti: k3-am62a: Add display support
Date: Thu, 1 Feb 2024 18:24:49 +0530
Message-ID: <20240201125452.1920623-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

This patch series adds DT nodes for Display SubSystem (DSS) and other
peripherals required to enable the HDMI audio and video on the
AM62A7-SK EVM. An HDMI monitor can be connected to the platform for the
audio-video outputs.

Regards
Aradhya

Aradhya Bhatia (3):
  arm64: dts: ti: k3-am62a-main: Add node for Display SubSystem (DSS)
  arm64: dts: ti: k3-am62a7-sk: Add HDMI support
  arm64: dts: ti: Makefile: Add HDMI audio for AM62A7-SK

 arch/arm64/boot/dts/ti/Makefile           |  2 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 25 ++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts   | 92 +++++++++++++++++++++++
 3 files changed, 119 insertions(+)


base-commit: 51b70ff55ed88edd19b080a524063446bcc34b62
-- 
2.34.1


