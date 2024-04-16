Return-Path: <linux-kernel+bounces-146771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F7D8A6AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD4D1F215C4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5FC12C534;
	Tue, 16 Apr 2024 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="shUWSQUt"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2112.outbound.protection.outlook.com [40.107.15.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1254F12AAD2;
	Tue, 16 Apr 2024 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269922; cv=fail; b=vGWAzUyFaWOgBDzVqXN7wIENfsnvHw6kDTJ8qFIc3ICcf/QUBITlHRwo0rKeGvvfWUdNeKWoBI1e2JrPkCk5GHkxnBysk+T6atLcqnwAtD/xlMawLdhJFT1K8jz8GAmulPHLwP0cI80Ru3iDD4bPg+VGxX1bRjHoA0V0SBK9VF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269922; c=relaxed/simple;
	bh=1aoN1xbl/7l9754dcmnA721Yk2m5ifv0RCLzGUA6YGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=agK+BIsiAt15Vhg+ZcsOWYBIrbWfppA8IQFBsPvuPhFDPQW+xAxmQD7mb3zJ0oV3fvAjW59+T+mpYaFXSNjePQcZznepIrxOlEPxcgPNXkMynAuqd1mAXiAQPxJCfUWwPVuCG5YSx5JwhGYWCOW+qet6Kjx4wJUa6uO7RbQ8EVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=shUWSQUt; arc=fail smtp.client-ip=40.107.15.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zie07Se5jWnuWrB4pPkPuOBO+dMFgGsEMMTwWvoqwWZ9bY1jU+n3J9H3Ga0pDBBxStntRE673qybXx6S9mgli1GY8+4sluk7uH05wu/YLqfmtR6bKxVG8wjmZBN2B420bXVrzNiDQS5QaZdVTgi7kC4oFUjWQaoXJJQo25E5HvzE0VDoQoGUdPQTYkAX7KvKZlGGwNJa9mptbsO0l0CbS60QjPjJfUK8LAjmnMmKStvJo67gsTV8mBZntKIsKggrjzXcKw7SL6cf7C20jf9xctrUGys6+FAf+z+DSDaBMWe4nn4g86hTyUBKMhl9xYADC0wwe96jfs8BRzKUSS8+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNwBJ+3V/poH/cqTNYIJW1lD5XSkzsOCir07AgsEEfk=;
 b=eriC23oOvo62Ntf+2YgoUX7Cltjuog/0N7PMixIQ2qSLiWhxLxVSKzZiQ8CzyoJdhgZksb9iKUwuIQqSDvrEvqbCyzeZ6rh8U2c+P/JoALSaBxMTG97SieOh/urJEedHqG+2PB9ZZadhXGVu/qSQHu+VG74cofB3VL2ggsScb+FLVRHFBJsGhMogQNmvZRY5mDKjyCHsc4UhKRfChf6rcr6IIOIi/aX6ddasX7K1PUvwyyg6mL8JoT+MYbMzEGtE+h35d4pPtUX0MBQieJKUdl3cEdtd3uuHZTEy2/iBw/cfH00bCSA5JccHuG8NaAmtQJKWzJ5Axqutqc7Z8+RP3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNwBJ+3V/poH/cqTNYIJW1lD5XSkzsOCir07AgsEEfk=;
 b=shUWSQUtFXpGX43B9a86/XuoPl2zDcv/+sYPS85TBPOCkKTGUDZboPjjnNSYh8A0EOrtpWxT2SDjEyRnv+TZUoRbZUfmdXXKaRi9eh0phlMF8iKL2uKcvTcEh0gdbzAHTrNIRWa8+QULAUDRaoDjSZLfvmbl4osbdbeHURsWwLiSNs39lHD129RaKrbQQKeqPJbXCT1N5S58S7hezZkoUYjuarXiqESmU1N8DHYIOiKAIUGu6CgDRJhtff3bU9eXZKFnAiUxNx6tWEnJAYBKa4BmqeAMQicI+QKTzF9l28soqwRm/hz1Q6UwDcnWM0t3VJNJMRqD1sCWDtuvbU8GRw==
Received: from AS9PR04CA0174.eurprd04.prod.outlook.com (2603:10a6:20b:530::15)
 by AM9PR04MB8890.eurprd04.prod.outlook.com (2603:10a6:20b:409::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:18:34 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:20b:530:cafe::35) by AS9PR04CA0174.outlook.office365.com
 (2603:10a6:20b:530::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45 via Frontend
 Transport; Tue, 16 Apr 2024 12:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 12:18:34 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.169) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 16 Apr 2024 12:18:32 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by VE1PR04MB7230.eurprd04.prod.outlook.com (2603:10a6:800:1ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:18:26 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 12:18:26 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pm@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/5] power: supply: ltc3350-charger: Add driver
Date: Tue, 16 Apr 2024 14:18:18 +0200
Message-ID: <20240416121818.543896-5-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416121818.543896-1-mike.looijmans@topic.nl>
References: <20240416121818.543896-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.4a7cccf3-e7cb-4980-be8e-de8bd2795354@emailsignatures365.codetwo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM8P251CA0015.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::20) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|VE1PR04MB7230:EE_|AM1PEPF000252DA:EE_|AM9PR04MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: 6efb13fa-5b5c-4c33-71a0-08dc5e0f5612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 NNkU7EMhbsC01jBbnzt/a79NNrfCFhXCxHBD02f6oMSAdpGUowTdWqkemghrS1Gp3yzVkHDzWyBkrOJOCCzTCJEN/t9DAnpO2hT5SWyh6DNGZ4KzRn/m8AYiohMTcSVE/3Fgn3K8Ghm/vJj5GJlr7g1YYfBhcXH+BYDF2S8emMr6WEbFTadG46e5zB4DI5lQeMDG5EUnwJCVcHx+cUm4amHv79Q7HhBjw8dmHeNf5s3HELGxtaakPOn418iqDOWmppz5Y2OV/33mG61t7FQI8kTprE7IkxiHJY8yonutwBfWbuxFy32nzImwvqcUvUcw6ZSlup3+0qDRRUI3fargY0kF3HOCdi9RqbE5bUIRiv81M3KJEJcUyVkjl5Zxz2jc4YepLRA4H4jtwYh04RZdoyT46K6z3CADN1P0ffPJqyJtpG091b+h9IVY52M6XR0tP7gEjgG1XrjmBynsjOqI/hs8kKvKCIpvVDK4iQFLXapR+T7evNLcVaTUXvRPvcd6LA7fbhztlsO5BqjDhm4JlxDCpsrlqiEXnj+LeyOoTi+DWHqC9fj8QVDyvjtSLm7+MYfTm/AwMQOqWY6tI4Gz/dGSClQsrtv+a1+bjRnK4BFlpR2/epYDHeKZEWuBcqMpm88U25Lljqe0jsvqJ70u2ky5YpqNcz6uyo0oqYC6mbDyLkR/6Zl5MvcdMZzMxdC4oG72mjWpaJXME7CtdUw00oPJ6mYoi2l8vxqsEBDpfAc=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7230
X-CodeTwo-MessageID: 5cdcea80-bff0-4a07-a4cb-919c7428c8f7.20240416121832@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c2f35af9-f6bf-4a54-a3c5-08dc5e0f5134
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFFjSGgyUWxTUW1SU0QrTDAyUDdRTklDY0QxeXRHNzl6cHN6ZHl0cFNYSjZ5?=
 =?utf-8?B?Wm5pVVpPK1dZNkZmWlpQd1ZLVlRRaDlOcm1WaEs0cG5Bd29EVnRkemNBeDZR?=
 =?utf-8?B?c3RCU1kxZUJHeDJmM1RXeTM2REUwTVVxbGtaREtwL2o3TWhYQW1hNUhmdE43?=
 =?utf-8?B?ck5oN2xiYTBpZUpZOXJheFEraVlxd0ViNlQzOWFuQkVhZndzcXlXbUJJK1ZL?=
 =?utf-8?B?ZkVDVk5MYVhTRmNIcldoZFI1ZnMwYi82bWZoWFlqdUtrVnVTeDNrWmhVOGg0?=
 =?utf-8?B?U010WVpnVmtNOGxsbDRqQlArQXZjUVBrUjRzeUFHWGJSeEFDUFZ4RDI1M1ZS?=
 =?utf-8?B?Wmk3OTRzRjZ5QTVRQjkwYUUzcEdyakpoRFN1SnArbGhMZ3ZYNlRoMURXTXE3?=
 =?utf-8?B?NWtvclNTY25leXhHYjBLb1VZNFRkWU82aS9Yd0FIdHNORXU4VHB1S3dBOEN0?=
 =?utf-8?B?c0xlb2VPdGdCdDluS2lnbHFnMnVBOFA2U3hsVGNFOU5tUzlBMGw3M2tiUDBW?=
 =?utf-8?B?dTRzcFZBTGFWeVB5OWtiNWtzcTI3MEI4cy9mWGRGdHhwclIvdXJuVGtpdkx5?=
 =?utf-8?B?SVZQWGpmTGFmN2lrMjVlVHdERDUrdlRnb0VzVHVKTFFWSGVsMVlCVGVyQUkw?=
 =?utf-8?B?ZXJ0OE1tM080a3daM1hzTUFFUGtLVS83ZlU5THR4bnJ1SUtGSmdFWjlCckNu?=
 =?utf-8?B?MTRXZzdhdjQxaDBKaUFLRGRTOWl3Vkc5YUE3ZWVld1BIMjArQkV3TjlCWWlj?=
 =?utf-8?B?VEhJQ3NXS0dIcGdrcmp3cUFQRkhjcUJDVk40ZDVNLy9BZlBoRW5zcVZUa0w3?=
 =?utf-8?B?MVYxL2ozM1UvNWQ4aFJzMDkwQndldVI0NGFFRzNYTklmV0ZNSERuSmJCU3RQ?=
 =?utf-8?B?aTZzbFZYSVhPQUV1UnRZZFlyTGFxZjFNR1NVWVl3N25halcwRzdNRUF4eGVj?=
 =?utf-8?B?MXppRDkvMlZMZmp3TEwzUGpmd0N2emxKRjdZY0hQZUxtTWFBQ1k5aGpKQWVa?=
 =?utf-8?B?TXRNNWVBRVNIV1VNSjJqL1ljby9ocFpUTjdYS01BVXI0QlFBdUt5YlIyTktu?=
 =?utf-8?B?OUwvc1FmbFNKaEFndGVrQ3RwUmlPamhkaGlVL0QyN213NzdtM2xSTytuUnd5?=
 =?utf-8?B?UW50b1Y5RFBaTGtiaTFzUGJ4b21KWjV4cDc5MzhmemZhTzZlTHhVYlllQW12?=
 =?utf-8?B?MXk1S005K2laM1p0bW5OVVN4WlhwQ1Zvcm90Y2tPRmEwOWQxQnNEV1pMZkx4?=
 =?utf-8?B?NjMrUGx1Q1FUTUxMd2dsa2FBMnZzNk1zSEFrOGlHaVpOcnhqeXFEUFpzaHRa?=
 =?utf-8?B?cnFYN09USWp6MmlmM2NybDJxaW01Wkd1Z01ETmlrckFNcnFCNlZWQzlJbStu?=
 =?utf-8?B?VjFvV1ZtV3VwOTdnUXRaKy8wNmhFWlVFYVZ1bWJaa3ZPQzNxbEJINkFpVTZO?=
 =?utf-8?B?dUwwSUxIL1crVHRIZW1NVXZUYnd1bURoRG5tU2VuMkdXMTBXWGVwQkVXc3NF?=
 =?utf-8?B?c1RGVUdzN3NqN0FoVlZNYWxxZytOdWQ0RGxXTUtNeDY1SUZxenVMUFhOWkw4?=
 =?utf-8?B?VnlGaWIrRm5tdi85bHpsdXhSWURSOGUvWWRvYjAzaVkrNUFtOVlmeVE3KzBj?=
 =?utf-8?B?djIzdEY0aE13amdYenVOZVJlNWFHeDhGMFFXV0JzS2VkZlE0aHhYZjh4cURG?=
 =?utf-8?B?UWdYTSs0VFZIT3RrWTVMRzl6VHNIdWFPcVEwTDMrUWpBNzAxMWYyWGxOZkVu?=
 =?utf-8?Q?MmT0x9bPmawEDutQxlUZKqfiWo3CkTDNm5HiqBo?=
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 12:18:34.0243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efb13fa-5b5c-4c33-71a0-08dc5e0f5612
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8890

