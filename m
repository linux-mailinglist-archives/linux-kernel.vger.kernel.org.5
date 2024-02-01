Return-Path: <linux-kernel+bounces-48905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A78A84630C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F43A1C23DB3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06653FB29;
	Thu,  1 Feb 2024 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WSN0YSJL"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0969E3E497;
	Thu,  1 Feb 2024 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824752; cv=fail; b=foN7TKWHwbQrM/GlT014cPHM3v0XvZQHT8Y8Qznf32xxKrBU9pSJcqbm9bSAQZyCS2W9+fnJRafpqC8R6s6VLbr1Wi99FJo9udGf1qCn1wuKCZmo0n7kX0Ceum8+pVpxG1N1fFWxsnl+aGdEP/O9co2176VYiLpm4jkk9AXz9EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824752; c=relaxed/simple;
	bh=aLgDUrKleIP05rrrgtdh+2TAbHmkEqbDT6KfhfRmj/0=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AUrML/e0U8c7sjNVOt+Pj9vVKWRrkAbwn/qdMg2bwQmxoTnMm746/SXDFE68bG33FaJqXKz568mbjtLtTRctifrBwtkcjs1KAiEzwqnNutolw+DGDaK5SHM/ceEBNjf+z/5z4s7l5l8Ii4KalLsH7/XFXwQt4pjABmCH83Kt8mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WSN0YSJL; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyHQHW98c0/cY20pCiHDdMwa4bOWGlCeN006fHHpbFTRFhyTuazEFMMEO/nnR9G+nq1dzV2epLR7OejJdbtUXnuWCXAo/0mmiJxP6Nq5hc2n/gnsyS7aXhCSr+G7qshU5WHzhMrSPHOhwflpsU0iK2cBmdEw5Dmp6Qxw5ywj7VttCg5UzvV1C71vMMWrzm/kpGWvTqWs+6rtVKB0NLoWIG3QEUvxGkIB2cJWT2IQEGtK17mHeFw4GqmeAMCWyjZ+3rt+Y7l0Sj6WqT2SewMCVLKOwqH2GCP0N9svrwEq1JfgZhANcztkDudl9wCzcMWtvYfksBoV0CUx6sKaz3/cQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPA+pRDuWpfNbeJ2WRWkWmbpUb8AYFe9pNWN0sfGdZk=;
 b=JN41nEMT/FE8DPhaOwrC+V69B1ypgBjbbzrUECARwk0zhtNLJ0dFEgeEp5CPUSrjI/Wylo23tx6yqc95KlfOVQ+12x21grlWtw+bxJWRhJ8bEuVrHzG2ngP8vzN8ToUOSf3JB+8SkiMhbkyFaS+ZwYlUASzhEEVIgvDD8Tzk1EeKFnwhUoFDfSw4GBo+6Q/h79rUpLsyXpAbWxvSZXxk6pU93QV/isRZqBfAwa5xx6cgzlq4ReI87g9DHWt3ExTdSHlTUshZ58anKLrlxynVqZKvmXPN8CCQ0HlE11jhDH3KpArF3GmJYusg6Wh3Pkg49Q87usn1D21nN9I8IRePiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPA+pRDuWpfNbeJ2WRWkWmbpUb8AYFe9pNWN0sfGdZk=;
 b=WSN0YSJLTYMPcxNdEuipTL6O2u76ApMZos9GNidU43opvZjzrSwte/Bj+bomvRXyfhhGSUna7NhAlK/iIDFcGygT4ijAAhsu4D/c/ROvCRvziMXmVH+rNwYoHqb8olPl8W7+Utbu0IWJCe3U79yGxpeCVaiqeTGTsmiC4Qpt8vY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 21:59:08 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c%7]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 21:59:08 +0000
Message-ID: <20e550af-23b7-4583-af91-0bba4c9529f1@amd.com>
Date: Thu, 1 Feb 2024 16:59:06 -0500
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, tony.luck@intel.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, avadhut.naik@amd.com, john.allen@amd.com,
 muralidhara.mk@amd.com
