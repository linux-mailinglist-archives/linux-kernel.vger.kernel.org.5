Return-Path: <linux-kernel+bounces-97131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5E68765E7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC9B1C22A8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84803FB91;
	Fri,  8 Mar 2024 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X6lgbB2x"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF403399C;
	Fri,  8 Mar 2024 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906470; cv=fail; b=N45wDevnX6X/0Pj5ej6huZBLaRwmX0X6E389Q215Ra/6xrcozoi81yCLvLD0Xg8xOk1+BVCRvNlkqotvuCLUBhZ4M5jf5r/RAhJG1A8lLBW1NLN2/RnYhNIlVN2iDaHsY8aewtC3M6t8kQpRGd0OZf7U1xYTNpWTGzst7Z8g4UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906470; c=relaxed/simple;
	bh=B91PEMjEuHgnXExsHzyqt73u/1w9yQiM2ZHYDKhIZyc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YQeor3ELh3v6c6rWMt40JK+EmUXsLUt60BBYdyroSxS6cu/UqbARKT0FVyfjhceGiOy/mzlH4KbJcv5igMsxKR9LN75TEnDog6gXtzLOr3WPCs4RWwOpMpTAojhafds9V9qgzzh35dZZlEY05i9kKc4IpdDhOr5rZimSvEZKM5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X6lgbB2x; arc=fail smtp.client-ip=40.107.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSuC64u+G9PB+/ojtdy+EQnDjDCKBH8yfPdziXcOexmvUmrYmvqHsY82QM6jaRRTDgE6k4jz4Tdh878Ns3v1a4ynN2NmNYC1o0VjCsx5F9jQBVVjKhPxBLMwor/eCirux3D5ZbUwif+mr3hROUccPRV7bKswOPt/+hRiNXbtPh5H7N8Svaqit4JCukiEWBDG1i7u35CdgcFcOKcumcv6m67lW0HY+Kwj3xRNVTomlykJA/lb+IFhKrqSCosZpQFl8TSKZXVxCLyh5/QwrodWBlNkwXB0+xGTA/CIBiuCkFtAFJq6SMmNZI7gN1qqSGXOfYq2MSxwHuf/Bk/0uPWpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpjBGY+QGzKAhI/G7UYQ+mFk08UJyK7700Pg09D6Xcs=;
 b=MzrP2pC/FTMzsIHDWhbOX25mVokhFMqy5vfcCWz+v6mB1KtdWG1mkKqB24FHiJOlmxv1RqwzwsfuTHLBAdaR2G24ukWDYdjly7qL86H0f82TcMrQorItG5N8f+NjQgAJ/PsnqRarmuRXqiOg+PA+MA+NIRNRXJqL9Bi2thywJAAjSOx0XFYA9arUqCautjBPZhwHxf16HM5KBVaC5dKSjEYLtmcmeuOu0qOjHddN2OJFnudaScUvgNzwbKnKhPQ8Wjkjm0acoEB11T/wH1uiPoDnW3ACEZgPmMFnMdBEcdGPCkDU6o1CzqEBbOVkIoC2ehNANZRK1m1DhbVAi6YreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpjBGY+QGzKAhI/G7UYQ+mFk08UJyK7700Pg09D6Xcs=;
 b=X6lgbB2xXALloYhq9/H1zQBcrZUP9eXOYrZloMEiK3reEt/3ae8BX5e2RjEbdsUttUYk11XZtv12CQc0tODAC3+bnA8DDcjDymtQPYU7upLbhXG1Y3nVUTpEs51t5bRfgDE79FAxbxpKfwRkdHdPKbnUCu+Zm4y46/5oArswilY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 14:01:01 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 14:01:01 +0000
