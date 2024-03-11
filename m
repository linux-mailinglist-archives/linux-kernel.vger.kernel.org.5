Return-Path: <linux-kernel+bounces-98851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA696878048
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418E11F21CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C27E3D388;
	Mon, 11 Mar 2024 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OTPQtwN8"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DB033070;
	Mon, 11 Mar 2024 13:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710162415; cv=fail; b=FkCpcFcqBEB9CPLyXNpqTiuNvNmV4//FMske9tBu3PnDz+BhUUSCrJmvKQsXQY64psfLOKhW4HY2r++jdCaIfyoODtEGOG0q9Md90ln6kRqIZrl2USsSGC3IuUUXdW82njD2NQ6bwfg3VGL/wS96p/OCLAK5etfWSoAjsgb7EM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710162415; c=relaxed/simple;
	bh=/rKhbgfZxyp6joSPGO0WxtPPmjTsS0j3arZ4UuRIVD8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F4n4TQ7bGsaBkecQ1ni4GETTdOIMuDwJiOBcqnlLQ9CTm43g5vRFWWSlhG86RAZMtCSZ5XRWFXtEtctHr7pUZUGyZ/VfMVkd8JWhbB7Mug/ujATMz9QoRqGlTKgm5FsrTNDRPazLLyoAoRZFYarCVxDS5nNYBXdY66pC5w/ww9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OTPQtwN8; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaQmNoBb6YGIEDeU9roQN3zo0yKE9Wj6zsvqTXJhnHhf5NmaXcE3+SCtp3jaW07YoAs3vU8LxkFACRThaI+kdvYJq4KzjXNrEHXAQYo51IqTDBbmoI+gZeZ4kpwkqwogcPPiUF8Jr+PHGdAYg1KMZ5Z40fP9f3XwegazQTfM7ME9f3G5Ah0JSP4rKjQCcnIb2+ZtAtC6j7P1up62qzRqiC9XC+g1F7P0rIXSff3BIxFGk668vcUIxxW886zBU0SPKjUiHZcZ5vq5S+2DWLJQ/T6vk/nuhy7VNODfAUmXTRGl+UWmw4ReTjHMJXXMkLYlFf4WNE6N4w/jrMcOJD5XNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywfwUZbn9nhaZkT6PnJD6GbiU9YbNWgGMrFJHzuDTeQ=;
 b=VwYJvHwmw83UbRv4QGOibAAcrI7LbzYZ2fstQpHw0I2sqWHBEfAVG4nKe7NG3Ck+iFdbVm2xl7Ddx++j6bAcY4nyc6+hlv4wqqCn4dgPu4xnKdK2wn7ILneEontOSM5OGFiNq/pbqGMili9lxVPeZu7htiRVx9eaYW97a4mZAzGJcqfiJxSC7qrs+JV0myORziT5x08qRQE+KT7/EXyKvuNZerUWmHf4vlA2QsoHxL9+OVz/FJLJbSQu5e4S9D+5hMH2IZinDLdS7zYNiAloL7synZxHmcB2MRJEHucRALfAVzPKGIbVmMxy0HUroaMvF8AZmpddPz1cUJ99K1WMcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywfwUZbn9nhaZkT6PnJD6GbiU9YbNWgGMrFJHzuDTeQ=;
 b=OTPQtwN8kSXNmdfYIA0it1wfQeBwd/n5N0I8L26KYi8JJEhUBh0ObvAgABb305kXAc5dlrCGKcR9dGuqFYprb4UHJB0CauAIPCm8mA3aNVAUrianLIVy+HmabYFqRCYSm0u9cILA2O/b0Mc6d6A+/9iiiHtjGMHtrguqJdc2XUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 13:06:49 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::3278:b63e:55dc:d1a4]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::3278:b63e:55dc:d1a4%4]) with mapi id 15.20.7339.035; Mon, 11 Mar 2024
 13:06:49 +0000
Message-ID: <9df559c6-fa17-4784-ba5c-7d4d51ab4411@amd.com>
Date: Mon, 11 Mar 2024 09:06:46 -0400
User-Agent: Mozilla Thunderbird
From: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: linux-next: build failure after merge of the edac tree
To: Borislav Petkov <bp@alien8.de>
Cc: yazen.ghannam@amd.com, Stephen Rothwell <sfr@canb.auug.org.au>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240227134352.6deda860@canb.auug.org.au>
 <e367a4ad-3431-4cf8-9c0c-1205e00b907c@amd.com>
 <20240309094651.GAZewwC3u3U7DhXBdo@fat_crate.local>
