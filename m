Return-Path: <linux-kernel+bounces-141920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC208A2520
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10921C2154C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F3218E3F;
	Fri, 12 Apr 2024 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cqiCybhM"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85D018021;
	Fri, 12 Apr 2024 04:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895952; cv=none; b=opspDUTbS8l3511ISoEwQV0XndZkm+n9AXWhHLBP8jB9CzFP6Vy+x7mnxmJv4ysqJ0XlrUnO3sbI+krjsNrWSDI62W7UK96p83woPgNFw8ezi2z6CT6FlxNU3YxHSidpOLO5fObzwxCwN9jPfPD3jZED3J/K2tZal1BiVa7aTts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895952; c=relaxed/simple;
	bh=mKgx5cl0/igRDLKCuUQ7DuWyjLoEa3B+wMZEZ+aYBi8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kk1LNw3kKxZqQ8lphP0dlTUH4aokB7OHnEouiyZ6nLycnO0nm+MBvmPBT1MrLcGXBdAUGefI3hbGo9A3B8MnqMNDW7DFtM6mjUGeP7YGkH6kl2HYSs+oLYz7PN2LoBFft1MbBiULxak5C//X3pDPmUkBNHLG79QKOlYAZoEcvK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cqiCybhM; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43C4Pf4f064453;
	Thu, 11 Apr 2024 23:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712895941;
	bh=K46w1PP0pYtXy4dPOOTNwFZVINedOSSvvS4cQNVlicU=;
	h=From:To:CC:Subject:Date;
	b=cqiCybhMzSR7XjQHxq/Miaw34fgOYbNtKa1ufwvoMa7F232pfDrf5v3DxQqE26xxm
	 /kr/Gf6ovcio73DPR7ssdzkZ51NM6+vVs6nW9Y4zrGBKeoSjSX36FhnJCI2qM3aa4O
	 FJAGXap8vJCQS87RHZigHMmdcQ5DXMvfTHdidTkk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43C4PftF030985
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 23:25:41 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Apr 2024 23:25:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Apr 2024 23:25:41 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43C4PbNa078207;
	Thu, 11 Apr 2024 23:25:38 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH v2 0/5] arm64: dts: ti: k3-j7*: Add missing ESM and watchdog nodes
Date: Fri, 12 Apr 2024 09:55:32 +0530
Message-ID: <20240412042537.666137-1-n-francis@ti.com>
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

Add missing ESM and watchdog nodes for the sake of devicetree completion
of hardware description w.r.t Linux and ESM and WDT enablement on
U-Boot. This patch series adds the missing nodes for J721E and J7200.

Boot logs (updated for v2):
https://gist.github.com/nehamalcom/5dc94ab60f57df5d515d0a6d0da6e0d1

Changes since v1:
https://lore.kernel.org/all/20240326122723.2329402-1-n-francis@ti.com/
- modified node name numbering to be in sync with TRM (Udit)
- disabled wkup_esm node in J721E (Udit)
- added patch (5/5) for MCU domain watchdog instances in J7200 (Udit)

Neha Malcom Francis (5):
  arm64: dts: ti: k3-j721e-mcu: Add the WKUP ESM instance
  arm64: dts: ti: k3-j721e-mcu: Add the MCU domain watchdog instances
  arm64: dts: ti: k3-j721e-main: Add the MAIN domain watchdog instances
  arm64: dts: ti: k3-j7200-main: Add the MAIN domain watchdog instances
  arm64: dts: ti: k3-j7200-mcu: Add the MCU domain watchdog instances

 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 27 ++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 26 ++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 93 +++++++++++++++++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 32 +++++++
 4 files changed, 178 insertions(+)

-- 
2.34.1


