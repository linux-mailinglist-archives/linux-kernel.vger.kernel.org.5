Return-Path: <linux-kernel+bounces-73986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D3885CE81
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E27B2852CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981142E632;
	Wed, 21 Feb 2024 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="B9IoZpZS"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2084.outbound.protection.outlook.com [40.107.215.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453302B9CE;
	Wed, 21 Feb 2024 03:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484465; cv=fail; b=lfH+cz1dgSNG+FkPcHw0jwWgXKoHBPlYrJZHL+ZGESqUbAnjgL9xK3F3JWsoLZhmYDboN2KjiNVKnm3Bs5S/ZJs0neb65QjsoJn1EzvF1vAZyJbw9vP59evX/gF+QmlhKDLeZyY4DVRdlvgylgmVzq0fB6N/HGNrrgYefj8Hvfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484465; c=relaxed/simple;
	bh=C4s6zyipUh9s3Y7UMW9Uv+cFRpRArfixanADyfEpmm4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X5C/jt0+CeDmbbh5RdCf93eQd4dZRWW6BuxyZgULAs+7TSa+rqPKkguW/Gs6X8Qa4/ahOiqhs3HezOzqEToV0Zwh+RxppVlto6Lav6bQdbO11vHTyuD9B2QDI/TG/XUNMQ/G5EyRGSf4zn+TrAiJp/MpALm95SIQBQXhQSBPgf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=B9IoZpZS; arc=fail smtp.client-ip=40.107.215.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nN1CwohS8aPlL+Fu34uw/S36AOLWeGJMbX/1UZYHkLeoCA5g10rGy49WaLr/Y4a+T6tD67sHyC4JFC9zGaWRBOUn96hlTrioGtLW/kBue2BvOU+uMlYth5PVr/yJVgpKMozO5nbi8hf7koNg8Tm7RKW2LRya7nfd8xcUhtNiIBayMWGNG94VX8iC79KT/odcv7FZHo79ths5XixsWNXfeETAUapU9YcFCzohPjqSVJXyEgIgCZYbIMD5GwXwc/ODyOZhG6LxVX5BTB81NNhNkrsEReqUjUZ8Cxos3rc23uTha+gTVIyyMS3iRw4uzRYq/Te6vKkZsxWe33oTLhc8vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4s6zyipUh9s3Y7UMW9Uv+cFRpRArfixanADyfEpmm4=;
 b=Ae1wRe2vPyJtcT2jgfg6+9eDSd7/LCgxYUDJ+STHfwkp2VXWQw+13yfcnXRbuCuvBD/a2Z4TgMZzIyfwvTJfdn2E16Tbg5dZHYuNmV33Cm03fOumfbmbZF5yuJ7HJUX10/XAyQeuzPMwyWlNPHK4lhuozn7pZ+RKJMoSDb1XqYJPtvWOic8RmCerDDHGdiwqSTiK/H8tc+GuM1Lihkkd4i+6q0snXl2qhAP/nxPS0s/P9XTdPURYghcsRSI/PhnmOmGMEXH6ZV0s1tXQZY9YXMQRqcVZQHYvp5X2D+spA4enTWRZ3ZbPp4TsZua+cXQfplydSjSrwyv8NZe9+D/R+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4s6zyipUh9s3Y7UMW9Uv+cFRpRArfixanADyfEpmm4=;
 b=B9IoZpZSAERyIs9JJIBKEOvt5qXOitLglvlLHSQB7sTQgyGgz5F5qBMNubRAF4JgB5NQFpkcG4EH4Ac5I+wlRRfVUjbjNDtxbi/65YXyVf2+R93MRbNbz3n7TniufdsCb7tjBVGxFSQRmCB24fasgNbOhAiDCSGOJB7Z0A6kGVV12SIi5zcxXEZFpG2ywPG1/yHcLVMhIVfvZz9FDpsWRg8xZXI52k3aUTgEMiWt7mbS0bwtI/9iXIjhvgdbcrsgXSdb6pFMdC/PkwL0CJaPTsxSlF8CtyyRqAAmalp4DT8pbsXg5rUzVjk1NTCer+gw7qhU8YtdBt6rmW1oLFukrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by JH0PR06MB6850.apcprd06.prod.outlook.com (2603:1096:990:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Wed, 21 Feb
 2024 03:00:58 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::8865:1c6c:513:4a68]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::8865:1c6c:513:4a68%6]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 03:00:58 +0000
