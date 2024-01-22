Return-Path: <linux-kernel+bounces-32445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0557B835BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297E91C21812
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B0920DE2;
	Mon, 22 Jan 2024 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JzaI05p+"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46FE20DDE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909226; cv=fail; b=ROcmcv/5Q9/fOcvXIcqiPSqcD3p97UFTOwZ1MDW4rt1Dytv1gtz9reV07BjnTw+UA3fUDeUFGReTc9rYYDbgnklqradZINeaCAynd1QKrXKpcewb1MmL6vVSdKgNINS08vx3O09ikJ2vzuSLKWACdwmHaUpOMJ/bx3UmYIuJREE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909226; c=relaxed/simple;
	bh=oRc3mhuG00Vpq2qLyqKSwbJnviOQ9cBFRy/Tp7lwCiY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BpasZUxUJJXHP6FMrKHVUyVDQ9NC2yIRcj9zUD1JEeYYj04mQ002sQSxIst5TQnz1Vm4bGHGRkT/hwm8B3T/64N5MBUbqlaK7BHZPYgl9mVptgRXFXdc5XaSFXr47qN0zXaPGmj+pGDRNBACoPxtPiDlBDJeSffmXVXfEixbTF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JzaI05p+; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwsJGCQtlWjJYErHa3Dkc0eoOZoVQ8b/xOHPBtI8zrudh/pCkD+zeRcYWPdiXYSEKsMlSaLJigNRrf7Ye4eIjQSPsFjsyaK5SToxKaLPpjkmj1syuv9QvCGczFEl6g/Ld/FJol0k1b8z7M5Ymmn8bV8p30IbJ3Hy0P6oAu11jbQfHt8DQcy5ziyjBQj+uErvghRYcQtYqAg0VtcsRvisTMKT82Nit715FsTWTJzaDDdO0nrbjtFHpx2rnjyQLGMpLWlwnGusmK5X3EZVxB2Ve9Ygkp8CYTGZbSO8H2+FXNP3oI6wJBGhLoZ7i5zimsQJQBWzk6EKPi+z0f9rsT/T/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v99TQeBsDpqNDOEvj/KCpAeo9BfN8T69Zs5H8352G3k=;
 b=JaIEUzxhjNH+6uvtEoQd/yGF+eoLOx6fRpIblWN1t8ieZibXIMmYvybLtNDDBJnYag8jhk1iaTk6edWbEQklSCc8dgv3xStg0c6rdtXgrmUlN5dytrovB8T8rjjw+QgjEqk5D80AHbE5VpUSMI9Lk4tZ8KYYdDYGXXynHLmeWYfztyHw6gYwswjP4FOfg/aKMZTc45YHzYuarjydgF7lABnyIUEW+5gbOmj0oYN1W/taTIdCSU+fPxyXmHBJlpmaNunsZtEfIbCdjnj2GwR4GliQSGDrU+t7HoxzIkPSlpc3P1ADKk2YM1TmqaZ536Y/NDlDwQ14FHmp6V2Z2H8DwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v99TQeBsDpqNDOEvj/KCpAeo9BfN8T69Zs5H8352G3k=;
 b=JzaI05p+OdznMmYqPWGZ+6jtgfPZ52oG3hG9IibzUok+CDulwdi2aTx7LA3NFjzkoju2ohsyUzCe1k0WgtYPDZuG5/cLaXY0mpjTE4KYn0XaGTI8utMSwCJncMiNfL8FgdfJoWRliU9h0rTW0aeupM4A5ncLHZLndF/6yOAT0bw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CYYPR12MB8854.namprd12.prod.outlook.com (2603:10b6:930:b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 07:40:22 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6755:ec77:7e30:bcc6]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::6755:ec77:7e30:bcc6%3]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 07:40:22 +0000
