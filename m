Return-Path: <linux-kernel+bounces-144740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B292A8A4A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68311C2201E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F17B446DE;
	Mon, 15 Apr 2024 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="NlxsgKde"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2117.outbound.protection.outlook.com [40.107.22.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0BD3BBDC;
	Mon, 15 Apr 2024 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168811; cv=fail; b=WQQGDd5b5Vz8KPacYO36n+3x/Nje3LL1gU5G5Lo8wh+uVvAaUXzdav15VYsF57wNrOfGQikO5IbJJlYz435mzLSPGMNRgChBfF92leS2mv2Xt4yWKpFKvRie+2xx+aa2Kq7ql5C0qK1rdG1pWxTW5Vlaj2avsYylbCfyLIi7K/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168811; c=relaxed/simple;
	bh=d2yl41KEXxg8kahHMOor9fOH9kQ09CdKq+C/fvMe0t0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ffjB673jgxcn+DX2nHqv0VboMIo1nuTHnoYE/h3m+uJEEPoRI//3sB/oy4fl9WfJ5V/a9Iv6MoQg1n5IfhFNHsnnYxwUcf+GBimjNfOXewZZxYdXuZlp08AZ0VE4Y5toI9aSSnNRZ3zX4ul/AZj7VpaeKeM7QwnMZ95LdVwADmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=NlxsgKde; arc=fail smtp.client-ip=40.107.22.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBSUxmXcB/Bn98geW97N70SeqbXtJqrySPA5ncOV4dDjxhawGZLG6470oSjssxrCjg+6VFlRK/mOgREiqAjyALf4tQBMYbeSal+pRKyeTHsrFK+ytpznRckIg0hVRN3oTMBq4wVQgJUHZqtynruY49o82AS98eF7UOdW4C0Dj+MSGAzFt/60HmNk0s3QsS6I9scX3nMok16i97dohjpunfSSAg7GsqxdBlcic1Lio8Ibm0Kiwhw8giOiBQQuBWVimBSKd+aKoQ6NM9S7hFFsRpI3mgsYv2eAZzx9kc+QNw49KZ9wiG+qm4End0QRF3UJz41HzcfieZBFzesVQD6TFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQP7/z2sq2I11vIJH9OMinTMt1phtF+PGKjb3wp3gy0=;
 b=PDAkLwkAhDyz7azlz7QYp/iLkg3lF5d9QZH+NGMEX5bDq7G3Bum8gSUelw5owKPl1EAUWxryo1Gy17JtujY+XUOUFMjiWIHZv2P4CGjVWP3O7q9CPa6GlB0HxUApVD486Z3m8xTznFfXqh5bpVdDacpSU9ZDtVVH7fuRwFMpshqHDN46by8QLcxYKO/36zDReA3FrGgLw4hDA5BSvbQoOMSiM/OZZsTIHJyW3DdXjzbPFfawrEYcoCxZb7rkUCfLQNo38ubgmmozXdTdzT7VrTUuyBLwQlOxCKILTfsdd9yX1hK4UlK8NxcUbV3lb+vXT3+XZ9GhlvoO7Haekk41bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQP7/z2sq2I11vIJH9OMinTMt1phtF+PGKjb3wp3gy0=;
 b=NlxsgKdexaoaKbwoknqiR9p8eFV2Zdm/1CBGC630pRoq87DqE3KUBJLywRIO72VuxKHEN0r1w1WPnlrE2tLA4G4ufIrt5MkQaTh8aQ4PePLkZHYjvM9NvD1znXsA2pFio7n7GWWxnNfAuNbXtmUE5p85YPxxvEgouPfRE+yudUOXdy80LZkWkI4jOB8yXLdIcyH2joRhiIMFxZRuFr4o9m7pUwS+qB2hu7BoK2BsuyR0cjgznsYiBNkBqjluIcfiM0lGV6orwKJtXtG+1PN4jFXaY/lUsVfCCkd6zoE6XG8C2D70t9iiyPsqLANX4wqovF9wbvGEqjDKS3/gFZWguA==
Received: from AS9PR06CA0508.eurprd06.prod.outlook.com (2603:10a6:20b:49b::32)
 by VI0PR04MB10229.eurprd04.prod.outlook.com (2603:10a6:800:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 15 Apr
 2024 08:13:23 +0000
Received: from AMS0EPF000001AE.eurprd05.prod.outlook.com
 (2603:10a6:20b:49b:cafe::a4) by AS9PR06CA0508.outlook.office365.com
 (2603:10a6:20b:49b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 08:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 AMS0EPF000001AE.mail.protection.outlook.com (10.167.16.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 08:13:21 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.105) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 15 Apr 2024 08:13:19 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PAXPR04MB8288.eurprd04.prod.outlook.com (2603:10a6:102:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 08:13:13 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 08:13:13 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pm@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] power: supply: ltc3350-charger: Add driver
Date: Mon, 15 Apr 2024 10:13:05 +0200
Message-ID: <20240415081305.316107-5-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415081305.316107-1-mike.looijmans@topic.nl>
References: <20240415081305.316107-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.f3ad88bc-748d-4d1b-abcf-bcf420d05ddf@emailsignatures365.codetwo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	AS8PR04MB8644:EE_|PAXPR04MB8288:EE_|AMS0EPF000001AE:EE_|VI0PR04MB10229:EE_
X-MS-Office365-Filtering-Correlation-Id: d883ad8d-83d1-4743-ce6a-08dc5d23ea5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 cfy1Hb2l7VXbF7otbwtWPYlSllY2Hw0qEYGwMd3hlRNhK0r2MeRifn6xj7g0bhrmtQtTfUIYXdv9C2KQnvyYPgfTfjRUtFghTL5GasWZrktX3HBA1TD+QzoJRMzSF/tnKDHHmfU9NUj222uyF/ORkskdS11BvfV7VucktpW8xchDymHnVeN62tt4I0Ndo03TsllhBmvoQxUNy3zcMoT5IxbARHGcbaEKOfYuQk9W/Zs2qQLDrs9uUO7R8B5X7QSwqrxf8tMQ633k9yeNHEVkRDYkHxj6ByM2HVoy/htdegaTL5UcwQe0628pM6/hPhmFEB6fUv4R09yxsxWMXzkW2N3eBZq8sop86Ke94aWgiVmss4qs9LH6tRpI+hA4FN/bw3dK3Ybfneut9JmQFwyI44osK2YH2xaSgVzqXS2sOqpK7GVt6nxdONkrNqH8U7iLqPvt+kidH/eCrbqh0BKHw2K2XUCZv2MXDpTnCUDu28/HibmyklRFZjFWN49insdVnXzpQGZSlYjYdUhq9IkMXYQYYEqmvSz9Sn7/XkshLXJq9rGqxZT9/lP+3enkpopHMQIZVRPYBoKt+hWF6RR7YntkvJsSLRwXs2oUWkTyKhTIrqIOIaefZASktA6GtKO5Ji5BpMr7bZHDpp/8r4Jh/Zoje7hfusvPAf16SGqwu6OmUg8Ym5X3uBHNpNj2A2l94zwBuMKAwcjxSPtF7jqWkCYNWrM+3hNLN0RdaP963oo=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8288
X-CodeTwo-MessageID: 3f1c8b01-bd31-45bb-9279-67df71677a9e.20240415081319@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4ecab4ad-5871-4700-d900-08dc5d23e57d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G+qgbEuEacakkKkRzAYnnnjmuvORErHZYBp9KIpjTwyUhRoSogTv7nFNBhV3EeAur8G41A+q52LpEBwCWkJc3Gj77vgogaOo4x5k5CeiJj6eScWl9NugEepQqewt2agUe8YAesaue8PFz0PLc/xREIWTbUs2DahhzgeNfHbZHlMjOwiKJdFjb1gE890UBBHtwS2HbzWW05V3G9TUSL6IkveUTYGA0wR4Gq2TjNAMRTWQcRtCaiHKhAVe8koEXmoMnDVDk6udXA4FPXwRn0uKmdRIVDEfpCvB1/Ia68g0q4nZY6JRB5pIGhUfii82tOdNpBqYOzb/D7CFANrIbKcSI+X5oTFW0BLhcMu7YRBY1igjk9uH0I05uJSvvgBGVUmFR66mg2VVCFSbJ7L7IvBgrltaBJjBQWPbUPQN9sl/gu4OuIFV13nER85r5s1rSqkwHINPOLiGubajOyJa+8JncJ+4icLttqdMPel8GnfCGX0bXUq2xr9FyT6faBFQtG0dbP+BG+QkCY5nIOUcmvHemQQ546Erz8jXRcEdqOJK9jf/Dg9UeLo4R1OGWfDoLltec53R/p4964ycoguim6MAWjYgpBiv2lsQpFNDf2QWR1Rqx/qnN0aSA4jN6Bdve8V4PimIJAuIZl2/PTw235JIea6QqRP8r3yPr/0CMoCSHhmOluXSl6FIyMoNT7ybR0YbkFptHtVHMtB12MhL+LcdjQ==
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 08:13:21.6528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d883ad8d-83d1-4743-ce6a-08dc5d23ea5f
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10229

The LTC3350 is a backup power controller that can charge and monitor
a series stack of one to four supercapacitors.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

Changes in v4:
Split into "charger" and "capacitor" parts
Use (new) standard properties
Header include fixups
Explain local "scale" units
Drop i2c_check_functionality
Use dev_err_probe
Use dev_fwnode
Drop of_match_ptr

Changes in v2:
Duplicate "vin_ov" and "vin_uv" attributes

# bash /tmp/tools/testing/selftests/power_supply/test_power_supply_properti=
es.sh
TAP version 13
1..66
# Testing device ltc3350
ok 1 ltc3350.exists
ok 2 ltc3350.uevent.NAME
ok 3 ltc3350.sysfs.type
ok 4 ltc3350.uevent.TYPE
ok 5 ltc3350.sysfs.usb_type # SKIP
# Reported: '1' ()
ok 6 ltc3350.sysfs.online
ok 7 ltc3350.sysfs.present # SKIP
# Reported: 'Full'
ok 8 ltc3350.sysfs.status
ok 9 ltc3350.sysfs.capacity # SKIP
ok 10 ltc3350.sysfs.capacity_level # SKIP
ok 11 ltc3350.sysfs.model_name # SKIP
ok 12 ltc3350.sysfs.manufacturer # SKIP
ok 13 ltc3350.sysfs.serial_number # SKIP
ok 14 ltc3350.sysfs.technology # SKIP
ok 15 ltc3350.sysfs.cycle_count # SKIP
ok 16 ltc3350.sysfs.scope # SKIP
# Reported: '3200000' uA (3200 mA)
ok 17 ltc3350.sysfs.input_current_limit
ok 18 ltc3350.sysfs.input_voltage_limit # SKIP
# Reported: '23742030' uV (23.742 V)
ok 19 ltc3350.sysfs.voltage_now
ok 20 ltc3350.sysfs.voltage_min # SKIP
ok 21 ltc3350.sysfs.voltage_max # SKIP
ok 22 ltc3350.sysfs.voltage_min_design # SKIP
ok 23 ltc3350.sysfs.voltage_max_design # SKIP
# Reported: '467900' uA (467.9 mA)
ok 24 ltc3350.sysfs.current_now
ok 25 ltc3350.sysfs.current_max # SKIP
ok 26 ltc3350.sysfs.charge_now # SKIP
ok 27 ltc3350.sysfs.charge_full # SKIP
ok 28 ltc3350.sysfs.charge_full_design # SKIP
ok 29 ltc3350.sysfs.power_now # SKIP
ok 30 ltc3350.sysfs.energy_now # SKIP
ok 31 ltc3350.sysfs.energy_full # SKIP
ok 32 ltc3350.sysfs.energy_full_design # SKIP
ok 33 ltc3350.sysfs.energy_full_design # SKIP
# Testing device ltc3350_capacitor
ok 34 ltc3350_capacitor.exists
ok 35 ltc3350_capacitor.uevent.NAME
ok 36 ltc3350_capacitor.sysfs.type
ok 37 ltc3350_capacitor.uevent.TYPE
ok 38 ltc3350_capacitor.sysfs.usb_type # SKIP
ok 39 ltc3350_capacitor.sysfs.online # SKIP
ok 40 ltc3350_capacitor.sysfs.present # SKIP
# Reported: 'Full'
ok 41 ltc3350_capacitor.sysfs.status
ok 42 ltc3350_capacitor.sysfs.capacity # SKIP
ok 43 ltc3350_capacitor.sysfs.capacity_level # SKIP
ok 44 ltc3350_capacitor.sysfs.model_name # SKIP
ok 45 ltc3350_capacitor.sysfs.manufacturer # SKIP
ok 46 ltc3350_capacitor.sysfs.serial_number # SKIP
ok 47 ltc3350_capacitor.sysfs.technology # SKIP
ok 48 ltc3350_capacitor.sysfs.cycle_count # SKIP
ok 49 ltc3350_capacitor.sysfs.scope # SKIP
ok 50 ltc3350_capacitor.sysfs.input_current_limit # SKIP
ok 51 ltc3350_capacitor.sysfs.input_voltage_limit # SKIP
# Reported: '5053824' uV (5.05382 V)
ok 52 ltc3350_capacitor.sysfs.voltage_now
# Reported: '4299588' uV (4.29959 V)
ok 53 ltc3350_capacitor.sysfs.voltage_min
# Reported: '4680396' uV (4.6804 V)
ok 54 ltc3350_capacitor.sysfs.voltage_max
ok 55 ltc3350_capacitor.sysfs.voltage_min_design # SKIP
ok 56 ltc3350_capacitor.sysfs.voltage_max_design # SKIP
ok 57 ltc3350_capacitor.sysfs.current_now # SKIP
ok 58 ltc3350_capacitor.sysfs.current_max # SKIP
ok 59 ltc3350_capacitor.sysfs.charge_now # SKIP
ok 60 ltc3350_capacitor.sysfs.charge_full # SKIP
ok 61 ltc3350_capacitor.sysfs.charge_full_design # SKIP
ok 62 ltc3350_capacitor.sysfs.power_now # SKIP
ok 63 ltc3350_capacitor.sysfs.energy_now # SKIP
ok 64 ltc3350_capacitor.sysfs.energy_full # SKIP
ok 65 ltc3350_capacitor.sysfs.energy_full_design # SKIP
ok 66 ltc3350_capacitor.sysfs.energy_full_design # SKIP
# Totals: pass:17 fail:0 xfail:0 xpass:0 skip:49 error:0


 .../ABI/testing/sysfs-class-power-ltc3350     |  88 ++
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/ltc3350-charger.c        | 786 ++++++++++++++++++
 4 files changed, 885 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-ltc3350
 create mode 100644 drivers/power/supply/ltc3350-charger.c

diff --git a/Documentation/ABI/testing/sysfs-class-power-ltc3350 b/Document=
ation/ABI/testing/sysfs-class-power-ltc3350
new file mode 100644
index 000000000000..d4a2bb0fb62b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-ltc3350
@@ -0,0 +1,88 @@
+What:		/sys/class/power_supply/ltc3350/charge_status
+Date:		April 2024
+KernelVersion:	6.9
+Description:
+		Detailed charge status information as reported by the chip. This
+		returns the raw register value in hex.
+
+		Access: Read
+
+What:		/sys/class/power_supply/ltc3350/vshunt
+Date:		April 2024
+KernelVersion:	6.9
+Description:
+		Voltage for "shunting" the capacitors in the stack. When the
+		capacitor voltage is above this value, the chip will discharge
+		the excess voltage using a shunt resistor.
+		This is typically used to limit the voltage on a single cell,
+		to compensate for imbalance and prevent damaging the capacitor
+		while charging. It can also be used to forcibly discharge the
+		capacitors.
+
+		Access: Read, Write
+
+		Valid values: In microvolts, defaults to 2.7V
+
+What:		/sys/class/power_supply/ltc3350/gpi
+Date:		April 2024
+KernelVersion:	6.9
+Description:
+		General purpose input voltage. Returns a single measurement.
+
+		Access: Read
+
+		Valid values: In microvolts
+
+What:		/sys/class/power_supply/ltc3350/gpi_ov
+Date:		April 2024
+KernelVersion:	6.9
+Description:
+		General purpose input voltage overvoltage level. Triggers an
+		alert for userspace when the voltage goes above this value.
+
+		Access: Read, Write
+
+		Valid values: In microvolts
+
+What:		/sys/class/power_supply/ltc3350/gpi_uv
+Date:		April 2024
+KernelVersion:	6.9
+Description:
+		General purpose input voltage undervoltage level. Triggers an
+		alert for userspace when the voltage drops below this value.
+
+		Access: Read, Write
+
+		Valid values: In microvolts
+
+What:		/sys/class/power_supply/ltc3350/vin
+Date:		April 2024
+KernelVersion:	6.9
+Description:
+		Charger input voltage. Returns a single measurement.
+
+		Access: Read
+
+		Valid values: In microvolts
+
+What:		/sys/class/power_supply/ltc3350/vin_ov
+Date:		April 2024
+KernelVersion:	6.9
+Description:
+		Input voltage overvoltage level. Triggers an alert for userspace
+		when the voltage goes above this value.
+
+		Access: Read, Write
+
+		Valid values: In microvolts
+
+What:		/sys/class/power_supply/ltc3350/vin_uv
+Date:		April 2024
+KernelVersion:	6.9
+Description:
+		Input voltage undervoltage level. Triggers an alert for
+		userspace when the voltage drops below this value.
+
+		Access: Read, Write
+
+		Valid values: In microvolts
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 3e31375491d5..7cb1a66e522d 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -514,6 +514,16 @@ config CHARGER_LT3651
 	  Say Y to include support for the Analog Devices (Linear Technology)
 	  LT3651 battery charger which reports its status via GPIO lines.
=20
+config CHARGER_LTC3350
+	tristate "LTC3350 Supercapacitor Backup Controller and System Monitor"
+	depends on I2C
+	select REGMAP_I2C
+	select I2C_SMBUS
+	help
+	  Say Y to include support for the Analog Devices (Linear Technology)
+	  LTC3350 Supercapacitor Backup Controller and System Monitor connected
+	  to I2C.
+
 config CHARGER_LTC4162L
 	tristate "LTC4162-L charger"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 58b567278034..a8d618e4ac91 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_CHARGER_LP8788)	+=3D lp8788-charger.o
 obj-$(CONFIG_CHARGER_GPIO)	+=3D gpio-charger.o
 obj-$(CONFIG_CHARGER_MANAGER)	+=3D charger-manager.o
 obj-$(CONFIG_CHARGER_LT3651)	+=3D lt3651-charger.o
+obj-$(CONFIG_CHARGER_LTC3350)	+=3D ltc3350-charger.o
 obj-$(CONFIG_CHARGER_LTC4162L)	+=3D ltc4162-l-charger.o
 obj-$(CONFIG_CHARGER_MAX14577)	+=3D max14577_charger.o
 obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+=3D max14656_charger_detector.o
diff --git a/drivers/power/supply/ltc3350-charger.c b/drivers/power/supply/=
ltc3350-charger.c
new file mode 100644
index 000000000000..6e0e238766ca
--- /dev/null
+++ b/drivers/power/supply/ltc3350-charger.c
@@ -0,0 +1,786 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Analog Devices (Linear Technology) LTC3350
+ * High Current Supercapacitor Backup Controller and System Monitor
+ * Copyright (C) 2024, Topic Embedded Products
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pm_runtime.h>
+#include <linux/power_supply.h>
+#include <linux/property.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+/* Registers (names based on what datasheet uses) */
+#define LTC3350_REG_CLR_ALARMS		0x00
+#define LTC3350_REG_MSK_ALARMS		0x01
+#define LTC3350_REG_MSK_MON_STATUS	0x02
+#define LTC3350_REG_CAP_ESR_PER		0x04
+#define LTC3350_REG_VCAPFB_DAC		0x05
+#define LTC3350_REG_VSHUNT		0x06
+#define LTC3350_REG_CAP_UV_LVL		0x07
+#define LTC3350_REG_CAP_OV_LVL		0x08
+#define LTC3350_REG_GPI_UV_LVL		0x09
+#define LTC3350_REG_GPI_OV_LVL		0x0A
+#define LTC3350_REG_VIN_UV_LVL		0x0B
+#define LTC3350_REG_VIN_OV_LVL		0x0C
+#define LTC3350_REG_VCAP_UV_LVL		0x0D
+#define LTC3350_REG_VCAP_OV_LVL		0x0E
+#define LTC3350_REG_VOUT_UV_LVL		0x0F
+#define LTC3350_REG_VOUT_OV_LVL		0x10
+#define LTC3350_REG_IIN_OC_LVL		0x11
+#define LTC3350_REG_ICHG_UC_LVL		0x12
+#define LTC3350_REG_DTEMP_COLD_LVL	0x13
+#define LTC3350_REG_DTEMP_HOT_LVL	0x14
+#define LTC3350_REG_ESR_HI_LVL		0x15
+#define LTC3350_REG_CAP_LO_LVL		0x16
+#define LTC3350_REG_CTL_REG		0x17
+#define LTC3350_REG_NUM_CAPS		0x1A
+#define LTC3350_REG_CHRG_STATUS		0x1B
+#define LTC3350_REG_MON_STATUS		0x1C
+#define LTC3350_REG_ALARM_REG		0x1D
+#define LTC3350_REG_MEAS_CAP		0x1E
+#define LTC3350_REG_MEAS_ESR		0x1F
+#define LTC3350_REG_MEAS_VCAP1		0x20
+#define LTC3350_REG_MEAS_VCAP2		0x21
+#define LTC3350_REG_MEAS_VCAP3		0x22
+#define LTC3350_REG_MEAS_VCAP4		0x23
+#define LTC3350_REG_MEAS_GPI		0x24
+#define LTC3350_REG_MEAS_VIN		0x25
+#define LTC3350_REG_MEAS_VCAP		0x26
+#define LTC3350_REG_MEAS_VOUT		0x27
+#define LTC3350_REG_MEAS_IIN		0x28
+#define LTC3350_REG_MEAS_ICHG		0x29
+#define LTC3350_REG_MEAS_DTEMP		0x2A
+
+/* LTC3350_REG_CLR_ALARMS, LTC3350_REG_MASK_ALARMS, LTC3350_REG_ALARM_REG =
*/
+#define LTC3350_MSK_CAP_UV	BIT(0)	/* capacitor undervoltage alarm */
+#define LTC3350_MSK_CAP_OV	BIT(1)	/* capacitor overvoltage alarm */
+#define LTC3350_MSK_GPI_UV	BIT(2)	/* GPI undervoltage alarm */
+#define LTC3350_MSK_GPI_OV	BIT(3)	/* GPI overvoltage alarm */
+#define LTC3350_MSK_VIN_UV	BIT(4)	/* VIN undervoltage alarm */
+#define LTC3350_MSK_VIN_OV	BIT(5)	/* VIN overvoltage alarm */
+#define LTC3350_MSK_VCAP_UV	BIT(6)	/* VCAP undervoltage alarm */
+#define LTC3350_MSK_VCAP_OV	BIT(7)	/* VCAP overvoltage alarm */
+#define LTC3350_MSK_VOUT_UV	BIT(8)	/* VOUT undervoltage alarm */
+#define LTC3350_MSK_VOUT_OV	BIT(9)	/* VOUT overvoltage alarm */
+#define LTC3350_MSK_IIN_OC	BIT(10)	/* input overcurrent alarm */
+#define LTC3350_MSK_ICHG_UC	BIT(11)	/* charge undercurrent alarm */
+#define LTC3350_MSK_DTEMP_COLD	BIT(12)	/* die temperature cold alarm */
+#define LTC3350_MSK_DTEMP_HOT	BIT(13)	/* die temperature hot alarm */
+#define LTC3350_MSK_ESR_HI	BIT(14)	/* ESR high alarm */
+#define LTC3350_MSK_CAP_LO	BIT(15)	/* capacitance low alarm */
+
+/* LTC3350_REG_MSK_MON_STATUS masks */
+#define LTC3350_MSK_MON_CAPESR_ACTIVE		BIT(0)
+#define LTC3350_MSK_MON_CAPESR_SCHEDULED	BIT(1)
+#define LTC3350_MSK_MON_CAPESR_PENDING		BIT(2)
+#define LTC3350_MSK_MON_CAP_DONE		BIT(3)
+#define LTC3350_MSK_MON_ESR_DONE		BIT(4)
+#define LTC3350_MSK_MON_CAP_FAILED		BIT(5)
+#define LTC3350_MSK_MON_ESR_FAILED		BIT(6)
+#define LTC3350_MSK_MON_POWER_FAILED		BIT(8)
+#define LTC3350_MSK_MON_POWER_RETURNED		BIT(9)
+
+/* LTC3350_REG_CTL_REG */
+/* Begin a capacitance and ESR measurement when possible */
+#define LTC3350_CTL_STRT_CAPESR		BIT(0)
+/* A one in this bit location enables the input buffer on the GPI pin */
+#define LTC3350_CTL_GPI_BUFFER_EN	BIT(1)
+/* Stops an active capacitance/ESR measurement */
+#define LTC3350_CTL_STOP_CAPESR		BIT(2)
+/* Increases capacitor measurement resolution by 100x for smaller capacito=
rs */
+#define LTC3350_CTL_CAP_SCALE		BIT(3)
+
+/* LTC3350_REG_CHRG_STATUS */
+#define LTC3350_CHRG_STEPDOWN	BIT(0)	/* Synchronous controller in step-dow=
n mode (charging) */
+#define LTC3350_CHRG_STEPUP	BIT(1)	/* Synchronous controller in step-up mo=
de (backup) */
+#define LTC3350_CHRG_CV		BIT(2)	/* The charger is in constant voltage mode=
 */
+#define LTC3350_CHRG_UVLO	BIT(3)	/* The charger is in undervoltage lockout=
 */
+#define LTC3350_CHRG_INPUT_ILIM	BIT(4)	/* The charger is in input current =
limit */
+#define LTC3350_CHRG_CAPPG	BIT(5)	/* The capacitor voltage is above power =
good threshold */
+#define LTC3350_CHRG_SHNT	BIT(6)	/* The capacitor manager is shunting */
+#define LTC3350_CHRG_BAL	BIT(7)	/* The capacitor manager is balancing */
+#define LTC3350_CHRG_DIS	BIT(8)	/* Charger disabled for capacitance measur=
ement */
+#define LTC3350_CHRG_CI		BIT(9)	/* The charger is in constant current mode=
 */
+#define LTC3350_CHRG_PFO	BIT(11)	/* Input voltage is below PFI threshold *=
/
+
+/* LTC3350_REG_MON_STATUS */
+#define LTC3350_MON_CAPESR_ACTIVE	BIT(0)	/* Capacitance/ESR measurement in=
 progress */
+#define LTC3350_MON_CAPESR_SCHEDULED	BIT(1)	/* Waiting programmed time */
+#define LTC3350_MON_CAPESR_PENDING	BIT(2)	/* Waiting for satisfactory cond=
itions */
+#define LTC3350_MON_CAP_DONE		BIT(3)	/* Capacitance measurement has comple=
ted */
+#define LTC3350_MON_ESR_DONE		BIT(4)	/* ESR Measurement has completed */
+#define LTC3350_MON_CAP_FAILED		BIT(5)	/* Last capacitance measurement fai=
led */
+#define LTC3350_MON_ESR_FAILED		BIT(6)	/* Last ESR measurement failed */
+#define LTC3350_MON_POWER_FAILED	BIT(8)	/* Unable to charge */
+#define LTC3350_MON_POWER_RETURNED	BIT(9)	/* Able to charge */
+
+
+struct ltc3350_info {
+	struct i2c_client	*client;
+	struct regmap		*regmap;
+	struct power_supply	*charger;
+	struct power_supply	*capacitor;
+	u32 rsnsc;	/* Series resistor that sets charge current, microOhm */
+	u32 rsnsi;	/* Series resistor to measure input current, microOhm */
+};
+
+/*
+ * About LTC3350 "alarm" functions: Setting a bit in the LTC3350_REG_MSK_A=
LARMS
+ * register enables the alarm. The alarm will trigger an SMBALERT only onc=
e.
+ * To reset the alarm, write a "1" bit to LTC3350_REG_CLR_ALARMS. Then the=
 alarm
+ * will trigger another SMBALERT when conditions are met (may be immediate=
ly).
+ * After writing to one of the corresponding level registers, enable the a=
larm,
+ * so that a UEVENT triggers when the alarm goes off.
+ */
+static void ltc3350_enable_alarm(struct ltc3350_info *info, unsigned int r=
eg)
+{
+	unsigned int mask;
+
+	/* Register locations correspond to alarm mask bits */
+	mask =3D BIT(reg - LTC3350_REG_CAP_UV_LVL);
+	/* Clear the alarm bit so it may trigger again */
+	regmap_write(info->regmap, LTC3350_REG_CLR_ALARMS, mask);
+	/* Enable the alarm */
+	regmap_update_bits(info->regmap, LTC3350_REG_MSK_ALARMS, mask, mask);
+}
+
+/* Convert enum value to POWER_SUPPLY_STATUS value */
+static int ltc3350_state_decode(unsigned int value)
+{
+	if (value & LTC3350_CHRG_STEPUP)
+		return POWER_SUPPLY_STATUS_DISCHARGING; /* running on backup */
+
+	if (value & LTC3350_CHRG_PFO)
+		return POWER_SUPPLY_STATUS_NOT_CHARGING;
+
+	if (value & LTC3350_CHRG_STEPDOWN) {
+		/* The chip remains in CV mode indefinitely, hence "full" */
+		if (value & LTC3350_CHRG_CV)
+			return POWER_SUPPLY_STATUS_FULL;
+
+		return POWER_SUPPLY_STATUS_CHARGING;
+	}
+
+	/* Not in step down? Must be full then (never seen this) */
+	return POWER_SUPPLY_STATUS_FULL;
+};
+
+static int ltc3350_get_status(struct ltc3350_info *info, union power_suppl=
y_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, LTC3350_REG_CHRG_STATUS, &regval);
+	if (ret)
+		return ret;
+
+	val->intval =3D ltc3350_state_decode(regval);
+
+	return 0;
+}
+
+static int ltc3350_charge_status_decode(unsigned int value)
+{
+	if (!(value & LTC3350_CHRG_STEPDOWN))
+		return POWER_SUPPLY_CHARGE_TYPE_NONE;
+
+	/* constant voltage is "topping off" */
+	if (value & LTC3350_CHRG_CV)
+		return POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+
+	/* input limiter */
+	if (value & LTC3350_CHRG_INPUT_ILIM)
+		return POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE;
+
+	/* constant current is "fast" */
+	if (value & LTC3350_CHRG_CI)
+		return POWER_SUPPLY_CHARGE_TYPE_FAST;
+
+	return POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+}
+
+static int ltc3350_get_charge_type(struct ltc3350_info *info, union power_=
supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, LTC3350_REG_CHRG_STATUS, &regval);
+	if (ret)
+		return ret;
+
+	val->intval =3D ltc3350_charge_status_decode(regval);
+
+	return 0;
+}
+
+static int ltc3350_get_online(struct ltc3350_info *info, union power_suppl=
y_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, LTC3350_REG_MON_STATUS, &regval);
+	if (ret)
+		return ret;
+
+	/* indicates if input voltage is sufficient to charge */
+	val->intval =3D !!(regval & LTC3350_MON_POWER_RETURNED);
+
+	return 0;
+}
+
+static int ltc3350_get_scaled(struct ltc3350_info *info, unsigned int reg,
+			      int scale, int *value)
+{
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, reg, &regval);
+	if (ret)
+		return ret;
+
+	/*
+	 * The "scale" here is 10 =CE=BCV per LSB, this allows all calculations t=
o
+	 * be done in 32-bit integer without overflow. This converts the
+	 * register value to =CE=BCV.
+	 */
+	*value =3D regval * scale / 10;
+
+	return 0;
+}
+
+static int ltc3350_set_scaled(struct ltc3350_info *info, unsigned int reg,=
 int scale, int value)
