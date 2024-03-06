Return-Path: <linux-kernel+bounces-94706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 863638743CD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A37281697
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECF21CA83;
	Wed,  6 Mar 2024 23:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xt7in5PT"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE951C68D;
	Wed,  6 Mar 2024 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767318; cv=fail; b=a15rhbUp5rFxW9Rl743lTR6X7uz8TpIaEUkssYzzDn9lXb3TXvNRpMB4IgV1viClzNzQVAi6+TtHxi86PfGuCOJ52smScaqHS1EeV5Bl1wAbq9/AfMfh/Sgjah3y63YUAhqUKS1/1LTMPKEBe0FFcT1YQnICB6SuT7FURufFEgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767318; c=relaxed/simple;
	bh=NKNvSgVoTPcIvBsFNfJSVddCW0jl63BDJDnYjrbHULo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o5HMEtiv6EvuXeqk+rdYhTjDLNsIJlE2/2kgr6A9owsQGBzGVHsITdfWr4iuxI8a+VE2vTY4mIUW5HxunZ4ewlEcoji747ccT+fxtdNW/KYnAVGLDt3hQNJYGz9z+lCX2MD31POFLkh+7V4vOGFwOEOZYIqoozy4t6v6+c0hRnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xt7in5PT; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGISqU/ZQM53YZUPGqiWF/VhQJlCUBCIfjXykbBb86OPYZGTIyhIhYtjsuaGkCN02Tug8x0ZSTSvIUoBrYdmQIC3PLpeE3XGr2yUL/kfVCsRqe+FihWcPMg/YO52jwZXlaY7RCJG3TwSmnMvImHMV+NJyR5m5IF2wxgLvzArSi/15Jc7lxNO/7Yd9HPGZmtim2KrRA3FUUTtZqYYvWet4SnQZWGFEr5Jn7qZNWNA5d2NasAIlVB3mskKluRmWuwQwS64cJ5MVUVgP7SP5k4GDy9oMi5RwggRdiEq0Br+bdYxCm1Rxva6LWwdY6KcBc0BLt3LEctFjn5hogelkr81gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIsVDwqXxWN9bp8EXejXkI3a7On8R+07Z0IChB02QOc=;
 b=EoYxlHsej2Jiz8pOAmm92kY5ISMmGzcu70uQMJVveoUV9H8CiwoGzDDrjq/IK8llOlFq86exVA4CDd3RnzRQGzR4FcnAHMLzszaVd2gCMZ6V/87JSEHDY96YRHwTbp4iZM9/QGD8aB6O/4SlunwhL6OX4DJBCDPuOHAx1oM1Ojnt03BgaNi2gePGEVVC11SGVasLsSibTZ/mZXsPOFyLcrhbXqXGDNMNEiIDEy3uDuaRFEgyc82eOrhH5iHCV8Rz9upt7l4wxkjaXUqYeWlvDhP35DZMlhSRKY+fvi+mzEVWOfcea6GmSR0ynnNcU5IhkuoP5vtearpbtYJMNnjggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIsVDwqXxWN9bp8EXejXkI3a7On8R+07Z0IChB02QOc=;
 b=Xt7in5PTs9dIS1rBrRuYP8SwTZe6ETp6kyb+zmckhh5OLiGAO7+gG/Tq6d1ChbzCaF1MCyne/6nUQ/M6phTmP7yyE0FX89eQHbSrd3gMAWk/9N56acKhaFxFuGEuFxfejcRYCXgRRYi7BtlKL4118AFVVkUMGdmdyAGrbHDSTI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 23:21:54 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14%5]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 23:21:53 +0000
