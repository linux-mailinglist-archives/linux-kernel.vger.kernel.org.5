Return-Path: <linux-kernel+bounces-165985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9519D8B9444
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BE51C20DF0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C047C20330;
	Thu,  2 May 2024 05:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R3ZAs/TQ"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B98D18E1D;
	Thu,  2 May 2024 05:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714628192; cv=none; b=RwiCAaM4W+PBRabCTOylNH54HGVKfxWvpQ1IJIaAcMXHMGYjT59YnQS/bTbechUuDQE42sYQNkZlppdPjfrDBvwfPgnMQpSZ6B7aQmikJ7Dkq47iebscpTU59KBzicdjIHV7+tuKasHSUDBBp+YcuzGwGs5H2JzEVlijWHVKwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714628192; c=relaxed/simple;
	bh=92pBswW6jEjH4ui2v7elSUIe5aDcq9luO/galnT/M2k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lqtYMGURZjh3eVxpO+h0JI6Umm2gxd9MNP/GGfAMUIu6tYlj/a/ldDhQ5eNAHUs0V1xeRYhQ1+3D+8akJq5rm4ryODMwGvGbTobp980VMaiLEr/K9vpg0ZyGfS1A40WZr0Oz6kkwPRV8Fs+JPQx6YOQgsf7xvjziPCtFNByrgXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R3ZAs/TQ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4425aK35067072;
	Thu, 2 May 2024 00:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714628180;
	bh=XxDRXovinw64QVgu+ST66HbCRuNxaRtTmvqXcimU5KY=;
	h=From:To:CC:Subject:Date;
	b=R3ZAs/TQtIIeOAPl4w7Jx5U9ZThWrSAlouuAaGWaP8f7hhRbCWAMOab4HZYoo1hEo
	 a7wSWfbzx64l+dIHmzTqwHKrgTpxK88K13qcCLD0otUp7a7SOhDh62LS49f2NUCQIA
	 wDxT6X4h9zcgWJe5f8Nd1xSTM7VO0hMNs9W4m/p4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4425aKoO061250
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 2 May 2024 00:36:20 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 May 2024 00:36:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 May 2024 00:36:19 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4425aGCh027413;
	Thu, 2 May 2024 00:36:16 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <srk@ti.com>, <rogerq@kernel.org>,
        <r-gunasekaran@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add USB 3.0 support for J784S4
Date: Thu, 2 May 2024 11:06:13 +0530
Message-ID: <20240502053615.29514-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

J784S4 has one USB sub system.
This series adds and enables support for USB 3.0 for
J784S4 EVM.

Matt Ranostay (2):
  arm64: dts: ti: k3-j784s4-main: Add support for USB
  arm64: dts: ti: k3-j784s4-evm: Enable USB3 support

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 41 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 39 ++++++++++++++++++++
 2 files changed, 80 insertions(+)


base-commit: f68868ba718e30594165879cc3020607165b0761
-- 
2.17.1