+{
+	int ret;
+
+	value *=3D 10;
+	value =3D DIV_ROUND_CLOSEST(value, scale);
+
+	ret =3D regmap_write(info->regmap, reg, value);
+	if (ret)
+		return ret;
+
+	/* When writing to one of the LVL registers, update the alarm mask */
+	if (reg >=3D LTC3350_REG_CAP_UV_LVL && reg <=3D LTC3350_REG_CAP_LO_LVL)
+		ltc3350_enable_alarm(info, reg);
+
+	return 0;
+}
+
+static int ltc3350_get_input_current(struct ltc3350_info *info, union powe=
r_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, LTC3350_REG_MEAS_IIN, &regval);
+	if (ret)
+		return ret;
+
+	/* 1.983=C2=B5V/RSNSI amperes per LSB */
+	ret =3D regval * 19830;
+	ret /=3D info->rsnsi;
+	ret *=3D 100;
+
+	val->intval =3D ret;
+
+	return 0;
+}
+
+static int ltc3350_get_icharge(struct ltc3350_info *info, union power_supp=
ly_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, LTC3350_REG_MEAS_ICHG, &regval);
+	if (ret)
+		return ret;
+
+	/* 1.983=C2=B5V/RSNSC amperes per LSB */
+	ret =3D regval * 19830;
+	ret /=3D info->rsnsc;
+	ret *=3D 100;
+
+	val->intval =3D ret;
+
+	return 0;
+}
+
+static int ltc3350_get_icharge_max(struct ltc3350_info *info, union power_=
supply_propval *val)
+{
+	/* I_CHG(MAX) =3D 32mV / RSNSC (Ampere) */
+	val->intval =3D 3200000000U / (info->rsnsc / 10);
+
+	return 0;
+}
+
+static int ltc3350_get_iin_max(struct ltc3350_info *info, union power_supp=
ly_propval *val)
+{
+	/* I_IN(MAX) =3D 32mV / RSNSI (Ampere) */
+	val->intval =3D 3200000000U / (info->rsnsi / 10);
+
+	return 0;
+}
+
+
+static int ltc3350_get_die_temp(struct ltc3350_info *info, unsigned int re=
g,
+				union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, reg, &regval);
+	if (ret)
+		return ret;
+
+	/* 0.028=C2=B0C per LSB =E2=80=93 251.4=C2=B0C */
+	ret =3D 280 * regval;
+	ret /=3D 100; /* Centidegrees scale */
+	ret -=3D 25140;
+	val->intval =3D ret;
+
+	return 0;
+}
+
+static int ltc3350_set_die_temp(struct ltc3350_info *info, unsigned int re=
g, int val)
+{
+	unsigned int regval;
+	int ret;
+
+	/* 0.028=C2=B0C per LSB =E2=80=93 251.4=C2=B0C */
+	regval =3D val + 25140;
+	regval *=3D 100;
+	regval /=3D 280;
+
+	ret =3D regmap_write(info->regmap, reg, regval);
+	if (ret)
+		return ret;
+
+	ltc3350_enable_alarm(info, reg);
+	return 0;
+}
+
+static int ltc3350_get_num_caps(struct ltc3350_info *info, union power_sup=
ply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, LTC3350_REG_NUM_CAPS, &regval);
+	if (ret)
+		return ret;
+
+	val->intval =3D regval + 1;
+
+	return 0;
+}
+
+
+/* Custom properties */
+static ssize_t ltc3350_attr_show(struct device *dev,
+				 struct device_attribute *attr, char *buf,
+				 unsigned int reg, int scale)
+{
+	struct power_supply *psy =3D to_power_supply(dev);
+	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
+	int value;
+	int ret;
+
+	ret =3D ltc3350_get_scaled(info, reg, scale, &value);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", value);
+}
+
+static ssize_t ltc3350_attr_store(struct device *dev, struct device_attrib=
ute *attr,
+				  const char *buf, size_t count,
+				  unsigned int reg, unsigned int scale)
+{
+	struct power_supply *psy =3D to_power_supply(dev);
+	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
+	unsigned long val;
+	int ret;
+
+	ret =3D kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	ret =3D ltc3350_set_scaled(info, reg, val, scale);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+#define LTC3350_DEVICE_ATTR_RO(_name, _reg, _scale)				\
+static ssize_t _name##_show(struct device *dev, struct device_attribute *a=
ttr,	\
+			    char *buf)						\
+{										\
+	return ltc3350_attr_show(dev, attr, buf, _reg, _scale);			\
+}										\
+static DEVICE_ATTR_RO(_name)
+
+#define LTC3350_DEVICE_ATTR_RW(_name, _reg, _scale)				\
+static ssize_t _name##_show(struct device *dev, struct device_attribute *a=
ttr,	\
+			    char *buf)						\
+{										\
+	return ltc3350_attr_show(dev, attr, buf, _reg, _scale);			\
+}										\
+static ssize_t _name##_store(struct device *dev, struct device_attribute *=
attr, \
+			     const char *buf, size_t count)			\
+{										\
+	return ltc3350_attr_store(dev, attr, buf, count, _reg, _scale);		\
+}										\
+static DEVICE_ATTR_RW(_name)
+
+/* Shunt voltage, 183.5=CE=BCV per LSB */
+LTC3350_DEVICE_ATTR_RW(vshunt, LTC3350_REG_VSHUNT, 1835);
+
+/* General purpose input, 183.5=CE=BCV per LSB */
+LTC3350_DEVICE_ATTR_RO(gpi, LTC3350_REG_MEAS_GPI, 1835);
+LTC3350_DEVICE_ATTR_RW(gpi_uv, LTC3350_REG_GPI_UV_LVL, 1835);
+LTC3350_DEVICE_ATTR_RW(gpi_ov, LTC3350_REG_GPI_OV_LVL, 1835);
+
+/* Input voltage, 2.21mV per LSB */
+LTC3350_DEVICE_ATTR_RO(vin, LTC3350_REG_MEAS_VIN, 22100);
+LTC3350_DEVICE_ATTR_RW(vin_uv, LTC3350_REG_VIN_UV_LVL, 22100);
+LTC3350_DEVICE_ATTR_RW(vin_ov, LTC3350_REG_VIN_OV_LVL, 22100);
+
+static ssize_t charge_status_show(struct device *dev, struct device_attrib=
ute *attr, char *buf)
+{
+	struct power_supply *psy =3D to_power_supply(dev);
+	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
+	unsigned int regval;
+	int ret;
+
+	ret =3D regmap_read(info->regmap, LTC3350_REG_CHRG_STATUS, &regval);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", regval);
+}
+static DEVICE_ATTR_RO(charge_status);
+
+static struct attribute *ltc3350_sysfs_entries[] =3D {
+	&dev_attr_vshunt.attr,
+	&dev_attr_gpi.attr,
+	&dev_attr_gpi_uv.attr,
+	&dev_attr_gpi_ov.attr,
+	&dev_attr_vin.attr,
+	&dev_attr_vin_uv.attr,
+	&dev_attr_vin_ov.attr,
+	&dev_attr_charge_status.attr,
+	NULL,
+};
+
+static const struct attribute_group ltc3350_attr_group =3D {
+	.name	=3D NULL,	/* put in device directory */
+	.attrs	=3D ltc3350_sysfs_entries,
+};
+
+static const struct attribute_group *ltc3350_attr_groups[] =3D {
+	&ltc3350_attr_group,
+	NULL,
+};
+
+static int ltc3350_get_property(struct power_supply *psy, enum power_suppl=
y_property psp,
+				union power_supply_propval *val)
+{
+	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		return ltc3350_get_status(info, val);
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		return ltc3350_get_charge_type(info, val);
+	case POWER_SUPPLY_PROP_ONLINE:
+		return ltc3350_get_online(info, val);
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		return ltc3350_get_scaled(info, LTC3350_REG_MEAS_VOUT, 22100, &val->intv=
al);
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		return ltc3350_get_scaled(info, LTC3350_REG_VOUT_UV_LVL, 22100, &val->in=
tval);
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		return ltc3350_get_scaled(info, LTC3350_REG_VOUT_OV_LVL, 22100, &val->in=
tval);
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		return ltc3350_get_input_current(info, val);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		return ltc3350_get_icharge(info, val);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		return ltc3350_get_icharge_max(info, val);
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return ltc3350_get_iin_max(info, val);
+	case POWER_SUPPLY_PROP_TEMP:
+		return ltc3350_get_die_temp(info, LTC3350_REG_MEAS_DTEMP, val);
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+		return ltc3350_get_die_temp(info, LTC3350_REG_DTEMP_COLD_LVL, val);
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		return ltc3350_get_die_temp(info, LTC3350_REG_DTEMP_HOT_LVL, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltc3350_set_property(struct power_supply *psy, enum power_suppl=
y_property psp,
+				const union power_supply_propval *val)
+{
+	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+		return ltc3350_set_die_temp(info, LTC3350_REG_DTEMP_COLD_LVL, val->intva=
l);
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		return ltc3350_set_die_temp(info, LTC3350_REG_DTEMP_HOT_LVL, val->intval=
);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltc3350_property_is_writeable(struct power_supply *psy, enum po=
wer_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+	case POWER_SUPPLY_PROP_CELL_VOLTAGE_MIN:
+	case POWER_SUPPLY_PROP_CELL_VOLTAGE_MAX:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+/* Charger power supply property routines */
+static enum power_supply_property ltc3350_properties[] =3D {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
+};
+
+static const struct power_supply_desc ltc3350_desc =3D {
+	.name		=3D "ltc3350",
+	.type		=3D POWER_SUPPLY_TYPE_MAINS,
+	.properties	=3D ltc3350_properties,
+	.num_properties	=3D ARRAY_SIZE(ltc3350_properties),
+	.get_property	=3D ltc3350_get_property,
+	.set_property	=3D ltc3350_set_property,
+	.property_is_writeable =3D ltc3350_property_is_writeable,
+};
+
+static int ltc3350_capacitor_get_property(struct power_supply *psy, enum p=
ower_supply_property psp,
+					  union power_supply_propval *val)
+{
+	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		return ltc3350_get_status(info, val);
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		/* Capacitor stack voltage, 1.476 mV per LSB */
+		return ltc3350_get_scaled(info, LTC3350_REG_MEAS_VCAP, 14760, &val->intv=
al);
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		return ltc3350_get_scaled(info, LTC3350_REG_VCAP_UV_LVL, 14760, &val->in=
tval);
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		return ltc3350_get_scaled(info, LTC3350_REG_VCAP_OV_LVL, 14760, &val->in=
tval);
+	case POWER_SUPPLY_PROP_NUMBER_OF_SERIAL_CELLS:
+		return ltc3350_get_num_caps(info, val);
+	case POWER_SUPPLY_PROP_CELL1_VOLTAGE_NOW:
+		/* Single capacitor voltages, 183.5=CE=BCV per LSB */
+		return ltc3350_get_scaled(info, LTC3350_REG_MEAS_VCAP1, 1835, &val->intv=
al);
+	case POWER_SUPPLY_PROP_CELL2_VOLTAGE_NOW:
+		return ltc3350_get_scaled(info, LTC3350_REG_MEAS_VCAP2, 1835, &val->intv=
al);
+	case POWER_SUPPLY_PROP_CELL3_VOLTAGE_NOW:
+		return ltc3350_get_scaled(info, LTC3350_REG_MEAS_VCAP3, 1835, &val->intv=
al);
+	case POWER_SUPPLY_PROP_CELL4_VOLTAGE_NOW:
+		return ltc3350_get_scaled(info, LTC3350_REG_MEAS_VCAP4, 1835, &val->intv=
al);
+	case POWER_SUPPLY_PROP_CELL_VOLTAGE_MIN:
+		return ltc3350_get_scaled(info, LTC3350_REG_CAP_UV_LVL, 1835, &val->intv=
al);
+	case POWER_SUPPLY_PROP_CELL_VOLTAGE_MAX:
+		return ltc3350_get_scaled(info, LTC3350_REG_CAP_OV_LVL, 1835, &val->intv=
al);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltc3350_capacitor_set_property(struct power_supply *psy, enum p=
ower_supply_property psp,
+					  const union power_supply_propval *val)
+{
+	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		return ltc3350_set_scaled(info, LTC3350_REG_VCAP_UV_LVL, 14760, val->int=
val);
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		return ltc3350_set_scaled(info, LTC3350_REG_VCAP_OV_LVL, 14760, val->int=
val);
+	case POWER_SUPPLY_PROP_CELL_VOLTAGE_MIN:
+		return ltc3350_set_scaled(info, LTC3350_REG_CAP_UV_LVL, 1835, val->intva=
l);
+	case POWER_SUPPLY_PROP_CELL_VOLTAGE_MAX:
+		return ltc3350_set_scaled(info, LTC3350_REG_CAP_OV_LVL, 1835, val->intva=
l);
+	default:
+		return -EINVAL;
+	}
+}
+
+static enum power_supply_property ltc3350_capacitor_properties[] =3D {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_NUMBER_OF_SERIAL_CELLS,
+	POWER_SUPPLY_PROP_CELL1_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CELL2_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CELL3_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CELL4_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CELL_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_CELL_VOLTAGE_MAX,
+};
+
+static const struct power_supply_desc ltc3350_capacitor_desc =3D {
+	.name		=3D "ltc3350_capacitor",
+	.type		=3D POWER_SUPPLY_TYPE_BATTERY,
+	.properties	=3D ltc3350_capacitor_properties,
+	.num_properties	=3D ARRAY_SIZE(ltc3350_capacitor_properties),
+	.get_property	=3D ltc3350_capacitor_get_property,
+	.set_property	=3D ltc3350_capacitor_set_property,
+	.property_is_writeable =3D ltc3350_property_is_writeable,
+};
+
+static char *ltc3350_supply_interface_capacitor[] =3D { "ltc3350_capacitor=
" };
+
+static bool ltc3350_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	/* all registers up to this one are writeable */
+	return reg < LTC3350_REG_NUM_CAPS;
+}
+
+static bool ltc3350_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/* read-only status registers and self-clearing register */
+	return reg > LTC3350_REG_NUM_CAPS || reg =3D=3D LTC3350_REG_CLR_ALARMS;
+}
+
+static const struct regmap_config ltc3350_regmap_config =3D {
+	.reg_bits	=3D 8,
+	.val_bits	=3D 16,
+	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
+	.writeable_reg	=3D ltc3350_is_writeable_reg,
+	.volatile_reg	=3D ltc3350_is_volatile_reg,
+	.max_register	=3D LTC3350_REG_MEAS_DTEMP,
+	.cache_type	=3D REGCACHE_MAPLE,
+};
+
+static int ltc3350_probe(struct i2c_client *client)
+{
+	struct device *dev =3D &client->dev;
+	struct ltc3350_info *info;
+	struct power_supply_config ltc3350_config =3D {};
+	int ret;
+
+	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->client =3D client;
+	i2c_set_clientdata(client, info);
+
+	info->regmap =3D devm_regmap_init_i2c(client, &ltc3350_regmap_config);
+	if (IS_ERR(info->regmap))
+		return dev_err_probe(dev, PTR_ERR(info->regmap),
+				     "Failed to initialize register map\n");
+
+	ret =3D device_property_read_u32(dev, "lltc,rsnsc-micro-ohms",
+				       &info->rsnsc);
+	if (ret)
+		return dev_err_probe(dev, ret, "Missing lltc,rsnsc-micro-ohms property\n=
");
+
+	if (!info->rsnsc)
+		return -EINVAL;
+
+	ret =3D device_property_read_u32(dev, "lltc,rsnsi-micro-ohms",
+				       &info->rsnsi);
+	if (ret)
+		return dev_err_probe(dev, ret, "Missing lltc,rsnsi-micro-ohms property\n=
");
+
+	if (!info->rsnsi)
+		return -EINVAL;
+
+	/* Clear and disable all interrupt sources*/
+	ret =3D regmap_write(info->regmap, LTC3350_REG_CLR_ALARMS, 0xFFFF);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to write configuration\n");
+
+	regmap_write(info->regmap, LTC3350_REG_MSK_ALARMS, 0);
+	regmap_write(info->regmap, LTC3350_REG_MSK_MON_STATUS, 0);
+
+	ltc3350_config.fwnode =3D dev_fwnode(dev);
+	ltc3350_config.drv_data =3D info;
+	info->capacitor =3D devm_power_supply_register(dev, &ltc3350_capacitor_de=
sc, &ltc3350_config);
+	if (IS_ERR(info->capacitor)) {
+		dev_err(dev, "Failed to register capacitor\n");
+		return PTR_ERR(info->capacitor);
+	}
+
+	ltc3350_config.supplied_to =3D ltc3350_supply_interface_capacitor;
+	ltc3350_config.num_supplicants =3D ARRAY_SIZE(ltc3350_supply_interface_ca=
pacitor);
+	ltc3350_config.attr_grp =3D ltc3350_attr_groups;
+	info->charger =3D devm_power_supply_register(dev, &ltc3350_desc, &ltc3350=
_config);
+	if (IS_ERR(info->charger)) {
+		dev_err(dev, "Failed to register charger\n");
+		return PTR_ERR(info->charger);
+	}
+
+	/* Enable interrupts on status changes */
+	regmap_write(info->regmap, LTC3350_REG_MSK_MON_STATUS,
+		     LTC3350_MON_POWER_FAILED | LTC3350_MON_POWER_RETURNED);
+
+	return 0;
+}
+
+static void ltc3350_alert(struct i2c_client *client, enum i2c_alert_protoc=
ol type,
+			  unsigned int flag)
+{
+	struct ltc3350_info *info =3D i2c_get_clientdata(client);
+
+	if (type !=3D I2C_PROTOCOL_SMBUS_ALERT)
+		return;
+
+	power_supply_changed(info->charger);
+}
+
+static const struct i2c_device_id ltc3350_i2c_id_table[] =3D {
+	{ "ltc3350", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, ltc3350_i2c_id_table);
+
+static const struct of_device_id ltc3350_of_match[] =3D {
+	{ .compatible =3D "lltc,ltc3350", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ltc3350_of_match);
+
+static struct i2c_driver ltc3350_driver =3D {
+	.probe		=3D ltc3350_probe,
+	.alert		=3D ltc3350_alert,
+	.id_table	=3D ltc3350_i2c_id_table,
+	.driver =3D {
+		.name		=3D "ltc3350-charger",
+		.of_match_table	=3D ltc3350_of_match,
+	},
+};
+module_i2c_driver(ltc3350_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
+MODULE_DESCRIPTION("LTC3350 charger driver");
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

