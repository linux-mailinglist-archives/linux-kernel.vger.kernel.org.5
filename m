Return-Path: <linux-kernel+bounces-107676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDE087FFF2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E1A1F240B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD50D65198;
	Tue, 19 Mar 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F0o/omc9"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2103.outbound.protection.outlook.com [40.107.93.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14267D2F5;
	Tue, 19 Mar 2024 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859861; cv=fail; b=VTuIrxN4SCiFylCdcBVCSFqvCk9vER+HAoR0OQnHyi4NdX+oF1eFIilUlv3L4aNTzjJLdpqtZW1RLTMMRM/w9J8w/kp84mookmFzkFlW8SBvLHMPlTSNMdQ2saNVYVtC6aPQxqyO0XFo8VBbPKv+Z7bRItg4i6r7YvG4Ynkib3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859861; c=relaxed/simple;
	bh=kjylzbZmvveuYvXCTsZEOP6J1FrGToe+H2EZ4ah24wE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z39vL3EFTka1YfF90KB5r5p1Tetgd4481guxRs4iha8Pgp2adZEypoFv0b3wLd7YQtcAe63PAxJEwZxfvt3Qy0rXDNZ1DBvbQlyq3JUmUr0Z4Sc7Y9/zpZ96jP3H9xs3DjR52TaDIShjFd18WYzn6tKUXGr51XpV/HqnpFD5GOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F0o/omc9; arc=fail smtp.client-ip=40.107.93.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WU6M/i1UvXsrkP7Gc6v+UJR3Ki69vRHP1ojLUoru6gzP8afbo2hU51jiu3k0LMsQUiqv2T1RzbenVi8+wXnVEJ+rlBcN64vc3V1e/mkQV/NyGody1syQuHNDId0p3BldrElScUrCxYrb5suZ4RVDdXEfweXHjyOD0kG8kWXkx2DV+xVij8B+SQjmZOsQYzGY+sIcVYrQuqb8UshJMVzDHqHS5xMmnkjH9Cn5G99GZ7VALoEmsLoqjzLS88SfOyq25p+CUPvSByyHVyyW/R2pUDP4/MUQT01g1k31Cgp/WOEZfuMjnurlvESILn75mSzu5jT1K54Eqn8YJLNKyD5Udg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=731k0gMDRuiSMXctDoSFBSeC9YeD4iK86Atr++hBAHs=;
 b=AxhH5CYe/LTTD2eVkLKf5yIq/VAUNvmelLOSwxkHnB6ZkW8uSe3FKON+NK3jmaFSt60meDoGewRGfsaAFdIptDvcpjEx9jkXL++Kr20E7PUqIccKuOo1lKl2NrxecayAj3aPA1UJuMFE/LkM7C9YzotWLzL0a+AsFGSNev7uQZMrRJDOvDjmFjhhhyfWGwuOEsbElQCJnZylAPjfAhZFeah6e5fM7HWFX9KqWCHQ44+ha0qbaJrRN335PPeD7GvuRoJUOCQ1Ojc/lORXCWu1A8OGPaugnEPH28aAk1/tvCrEbV19vEqk9SZEDV0O7YZPr8XJOuFuhyw0iK76BAcKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=731k0gMDRuiSMXctDoSFBSeC9YeD4iK86Atr++hBAHs=;
 b=F0o/omc9AsY6es7BTXsSmAb7BNsbWfOfbGMgrt6kmW1mb2cTcUcbc9yfuVeXN3LNSQzjCvT3sYgHSSViautdJoBw+knUGatJCAHhlPflcbZ9ZIZJUxKQY4h790lXvqdIowDfZYafK/3TPhncm8f1XBMiwAdLNxoimX11tqTAFTw=
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 14:50:56 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:50:56 +0000
Message-ID: <f2a19e07-bf3b-4a25-9dff-201dac1779ab@amd.com>
Date: Tue, 19 Mar 2024 09:50:53 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 3/3] drivers: remoteproc: add Versal and Versal-NET
 support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 andersson@kernel.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240315211533.1996543-1-tanmay.shah@amd.com>
 <20240315211533.1996543-4-tanmay.shah@amd.com>
 <db6f16af-e715-4ff5-84d6-2d85d62d7c0c@linaro.org>
 <a0cdfa4c-9257-49e7-b519-54e7fd0fb230@amd.com>
 <b9bcd0e2-634c-4441-b9ce-839b2f7bfd85@linaro.org>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <b9bcd0e2-634c-4441-b9ce-839b2f7bfd85@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0092.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::33) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|SA1PR12MB7365:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dTwxbQjhCHQuOu7xqJ2KgCUd8nDmmp/NOYAIw6VAk7TYRdnu3mLrHZEOLj4T3i/bEAUE1E9IaWg99sXh9Fc0k5QSHoz4fKLwZOo1ONZanc0Fksq5QwZQMqp0JFSdCAbPsLW1pCKMETFB6rWbGwaE81TRDE7GgijCvADycTWhR14GhfD+6P7r+bDzMTOMFAAm55WSJtX84R8q7gKyUZvQS+1N9sfHFteE9B1GU3aATOk9oXhWlE9G5MVhDl0f22nhTrmn5qlLEI3GQhxwwgNfpfeLuqTxB5sc9yZlc5i7zjs27rxEm5/qGlXKB6KydmNdeGnWrPqB4J6DYTy2A5jMrU/Y87lAHYcgMfO6KdvOQq00ciHD4vGMDrI1ZabEqbk50owiALvkyYo2nYUc67Dzr0IcmVATl7Adk0Aih0NjxoyS0MGGZK1JvvH9ruGAXEOU7dSa4CVHQX1ifS0YVWxieo84H7/dDpXgLBD15+5ad45MNlg1KNU+JZLeE7GaI0JR14mO8rpGMsKsluNgLH02zAsYLcDVevR+mjRRG0AiCLles7p6KTeSx8Q16QW1wrhpcmRQUL2wtXRHKQkIldg0JTB78HvEccheiE41in8Eeh6A7UfX5uJ8oEceNptJwwrwmJ26UU7Nm3WStddjjFWjZhdAC5SRnJ79153h+L5RszA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGV2bXpLR3YvRk1aNDkwQ1ZHNlJwbWJCcW1aa1oxdVg1aWdZbDVOdmhnZVk5?=
 =?utf-8?B?bFJreWszMm0yTGp0b3pvYkxJRHIvWmx2TytRR1pWclJETUQrWmZJTTk0N1c0?=
 =?utf-8?B?QnJ3M29iM1NqNW16eTBGVVhJUnV4Nks3Tk1UVGhRZThWSENEWDljb3laQWY1?=
 =?utf-8?B?UUoxMGtlK0xnc0tieTRGc2xNcEh5VytiOHo1Smw2Mkg0Nmt0d0o4c0w5RC83?=
 =?utf-8?B?YWJhT0tiM3gwckplRlhvWXNPZmxUNllCeFBGR0EzNEFodS9RZUZFZmJBajFE?=
 =?utf-8?B?d0Q0MGVpcEhObHJlMGxKSXNjTFFmQWd6YXY1UEw1L2kyeHRPUjR6cTh6MkNV?=
 =?utf-8?B?WTVJV3JjTml1c0tUbzgxZ1ZOdVJYcmVEZ2tNbm5NVTZSdXFiaVV1VzVZVDlu?=
 =?utf-8?B?eEQwQ1FVTVBWUys0ZTJ2c3VrOUF4dmJna3BBRmpHYzZnRTJ6MmNWT1pyNllJ?=
 =?utf-8?B?SlE5VUJsUWY4dFYxN3JhTUtPYXBvTkM0bXFLK1psTE9GNlc5OUMxdWNPd2Nv?=
 =?utf-8?B?MEJIeEF5Z3EzSFB4S2gwcW1NbkFBeGFmcUUwTVp4NjRiNFpDa2dnbXFNemNO?=
 =?utf-8?B?N1FubkhPaVZvSzVHTk9XK3FYMWtOL0VwQ1BIb1YwbGtOek42OGRQMC9MV0xJ?=
 =?utf-8?B?bUorajRSU0k1SzgzRHVpS1Zqdk1PMmd5c2pHRm1oSStaeWEwSHZ4bEMwUzBP?=
 =?utf-8?B?WWo1RXdZUVlxRkhrenlZTlJlWER3RkZiSVNTUjVibXI5eHdvaThadHlicGp0?=
 =?utf-8?B?R0RuSFVldGNnY3RnK0VnSFZoYjcwTHdQcmNMQWpNVXZGZldrV0N4dUx3NHRF?=
 =?utf-8?B?MjhPVHdvRVZLemVMM3hHQXNNQkF1U3phRDZPUk1BVmhkcERKQ3Z3eEZSNm1p?=
 =?utf-8?B?dHhyUXRYZFp2bDFpVWEwNUVWb3QvSWN6UDUvcDJPVEJXTVBEaU42UUgrRHZy?=
 =?utf-8?B?K2FuQmZyMGNrSmU3eXUvcHVQbHNiNWlvZU5QNGZQblg5S2pIOWhpVnNoTlJR?=
 =?utf-8?B?L2ttMStlVVJYdHlFTFRtZDFpMXdpcXo2U2hzZVZ2dGU5S3NXN3dOd3REeHVR?=
 =?utf-8?B?bktWMFUxdnU0MFRjTVdvU1g3S3lnSk53ZGhCNXZlZzNFSVN0RjlZWEZwUk96?=
 =?utf-8?B?U25MaXZOblZrQS9zZkoxcmpncU9kRHdqaU5nYnU2TzVFN3F1Y3ZNckI0M3VU?=
 =?utf-8?B?aXJybHpVSU1GRXRENWV2NjBxR3pSQXpwMjF6VktLY0drejVudnFDdHJmZ2ph?=
 =?utf-8?B?OGNVblpPZ0hha1c3TEVUU0dReGh4c05YbFk1NjZNU2g3d1Zwak5rV2RqRktm?=
 =?utf-8?B?R0hlb3d4bTZNVVBWWUhoaXdKODFRWmVFcDdlUGs2aUZRNFJoRklTV2VHcy8w?=
 =?utf-8?B?VWFEWGJDS3hQbHVlOXlBRkp2QW5xQkVaS0VhQWdPRXdFODFITGZnbnAxbCt2?=
 =?utf-8?B?d0pVVHVTZzkwdEZSR0NRQUpiWTk3TlNJMyt5NUtpODNISkRoSXFDVDlBMDN3?=
 =?utf-8?B?aS9Nc0N3a0RPNHdXbWZhTWljVXowOThPdUhNcUJFNzIwa1d4UXZiL0piYjhj?=
 =?utf-8?B?UncvMEVKeDRFa010VzRzem1IOFk0TnhoWmlja2s4ZUFSa2xrYU53RHdDUXd5?=
 =?utf-8?B?WHJ3VU8wcWVXYkJLSGJHaHhaR2I2QU90T0dqTkZSUURnRUw0b0JkaHVGOERm?=
 =?utf-8?B?MDdhZGhUTElmb1dYb0d4cEk5UW54TVIvc3NmaW5uWWRxTlQ0RzBiOGhlVzRY?=
 =?utf-8?B?QnVMd2c0bXlRand4ZGhFTHhOY01oOVBZZ3pGLzFoQ09hKzVtdno2YzB2S1Ni?=
 =?utf-8?B?L1ZUZVVJT05zdE9xOGQwTDJUZ3I1T24zT1RoMm4vZXAzTXFRL1RnMjM2VnND?=
 =?utf-8?B?NTRTWU1ZamJsNWlLME5QV3pqYWMxZXVNUHVJRjVYZVdsV2c5ekFDQ1ZZWUdo?=
 =?utf-8?B?WUNvK1ZlUGNycG5HQUUvR3VObGk3YmlQSmwyemRTb2FGRTk4OVFxb2ROSHFN?=
 =?utf-8?B?c2c1enpCUmRzVW1wOUFxTVRRRlg1enNCUW9aMEEvOExKdm8vY01kSDZTNjdj?=
 =?utf-8?B?SEgvMTcvTThsRkVyamprQkgyTVp5emZmM0RxUmtZQzlPMHZwY3ZJOEVOK09D?=
 =?utf-8?Q?wlxjZYtLhZ7FY60ZfSlzKmbgQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d846c00-f9ce-4f25-bf6b-08dc4823fba6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:50:56.4409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aWC7VBmbqe6kYgC81/Fs6HxcG0BtwqNRlwWGI9HcRqY/FG6QZ6mLfcvw/II0sOL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365