The LTC3350 is a backup power controller that can charge and monitor
a series stack of one to four supercapacitors.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

Changes in v5:
Fix ltc3350_set_scaled() arguments in "store" routines
Measurement values are signed
Report technology as "Capacitor"
Report "full" when "capgd" asserts
Move charge current to "current_now" of capacitor
Add ABI documentation

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

 .../ABI/testing/sysfs-class-power-ltc3350     |  88 ++
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/ltc3350-charger.c        | 789 ++++++++++++++++++
 4 files changed, 888 insertions(+)
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
index 000000000000..55b8a3922b4a
--- /dev/null
+++ b/drivers/power/supply/ltc3350-charger.c
@@ -0,0 +1,789 @@
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
+		if (value & LTC3350_CHRG_CAPPG)
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
+	*value =3D sign_extend32(regval, 15) * scale / 10;
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
+	ret =3D sign_extend32(regval, 15) * 19830;
+	ret /=3D (int)info->rsnsi;
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
+	ret =3D sign_extend32(regval, 15) * 19830;
+	ret /=3D (int)info->rsnsc;
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
+	ret =3D 280 * sign_extend32(regval, 15);
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
+	ret =3D ltc3350_set_scaled(info, reg, scale, val);
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
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval =3D POWER_SUPPLY_TECHNOLOGY_CAPACITOR;
+		return 0;
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
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		return ltc3350_get_icharge(info, val);
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
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
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