Subject: Re: [PATCH] RAS/AMD/ATL: Add MI300 DRAM to Normalized address
 translation support
To: Borislav Petkov <bp@alien8.de>
References: <20240131165732.88297-1-yazen.ghannam@amd.com>
 <20240201092148.GBZbtirOfNAR3SYmht@fat_crate.local>
 <132e22b9-2e42-4d8d-a2ea-14023bd5dae1@amd.com>
 <20240201150543.GHZbuzR4_KJHbCTI1H@fat_crate.local>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240201150543.GHZbuzR4_KJHbCTI1H@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0506.namprd03.prod.outlook.com
 (2603:10b6:408:130::31) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a24c2d-c1c7-43d0-6d54-08dc237103ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	25/3VXTCJ30MStMefmSiMtfNZbc+JUooHNAAkzL27mAHI6P2kc4GizVxT32nTf5W/eI9HuhBk9kf7PfrjgOvu+lNM0WhBfWgPabMyBnyKF3tJlDGxzuXKWQI0nQ1TI4P6bkk3YkdJeoYZ5OG5D5UKJ3+sgmRq4FVz/DL2xtXtA1NH8T3x3SZ0ggwCJR4F5bLHL1pVGQPUaBfYq4GziAVRWL3xtykj50XB+FoAQ2iLLcUJMJwINFiCzevyt7NLrJorD/7sEFsXTANPYAgaZQ3OdBtcumXv6yoIHxuNYQD6zY34IU2I0qTxwXPVOfJAPdwciAXVMorwuFO94lIAvBMkcZcwSGjbalmZkNf2ru0rDVuFqWtno9gayjs21bI4P6UGsGqXWfWfupQuKnLNFa+w+WyDdGDJCnZfSxgR9N60P8Qx/AanWILbOPjqogs6LzaTuR7SipwIG/+aCbmyrzTb+Yr6fbER4H5klQPEBbPKQZCWmUQUy3JHesNIdxo/nurpeobrxatEIJX1nJi1OMemkrmgzWnL+ndCE6ojJMJhGBhyN5XSFqSO6tMdGN7QCb0ZU5SpJEorTlSig7rmx5/rcglo3q+KQORVaEWP/1paQ6ZjFAgB69mEGbJTgMBRK6x75wENPoxn71gcbB7DTePTA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(4326008)(6506007)(6512007)(53546011)(478600001)(6916009)(5660300002)(26005)(316002)(8676002)(8936002)(66556008)(2906002)(38100700002)(66946007)(6486002)(66476007)(83380400001)(86362001)(44832011)(31686004)(31696002)(2616005)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEdraSt4anRod3dQVGw4eDJPdXhHdDNSMmd3Rnc5VzFZVnNXYnVoN2tWU1NY?=
 =?utf-8?B?N3MvVkFuZTBubmxlL2lRa0NRN2YrY2lzNmltMk9qcmhmR1I4aStsOU8wWFdm?=
 =?utf-8?B?Vjh6RUNUWWtCdXBzeEFPU29RR2lmVkd1RFN5ZlVnRWFqZDdsVDJqeEl0Q0wx?=
 =?utf-8?B?SHM5aVd6WWVCRncyYjlkUkVLYUxIMkx1RkV0SGJRaURKUkZmdmEyTzJGcFZS?=
 =?utf-8?B?QnJOUGdSaTdYRlM0OTJHQlJGcjFXUlRSQjNIV0M0OXJJQzUzUytEZEhXR0dZ?=
 =?utf-8?B?bWgwY0RBbmd6aVY1UWtGTFlkc1ZLSmFadGJCa1cveDF5NmVQcHlLMEV2azRk?=
 =?utf-8?B?MFhxYnhZNDFIZkFSWnllU2ZGN0sxZmpBeCtRSVVZODAvWU03aDRDT2JVVWlD?=
 =?utf-8?B?SWNLY3pNbDVjTEVtWTVtTmJSS1o5bys3dnNxbWk5aVpYVGwzQmN3djY5cTJW?=
 =?utf-8?B?d2cvTTlqU3owNWRKYmM0QnRQY2V3MHc4WndtdFFHSDh6aURTcy9CNHdoOEZp?=
 =?utf-8?B?SHJ1N011UXFtQStoUFE2THA5QWhKdVB5Q2R3bGpYbzM1UXQ5V3c3MkNRV1Fu?=
 =?utf-8?B?WEpCMCtmdkFsOVVWb00rc0JNcWNKUTI0OC9MUUFWS2VEYjNoRmlhbFREVith?=
 =?utf-8?B?T3QzbFF4VjZocktuYUlLQWRjVjdUV29ka3o2TmdlWnNPY2FiYW9tY2U4OXhI?=
 =?utf-8?B?NVlQYXl3dEhJNHVhdVpuN2sxdURRaUx4OTdNQ3dCVldlV1h5SWFsemxjM29E?=
 =?utf-8?B?ZHNQV09uK21YbFBkSkh0QlpLWEkzeGdxNGpPZ1VvZ09xYnY4VVplcWU0V3pl?=
 =?utf-8?B?QVhELzhEczlaUWdiUXcrSFZBaXpEOURRTWY1MXRINndySjRmWld6T0h6VExa?=
 =?utf-8?B?NXZQb3ZxT1lML0NZMlpwU1dzcjhEVGhoZUIyek45VUdRS3ozYTAydlRnUGRQ?=
 =?utf-8?B?alFKam44dEJEZHdyZlo0OU9GakgxY0EzRllGMVB0SnVDdUxVRThKcGJlVXBB?=
 =?utf-8?B?MHozN01PcXR0RVVZcUFES1JsY2pKMmxjZFU0bGhIWHAycDh6SDdCYUNsM2VX?=
 =?utf-8?B?dVRHai91aDBJWGlsK1lDUHJGcDZwQVBrMUliczd4R3JOMmZzaHovMFoxQ1Nv?=
 =?utf-8?B?QzBxREFGcm9pYWo3Vnh6U3Y2VjdvSzdZbE01NnFKdzQreW5BdjFMR3FnZEVl?=
 =?utf-8?B?WGV4T3lzc3JoY1dmRHlFajNYZWJRWWsrMVM4TVpnYlVtK1ZvT2I4Q014SGNN?=
 =?utf-8?B?VXRJS0ZuUjdNU1VPVHlYL3pvTHVDMGNOUjc5VmkzcjAxaW12Z08rUE1uMHU2?=
 =?utf-8?B?c2tERXI4NlFKYnpUNmcrR3N5WTVLT0pIQ284djJxTHpLWFdaV1YrRy9ZKzN5?=
 =?utf-8?B?Y05PODZDVnhDS1FtcDUrcXN0a3E5Q1dVcDIwSjJsWGxvaG0wNGsxTW9uaG5t?=
 =?utf-8?B?cGZOUUUyWENvdVFnODYrYUZ0TTM2c2xPOTBmakdiRW5mSWgwaVpwL3NoSVZl?=
 =?utf-8?B?bmxYRGQ5M3h4YU5YOTM0eTFPZzhpUWZTOC9hNVJUZHZMSE0zNzNEZjVBVG0w?=
 =?utf-8?B?cThseWM1Sld3dk81V080ZGE5WHViQ0J3SXFIbXV2UU9tb3NlMVNXK1BQWmwy?=
 =?utf-8?B?U3NyWDN4bTVPNHlGWEkyMjRtSGtYZmVBM2ZESWk4cGJGalRrRGZLS2hlYzBr?=
 =?utf-8?B?UkxuK21EU3dLSXMwMzhZeTFuL2xrUXFlK0U3MEt6ZEJLcGk1QlhBb0hLTHU3?=
 =?utf-8?B?cTRNTFY4b0JKQmVsUkJveWJOd1JPV0FGSGhSVDMyaExJME1oZG53RGxBUXJR?=
 =?utf-8?B?UTd2MmZCdE5vOTJNUTlNWkVYNXBEUjFUeHkrdTFRTmJCS244RldNOERuVWs2?=
 =?utf-8?B?aEdpckh4b24vK09GQ2cvSjl3KzJCeHZNZzFYWUlhbGxKQ2tXcTU1S3JWN2wy?=
 =?utf-8?B?NUt5dS9IYXR0VitpZWJmMWZ0Qnljd2twM0JYRTFLenN2eGhLa29kVjMva3dP?=
 =?utf-8?B?cGM0dTU0NnQzWXMweURjVXprcTI3RFBldUU0cFFDNVA2WHdjVllkN2QxT1F5?=
 =?utf-8?B?eERBVVczMmFtcUFZcHZmMkVsZmtTOUN3L1VaZkJqVWZMVXJqbmNrV1RzQ1Bw?=
 =?utf-8?Q?mlRBi80A0B5bkWjUrLkzRza9y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a24c2d-c1c7-43d0-6d54-08dc237103ee
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 21:59:08.5383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoFqIqDhjmQ6mdAzysrIRfU5imW2iZ/+F/1db4hZj/R8mvDfXZFc7DTc1vsXVVIBy/N6crp50T1jQRyBav+kGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491