Message-ID: <7fc48153-cee5-449e-96ed-54770b9f5670@amd.com>
Date: Mon, 22 Jan 2024 13:10:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 02/13] drivers: soundwire: amd: update license
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 vinod.koul@intel.com, venkataprasad.potturu@amd.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20240110094416.853610-1-Vijendar.Mukunda@amd.com>
 <20240110094416.853610-3-Vijendar.Mukunda@amd.com> <Za4aeN7vJ-Ln2fxA@matsya>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <Za4aeN7vJ-Ln2fxA@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::35) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b03d64-29b8-4adf-1fc7-08dc1b1d63d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T9XZNwCMGwu2dftWFvGlMhfG23cSCn0Nf49zOqM1D2Z/dAGlcakeMBIMaf4K1FDHtwRyTKqrkOl1YrwHQ14fSyy4EWXkjhrGyqNvLTDDRLsT+/H9IeuQb2EbNR/MZJXfFcwFJTZxDC1pPoidUGRazx9KGaQptSW2SpLBnwOe0mPHAsy8J2G8DzAUh0XKxCfKxlj24BM8HseWZdMmrigoBqZDXJZOSHyMEKKTuV8k9LgPVeD0v7ySNeWOmTsyJwJWdApijsA5qvdWjrGSa8KYX7ox/Jr3mz7f6SvhTt+UKGWv/KIaIBC5wBYhJ7W9ZHP4snJF4rvaU1BkIvU0Mb4wZpq0CLSgrhuCMyAGDthF3OxF8GucyTNaNC2LDuv1/NIBlpzWMpeWeTuXS5gjbLqOFOII3kMqaw67wIYZfk6fnUe2fR+X3LJ7tOkm7T0p0rqyADQpEhlfaQm8D8yeD4naFW9cmkIE/ipxye+TUj6pp+0i2SKnuk2QiPKyDtGIF2Rmy76qv/2DpkxswiCj/XMFj5sYMo/JUuF33gqwCizpjQ+Uh6S8zWd+Q9eonq5AZAVaWkES2WgOMpRgGt1rzF6g1ucGbvn9OB2xrmxf21G6jKGE+u/MZYUiuO+NDF2FZRSnCn90lCDnOfvhs1/L/PDZQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(83380400001)(31696002)(86362001)(36756003)(53546011)(8936002)(4326008)(2616005)(38100700002)(26005)(66946007)(8676002)(6512007)(6506007)(6916009)(66476007)(316002)(66556008)(478600001)(54906003)(5660300002)(6666004)(15650500001)(6486002)(41300700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmdhTFBYS0hlRlFTSVVnWFlZNm9ZRDZzaEFvMDBLZXZKUEhiQzR2dktUbDl5?=
 =?utf-8?B?WDZqWVZPbDFGTnRVUmJvN3VraTBKVk1Wanpwa05XY3BpdUNHNXZNNlJXaHlT?=
 =?utf-8?B?Rm1ZS0NPV0RZdlFZR2RvUjlZR0NwUnpFZHdHelZaUTVhQlFkamMwRDNndUNa?=
 =?utf-8?B?MzNwSlc0RE00eFJ5dkRCcDBtd1V5NXNJVXJxYXprSS9nMVd2czI5QzFmY2JQ?=
 =?utf-8?B?UElJR00vM0ZMdGdvOXZ5MTVUdmJkNmc5OUREWUdJaUhBMjg4N2Rqc3ovQUlV?=
 =?utf-8?B?bUhiMVpjaFk1S0swKzd4TVVSL2cwRDg3WVVxZWIybmFITUdOcGlESndqcW5Y?=
 =?utf-8?B?K2Fiam9DeTIrREZubWtNcFZKcVorY1pOUHh3OVRIalJnTlVBR0cxcXltNkJw?=
 =?utf-8?B?czByTzZFd0JXWGlYUmw1bW1SZHVlcmUrMnJLN28xamVDZ294TzFJdFloUmw2?=
 =?utf-8?B?QzhwZW1YanB2eVZQL2d3eUtLOTFxdEx2bit6RnhWQjMvRDJUMkUyWnhPR3Aw?=
 =?utf-8?B?a0JxQ3ZtY1ExRklVaVRsY3JpRkZzSUVzR3p4TDg3ZDNMZWVvd2JSMy9LRnV3?=
 =?utf-8?B?bzRnTENWdFEvUTNjRHZLNmV0RnJnZnYwNDJKVW9KdmRiL2I5T1RCWS9hbksz?=
 =?utf-8?B?SEJ0dGVFcW5aQWd2aDV2MHhQTmJPNkkyZk9wNC9kNFgzYjg0cWZsNnhML1Ex?=
 =?utf-8?B?VlpiTS9ydFV4Uk5abEEwbC83RUR1SDFNTzBHZ2ZzajVzYU13Z0VmTDJucHlE?=
 =?utf-8?B?STQ4a093WlN3cnc1eFFNVkRGOTZFeTErOUY4MDlzNmpuM2c0TVZ1VnA0T2lx?=
 =?utf-8?B?b3RUcC9MK2huSDZITHd2RDR2QmY4TU9PSWJGTDVGbm00V25lNWozcllwTnR0?=
 =?utf-8?B?VFZZWGxsckE4ZzlIbS9GRCtkR25QMlpWSWZ2NEpiUFpKVmd6OHkzcU1jaE45?=
 =?utf-8?B?bzhOL3RyOEQxcjJDVCtGa01KZWNIY1V2eHAzMUFvY3Vtd09hVGZyWkpLbWF0?=
 =?utf-8?B?aXg1Q3ZtK2UxWHVFVE1kaVpBTmZBVlFRblJBMm5ydjlvVjBicm16YjRFbElB?=
 =?utf-8?B?V01CTlpwUkhWZ3dMemlNb08rNFpsQWxJWkRpd0J5VGUwQUNXWDBZRVU2ZGhL?=
 =?utf-8?B?c2U1QUo3dmkzOU9HMUJrZFRpWHh6WWk2d2x1VUF4eE91SDVkM0c1aTEwT3FQ?=
 =?utf-8?B?aEFsL2ZvdWxHaktVSjRHRUZmbHBZVHU1bnNYajVrWDlFMWhMZVFsKzBOc3N1?=
 =?utf-8?B?UFVHaThEVzJHR1ppdkFPeFBCemZlRURETWF1QXJsUldaSlE3emxwTTBvQUpz?=
 =?utf-8?B?L2lLc3U0OEpTMGNaR0Y0M2dzQXVYTTdSakRXSGI0UXBRRTFROWQ3QW9hQ3cv?=
 =?utf-8?B?RytTVWZGS203cEl5bW9kdEZXQlA3T3hrVWpwcE9wbzJLczMvU0MrN1lJZ1BH?=
 =?utf-8?B?MFhhQUpnNjMybTh3cmdtdVNzNVN1NXlEaTNjbHd4cjdnNmVRMWQ4VVU2SktT?=
 =?utf-8?B?YVllc3lHaS9mV3lLYkxYbTliZnFEQ1BjZEJvNk1XaUgwdXRleTU0ZFhtU2VB?=
 =?utf-8?B?RUVlQTNsbVJBT3ZjWCthSzZpOW81SkhQd2hTZ2hKUmZEMmpLZEliTUJ5QjAz?=
 =?utf-8?B?amFFOFBJUUk0dklsVm15YUlQRHlkK0NYUWFWSHVYaEc2dTZNUjFZbHBJOXky?=
 =?utf-8?B?TXIrK0hzL0EvOTZTRS9aNmJxMGVRd3o2RHFzZU9JeGZCR2dNMUFEWlF5amtN?=
 =?utf-8?B?RWhyOTlkYXBjTkZrcDhSZTNNVzh3ZWljL1Q1N2pqaDUzcnMwajZwd0tweGxp?=
 =?utf-8?B?SlpXVjFjMXhQS2FWRVhJREhjM3dhcTdpQU56ZTVpNkZ4YVpvSUZaQThXS0RC?=
 =?utf-8?B?bkdHMHNTSG1WR2VMVW02RUNvZkFZRXpTNmZWa2V0RUlSdTNNbDJEOHFxbWVQ?=
 =?utf-8?B?MzRUOFl1ZkhwR3lRYXV5UUJZTi85SFRZWmFEYlFwaGNLUE5CRWZEUUlsaFpu?=
 =?utf-8?B?Y0w5akxMaDZvc25LS1hQa1VBWkcyVmd5T1ovZFhQTXFjdWhjVnJFYmE4bUow?=
 =?utf-8?B?cXhjMWFzdWMzRXJMd2hNN1gxZGtSeE92TW03Y0JCczZFWDhaWUZMb29YNGtZ?=
 =?utf-8?Q?GV2Th6e/sx4//pFZwMXHTeX8R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b03d64-29b8-4adf-1fc7-08dc1b1d63d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 07:40:22.5674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epUlutz8exKMpRn+slVQBzmGX8GH6c0T0U8a7FJE/gM7dKCeDslOxSVeiXY3ETci+jUGB8FMsBcpekqfDFNn5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854

On 22/01/24 13:04, Vinod Koul wrote:
> On 10-01-24, 15:14, Vijendar Mukunda wrote:
>
> Why is the title "drivers: soundwire: "
>
> git log drivers/soundwire/amd*
> Tells me you didnt do that in past why now..?
Sorry It's my bad. I supposed to use tag soundwire:amd
will correct it and re spin the patch set.
>
>> Update license to dual license to align with Sound Open Firmware (SOF)
>> driver as SOF uses dual license.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>  drivers/soundwire/amd_manager.c   | 4 ++--
>>  drivers/soundwire/amd_manager.h   | 2 +-
>>  include/linux/soundwire/sdw_amd.h | 2 +-
>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
>> index 3a99f6dcdfaf..afa2d83b7e69 100644
>> --- a/drivers/soundwire/amd_manager.c
>> +++ b/drivers/soundwire/amd_manager.c
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>>  /*
>>   * SoundWire AMD Manager driver
>>   *
>> @@ -1207,5 +1207,5 @@ module_platform_driver(amd_sdw_driver);
>>  
>>  MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
>>  MODULE_DESCRIPTION("AMD SoundWire driver");
>> -MODULE_LICENSE("GPL");
>> +MODULE_LICENSE("Dual BSD/GPL");
>>  MODULE_ALIAS("platform:" DRV_NAME);
>> diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
>> index 5f040151a259..f57165bbb9d9 100644
>> --- a/drivers/soundwire/amd_manager.h
>> +++ b/drivers/soundwire/amd_manager.h
>> @@ -1,4 +1,4 @@
>> -/* SPDX-License-Identifier: GPL-2.0+ */
>> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
>>  /*
>>   * Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
>>   */
>> diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
>> index 41dd64941cef..56b4117c087a 100644
>> --- a/include/linux/soundwire/sdw_amd.h
>> +++ b/include/linux/soundwire/sdw_amd.h
>> @@ -1,4 +1,4 @@
>> -/* SPDX-License-Identifier: GPL-2.0+ */
>> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
>>  /*
>>   * Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
>>   */
>> -- 
>> 2.34.1


