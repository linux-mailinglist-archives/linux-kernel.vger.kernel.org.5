Return-Path: <linux-kernel+bounces-93337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75C1872E36
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458F81F2640E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1403E17BB9;
	Wed,  6 Mar 2024 05:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kkf53cDf"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0BCD502;
	Wed,  6 Mar 2024 05:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709701810; cv=fail; b=c9v21O6b4Lj2kcPsIlA/Qgy3d2fWzfg8yfn+N5Km703UYWVAa64+wcv5qgAPw0azyhTHRgH7ebsUnIgbDk+HZ5cO2uMfIOlD95cSmaP6jz6C4mVr0+7ISOwVFJepzHaW8Nn0r6Ucr4WkCL/uOtSVeBVzEnhq1FG1QF9Dmuax75E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709701810; c=relaxed/simple;
	bh=wc0Yyb7oUJBNtVw6z1fuDAK1aEDLjGLj6JIGStSSrYc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fo8+aO6oTcFMSwea+XAEiF6KmJCd2AdzFUJLXJiM+gDD+tUZYSHVAX73qzWT+POBlhTovxcAV4xUO3ln61kZwMl1T/AmnHp7dAd1rlb+6dk7ON3fZOYj9ZV/deVhxrql/8DNV7UVCPT0l2hmZ4Cn8zr+0Eqt/kp9SZol4QJX0yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kkf53cDf; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JK1bmLobRmedNpwxDTRDHKMsWeLg0WSmodahVs9lWpaMD+KDvzFLmo7kbdLz3HxOwnaVThMAEVFotKnFoU8ciGR4M65SjHF6EOKUuVjAHLDEJcNqq1cvUdUg1liIZG+A2eItJFn9V3zImcGhllrWnpIHXWy3Plj5spllCrj1xY6G3nFMaeDfgl4I6FVAf2HSdzMTYELrAit52Cd8blDd2Om76EmQrrmDa7NFMLrGavTG56Y42pGEQHIBW8ysQgAxfP13Bpij++brqMz6uOlQLVkua/Zno+y6ZEOUOERTqkcGkpYAy+uxKOCgeScyhUhrf3/WgdNUiuh7AKKgpSqWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoI/E+p30EoZ58lEm7MdSuHeV/BOcXkJBR7n/XHtctc=;
 b=ezXv2cX4Fdti2V6E6zx5Xa2HyGdKoQgQ6Zgpgxh36G2HuYMCTBBMGN+7+7DoQycflgABnX1YXl/2T2ZKjnXY0o7aNGJpHd1MouoC6lmUOeT2TU6eslz5va+9etONKeD2klQ6iMhyL2Kh9SipEj9XVZmDhp31reu6wq73w/4Brjhg2hEXhJ4ySkQZ0V4c9bCxD1S1hQE7JCnoEtOcqyr42fACFpGjxq0WJQTZeoY+pT1L3a71a2Y1BCBc3bCk/wLjHDOl0EtBNiUsi/0/k8GNqYvqmQvWY/2LIarm9ScxUVsH9qZMar+9y9317nJ9Ty7G6yp/IyuKzDW75FexhcLtGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoI/E+p30EoZ58lEm7MdSuHeV/BOcXkJBR7n/XHtctc=;
 b=kkf53cDf6mNn+c8UowYJYoidMHX/sHr/AAryCuierIdEMH8dKJpWl2c16ewd74HZjzS1aDetit3zSGbWkDoHI5YcdObjDs9YKzdWBMybDXq20zUOjaqrbVdStf2gUq9Xqd5aC1Eew4IByBq1sjz7ySCK1cHRLSzYnXvurf0ir90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 05:10:06 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::3476:df27:437c:12b8]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::3476:df27:437c:12b8%5]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 05:10:06 +0000