Message-ID: <58dca460-d363-432d-9ea7-7f29ec9c4050@amd.com>
Date: Fri, 8 Mar 2024 15:00:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] spi: xilinx: Make num_chipselect 8-bit in the
 struct xspi_platform_data
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20240307154510.3795380-1-andriy.shevchenko@linux.intel.com>
 <20240307154510.3795380-4-andriy.shevchenko@linux.intel.com>
 <f7a882c8-5858-4d6b-8a70-0702c3170661@amd.com>
 <ZesTS2LDEYz_bbPK@smile.fi.intel.com>
 <1e35a288-0a11-4df6-b7c5-82e5cb6e1d3c@amd.com>
 <ZesYvnwiSMPMq98s@smile.fi.intel.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <ZesYvnwiSMPMq98s@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::6) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f1da10-ddd6-4e22-c174-08dc3f782fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AMCt/sGmgN8bmRvZLMzOwS6+SoOk14nYbD5xes2DtmMLfTaRDmh6AaHmYCFHUWIKhzLl5f7OhdMcEM+YkeHUYr7pDUyPjs3Oed+r45M2v+xaFfVWsuO81NLWfblsJ3d8PvwBRK0H9M5s6XoZ05twyKoluarXmuycmRxOBc4Td9p31N2PZC3XJQ+k75ATBj2m36iJ+Albb7VxMdMps700RgHJuOLAk6ljS3cVlzuDxQaS/bNE8AtYl8jCpuarXxBH/VQEzoDywPU0LA+yCDwfUW4zXZkoyumq4pJ9VW7Zr7llaD4IDEPiekSlp3Pfx9xZbzHhL5iyhpSHe+tpqHyDRGlqY6udL49GCCYs3ETr4B9wgXJyVfuYxHqj58jRnOowFfY0CrHczeK4xTRefXme1S6OgkUho3AEubDsNr/H0gOCZR289q+UjAtN1skoaM4wpPdHLfwCSFEnLY9S0K/K+Jlc4PFEqtDNSz8p39fjBon2zG97S8BBDRRyv+6cAUH+TsPBaOblVK+vumV0Z6RqIU5SBNlZTVK/zEyWSzL9p7NLkOBt09EELBoEBUjGWOU+aDf4Fut0SuAC5x96Q4X+79ljkxOzprtWG8g1wsEN0xuVzVryWCPEp2uuHK+HvXg5axmRD+K55FryDJahTGPrWOlbt4Ke3zYLwgXgtI/RcDQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWtwQWs5QUY4V1k2a0c2enc2Tkc4SWdKMnVCNmlBNk9mTm1pWERyVGhIaVRi?=
 =?utf-8?B?Ny96Z1JMdXJjUUM3d0d0UFlmOXdTR3JlRGNjcCtzYXpZUlFyWDZmUXNRZW43?=
 =?utf-8?B?R0JCMmZsUm1Ia3RHQ0YzOU5XVkhWZzliMDVqUitZY3dZdlFDNGJYODEydE5v?=
 =?utf-8?B?VjhIQVBYRWVYUTFEbUFMSlhhVlh6NDBzemFHM2RKK1lzN01CQlJxSW5nZWZS?=
 =?utf-8?B?MVczY09QQ1JnYzNEUDhhZ0U3YmV4YkFSUW85bEppNlc3TXlIbW12aUlvNFpm?=
 =?utf-8?B?SmZRUm8vRHZVanIvQkxxUXJWZ3A3UzZabnJjS1I4S2FQWDAwY1BYVEY3YmRL?=
 =?utf-8?B?YlhQbkw0SW0xcFQ5enZyNTBYOTJJRHJENGFSYzhldnhzYTRZQTdxVzQ4YWJN?=
 =?utf-8?B?V3V4ekEyVUJVM0szQXBjRndxNWpxRkZsUU1TcDVwNER2ZWhMSkdpQ0xQd3o4?=
 =?utf-8?B?VDBCQjB2aXBxdnpVR2FRMkY2cWxwYjdjenJkanpOSXp2dzdUOU4yczNmQ2NN?=
 =?utf-8?B?RWJxZ2krQ3QxRytRaVRXVzA1UzlCOWkxVEZnZ2xLS0hsQ3Q4eVQ3SlpjTml4?=
 =?utf-8?B?ZnVHRUNxK09Xdll6RzdaL1RpRkJwaEg4aU5lc0RiTGNOZ280cnBlY2VUVFdG?=
 =?utf-8?B?NlJlOW1EckQ3V2xuQ3RXZ3dBbnZkdWp0ZFhnS3FNb25wZTdrQU51NTVrcmVt?=
 =?utf-8?B?NzFqK0MwNUZsUTFNSmdlSy9lRUllaEpYa1hFK2szcFVDSm5MWWhZMFROY2dI?=
 =?utf-8?B?RkxTZkx5bFoyUnJNZmtuUldkdklKelZualVuTTlQSXBqNVp6UFRRaVJpVTI1?=
 =?utf-8?B?aFdYYTB4MGtxaStjNnZ3V1RoTFB6MnVDbnU4cWo3UkFUdjVyLzhzaEE4NjhZ?=
 =?utf-8?B?bnJIVnFoaENPQjF3cGIyRSsxaTdkdENUeXlHa2xQSVB0L091K2ZZWXpsdWc5?=
 =?utf-8?B?NGFqTHE2Ti8ySzlXSWNvUURrb21pRysrT01HMmxMTUpNek5yL2REMmsyUGxQ?=
 =?utf-8?B?RWRmVGpPSnU1WmY1cVF3eDQ2SmRJYUZjVFJuWHVSTzloYW53cmM0Y1FEMDlL?=
 =?utf-8?B?OG1pZ29YMzdqWVBPcWpRMUY1eStxOFI1T2JUNXcwaTZFblZGQlN3Zm1GOEJ0?=
 =?utf-8?B?OFFLUW9vczVobkZhUFpoOWx2NUZ3UlRlaU5vMWdyM001K1dEWldSWWxWUG0y?=
 =?utf-8?B?N0t4YW9jVklKVE1jM01kK0M0VlhZRElyR3dwd0FsTTlLU2ZPbkdta0gwSmwx?=
 =?utf-8?B?OEJZZVRWaGRoT1dBcThoTEhEZUdhaUxFckNjbHVxTGlmL1JiNG1KMjkxczNE?=
 =?utf-8?B?TzlHMmVZVFVRNDZoUGsxaVN6aGlCNmZnaTNrUkZJcHVmYkk3eU0zcEZnSEhT?=
 =?utf-8?B?R2RZQ0FSQ3gvaWthZ1Q3bjBLbG84SENhMzhzQnpqOVkwcVNVOStyN24ycWkv?=
 =?utf-8?B?dVBUSWkxU1lZL3k2WUlvMlQwa01qU3FHakNzVVB6VUF2anoyN1pWQjVYSERp?=
 =?utf-8?B?cE5MT3l3YjRDNDkrWC9jZFVyeGZvZHgvWGIxMDdsRHlkaGZCMzM5dkJINmdn?=
 =?utf-8?B?dzlhUktHSUNNekFvQzhvUHA5RUV2YU5qcE1zZlN3MzlySlgwcklZeFUrUzNh?=
 =?utf-8?B?ekx0Y0pPM2xKbmxjNHBGRDJtYVJheWMvTTN3dXliRVdYSDlHdWR4TmdTWkhM?=
 =?utf-8?B?eTJ4L2JvUXFEWkx1OW1IcE1uVFc5bEhzS3doV056R3VaWmU3aVU4OWdORkVF?=
 =?utf-8?B?RWxiNndtKzBoc0ZDRnhnZFJGQ1ZiN1kvRlFqcXFudkJzdVVOdHcwd1BlN21v?=
 =?utf-8?B?Rytrc0JDemZwbHBSSnhjOE1sMmhoWlhkZjRsZFFtT2I5YTZiT1ppdVpXeWFu?=
 =?utf-8?B?Skwxb2Y5Rm5JRjQzZ1pyYXVScXZQUWhsZ2ZXbE9mbTRydkhvc2dOWisxOTdD?=
 =?utf-8?B?SFV4Y0tEeHFaRFNkNXA3WmpyUGQ5d0xlZjI0TjQ5YjRETzF4Um1DdzErZmZ5?=
 =?utf-8?B?TjJieXczYjRLRENTbTUvT0JXa28zMStNeDYxNjlYdGMwemx1SGE0amZQOUsr?=
 =?utf-8?B?Nzg3NVliMUNMcFVkQWVpNXJFL0dqS0dlZ3dyVkgwTzNTSTBiNzFoaU8wWEJD?=
 =?utf-8?Q?T+YpzN86EdLtRnrcPZQDjXzlY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f1da10-ddd6-4e22-c174-08dc3f782fc8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 14:01:01.1029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ABVD4/nznoBCa6YkzxqUZIfMBxRtTkYoeY6+ey5OXQv49/dBd+bWoaOKblDZZ+6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331



