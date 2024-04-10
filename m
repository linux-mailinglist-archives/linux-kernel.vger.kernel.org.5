Return-Path: <linux-kernel+bounces-138450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDAF89F173
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98581F256B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D858F15B135;
	Wed, 10 Apr 2024 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qft1b2Jr"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2137.outbound.protection.outlook.com [40.107.93.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B1F15A488;
	Wed, 10 Apr 2024 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749915; cv=fail; b=QsoOon36X+R30FW2yJxHLPUgv3dZ58E6NPXhwJeTxpOHwgd2PLAftf11caZpWfIKA6buR1yyXAi37aRJ6SzwvNAPztQSeeE0pNXuW4qsXxb+9DMJliglbho7atCmrtogwmdJiT8dldn03rHlShgRdaMDiKLw27oBPDXkeXNCXUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749915; c=relaxed/simple;
	bh=jDGknkImE0wrOIOAXdaKN0l7NduDulYeqoHsM9A2DOE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g3GCZY31oHRey0BS77ibRDzq+x/wVegXpXk8cGSEaqjUotyHx/IbuN5ZCfxohDrZjHY6i2/OHdHD8aJB+zQu64NKlMI9dCOd5dK8U/KaIP2ofT6SYgDz17dPmpTqrVat1EqDycCEupAv6LXdArqTo4tbzQMRn6iB9KH2A4fXTgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qft1b2Jr; arc=fail smtp.client-ip=40.107.93.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvbWY/2GD/EeU6Q9tBQdKPm5l0b1a57bIrgzQh93XGzon3jjWUHp2zBBEleUARH2OD+uw4al2SfrpgczRBPBtUjErwyTGxoSqiVan9mPjGDKCPr/tuJhxv5AYqLrb9AmcNcPZakda9enc74MWM6yR1ADbqcRf1Bi72J6qD7KTLaheQT2WUO/eEwg8Y8+bxLKmh/cyhbvCFabNHyeVj3ee8fwWFQSL7EC8FCsomdsy2j42KRJNuV2IdGBGEuRwTfe7CNqd1UEJATJLUVdc2bjrAF5TTA61q1AvsM5qrYQWKfCEzdCNRUz36v5NeW8m4pqXoE89qDcF6URDHT5ByYgIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6mXdkoXjmTWMQKDs1EuJVnps9pVubJ+upNSeiqqXE8=;
 b=Dl9T0VQxv0cD+BEu3Kg3vt8NXvRYgYIfXa5Sbtm7jkYnztyPmaD79NpjCgzweNWB3IO4KTr00Q+zgCP2R8AowBX/5eC063Uquex+6fhEDpppR6Ds3fyq8U6L3KZHLZLdT2hiy2Mtp0x1rhQ17gm5IjzVR8AN9/byEa6or6srI9WEakVvE6LWbdWkCpODzrKBFSYrq4NQo+wfmMwJS37rqz+w5Mm3KuKqwSbKCvm5Y4PQUIYIdiMbIhQrZ1klgZTjAEOVR3V/rR0tbRyodMjmsucy2nHMzvFQS3tR31IXRykQbp5CuVGxCxvLwMCKeE7EgTVFQMFTAdViOv2kt/tHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6mXdkoXjmTWMQKDs1EuJVnps9pVubJ+upNSeiqqXE8=;
 b=Qft1b2JrfL/QsbJVRJodRfA25kp173/55688QjYVGqfwrW5jIjZh4tvmh9gOCml8ghS26+3qGlzSaV8yW7X/7WPXDS2p10CaTTxb2fKcaHWF6eDm5rM9zEUGW8jDC7tic+jpA9+S4Au6eMt49wYKpnUO62/f9pYIaXbgNcsHNh8=
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 11:51:50 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::ee44:e235:d5d7:94a1]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::ee44:e235:d5d7:94a1%4]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 11:51:50 +0000
Message-ID: <ed7925d5-f7e3-3de8-d99c-663877d7d04c@amd.com>
Date: Wed, 10 Apr 2024 17:21:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: BISECTED: perf test -v "Test data symbol" failing on Intel Hybrid
 systems
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>
References: <ZhWTIuyB9p1ORbQH@x1>
 <d08f02fa-7930-0d48-0f60-2520f890e7df@amd.com>