Message-ID: <839a74c1-6e08-441b-a6e3-9923dfc3f303@amd.com>
Date: Wed, 6 Mar 2024 10:39:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] platform/x86/amd/pmf: Fix policy binary handling
Content-Language: en-US
To: Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240304205005.10078-1-W_Armin@gmx.de>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20240304205005.10078-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::12) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f5072c-0e7c-4097-612d-08dc3d9bafc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C+3jVJQNHKqYxC+WGKr2cqJM6D4gbraHN5a51vQ9Wu3Tc8el1GBl9r/7utHuvh4NTDyLptZNqNaJvU7nVsrE++iDcz+SMvrtxi9D3hFshMLV51aq5DPgUYpVDZ5Zx38oAwJwT3Vwm4X8X/J6FYifjESRyo/28Pnpb3n3+ab/t2tfpgOyBvND3ebhbINL/Qp/H5sCrW5mb8A+U6CFb3mAmc2Wbc6sqnJ83N1TFLFgUPyKLxk6vXAyj7bIWCTfDFpVjUqux3CL/SkUfY6Lx7ePaq2kj99pom9lMPiY6/RCXBnRzULoDsMuUY0HjjNhmnw29f33mw6ldFLMqjT5hQ+Ku7EskQyK2XZZdhwXNBe/UEF/QZjf7NkvSpF18afih7kEizPRqjN/FG0lfbPsMe2N6MgsN9rSNzR4eIDvu09NZEY7CdmAjI3lkfm2sh1W1R9IjuntGnU1DbZLzIJgMXnFGrwD4aQamKEDeZjWQCorYYkx3VBZvzdiuFT9kdPhwgu2/q9GkbzS97+fCA3W2/70magNAthd7iwGosq7aszpcNDMRd/nYEMsA8ugiqsvvKnIHrr7MD0v7WsUaI6pb8ndqWpwry/TAuRUXo7BuxsxcSZqRiEtW4tOsK+wPhsyJNnT2OzX/vmo2KImpnP5jW52d69aQFOH3hBovc9ZLFta9oc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVNNcnVseWQxbUhvVyt4QTRzZ2JhN3Arc2NvWVFmTENLalphQWlBTjBzc1ZV?=
 =?utf-8?B?V3dBQ01ZM2ZjK1VEUEw0TkdEZUEvdDljeTluaURySThjcEtxZHlNSVk0V21v?=
 =?utf-8?B?SDNMSWdTUE5sL2ZURHlpNHVCMHRTcTQvcFBqMmtvaklDYktudHQ1K1UrNGhN?=
 =?utf-8?B?KzI5d29SVGZISlppUGl0WmFSaDl2WWxWZlhDRGpBL0xvdzlrZnB5cWdhdGs4?=
 =?utf-8?B?UmVTUVdxSTkxRW1FZVlXY1pKYm1EdFEwVVY4amt1MnZxbU90VVM3eEY4cS9P?=
 =?utf-8?B?eDNaeVNVZVRRaUQrWmhvT0MrbVIwMFlPWStIT2xpN04xcmNHRmxROVBBbFlE?=
 =?utf-8?B?MTQ2UEhtcC9wcEdNb1Z2SFVzdEwwNXJTUUZsWVAxVUtIMGNoUGlzSEZPOXF3?=
 =?utf-8?B?aXppa3hSaHFDeURONnhRVUtIYldoTHUvOTNPeUxjUFhFMVVDTXNtbjJ1UERY?=
 =?utf-8?B?NlFMcG1GREZqYWQrZmp5UlNIbGVKVmNaUDlqR2doSWJxZXNoM2VoUnl0SjB5?=
 =?utf-8?B?b0ZQYWRVMlVLSFZlVVFXT1lpZ2hGaktDOWxlc0RNZDQ0SUpsaFhPaXcwY0VT?=
 =?utf-8?B?TjlkOHFqNjl0Qm9xNzhTL3Q2VDZrYm5IY0lJbkNCNUk0RUZnQmw0SHhvV3ZP?=
 =?utf-8?B?U1RvZ3lHbnhPWXF3UW01VGdRNWlhUG9iUGRwbXA2S3puekkyaTRUS0pxclNT?=
 =?utf-8?B?cElKa09rejY4OTBTaDNXSFlLRi80dTJjVkNGS2VKU2VNM3dJV2M4aGNqZDFK?=
 =?utf-8?B?VTBJaUlkN2RUWXoweHpLVWFrQWRydmZaQWR4NTFvVTJJazNMMlJyRk1DTzNl?=
 =?utf-8?B?RmV3UVh4bUtvVzRPU0VFanZrS1ZQcXZUalN5OWIreXZwS3pYamZhRS96dTY5?=
 =?utf-8?B?YVZMRkt5eDBnd1RuYVF0YTJJSUFZM2ZjUDQ2NVpZaTRMelAzSVIvY0pqWTNH?=
 =?utf-8?B?cGJOQmI0a3JKbnlPeHlYL2QvSDFaQXVIdlNkR2FTaUJJNDRnMVJ5OXNlQURj?=
 =?utf-8?B?MWFJZXRtL0w2Y2pmclBrVU5sNTB1SkdHdkFFbTlIUXY0MUpCVC83dlhUdEE0?=
 =?utf-8?B?NWhiUS9lREYxWmRWeGFnZDRPYTRBbEg1cmo0a2s2NHRkdzlsa1pkRC9WVDIr?=
 =?utf-8?B?MVc0R25rUUZyWmVPUWN6U2RlMFFoSG1DazhLRUJ2YmV1Ni9Ia1hPdnIzL3N4?=
 =?utf-8?B?bFV0NWw0eFVwaTZQWWNVT3BVS0c1NnRwOXZ1U0Y4NjJQazBoK05MS0lZbU1U?=
 =?utf-8?B?ZzhPWXhwS0tFeUhYdi8rSW5IemxaMEVsenJoT0hUQThpM2RTcFJpa3NBODh4?=
 =?utf-8?B?OHBVdUR6ZFg5ejUzckU2UTBNa1hSM0ViK2wyQ2g1UHByLzVFd01COHcwbnBi?=
 =?utf-8?B?cGZxUUtXSFdITzBkNWYxN2lDWmhYMUZMbm9xbStENnhrNjZIWGFRa0hsek8w?=
 =?utf-8?B?djVub1NzWDc3QnRZVWl5T2NWNU5CMzZIeWxNeERZN0JhTCs3eElQMGFkNGdp?=
 =?utf-8?B?REJ3ZzRqNWt3aWk3ZFdPUWVSbW5ueGx0YzJKL1locnBxWStmR2F3enNPam1Z?=
 =?utf-8?B?aDdvUVFNSmFVNTIyb21wS0VXbjhhdXJaTW5WN296TCtqbXRlOHVzREYxS3Bt?=
 =?utf-8?B?QUJscHVaOTBWdHRlRlc5SkI2bHhob0VWU2dWQkM4TDVNMkRoaEFZamZpK0pB?=
 =?utf-8?B?bDlrZXAzYlZIUGIwMFFXSmpHZ2NoWjFNWHJHQ3oxTzI4S1V4MUk4blZJU2dS?=
 =?utf-8?B?Yk5BcW54M1VlalgwYUZkelVXL29XNjNTWHFKSlhQMit4cDJPOEZla1JJM3lr?=
 =?utf-8?B?TTF1VGNmNnQxKzA0UmpzUkNxTXhSYi9JRXo0YkxuZnJybDVkQWwxSTBxMFpl?=
 =?utf-8?B?M0ljK2tXKzNQTCtZb0FET2VQOWlzdnExWnFWM1VSdVRrMERuL3JNVUJsOFg2?=
 =?utf-8?B?Qit3Si9jamtiVmR0eFpmb1o3VlNsV3FzeXh6eHBmaWlnTllLd3BDKzlpNFFu?=
 =?utf-8?B?bjVwN0N6T0cxWk4yMm5RcDF4d003azZqYnJCbzd2d2ppekJUWnpvWU9RMDky?=
 =?utf-8?B?aDJISXYzVU9KVWtpdEJGa3VoSVdSc2VmYVVHL2ZMWVdORHI4QS90SVlMeXdR?=
 =?utf-8?Q?uQ7tsRiFvGu/XG5lnkBkAAajA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f5072c-0e7c-4097-612d-08dc3d9bafc8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 05:10:06.1110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJz37g7jqjOJzsVLasQQ0yt35MNzh44P848YQ5/8IhZfadvDSIJNitOEghqAiI2KeAJ3qkzkVm7fJ0iZ8PMKkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091



