Return-Path: <linux-kernel+bounces-32927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E5183620F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6F01C26B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399B747A78;
	Mon, 22 Jan 2024 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s/eGIi4O"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56234439B;
	Mon, 22 Jan 2024 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923069; cv=none; b=Qvk9zyFj9ELYgLAd4A2BD9iJjsj/sGXpoWR9K2CEvCdlODgHZZCAoCaGscJaJkplH7YQv/WElBpBrh68yJYi/+rdyB8gzPpKRXGRNGJX6kuKeDMTW9uCdAeQf3b0Rr0tedJt7F4wRyqla8hTr7c8rfURfsWs94Lg+Rj/86/A7ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923069; c=relaxed/simple;
	bh=4tCrzUC+/YgxObX8hzrHBOPIJAA1eJDa7iglCGdrgKg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hO19NobB8x46TITIduBBfU6XibYbNcLt1PH5zMXU2zUofIZ6ydVdQ78v+0OUxjkH9a5HIBQfnb5iux6Zl7w75BfqO8odeCC5Z7m0AQvS45SbK4Ocw7xx+EJTZrcqAli/8JejpGU6zOo3AWLQ4ApNd+7xLRB8VvdGnXQxH208M6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s/eGIi4O; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40MBUvvC121154;
	Mon, 22 Jan 2024 05:30:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705923057;
	bh=dzEoq5dLrijjQejs3RrwVn51yH4SqPJoQUpFjXavDyo=;
	h=From:To:CC:Subject:Date;
	b=s/eGIi4Ogz4bVRI+XTm2F46nKL8tF5sRBsgQ7lBHlwGdo04lNPJYP1nATBT1rlvUE
	 sM2BVx1INP14YeMdbpJg+agWbRbbHWhJpfLaQNPmmcdeCMjSffFpCi6dKMAgQApc4L
	 VulnGX/Exa4E5c7JgKXaE8ETCZ6W/nJfVlnkNM+0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40MBUv57054692
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jan 2024 05:30:57 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 05:30:57 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 05:30:57 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40MBUvNY115874;
	Mon, 22 Jan 2024 05:30:57 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 40MBUufF021315;
	Mon, 22 Jan 2024 05:30:57 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero
 Kristo <kristo@kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger
 Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH v3 0/3] Add AM64x ICSSG Ethernet support
Date: Mon, 22 Jan 2024 17:00:42 +0530
Message-ID: <20240122113045.1711818-1-danishanwar@ti.com>
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

Hi All,

This series adds support for ICSSG ethernet on AM64x. 
This series is based on the latest next-20231211 linux-next.

AM64x EVM has three ethernet ports. One is dedicated to CPSW and one is
dedicated to ICSSG1. The remaining port is muxed between CPSW and ICSSG1
ICSSG1 ports. The ICSSG1 node is added in the k3-am642-evm.dts. By default
the muxed port is used by CPSW so 2nd ICSSG1 port is disabled in the
k3-am642-evm.dts. But overlay k3-am642-evm-icssg1-dualemac.dtso can be
applied to use muxed port as ICSSG1.

This is the v3 of the series [v1].

Changes from v2 to v3:
*) No functional changes.
*) Rebased on latest linux-next (next-20240122) after 6.8-rc1.

Changes from v1 to v2:
*) Fixed aliases section in k3-am642-evm.dts
*) Fixed firmware-names in k3-am642-evm.dts
*) Changed icssg1_phy1 to ethernet-phy@f from ethernet-phy@0 as suggested
   by Andrew L.
*) Changed makefile to handle overlays using CONFIG_OF_ALL_DTBS as
   suggested by Nishant and Andrew Davis.
*) Fixed aliases section in k3-am642-evm-icssg1-dualemac.dtso
*) Fixed pinctrl in k3-am642-evm-icssg1-dualemac.dtso
*) Updated commit message of patch 3/3 of the series to warn about adding
   label name to 'mdio-mux-1' node.

[v1] https://lore.kernel.org/all/20231207081917.340167-1-danishanwar@ti.com/
[v2] https://lore.kernel.org/all/20231212165832.3933335-1-danishanwar@ti.com/

Thanks and Regards,
MD Danish Anwar

MD Danish Anwar (2):
  arm64: dts: ti: k3-am642-evm: add ICSSG1 Ethernet support
  arm64: dts: ti: k3-am642-evm: add overlay for icssg1 2nd port

Suman Anna (1):
  arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes

 arch/arm64/boot/dts/ti/Makefile               |   5 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |  24 ++++
 .../dts/ti/k3-am642-evm-icssg1-dualemac.dtso  |  75 +++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       | 104 +++++++++++++++++-
 4 files changed, 207 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac.dtso

base-commit: 319fbd8fc6d339e0a1c7b067eed870c518a13a02
-- 
2.34.1


