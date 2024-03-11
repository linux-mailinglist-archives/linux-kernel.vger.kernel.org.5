Return-Path: <linux-kernel+bounces-98743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A51877EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1813B21A02
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA63039870;
	Mon, 11 Mar 2024 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="tLWNEPUI"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2096.outbound.protection.outlook.com [40.107.243.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601418C01;
	Mon, 11 Mar 2024 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710155658; cv=fail; b=RSxl7E1m7FQAQpcC8AQpXRU82i6ePXfo3DNzH/cwSxiuaePQOjdF2QSCloYKZECd4/gV/r40cVSwxgcoHkAcCDJ/zR1giwLa18h1rIvrMJW5Npqhx3DJhK6GTPHqS74c2TxEL2R2ABP8mcfWJBvrKvXhs5X0Xxbesfop0h+Untg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710155658; c=relaxed/simple;
	bh=JTNFx9nu6kHoZBi7nrt5kuYuwiGGKDt8M6tD/UaH0Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TJuNwt1BThE7U9lnOYYct77f9uDfIsH0r0cvSAWtHnnd4SNsOEAmCQyecVIAnTnKrowpSi6ele8bwBIM1guGImnUku6Vh+ojU4D9/XyaSgMdfBjfL60B92iu0UYezZ156JM6+vAiWLgs13fJJi2F3+aY3oCAQm0reMrp0OKIQOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=tLWNEPUI; arc=fail smtp.client-ip=40.107.243.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmglObk9gveKMMWwLLejIy/RRDG5LGt82dJt9q2XfcPHmkWnnKPuan6puBo2L+E0RZPIPi05FrkOL2QOVFArIAOWkSuNzj096odS+gJSlm0HLU3QWkz8nPfurafDjYImvujfkrulwnEgV1SC2bxBl+O145tV36h5s3bR4WUiuWdR8DKlWXPX+98b/5cKdQ84uvmHdGwllCDO4p/zgH++myEiW9Y1rFX02YRlCO65qRqSp6to6ZPHFh8vnspk2nmBTjrvbrChNZupfw9kU+TbPuwkjB4RbTPlRlvPapKh7rSGjJIFokFn+GRc36H8I5JiMk9BYzTVc4iDhvXCz5uezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCgPLH2auC97U2Faw5s1wc0K77ofpRpqL6q790ZEFHg=;
 b=oNUmH62ZAi3mC0GEnLz2xWjVmCfwckUJziy+ixzIJ154pTm8lc18Tmbo9YFiQ2hFf0umHYZgLdqWWX4s1CWveGun9Vsz6PgNJrvKXQhwzyAVe7yKgJQVIfUAc4/FdYY2inGc2D1+UmoBcEgj+jzz/Z0WpjA58LPPhX2Z7Q0+t/MPfOSqX7kKU+UESFPTJu5GlX/hS0NzwhS8iuG/xKyPiXcrR4xRGvJ6dZoIWRDBKUhAbVD3TCrE7/neZCq7i25u6wQDttRiblOXTEKihT3dHp6GOrGA6O47BGe0Wg34Mzj5ciDmB3p1eQv8KIbVMxqzPQl/6kLvlwszyyBsDHzcYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCgPLH2auC97U2Faw5s1wc0K77ofpRpqL6q790ZEFHg=;
 b=tLWNEPUIHLoseVPSQuFRJD1gRJqOSpWLVgceYBP14BCfyBgk/sDgznPHWgkw6sfHTQTm5bOJQH654nE2ONM+P3RvgYcxE4bIhgfiULj/y2gfFL05vlAazubxLzeBD5LoN4uVa+gCKHnBX68JgFxeLBuwn+siOmnxlWFZccBYEHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5947.prod.exchangelabs.com (2603:10b6:5:1dd::12) by
 CO1PR01MB6741.prod.exchangelabs.com (2603:10b6:303:f2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.35; Mon, 11 Mar 2024 11:14:13 +0000
Received: from DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::b557:13cd:8a29:ae08]) by DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::b557:13cd:8a29:ae08%4]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 11:14:13 +0000
From: Chanh Nguyen <chanh@os.amperecomputing.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Justin Ledford <justinledford@google.com>,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>
Subject: [PATCH 0/3] Update the max31790 driver
Date: Mon, 11 Mar 2024 18:13:44 +0700
Message-Id: <20240311111347.23067-1-chanh@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0088.apcprd02.prod.outlook.com
 (2603:1096:4:90::28) To DM6PR01MB5947.prod.exchangelabs.com
 (2603:10b6:5:1dd::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5947:EE_|CO1PR01MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e998ca2-d005-4b1d-a2c5-08dc41bc6159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XKuqTsqj6P46u7D2DTHTckA2DLdzFdM+ox48rM1Y6ViZrbW3wtGmszoGD6lT4qNKVHet5vQbpcxSiJqmO6is3/2m9AKIry6dISpX1NgVR4h70oz98hhNgTmjPBfzgY0W+8vmQijmVVNaJH5av0iD/4UKMfxQpYLpmlG6s813maBvL6p/Im4wTCqYkaF0lAy2wWO08VreUchNrbbaLoKFPXj9fvIP+z5IRMaSyR+15X4+L/rFAgiQgS/EPOob3XRNeL3UXWHakCOFYxrhPn2KZ7T/zJxncD9meRoWqqQ5iH8UeO+wOtjD5z/gFmfXjrTDvVV2QrumNoHWSb9q/0cc0Mc/OS68hiHsu80bGspNONktZbEDOWYle856/N59umSLZawcv/L1bWl/kV+DSlCso21AP4IvtWfV1OIMv7c3NKMd722g4i20hMWkDgwLedjf8w+/zYR0K0ShE3b3t7xGIZPmDVE8hFAnP7TkUijXBca6ywjXDbtGLgnEl1mtocmWdpw57jxZ3MO6qiuku4a+wpadSeLIAqinFrOlZ7ERh/gomHA28fn6/D7eDV03/UdfP9vi6jv1pYZDPX7BUmV1XVB5Bu3VApVfB2sG7Yv37ldKxdaeinkN3Cwsuaja5cEqkkC1jIi4Fat1OvhgKeyk053vZ6Tal6z3EMxVUGcUpIsI1YXPWAPkgxZHQ36wBFKXhUlRCv6AiqivjPZ4PcmxPpe8HSgR1HtWVVG4FoMVYro=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5947.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X0b0b1oA3P/6unv6kn0z106EvghlRxoOSVaftg0GjXrTV12+6aXxtuUQY53E?=
 =?us-ascii?Q?vRdc+BNgyno40W8K+lZO/dogze0kbejgknSYsOGuRjWxeMRkqBgl/5o2Qn9T?=
 =?us-ascii?Q?3XoxbctNfeyOFPjkFydkOe39OtPSDjkwc9GMaM9LOXIcZgYO/R19uyp8NBsN?=
 =?us-ascii?Q?MTaMbOX98eE66+oFi57E+o+IcoD0CyIHpWT3NemEeidpWQmJtjqRCg8Beqmn?=
 =?us-ascii?Q?bAJS+imqiG9cmbdn7t/kEksXOlmTtPd5RriOQrlZKGQiyY0naTB313MKH3xW?=
 =?us-ascii?Q?kG3OJHhpBqWKIuV9oLAxqnKNq89aykjmeStKIgEQJbEhKbYpU/lUtHI2iQPm?=
 =?us-ascii?Q?oyD+/cgoDYQiea/wSy+I9KgJqTw7TdlEPnTUa9X51vx2J5SSPcSaQoVyMM0y?=
 =?us-ascii?Q?H1G6llxUlJFqzoxNGfTL8l1a9BoKozKzgdCPdNf6B2aBcGuW0/3Xct7COzo9?=
 =?us-ascii?Q?jTzvvLYmk9hNAOUyO8OzDj5qoFFhRJBpLFiaZX6OCHkjufKzEd76aduz3RqU?=
 =?us-ascii?Q?VirpeZ8eGJLGIZbSRz7JpJf926rPguhC5eReOjKIuJ5eI1TY0CinTMPuh1Fp?=
 =?us-ascii?Q?LKATLg2bOAPmsLpBfxekdN4CdSgxlGYpQGP9nH5/algkMST2wSmkr3TGrwYx?=
 =?us-ascii?Q?+7fabwusoEygmts1YeRecyKLiIIeGnNmpdP+/lqxIGfWgL3hVs8SctUX9ZUF?=
 =?us-ascii?Q?BSKqp0bLU1w0dGT6UVc9SPm0jb4098Ztg2nrLY9/EvVv9LhPuAJ6cBPBbjx4?=
 =?us-ascii?Q?pMs+LGxIE9SDSssRyX6idqXDVgyj17ZpoLRKM3asHWrVrx5eRmslXxw7MmJ7?=
 =?us-ascii?Q?a+BKWHywcxDJfXN6xqwi9fQsTbANPdV5Xl/iLdn8iR9+m9ocUGVA1TBgrXmd?=
 =?us-ascii?Q?lB/8O2LPgM7XaYlHimayhZYAvOimZ+/S9ZqKr3NlJ6A8oY3arHAoh75H7XmV?=
 =?us-ascii?Q?1cza7DBVHLk1LpQCKnJHwtwaPUvs9SYAIlPK350SC0ikLZJx1LCTnJCCUsVC?=
 =?us-ascii?Q?c47z/DL4bFeV2dkbnXmqOJU6DGpun6TLGa035x9Mx2Rp184D7h7GoxN0C3eA?=
 =?us-ascii?Q?S6Zc+ZaiQOanfKPegMhwSsZdDdp+bkjVZ4R95hrWWa3chV7zHYqzT1S0m22q?=
 =?us-ascii?Q?9DVoRVV2T6TxD0m5ZyU5CCmsCJICJGPEbQaFeHDP5ll2R9pMhykquKEqSK00?=
 =?us-ascii?Q?5J/eAYypiK4WotU6H2iUUdm9WyBvlKLxEv25Omc4EfGp/3uHlvbMYrbHUIBG?=
 =?us-ascii?Q?0ZYYJE99u+Dq0JKf0WVaJ20Li6kaj9Abh9binV+GG1rFamuIA+AO+8AlXDmv?=
 =?us-ascii?Q?LQPb4QjHtsYPO5Jz8ukNLye9y3gT3IliXDiUP5BJlhYW+Jj/3Qjld2Br8Wd9?=
 =?us-ascii?Q?pIaJIX6rMEx0V2oBbuZOKyZaHHoJRGW2ceOhWZ4FovY8mCfyIy0xLwcUuz84?=
 =?us-ascii?Q?CHp/JtB2ivrUt9ZRkjgjVzris82Yl5vCyqvAi06vQqmGPhW/WXkXO3Jo3jTK?=
 =?us-ascii?Q?Gy8F108HJQ3CIClB+M23iaUdAR2S7UYjSDSt4uSn6gO7ub7G4kuXfLAwvNzG?=
 =?us-ascii?Q?XOoEcD1uyv0618cyy1J0Sm+0CAlQ9die1mcBLMXCgfbmUvglWKFlAkRCR/0x?=
 =?us-ascii?Q?iaQYgAh8IBJYyEj1JZiOBp8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e998ca2-d005-4b1d-a2c5-08dc41bc6159
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5947.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 11:14:12.8879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M44Cpgdxbw8m66M8ldbOg0m/lEPMGM1RDJ6eIDvD5qeqx4uiIpFfvce8ymeUTfAgOmCozKgim5Ztc3xaLiczHJiB+LbHTjnrihpYK3dD/UtWzwvjAoCiH6nNgkjCxrnx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6741

Add the max31790 driver binding document and support pwmout-pin-as-tach-input
property for the max31790 driver.

Chanh Nguyen (3):
  dt-bindings: hwmon: Add maxim max31790 driver bindings
  hwmon: (max31790): Support config PWM output becomes TACH
  dt-bindings: hwmon: max31790: Add pwmout-pin-as-tach-input property

 .../devicetree/bindings/hwmon/max31790.yaml   | 55 +++++++++++++++++++
 drivers/hwmon/max31790.c                      | 31 +++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/max31790.yaml

-- 
2.17.1