Content-Language: en-US
In-Reply-To: <20240309094651.GAZewwC3u3U7DhXBdo@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:e1::17) To BYAPR12MB3109.namprd12.prod.outlook.com
 (2603:10b6:a03:db::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: e22dd108-17df-4d3f-9a16-08dc41cc1ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D61DfPOEyECkJR7l9tLWdstInp27zfTZKQ8W+zNU8c8BZSjE1AiUSuBB6a0vy1GZTTGquhDOU6QUOxtCdKiTTvXQlyRECq/wDojKZadDV/NuqxS+b8EjhAlwuoyaY1xWubeNOdCZ2PNRWBVDoyR9PcXfcCPdKztkhg4tjiHUNbJJ/+SxkrLBzcTnua0bWzLA7G27cvIYH/3vGlJ/+216x/A2+R/j4PXSzkM8ufAagsqH8gW6PshjnCSVqeLvpYF3yPZXtLCP11sWb3HkTJUVi0NCOmF4WV8iKgWAW9QK1sbgj8nYZyLew50lE1wGFEBMydpnbX3fnDQyGYq+F7rnMxo8XfZyYH5vIgC9YW/LUpaQu4StgnECjMZOXcSOyVF973J/dROzSxc7OwikYGPBcjOXlWLRddl0VJMSU3jB/cZg2CDzDfb3hJ9/iC/BXoAJVRSJJWrlNoviJV8+d8MALtRXaYT/340TS+/Cv4+u1KPMLr4FvyAPeqeBfEstCcqW8DAl3Zjwpy6ZVAZIcAERT71Eirj8iaY6r+tPWKYqg2Gfd2XihaM9mIVQvg1QAqqg7ZYLEZA3GfbU55c1fp8rudIffl8k1jjg6dO4lnvw468fdyr4lHeR9FsHZ5ltrcFaxK6eFSpEfsVzmst7ZxeoADIhs7WJteJ4Y/LUrweP4tw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0dCTmZsbzAyUTV4Sm9GTTczQ0JNaGQ0V1ppQjNoWGMxdHdBMDMwNTdrZWRI?=
 =?utf-8?B?TTZaWXRIUS9XenFCUU9UaitOaHBWcFpwNGlVQ0hFVzZaY1NBamh4R1ZrcFlu?=
 =?utf-8?B?TWJaMVN6K2ZpSWlMZnhLcHpBWmFBTGhZeEF3RU1iYWRDNE1PTC9BbC9nbUZp?=
 =?utf-8?B?M0Z0UDd0MHQ5a1pQVGtvZGExbHdQV0J5K1F3b0lYcjRRbVpyU0RDOTlKdktl?=
 =?utf-8?B?ZEJYa1U0MVcwMHB3OGkraDdKWWsrc29BVCs4WStSZXVEOFE1dUxMVWt6OSt4?=
 =?utf-8?B?ZWh5NEFDYXFGaVpGTUZBTmFuMzRFZTVJdmNyMEZOOGpmTHVScGpDQTA0cm55?=
 =?utf-8?B?NG9ubU9JOUNodjVnYnJabmxDTmpvSmp4UDYvRWFBcjAzUjNBVlV0d01ZVjVZ?=
 =?utf-8?B?YzdEVUdHZWhtZ3VkL2c5dDJGREE0bStTazVnSjNPQ1FzZFFqR1lsUlhkRXZI?=
 =?utf-8?B?V0RDZ0Z0a21oUlJ4Y2VubUZjTy9oSzJuN0puZ3UyR3U5NUZ1dnNqWUxjRGdV?=
 =?utf-8?B?QWZCUzgxT1BUYlhrekY5aktSa0ZEcnk3YzJ2UHNXd1hGLzZkWnZBK2F1Y204?=
 =?utf-8?B?ODFGSlIrTHNtdElPRnB1aUMzMGFkL3ltWXBJcURVM01OVWtuZmZFcXlVQ0oy?=
 =?utf-8?B?dXlORUJKdEZ5Y3hnelg2VU5IYjY5eVNsVlFKZzNtOXNOdWpLT01MWnc0Q0Q5?=
 =?utf-8?B?N0JLTHd6QjFHU0RaWjE4d0VDQUlkZ1RkdkhxZzlvOEdaTytRL2s0YWh4RVAx?=
 =?utf-8?B?Z3N1RzlFQUZPVzVyZU1JT080MWZsdkx1OFc4SGl5cXR1UkRMV2U1NG5aUE1X?=
 =?utf-8?B?M3Y1T0RONkJmYTNiMXFYOUxybkpySUgzNVZtMm1oSEladzVUWlA2UGZ4VnRN?=
 =?utf-8?B?ZEtKdWZYcTl4UkZYdWdnZi83VHRFV1l1SDVGMTZyWmFSaDNqVCtaYWpJYmFU?=
 =?utf-8?B?NTlXa09MSHM2L2VFSUs5QnU0ZDg5MFA3MVVjMjFlRjdpeEtBUDYrZ09vNVdI?=
 =?utf-8?B?RGIrenBLWDhjckNiSlJLdzlaakJtdDBGbUZ3bjFmN3Qwb0FhYjV2YkV2UG5h?=
 =?utf-8?B?c3dNYWVPZ0NDT2JLVTU1S1lYTVpUZkF1UlpHNzVBRFBvYUtWUVlxUmozaTlG?=
 =?utf-8?B?Ny85VWh1cXJZMTVUM0x3VVZlbmdmejVadDArbDU3WkUvejlzRkxrdFlROEdG?=
 =?utf-8?B?dFB0M05KS0FUdWJmOVZuQUQ1ak9GS0Q0M0t6SDRyUlIzUVMrUm5QRldMODlE?=
 =?utf-8?B?UzZYSTBBTEM1aktMSE1XR3ltWElFREx1Y3BVZDg3RHZJUVgxV0RyWXNBc3R1?=
 =?utf-8?B?REl1d3hkRUVPU01sS2I0MUVLVzVra3NsdVc5aDNOekJkWkRLQ1lPenVOUGly?=
 =?utf-8?B?Vm9NTXd5MVF1bEZzdWQ0c2NPUzQzd2k0czdjV0Zxa08vKzB2NFpheW1Gc3FG?=
 =?utf-8?B?aHk3aWw1dkk0MFArME1lUVlmeWN3NU9nQm96RjdyWGF3L2djVHYyTm1WVnBm?=
 =?utf-8?B?TDdoOXdDeitERCtzSFZGdXZmYnhIQmwyanRxcnZRZVlRWFVjY0h0OWN5aEVP?=
 =?utf-8?B?YnBGemJwOFdGc0NxbHF2cUswRXJMNVR1czdUL0RCc2NPQVhRR2lKejdLVG9F?=
 =?utf-8?B?M2NuMU9wMnJtcEhjYjJNZ3E4T2ZjeXowU0dxWGlNZm5XdlkwVmpqRXhlOEV4?=
 =?utf-8?B?S0c5c2lOaXo2dzlKSmMwU3VlN2ZBNFFraU85L0ZhQUJVRjNBamVjY3NhR2xj?=
 =?utf-8?B?Qk1PYVB0WWFWWlVBK3NyN0wzVGFibmJoSnEwWGJTdVYvMFlQWS9DYmRwTjFp?=
 =?utf-8?B?b2VWNFV0ZFg4MjB2eERBYVQ2OVIxWWFJaVdvcDgxVFluL2tsMUhkeFlPWEx3?=
 =?utf-8?B?V2Z3cklJZ3FseFZ4bnIrc2pqdzg1Z0g1ZjdUK0hUdS9IWlRQOERhU3VYVlVx?=
 =?utf-8?B?dGtTMjlnNG4wVnh1U0FjSDdNa0VDUHRJQkZXRVFHR3pQVXgwdldlSTZEcnRU?=
 =?utf-8?B?a0w4dlljdVlNTjB2L1NrRHB2b0I0SFlrSmgvZGNKSHJ6Z3NHeU1XUFRkMkYy?=
 =?utf-8?B?RUVWbDFqZ1BVbHEvTUNkNFFFRUlUSHUwaU0vajkya0pqbHdBRW1kWXlETytE?=
 =?utf-8?Q?hPJHeKR5dc5jyBywYLnSM77/y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22dd108-17df-4d3f-9a16-08dc41cc1ce2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 13:06:49.5235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDVk5iyvFUhJqKK7sgz7WDhDje2XR8mxWjy0d9FIEAInWp2v5B+51GQxBUv5szFsL0EI6GaKJ/DShQ4WK+YGZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182



On 3/9/2024 4:46 AM, Borislav Petkov wrote:
> On Fri, Mar 08, 2024 at 05:43:26PM -0500, Yazen Ghannam wrote:
>>> diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
>>> index 08c6dbd44c62..65a0ab651ee2 100644
>>> --- a/drivers/ras/amd/atl/umc.c
>>> +++ b/drivers/ras/amd/atl/umc.c
>>> @@ -315,7 +315,7 @@ static u8 get_die_id(struct atl_err *err)
>>>    	 * For CPUs, this is the AMD Node ID modulo the number
>>>    	 * of AMD Nodes per socket.
>>>    	 */
>>> -	return topology_die_id(err->cpu) % amd_get_nodes_per_socket();
>>> +	return topology_die_id(err->cpu) % topology_amd_nodes_per_pkg();
>>
>> "topology_die_id -> topology_amd_node_id" is also needed.
> 
> Are you saying topology_die_id() was already wrong?
> 
> Because even before the topo rewrite, this was
> 
>    - cpuinfo_x86.topo.die_id:
> 
>      The physical ID of the die. This information is retrieved via CPUID.
> 
> while this code talks about the AMD node thing.
> 

We used to save AMD Node ID into topology_die_id() before the following:
03fa6bea5a3e ("x86/cpu: Make topology_amd_node_id() use the actual node info")

>> Does this need to be fixed up in the RAS tree?
> 
> I'll give a diff to Linus when I send the pull request.
> 

Thanks,
Yazen

