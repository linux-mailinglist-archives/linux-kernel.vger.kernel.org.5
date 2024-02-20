Return-Path: <linux-kernel+bounces-72398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 476B685B2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99671F25492
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A213A58201;
	Tue, 20 Feb 2024 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VIQ850wd"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455257872;
	Tue, 20 Feb 2024 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409903; cv=none; b=mMHiQ5GgEedy+qzApKOc5WAdxJa9CbdsPaiibfSq4j7YpVII0ktBj3SZ6ICM1O4fRfroFj4nSpv5XflNMZpREGxxNorj1pjnHFXEIGfG/oVDn/xv6SPORmzJBsE4N+v4Ng368RF7nUic9fTJcv7tqs3EMRncT3wW4/In2zxZ440=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409903; c=relaxed/simple;
	bh=gUkAM6nsKOBeB/7flYRVfw0/0Og27VQ7Th+iZ9+JC4A=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=bQYiHW6P8fnNkrBqFz8NsJePIOEQo+a+JZkDLLfpvPadc25CT/dJTpAARnJilPm2xaVaIboftKnAckn/sWXtyDMVBPUHjYl+2tvlbYcWBfj6RLZwQyzcLd8Ry+mqVn5DxRVt9TKohkrTt5oTYzIcYAiq5IbHY/gXztd2RtopfVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VIQ850wd; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41K6ICAg113559;
	Tue, 20 Feb 2024 00:18:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708409892;
	bh=g7Dcxd60svvnzRjWgQoJnsZXePx8JG9B86EVg8kSl3Q=;
	h=From:Subject:Date:To:CC;
	b=VIQ850wdpavWpnGXS9T5nm1JZbc8Z7vppzHrhAK7nfa0v0YC/HNgOx3V5xJBqjFIu
	 KCEstYxNqkCZZEMk593TWktaETuODFcr+VeRhkISBqyz/O7MfJS+x12/cIHsMAPxKF
	 51Ii8jGPHibdneeWuKP0U4yqONkOOiOTNJqDNCEM=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41K6ICOY024613
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 00:18:12 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 00:18:11 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 00:18:11 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41K6IBST120842;
	Tue, 20 Feb 2024 00:18:11 -0600
From: Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v2 0/4] arm64: dts: ti: Enable camera for SK-AM62P
Date: Tue, 20 Feb 2024 11:48:01 +0530
Message-ID: <20240220-am62p_csi-v2-0-3e71d9945571@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABlE1GUC/22MQQ7CIBAAv9LsWQzQBsWT/zBNA9vV7qGlgYZoG
 v4u9uxxJpPZIVFkSnBrdoiUOXFYKuhTAzi55UWCx8qgpe6klkq42eh1wMTCGzuqS9UGHdR+jfT
 k9/F69JUnTluIn2Od1c/+u2QlpMBr670lR76z943PGGboSylfdVr4c58AAAA=
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Bryan Brattlof <bb@ti.com>, Dhruva Gole <d-gole@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>,
        Devarsh
 Thakkar <devarsht@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
        Jai Luthra
	<j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3007; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=gUkAM6nsKOBeB/7flYRVfw0/0Og27VQ7Th+iZ9+JC4A=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1EQadO1sYYSqtxpuYr7Tz17PTyN8ncMS3FwYd
 CAxSL4GtsuJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdREGgAKCRBD3pH5JJpx
 Ra6wD/sFdvVqR4nPdQ8E0UpHJZO6SU2UMr8O3EUuhqF6EUe4OwI+vibOGk2L1bF5VJxfFEUrvum
 3DsWh/jVcfsmKnRgIcu4UGkVXTJ+LPioltaKxvavRVlSC+BAjnobupeSC6TdhoUigdC91PN0fg5
 MrIsOzYYTf2H2c+gmeJSTWw8/5n++uklIePCnutQe9obZfRBEeC+EcC+YM5xwwDWwpSvaFRzwSk
 0lDWYoOYVILIU73oHHiIm1xRMAR7OZE04t9kzVS6OIwQm0FnqARYmIaUViU+syes9cm7kt5SXsB
 87DRFF730xLe4IVSaHegGw7tZGCHFON68RsGq+sEdhVCtGFxJLWa1U+X59RHFNSfnVYue5mljeg
 K65ES5C+uKzKqpszvTF6Ljmjk2Pn/UDAD2yC6agReu3V/GwpPprY4gCxgRTozTyciyvUcSKb7ez
 Sma4xp4bvp+3RoHRda1hzP966CF/nHIPfWFsnnmQannkuxjLBHdiW4sqJpigPlcr4YY7/Xq692w
 fQ1iUxyURPeKbBr9BwsKvJSrTBo9Atrm3hshG8/S51dQXWE4INRrlNWdobwHcFRqWtkw7EGJt/Y
 uolwcMnOQyhxlMfD7NcBGcYqgcvxjRRZn3vE3VdgTsR6XFMTRcXPsLqwLmMuAztqR4P3gDMUfPp
 lTaVx7DoDDLL6uA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This series enables support for camera sensors using CSI-RX ports on