Message-ID: <cbf11eb9-ce90-426a-a27f-623e6c350426@amd.com>
Date: Wed, 6 Mar 2024 17:21:51 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH] x86/mce: Dynamically size space for machine check records
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: "Mehta, Sohil" <sohil.mehta@intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
 <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
 <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
 <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
 <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>
 <20240212224220.GSZcqezMhPojxvIcvO@fat_crate.local>
 <Zd--PJp-NbXGrb39@agluck-desk3>
 <e6675835-46ca-4183-86ce-008fde928e73@amd.com>
 <SJ1PR11MB6083F8541423267B852C510CFC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <SJ1PR11MB6083F8541423267B852C510CFC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:408:143::7) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|DM4PR12MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c33fa3-259d-4c86-554f-08dc3e343587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FKFJa7iWzYbb7Ftc4QTdhvZcGTWlXY1EKspRd+/DPchITDSGst1DkaaV/Ga2VNQpy75SeD0LiH45Uhte2jnGbTEyAO63R5zkDhGne8xrGQTCDSa4O8YUWpMSjs09xt2oMRp+3Swz7cKj7kkFYJ2M+jyWcp/J7sI1Er4jCovCzPFscTOaCPrJAhA2HpwUh9H1a754wSW7htLPfIDtJgGl+PUMb3GtkdBwZaEg0mdrH4s5GTYBLnDMkDb0si/vVhF+BXglExL2oKob+HQPl2yxWq8VAL5OvSFxX7gwvsySm+6heN/AexJ9SpGnG/Pftfkeq4izoGEO+O4R/rFDDxZlNaUNZmwiGNp4BB7K+ExWidIKhsPsahUN2D08aunfFY3T2uJyw0xVjEW/trp1+/IU9XMAVRNNSHyGgRcbYKdqXnsCHnsrX3sKZALLHdYx2mCoYMFJDTWTuCgrftV9HfbfiiAqfDcafXLikzLvd787LIk673Rvou3PDkOfDugeS0xErqHkzL4g9F5+zzX/iR6C/WzHXjKgeaHwDn4Jr0Xd0Xjxx8SJ3PMy+yolbxJYc9tQ19ZeIs0jcUf7kv5sE4dUFdHHCB7U3SNuEEfCg7nC1uMHHTbXzJyIkoyMMTmnDibL+gWQHl96mJ1u/i6MuGcB+F8pkvcTisl8pZLwJt/gDqs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVFWWTFDUlp1aSs5Q2wrZ3hNYi8yQ2NXNHZKMTNveW1RUXJPa3ZnT2NuU1Qx?=
 =?utf-8?B?eUZFSzhGVVN1Zkh3Q2YvYVU3TEdaVnNWOElkWkhxd2lKVS8rbG4zM3dtcTR5?=
 =?utf-8?B?SHNOODJ5ZW5vSi9kWS8rYjNlMEJPQUVrNlBqY2FRc2x1Zk5PV0FRMkp0QUg5?=
 =?utf-8?B?TUtacmowalF5RUFqVHJ0MkxaTWFIZkdTRklhdURZT1JrYkdCZmh5SGJSQ0Y4?=
 =?utf-8?B?TUhobC9MN0FCbFVvN2VkOUVQUDRsKzlTaXQzSnBBczNSNXhMWXQrS3hxbnVW?=
 =?utf-8?B?d2VNUHM5Y2puU2drc2NZeVcraEZrRGNrMVZXWUZwV1JqR1h0RXEwNGJ3VXMy?=
 =?utf-8?B?TVJoOTgzd2xISzJLRjcvZGtOWFZCMnlmckp6THJqdTBWM2E0dXNiVy9QRUlJ?=
 =?utf-8?B?VUVGb2h6WGxhSVpxU0JmNm1MT280aE5mbEh1NTZsenZVYmJISjhKMG9oMVVv?=
 =?utf-8?B?Nm5zc3R3NXkzdlNtd2d5OGJlSlhyU1NrM2tBVG83OFoydVJ1WFppS2lIZUpp?=
 =?utf-8?B?cUJHNGlMY0djN0t1R2FRdzZBa0RpVUo1dnpQZUF3cGdLTXd1ZytLdFZDamg1?=
 =?utf-8?B?enl3R0Y2UXBrTU1tTkdLbHFoZ2grbDF2MkU1anh6ZWs1V1RGZFh5RnRyZTVx?=
 =?utf-8?B?ZWpxVEphOWNVajVuSVAySThhc2w4NkFVUjhWVVkzeEZmV3R3cG5aUlpJUUhk?=
 =?utf-8?B?Z2N6WUZmKytRUWpIQjlQLytrMmhQM09kY2pBczNYbitDcmU3RnltbG9Gd3Nn?=
 =?utf-8?B?UmZOazFXT1NyYVNDVFRvU2prUUREZW1QWmJqTVppWmJmME5oaDQvRFNWc3RQ?=
 =?utf-8?B?ZE01ZmZVRWwrODdzK2QwM0pKOVBZdDFTeU1JRnQyd3BBYXEzUGRhODlqMzNU?=
 =?utf-8?B?VGIzMUJGeDdjeTQrNHhmTnNjeldxNEd2SzZrMXhzUFNjM2pKNHVkMnptYmNy?=
 =?utf-8?B?Z0tiYjN4TzlwclFnRFp6a0lsM1EyNHM4R2ZzQ1krS1NuMGxlbnZHdWJsYnRz?=
 =?utf-8?B?NDRZT2phYjBhVEJEblYrZ1ZtRk9zT3VQVXBKWTczQ0w4SmlYY095UDFxMWxI?=
 =?utf-8?B?NHRxRkZrTUh3aWpCc0ZZRWRldStYakhCazNzQnlJblllS24vbDljZWZEOEVS?=
 =?utf-8?B?bFdzSHMrQTE5dThDazBEZlFpUHl4ckMybTI5OTE3MDJoT05ZTlMvTE12bFhR?=
 =?utf-8?B?ZmQvY1NhSEQ3dWdYZi9YZnEvd3ZrMGNDOVM0cjRUN2J4bWthVkhaL3ZwSitG?=
 =?utf-8?B?VTNiNC9pMEZ1d0NNTXlaQ1J5M1ZNcFByaGJOa21sdjFFaDhDYWJpeXl6MHNw?=
 =?utf-8?B?ZDNzNWd2NDdXUDlpOWd4V1Z2TWl2ZFV2OFRzVlhmcjBJOU1FbDJvcnFTc0hx?=
 =?utf-8?B?NDE5ODZMQ1Z6aTMzUm16Z1IvZ2tHUkROaC94aTB6elR4TVY4Y1VLWis0bWJP?=
 =?utf-8?B?c1hEeDkyTnhpdDVlYVFQQWl2cjRhKzl3Qkt6UzJ2cGxiQ3h0TVhpZUIyMDc5?=
 =?utf-8?B?M0xibXl5eTluQUViS2x4MTcweEdLNGxjNDdxWE5Ia2VJUlUrTVN5NWJJT1Fx?=
 =?utf-8?B?NTlEb2VKN2M2TTI0cmZmUlcvSTdVb3JwaE9IbVVGbVZteTRYYldjODVIQ0J5?=
 =?utf-8?B?K0Z2cTIvb093WjVJZGc3S3kvUHJGOE9pUHRvRmtFRGJQcjJRbXZiNFd6dlBB?=
 =?utf-8?B?MjY4TWtQY1plQmtkcE9FdU4vK29id3JINUFKbDJCazNwZm9hWi9SNVRsZ25u?=
 =?utf-8?B?aXFtYmxFQjIyWVlFNGJVSXVSNEU2TzgwNloxeHh0elhHNERMaE1iWWsvMk1G?=
 =?utf-8?B?VmRWQllCWndlSGI5MTlsNUVuSWx6bUFFV1VyZURSZzV1RzRtT3hWckRsSjQ0?=
 =?utf-8?B?NEdheEIwRlEreUZBT0ZiczlGVSsvd3NRNlRRKytNcDdEZ1F4cHdmM1lOVUZL?=
 =?utf-8?B?VDIrWUE5TXc0bnA2VlljajN6UzdJWFBWRVYyK3ZzVzkyVWMvUHNsazcwTkU4?=
 =?utf-8?B?K2luVWxLRDU2UVcxMGxtQW9DUHBNalRKalpFUjVCZVFhMGdrZzNIbnZidnU0?=
 =?utf-8?B?YXFjTU56RVhzUXpjSWZGNC9nSnhIMGZMUWNKWnR4NjU0OHMzcHRaaHdKU2F6?=
 =?utf-8?Q?/tTRpkHjz+bmWKyoZzL5POyJy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c33fa3-259d-4c86-554f-08dc3e343587
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:21:53.9229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPIW6VnYl0eOeUrcZ8TD5dPYNN7qBTeYiG8TSzw/DNRwIH3s/owIUdshqMJx/keGyoxGztwLVt14M9ynbsR3VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158



