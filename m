Return-Path: <linux-kernel+bounces-144736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 301E88A49FE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC871F24461
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAB43BBC5;
	Mon, 15 Apr 2024 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="Bts71gga"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2127.outbound.protection.outlook.com [40.107.22.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CE2383B0;
	Mon, 15 Apr 2024 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168806; cv=fail; b=tkrKY1P8UStoRCLzNdXtQX7fA2vBTzKAZDZCkuQBOmnN+ct2PmL4ZnHkg+WXzFD6n4LirfcEbSjBiSwtFvcrbUEL/psmvLehvP7+RfVTTOQ4HJhpjqZio3etKqx2pyBOio4t2CbAZ9fM98l0t13r5l9DIZVVy3tHeNTGU2vqwFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168806; c=relaxed/simple;
	bh=Y2H6dOGBf2pkftSVAP8GOMZcx7D2R5boo/6ugyeLpFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dz5xVkb6+YEIcB7NOFTAwzm2yvDxa+gzMS1dwfKkmlXdCfYqIV8rmpvRqutqk9OgONLPKtBf2bLEMA60VBky6U53rSUPTUs6sF5KwoS7ZbGUQIXJs71neZ5TJTS56TiMJ0Vjiez6XemsK8c/Msn0ar+OFvXL25UfXJwpvveNfuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=Bts71gga; arc=fail smtp.client-ip=40.107.22.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ap4WWKjhP6Ub+Fh2CNMrxZeHaw9MDdnaiUfE5crQgh+YZHvKDdLRY8MCtRc9cv71GIDSBG0HywzBLcLo2Q1k+KuA4njzxeWwvEaEtwsKxrpy6X6XrqVcnfhaIeWx1gKmB4gizmrj6c+tF3FDD2JbrpV7SDXSl08/B1wSYcAs6BAe1uNddQZJGK3/DjFWDsVagCJH+QJC5UshQ6ugfUw4WDWMSWEzANNfChTY3+NDfAWKA8d/Q3RkpCX0I4QHuCQK3HpWbnndSSnQpVwVWzmltC6m9ElFGt7lEzgG+8t/kYBYT2KepLYXYC+lcRit1k34AX+HSjdIXQpX4clifOVfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PxWi/d1gN0YGmptaDaIN+rhdlEdWzrSX4jllpSdXX4=;
 b=TCUllCBtJm+ByfEmmugdscY9XswebzKPYzXTtV+TB49LV2YHEgXGX6RSbQjhnvqUeMUMvV055NZ42m1pwvi+OmEdRIfpjDxTM8b3tJqBsti8W5rbvwet9bNiq5h6FRxG8kl8VerwsBRQEsw3p/h3uWUjtId+kldkAfFiF4+dJg1dMKTKUiJUNoOZ5U0i9jIZtKbmuRqRb452AqAVhQyf3VnBJe6zZ3PgqIBJwpcnxWaaJlPw1Qj/3TNm6P2Sz6/N/ERu/ms+GGntmsf3K/iAdm3/drs4Tirfd0tKgC0EOnu6I1wxFirSB6YQ79lU7VDbfbc8nbL84AO2kcBuUbuQpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PxWi/d1gN0YGmptaDaIN+rhdlEdWzrSX4jllpSdXX4=;
 b=Bts71gga8vBm5rk2uBEkio0wLxS6GHzaTMeMlcl93XuoDjsGWKakZAgSmvDjyVb01B6w+l1pk5fGKsW9d1Xb/ogkOHoKPTTe8M2m/CJDTEmO2Z1Ck1R+T78xjaPXxbTiWNoF3D/EW+Ce1NDtqxeH2Q/K2Ht+p7C7raFj7tEyJ64dN0ttECS4CCuizlBiz+RKYYwjsD0Jyqy0sQAMyts4YpmZw7oqUMO/s3SWEPRSfWaTqH6pMm5LZBXrZfsDx7gCWBTkX32rdQFQnbpOWS1K1CueF+yZTrxc2+8CvAEE89mT0ohwpbvVloiRwJY+lb33iv/4TxKuCxdh8KnGiXcKHw==
Received: from AS9PR05CA0102.eurprd05.prod.outlook.com (2603:10a6:20b:498::27)
 by DB8PR04MB7049.eurprd04.prod.outlook.com (2603:10a6:10:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 08:13:20 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:20b:498:cafe::b9) by AS9PR05CA0102.outlook.office365.com
 (2603:10a6:20b:498::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 08:13:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 08:13:19 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.104) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 15 Apr 2024 08:13:18 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PAXPR04MB8288.eurprd04.prod.outlook.com (2603:10a6:102:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 08:13:12 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 08:13:12 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pm@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] power: supply: core: Add POWER_SUPPLY_TECHNOLOGY_CAPACITOR
Date: Mon, 15 Apr 2024 10:13:02 +0200
Message-ID: <20240415081305.316107-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415081305.316107-1-mike.looijmans@topic.nl>
References: <20240415081305.316107-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.0aecd676-868f-4018-bb2f-56c7fe7c18ff@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::19) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|PAXPR04MB8288:EE_|AMS1EPF0000004D:EE_|DB8PR04MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f5e1ad-f09b-4318-4867-08dc5d23e93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 e/9WCkdrxhl57fk/qgnQJyi/4RjgQR0IZQ34V+F6AWrvy/atyJ5ZGjAdlmsPihKuK7CzKcr+In3wGT7DWFHDtoZ2OW0+mtilFQ2zoSFonl0oSFBRgc/J3SLAzo0R8E2CqLAr6tHOA2oK1AMgUdMng8Fe8QQnek6X9YUekhDE6SrbVpoeuPaFJIxTCTYW2ecxF9tmzcdYGvW4HdA39VjwC5R8cLpqCb4vvwNvdI+0920GmvvSW1UNEHJoap3mfXjUrqHAub0vu3fkd2f/HO7vfqLIkdVvk8/CjaLzLnFKZoFq8mj5dSfeQiw/CSDgoEZex6FweO5fb2mtXvy1NiDjjY622a1viHCDTpMakM9alF4YRkG/iL4KN3MN7UgtyCWBb4QBsxJUL/E/l5DbJtxv2eIWy7yv6ht1ETv1pnyckIjemezgRWvdro6+0TiLL+iKJKyV49tJybM1fzbySPi3RaLSJ26QKttgkPsG0U38I/xWOF16jWRx9cWnO2QFCvtyIP8nd34Hp4AKYLscl1JGsSF2FBLggq5zEV9TkfRzYiXmzljXZQNlghxjX0ZE+JIIZr4pvbhKpQGcEqCgTIIWlmB8A9qAfmpb/tV2doSGyKvDYS+K9yVtf5ShMax5ss5L2iP8vlLEYmwL/7fH1s2XEaXkw99XGIfcWVlyynk6ruMkyZ7vtjBHmoF4/O3mocV6bCkkCNvu3Pn2F3Xa1Jc7vQSQkqzR//GNTyJesPEOVpY=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8288
X-CodeTwo-MessageID: 2614c8f6-768a-453d-b1a5-76a247684cf2.20240415081318@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f4cb233c-113a-4010-893c-08dc5d23e486
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kYqIk8YT/hAbztdy/Dukl9U9oEGUF7nbWXBE2LtqpT2xAX9qzHbuVJJ3oikFo69l0no2+CpmdqLrBKWcfp+RINssQWFPQeeMqB9VZXPvwyQgKG/7e2G1n/BZ+LtJCAGAb8mANlkGn9lBz8qPL8j9OaT0mtX8UhBO3CH7KFybF9C5Ml9MLdEmAbdthrX0H/XK0E0DxDXziJaLBGL3Rk8WjpVDaI40kVWTgIXsfJCxokSVYEXeVzC+nia48Pbq0j5Quuo6PBeRybYngtba/7h3OqUGxO6KutA3dV4vtf9UvQlQNd32XyWo40/MpKCOtLxVQM3HogFI2VMux/E7Z8JuowtJLotPTiKM0WXjKExd/1nLuDJ0euRpIzaqAebynsEcINfsfe9lDTfkMCAXkhvQ2XvzrCrTsgO536Ndy/5TJdM1iwRPJvyMPmeaUYrCh6P+rauCTeCTQd3jfZrdvVclyoQT5PhjEyi5hiQYvEn6aHQcQAtwZcE5uGGQk8CTSxeSkPUTtl4D97fn6REQfw1rvYFlvyDvvKGazCmnpGmTPzSdbjr6G8unVa7T2DVp9WTkxp/UIuzJZpuq4V/zYDshYYrOsIIJHwccm5oBwWqFNJixatU4w+NfeaJ1pPNtX9ZfU3ZOTEuyOqheyu3la+cVxoaGcJICqqOk6ydciO48CkaBvgb76IRT3qUYllx4GBQjncM7AKgw1lTOmeuQ7jW0DQ==
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 08:13:19.7201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f5e1ad-f09b-4318-4867-08dc5d23e93b
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7049

