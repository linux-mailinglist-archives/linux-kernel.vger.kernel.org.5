Return-Path: <linux-kernel+bounces-97229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E209876759
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5069D1C20DA4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121EB1EA84;
	Fri,  8 Mar 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xuWl01Ht"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507C95234;
	Fri,  8 Mar 2024 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911682; cv=fail; b=hG/XP8C/iOVZTPi62t4zp2uDc2C4jAnaHAUPgxSKLw9l9uYoKqKJsYVVw9Q2ySqgO0rhZ1Rq3nLB3sDVnD6tWrKVgGTuQhFheAH1x9OKSJxYemEdA/1vVuacEEZhPWukO+SojTk81i4K0IFLP8RiyXJ72OGIvvI2T6w3t3HZ2rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911682; c=relaxed/simple;
	bh=W9UlGerQOJreUYkvEWEILRwTysZ/61LgI0N1xYqoECk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EeSpqhuwW0BhdM95ucC+tCd+d2UnlE7o6J8xsackvvlHE1U8IvIGPvwEnqjQTm3nlfAVevCyQ64thLsB993hEYL8BushdnFXDT5ycJc+ywuq5tfMQVvtiZDblyFKXBFXXLBm2mnhbyuTWIF5EoZ5+egEvpLTgE/SmC7YsAzugBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xuWl01Ht; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5nT7tUpO3d/Bjklni/OfEClzXYlHTcndZ2xWB3Mo7KNVInybeENN/fswGb4uKMfwyvq5FgnaFr0YM3drLxG+aIW2Vl1BIGyPGDq2+x1BnbOMyE7gpi/BVqkUg59IZg+ZmXdljjTZc1pKBv+gXDPmWYwe+bscKMLdqOSqjAn2R7LaP1/stczlNw13eBC2Z6qWeamtzJ0B4zcKPsEFDm6+j4Ydtf6SZBdy8j0JwgLOgWYPZt1D+YHHcY6/fX4a5rlyIgh5MM4eHswxXGyWOlbkaMeqmcJU98y+HRyWMyrcPRTm0gA7+AJaURpC34i3VBIPWEv3iSm6fxnbc4EU8yQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRH07OmJYlbIsueVXSSN2GT9nCqD4mXpWjcjxvrOH64=;
 b=eakqtIxaLX31/h2vunsrVuYg/gjkXAbsWNx9YMqIwyveqg8+L3PWrzzZgJ+o+TgrTsNQNkoBz7pCNMQ/IyAE8xAyraSMhKctFrneYcqUtJ0GD3a/PGgcT90oM+LMcEZJ1He1iuzXvXO6In41ugfp4xJH+bwcalPDr6qkrHYPWL9+euBfaGYfvt6lILHD9xuCm7yfkFElJuwHufCeK0/6XiTsWq9b5301BFPwgBNbOgo7CYJLBEI4358VYo2f5zZIXlX12S4RunlDjODO57IB9MslZ1zvVmgAcAYQKcALPUNStAPg/48dX4fJymJddrWFSzAl3nKE8oA21mx3s6LSAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRH07OmJYlbIsueVXSSN2GT9nCqD4mXpWjcjxvrOH64=;
 b=xuWl01Ht7b2V0pYwKBTLzpAokDzTp8pj6YeQL6F0nX0dS4FsFJaaoMRgTVbZ4EppMsuwT//ubcWyAStag3u69R/yH9xntO4Mo5h/9Gw3h+r4Fk5cNN6ZOTqAih9hitjIg9IApr/bvReNhOipRYpBym1Vjmg9r+1EPzR4OryTEiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 15:27:58 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 15:27:57 +0000