Message-ID: <3d4f44ee-f533-446f-a9e6-7f58afc78d65@vivo.com>
Date: Wed, 21 Feb 2024 11:00:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v6 0/2] Make memory reclamation measurable
To: Steven Rostedt <rostedt@goodmis.org>
Cc: akpm@linux-foundation.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 opensource.kernel@vivo.com
References: <20240105013607.2868-1-cuibixuan@vivo.com>
 <fac8d079-100e-4b8d-9a35-db8219b28b51@vivo.com>
 <20240220212202.59ddc123@gandalf.local.home>
From: Bixuan Cui <cuibixuan@vivo.com>
In-Reply-To: <20240220212202.59ddc123@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|JH0PR06MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9b5497-80c4-4d2f-f539-08dc3289540c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bwhVjs2HynftN6KgAKj+ZO6p+XcIAHlnlfSUaVWIPlCFI9TqfPwbzKW0vXHVZRpg9cuXEiq0sNuddzMpVFZgFxRuuwgSgHgar3FgzGYAQqnxsTqOLk8xD1s7RCeilM+SaCorov3igM6US2yFbPPfeqQBR9G6tjd2tR2mrZDBm9LowppnMOj9wq7l1MCN+VCmBK1dMom7iNfVJW2k9g7vWIzpapfa/mqtCfuMYzjvSMOh6hQOMnruXXv3lfHtRN65zyfBehkQCGreECBVnwQuLYGfWA37wa41k+cDsnJIvaGkI8V1Rto8A/Pw2ePlIfRgg3aZsOl9FkmOSunFVq0Yg3i5rApOFwL8vxLXvIUqzWUMGXetzMZvec9l0ruA6ci3XqI2eUMMNtDceZHE03cAsGlbryRdCI9hfLNDSxBpFZynCtJNy0vsYZgGRfRoMLdYaCs61hy3aGlXyE7g/1bPNsQZfGwvC0dqKjssdo09tygaAP1BVGX+FkXVhZfd5MKH07mCQIedW2Bo2hJPxSSF0ZeuOfuFziYoDyOxgbS4BfIGWpcZfigsYcQV1zH8qeiyLZ8/sohI1I1BtxnNsTdAqy/h3g5QSxeReCGR+MQ/oonwUUqenVX5NE66fSKsFDaD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTFTZkVxUzBaZW9yNzZqajVvVXk0RzlRT2crTE12WWs0WU83RUFQSE01SjA1?=
 =?utf-8?B?OFMyNzhIYkorTjJIckVGUkZXWU5zUmV4RHBrN0hPQ2dTSEVPcTl0TWJyUHlO?=
 =?utf-8?B?a2dTQlp2ZWVCeEwrUy96VFdlL08rSjQ1VHZMR1VnZzYrWXRNWndTTno4MEww?=
 =?utf-8?B?MEZ2ZE1SMkV0SkZvaTREcXRMVmZhK0paVG1FSCtjbHJ5M2xPNm9PVlQ4alM2?=
 =?utf-8?B?K0ZTWlZxZVNtVU5zbnlNS1FNUG5tTVU2bFA1ck9YVjh0Skg0NnAwUVI1aGlw?=
 =?utf-8?B?RGs2U1k2bkF1cVdUaStPYU9kOWxKaUJLbDhidXM3MnN4dGRtYWFRUGhLNk9G?=
 =?utf-8?B?c2tQUEFwNklEd1NhVU4yeGU2R3pCVmx4enJRakh3bXZnMzY2QUR6akhFdVd6?=
 =?utf-8?B?U0NQeW5sTjlwaG4yaEZiR0haUElhL1NBVHlncEdkLzJFRGw1MG9GODlMSWFi?=
 =?utf-8?B?U3NaN3BQZWgxUDVBcU1jckVrM0hUUG9WdmlXdExqNFRQeVh2Skd0ajIyYmFQ?=
 =?utf-8?B?UFFjWDM0SUgwV2tQS0h1Y2o4SzVETStTNXArZzN6OFlyUGJSTE16bkRnUkdw?=
 =?utf-8?B?WUpiVjRJbFh0elVTcCtLSU9COUNYL1pWZGhQVzltZjlPQVZPU3pzc2lMbUho?=
 =?utf-8?B?ZGhCYWQxSEFSKzQyS1hNTWtTcDlrWjFpcERGM251b2syUjh3VjRLSE9NYTBU?=
 =?utf-8?B?bzVaejJ0WWtJeUdTRzRJTkR2NzY3WS90QkROR0pLYVgrTjVKam1rR2hyL1VT?=
 =?utf-8?B?aGZZd0NsS1UzUk1yUXZBRzhCVGZZT2cxVzB0Qm5hODg1RUkwYmhNelQvcCtE?=
 =?utf-8?B?dzdYS1R5eit5bVdqMVNiTEtlVVJoL0pFM2N1VmUzVUxYcUZ0OFFHN0hUVXZO?=
 =?utf-8?B?THdKMFZ5QlU4NGZmenlHRmhnODkvc0Y2R1FVaE5BL2dybFJsc1Y0RFhqNm0v?=
 =?utf-8?B?M1gyZjc0L1NGVThhY1NpK2lRalQ2YWlpUlNyQnNCSmtBSzBpRzNxaytHV09l?=
 =?utf-8?B?WWFMK0lqVUhDWndTYko2N01IWFRyZlZZbFMxQ3VhbEZTRTBtMFdST0kxUWov?=
 =?utf-8?B?ZkU1NkNneTRaSnFlOUhlM1FtbFFISGVjaFVleU1HVU1nY1crT3AwUExMcmM2?=
 =?utf-8?B?YytBSU9Rc3o1Z3dYa09qSVhtcWwxay93dkl3UkNBU0QxRkZKZEErS2FUcm9z?=
 =?utf-8?B?QlZCdHZDVnBiOTBHcXFiSHRiL3hOUW9ZQUJGSW9yWCtJZkk3UDF2REcxZ3NR?=
 =?utf-8?B?Yzl2NG9lY3EwekJhV0R4N0tBQmJlMkpTR1d2b3ZwNCtYTlB1UkJuUWZBbDFV?=
 =?utf-8?B?cldUMEJYMG5hTkNkbVBEUXUrNWY3NE1NOTdaSkM4eFcrWU1YUDhSZDJkaGJN?=
 =?utf-8?B?Vm5HNmZETmx3d2E2WWZLUXZTMHZMak4ramVHUXBZL3FwYnhXelNtbkVSclVP?=
 =?utf-8?B?d2hyZElVRTZOYitLWGJNeU4yZWY5VTlnZlQ1Z1IxU3dhenZhWXpaQktuVDZq?=
 =?utf-8?B?bFp0bGJ6QkUvdjZVZnJZY3A4eFVaNFUzRlcrRkNXOENrRnhyWi91RGVubTZv?=
 =?utf-8?B?ZnFvME4wMTRVZm5QRWpxZGdUblV2RXYvVHd6a3hJZjR6Z2ZjVWd5ZnQ0eWZO?=
 =?utf-8?B?cU80Nk1UK29zYkxFVm8wTm1XOVdxUFB3YzRlV2c2REk5bzRVeFFEZEJGSDZ0?=
 =?utf-8?B?RUFiOHpGWTFMU1J5c3V4YkplY004Z0s4K1U4cWdKdVZNeUl4T0lGUC9yNkdJ?=
 =?utf-8?B?TENWazNTeTVoK21KSFdEcFpvTUhzVGFPYS9RS2NXekVYb2dNMXU3VVNOVGVR?=
 =?utf-8?B?STBzSzkvYjZPeXRkVCtYQ2RaNXMzMFRQSnlhbWRtLytHZmtTVm1STUV3cm0r?=
 =?utf-8?B?TWdUV2kxa0llbVZzcXlhQmQwZkpmNzgzYUZLd2YwSjhFRDNpa09vakhYWTZD?=
 =?utf-8?B?RWlQNG9MVTg1cnBjVFVueXVYVHNudUZYQmxiaVlBTnorRy9GNGpRdm5vNHor?=
 =?utf-8?B?L3Y3eTJZWDhTYVowR2hVWG4zSlBieWRhSlRuT3pQbG1JaDdmYVVPL2RWYkk4?=
 =?utf-8?B?WmJ6aEorbW9HYWdVb3BtWTg2Wm9EY3BEMGdkeUViSWNWdU0yZThHT3gvVTN3?=
 =?utf-8?Q?d/oYaU9I+Y+WC7+hS7k3on4wU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9b5497-80c4-4d2f-f539-08dc3289540c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 03:00:58.3782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubbp7UMzb40FKMBVub2tRN47f/KrGFc0TjxnSlWm9nvLXFiED4l3P8pRfu9rXGglUOgmTDbnH/L3PpM9xQtHqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6850



在 2024/2/21 10:22, Steven Rostedt 写道:
> It's up to the memory management folks to decide on this. -- Steve
Noted with thanks.

Bixuan Cui