On 2/1/2024 10:05 AM, Borislav Petkov wrote:
> On Thu, Feb 01, 2024 at 09:35:13AM -0500, Yazen Ghannam wrote:
>> It's an operation on the bits within a value rather than between two values.
>>
>> BTW, I looked up "internal" in a thesaurus, and nothing seemed much better to me.
>>
>> Maybe something like "xor_bits_in_value()"? This has the verb-first style too.
> 
> Ah, ok, easy:
> 
> ---
> diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
> index 67dc186a1226..7e310d1dfcfc 100644
> --- a/drivers/ras/amd/atl/umc.c
> +++ b/drivers/ras/amd/atl/umc.c
> @@ -49,7 +49,8 @@ static u8 get_coh_st_inst_id_mi300(struct atl_err *err)
>   	return i;
>   }
>   
> -static u16 internal_bitwise_xor(u16 val)
> +/* XOR the bits in @val. */
> +static u16 bitwise_xor_bits(u16 val)
>   {
>   	u16 tmp = 0;
>   	u8 i;
> @@ -181,8 +182,8 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
>   		if (!addr_hash.bank[i].xor_enable)
>   			continue;
>   
> -		temp  = internal_bitwise_xor(col & addr_hash.bank[i].col_xor);
> -		temp ^= internal_bitwise_xor(row & addr_hash.bank[i].row_xor);
> +		temp  = bitwise_xor_bits(col & addr_hash.bank[i].col_xor);
> +		temp ^= bitwise_xor_bits(row & addr_hash.bank[i].row_xor);
>   		bank ^= temp << i;
>   	}
>   
> @@ -191,9 +192,9 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
>   		/* Bits SID[1:0] act as Bank[6:5] for PC hash, so apply them here. */
>   		bank |= sid << 5;
>   
> -		temp  = internal_bitwise_xor(col  & addr_hash.pc.col_xor);
> -		temp ^= internal_bitwise_xor(row  & addr_hash.pc.row_xor);
> -		temp ^= internal_bitwise_xor(bank & addr_hash.bank_xor);
> +		temp  = bitwise_xor_bits(col  & addr_hash.pc.col_xor);
> +		temp ^= bitwise_xor_bits(row  & addr_hash.pc.row_xor);
> +		temp ^= bitwise_xor_bits(bank & addr_hash.bank_xor);
>   		pc   ^= temp;
>   
>   		/* Drop SID bits for the sake of debug printing later. */
> 
> 

Yep, easy :) Looks good to me.

Thanks,
Yazen

