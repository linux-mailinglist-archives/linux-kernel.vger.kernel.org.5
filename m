Return-Path: <linux-kernel+bounces-57946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E85684DF60
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17B61C29052
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C51A74E06;
	Thu,  8 Feb 2024 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JizZmGwh"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28D474E0F;
	Thu,  8 Feb 2024 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390372; cv=none; b=Sd4KkvKhtYhtdB4FEdyV6nSSq31yQELsEL0CDxBP5Uty7WOGTagh7dYXfL1au/wDGBtqk5JjJ2CYFF77gGpI0fAiqL0qBoKCSMU0cOMb7XGIS/QUgs1brMgGgp+P6fjLNBF5+YYzWA0eBRq6iQpTYW2cQZmFwinOOgX+F1VPL3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390372; c=relaxed/simple;
	bh=yKIQgx1tYl4N66xn4SONCewxCyLnmqBgU2OMAGJKi54=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bzgr5glAIcF3r2O4TSsxrRVeQ50CASwUsn0CNlnf28GhKZfpzgkNAh1vertatsX4zofLKzedfkFeh0YRZZtgqSqJ3NxeXD/ic7NNrJQl4nL3fkT/aoXPSzyuBvg8ABpDzo/Ybj0pTRbqcH0AMTxa90REjMTfGmk5mHV7cbXaztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JizZmGwh; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418B64X1051890;
	Thu, 8 Feb 2024 05:06:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707390364;
	bh=JXXVu22Eoc25d5j9Jp3/5JtdcHkgF5s1mAQEELWRls0=;
	h=From:To:CC:Subject:Date;
	b=JizZmGwhTJVBUdyW1LRioWhgbQWevYQg5RHjgvK80mPCvaUTKMTmAkuo4htd/eChY
	 SxB2FqVnFHG81rJWNTzf7jptY5388MxwIMJRYegdISyqRC/uFpoKN4zembzlSUVgeR
	 7c0vNF/eL4W0wxMHS7bmyscih3R4xPXMII1JL4Is=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418B64aH022899
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 05:06:04 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 05:06:04 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 05:06:04 -0600
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418B63nP096123;
	Thu, 8 Feb 2024 05:06:03 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>
Subject: [PATCH 0/3] arm64: dts: ti: Modify pinmux for wakeup and mcu uart
Date: Thu, 8 Feb 2024 16:35:59 +0530
Message-ID: <20240208110602.931573-1-b-kapoor@ti.com>
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

WKUP_PADCONFIG registers for wakeup and mcu uart lies
under wkup_pmx2 for J7200. Thus, modify pinmux for both
of them.

Only Tx and Rx Signal lines for wakeup uart are brought out on
J721S2 Common Proc Board and J784S4 EVM, but CTS and RTS signal
lines are not brought out. Thus, remove pinmux for CTS and RTS signal
lines for wake up uart in J721S2 and J784S4.

Rebased to 20240208

Bhavya Kapoor (3):
  arm64: dts: ti: k3-j7200-common-proc-board: Modify Pinmux for wakeup
    and mcu uart
  arm64: dts: ti: k3-j721s2-common-proc-board: Remove Pinmux for CTS and
    RTS in Wakeup Uart
  arm64: dts: ti: k3-j784s4-evm: Remove Pinmux for CTS and RTS in Wakeup
    Uart

 .../boot/dts/ti/k3-j7200-common-proc-board.dts | 18 +++++++++---------
 .../dts/ti/k3-j721s2-common-proc-board.dts     |  2 --
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts       |  2 --
 3 files changed, 9 insertions(+), 13 deletions(-)

-- 
2.34.1


