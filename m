Return-Path: <linux-kernel+bounces-66627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFA2855F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC681F21F38
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC1D78669;
	Thu, 15 Feb 2024 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HlAD6v4t"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6229077F22;
	Thu, 15 Feb 2024 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993053; cv=none; b=c5jfRpK30uYGs77G2mycKJdapHprdc8lPgz4eYC3WX6TmgSMwJGUxfClWypuYEW9vL6QtIvUwZoocgcqC7xUzLRCYyHfN84TGc58KQQefvPrnV23/41CoWC/QCtPT2qTriBLB5eMw2kziDAuIqENHliNMaawVfeRcfzpEQjopRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993053; c=relaxed/simple;
	bh=kCRokLOhZl6yvnHX5JwFP41xHOBcBkNACEwai6IqO9Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oMRLWm4poPRWuFVtBUa7vnG0aoOtvFh0s3Dbiwq4TDtu1aj9Q3eT4wy4FAtBUnF4fbC8kVGtG9FHCQ4CS/ybgPd/MM52+xePWuFEw8Up4J+yboevDsgEmDWy23SapeRdI2FmS31YBJFotreMST94YzPtRTuG76ea4BcuHvOxhVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HlAD6v4t; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41FAUd3K118472;
	Thu, 15 Feb 2024 04:30:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707993039;
	bh=+n90dqjXRjOMQb16XVs2S115NbnHy10Ajvp1/zZckt0=;
	h=From:To:CC:Subject:Date;
	b=HlAD6v4tAnROGB3f2SP9GOuyeVwg8A6jRaOFZD5n7VSV9fzGYTqMTvLE821UgGLQ9
	 AKPXsiy49hqjCW0DEET0nQQwbou09r4Q3gsk0Cj4xN1XWEpur8kxUaZiWqp6lh3J/X
	 nhv8EDBkvrNZNLXRA+CC9zIrY444j63iU/bspG9E=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41FAUdKQ025689
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 04:30:39 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 04:30:38 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 04:30:38 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41FAUcvk018921;
	Thu, 15 Feb 2024 04:30:38 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 41FAUc2u031768;
	Thu, 15 Feb 2024 04:30:38 -0600
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
Subject: [PATCH v5 0/3] Add AM64x ICSSG Ethernet support
Date: Thu, 15 Feb 2024 16:00:33 +0530
Message-ID: <20240215103036.2825096-1-danishanwar@ti.com>
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
This series is based on the latest next-20240214 linux-next.

AM64x EVM has three ethernet ports. One is dedicated to CPSW and one is
dedicated to ICSSG1. The remaining port is muxed between CPSW and ICSSG1
ICSSG1 ports. The ICSSG1 node is added in the k3-am642-evm.dts. By default
the muxed port is used by CPSW so 2nd ICSSG1 port is disabled in the
k3-am642-evm.dts. But overlay k3-am642-evm-icssg1-dualemac.dtso can be
applied to use muxed port as ICSSG1.

This is the v5 of the series [v1].

Changes from v4 to v5:
*) Added Roger's RB tag in patch 1/3 and 3/3
*) Modified commit message of patch 3/3
*) Dropped ti,syscon-rgmii-delay property from patch 2/3 as it is no
   longer needed.
*) Reverted the renaming of mdio-mux nodes back to 'mdio-mux-1' and
   'mdio-mux-2' from 'mdio-mux@1' and 'mdio-mux@0' as the later was
   throwing DTBS_CHECK warnings.

Changes from v3 to v4:
*) Dropped ethernet3 alias from k3-am642-evm.dts as suggested by Roger.
*) Dropped extra blank lines from k3-am642-evm.dts.
*) Updated commit message of patch 3/3
*) Updated licensing header in k3-am642-evm-icssg1-dualemac.dtso.
*) Fixed up alias for ethernet1 to icssg1_emac1 in
   k3-am642-evm-icssg1-dualemac.dtso as suggested by Roger.
*) Renamed 'mdio-mux-1' and 'mdio-mux-2' to 'mdio-mux@1' and 'mdio-mux@0'
   respectively as suggested by Roger.

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
[v3] https://lore.kernel.org/all/20240122113045.1711818-1-danishanwar@ti.com/
[v4] https://lore.kernel.org/all/20240205090546.4000446-1-danishanwar@ti.com/

Thanks and Regards,
MD Danish Anwar

MD Danish Anwar (2):
  arm64: dts: ti: k3-am642-evm: add ICSSG1 Ethernet support
  arm64: dts: ti: k3-am642-evm: add overlay for ICSSG1 2nd port

Suman Anna (1):
  arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes

 arch/arm64/boot/dts/ti/Makefile               |  5 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      | 24 +++++
 .../dts/ti/k3-am642-evm-icssg1-dualemac.dtso  | 79 +++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       | 97 ++++++++++++++++++-
 4 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac.dtso

base-commit: 2c3b09aac00d7835023bbc4473ee06696be64fa8
-- 
2.34.1