Message-ID: <6031ff70-d9f8-4e9e-b9be-6d9fa0091b9c@amd.com>
Date: Fri, 8 Mar 2024 16:27:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] spi: xilinx: Add necessary inclusion and forward
 declaration
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20240307154510.3795380-1-andriy.shevchenko@linux.intel.com>
 <20240307154510.3795380-3-andriy.shevchenko@linux.intel.com>
 <a3aca544-dc6b-4812-b82e-dd1f9cc04871@amd.com>
 <ZesZKbdIo6z-AfIT@smile.fi.intel.com>
 <d479cda0-3c3f-4cf7-acee-bcacbb9cc5f5@amd.com>
 <ZesoAxvS7y8VCxZT@smile.fi.intel.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <ZesoAxvS7y8VCxZT@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0119.namprd05.prod.outlook.com
 (2603:10b6:a03:334::34) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 54fb9f40-3aeb-4363-39f0-08dc3f845515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2AYkgYsGD5RaIVIeefHt42hIslnwuxGfFmkSznHN30Oog2Aeq/yR77clbfjukDevw218VQ8+fVFqBblS1Tc2Bk30as4r3+iKz0l6N4B8C9NCISDFEe6Hbm6JXJdDoGOkLglAVPeV30JNqyQk2+Klv4COfcB3it+YeVIz3Bzu/HIGhZJ/692DOefrvqGiacp8lq6RDJvkLaXmBFVPza/KEiAqc86Yop8krt8Hk0JDN/vE7eRU/M1GqT5yDJ6u+elDLORIg60zXTeXZh8Viut8Yp7Ixblgj7TahnAT8gojSwcHdKANRbLsPPqaxI9CHrnLf94I5Qlv+uVJvitZjpzZsHsdXQtM/lOS46BdZevwaa9It4aphD29YkdiCyFFUU2s4qVlPsZTsBntOZZo+4mOtIBvPHuxeRwoqbOUARXroyunh8ISnK6zeM1aT8r+/7MZeHq8kBknbJJpqsZDlievlW0owNnbdJH4UXK5/96/7dxJEhAc8rCM4SuT9Xvye5SbLg11UMTEu6wCJIxABHuaD2tekOBUP1KuCFfq/xslbxMi3OSXDbXTZp6LdK11w7oZ0Hw+bdsYEBq/jpeEJdk7aqpYCKOs1h2bDd5/jUh7GGkGTWbjUw3PdOkzlV1r2HXduhAT3kzxhjxqKiq9xhFo5cDzr2NYWS2d/q231lYlXhQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEQyUjJOYXNLTUhYQjhtMEx1eTZtWTQySVN3LzVCVGNneWlaWGViL0RnR0kx?=
 =?utf-8?B?VzVMRXFQWExCNnY0cWVOdzZLNkxHWmxuZjlRaWovb3pMbnNUMGM0MlRscmpE?=
 =?utf-8?B?YXgxRCtoRFdUOU51Y1lJUjR2Z3dnSDd0VEpuTkxBOHJWOE5IMGZLbnh1K2I2?=
 =?utf-8?B?alZNZC95U010RFgxeTZlVmVlM0p2eFZRcU42QmtIZFJtcENlVUFTU1RhTHNM?=
 =?utf-8?B?d2pva1NVVVpSQVhBdnI1STZLeXIvcGVRVkJFbHdMZllPSk1iWDBJRHJHNDdO?=
 =?utf-8?B?TUZDaE9yem0zYzhtZWdBandwTlZ5NHFUQUt2WmdXOSs1OGhBcGVuMHRJMlps?=
 =?utf-8?B?dzVOTk5kcktRdVZsY3FrdlphZUZvK0JZWWJ5UkJJREJhOTNyVTZlV0VHSXUr?=
 =?utf-8?B?czUyQU5ZSXBORHJuZFlMU21xUjNtd0Q1UDBLUXdzVy8rSEI1czAvRkJQcHM4?=
 =?utf-8?B?VmJZM0RxVkF3cXFlNkZnblVOS0tzVGJPbHhRSUxHMWRyZjlDdXFHS3JlUHIv?=
 =?utf-8?B?VCtaYWJaNTZpR3NaZ3VDaXJwRzl3aFljUndaRlJaVGYxZXdLQ1dMUkNLWGYw?=
 =?utf-8?B?OWlaMFVQVGppNXJEcHUxU1ZYbHNCQW1tNjN1d0NHSzArTG9qTGkxODNkcHRL?=
 =?utf-8?B?UmJscmU5VnVVYXN4UFhEYmVxOHBNTkZTWUVEblBMYmx5QUFyVzBWUk1Db09T?=
 =?utf-8?B?bnZXZWRSV2x3aGVxMnhidk0raE1sd2UveDRyMm9wSmR2dXpwQ0wxSnp6ajUx?=
 =?utf-8?B?UTJDZXdsdUtIbXVrY1VXUVA5U1MwMjd4SXZSMlN5ZmpKMExWM2RzVURQbklU?=
 =?utf-8?B?M2h6TzRJUWdYV2RmbzVyWU5IUHQ4ZHpBeE9DMmlEMTJsTk9aOFQvOXJFelJj?=
 =?utf-8?B?L3ArTGU4QmJJWkdnU3ZaSFk4cC8wSlVkQkppSjJNKzVJcjF6dlR1RGw1YzZw?=
 =?utf-8?B?VmtLc25UNjJZalNxMkpPU01rRTlpOExUMzZCWHNFSFZpSFdVTmdoTEFwcUIv?=
 =?utf-8?B?MHlYU2JFdHJ0Q1hrNk1Dbm91TE1CTnRRMlZWbThGZVRXYVpOelo5cGdJZHUy?=
 =?utf-8?B?OHVLMUV0M0pOamtUb3RuaFQ0U0UrUDdQdjdzKzNvUGJMbmRoblIvNVBYc1l6?=
 =?utf-8?B?T1JMVTl2RVN4VkJmSXhVSE45KzE2YWdhZFY0TjZqQXJ1WTdjUXdldWVIZ0RN?=
 =?utf-8?B?WGVzMFBPREJhT3prYTVUb29FZUFDbERITHV3eTBHczM1eFI2RTI4b2ZLb0xl?=
 =?utf-8?B?UFZ6S2RTeWkzZGlzRE5iQnB1OUNtTzg4Q3dNNGZPcXplWC85QkpVQ2lGVHY5?=
 =?utf-8?B?NDRsUkQwei9jVm14QjV3MXdBdDM2UnFMTTVubnFoUE9Zc3Y1L2JYMWtOb1ll?=
 =?utf-8?B?MzU1YmZEL1lXSjNjOU4ydTFWOHA1RjAzOGM1WkNDRWtjRGVaTE1nbnNHRU5K?=
 =?utf-8?B?K3U1WVIrOCtFMXBpVXIzT2hYaWVWVllJUzRwTUZVS1F5M25HUWM2RnVhc0hY?=
 =?utf-8?B?TERiNU5Fejd4VDRlRHQ2WDcyQ3ViTzRYRDE4K1cvcmt3SzFYdmNzaXhmSFZF?=
 =?utf-8?B?NlpiUk05dUg1a1Y1UjFTZDdjazFaVURheUtHVTJ4NS9Va2RYVHZ1bmVkdFVJ?=
 =?utf-8?B?M0ZjR0E3MFNxL2x4WDVid3RDQzhyQVArTW9kME5UaHBCU21DTXVSUXkzV0xm?=
 =?utf-8?B?UnpUVGpzWmRwb3BxazZhV1p4OXg2aE1sMkhaQlR5d1NRYmRTcXl6MGVqa2hH?=
 =?utf-8?B?VitIY2pVVjFvbWxGcmRwdjZnL0JVMVI4RUs4UFZscWpycUdSQnhBWGtJS3oz?=
 =?utf-8?B?NjJMcTNXYkxMVlkzM2hxUmdRbUJ4MXNVZ1R6NmFXbkZpSDVFNVFoYjE4ejNI?=
 =?utf-8?B?ZndETU1HM2JMaUZXcm1Ta0toY0JrQnNPa3NjUVdHQmdmRWFRRE04SElCVUhs?=
 =?utf-8?B?bWFaNFhVZGphd1kxeTBEd2dCNXRTM2twWWlVSXpCSm5tdldCamRRVzJvMDNE?=
 =?utf-8?B?S3RTdmxUeUk0ZndWV2V4ZE1KRFlDTXhyZDJoU2pEUXJLVEJiU3ZZTGZzUkNN?=
 =?utf-8?B?ZFJRUGJJMGI1QUE4WC8yNzRjNjBsSkh4cS9meXZNT1k2bnNpSlBIZnpOa3gz?=
 =?utf-8?Q?srqTCUH2HuHwicLlpdQzQj6Yg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fb9f40-3aeb-4363-39f0-08dc3f845515
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 15:27:57.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7Ud7h1tdUMMOy9OtcVcYqjOmc+IoVb7AbZLAXTQCW8RZEIsIq3Vt5bjav+So60T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789



