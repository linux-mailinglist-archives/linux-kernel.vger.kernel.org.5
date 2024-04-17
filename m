Return-Path: <linux-kernel+bounces-148629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 330798A854E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F301F24BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D706C140397;
	Wed, 17 Apr 2024 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1GD8Nph4"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C089314036D;
	Wed, 17 Apr 2024 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361866; cv=fail; b=K9AbfN36UdQnQxEG4Hb29V5qj2I3RZX4HGAjVKyunDTa3dKXQCQgl9FX2ItR+kQLblDNOLxBwEoj+JOGYc3+JIGiIBwBE43nlOo3W9TdDvfEow+F1p6TK5F/wF3dHbqgC8jLGYA3VU9NXoSPtvlmrfBghPZLFWx4NHi9Bfs74mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361866; c=relaxed/simple;
	bh=0i+TuQKM80eMbdvHTC9RTzJj1UbxHUvrxko7nFXZCyo=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C/XGHG82HPeFBl8gb0dgBUyraf5FrPRx3I/Tor+E5sSbFniRnK0ojgnTeQXNurw25Boj9AcymYonE/0Pc8JQAV9JrvxmHkXd6DsIuNM+EhkOEM2oAF74wiBucdk4MxIaFMuj2gFiFI+tehkqu42rzX7GlYeIyULEJ2Y2HUsj6oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1GD8Nph4; arc=fail smtp.client-ip=40.107.212.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XG5u4Ddp4l47sb45WpP7f3Qkv/SH+fik3ZjCwQcrcJPtvuhKEY46i3wPoOKRQbCe+Bgi9UdaMgPC7ld0x6avIGAUHJr/kqu3gRrrcvHOa5dGqr3nDuIdKn1BGVi0giKGg1W9I/n6sv447G4RmLPws8AJcTG5qtTS9vUZco6JQF9CJLp6ZOebb4EDKvkPMmE9yFRxQvb2WKuGaffxdBNUpcMOCcObo4LHLAJbNX9AddBpez5rUSHk8qe3MYX4nYkbhfKlVfHKxKjH2/+bqrBiQufMXIhDYrJbJcpc/ZhJOo74oZkD6vP0dAhDTyREeomn3bPKF5LtcNuBSfMxSTfqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdkcD08jQJk7dNZiWE9XWaAftHfS5P7ZQ30oJ8l3VJg=;
 b=SLjVJUob6FOrW71GhPCO4hBsH8tbAT67UgLu7FaHvh11j5/923FdCL4HlehuUa4KwZLkvec9oXtfRw0JxWRLaEs9gCygaEup/0XpvHc6KzrI/e5M1dQQa55aZd41vBTdCSNX2F+9p8oWpEdoocOMPSVwX+sPFaKBALHbjQ4WYan8YXtTg0Px2u+TPgxY0vCAnsYHVlvnTCeHvlwgzvMHIjkbUz9VqMU6Gi6dUzFN6oKROhhc5tE3+fH3k7mTcALh/sFNpkpsUx1MS2AbBxcHRXiv95JGWAogVZE/aFAVaDuB4Vzdu2FIvJNSLvVKig/ssgzeaQyd9IAw6waUVLcY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdkcD08jQJk7dNZiWE9XWaAftHfS5P7ZQ30oJ8l3VJg=;
 b=1GD8Nph4PMsWiNo5gKPk7SkB+f4eTDu2/kYSNRyWZJwmal5N/9CtP7b887/AVh1VD5n+iEPWRghZgQQKsjk7CMDJLmW63EU87J9YHYjVsErpNNtcwkZjOtgljamLUBs0Alyt4ZcbTXURLMM5BfenISMVDFfuBofzqf6fGFNKq7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 13:51:01 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 13:51:01 +0000
Message-ID: <b5ecdc56-11c6-47b0-9cc1-87d384b01d0f@amd.com>
Date: Wed, 17 Apr 2024 09:50:58 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 01/16] x86/mce: Define mce_setup() helpers for common
 and per-CPU fields