On 3/19/24 12:25 AM, Krzysztof Kozlowski wrote:
> On 19/03/2024 02:06, Tanmay Shah wrote:
>> 
>> 
>> On 3/17/24 1:55 PM, Krzysztof Kozlowski wrote:
>>> On 15/03/2024 22:15, Tanmay Shah wrote:
>>>> AMD-Xilinx Versal and Versal-NET are successor of ZynqMP platform. ZynqMP
>>>> remoteproc driver is mostly compatible with new platforms except few
>>>> platform specific differences.
>>>>
>>>> Versal has same IP of cortex-R5 cores hence maintained compatible string
>>>> same as ZynqMP platform. However, hardcode TCM addresses are not
>>>> supported for new platforms and must be provided in device-tree as per
>>>> new bindings. This makes TCM representation data-driven and easy to
>>>> maintain. This check is provided in the driver.
>>>>
>>>> For Versal-NET platform, TCM doesn't need to be configured in lockstep
>>>> mode or split mode. Hence that call to PMC firmware is avoided in the
>>>> driver for Versal-NET platform.
>>>>
>>>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>>>> ---
>>>>  drivers/remoteproc/xlnx_r5_remoteproc.c | 19 +++++++++++++++----
>>>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
>>>> index d4a22caebaad..193bc159d1b4 100644
>>>> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
>>>> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
>>>> @@ -323,9 +323,12 @@ static int zynqmp_r5_set_mode(struct zynqmp_r5_core *r5_core,
>>>>  		return ret;
>>>>  	}
>>>>  
>>>> -	ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
>>>> -	if (ret < 0)
>>>> -		dev_err(r5_core->dev, "failed to configure TCM\n");
>>>> +	/* TCM configuration is not needed in versal-net */
>>>> +	if (device_is_compatible(r5_core->dev, "xlnx,zynqmp-r5f")) {
>>>> +		ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
>>>> +		if (ret < 0)
>>>> +			dev_err(r5_core->dev, "failed to configure TCM\n");
>>>> +	}
>>>>  
>>>>  	return ret;
>>>>  }
>>>> @@ -933,10 +936,17 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>>>>  	int ret, i;
>>>>  
>>>>  	r5_core = cluster->r5_cores[0];
>>>> +
>>>> +	/*
>>>> +	 * New platforms must use device tree for TCM parsing.
>>>> +	 * Only ZynqMP uses hardcode TCM.
>>>> +	 */
>>>>  	if (of_find_property(r5_core->np, "reg", NULL))
>>>>  		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
>>>> -	else
>>>> +	else if (of_machine_is_compatible("xlnx,zynqmp"))
>>>>  		ret = zynqmp_r5_get_tcm_node(cluster);
>>>
>>> That's poor code. Your drivers should not depend on platform. I don't
>>> understand why you need to do this and how is even related to this patch.
>> 
>> You are correct, ideally this shouldn't be needed. However, this driver contains
>> hardcode TCM addresses that were used before TCM bindings were designed and available in
>> device-tree. This check is provided to maintain backward compatibility with device-tree
>> where TCM isn't expected.
>> 
>> For new platforms (Versal and Versal-NET) TCM must be provided in device-tree and for
>> ZynqMP if it's not in device-tree then to maintain backward compatibility hardcode
>> addresses are used.
> 
> That does not work like this. You cannot bind to some sort of different
> compatible. If you disagree, please list the compatibles the driver
> binds to.

Okay understood. I believe then removing hardcode addresses makes more sense in that
case. So, driver will become same for all the devices.

> 
> Best regards,
> Krzysztof
> 


