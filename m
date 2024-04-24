Return-Path: <linux-kernel+bounces-157585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 583678B1339
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9421C240EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDE92B9CF;
	Wed, 24 Apr 2024 19:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zF0wSj5k"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42AE1DDF4;
	Wed, 24 Apr 2024 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985599; cv=none; b=YftVP/lRm1HrPoYvv1rmroDOl1dAHeKGFvVUr3lMIG9XLc0DO6NhmDtf0O/dKsFaetJct1mHLcfOcQ2ECsVpgwK3p1WwTZjfWorkOhYB++XWzdjtwsX0Dmpyk89BlpVw2pcOjoJb8O67kjUjzplYewYAgN+ldM4DQQtde7aMP5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985599; c=relaxed/simple;
	bh=WYoh90sRIRI9un9UAfYGHEtVzQuEF9n+z1X1OknWuN4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IX3i1e5Xzs8gkmJohRtvKyk3QupUR9QiVKU8b2reacBWA2/7uo/5CDn04S0U+CThY5Uvl1KWI+Dok5A3ovBUkjhJCKXJrGl5omynbomCenCMKojtBvhp6w4yOdrD/AgZK8gY86sa1JHRuy8FfhGsC7nf8LkX7fo0AGY0eKwfSaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zF0wSj5k; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43OJ6DGk004439;
	Wed, 24 Apr 2024 14:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713985573;
	bh=x032eyrn6hQaOAO3LEFL1lvrOVjn5YoaEkDcNs3WXGA=;
	h=From:To:CC:Subject:Date;
	b=zF0wSj5k2gqtemLwsYM2rMIDDm3JyZ3SPrvzrvFui9v3xLy83ZrdRgaZoX1SM8qPk
	 RKVpfFPStKxdB57ULywBkGhv3If8dEJqV0R6BBWnI6Xz98VIMFPo6O9ISGIZlrtrSW
	 LhOM8qB2L2X7/bm+1fCSHVL32ntlGlvL5A9VmG1s=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43OJ6Dsr017950
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Apr 2024 14:06:13 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Apr 2024 14:06:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Apr 2024 14:06:13 -0500
Received: from ula0226330.dhcp.ti.com (ula0226330.dhcp.ti.com [10.219.51.241])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43OJ6DqN067070;
	Wed, 24 Apr 2024 14:06:13 -0500
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
Subject: [PATCH v8 0/4] TI K3 M4F support on AM62 SoCs
Date: Wed, 24 Apr 2024 14:06:08 -0500
Message-ID: <20240424190612.17349-1-afd@ti.com>
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

Hari Nagalla (3):
  dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs
  arm64: defconfig: Enable TI K3 M4 remoteproc driver
  arm64: dts: ti: k3-am62: Add M4F remoteproc node

Martyn Welch (1):
  remoteproc: k3-m4: Add a remoteproc driver for M4F subsystem

 .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 126 +++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi       |  12 +
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  18 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/remoteproc/Kconfig                    |  13 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/ti_k3_m4_remoteproc.c      | 785 ++++++++++++++++++
 7 files changed, 956 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
 create mode 100644 drivers/remoteproc/ti_k3_m4_remoteproc.c

-- 
2.39.2


