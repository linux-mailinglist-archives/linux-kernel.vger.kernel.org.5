Return-Path: <linux-kernel+bounces-161413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 190A68B4BAB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34131F21B3F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93E26A33F;
	Sun, 28 Apr 2024 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="I49xqpkd"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2064.outbound.protection.outlook.com [40.107.6.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940C03E493;
	Sun, 28 Apr 2024 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714306474; cv=fail; b=iSFHKh2VMBcOcKnvvLo1y53WvJ3tJYroyOimBDc0fqOv/t0o8DLDw+j0HqCfR1bWRzrGfk1uYNDisjFmi2duEbejwZYoVi/V0SnAPVM3Xc26uqi0Hq0Y2SxdtbqG1aQ5iwq4iN1b590Nb0j13SE4hL93jRfje9xCXS1MWJ33JZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714306474; c=relaxed/simple;
	bh=h5lZ1dXREKIO7TIqfsxsZcvv1x5DJJe8/YJ8j6UyWs4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=pDUytiEofZIqDMtksfZvYSETniL15k3YPqZnx3NxLb1ay+o3yqzTQM/SKU/qHCZnrD2gx0AkxtfZGEN4/EQLtrh3t5e8L8xYy0qEwpzGytYYmvnvlLBRKjnvblJw/cN8iAMh4i9FQsmgh6usFPzndveQ4km1daPIWf1UyIHvuKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=I49xqpkd; arc=fail smtp.client-ip=40.107.6.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fh0W5u4zDS7qIY58BYs8coT6NaeyRFPF3EA+I9VPZ2w/r3ONdxwzkTP7QiufNhs7x9DH7VCDwTYLV5lmGaYC182oOttEe2GZPxiEcttlCDPP8peGg+mc/spn3y6vYTLVCJ/UUSXsi/CDGNRw+K2rqAmRHGATzxi7OQEksshdFTJF+66AWi6mV1SJ+1o245+Azpylo4XhlqbzRemj43i51PqAsXnzKoE2m2V5MR/FkO4PgPD5DKVYF+NO1aiuOotXAP6LqDsi21SBV36NpAZgaucvIeM4bGHk6SsXIkqvy9J0ZrP47jqZRFiyAvgtM387igrLlPX5nzNHAiu/h2x9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJjMOCCkzb5KhRZj1/1C3TQxVFwNaqP9CKv8JyAxdtE=;
 b=B3BixNjznlouScJo8bzMKvlBmjKzDQiJqK+JsL+cc/ldyXlDNC07oaRUxGrhghcYkqhKUeCLLR+hDfhTEwTJadVkJJu/epb/4v2u24ag8NVrIU9bqS26x1L+CnODL5pvoj+Pmhh5fWzO+1PMzXHpXWuig+JdOk5QonvnMBRW7qd3az0sFyCwTo4A02jna3LCGEEimQ34bkiS6pJyC1Bo+gDw1/vqaoR04fJ1BQqFZfhw67Bl+Nbd25DGMK2YBI+5yfIGkC1gvJ+mmXkPaNnb1X3MaADOz79y2d0JrW5Uw9ChX2imcNoZhrMBz9Ky3hyYSOIN8XytGdubfYbUFQ+zHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJjMOCCkzb5KhRZj1/1C3TQxVFwNaqP9CKv8JyAxdtE=;
 b=I49xqpkd+7TGzmdkYuzTkz1DZ60y8Y45mkLGbXhiyutPdFFa25znoO4mBmO8dGB3I4Q/O+GsnKmUvssPur4j/dIewgC15q2tL/zrRHNDZEvpB3IcsVMpbBTBgHtREc0Rupa7Rbj7I7bmgGWBKLYLIzlJ7VFyPViYP2Q2V7+oPYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7018.eurprd04.prod.outlook.com (2603:10a6:10:121::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 12:14:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 12:14:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 0/3] arm64: dts: add i.MX95 and EVK board
Date: Sun, 28 Apr 2024 20:22:18 +0800
Message-Id: <20240428-imx95-dts-v3-v3-0-765395f88b9f@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHo/LmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEyML3czcCktT3ZSSYt0yY92k1FRTyzSDVFNTyyQloJaCotS0zAqwcdG
 xtbUAOkx+N14AAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714306959; l=1924;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=h5lZ1dXREKIO7TIqfsxsZcvv1x5DJJe8/YJ8j6UyWs4=;
 b=VBejQcGGULJosa3CLxgg/0cOhJ8G04+BRjYd0GxIEpT8mi/71SbD+GV4aW3RGZSgjtUIsiUdJ
 0qSPo1MK9aTAyy5pHcMLUZcopUOvxQlLm4Mi57v5MjjyaWwXwNs7qOJ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 255fc99c-fa35-40cc-80a1-08dc677cc0d5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1JzZERIVXpISDJQRUVuZzZoVW1tZkNOTWJvVHg3STFvaTF3ZEVqQ2d2ZjA1?=
 =?utf-8?B?Vlp4SjMxOXN2S2tKSUVaUlhReUJqMFdlQ0Mvd2Z4N3BpcTlZR3JFWUhaMXhs?=
 =?utf-8?B?bUJHemhXWUZGbjNyVHd2aHRHMUQwYWlaak1nOUc4ZkZTNzd4bFZxQVpZdzkz?=
 =?utf-8?B?ZElZVWI5VFdZclI1UWJRb25PRjJzMWNMTkdFN2cvSjZlSHJKL1c0RklpSmV5?=
 =?utf-8?B?ZXNGd0h6SCtCdllkZnE5WUZBczZjMDAySGI2Zlh1MHg1T0pnZVIxb2RqZ3hp?=
 =?utf-8?B?cFFSUjdyc2FoeGtXdXlnSlRnVlIxb2VrYlRpT2xZOU5kVTMvNnkzT1VEVTNp?=
 =?utf-8?B?eVJIQTE3dnBJQ3psNE0yNXg1RkVkWElvdWRPc3FLRU5uMXBqNW8reXE4c1kv?=
 =?utf-8?B?YXExOXA3cWxSY2d3T2pOdk9xVGhDaVROZzk2YnpRSU0vc2dvZlFWTDdkWXg1?=
 =?utf-8?B?OTNVbVl3emE5WVAxTlBWbG1ScGpHYk13cHYwRVlWY1luK28vMUJYbDJ3Rysw?=
 =?utf-8?B?b1Q2Ykg5VlZKblcxb09rWlBSVCtZa2c2Yk1xNGNhQ3NoTUhXM3lad0hqZmVh?=
 =?utf-8?B?RDlnajM3SmlINW8rWGJlSCswazZWMGo3eHBoOERvdlBwUXZGaWR0VVg1c0xv?=
 =?utf-8?B?QjFjajNvbm1RZ1l4WXY1MHhTSVBRcnMrTnhLNWNsc055bFkyZFJxM2wyMEsw?=
 =?utf-8?B?Vm1GaUpoSjl0cVZQOUdmaDJZeGxHaHJlUEtOSzE4V0RrNXNjSXJsc0RHSGV0?=
 =?utf-8?B?VWpzdW9GSWhOSzY4TnZQanJ1RE5BYndsN1h5VHY5NjRIRlRtOUJ5cGRNcGJV?=
 =?utf-8?B?MVdxekRQVFhmSWErTmg5SHd0STB1MkVQek4vQkV3aTRqSUFwVEkralI4N09B?=
 =?utf-8?B?TmJRUHYrbThmOXRWY21Xb2F5TzFSaHNTajVmeDJyNzFkNjdCbldOZ1pISGh1?=
 =?utf-8?B?MWdOM21oTUszT2FnUFp4c3pQdDY4d1N0VStDNTRGb3pPQzhGclF0cnpiaFhm?=
 =?utf-8?B?QjJlRmdXNDFvSkR4SEs5eTNaYjZYcDUwbEVObnlQNVRSclAvUzFMQ3dwMjRO?=
 =?utf-8?B?cXh6cldOZTI3ZW1LRHBzekIyTDI2N1l1blA4L0U4ZVRXMGo4UFpvV0RmQTZG?=
 =?utf-8?B?MGo3NndCRmxQTGkzcmNBQWJsMGNveWpnNHFMTDVpUGlGblFmdW9mQnlhT3F1?=
 =?utf-8?B?S2ZWUlE3dzJlWTNwNHIzSkZFdnlyL0FtU2NvV3VsU0c3VmtOYlRYT3NvOW5N?=
 =?utf-8?B?N215RG5CWHNxYTdEK1hCS0lPMTF4a3ltV1VmekloU0xKUWM0YjZoeFRUaEZ2?=
 =?utf-8?B?aFpaM0FMclRtNXhHSEZDMDA2b1lCR0N6Q00zc0dlQ0UzcGgwS011WUhVdXNN?=
 =?utf-8?B?SjhLUkgvZjRVRzdZbmRjdzZOSHZTNFRNL2oxdFVuZFlUZGhYRE5ZUEZaTVFK?=
 =?utf-8?B?bitaWFBLRC91c2Iwb25QSGJ5WG5MS0JteWpnOGR6MWdBaFZzMXdkOWk1K0U0?=
 =?utf-8?B?LzdDb0Z0OXJremxVOGhCdWM0VjVpb2pNN1d5OEh4SXVaM3RQZm5JR0N4d1hr?=
 =?utf-8?B?VjZ6c1pLeUpscVh0eWJQWWVOTC9saEcvbkRaRHltdFF0RzZaM2JRdERXaFdx?=
 =?utf-8?B?NDg3RDIzYUFMMDZvTlZScitTL2dVdUpGbmdlYTN5QnRiUDhsOHppcVJqMVEr?=
 =?utf-8?B?NXRwb0ZmZVh1bk1pNmJmTmpuOXlEVnJRS2EwNERkMVFkM2dOMFlHeURnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm53RkFMbnByR09GRGZ6cVBBamx2QUFrN2VEY1dCdC9vQjFuUFZ5aTdiaG5o?=
 =?utf-8?B?K2ZtRk1FSnJGMk5RUTZkQldJN0FoZWFKT0VWZVBGYmkreExQbEt3Vks4YXJY?=
 =?utf-8?B?c3kyTzhLRzFiVk1XYU9pWm5jZGdhaHZKd2g0WWlFeklONUNXSEFZYk9qOXVR?=
 =?utf-8?B?eVpIYVFXT01YYko0cHJmTGYzREdJRFNBcHJJaVlhaWlxMmhkQm80NGh3NDVa?=
 =?utf-8?B?clVqbllwRUMwQlJGWHFXV3JLdFQwUTFtQkdnS0c5OGFnMXh1clN1Q2NERHds?=
 =?utf-8?B?SGZIUmdHNTYvcmR6cEdPcDV1K1E4TjVFN3NFRDM5REhzV2tFN1JINzBhUkJO?=
 =?utf-8?B?UmJkYjdpaW9YTlNRcUdUWkw1K0N5TkVTVkVTSFNjK0JQVFVpdk4rWFUvZlBj?=
 =?utf-8?B?SXhiUnppNHFZZzVjeTBhbk8yN0RNS2p6Rk9VNVJqN3RMZFU2cjREOE1aMkl3?=
 =?utf-8?B?bXJFalh6N0s4TkN0aDVmcmtVUUxUUFh1Z0t6Q3pmOURlSzhRUmtTS01Qa0Mv?=
 =?utf-8?B?VkNNNlNsbS9uVXVZcS9tWTB5NzQyOVlua3JEY1N0WHZBUmZwWmFtYk9tVklR?=
 =?utf-8?B?WXYyM3VvV1ZPWmg0NW93cE9YRStNeE1QWlpnUHRWRnZZQnkvR2IrSXNaNnhp?=
 =?utf-8?B?d2lRMmF1QVViNHBrakxpcHh3V2hITTFHVk9KNGtyK0J5VUF2YWFBcFJiUHlC?=
 =?utf-8?B?VTFKRXRaaFQwTG5URk5jZ1hzOHBKb2xva09vRkNUcDRkK1VEYkRpNlh1Zkpl?=
 =?utf-8?B?T3RXZDc0ZDJ1cW9pUGdINWNUdTVoREQvOEhrZ3JLdjBDMXQzRnFtSHNCOHF1?=
 =?utf-8?B?U1pQdjFRMkRLdWRrckVvcWtjVk1iUkFBaEgrN1BhVmR1R3g5L3FQamkvUkVj?=
 =?utf-8?B?Y0UzQnpXQzBBQUtCdkV1OWVhWU9Ta2JaVXExS1pLYjhDd0xnUEQzbHVjZks2?=
 =?utf-8?B?UjR3Wk82enJBRTRUWU1QRUUvYTQ2L1VtSzUzeGpHSUpmR0RuK2JEUVRnWWZk?=
 =?utf-8?B?dkNJdHdOVFBBWkZ5Ty9DYW00STQ4SWZndnIvVjROVEppQndxQm9DVU5uaGd2?=
 =?utf-8?B?YW5BQWJTUE0rZG90a2dKb09NMEw3d1N5RGV5b0IySTYxZ3pPQUdhY2RYK2hJ?=
 =?utf-8?B?WWgxS3BicEtvUVUwTjB4UnJQd2crMzRabmtzdDVpNm1pNXJWRGIvelVmcWR6?=
 =?utf-8?B?cUdmTGRLWE5xWmFQRXYrYWpRd1dyNjdNWm9OSDlUZEc5RWllODlPUG4wYklv?=
 =?utf-8?B?cWJqTjZ5ZEdxVlN5RnZTV1FQeWRMUTVXeXlyVDdTUnNmSVhnNjVKRXNPdnJP?=
 =?utf-8?B?M0tKUW1FcXl3TFBSZHg1T0J1THEySXdkQTQ4bStpSE1XcmRTTkhOeEFnUTZU?=
 =?utf-8?B?RGJEM0l0NW95TTA2RTNzcGcxK3BBNTNQWjB6V2VvMWkwN2dkeks4QzE5OEhS?=
 =?utf-8?B?K0MvaWJ1N3pxWnB3TDNBNEJJckMzYmJLb0EvdHRER3pPb01lSW03WDAxUkZD?=
 =?utf-8?B?Z2piM2V5Ky9jcGptVkk0ZE0rUGoyVWRodCtUa0NFeSsweFJ1bHRjV2RvNUxJ?=
 =?utf-8?B?QXBzOVR0N1Y2TlZ6d2QwVlpzdSt0QkloOWQ4NGwyRi91UlZmcWhUQ3RPUVlV?=
 =?utf-8?B?R2RPVzFzTXZ6ZENHd2NyaDRpMW1ScmdTOTFpZlJaT1JmRmZqZFJYU0UzQmZm?=
 =?utf-8?B?QmxmSktjVzhhQlpKTXpRZjhINTJreWdDdDFudkg0UzhiOVZ0enh0aWhGOG9Z?=
 =?utf-8?B?c0FLUmg1bzVIYXkzUjltWWE0a3haWGtlZ1czQTA4b1FHeGkzNCtSZW85eXYr?=
 =?utf-8?B?d1pUZExiYWNyKzlFNnNyNW9EdlJFdXZPeUJNdFBGOGhtWG9MWU52Vm5GUmRq?=
 =?utf-8?B?OS9nSEp0Vk1Gb2FJa3dVMzRtQXhIZ2NPNzhaSDY1YjZ1MmI3T3RqVy9sZTJ6?=
 =?utf-8?B?emJ0WDVFR2FVakNWK2R3WkJSbmhnek1nbitvOUtQNmlZbVRiYldCaHpZajJj?=
 =?utf-8?B?UjFGbXByUG5OVmdIMi9IMHprOVVoMnVLWG1YbkVCK0NsV0l5ZkFYMmpsQmtn?=
 =?utf-8?B?Y2xyU3gxSllBSis1QXh1MGZvakhSWVp2UTJhdldKczdDbkd6czdBMlZsdDhB?=
 =?utf-8?Q?XGwpBd4MeHOZUycdktaG9P0ZQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255fc99c-fa35-40cc-80a1-08dc677cc0d5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 12:14:29.2577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+2aeSXO5iAKbEPOhYBcS+arhv44yGp7VmOOfdOy1rKrDetpcNcAy1/d01f65A5FSLrIgsD7lZuPaogzTeCgpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7018

Add a minimal i.MX95 dtsi and EVK board dts.
i.MX95 has a M33 running SCMI firmware, but as of now, the scmi pinctrl
driver still not ready for i.MX95, so we count on bootloader to
configure the pinctrl for lpuart and sdhc and it boots well. After pinctrl
driver ready, we could move to use scmi pinctrl.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Drop irqsteer node because binding not accepted
- Pass dtbs_check
- Link to v2: https://lore.kernel.org/r/20240226-imx95-dts-v2-0-00e36637b07e@nxp.com

Changes in v2:
- Addressed Rob and Krzysztof's comments, and fix dts_check issue
  To pass the dtbs_check, need apply:
  https://lore.kernel.org/all/20240226070910.3379108-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240226130243.3820915-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240226130516.3821803-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240226130826.3824251-1-peng.fan@oss.nxp.com/
  https://lore.kernel.org/all/20240219-imx-mailbox-v8-1-75535a87794e@nxp.com/

- Link to v1: https://lore.kernel.org/r/20240218-imx95-dts-v1-0-2959f89f2018@nxp.com

---
Peng Fan (3):
      dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
      arm64: dts: freescale: add i.MX95 basic dtsi
      arm64: dts: freescale: add i.MX95 19x19 EVK minimal board dts

 Documentation/devicetree/bindings/arm/fsl.yaml    |    6 +
 arch/arm64/boot/dts/freescale/Makefile            |    1 +
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts |  111 ++
 arch/arm64/boot/dts/freescale/imx95-clock.h       |  187 ++++
 arch/arm64/boot/dts/freescale/imx95-power.h       |   55 +
 arch/arm64/boot/dts/freescale/imx95.dtsi          | 1152 +++++++++++++++++++++
 6 files changed, 1512 insertions(+)
---
base-commit: bb7a2467e6beef44a80a17d45ebf2931e7631083
change-id: 20240428-imx95-dts-v3-bee59f0e559b

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


