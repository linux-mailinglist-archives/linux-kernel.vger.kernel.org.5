Return-Path: <linux-kernel+bounces-120066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 154A488D11C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467CB1C2AB34
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9D713E02E;
	Tue, 26 Mar 2024 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KlB/YNtK"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FC273189;
	Tue, 26 Mar 2024 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492662; cv=none; b=Ass410r2R3ql/QnRfRGXWvFFwWsS5iZDYXPcfwP0uqXzTXn+k4OvFmXaCdCd1x9/72WXw3B2xEuLHK+WvjTCNnElAmEHWgdORPlKPOI1X1pmJMunpGThij7STRF2T3klhuJxXRPINqlvIVws8m5oX3QDKE68tPP4FvS3eQhiIuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492662; c=relaxed/simple;
	bh=520Om8/gOxOGIscUHLDVMS47Bb6fvMQE5DtU+M4EBxk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O4LqPpbEB87icehF70QFC1mHFwV9KxwtFiQRHhaZWsNSd8A+8gm0Gt7icC20IHQDFIDeCgHxNNzdiu8Xrd7xQq9aAoM2yMk4DL+LEMBsMtHLtQIESa937F/8hTBTa8FGZC7OjM3aG7iv4rhw3R0uXALvGOPFbWd33dz5eOWxGIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KlB/YNtK; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QMbVoQ117991;
	Tue, 26 Mar 2024 17:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711492651;
	bh=hdbS8hHS7byI8y8EUeETEK7HCF+OfuH+24CxpKPG5yQ=;
	h=From:To:CC:Subject:Date;
	b=KlB/YNtKq+tC0dSUW7H4w0gmacbQY8azUCs0PD4CIvScO6VUmBx3StkR5xXt6Q/BU
	 AZjeCt1K+nl2sO8CISKabHMyvcbRodZ9onQkega1l3AekUWylLT2h5z0Le6LVgxqnH
	 znV257RXPNai0/0hNCr5qGnOBuGote2sRN4Ajuuc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QMbVF7106444
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 17:37:31 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 17:37:31 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 17:37:31 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QMbVmX109669;
	Tue, 26 Mar 2024 17:37:31 -0500
From: Andrew Davis <afd@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 0/4] Unconditionally register TI-SCI reset handler
Date: Tue, 26 Mar 2024 17:37:26 -0500
Message-ID: <20240326223730.54639-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello all,

This series is the replacement for this series[0] and is based on a
comment in that series by Rob here[1].

First patch is just a fixup, second patch is the core of the series.

Thanks,
Andrew

[0] https://lore.kernel.org/lkml/20240131221957.213717-1-afd@ti.com/
[1] https://lore.kernel.org/lkml/20240201230351.GA1900918-robh@kernel.org/

Andrew Davis (4):
  firmware: ti_sci: Use devm_register_restart_handler()
  firmware: ti_sci: Unconditionally register reset handler
  ARM: dts: ti: keystone: k2g: Remove ti,system-reboot-controller
    property
  dt-bindings: arm: keystone: Remove ti,system-reboot-controller
    property

 .../bindings/arm/keystone/ti,sci.yaml         |  5 ----
 .../boot/dts/ti/keystone/keystone-k2g.dtsi    |  5 ----
 drivers/firmware/ti_sci.c                     | 24 +++++--------------
 3 files changed, 6 insertions(+), 28 deletions(-)

-- 
2.39.2


