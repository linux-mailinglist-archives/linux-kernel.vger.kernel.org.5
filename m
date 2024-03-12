Return-Path: <linux-kernel+bounces-99864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5AB878E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4041C21F19
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6243FE46;
	Tue, 12 Mar 2024 06:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="vRVN7e2q"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011005.outbound.protection.outlook.com [52.101.128.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788042E41C;
	Tue, 12 Mar 2024 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224172; cv=fail; b=Y9yAmnJ4vzJXPpdgrg4ZbZHitU+CkJprdcIN5OtG4t4nSMVIMruogQmxWTy+FbdZbFx58E9h26s3dL1+DoWA0Us5/t7gVohZqikmAJL8ABu9naQ+iwYvPW8Qm1xuqZRgzF95iKF+bAd8OHWdZ0/nkCMTQADHLgUfaNdanpKsgd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224172; c=relaxed/simple;
	bh=C1sKk/8yEduVRzoUaqH6XRUvtSLCvjWT1dmeOhtCRxg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Z0PI9y5h7v4UZU085iEToc2alLPtOYhCJ/HTxV2qjbEKUuqhSHxKIW1qTYxzKlef4fqu4l3aocv7McfJJSJ5zSCMqxhQrYeJCEmc2gVEHgMXduoP4VTpvFi62uBTxmlTtNjEYMJYL4tQQdHrhKt/17i7PmaTb/MVA+vpEWUJLNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=vRVN7e2q; arc=fail smtp.client-ip=52.101.128.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgiBZRqoqfNlxgIqzeFkCtzXgyaMiWkueWq42ZHO12IMP1Llyliz894vnuyL6drnfYmG0AhkxURX3KLsDhDJb1tGUek/UkGPZXPQienvSHS4ntoTwyGvvOUEV+g1kmT0kbeW55ySghp4F6kBMPd0qy7nn2p90Hn5I35qevCEaxBMx46dklxWRW/dJ/uYMzrGyuglR1USj4UsKgTIKEnJiHA8ibMyzphhLnnE1MHavbvicSFxsK91e2GrDyBKekms+C3dCakZ5tZYTd1Sl+xnWv0AYpqbyR863ihoT+Bx+1HUYfyjnquf89c36ybw3HPUUAG4h9lV9+WxM0NEACKTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RkquM5/cO3Lq776cKhbTsIE8JytwM6TQi45HAbw8XI=;
 b=FAi45tAJW/NSyXftDSlj6DkTEJteqq1SRYVA1Wv5d/LrobO1GS9Lzh0S5B8cb3bqC7LwHuM7iHRraDd++qyjhlK3LGX5VsgQHcZi7JwwxZbtbmlqwwekfJ2SyZhGvjV3MGlSVX7RUGRwZ1Ek78WwBPKbTkAtXIJ4pAc+x8ZhzJxv4Fh9a9ly/zS55I8/Gkei8Jz/OLKf2FPyIKRIRD3l790fJA7jcY2ERUvtR9SrFORoDhePBPerUeF42V3Vg1fjTm1wQcbgwwJUjudgUSjXDYqZZgh0IKssXgZKMta4/6Tn52cT7Z/5i1UbMn6TQigfJY7BfdHj/dwGvZnWYRpwxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RkquM5/cO3Lq776cKhbTsIE8JytwM6TQi45HAbw8XI=;
 b=vRVN7e2qYmFipxIr4JQGLrbVYcl84Spjtuw8rudR7kzeGaRpe1w3UvydCsvZTV+L9+TOgtJQXYKZerQl5xs9oEYJu+r7hEA/gUCAiSkutALUeaD2zRbeURZ4+4+XjHexnahudiObzG42F0eR5l9uYPATxZKCeGPdpjhDzvzmHepPXPqReYHWZmlJSCc01C2wITO1rz9bsL8K9JB6tTPhPpwM0okUXSWeSHk9rk1wzsrTkUm1IilyDsrIy0I65omEvjNADmfG7y6OrU3R1zXO8NttqpxBcZsJ+d20SJ1W/E1de6Wftj0EI2MWulRInQw8a99KTKQ1wB5UidIWuND+KQ==
Received: from PS1PR03CA0024.apcprd03.prod.outlook.com (2603:1096:803:3d::36)
 by SEYPR04MB6750.apcprd04.prod.outlook.com (2603:1096:101:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Tue, 12 Mar
 2024 06:16:01 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:803:3d:cafe::85) by PS1PR03CA0024.outlook.office365.com
 (2603:1096:803:3d::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17 via Frontend
 Transport; Tue, 12 Mar 2024 06:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server id 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 06:15:59
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
Subject: [PATCH v6 00/22] Add i2c-mux and eeprom devices for Meta Yosemite 4
Date: Tue, 12 Mar 2024 14:15:32 +0800
Message-Id: <20240312061556.496605-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|SEYPR04MB6750:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0d1bd067-06e1-477e-94b8-08dc425be2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4B6kJSw3xwCrj/RPSrsJix1JeL2TObdDB29zLrOqY5saGnRqfw3k9DEa93GV/4f2PG1St5pQvYqnIwnu4THzxPuL8MNrDiEb9QznTKi7DbjqJ0DC5a+5FjnCIBLYg3eEB9b5VKsLGdQ8/xpvpsvygsHeHekM+JYI7vkWqtWGKvG/FiwctZfyZOH4YC+AWhuN8Lt70nh+8tgyxVd+h9rQAZCkLrMs8kKJXRTt1WMy/fiYTtFBaTPwdj+dnyPiXlIwNQaf/ft8HN4aRVtoLywffFFy5+dCZhfHQIsuPzkxrJZYoZZ2gWBJj3Ds7mHEh8juDNwAejodAPIn2cbnW8iowHPzJ3i+a6FUzC0He6vcylNoyqGHrEUxOgJ+gARZzf0DR1MVcCsPwaJEV/Scv7SavR/xqpqpO1v5RdPW3MqjXrvCRRZ8uLvz+qDyw1U94NZzHfWaPb6OI9VZdThgajRfXBQQ0k3srj2DRcmjRTnMu/u1QiYhQbVMpcJ9LaVGCcqlGAB05YtAJ78pAp+F+jCfNRbCsUm5SGMlJBxTcLgmp2BbFw6p+S7V4PJyYGdq6qSj6FZqKzG2OPaCSttXCsd1lUi3i4wZonhPJGy2s0tIMddDn4qjqZyAI9KHK/NZRPhJ6rSt3NVxmIxk/0T0enPGbMppfsdb2AjrbGng6zgyHaqYbKfo5kKPFsh32K3llaObC3kb3Ct3kHM9S9lN2D7P5zY17SJkcpdw/lZFf+mr3v2i9k28j02tDRS2nKqHWa2g
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(7416005)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 06:15:59.3537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1bd067-06e1-477e-94b8-08dc425be2e2
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6750

Changelog:
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


