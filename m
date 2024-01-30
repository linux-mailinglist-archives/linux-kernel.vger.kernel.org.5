Return-Path: <linux-kernel+bounces-43899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D46841A92
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB7C287113
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819DC37704;
	Tue, 30 Jan 2024 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="D6otkuMi"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8179137169;
	Tue, 30 Jan 2024 03:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706585561; cv=fail; b=uSa3xeLmUaeWwz9E+rWbDFuKN2E8FsIi1rKsgTWt+ZlU73LKaF0iz9LNwiShgOAE0BkdPfYDWVnN9anM1D1cqgKizsUU30ga2FSXdLYVo6VYNJa6hblJlKFl5/Q0+i3tfHZ82OwLmaF7KBYMM0W/cQs+x+cFt37X88MY6aD9UVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706585561; c=relaxed/simple;
	bh=t2fuw6cIz3fW47nCOwUFFm7p4CyDcBp2gvMyOeo6Hlo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dn6tgQlnljh+PPdrLT1KLGvzWKmgtrsCU2zQ14bfJ9YjiRud2z11ykQCTxZ2ibIQkPSACFHKpgMNsOX5Ocr1uZCYy4GA1FxOczr5X+lTVi6ymvDT63juwI/qw3vLv9c3/BsKFLdxtcRnIxVGR//VlMv4z/QNq7CXWwMEueUF76s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=D6otkuMi; arc=fail smtp.client-ip=40.107.117.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0DPvNIZBblIemIjoa41Z91FHmz831KcoOv9nll1UYfaJkOY6kBhhhhnMrkOJl+4vUpS47xmLzhHf+I+tVRgAv0riZL8pwQoOaz0pikJRtvM4UQ5mWMgN+0PpA6LAceIhRN5pGBgdOHtFT6cQLfIFsV0MN/fekNbnMQoln3Ave4iFnSS4BvU3NKe7s69CiS8aw4vF1KG41t30vqb4bwZxFBXgfkymC4M7PgEFqbfR6aaOZky8jPksSF6F0aw3f24sU+V1L++sjYK23kFq51ej8bOvGl7JE80o1AOivQEprZxaCnMMEMpV+okUu1aDuz3dytMr4SMhbivU19q9bWIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTTciFZWZ6p1TobMqmGz7s+9kkdKPuCltgFV97ItH5Q=;
 b=AzSnDJj/E3PDkIhTHJxf82InkswIw5JvmN2iOsA6+6w1tz8Ccc3jK/QxpGYurtj96vj6+niihND562Ypg7kqHAF+qs6Oeli2bM+13DBkWTaepjjHrCPMJxDZinuzYiBLFqNKz9N27oZm0Heb1d6XPbWcKZsexNOyUYHD19xkG8wvLv/LWy2LhCM567oktTHEIl/P5oPD+Cvt6btggXcE0/sI1cPUo1s7QiYD0b/DUE1xNG1mWjVzDbVlGVXFoZ9/90BRV3sZnw0cp72huUYD1h+YKN5M9U4bYgMoluQnTlYohafJbd6k8U4phMbe2MM5uSZJdvmwMhoqqmBZt88oFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTTciFZWZ6p1TobMqmGz7s+9kkdKPuCltgFV97ItH5Q=;
 b=D6otkuMiO5//7HUK9+wNxnabDRwQb3COByXY0QiaPmBJa/EZgjjDX4qC02trr8ARcx8K+zDwmyfj3NXyPhUmfV5hWjSIltTIqiQiG6lQOdWtdNcUSfZ0TEnidU4OQdwjVGem+lWXFooo20mHZgc7/Y1JI6m8/7gw2n0GyfqgmEJ9vxLd0GoG/s/OFVmHUWyOM3Rfk+2pkPpkHyWG9QYKwFZMU8U3l0uxA0BoOgrQdenBvTvsAEwU4ISdVaUSyKLfuvsmMlODkvAIvL9JYAq501kkUcV4FJxTfPHwRmg2Wip3/ATvX1k4BkkXJQmqwpf0uyJweKsShmUiKKBO2UGS9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY0PR06MB5470.apcprd06.prod.outlook.com (2603:1096:400:264::9)
 by KL1PR06MB6394.apcprd06.prod.outlook.com (2603:1096:820:99::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 03:32:34 +0000
Received: from TY0PR06MB5470.apcprd06.prod.outlook.com
 ([fe80::adf8:c18e:5c1b:55d0]) by TY0PR06MB5470.apcprd06.prod.outlook.com
 ([fe80::adf8:c18e:5c1b:55d0%5]) with mapi id 15.20.7228.028; Tue, 30 Jan 2024
 03:32:34 +0000
From: Chenggang Wang <wangchenggang@vivo.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Pierre Gondois <Pierre.Gondois@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Chenggang Wang <wangchenggang@vivo.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/doc: Update EM API em_pd_energy to em_cpu_energy
Date: Tue, 30 Jan 2024 11:32:08 +0800
Message-Id: <1706585531-24072-1-git-send-email-wangchenggang@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <TY0PR06MB5470E30E86989E8CD84FCE0DC47D2@TY0PR06MB5470.apcprd06.prod.outlook.com>
References: <TY0PR06MB5470E30E86989E8CD84FCE0DC47D2@TY0PR06MB5470.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::31)
 To TY0PR06MB5470.apcprd06.prod.outlook.com (2603:1096:400:264::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5470:EE_|KL1PR06MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 3147b298-4560-426c-ce8a-08dc214418db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5ol35oxjq2CvZZOLpB37X5i/WD2V36mMhtimZk9fr0DnidbYzAQj+bSStYCs7wubEi1wNszaua/07yiluYg86xkXdwDSTbNAHR7Pff8L86FvirLf3vQbh27r5bW4PVkBsHMIzTt+mwq7/CN31tHL9Y4kWr42DrjSls6+k3oEVsg6ZKb9b+I63HPQCl9Y7sTVKusVHkcEwlrSoytdxK/YmPZuYWeqOErllDotQW0J0b6QioRABsLycpiqvpMvWCXwVpGPjubaYAt3JCulsw6L7vVC/TpR191P/HTMfMdd4yrovmwBbXUF0AinM5/l/jFVpZxgI6c8VAvM16IOZPkIg0RS9yEEuDb4RxW1m4HKJXdKzqn36XU5S73TCI4Qi9DV7rwtQh0NkgQpOEKO9NKuseL1MU0+AEhiyHBiq3QFykr89JbAaeRzlHNr18Dz9LcdWnn6qmft4tMsQIuYQSlyhVGTJEFi1JRiAifnvL0NNgB8WNiNmf7v2S/IHd71kn2rFwJGfFmkkelr1ToJGrz4XtbLMFoeNWogGz3ywnmTKh+cnAge4TgvFXlArbwud4U9jtPkFk3UYDuEx6IVEept2UHEL3kroPk+9y7W0Tk5bbOA6LuhHJ1qkmTuhBtUkVhvcCQsT9CCsh4iXjCpq8K3tw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5470.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(921011)(41300700001)(26005)(2616005)(316002)(38350700005)(36756003)(6512007)(52116002)(478600001)(6506007)(6486002)(83380400001)(6666004)(66946007)(38100700002)(66476007)(66556008)(2906002)(110136005)(86362001)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWVXbkNrRnFYN2FuUm94MWhsamRlYzByM2hOc1RKVUx0Zk1uR3ppTWdqbmNU?=
 =?utf-8?B?QXR3bUtwaEtWQ3AzckFBY2crcS9vREFhZXpmSDMzbXJJOEdwTHVjQWRCYlJG?=
 =?utf-8?B?V0oyMVlxWFhLVnBFNXI3M0ttUnpQVHA3SDBQWUx4QW9RYThUdHJST1dQWjc3?=
 =?utf-8?B?OFdldGUzeVFvTVRxaFAzR01MUTVlblJtZEpZZldVN2Q2UzlGcG1NV3Y1ZW9K?=
 =?utf-8?B?M1ROc3hjL1BjVWZDSVpsdW1PRVlaYnNXTlZoSGdTenFiUVlIRmNkRThLR0lZ?=
 =?utf-8?B?L2R4SXRtWW5zNmhYMnpsUGRoeXdyUjFZSlF3d0FNekdPZXQrRjJpenRBRUU0?=
 =?utf-8?B?cnROaVJsU0VjaFBHMDdPUXBWcGdyYkxXa3p5MElibEFORyszaURIbDh4ZnBB?=
 =?utf-8?B?RStITG85Z0JEdlIxRDJ0UnUzSXpMVXVud0svOUpwL0RoV3dUWk90ZDc4cEhr?=
 =?utf-8?B?cE55MnRQK1dJcjJvb2RvYlorQXU4VmZBTDVlTS8wVUl0WG1uZWlHRmZUMXZ6?=
 =?utf-8?B?RytjbHl3WFY4VWJRSjEveWhNQlA4UWdaRGhGVVdMK0dybnNrdEU4cjE2QlFo?=
 =?utf-8?B?NWJ2QXRTSENYMzBhS29pNzdGUlBkSm50cmZnRVp5d0ZxQytZVVZ3K1JPbkpR?=
 =?utf-8?B?NFNBSzZYWUM0bjlsN2RpSG52WDNYdzhUd2g1V05OMkwxaHlGT0c3SzBTalhU?=
 =?utf-8?B?NEQvd0dBb1FOZVpQdjBORGpxejJMdEMxYzFQS1M0QndyZnpEdzJodmVVK01Q?=
 =?utf-8?B?NDRhbmw1a1VZWFRJTnR3OHc4S3dQNWN3L0MySS9sSTFTRDdsUWtiT1dZK1ZR?=
 =?utf-8?B?bndGUDYvR29jNlNEM2xGQ29sSFY5aVU1cWY5WFc0TUxTeDIvTTdabndxc253?=
 =?utf-8?B?UnEvUTFLRzlSOHZYdFBiUXV2WC9YNE5jVGVwd2dmUS9QNlBqWUlLWVZDMUh0?=
 =?utf-8?B?ZE9CaVZFT2ZMcWx3Wmg2c3lONWFFUUJNU0lBaVVKMzZrMWNlT2U5bXdpbDdC?=
 =?utf-8?B?RzQ0Q2c4YmdGaHliUE5Ha2ZtUjJPUXEyaEt3STBnR2Vrc2doOFhjY0dmS3hx?=
 =?utf-8?B?Y0JQbzR6Z3RvUlR3ZFFLZ0ErbUNGYUNMR1laMzcxVEt2SVdtQUZDRVNsSXFn?=
 =?utf-8?B?WVNtbGJSKzlMRFpma0gvUG12MnpkakxRYjNOSytzdXB2R054MGFyclZYV0Rs?=
 =?utf-8?B?QTFpcGhqLytFdXV1WVMrS0hjaHM3OW5EVkVTWG81K2VNVzR4QmxUNks0RXFk?=
 =?utf-8?B?WTMwUVZzMURldkRpZUxjMHlLSGpEaHJSNlEyNHFXOHo4NXBNRFU5dlF4U2c1?=
 =?utf-8?B?SU1MQlVMU2pVV01XMVZJemh6S2xrQXR4RHBQTzQrczBibkxOT1VtMUIrTXVO?=
 =?utf-8?B?ZVBQaGl1QVhWZkliTlpwcnQ0MHlndGZkb2dNUjd5WURsWHZXVEduaU5hZVZa?=
 =?utf-8?B?NTBmODZDN2NJUWN2Z3BVclAzMkhYTHVCd2ppdFE0aGlFRUxRcGlzZnlKVG5Y?=
 =?utf-8?B?Ry92VkoxdXo0Wm51ZzRGa0diZndFTnN4dHJZajFSNGcwR29TYk1vZUZsbVAx?=
 =?utf-8?B?VHdnY1VKMXdyaTFDZktkR2M5bTJhY2UvZ28zRzlwSW1jOHRHZXhhMFJscGVZ?=
 =?utf-8?B?a2Z3N1k3UDk1YnNxVnpScUVrcllNOWVoT1FRNDBIOTNMUUd5ajRrcnlnNjJk?=
 =?utf-8?B?VUZwZjcyOStrVnJoWlJkWHAyZ3VSK2N5TGFSNHc1VkVvYTQrang1dmJzOGRC?=
 =?utf-8?B?d0VWaFJCekEwbmlkZlFBQWlQSmhMZTRzV05QYVozY1UwaUdvUHA5NzQ1WGts?=
 =?utf-8?B?eW9PdmdTNW5vSWR0eTEveHN5bVJRZDQxdVJXSTNvTFJKVytMU3lyNThxZ3V2?=
 =?utf-8?B?WTl3bUU3TkFObjRCb0tLS2NtZEswRnpPbCt1bGdzVGNoY1Y1eXpCTENyckF1?=
 =?utf-8?B?NGpyYUVTaUp5VzlEUGVoYVI5ZmZkQVA0WGJsakhPOWJXSEE2UmhjU1RKQ1JN?=
 =?utf-8?B?NEE2UnE0Nlh4S1FjNkp3QlFzdXNFajJOSEl4NExtbzdXdWpYaUJqU29TVU5K?=
 =?utf-8?B?YjN0WnMwN2NmaEJSQTZ1TzI2bW9NOWRydy9Tc2VlOXVxaU52eld4MXlKMWJj?=
 =?utf-8?Q?BrjeghbobxnaTy2dv/9UloSKi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3147b298-4560-426c-ce8a-08dc214418db
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5470.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 03:32:34.0188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zo5zPmMz1ZMAjjlRRyrOXBbOqHbjwot86TMUPW7ht/Bkt8awm0VVxhJ7z4+/VAJomHemD3zth8u6IZJESZ3inQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6394

The em_pd_energy function name is obsolete and non-existent now.
---
 Documentation/scheduler/sched-energy.rst                    | 2 +-
 Documentation/translations/zh_CN/scheduler/sched-energy.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
index 70e2921..84b37a2 100644
--- a/Documentation/scheduler/sched-energy.rst
+++ b/Documentation/scheduler/sched-energy.rst
@@ -141,7 +141,7 @@ in its previous activation.
 find_energy_efficient_cpu() uses compute_energy() to estimate what will be the
 energy consumed by the system if the waking task was migrated. compute_energy()
 looks at the current utilization landscape of the CPUs and adjusts it to
-'simulate' the task migration. The EM framework provides the em_pd_energy() API
+'simulate' the task migration. The EM framework provides the em_cpu_energy() API
 which computes the expected energy consumption of each performance domain for
 the given utilization landscape.
 
diff --git a/Documentation/translations/zh_CN/scheduler/sched-energy.rst b/Documentation/translations/zh_CN/scheduler/sched-energy.rst
index fdbf6cf..03dedc6 100644
--- a/Documentation/translations/zh_CN/scheduler/sched-energy.rst
+++ b/Documentation/translations/zh_CN/scheduler/sched-energy.rst
@@ -119,7 +119,7 @@ EAS覆盖了CFS的任务唤醒平衡代码。在唤醒平衡时，它使用平
 
 如果唤醒的任务被迁移，find_energy_efficient_cpu()使用compute_energy()来估算
 系统将消耗多少能量。compute_energy()检查各CPU当前的利用率情况，并尝试调整来
-“模拟”任务迁移。EM框架提供了API em_pd_energy()计算每个性能域在给定的利用率条件
+“模拟”任务迁移。EM框架提供了API em_cpu_energy()计算每个性能域在给定的利用率条件
 下的预期能量消耗。
 
 下面详细介绍一个优化能量消耗的任务放置决策的例子。
-- 
2.7.4