On 3/8/24 14:55, Andy Shevchenko wrote:
> On Fri, Mar 08, 2024 at 02:48:04PM +0100, Michal Simek wrote:
>> On 3/8/24 14:31, Andy Shevchenko wrote:
>>> On Fri, Mar 08, 2024 at 09:20:23AM +0100, Michal Simek wrote:
>>>> On 3/7/24 16:43, Andy Shevchenko wrote:
> 
> ...
> 
>>>>>     struct xspi_platform_data {
>>>>> -	u16 num_chipselect;
>>>>> -	u8 bits_per_word;
>>>>> -	struct spi_board_info *devices;
>>>>> -	u8 num_devices;
>>>>>     	bool force_irq;
>>>>> +	u8 num_chipselect;
>>>>> +	u8 bits_per_word;
>>>>> +	u8 num_devices;
>>>>
>>>> all above have 32bits. It means on 64bit cpu you have 32bit gap here.
>>>
>>>>> +	struct spi_board_info *devices;
>>>
>>> On all architectures? I mean do all 64-bit architecture ABIs _require_
>>> the pointer to be aligned at 8-byte boundary? Even if so, the struct
>>> itself can be aligned on 4-byte boundary.
>>
>> I am not able to tell if toolchain enforce 8byte alignment by default/by
>> setup on all 64bit systems.
>> I am using pahole to check this which was recommended by Greg in past which
>> reports gap in the middle.
> 
> I see, thanks for explanation.
> 
> Yes, it's likely that in some cases it will be a gap on 64-bit platforms, but
> after this patch no gap on 32-bit. Do you still want me to reshuffle that as
> you suggested?

Yes I would prefer to do that change when you are doing cleanup.

M

