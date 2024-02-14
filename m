Return-Path: <linux-kernel+bounces-65335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9A1854B63
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6612D285AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E5655E55;
	Wed, 14 Feb 2024 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZeRIXnlX"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D56D54BC9;
	Wed, 14 Feb 2024 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920941; cv=fail; b=bp8N5K1cmr5RgilL0li2bD3opD2+zFVD8H8jRpDM0EA02x1T6jQ3Nx5Y8ye96ND/lr3swgc/C2BB+J7RfU/ZQnokrHXQVIQTvnmuiozNSJfJ1fyT6gcIkmyzYwo6+prSPP3l1WQxCH4kEWzlav45RYVewj5YN938VU8kNJ3VG2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920941; c=relaxed/simple;
	bh=ZR/96N/KMyZpvejMoYKusCRF2OIfzlZ8+w3xXR2Ht3s=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WDMPoomE6KIOY6MucPGI2oRttO+viROwFTj4bs/3t1/Sp2sXyRMVJf4nHvUt0eami3FoHFzoCFtGwfYs3n/pez1jYwfiTHMO203RF231tI1jkCX+sej+nNTZcbG+fm6+r1YGfSopPamYJ5bHB896SHEAR8u5mEAJikCofJ1XX2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZeRIXnlX; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XY2xTMisH6NTacBlHBD1+U0hible/HOWu1pfd2OeoDKPJbYGp5+Clr3dTX+hRf4f5/TdSWYCTXucK+/zmjl2ec14Y1cYVBQpm28vUOJ8kizSWF6Vqq5jYi5XpkBJtXibotKNPvZmZH3gObpN4PBLbuwqS/aU32obqUu0fpoL61ghwp6rFs9UkZ6XIx9yM0Dc4gKc8OKeILFHyfs/oTjYJKc1YsvpzKR1By3Yezk4eofd0QhcGyY7aTFsaqyTp+lFIeSG8tKtSaK6AjcP4OIWz3nOK/3/u9xvYUC2g1z+AhFvJU3aJ0Gm1uejDwwQCZakFVOsL46XRaeUF90lfwLOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSyJ0uJlQ7Cn4CiqK8ep47c+ZS0e03OT5IEDfAlZF4E=;
 b=aBqRr+eUuUPgBfYX716FNX4Jm81M/yBcKj/kqID2ahmBrFc2C59CIFGmpNEACV0esJCMI98o60kf+u2ScaN6H9tpGrBk6w21i5e0VvBv/qlCOVLiAUisnSmHIeZcCGg2LE4zdDIEEWdFKJMTGqO0aAIptcElT0lfo2NitKQRS/3d6+qxv0ey8gOdbOUjt3m+She4JHfzQ1RShMTVW2sjl9wY+9D3CPxJmd4ZJtHyzVPHLmYeKu5mDJHx9A3XoM7/J48bmf6b26df2PElRE5IWsI9jPayRxf/z/l/IS3a68DNdNwq0BEFP2h3e3mfjPsFlA9LvO0TothiBng6uHbqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSyJ0uJlQ7Cn4CiqK8ep47c+ZS0e03OT5IEDfAlZF4E=;
 b=ZeRIXnlXSbTAuo+X48hynfssCo3sEHhD0ZTkdvyaWB2PQ7nQ5Pa2/CkO8uJthGuQM4iQ7FB8pD+iPJJRn4uMAERkHi8JKePrbEODdNHHTAtnZcQzRpNhAilI1ZnLBe3pgMnLHH8JTuF84N26IwIVzdTjW+/tk7ag/m2DJBVrQR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BL0PR12MB4851.namprd12.prod.outlook.com (2603:10b6:208:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 14:28:56 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c%7]) with mapi id 15.20.7270.016; Wed, 14 Feb 2024
 14:28:56 +0000
