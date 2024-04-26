Return-Path: <linux-kernel+bounces-160611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3003A8B400E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CF11F22F82
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8400327711;
	Fri, 26 Apr 2024 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r1J5vK1m"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9CF200D5;
	Fri, 26 Apr 2024 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714159120; cv=none; b=lRqAaVPHmsA8AeiDQ8ndVlo64VYW1DDPuu3/3jK+M3IltVGZPv993HrjHTpwj7c958a09hoEUhAfAOIrcOP5yISWUG0Ty3PiDIUsIHM9V/gYS7MnrQurLWe9f/xg2JLa8jc+yLEwjmCgBdPxykgOSx5Wv8ZKkocQqP7wm4httRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714159120; c=relaxed/simple;
	bh=uGwiYVt/DbMYRZxna6pr8UV1w1MMAGhUput4YYCgc9A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F+lhCmEIkFDpvenSOxcMHnEC67gKcEvfnaXmVs4NJ0V4CQijyIOs6Ti6fk0E8WJcdHnhDDp/Q9G3WeUWn8I+JJ6z+48UTc4cir3pkbG4g1qyJ+EjF0ZIRtZ7K2T8Mk4uXzJe2EF/AUo6Kc8ghPR88HejiDNQ6/VWpXcqE3WFWGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r1J5vK1m; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QJICL2019118;
	Fri, 26 Apr 2024 14:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714159092;
	bh=7dBjfJ1mZuQBiogtf4rbNt6K/PfcTrXpxljZm57C46g=;
	h=From:To:CC:Subject:Date;
	b=r1J5vK1mrpUecX4e+6ysDuTCC/FijfIy/X6sXlKog6rEiypQsuO0mDwchb5Jfi4p0
	 VwKHldcz8DG1UE8SnuzqLW6EuOHelD2phSsgYj0xBPAvEO2bty202eePUHEX3fzzUf
	 FbDfp6g9f+3pSkLLjljJb8GQCh9SlLkUrjjLWcX8=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QJICjH001738
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 14:18:12 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 14:18:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 14:18:11 -0500
Received: from ula0226330.dhcp.ti.com (ula0226330.dhcp.ti.com [128.247.81.8])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QJIB7J028593;
	Fri, 26 Apr 2024 14:18:11 -0500
From: Andrew Davis <afd@ti.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth
 Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo
	<kristo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hari Nagalla
	<hnagalla@ti.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v9 0/5] TI K3 M4F support on AM62 SoCs
Date: Fri, 26 Apr 2024 14:18:06 -0500
Message-ID: <20240426191811.32414-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello all,

This is the continuation of the M4F RProc support series from here[0].
I'm helping out with the upstream task for Hari and so this version(v8)
is a little different than the previous(v7) postings[0]. Most notable
change I've introduced being the patches factoring out common support
from the current K3 R5 and DSP drivers have been dropped. I'd like
to do that re-factor *after* getting this driver in shape, that way
we have 3 similar drivers to factor out from vs trying to make those
changes in parallel with the series adding M4 support.

Anyway, details on our M4F subsystem can be found the
the AM62 TRM in the section on the same:

AM62x Technical Reference Manual (SPRUIV7A – MAY 2022)
https://www.ti.com/lit/pdf/SPRUIV7A

Thanks,
Andrew

[0] https://lore.kernel.org/linux-arm-kernel/20240202175538.1705-5-hnagalla@ti.com/T/

Changes for v9:
 - Fixed reserved-memory.yaml text in [1/5]
 - Split dts patch into one for SoC and one for board enable
 - Corrected DT property order and formatting [4/5][5/5]

Hari Nagalla (4):
  dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs
  arm64: dts: ti: k3-am62: Add M4F remoteproc node
  arm64: dts: ti: k3-am625-sk: Add M4F remoteproc node
  arm64: defconfig: Enable TI K3 M4 remoteproc driver

Martyn Welch (1):
  remoteproc: k3-m4: Add a remoteproc driver for M4F subsystem

 .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 125 +++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi       |  13 +
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  19 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/remoteproc/Kconfig                    |  13 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/ti_k3_m4_remoteproc.c      | 785 ++++++++++++++++++
 7 files changed, 957 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
 create mode 100644 drivers/remoteproc/ti_k3_m4_remoteproc.c

-- 
2.39.2