On 3/6/2024 16:07, Luck, Tony wrote:
>>> +   mce_numrecords = max(80, num_possible_cpus() * 4);
>>
>> Per Boris's below suggestion, shouldn't this be:
>>       mce_numrecords = max(80, num_possible_cpus() * 16);
>>
>>>>    min(4*PAGE_SIZE, num_possible_cpus() * PAGE_SIZE);
>>>
>>> max() ofc.
>>>
>>>> There's a sane minimum and one page pro logical CPU should be fine on
>>>> pretty much every configuration...
>>
>> 4 MCE records per CPU equates to 1024 bytes, considering the genpool intrinsic
>> behavior you explained in the other subthread.
> 
> Picking a good number of records-per-core may be more art than science. Boris
> is right that a page per CPU shouldn't cause any significant issue to systems with
> many CPUs, because they should have copious amounts of memory to make a
> balanced configuration. But 16 records per CPU feels way too high to me. The
> theoretical limit in a single scan of machine check banks on Intel is 32 (since
> Intel never has more than 32 banks). But those banks cover diverse h/w devices
> and it seems improbable that all, or even most, of them would log errors at the
> same time, with all CPUs on all sockets doing the same.
> 
> After I posted the version with num_possible_cpus() * 4 I began to wonder whether
> "2" would be enough.
> 

Was thinking along the same lines that 16 MCE records per thread might be too high.
But since Boris made the suggestion, I thought there might be a use case that I am
unaware of. Perhaps, some issue that had been debugged in the past. Hence, my
earlier question if it should be 16 instead of 4.
I think 2 records should also be good. IIRC, the patch that I submitted reserved
space of 2 records per logical CPU in the genpool.

>> Apart from this, tested the patch on a couple of AMD systems. Didn't observe any
>> issues.
> 
> Thanks very much for testing.
> 
> -Tony

-- 
Thanks,
Avadhut Naik