Message-ID: <76fe899b-73ea-4f6b-9821-84240d89b0cb@amd.com>
Date: Wed, 14 Feb 2024 09:28:54 -0500
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, tony.luck@intel.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, avadhut.naik@amd.com, john.allen@amd.com,
 muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com,
 sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214092839.GBZcyHxzsaz9NcijyV@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240214092839.GBZcyHxzsaz9NcijyV@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0576.namprd03.prod.outlook.com
 (2603:10b6:408:10d::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|BL0PR12MB4851:EE_
X-MS-Office365-Filtering-Correlation-Id: 59cc7db1-f43d-4f9f-d575-08dc2d6946f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9nZOZdtFVivUvA6m429dmw6lSrMGz0DBX4UN4XcUTcG9fGjVNFas/nl/z+k03mbF0AGhebpbvN7TgPQC0CgmPAWknyVAhwgnNkGbLe/o5AYR9UAY/NEpKkWAjI1fV/B26LxVET5bRkWBGLSv6b3wZRUWn6Wkco0Grj9YJENyxLIhV/Csaj8yYkFIoUa/cBYKpJ+1/inwejpxihbtVKz01NxvzgUpCYDcYTETFC3HhEnmaPLarOjMz388e6i6po7ZNzr1kygfwr5g9t/3BSyXDZkI32rnn5Nx4pxh/q8KM6MiD6s4lxUNKCeChbO+yJyHyVuD9AvUfw7owUXW8tCEuBUoDt4fpbrBhFjSJ0UuYroiAzz1zZKmBiYJyrarM4UGfloJlgaQbvRWj0mXRhIBqg626jrh/EVPdjfb+QstIIjdRiSkWt68ie8EBUPWetYrpG0BU12ROyAbhmtOuEQ96QHvwNTc7130SL532wR3P3xrlTpZII0Bv9R0Xst1VIGOXJjBPxogJwYowITzWJSzE936fMt8R7GP1l9YrvdmXE49EQC2fQv/oVBToh7UGpxx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39850400004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(8676002)(8936002)(44832011)(4326008)(5660300002)(66899024)(83380400001)(2616005)(26005)(36756003)(38100700002)(86362001)(31696002)(316002)(6916009)(66946007)(66556008)(66476007)(53546011)(6506007)(6512007)(6486002)(478600001)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHgwVzl0Vzc4U1NWUWszb1BPeENpWFA3UFVuL25DVVVrVXlTS0ZjTTh2YjJQ?=
 =?utf-8?B?NWJmdWZQZTdsZ0xwTW1RVXBYQVZDUmc0S1ZvbEpXYjZ5M2ZiZWcyTU1yN3ZD?=
 =?utf-8?B?SU8rQWpoWjNoelBBK0tQbnBEL29SdjBvak9oMzljUFRnZEplRGpKUm00L3lP?=
 =?utf-8?B?bGY5MWJOUzRlV3pUMjlRa0dZdkRSWHk5ZHE1cUFDcStlb2VQeWhFWWo1eEx2?=
 =?utf-8?B?MTVEYmFncWEvbWFvVllpd0RHd0tqZWNlcVEvaXEzYURNbU9uaFNNc0xIRGx5?=
 =?utf-8?B?Y0VISEwwbWNOUnMwczkxZE81TEplR2YwMnBydVo0WFdRVHBGTDZNc2ZjR08x?=
 =?utf-8?B?YUtYZGNGTDBtNkEySzEyM01JNDBFSzhxbngwNHJEbUJnNU5Xejlxb3FYVmNj?=
 =?utf-8?B?MU45N1ZvZHlvclFIcmJVaGY4SDlZUjljSGpXRytzVmgzdDJLMGVZd1o4dVhP?=
 =?utf-8?B?TjNzb0wvayt1b0pHOTd3UDZFV2FNMmJZZmQ5VnBwVXFBN2tCcnhDSjNYdVYx?=
 =?utf-8?B?YnBadytpTElBeWJQVnhQNk5Ld2JlR2JHakM4Ly83eVpvbDBURkxnUnE3ZXRP?=
 =?utf-8?B?S3lOQUw2SUNaWmV3WTIrTGhWd01SN3VublNVejJaNWZla25HUSt2Q3JvMFZp?=
 =?utf-8?B?R24rZS95WEpBSEd5VURCdkxvakVNWjJ6RTVxYVdIb0gyYzVuZC92T2U1Tzd2?=
 =?utf-8?B?eDZHUFQ2MmJZUVAyWE4wc0loNzFVQjZ6UWM4WDlzam9MLzFwUEREWGx5WWFQ?=
 =?utf-8?B?c3NYakYwc1Y5citaVjgxMUpmOE5wTzVRc1hodnZxMVBGb3VSNlBhSHZwMTBS?=
 =?utf-8?B?bG9McmRJcHlNSW4xTGdDQXlMNHlpRStidSs1LzhQSUV4N1E2SlVNdEVJVnl2?=
 =?utf-8?B?WEVZTzd6SWVyWUw3Uzd1dnY2cHRyVllMeTlGMjdzNkZCdTA1VTA2bXJsdHRm?=
 =?utf-8?B?Q3hvNFFUL0ZlWW5Gd1FZU0c4U2NNY1NPN0R3eXhWUW1GVGx6bnlLQ3VzV3A3?=
 =?utf-8?B?cDhRSk56RUQ1Mi9HVXR0Q2RYT3lhemkzUFhRL0pHMExrMlNZaytTWmhMZTJO?=
 =?utf-8?B?QlpXWGd5NjZkd1Z6NkZjOVljcDNvaU52TmEyUXVObnE0eWRZY1M3YzRFRWRN?=
 =?utf-8?B?dzlPRzJrdnRFNGVZOU04VVVQUHBtd2hJTXI0anlSaC95QnFkcFllTW0zSEdE?=
 =?utf-8?B?OEQvbk9Da0haNnRGLzJoZHFRNUdIRW1VY0w5Y0Y1ZTFNblhHK0l5TU5KWWlC?=
 =?utf-8?B?UTQzNGZUa0N4NWJrWWU0Q0dlbzN5dkRxSC9Ed3ZGVW1hei9XYjRWS1JTMzNR?=
 =?utf-8?B?MGhDTlY5S2cxeTZZL3poZkYrek5URkVDelc4QnVtN0lIMUZyR3o0N0lFYStV?=
 =?utf-8?B?eXVWUUpXM3NnNkhhbmYyclFiZ1Y1UVZ6MmRzS0JTM3ErczdBQlZSTVV4LzZK?=
 =?utf-8?B?TTRYaVplUi9MOWJZOEhscnZ0eUZMcGpFWU1aVVpoclZOMTIwU1E2dmViL3g1?=
 =?utf-8?B?aDJTd2JTUDJvOEZ6VUFQVEVZR3hpTlBFSUpwYnduY1lSWkhzTnVuY3hFVnZN?=
 =?utf-8?B?Wmx4MnB4V1NET1BXKzBDbXBaNG1mVUU2TXF6RmRKbmZ1RTBCQTh2LzRVQ3Nk?=
 =?utf-8?B?RDQyL0tRRE13RDlacE9YMmxGWFJCQzNLZzJHSG9ySWdNN2ZlQ09kUktNZlZh?=
 =?utf-8?B?S3ZpQVRwbHVmcUl6TU5VVnBUdjhvTVZZT1BGeEc5RDM3OElXd2VwTHUyZDJn?=
 =?utf-8?B?VlRrdTZmTkx6a2xSWTMrNmpxMDNHS0F3UTVRZHpkWHlqUnFmRHd0MWppaGVs?=
 =?utf-8?B?Q3grU2YrdGQyRENzYkkxbXB3TjJ2c2RnTmhncmxWWlgvbHBmNm05bHRSZVVa?=
 =?utf-8?B?QWdvUjlVUXlXTFl2aXBmZWdQQlJtbzRJNTBkb3FaUkJGNmtPR3VGenlIS0JQ?=
 =?utf-8?B?NWNRVUFqNVZXOXErVWZNSG9xeCtCYU84RTNGaVVJbVhPQmZlSGFEUTd5VFB3?=
 =?utf-8?B?U0RwSnQxWEJ6WDZtYktieERybDZvYTFwMEdNYUFpek1mY1BRdEw3TFlVWTIr?=
 =?utf-8?B?UFNFSk53dHNqNkJEcTNhZHVTRWNMZVl2eWNkbzR6Nkg4c2QxT093WXU1VVdV?=
 =?utf-8?Q?4KGvRZxP0thUxIrbhUxcjFOvv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cc7db1-f43d-4f9f-d575-08dc2d6946f5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 14:28:56.6092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UeR4kSwKNRpAjIKZFIv6wi2p8XR9r9C3rNU4Lx3HwdkyfRBAgJoIgScbwx4XT3vNkenOLSWDBrAaaGkmyjV0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4851

On 2/14/2024 4:28 AM, Borislav Petkov wrote:
> On Tue, Feb 13, 2024 at 09:35:16PM -0600, Yazen Ghannam wrote:
>> +config RAS_FMPM
>> +	tristate "FRU Memory Poison Manager"
>> +	default m
>> +	depends on X86_MCE
> 
> I know this is generic-ish but it needs to be enabled only on AMD for
> now. Whoever wants it somewhere else, then whoever needs to test it
> there first and then enable it there.
>

Ack.
  
>> +	imply AMD_ATL
>> +	help
>> +	  Support saving and restoring memory error information across reboot
>> +	  cycles using ACPI ERST as persistent storage. Error information is
> 
> s/cycles//
>

Ack.
  
>> +	  saved with the UEFI CPER "FRU Memory Poison" section format.
>> +
>> +	  Memory may be retired during boot time and run time depending on
> 
> s/may/is/
> 
> Please check all your text - too many "may"s for something which is not
> a vendor doc. :)
>