AM62P family of SoCs.

Particularly, it enables OV5640 and IMX219 sensors via the 22-pin FFC
CSI-RX connector on SK-AM62P [1] using the existing common overlays for
SK-AM62* family of boards.

Capture test:
https://gist.github.com/jailuthra/11f3383ccc0902b9db90d806222597a3

[1]: https://www.ti.com/tool/SK-AM62P-LP

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Changes in v2:
- Rebase on top of ti-k3-dts-next
- Fix commit description of PATCH 3/4 to specify we are keeping the nodes
  disabled
- Link to v1: https://lore.kernel.org/r/20240201-am62p_csi-v1-0-c83bb9eaeb49@ti.com

Range-diff from v1:

1:  646c0b26cee4 ! 1:  61c395edcfd3 arm64: dts: ti: k3-am62p: Fix memory ranges for DMSS
    @@ Commit message
         to enable programming the interrupts correctly.

         Fixes: 29075cc09f43 ("arm64: dts: ti: Introduce AM62P5 family of SoCs")
    +    Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
         Signed-off-by: Jai Luthra <j-luthra@ti.com>

      ## arch/arm64/boot/dts/ti/k3-am62p.dtsi ##
2:  5d6c41db44e3 ! 2:  2720ce668bf9 arm64: dts: ti: k3-am62p: Add DMASS1 for CSI
    @@ Commit message
         On AM62P, CSI-RX uses a dedicated BCDMA instance (DMASS1) for
         transferring captured camera frames to DDR, so enable it.

    +    Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
         Signed-off-by: Jai Luthra <j-luthra@ti.com>

      ## arch/arm64/boot/dts/ti/k3-am62p-main.dtsi ##
3:  2896237c1ad1 ! 3:  9853acf0bc6f arm64: dts: ti: k3-am62p: Add nodes for CSI-RX
    @@ Commit message

         AM62P supports image capture via the MIPI CSI-2 protocol, it uses three
         IPs to achieve this: Cadence DPHY, Cadence CSI-RX, and TI's pixelgrabber
    -    wrapper on top. Enable all of these IPs in the devicetree.
    +    wrapper on top. Add nodes for these IPs in the devicetree, and keep them
    +    disabled here, so these may be enabled by the sensor overlays.

    +    Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
         Signed-off-by: Jai Luthra <j-luthra@ti.com>

      ## arch/arm64/boot/dts/ti/k3-am62p-main.dtsi ##
4:  7a82f73e345d < -:  ------------ arm64: dts: ti: Enable overlays for SK-AM62P
-:  ------------ > 4:  1a5e859dec12 arm64: dts: ti: Enable overlays for SK-AM62P

---
Jai Luthra (4):
      arm64: dts: ti: k3-am62p: Fix memory ranges for DMSS
      arm64: dts: ti: k3-am62p: Add DMASS1 for CSI
      arm64: dts: ti: k3-am62p: Add nodes for CSI-RX
      arm64: dts: ti: Enable overlays for SK-AM62P

 arch/arm64/boot/dts/ti/Makefile           | 10 ++++
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 98 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p.dtsi      |  2 +-
 3 files changed, 109 insertions(+), 1 deletion(-)
---
base-commit: 0f9eb43f009091501dd0c68232aa6530ba0e0185
change-id: 20240201-am62p_csi-b69d172406ca

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>


