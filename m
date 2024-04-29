Return-Path: <linux-kernel+bounces-162037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933D68B54F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41501C219D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973962E40E;
	Mon, 29 Apr 2024 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E9QEtbBK"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AAC2D05D;
	Mon, 29 Apr 2024 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385963; cv=none; b=HHk4eotp+Eacu3Qen6Gk1mADpc75iDJ/VPkB8AS8Lm7/+itJIeSfxpn0lrEhImGhNhe9p8Un00NyfGT07wK5Kp/Yh6lE2T3kYFzZhR0simCeQIwci5BoN8N9earY+tKu59Y1WZ5LfFQS5PGoDDzXUz6EJYYRkdBLYaccJXwQzto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385963; c=relaxed/simple;
	bh=0lJam32ziZv3gk67Vn+2YcQBQ6lvj00k2Dee7wWKZDc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=toYv6UgKbdhIzQl8kv8Q3T0/6gDOiZtqpex4pdYXprRuHiFM1yAfu78IF0wUtugvVbkWe3AoEkaB7J7QPjh5h5EiJRkcbElPjU3m2ttmcEFmrI9xg8iWChbLxAPlp2D70nOiYiU2NxNNlk2vOVN78BJNGmGQA5xZPXKPpbyp+L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=E9QEtbBK; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43TAHgPT021067;
	Mon, 29 Apr 2024 05:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714385862;
	bh=HImqf486OVZrYkpjd/mZixCJecu9xlenhuNKUlVhjPA=;
	h=From:To:CC:Subject:Date;
	b=E9QEtbBKTilDRP0zQKJscF0Gyv9sNqooGP+Ladis6biJRcD4glROsQzocmRaZwJ2g
	 xzrm5zDcyGYYcnYpO4yvIeY5J3NGgyQMUYIe5TtutoJueDvkPwKzh1vRZ6OUQxWdgw
	 L/FprQLhN8lUmOgheasw9ut1l3BlPVNqxutx5Vj0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43TAHgcJ056028
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 05:17:42 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 05:17:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 05:17:41 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43TAHfce103035;
	Mon, 29 Apr 2024 05:17:41 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <s-vadapalli@ti.com>, <danishanwar@ti.com>, <r-gunasekaran@ti.com>,
        <srk@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH v3 0/2] Add support for CPSW3G port 2 on AM62A7-SK
Date: Mon, 29 Apr 2024 15:47:37 +0530
Message-ID: <20240429101739.2770090-1-c-vankar@ti.com>
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

Hello,

This series adds support for CPSW3G MAC port 2 with the SK-Ethernet-DC01
Add-On daughtercard. Also, the missing alias for CPSW3G MAC Port 1 is
added to the am62a7-sk board file in order to allow kernel to fetch MAC
address populated by U-Boot for CPSW3G MAC Port 1.

This series is based on linux-next tagged next-20240429.

Link to v2:
https://lore.kernel.org/r/20240425102038.1995252-1-c-vankar@ti.com/

Changes from v2 to v3:
- Updated SPDX-License-Identifier and "pinctrl-0" property in "cpsw3g"
  node in "k3-am62a7-sk-ethernet-dc01.dtso" as suggested by Ravi.

Siddharth Vadapalli (2):
  arm64: dts: ti: k3-am62a7-sk: Add alias for CPSW3G MAC port 1
  arm64: dts: ti: k3-am62a7: Add overlay for second CPSW3G Port

 arch/arm64/boot/dts/ti/Makefile               |  3 +
 .../dts/ti/k3-am62a7-sk-ethernet-dc01.dtso    | 62 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       |  1 +
 3 files changed, 66 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7-sk-ethernet-dc01.dtso

-- 
2.34.1


