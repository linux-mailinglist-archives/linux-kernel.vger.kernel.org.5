Return-Path: <linux-kernel+bounces-109564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6550F881ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F08BB217D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F855680;
	Thu, 21 Mar 2024 02:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="e57m5gcX"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2073.outbound.protection.outlook.com [40.107.215.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEA24A3D;
	Thu, 21 Mar 2024 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987165; cv=fail; b=ZIF6Np8QcwE+sWtuNLOI3nFHRByZtf+1Zn8QbofIu4BdiLeaK6ttpns+vD70LJUw0QWyAJuDeL4KlPXqz42FhoNSiVYVGueMxypetr5eRd5n/kOzbjbZ/lgh2snpzrJzpC6gmDgm5cPZmaAZbjFdtoZONTqGzvdwenZ4mjl+RwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987165; c=relaxed/simple;
	bh=PXOAsU+g9TUL7wSr5DXPHJCzYLjsZ/lPUrwLmTyhD4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OfOFIUs2vn/IVdVnDyJ4pBRsSENsNgvXcV015nhE3io05HYY9BMdqFONclfULIsiuFHOpURQyM6eC1KbwJyB44g5fcBG4IpM6XcAiIXQZnXnHiW2RzOzoNnt5D3orRE5PqqscpuX76065y6wEE7ImUDatAy0/8x7KsN+SAz4Ctw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=e57m5gcX; arc=fail smtp.client-ip=40.107.215.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUwTo3MUMNJ7ojnEf+vj5H6iQRSqwcdfJn6kOV6lQiRTfvSTzIjFueZCk9Mby76LtSHgCEU5YF9Yqita/wkBpqRdnRI1dCWoymcBYvNDIfAVBuwkghxzypQ98+n8lgjfxiZcNdoORcrR7gSKKrYiCZitayezh0sCEp7v471hKG/+CG7ui3tlKQd18DGb0vgGofPzDvWcbmYpd1aZjNo7F9FNVuRazJFrrPjNi6VscAfO81MpUErzQQE97gDa8GuPmSbBApO0fHBctwRWlrmtPnkO7qXnn08QLXmAmkEdWutyBR9p5NxriULuBQa3gnLwu7l0uSPmT7KQ31N/OifE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwllaVZrK3Z03jlhItgA6A0K4JF92EcjWplkQCYFA5w=;
 b=iPWOc+LfwFyGWSS7NGqfS/UnPHOhsGvGv7l6nd8T6INZTLLPjQglrs5TlmkNkv4EGMrTvMSDjOfdtnqWysbkXsD/DJOtkRW5/GeXoup8fIdRNS10lxLw5blEsRNUrOFXfngHDh6EIUrLV7wNk6dBq0AoL+HwyVz91GB7nwWS/g0xo+ktdhJ+3/HAz411c6qdvOTlEIROa/P6VO157dNWroAjx3g9WEjyMUh+141m0PDcl5qmohm1BVgcoBUISs/6A27JJ8pfqUdZRbAfHLZD9gwg7aHlvgrpBx2WquTEsJ9SpPuTUH6EtmylrGjP64URdPaa94L5BoJIY5/OtA0a3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwllaVZrK3Z03jlhItgA6A0K4JF92EcjWplkQCYFA5w=;
 b=e57m5gcXKLxjCGqnOX+unkyuZYFXrBT9sTeTeZrGl+LTS5uhMSOdsr7KQkASNEf+lE8tHUmQ3kSn7QWifKK3/gbfpVC6i5Ei09Y5IkF1W1d9zcvn3ZC8bvdp8B2QY+TJbWLohCjmJbTcVOb8b6J1wiZpVjA8SJrVvCfxGid+v+QKmYDYncsPdSJ/l50ArkfmctCXzMatqpmC9FQla0a7MIkA8bxSB5v4ivStojN//zColkhtSBIzfse0+IahzoktiVpu364Tjg4inOzjP69mbUkeQu3mbkKi59kubFO3Qy12Jr/Nhnd/ggHYQpWdSzaIOkuO+nDWs/tuZaoy7xddBw==
Received: from PU1PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::19) by TYZPR04MB7235.apcprd04.prod.outlook.com
 (2603:1096:400:45d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 02:12:39 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:803:15:cafe::e) by PU1PR01CA0007.outlook.office365.com
 (2603:1096:803:15::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Thu, 21 Mar 2024 02:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 02:12:37
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 00/22] Add i2c-mux and eeprom devices for Meta Yosemite 4
Date: Thu, 21 Mar 2024 10:12:12 +0800
Message-Id: <20240321021236.1823693-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|TYZPR04MB7235:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f79a2b0e-f197-44e7-235c-08dc494c6148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JhBEbcQc73lwS7erGUvts4E4N7lXtDb70tIe3Zz97xme4bT/+UNq8PkdcCCRspbnEkpinnkUQq7lG07NcihHmrfOrUFIWfiy2eDnBetIey9U9bNOyWgOYTQ9TuEcER7fLcvrAU4OHy1Hs6hyMRc9lHQ00kvJ3BX/PNNybH1HlCPV6SxI1F6LSk7qs5uExtkiI9jCuzI2kHY/wWbAQMPh3FpgqQnSWmmxmto85b7+5VKJlHI9wRKqPs+xkUSEUOB9SQQxjWjAkn9zIIE6VzvXMQlHVZrKXXvWwHaEydxuKb9p7+xZ0zL9Jk11pbcp//8UhsJ7JkRE4Pa/hhB5y+ryw7MiobKwDujGjwuBajYcTVBhhcmosdQmkT+ARX0PPTL1doyw5Sy7ynyS/HNbarw22JgjM5/Jv0WMav/obLwsiKAtUm5re2XO2OJK6EP6aJvwkqWwVtfUhsXXETigjzX0NlUyOubOoIfhO2LUWl3+uPs10W8ixqVP1Bm6MIkKyqc43tyOB1KQ8qt+eaQyDMlzDS5R99v6/nFe8PIDQBUMHCAlCtrCn4yJBLzZ7zPGfvrJxhOsbI79vpE785kT1nODyHIKTaHlDSumT8z9Gy6QgIUFo97jCjX9lM95nNkATVyanRK6WmUepbzS1zpIZcqKCFqhKEAT4aqqtfAFjTUWyJYSMXJUuBeG0ipdfVkwvHrStaiBiYf1nL2quuxZhVaAhxsgzaQRvB1Y+SrVa5Wq++EDO8ozuTU40A7AgbVvhnP/
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 02:12:37.6040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f79a2b0e-f197-44e7-235c-08dc494c6148
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7235