Ack.
  
>> +	  platform-specific policies.
>> +
>>   endif
>> diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
>> index 3fac80f58005..11f95d59d397 100644
>> --- a/drivers/ras/Makefile
>> +++ b/drivers/ras/Makefile
>> @@ -3,4 +3,5 @@ obj-$(CONFIG_RAS)	+= ras.o
>>   obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
>>   obj-$(CONFIG_RAS_CEC)	+= cec.o
>>   
>> +obj-$(CONFIG_RAS_FMPM)	+= amd/fmpm.o
>>   obj-y			+= amd/atl/
>> diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
>> new file mode 100644
>> index 000000000000..077d9f35cc7d
>> --- /dev/null
>> +++ b/drivers/ras/amd/fmpm.c
>> @@ -0,0 +1,776 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * FRU (Field-Replaceable Unit) Memory Poison Manager
>> + *
>> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Authors:
>> + *	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
>> + *	Muralidhara M K <muralidhara.mk@amd.com>
>> + *	Yazen Ghannam <Yazen.Ghannam@amd.com>
>> + *
>> + * Implementation notes, assumptions, and limitations:
>> + *
>> + * - FRU Memory Poison Section and Memory Poison Descriptor definitions are not yet
>> + *   included in the UEFI specification. So they are defined here. Afterwards, they
>> + *   may be moved to linux/cper.h, if appropriate.
>> + *
>> + * - Platforms based on AMD MI300 systems will be the first to use these structures.
>> + *   There are a number of assumptions made here that will need to be generalized
>> + *   to support other platforms.
>> + *
>> + *   AMD MI300-based platform(s) assumptions:
>> + *   - Memory errors are reported through x86 MCA.
>> + *   - The entire DRAM row containing a memory error should be retired.
>> + *   - There will be (1) FRU Memory Poison Section per CPER.
>> + *   - The FRU will be the CPU Package (Processor Socket).
>> + *   - The default number of Memory Poison Descriptor entries should be (8).
>> + *   - The Platform will use ACPI ERST for persistent storage.
>> + *   - All FRU records should be saved to persistent storage. Module init will
>> + *     fail if any FRU record is not successfully written.
> 
> Please drop all that capitalized spelling.
>

