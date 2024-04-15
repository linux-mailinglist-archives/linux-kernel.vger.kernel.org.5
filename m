Return-Path: <linux-kernel+bounces-144585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0F58A4820
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EB41F21C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA84118E1E;
	Mon, 15 Apr 2024 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q6qkveo7"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC231EB35;
	Mon, 15 Apr 2024 06:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162837; cv=none; b=gGsQulA9QPTVXtEw3oCgHa+t2M5gFFPQRhQ5RCVuexAlLIpR3FKJcmixT1PapuChadghmuyPxfcZ9ZXdDfVVvl+M7vLnbprt4aqfjYSqsHlAfFQbELbaBm0M4hKMvZSukeu7OBz56e0gngW4Dn1fE4CqK4qw0f+VJZ6InzVVeaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162837; c=relaxed/simple;
	bh=t4QhWflZmb3a6EAAnOubb1Rw1MiqOWkmdlzFU3Iyd2A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J5Rs5GGsDN3IZmazBArFT//UGHf8NMoiXNt1Y+WeqS5kVY7YOtpR2Q19VOd7NXshuU0Ctg+MAJC4YpyJkd7CSdanmAf1pxRG0Ceaw77qkwgaeW9/2XuZf4hJLPCA8ewk6T+YUkl1N4bcdl+2WTCZrTVIF0xHJ7xWLN9bANj6Q6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=q6qkveo7; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43F6XmYK075291;
	Mon, 15 Apr 2024 01:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713162828;
	bh=53CrcW3/BJQjl3Y8bJu9EfeREgM50todFjEwoG6XlvU=;
	h=From:To:CC:Subject:Date;
	b=q6qkveo7NjBl3j2dbgdUL+Ps2JSiaPXaYeSp9pzTDxUrAc38F3F6bTXb07gaE/X0G
	 42cgZVRfYFFgArfHbMRznkCqghReQj7GyZYi10DOtQ4ceBedEtVY/BhMnNIhtnNU6R
	 J7F4zYpuOxmddZqD7SIrJjTYarGNdLLSI/nLnyuk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43F6Xmb1024199
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Apr 2024 01:33:48 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 01:33:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 01:33:48 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43F6Xidb065992;
	Mon, 15 Apr 2024 01:33:45 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar
	<u-kumar1@ti.com>
Subject: [PATCH 0/4] Arranging mux and macro update
Date: Mon, 15 Apr 2024 12:03:25 +0530
Message-ID: <20240415063329.3286600-1-u-kumar1@ti.com>
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

I need to resend this, as previous git send-email
just sent cover note and timeout after that.

This series aims to align ordering of pin muxes in following order
main_pmx0/1, wkup_pmx0/1/2/3 along with two fixes for 784s4-evm
and am69 for UART pin type.

Also, updating pin mux macro of J784S4 SOC instead of J721S2 for 784s4-evm
and am69 at few places.

Sorry for this cosmetic push, but usages of pin muxes was not consistent
across the platforms, and even for j784s4-evm wkup_pmx1 was coded at two
place.

For fixes, these errors should be caught during review but missed due to
cross reference is taken from tool's output.

Note to self, don't always rely on tool's output while reviewing the patch.

Boot logs
https://gist.github.com/uditkumarti/089777a8c31482a67be35aa0ab3cefe9 



Udit Kumar (4):
  arm64: dts: ti: k3-j784s4-evm: Arranging mux and macro update
  arm64: dts: ti: k3-am69-sk: Fix UART pin type and macro update
  arm64: dts: ti: k3-j7200: Arranging pin mux in order
  arm64: dts: ti: k3-j721s2: Arranging pin mux in order

 arch/arm64/boot/dts/ti/k3-am69-sk.dts         |  12 +-
 .../dts/ti/k3-j7200-common-proc-board.dts     | 132 +++++++++---------
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   |  31 ++--
 .../dts/ti/k3-j721s2-common-proc-board.dts    |  30 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  |  32 ++---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 116 ++++++++-------
 6 files changed, 175 insertions(+), 178 deletions(-)

-- 
2.34.1


