Return-Path: <linux-kernel+bounces-50271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA248476B8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1088EB22D4E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A41414AD3F;
	Fri,  2 Feb 2024 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sQ25Q8lR"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE91A14AD16;
	Fri,  2 Feb 2024 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896562; cv=none; b=D4gFiAnDFFGAKgDM28Sh74yybLxE2zTVOeAfKjjYuyr1f80llAkVVoyWrc78oyWNhNpX3pDfBBPjMca4zdUgEwy0jsVNtSkbEPLuHxnMxzaqfnCYW8eWl/jlBOHsj/RYCz1FSZyFB0r2vtlIDj3BPDSGgRkAnTqpArTiPZbeYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896562; c=relaxed/simple;
	bh=qfwEz8hpHsqgnU+4/WFirpMN2irACdQrIsL+NmunY7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WPIwUDU2h9b1EizJKLm28xiODrjItM/K/Q+Y5nMB2PaMijkL+4bTetzZEd1ZoHSG59a0Ce4VMzXS6QtERMZS43Q3SiM6vSKReHEWk65P9H9Tzyh4foK57oqEKMiWliFZIcG3lI1YOMfGYWfEslNYv47n7IRfIfZvwE4IPwI9G4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sQ25Q8lR; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 412HthxX030367;
	Fri, 2 Feb 2024 11:55:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706896543;
	bh=Vr15aner70yVXaHBFlAcgeLFRPozQNQYOHKtYk6Y8CE=;
	h=From:To:CC:Subject:Date;
	b=sQ25Q8lRPE4GkcyDs3KKXlSerUz8PWSTgoyvRF5kMJAmymb2Wd2yy6LhE5iZXbT6n
	 MH4tL3RLcB0T50dumaRC7L/QvZt7v2kt3z3xYJV878JA4TU8Kave+s2uWaMe466c6n
	 v7x0dwISaWda/jyfVJMz16t9g6lU6fNJzQTJEdSI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 412HthTV003944
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 Feb 2024 11:55:43 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Feb 2024 11:55:43 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Feb 2024 11:55:43 -0600
Received: from localhost ([10.249.48.175])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 412HtggK114579;
	Fri, 2 Feb 2024 11:55:42 -0600
From: Hari Nagalla <hnagalla@ti.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <p.zabel@pengutronix.de>, <martyn.welch@collabora.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v7 0/5] TI K3 M4F support on AM64x and AM62x SoCs
Date: Fri, 2 Feb 2024 11:55:33 -0600
Message-ID: <20240202175538.1705-1-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The following series introduces K3 M4F remoteproc driver support for
AM64x and AM62x SoC families. These SoCs have a ARM Cortex M4F core in
the MCU voltage domain. For safety oriented applications, this core is
operated independently with out any IPC to other cores on the SoC.
However, for non safety applications, some customers use it as a remote
processor and so linux remote proc support is extended to the M4F core.

See AM64x Technical Reference Manual (SPRUIM2C – SEPTEMBER 2021) for
further details: https://www.ti.com/lit/pdf/SPRUIM2

See AM62x Technical Reference Manual (SPRUIV7A – MAY 2022) for
further details: https://www.ti.com/lit/pdf/SPRUIV7A

kernel build log: https://paste.sr.ht/~hnagalla/be9d1c45e176ea8fa274ab13a3da43a9853fcf7f
dt-binding-check log: https://paste.sr.ht/~hnagalla/25912c85f6a8c68e3da24053fc060f38024fb8ab 
kernel boot log: https://paste.sr.ht/~hnagalla/5ba77847343f22b5f9ec2b7aeabc410aaf8cdf45

Hari Nagalla (2):
  dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs
  arm64: defconfig: Enable TI K3 M4 remote proc driver

Martyn Welch (3):
  remoteproc: k3: Move out data structures common with M4 driver
  remoteproc: k3: Move out functions common with M4 driver
  remoteproc: k3-m4: Add a remoteproc driver for M4F subsystem

 .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  |  138 ++
 arch/arm64/configs/defconfig                  |    1 +
 drivers/remoteproc/Kconfig                    |   13 +
 drivers/remoteproc/Makefile                   |    3 +-
 drivers/remoteproc/ti_k3_common.c             |  583 ++++++++
 drivers/remoteproc/ti_k3_common.h             |  107 ++
 drivers/remoteproc/ti_k3_dsp_remoteproc.c     | 1277 +++++------------
 drivers/remoteproc/ti_k3_m4_remoteproc.c      |  327 +++++
 8 files changed, 1539 insertions(+), 910 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
 create mode 100644 drivers/remoteproc/ti_k3_common.c
 create mode 100644 drivers/remoteproc/ti_k3_common.h
 rewrite drivers/remoteproc/ti_k3_dsp_remoteproc.c (67%)
 create mode 100644 drivers/remoteproc/ti_k3_m4_remoteproc.c

-- 
2.34.1