In-Reply-To: <d08f02fa-7930-0d48-0f60-2520f890e7df@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::18) To DS0PR12MB6584.namprd12.prod.outlook.com
 (2603:10b6:8:d0::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DS0PR12MB6630:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kLW7bpATSNoenjOQbEsNa1w2s+xymYiB+N8eaf28K5C6FKBq84KiykdzK/ItB3CO6J8A4wRAUdeUVPw8ycbOKoj/Oqad3N8WsXNGeBAFWN51aPIPiDohau+TCnnwfJ11Z7RHcq4mhfTFlw2S8DWxMLRU8P2wlVG9rcZFPfL+6W9QLIWaYRj2LMBFHhsDMZrcAF9kvP5p4g8RHXBf40pOz/dgrrcvPpip1dG2HQVEQlCwUoRsguLhPUfk3Tc0hZ6w21bp0d+0oJIvXNGe7Y9oPvdI1eOZBRifRPkNs+esRZTV7aSRuLdNtvAVtoKuP9sRiSX4KunamuGwROtkQwn7V/hUDRaY8jw8/6UussukevIo5bFBQlwOqFWwL+6JIYIbOAmdYXrZFybzL0Kl4eWKs9sE6uY8WJJtwYD9Z18o3LmcBGN1QvikoTEPd1+e+Vu1Q5Txe7+fx3CDjIUJ1E28Okh56JGdBJ81vj7zVR3VH3xJxVJdI1lWYvVkXG7fOQ65Dk18peR1LhJrbD08LV1SOTpAOk+zuaEKGTIXfl5XV4fbbpClbLo491lEeyRE4aDrT8WuGo1rai76OOaeEIfK1qkop7sJSasA2wio9kL25gylVcbzyH92uTQxiNkjjhs798lq160Ypt3/5ZSIWk+r/jYNOf7l/oDXpL5hMUDQoBo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1ZBQlpveDd6ZVpTT0dpTUkxNlpxQng2czI3VGF5RWh6Um95S1M5aEhNV1R1?=
 =?utf-8?B?bDJkVU1yQlBhaDJDQllySlVhWXhGeHlVZFhCTTMySVJQVmI5RWw1clo2Z3Yx?=
 =?utf-8?B?bE1QZVFrS0dOV3c0K0ZvUGZYbGozV1hRRGNOeXlGQlRvNEVpSmwvVGhiSExX?=
 =?utf-8?B?b1F3TlNKS1RWZVlzTG5LbmFFWWtVM1prdWJaN05QaUI5N2ZwVjMycjJWTWRE?=
 =?utf-8?B?NWFSNUZNMXNMZzVzSm9wclduVUp5bVhDRzRrVkJxelVYcm5sS3I4aDFmQm02?=
 =?utf-8?B?TTZXSi90YzdOTFVYYTBhcG9FZ2xRcWxrWkh2a1V2RW1PUzg2Nzk0WGx2Zk4w?=
 =?utf-8?B?a1JwUVpnQUk1UUlyUHVjc28wcEgySmMwWVlCZ0lJMnRvQjcvL3FDbFZvMG9h?=
 =?utf-8?B?d2tXcDRLbUFYSUUrNnhpVmNKRmh5ZHBvejZYb29BaEhaTU9zMlZpb1hpMk1E?=
 =?utf-8?B?dFQvWkRiOWU3d1pDZ2N6eDJ0TjJmSFV0ZDljNEl5ekgxVGpHMkFMcUxWNG1W?=
 =?utf-8?B?eWxPK3VDUmZuaTY2WlZIOTgxR21tclZ1aUp5TDFjTGRtRkp1WXVSamgyaFZi?=
 =?utf-8?B?YzQ2OEJHNDRkUzhuNEhCNXdqZFVOczBIZS8zTEx4YlpPQXBoV0VVV1dzdUNq?=
 =?utf-8?B?UWxMdXE0cjQ4dE5sdXJrQTVwSHBJTWxmK2JBRlNaOFVwc1AvVVEvSERaeHRY?=
 =?utf-8?B?L2NCTlpYMG9tSTcyWldzY0VGUm5CZjBhVitKMlVVOHNHUHFjL2VGQ2FTZ2Q2?=
 =?utf-8?B?TjE1bWRCTXJzWjlzc2FSUkk5ZHd4OURCVzYwQlZmNjZXY0pNbGtpNW9jRW82?=
 =?utf-8?B?RmxGNDhnZlNVMEFQemdrSDZVVzdWbEVkdXlWWXR4ZEJJUldidFd5Lyt6VW96?=
 =?utf-8?B?MUREMlRXSmd1NFdWRkIwT0JmT0FmRzFycDluazBOdVE3b1NPNGNYNDc2MGI5?=
 =?utf-8?B?WU5Tb2J2b2M2UUpIN1NvUDF2TkF5WDA3T00wdTVoMHN4Zmh1TEZUdDJaMEpB?=
 =?utf-8?B?ckdZeWFBbWNpS0ZJd1RJTExodmZwYmVlc2JaQ0pGOGtTd1NLU2JBYnpJOUo5?=
 =?utf-8?B?V3hGdC9sQkFPMldWb2ZiOER5NjE1OHEyUTdqM1dTdmdGMDVCSS9ZdDg1a3gy?=
 =?utf-8?B?MlhkSmRpVnRIbXVSOVR3NVhFQW1hT04zYVBTV1h1ZHQvNXV0ZXR1TDNZMytZ?=
 =?utf-8?B?a0RNMEE3VnFibmdkc0RhN25nNTNhdUNyTERtVjM3QTljamRoQi80eGlSQ2FC?=
 =?utf-8?B?QWZ1RGVhQ1JKU2FkLzFlV3g4YS9uZ0JiMThGU2N1VSsrZStuUi8vWEdjTVdu?=
 =?utf-8?B?VGJENlM5RmNnNjVrYWxUQS9ON1cyNW81RkpMUXpseE11YTdnOS8vUEhCSFFq?=
 =?utf-8?B?UGtjaWRTV0lLTGFjR0JRNWFXOUNaUlFLOUFDWHBkT1IvRUw2ZENNM0JCejJR?=
 =?utf-8?B?eWpsT1lpdU5Ua09WcCtXOVVFY21CYVFBdWhhTmhPVHdRaVFyUHVPWnZvMzdx?=
 =?utf-8?B?cWIrRFRqVUJ3T0lTM1R6NlJUcGkxVG8yL2swUTZEUDlvOXd1cXVoRzhFT1FS?=
 =?utf-8?B?VFUyVTIxSkUzajVHanRyRWFuN25RaUxmVXNSTk5XRFhBbWV0QmZtd3pFTFNw?=
 =?utf-8?B?SGFQaFpwVFd4RURZTFZhV3JTSHkyUVgwSUgzeTdYbkJaRjBzTFNXL1JiTUln?=
 =?utf-8?B?TG9JSnB0QVJMT0EyUUlCVHAyVm1SUEMrVGpyc1ZNdzJWZVRCWXZyWldrNTNX?=
 =?utf-8?B?dWgyaFJ0WjJud01Hc3pDZ2wzOFU4OCtJUFg3anl5YmpLSHlXYUxRNisvTXR1?=
 =?utf-8?B?ZjFxZDZ6UGwwMTVGODlZbUxuaWhaZUthK2Q4TjROckpsc25NTzRaOXR6c1Rz?=
 =?utf-8?B?Qnhyc2tJUkdaRVFvc3NlZmNvMHFhTllNanlid1YycTR2bjJvSWRjSXNFck9C?=
 =?utf-8?B?Tmpsa1ZHRTdaN1RKTCttVVl5cG9va3hSNXZRVDhjQ1MvL2Nnci9WODFWMnNw?=
 =?utf-8?B?dXlCMDdQSW5VTG5LbFcvcnI4aUhmZTZGY1hFaEc5UXhXTmlGTW1pRUFBemVS?=
 =?utf-8?B?TzdubWF5YjZkWEF6REQzMVgrT1lRejlkV2RqUFZIemhEZUNMM0VDMk8yc2F6?=
 =?utf-8?Q?W7NKvlX48DVldZJz/RJCRoCq8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46a3837-5c4b-4a39-e701-08dc59549a72
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6584.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 11:51:49.9282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VXxlRbB3Ki1VctCQIRxv1HcehlPSLprc8Gd8g0oeyetgqTPm6tQ+iWvMA19PdeNr1O9kbhe8v82tFqiMESlxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630

>> root@x1:~# perf -v ; perf test -v "Test data symbol"
>> perf version 6.8.g63c22868714b
> 
> Which tree/branch? I don't see this commit present in latest perf-tools
> tree.

I mean commit 63c22868714b

