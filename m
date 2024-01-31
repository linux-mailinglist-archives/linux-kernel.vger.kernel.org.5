Return-Path: <linux-kernel+bounces-46016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BBE843943
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98EE1C21BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D535DF35;
	Wed, 31 Jan 2024 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="mXqtTjjF"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2045.outbound.protection.outlook.com [40.107.255.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417145A0E4;
	Wed, 31 Jan 2024 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690505; cv=fail; b=VUfERreqLNFeC1RQitYzMuj/xJXICtbLkhuAfqrVBAGJmIeJzxcfZy/eTpm7I55uDDlngiV+o0MCE4mX7igykqOUSK7R0mphMRP0NzUcdUZM+mDQdk0bhCXZd294+zQo4oSsnSK3UZuPMdHPb7lM6OsTDJVYxPOp90GbQLRnv7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690505; c=relaxed/simple;
	bh=ZB0uuKhuGlwhDRABa0fnEYzauI2z6mkdht1GyBc8b/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=I5pHmBqxlC9Qn5i2mXyfAjfT8/4pvZZId4b+J4rRzP0o6VKoC+uamE22NBVomL59SIz0vR9KD9j/0Gis8wnJo/xpAc434T5Q6lsSLlHP7rY1UIry5CwoXpKuRvaNafrN4aUupsLTST3lkfRH6touwAqch2V2gfieCzgCZ0mN3gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=mXqtTjjF; arc=fail smtp.client-ip=40.107.255.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZD/mJqXdnlPvY31raih7TWrPZxFXQAnnyRRcrxn86ShSaisu7JqD+L65jt4JsmtOJSYb5wbRWVg/QpDw421WCmNx2WPdUqFFPOkDp6UWnN8BqjlxCNfhqSuzS/0/wI+1dDOK3oiOpiq5z2ING8inDKC5vipBTmMjH4jSn8kxP0jdGQgeUUA147B9GTovB26QlKyHtV4kxGF63G8WDCkJ0K4/dCWyzzWy73JwUxJyCiMV1hRwuUIwwHyPOPRW7Yp4CBzlAQLmuyAvHgzjX0Fze++9XUxk18CbDsKriRUFW1j9/86DiGJ1EECafJP5p0EYlEF1kT/m1xGTjOxtg20xpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4g56/60hyAX5ggdjqNQXbU+iIP856fiKJRFbrdd3P4=;
 b=GVkyezF0LF/3Ej5vLv598qAOPYYhvTN8k6+aLYKHYuMgAPhQS5ERelf7w6seLatomYa0mYnRJofHsWE6ElKppGr6BBIc+l8+Pdwhjt/mDtjytPjQ3iOM3YX+AhCuAwtutZkF3D+YqwevpCwD+jOg0RJdBprbt3rtYwozhI2kA8Q9DISr9lVLW/5R/iJF/wzImF6mc7WtGXfFMqlBKjtc723z1W2oG7AZ2+7AjTdS3UB1+oDPeRnB+8KJFmGrZVpXzyGEhuACJ0SEvNHgd95vY03wjxSdLX/rV0bGzipchbei9dwujgG4LvYmGrtnGhtKoz05rmW6Q+2oSxA37LyaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4g56/60hyAX5ggdjqNQXbU+iIP856fiKJRFbrdd3P4=;
 b=mXqtTjjFlBpqx+94sqqssx4pgYRQPe1AeceFxR4fODAHVqw5ArMyoj/Ar9y8YOScy2BgBvr0ecqyEKOskcE2cpIM3uDIxt+C4aNIg4mgW6iJUS704onkRBs0frnpDAPXyr9y+WJGp46q5yWKdCfh7Xa59BtkySOibnqsZnpvziMZc9z3DRcUBuSWsOGSQV3M6Pvvi3AvkOpMeacSC+kSGKBZdmvfaTAvTZniRziAj9G/kceoeToWkTQxK3uw96I94+5de1cAXDRFYboGfSARdP9KsOxNlgJOLGhwqs5PIPusdN2YTE2BtGMZHcZh5cQbNl38/B2naViCVQ8uXjtvtA==
Received: from SG2P153CA0032.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::19) by
 TYZPR04MB7783.apcprd04.prod.outlook.com (2603:1096:405:76::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Wed, 31 Jan 2024 08:41:39 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::39) by SG2P153CA0032.outlook.office365.com
 (2603:1096:4:c7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.6 via Frontend
 Transport; Wed, 31 Jan 2024 08:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:41:37
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
Subject: [PATCH v5 00/21] Add i2c-mux and eeprom devices for Meta Yosemite 4
Date: Wed, 31 Jan 2024 16:41:11 +0800
Message-Id: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|TYZPR04MB7783:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dc1575c9-f2c4-4f7f-e5b4-08dc223870ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+TlP5J3HL+I/NsOp+TwfSMGiM2t9qcBpxMVxGq0+ImNaSKd9NBOS8JIrB2QvQz2DzaasUQ6oUj0R7pZAp+sGlyNOjCWqNebF8YTRSlW5bra7/7y/4UIfwk6GhOHpme6XS0ypBQMKWnk+j4P2yKeNENAELL4+JwYZj4FVWuTZYbGgp8RgmfGcTD1X66AHKQJjgXfF1R72yEbG5cA49XOV2DgmCGM4ZSMRxSTiz1RAsL4Eu2B5YbReX9v1wA+loIspa8a4VyXQw7tGteHjR2mgPmQWX1+IiALx5SvzLTDkbEKXXiXzrJdejvQUzvLAUKJSb4EXQfShKJnysQRZl4B4YqqLX6oMXDFO3ZGCkvR5BgEhjHGjASowAMxrbEIwlbMiYixlo3NDfGrj5JL4hWI3dpKXfsQyMf51cwINPEoY2f9W3ZS6FtqBf6mUvxf0Ts92bGIHgnsC8AqJon1y3ZvFxswXA6otZz6/baDfW2BFKg/Nr1MBMvAeBjRxJHNQuHbJyytC+qcTZoSfgpiGSi3udaCztbq/eltnB947t1oS4rrTFubFsnFvqAg3+LW0dP8paXpegXSixUZshoXKGMy4b9aw0FIejs+aQpMf9Yg3Njp+v6x3JW8otl9alWpdqSrdKMzmI5sMZZeqTCavh766Yrs8MesVTp9aCrPrvNaIsqGK4/Z8Sb2ytPaSGXRBwKWaJSa+Rkw4y6t9Jrla+UJahg==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(136003)(376002)(396003)(346002)(39850400004)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(46966006)(36840700001)(1076003)(9316004)(70586007)(8936002)(8676002)(4326008)(7416002)(5660300002)(2906002)(86362001)(36736006)(54906003)(6506007)(6916009)(36860700001)(6512007)(47076005)(82740400003)(70206006)(81166007)(36756003)(478600001)(6666004)(316002)(356005)(6486002)(83380400001)(336012)(2616005)(956004)(26005)(41300700001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:41:37.6760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1575c9-f2c4-4f7f-e5b4-08dc223870ec
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7783

Changelog:
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

Delphine CC Chiu (21):
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

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 1221 +++++++++++++++--
 1 file changed, 1110 insertions(+), 111 deletions(-)

-- 
2.25.1


