Return-Path: <linux-kernel+bounces-118972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B99A88C217
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D28E1C3226A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C7874267;
	Tue, 26 Mar 2024 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f1eXqbhy"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FA070CDA;
	Tue, 26 Mar 2024 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456060; cv=none; b=MmJ5PxyY8H4bUh4g2thO0iJA+e68SgHjl2TCGxpR2pNH1dSCzq+8rkFjOjpxPhMkUExj/3I0tJIZgwoiN25M2JO0YXJIa5bg9/+j3py+4uykMYTUbcM7PVpSXvag1iaM1voB4/+upK9YXnuU+XonpbFcpjvX18/xaD/DjYvGdt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456060; c=relaxed/simple;
	bh=8Jl54xlqjwkJWP5PUMyWwqy9IBRiotbXYLdQBgcsjJo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kxMGuZx44naak+c7Eiq5Vfzr7/zZlp04rOtiPas1B1AaHGAJTg/MviziotsJz/8c7fXZDjk3jVR7BM6UF2zmxwCc3X+8kPmoxVMyyjXJzJC8nG6y6jzUOsENiHCBSELAf2mG5Gt/4/y89Z459KxCn/bxIaTfBkNoN8XPpADG9gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f1eXqbhy; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QCRR7d080815;
	Tue, 26 Mar 2024 07:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711456047;
	bh=XMIn4Bg0h4wNwem/5Hp295ouaQHawgTd9UzgVAS9LZ8=;
	h=From:To:CC:Subject:Date;
	b=f1eXqbhy8Tv2ne/fpJ6An7ULgloUhTkKJ5mfFRou79EgQMkkYFWvx6qtIcpm7+q48
	 132OzR50MsLWxb2H8L9+qmFzRs8mgcJh7ex13hARTiXFpdte2Qw2XPm0/ufv/qvPxI
	 0/Y+8tGFapBTqt1Nh8dB16fBYVMHIrDoCvf6PVEk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QCRR4b035160
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 07:27:27 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 07:27:27 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 07:27:27 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QCRN2b129435;
	Tue, 26 Mar 2024 07:27:24 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH 0/4] arm64: dts: ti: k3-j7*: Add missing ESM and watchdog nodes
Date: Tue, 26 Mar 2024 17:57:19 +0530
Message-ID: <20240326122723.2329402-1-n-francis@ti.com>
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

Boot logs:
https://gist.github.com/nehamalcom/5dc94ab60f57df5d515d0a6d0da6e0d1

Neha Malcom Francis (4):
  arm64: dts: ti: k3-j721e-mcu: Add the WKUP ESM instance
  arm64: dts: ti: k3-j721e-mcu: Add the MCU domain watchdog instances
  arm64: dts: ti: k3-j721e-main: Add the MAIN domain watchdog instances
  arm64: dts: ti: k3-j7200-main: Add the MAIN domain watchdog instances

 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 27 ++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 93 +++++++++++++++++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 31 +++++++
 3 files changed, 151 insertions(+)

-- 
2.34.1