For which parts? The acronyms, structure names, or general things like package/socket?
Or all the above?
  
>> + * - Source code will be under 'drivers/ras/amd/' unless and until there is interest
>> + *   to use this module for other vendors.
> 
> This is not needed.
>

Ack.
  
>> + * - Boot time memory retirement may occur later than ideal due to dependencies
>> + *   on other libraries and drivers. This leaves a gap where bad memory may be
>> + *   accessed during early boot stages.
>> + *
>> + * - Enough memory should be pre-allocated for each FRU record to be able to hold
>> + *   the expected number of descriptor entries. This, mostly empty, record is
>> + *   written to storage during init time. Subsequent writes to the same record
>> + *   should allow the Platform to update the stored record in-place. Otherwise,
>> + *   if the record is extended, then the Platform may need to perform costly memory
>> + *   management operations on the storage. For example, the Platform may spend time
>> + *   in Firmware copying and invalidating memory on a relatively slow SPI ROM.
> 
> That's a good thing to have here.
>

Okay.
  
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/cper.h>
>> +#include <linux/ras.h>
>> +
>> +#include <acpi/apei.h>
>> +
>> +#include <asm/cpu_device_id.h>
>> +#include <asm/mce.h>
>> +
>> +#pragma pack(1)
> 
> Is that some ugly thing to avoid adding __packed annotation to the
> structure definitions below?
> 

Yes, but __packed could be used too.

> "GCC supports several types of pragmas, primarily in order to compile
> code originally written for other compilers. Note that in general we do
> not recommend the use of pragmas; See Declaring Attributes of Functions,
> for further explanation. "
> 
> Oh, that 1 is something else:
> 
> -fpack-struct[=n]
> 
>      Without a value specified, pack all structure members together
>      without holes. When a value is specified (which must be a small
>      power of two), pack structure members according to this value,
>      representing the maximum alignment (that is, objects with default
>      alignment requirements larger than this are output potentially
>      unaligned at the next fitting location.
> 
> So do I understand it correctly that struct members should be aligned to
> 2^1 bytes?
>

Yes, no padding and no reordering too, I think.
  
> Grepping the tree, this looks like something BIOS does...
>

The BIOS does do this on its side. We need to make sure to do it on the kernel
side.

See <linux/cper.h> and <acpi/actbl1.h> for examples.
  
Thanks,
Yazen

