Return-Path: <linux-kernel+bounces-124157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A96891332
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73EF1F22110
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A210B3C08E;
	Fri, 29 Mar 2024 05:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e0JUcaSR"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695B53BBE8;
	Fri, 29 Mar 2024 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711690330; cv=none; b=BvoO7qGasAz/n+n40KNWCnfxtcRKlfQ8F9uOVKalahXMbx8LJNFh9kj16asJcZuSQwoqwx6QUwW0WPqanZEjcDBe65f8lZFjW29Syo/ocVQA5/3MLDLkn4jlb/ufHuskOrp6BfdfozmLLFX4ABVcObHFsM1ra7fh+sE/cKAaq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711690330; c=relaxed/simple;
	bh=UgAzys+A3Ct9KXhz17x1cUouk22XzMXeBwW0gKTCSVg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PMBtPJSQWck8ajjQCn/Ocp/ArZ1awLlw9FUtXt7HMKQ+mfCR12gf3mC1YvPF56sR4j0/W75P/oWPTWj8dHxBZcSXC8dk2F1kDAD18Z4lxaaAN+3T/IZMNcvs/8kE+QngdJYC/NtTqi/OWR/mAFQxxaeG0ZT+XcGpZQDREOojbxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=e0JUcaSR; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42T5VueI026879;
	Fri, 29 Mar 2024 00:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711690316;
	bh=5lksTCQRb+IpwWrjwgj+d/p3OjVbx/lb5zxF1JmKpyk=;
	h=From:To:CC:Subject:Date;
	b=e0JUcaSR8Cb7F2KhZVnyTpxOFfcq2c932h74cPCliQ/9uDy6xdTIiB+ayNnO6JuCI
	 JRx5o8uNAEBL2cmbm1RlzVcYq66nYHITeNqYhDvLYRekiAw5gHHHQ4K5UEKpFRCGZu
	 k2UFcb9XPAIx9WjiYTdLMuBZegFneEsW3h2bLw98=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42T5VuBj082193
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Mar 2024 00:31:56 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Mar 2024 00:31:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Mar 2024 00:31:55 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42T5Vsf0028006;
	Fri, 29 Mar 2024 00:31:55 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <s-vadapalli@ti.com>,
        Chintan Vankar
	<c-vankar@ti.com>
Subject: [PATCH v6 0/5] Add CPSW2G and CPSW9G nodes for J784S4
Date: Fri, 29 Mar 2024 11:01:25 +0530
Message-ID: <20240329053130.2822129-1-c-vankar@ti.com>
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

Link to v5:
https://lore.kernel.org/r/20240314072129.1520475-1-c-vankar@ti.com/

Changes from v5 to v6:
- Updated order of properties in Device Nodes based on
  https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

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


