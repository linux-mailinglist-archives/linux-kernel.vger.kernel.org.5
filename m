Return-Path: <linux-kernel+bounces-141988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA008A25CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552CB1C22D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674191CAA1;
	Fri, 12 Apr 2024 05:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zqamf3bv"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCA0125CC;
	Fri, 12 Apr 2024 05:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900233; cv=none; b=t205byMa+OFFRXlhwVRowWDgTgSi5xqCGjcSy4PESl1oDvK5lC6khREpeBiGXbVs2nxgLDF86g0GMHUHdKUiWHFXCt8G5Dzd/+PdoTzKK7IV/QXVotm+ATlkPFiS9gtxosmo++JG35C6aojmC7J1PxZzzW4jCKYF5hQRv/V4nJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900233; c=relaxed/simple;
	bh=0kIJRU6gFz0aGszo0gzpp4tU6bLm/VddgMGhasHogXM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fY0vQOopkeQ7QvbWlDUgxTORXz0Hz8Ti8iml3Ce0e3yYE8Ko3oMfdMb4N57baGQnik/Z/og7y3fkBvNo781UHCwN41xFfTYYeMZBOxvFxoM3DFmCQGr8F64YtlQayXGf5XgZzYUOzeF0XSZxM1S4v3dVPjcVOpsgQnqxSnTC5O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Zqamf3bv; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43C5asN6082662;
	Fri, 12 Apr 2024 00:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712900214;
	bh=Io0EcHmCwXnbfHL7GZiyKT8TQNpCyGnmdDp0g/Xczrw=;
	h=From:To:CC:Subject:Date;
	b=Zqamf3bvFGH/7NXlbj39ATGrB1RLRh55PRzgqVZ0lIr9g2e5CSBQh89JHOmHHEDgd
	 Ao5B9leA5FQ79Drz67whOZI9/0Pn7wFBi0mKGtFFaYud16v2V4RKJtgMp2nmo5TwjU
	 SX/js0xhpT4tZOULTfCCH35qpRib1LJlGKnxlf4g=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43C5asel093568
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Apr 2024 00:36:54 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Apr 2024 00:36:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Apr 2024 00:36:54 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43C5aofX085656;
	Fri, 12 Apr 2024 00:36:51 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH v3 0/5] arm64: dts: ti: k3-j7*: Add missing ESM and watchdog nodes
Date: Fri, 12 Apr 2024 11:06:45 +0530
Message-ID: <20240412053650.703667-1-n-francis@ti.com>
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

Boot logs (updated for v3):
https://gist.github.com/nehamalcom/5dc94ab60f57df5d515d0a6d0da6e0d1

Changes since v2:
https://lore.kernel.org/all/20240412042537.666137-1-n-francis@ti.com/
- corrected register size for MCU watchdog instance in J7200 (Udit)
- added Reviewed-by tag (Udit)

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