On 3/8/24 16:00, Andy Shevchenko wrote:
> On Fri, Mar 08, 2024 at 03:02:01PM +0100, Michal Simek wrote:
>> On 3/8/24 14:56, Andy Shevchenko wrote:
>>> On Fri, Mar 08, 2024 at 09:21:32AM +0100, Michal Simek wrote:
>>>> On 3/7/24 16:43, Andy Shevchenko wrote:
>>>>> xilinx_spi.h is mnissing inclusion and forward declaration, add them.
> 
> ...
> 
>>>>> diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
>>>>>     #define __LINUX_SPI_XILINX_SPI_H
>>>>> +#include <linux/types.h>
>>>>> +
>>>>> +struct spi_board_info;
>>>>> +
>>>>>     /**
>>>>>      * struct xspi_platform_data - Platform data of the Xilinx SPI driver
>>>>>      * @num_chipselect:	Number of chip select by the IP.
>>>>
>>>> Likely correct but forget how to check it with tools.
>>>
>>> I'm not sure which tools we have to check this.
>>>
>>> The types.h is needed for uXX
>>> The forward declaration for the pointer to the mentioned type.
>>>
>>> All this has been derived from reading the file.
>>
>> No issue with it. But I am quite sure there was a tool which was able to
>> find it out and report it. But forgot which one was it.
> 
> You mean iwyu? If so, it needs a lot of tuning before being able to be used
> in Linux kernel.
> 

Acked-by; Michal Simek <michal.simek@amd.com>

Thanks,
Michal