Changelog:
  - v7
    - Revise pca9506 i2c address
  - v6
    - Revise i2c duty-cycle for meeting 400khz spec
  - v5
    - Support medusa board adc sensors
    - support NIC eeprom
  - v4
    - Re-format gpio linename
    - Revise i2c device node names
    - Split patches by logic changes
  - v3
    - Correct patch for revising gpio name
  - v2
    - Revise mx31790 fan tach config
    - Add mctp config for NIC
    - Support mux to cpld
    - Revise gpio name
  - v1
    - Add gpio and eeprom behind i2c-mux
    - Remove redundant idle-state setting for i2c-mux
    - Enable adc 15, wdt2,spi gpio for yosemite4 use
    - Revise quad mode to dual mode to avoid WP pin influnece the SPI
    - Revise power sensor adm1281 for yosemite4 schematic change
    - Add gpio pca9506 I/O expander for yosemite4 use
    - remove space for adm1272 compatible
    - enable interrupt setting for pca9555
    - add eeprom for yosemite4 medusa board/BSM use
    - remove temperature sensor for yosemite4 schematic change
    - add power sensor for power module reading
    - Revise adc128d818 adc mode for yosemite4 schematic change
    - Revise ina233 for yosemite4 schematic change
    - Remove idle state setting for yosemite4 NIC connection
    - Initialize bmc gpio state
    - Revise mx31790 fan tach config
    - Add mctp config for NIC
    - Support mux to cpld
    - Revise gpio name

Delphine CC Chiu (22):
  ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
  ARM: dts: aspeed: yosemite4: Enable adc15
  ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
  ARM: dts: aspeed: yosemite4: Enable watchdog2
  ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
  ARM: dts: aspeed: yosemite4: Revise power sensor adm1281 for schematic
    change
  ARM: dts: aspeed: yosemite4: Add gpio pca9506
  ARM: dts: aspeed: yosemite4: Remove space for adm1272 compatible
  ARM: dts: aspeed: yosemite4: Enable interrupt setting for pca9555
  ARM: dts: aspeed: yosemite4: Add power sensor for power module reading
  ARM: dts: aspeed: yosemite4: Add eeprom for yosemite4 use
  ARM: dts: aspeed: yosemite4: Remove temperature sensor for yosemite4
    schematic change
  ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode for yosemite4
    schematic change
  ARM: dts: aspeed: yosemite4: Revise ina233 config for yosemite4
    schematic change
  ARM: dts: aspeed: yosemite4: Remove idle state setting for yosemite4
    NIC connection
  ARM: dts: aspeed: yosemite4: Initialize bmc gpio state
  ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
  ARM: dts: aspeed: yosemite4: add mctp config for NIC
  ARM: dts: aspeed: yosemite4: support mux to cpld
  ARM: dts: aspeed: yosemite4: support medusa board adc sensors
  ARM: dts: aspeed: yosemite4: support NIC eeprom
  ARM: dts: aspeed: yosemite4: Revise i2c duty-cycle

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 1258 +++++++++++++++--
 1 file changed, 1151 insertions(+), 107 deletions(-)

-- 
2.25.1