To: Borislav Petkov <bp@alien8.de>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-2-yazen.ghannam@amd.com>
 <20240416100206.GEZh5MnlDJMeaERfQ5@fat_crate.local>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240416100206.GEZh5MnlDJMeaERfQ5@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:408:70::34) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 028127bb-e47e-4de4-36a5-08dc5ee56a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6SaOJAsl5sBpo+Jxr9/YzaK+h2Udh1/wpawG2kRO2S0RK4tewsVazJY9jcDTkupFPUoNIHsf+YSylqiBYYQFmLSmLDfDZy+uKRnRUMaSIQe9JJf/qE8cFhnrz+mKaC9UJicTuWCsdzV5i1V4gZ2BIo+lylmGT8pJM/iImwdR1HatsDlG8yxM+gCajUw5BGeiIeNMuqWxHmY0vAaQrg/6k1vgsstou8UAaTSLasujFMLbVxcYayCXZPnb30JbhmXFmkNHW9NZubSksVmNZ+lUSeSaRnEp7CDuCivviLZDND3YCnrIYLsLJviaMnPZoCml1n5TY0TOhIqmxMthOLumC7drvOKXttorV8P8SY9mj58zNd6NoF4/CjP0N8Bjoe1W2+OBjKggkIbv9uKImwJ3LmJYa80yS1wwQLcSTNiQYWm6uCoe8AQg0dptOXfRryB0kT7cjmTW5XFNo1wzOYjruKyaR7wAaDWOIIWpvPKd6iqs+Ag3XcXFHEMR0uwXRU4Au4AejJ5KaAmFWK3uqv6mY0cvkJWIGi5bhq8CTtHXp/ZsyGjrd64DQeMiLkGBePJMvk2px1Dh+wENtcWbJx9YW6I5AQ3FVK2e4qgqs5GX4cemblH/O4lFKjRQXQKBMnZGBXHdwY3ywMeafZjZ4rjYdNWsGpOINtdL57kxTQvohDs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGhmZ29OcmYzakMxeTh0YzMxMHpKR2cvc2hPQXYzaktZaElnTWgzZ2grZE91?=
 =?utf-8?B?TFZtaGU2V3poWjJPcFR1QkpjMytsWUVpUDFEQWF1YzB4ZlpzVEdVR0VtT2VY?=
 =?utf-8?B?SWdKMzEwQkhGKzFXSXdVT3FJL200cmg5TDA4YXZ2Qng4bmtHbnFYOWV3bllz?=
 =?utf-8?B?ZHFwcWlWUExQOS8xcGZXdTdUWlhGK2ZKS1NiTUw4d1dZeG5lL3FmSHJ5M1Br?=
 =?utf-8?B?ZEVpbUoyZUI1bWN0YzFvZzF1YjdHcy9kT0R1bTlLd3VGRkhGWjNPTmw3aU9N?=
 =?utf-8?B?RFFmYWdBZVZTTm9nNXdPbVNDSm9jazROeUNFUUFydFc2dU01Sy9VaG1TMkJV?=
 =?utf-8?B?MTNlbTR6WGgzTjdZN0ZlZWFtU0cvdkgveHhoTnA0Um9ydEVkU1plOXJ4U3Fl?=
 =?utf-8?B?MzM3S1VnRjQ4ZzdSWWVHcGlzNFVEc09HZERkanRqS010N0luRUxLSGYvRDl6?=
 =?utf-8?B?dzZrVnhRM2FjK2hYUUcxek1MRmZ2UjB0WHFEd3ZKYzArVzQzTU5hcVB1dzN0?=
 =?utf-8?B?WWs3N3RWTWJOd0htelZLcUFOdVc4dHVPRkViZ3AvTS8vQzdQWmZablFWbUdj?=
 =?utf-8?B?RzZGY1F4VFFDV2F2TndGTDlza1ZwVmZ5Y2ZjdDlGbXl1azRXVkdlc1VLQldk?=
 =?utf-8?B?MGxPOFN2eVZQaGdNTDZ2YnB1eXlzUFczZ2xwZDk2VnBrcEpwNkpDdzlGbkFF?=
 =?utf-8?B?ZEFONEU4YUtFZnMyTkJVWDVsSDNmV0dwL1QxUG1McjJoU1lrekF0aXI4L0hi?=
 =?utf-8?B?Smp2UTV3SVRBNmFvRTM1djJoNGRTNG1Cdlp2T3dUTDFHQUU5VVVDenR2emJv?=
 =?utf-8?B?bGdrS2NRclE0VXdkL2UxZXdrd1JQSkdoc2V5aE5NdFhtT0ZUWWNTQVNJVUxB?=
 =?utf-8?B?N3ZlWDhPcWRSZU50NUsxdW5jU1hLUnI4dmVqRFZDV2hzbE1HcW1RNktkYitk?=
 =?utf-8?B?L1pzUndBZjBBNWFBSmJqZnZGZnVrK0kzaHVyNjRwWE04NHhDTUZTSUhFOGow?=
 =?utf-8?B?cm1Lc3lPZDZJNEhEV1hTZS8rNXhlWkN5YUszbFdLRktnaktadmY4d2t5ZXBq?=
 =?utf-8?B?UTUySTU4WEtWTlNZOWxpQzE5UWlDai84ZU42dmI2M1ZZN3BwVlhlSFFabnJY?=
 =?utf-8?B?NzhTWTFuRGRKYzBIeW1wZmtQT2djUkhlZ3dwQksvY0VhdkM5TlhTOWpySkJK?=
 =?utf-8?B?V011clZCV0xGNzBGQU5IZGFFdjJQK2xMb3hPTTMwWWtMWUIySGJTK2hIb3B2?=
 =?utf-8?B?c2RpeWFFUFkvSzR4K09Va0tVNFJOcTVZQityZWJseUpmdTUzWkdlbE1CcmdD?=
 =?utf-8?B?K2R0YUhjai9FV01lKzRFTlV3N1A1Y3JlUlIxUFhCVTRSL1RJUFJFS1djbFg1?=
 =?utf-8?B?SE53ZkJ1QktiOWZwWEFGNCtZM085Y21tbjZpQ0FPditoSjYyczRFMTlab25Q?=
 =?utf-8?B?Mm9rNG5ncC92RVJFQ2YyZk5WMGhRajB2QzRLMWNGSUVkYlBmbFMwWXJSZkQ0?=
 =?utf-8?B?R01kTGZ6L05Wd2tscXpnTlEzMDkweXE5UHorTTRxQmh5K1dkTjA3WjQ1dllX?=
 =?utf-8?B?dW1HV1BqWmV6c0lNQ3l6VXowQ1d1ak9NVkpTNHBRUFA3M2xUakZjTFBHajUr?=
 =?utf-8?B?TXZVZkFsV3hadjNKTHdMbHRkVzFLMTM5Unl0cldRcHRhMHpneDRuTUZRbWh5?=
 =?utf-8?B?dDVUVHZHbnRSLytJdHY2N3NFL2RJa1lmdmgvTml0dlRlRkZVTTkxQlYxTXBG?=
 =?utf-8?B?NW5UU1ptMk1waXUzVmdkOHNVMW9mZ0d5VVM1OFlBK1NOQ29BYW5BbFJTV3NQ?=
 =?utf-8?B?UURQSWVaaGh1c1hnN3l3UDZvVnlXcUcrYW0yd0N5UHlpSjQzb0hmcmpVTlVY?=
 =?utf-8?B?cW5YTTd6TFNERVNFa2pvN3lGb1BNZFlYSG4wdGVabXFQUjNBTkRGMWU1Q1g2?=
 =?utf-8?B?ZTMrQzlrRUR0bVQwZTg2MFRBK0pnM0t4YW1hT3FWQzJhMElmeW9vS0NNYTJC?=
 =?utf-8?B?US83c0hIY2wwVXd3VGVtZktnVmRZTnhwOU1OS3phVTQ5UmN5dkk2QS9ieVlp?=
 =?utf-8?B?QVE4d2FORnRpVURSWXIyMGppNEFVVTdDajlVYnVlVTRaUlF4WEhHMHN6WGZT?=
 =?utf-8?Q?siLHuZ+Lc/nXwwINtr0qZQNP1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028127bb-e47e-4de4-36a5-08dc5ee56a96
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 13:51:00.9705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMLllcVr1dA0UD+VfyF2z+IO5sxOpG6XG2Czut6EpTRShU4CQofTzImN0almyoi2dD1IjrWQHEr850DVQg80tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041



On 4/16/24 06:02, Borislav Petkov wrote:
> On Thu, Apr 04, 2024 at 10:13:44AM -0500, Yazen Ghannam wrote:
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index b5cc557cfc37..7a857b33f515 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -117,20 +117,32 @@ static struct irq_work mce_irq_work;
>>    */
>>   BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
>>   
>> -/* Do initial initialization of a struct mce */
>> -void mce_setup(struct mce *m)
>> +void mce_setup_common(struct mce *m)
> 
> Since we're touching this...
> 
> mce_setup() is a perfectly wrong name for what it does. So let's clean
> it up. Diff ontop below.
> 
> * mce_prep_record() - the name says what the function does.
> 
> * mce_prep_record_per_cpu() - "per_cpu" as this is a common kernel
> concept and we do use per_cpu data in there.
> 
> Please do this in two patches:
> 
> - the first one renames mce_setup() only without adding the additional
>    functionality
> 
> - the second one does the split
> 
> Thx.
>

Okay, will do.

Should I send another revision of this entire set? Or should I split out
the mce_setup() patches?

Thanks,
Yazen