Another technology to store energy is a (super)capacitor.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

(no changes since v1)

 Documentation/ABI/testing/sysfs-class-power | 2 +-
 drivers/power/supply/power_supply_core.c    | 2 ++
 drivers/power/supply/power_supply_sysfs.c   | 1 +
 include/linux/power_supply.h                | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/AB=
I/testing/sysfs-class-power
index 7c81f0a25a48..1f6a04a17c81 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -488,7 +488,7 @@ Description:
=20
 		Valid values:
 			      "Unknown", "NiMH", "Li-ion", "Li-poly", "LiFe",
-			      "NiCd", "LiMn"
+			      "NiCd", "LiMn", "Capacitor"
=20
=20
 What:		/sys/class/power_supply/<supply_name>/voltage_avg,
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/suppl=
y/power_supply_core.c
index fefe938c9342..6d1327e16ff6 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -686,6 +686,8 @@ int power_supply_get_battery_info(struct power_supply *=
psy,
 			info->technology =3D POWER_SUPPLY_TECHNOLOGY_LiFe;
 		else if (!strcmp("lithium-ion-manganese-oxide", value))
 			info->technology =3D POWER_SUPPLY_TECHNOLOGY_LiMn;
+		else if (!strcmp("capacitor", value))
+			info->technology =3D POWER_SUPPLY_TECHNOLOGY_CAPACITOR;
 		else
 			dev_warn(&psy->dev, "%s unknown battery type\n", value);
 	}
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supp=
ly/power_supply_sysfs.c
index 0d2c3724d0bc..9d8540ce1f7e 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -119,6 +119,7 @@ static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[=
] =3D {
 	[POWER_SUPPLY_TECHNOLOGY_LiFe]		=3D "LiFe",
 	[POWER_SUPPLY_TECHNOLOGY_NiCd]		=3D "NiCd",
 	[POWER_SUPPLY_TECHNOLOGY_LiMn]		=3D "LiMn",
+	[POWER_SUPPLY_TECHNOLOGY_CAPACITOR]	=3D "Capacitor",
 };
=20
 static const char * const POWER_SUPPLY_CAPACITY_LEVEL_TEXT[] =3D {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 8e5705a56b85..af5a4e700881 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -78,6 +78,7 @@ enum {
 	POWER_SUPPLY_TECHNOLOGY_LiFe,
 	POWER_SUPPLY_TECHNOLOGY_NiCd,
 	POWER_SUPPLY_TECHNOLOGY_LiMn,
+	POWER_SUPPLY_TECHNOLOGY_CAPACITOR,
 };
=20
 enum {
--=20
2.34.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