On 3/5/2024 02:20, Armin Wolf wrote:
> This patch series fixes various issues inside the policy binary
> handling code.
> The first patch makes sure that a valid error code is returned upon
> failing to start the policy engine, while the second patch drops the
> usage of readl() on non-io memory.
> The last two patches fix a possible out-of-bounds memory access when
> parsing the policy binary header.
> 
> All patches are compile-tested only.
> 
> Changes since v2:
> - add patches 1 and 3
> 
> Changes since v1:
> - get the full dword instead of only 8 bits when reading the header
> - check if the policy buffer also has enough room for storing the length

Thank you Armin. Series looks good to me.

Reviewed-by: Shyam Sundar S K Shyam-sundar.S-k@amd.com

> 
> Armin Wolf (4):
>   platform/x86/amd/pmf: Fix return value of
>     amd_pmf_start_policy_engine()
>   platform/x86/amd/pmf: Do not use readl() for policy buffer access
>   platform/x86/amd/pmf: Use struct for cookie header
>   platform/x86/amd/pmf: Fix possible out-of-bound memory accesses
> 
>  drivers/platform/x86/amd/pmf/pmf.h    |  6 +++++-
>  drivers/platform/x86/amd/pmf/tee-if.c | 21 +++++++++++++--------
>  2 files changed, 18 insertions(+), 9 deletions(-)
> 
> --
> 2.39.2
> 

