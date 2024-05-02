Return-Path: <linux-kernel+bounces-166180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8BF8B973E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC2D1C2128F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CE454660;
	Thu,  2 May 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Iu0FC13p"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73DC524C9;
	Thu,  2 May 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641049; cv=none; b=eWQtC/LL2XD28FVOeQm4d8Q6F/CJEcRUtvfdp14Bf2LYfOHMsTAYwktElbzz3DpV84605aKTdPsntOdsxhSWidlZyn0Zznh5l35f8fB4MbY5LtV16TCByEoQufI+JlRMn4mllP5VM5K+BmnzKA/Oomxr503wEvRZSWeNPWYEHzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641049; c=relaxed/simple;
	bh=/62qrElWcEFVuq9yrX0+3UpW+I+c2tzCKflTT/yqC58=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pezbLb2OGXAJu2gaQTU5M1fxeDLxnIG/0V2yjcRXQuKM5o3IOOMbSCE6+yvwi8g8dWNTAiVYKfGhruBKlKicZoLaGwXoiBiR2T31mZtrw3VA+v7jj+/2MfPqqkULBB4VkkMckCNSXviG89hyiIiWVeBHLVxP9kMg3+rqAa4eazg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Iu0FC13p; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4429AZP8038072;
	Thu, 2 May 2024 04:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714641035;
	bh=H+gfwzukIpwZ3LcdXxpMyQQbJM0fjYYDlzLH84RZbEQ=;
	h=From:To:CC:Subject:Date;
	b=Iu0FC13pgzjqIJh7S9Czgu/nSua9ksZzcqzi4uYgo+4di/60yZsZMgaRjAtjvRKmG
	 tqPY7d9sKlJNYMeep+JLGjYVmAwcKm4DNQiZ7390lhkTbS+DK8cSMnbijTzDzeLS2r
	 ggGmvuF6neDGzlifFAS1XZt5R18cg5EJQubMF1Os=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4429AZLS020184
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 2 May 2024 04:10:35 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 May 2024 04:10:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 May 2024 04:10:35 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4429AY4b007440;
	Thu, 2 May 2024 04:10:34 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <s-vadapalli@ti.com>, <danishanwar@ti.com>, <r-gunasekaran@ti.com>,
        <srk@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH v7 0/5] Add CPSW2G and CPSW9G nodes for J784S4
Date: Thu, 2 May 2024 14:39:57 +0530
Message-ID: <20240502091002.3659435-1-c-vankar@ti.com>
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

This series adds device-tree nodes for CPSW2G and CPSW9G instance
of the CPSW Ethernet Switch on TI's J784S4 SoC. Additionally,
two device-tree overlays are also added:
1. QSGMII mode with the CPSW9G instance via the ENET EXPANSION 1
   connector.
2. USXGMII mode with MAC Ports 1 and 2 of the CPSW9G instance via
   ENET EXPANSION 1 and 2 connectors, configured in fixed-link
   mode of operation at 5Gbps link speed.

This series is based on linux-next tagged next-20240502.

Link to v6:
https://lore.kernel.org/r/20240329053130.2822129-1-c-vankar@ti.com/

Changes from v6 to v7:
- Corrected the syntax error in [PATCH v6 5/5].

Chintan Vankar (1):
  arm64: dts: ti: k3-j784s4-evm: Add alias for MCU CPSW2G

Siddharth Vadapalli (4):
  arm64: dts: ti: k3-j784s4-main: Add CPSW2G and CPSW9G nodes
  arm64: dts: ti: k3-j784s4-evm: Enable Main CPSW2G node and add aliases
    for it
  arm64: dts: ti: k3-j784s4: Add overlay to enable QSGMII mode with
    CPSW9G
  arm64: dts: ti: k3-j784s4: Add overlay for dual port USXGMII mode

 arch/arm64/boot/dts/ti/Makefile               |  11 +-
 .../ti/k3-j784s4-evm-quad-port-eth-exp1.dtso  | 147 ++++++++++++++
 .../ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso   |  81 ++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      |  51 +++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 187 ++++++++++++++++++
 5 files changed, 476 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso

-- 
2.34.1


