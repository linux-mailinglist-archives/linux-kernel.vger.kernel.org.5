Return-Path: <linux-kernel+bounces-106876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC92487F4D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E391C21514
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BE5A3D;
	Tue, 19 Mar 2024 01:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aGappLma"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2104.outbound.protection.outlook.com [40.107.244.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476D8A29;
	Tue, 19 Mar 2024 01:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710810404; cv=fail; b=hM0o4IscLGlz43WYZPYyd4uLwtflrovUHbTA0l3eOI9QZfo/NZ8UX3oArrx+3aqN7MoFiTAWBW0CyPqTTsSyE9vUT+bLpevqwShjXOIVQeIPrXIwZEDCaJiVpvn/TRy8QbjCjowJ4j2C38qdNsbhUkKXaYhd+gKsw8rgwHrazCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710810404; c=relaxed/simple;
	bh=/pmePyVuR1aPrVjMgGD5FbaZkUvdzjCKsKF3DBzxg54=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lShiDRaRg5C0ewaMDiERdnQVndU9nvgns+cbMgW0BHTV037HdIA6GN6y8aeeDp7B+1Yg7ZQDsyg041rHMymbVAroa2rjsj86tex84JnuiSAzlNFxiXrDP1pmlozEf1s7b0lgagH9I8LayUvsXCi59m1EliK3ZlcOMp4O5dkPL+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aGappLma; arc=fail smtp.client-ip=40.107.244.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrzCSLlu5oJjid1tcDjRHMuD9hzDkIDje+bnTHnN9YcKEGbGNg5C2VfhjlBLi43KftYpfhu0ixjAFLoUUJmTQ7qvfEUev+2cyEoPFUcHYE+sFCJuQptf19AikNhJSO4TQZ2/ZHz/GvHRJ/4oGTsoJeb1Qkcl6KtGzdY4S8scA3xePkNNZS9M/3uHES0VHQngJAi8W6E1NQVM8IGFdyNUexvGX0Ol9sR6UYI2weUKOmU1OwqVwBE5Ow6z5JhpYdhgQ/WMp6sl62dwOFmrcklpecEg/43paHCeCbesjlMF/aw7T8vRNpEhEIrpAFZNp4m6OL9cTzBRBZIk9U9m+3hAIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jh8K0eubbTTIXhu2zvFy2LMqibn/m29opJM7GWuuCOQ=;
 b=k7RHpOi3SMbYUcNIHL1D19VNwkuu2kljdl22if4rGB9wEjLcvbnkmdWHdLTgIiGFEfzMyACX8EKNj4+pIH4oi62Ds6H4IQB3/yu2gxcRNSu/yulRGpFR6jhqPBrajU2xUJWWLxDeJ8J+RSB6GkFOi1QTIkNP/KUu5Q7hHBNrAEhp+02cy0NOm8D8pgOHMMNzhRQ8nQhIZoXSDyQMZpHn+e4Hca3BHYdg9mH6B0GVb+MwtQ/u9+pHnT51nsAd9aE8AWy3d2/Y1j1oexj/Xax4X4l0GFUvBnLSwknoJuI2SPjAKXcte3gHlT/ye0K4FGWWphpJjR6Mqm2p7We7Gljw/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jh8K0eubbTTIXhu2zvFy2LMqibn/m29opJM7GWuuCOQ=;
 b=aGappLmaqmS6raRYy3ygxthMwMhbMORzMgvb/JUdk7CB7bJtvclGBK4Xz9bFh2QWqzLPJ++wjyeJfHIZSvQDGpvqf2KXrYTjcTlY70E5zRKeKgFlzKZRR0uOJlAXRw7mZb07Fhmdc7Wipk77LKlB0i4Ju+Va/207mET5tx+jOyo=
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 01:06:40 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 01:06:40 +0000
Message-ID: <a0cdfa4c-9257-49e7-b519-54e7fd0fb230@amd.com>
Date: Mon, 18 Mar 2024 20:06:37 -0500
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
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <db6f16af-e715-4ff5-84d6-2d85d62d7c0c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0105.namprd05.prod.outlook.com
 (2603:10b6:803:42::22) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|MW3PR12MB4395:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1YO/MvtpCRAkxNuQ5CoHQhqZsSLww/a4pihFhtfX7xHSdrAAyKW5n+YltGADcou/Y6zmFoMF+FeO4CzfBA/urNR1UE2WHgC4TnUX6VgKXyPj9sRJFkOJ+G45+FiseQpitNVAWRuqi5CqRoiD+WESrYq7g41Ua2ol8kiMskoHVPwbbzQhS/18bmPRQ93BhtFs6C0EPYaX439OH61Sncxy46xuKcIQNeETdYmWZCF8zPn7N9qMgM+3gWd0WbKV79Tw6zn96Qsfs/QLkLB+t258/RelGDNtAIAJ0B38OuO58D4ENbxGmPfNRZCwIvnoCO8hGKUnYJtQulsw2xrrJ+EV3hsZHBqqYRY3K7lEsqxdqPjGkX6KEt9Dkl9aaJbLXmrt77FlVkmG02I+XqCytaSczLvWqs7g4LEsUXinHsJYCKwTxIUcEUOeyicQ2QrcWqWN75JuEyOPU5jyjWo64MJUR3xVlmWsS+tLT38lx71OGPmOa0A/kNcD0WRFlNYZMViRXG01bmIg879p3sEujMicVMRtE6ybIuxj2bHHdceqXujAb8PnktC3V25wAzuoHJ69mooL2f8BWHZeYNqSMPlBavG77dL1VYB07xbcMiRbeX1Jv1+O56k+FQmHNsZJpzg8gAUrTr0P2yZMqK9atz0g1nptLQmVNO4DLB0jdecOsjY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEdpV1FiTG44RXRxWWhtZ1VEeTRXL0tjWEx3dFgxV0VjbzVzOVY2TFNLeVEx?=
 =?utf-8?B?emg4cDdjSGNmZUVtMHN5K1Y0bVkxdmV1eHRuQnlGSUc4V1VIOC9nYVJ0b29r?=
 =?utf-8?B?by9iVTdVM25zWnB0UWlSdGZmMUQxeHNodTUzb2I4VXIvL1NXTnFZNHQveHR1?=
 =?utf-8?B?QStWRklNY1o5RzhRc1EwMEdNSmRuMEFBU1BFWVdZQ2puM1VxaW1EZFdGUGM1?=
 =?utf-8?B?elhKMlViRHZHSk1HKzZndE5NNUsxOUxTd2RjOE84WTN0c21PcFVsSTFCSEhP?=
 =?utf-8?B?WkVDdkpMMDBmTlByQit0bWNhZWlWbHRXNkM2a2pzSXhHb05VTWZUUnBwVUJP?=
 =?utf-8?B?SkpLaTU1NDRsbGRVR0dmL1FoOFZqOUwyNXhENlVhck03VUZsaUZpSHNPTzY0?=
 =?utf-8?B?dFI4QzJjbnNIbjFQM2JFVE1RRVgwZU4vQnYxY243ZU9zQVo0Tyt5eXNrTGJJ?=
 =?utf-8?B?OWdYWURmOVgzVkxpUVh0T3ZMTU1BS2dwUVVqUW15WXpaMWJNTXFCZW9saW5D?=
 =?utf-8?B?SWJaNXppUHI2SlkzRXJFZzhLR1ZFR1JCeUlpeEZkUmhtVmJpT3pqT1F6Q3Ns?=
 =?utf-8?B?VjMyTzR4K282NDhZUjRPNlN5ZFBTY2tpN2kxcFVGVmhqRHBrREVNTHpVbHVW?=
 =?utf-8?B?Z21Id3FrMnlxcE9sN2NNeVhoZHFEUFNnaUIxTjkvSVNwWWx0enN5ZFlDVGJE?=
 =?utf-8?B?WVJJYUprL213N0RCa1crcEwyRVZCdUdQNkx1UHl6SmRuL2hBbkthKzNBa1Bh?=
 =?utf-8?B?SFozMDAxNmZaV282ekd0YW5UaG1qdGo1bjNQb2VJOTZnbDkwK3lHbklJbjZP?=
 =?utf-8?B?WE5UZXlmVGRldkx1cEQrdG1ROHJFcFpsQnVLOGlqSHRENXVTeUNIWXFxL0Q3?=
 =?utf-8?B?QXJNMkNtWlFSbnVqbjNzMW5SNUdMZEpzVUVTdm9na2ZsYTM2WDhLS3Bad2NT?=
 =?utf-8?B?K3hjZ01nR3UyVjVka0xJSVllWGlwK3VnN21UZTREd2xyTmtYZFljSC9hRTNy?=
 =?utf-8?B?OUkxNjVUN3Q4K3c3ZkRyRWZjSnBYaXNIc1JzVjdPakhMbVZzNGpJMFVDbUhE?=
 =?utf-8?B?Y2llQ3JEbVcyM3FXdzZLWEF3ZnpBc0JQNTREcWo2VjV1MWdSNWkzcVdWQVRZ?=
 =?utf-8?B?dWZMeXpZc3c2OGlsK2U2elhNZWtFQ3UwWGxDd3F5TE51RFRvRHB3SWdyUGRw?=
 =?utf-8?B?aFFMQUdhNUFEUm1zTEFLem9semt5UFIzdUlWRnlwWEVCY0MwcGtGZlRBK0hp?=
 =?utf-8?B?WSttRW5hK1hEb0lNZ1pTTWlMV2RwVjY0Y1RpN05qSWEvcUtpMVh5QzM0Z2ZO?=
 =?utf-8?B?WlB2aWN4NTRZaWhBcHFac3AwcHc1SU5iUU8zVkhhd2pXSy9iRHdMSmpTMXg5?=
 =?utf-8?B?Z0pkMjFnRVdqK0tETXFIajA0bnVWNVRob3lKQTFIQ1hlMXVid1d4ODUzb0dK?=
 =?utf-8?B?a2J4bVRDd2V2aEVza0dTNzdMY1A3elZvdi9Zd2R1MGlOMUtLUWZmdFFqOG1Q?=
 =?utf-8?B?YXdBMGpvdGlWWWpmVmFRTUNBM1l2M3lxVjFuY3ZGNzI5dVlzT2VJdGRSeGRt?=
 =?utf-8?B?N1dPakJSMmFiZ3pTMTF1UHcwTTlpV3R4TGNtbEhwMXViTlBzVDMxd2J1b0x2?=
 =?utf-8?B?aVZSQk9yYXhZYUVLaGYySXVhRVVVTFZiYWdlWnlEQStoc0JrQXVNWEEwQ0I3?=
 =?utf-8?B?YU9iL0VmS2Z2SUw5NisxT3d3eksyVjF2LzlFbTRGUGh4aU1CcFFoTm5GNE50?=
 =?utf-8?B?eVc2UjRNRTVMOWE0eTlYbXJCUUZQTVYzR3N5SnArbGJVb0xoc21QdUI1MzRw?=
 =?utf-8?B?bDQ0NldWSE9sZ3dNcVFDbVBiUGRxNmFsOFZhM1AwZ1lBUDdTb0hWWGdZNWVT?=
 =?utf-8?B?TUdhMFJmb0ZSMVd5bVp4aEQ4TTF6VThEMDlSMUx0eVJsb0ozOVJyWTZqNHJP?=
 =?utf-8?B?c09xbDlLbzNnQW13Q3dYZEF6aDJWR21qdEx4QUdlMCtiZ1RweVEyeTlERFNC?=
 =?utf-8?B?SzVyWnN3c0NOQi9PcFFJZE1hc2dpV25RWEVvWUpDL1BIcjFaY2k5bm9MYUpi?=
 =?utf-8?B?SllNYjdYaDY1Zjg0bTBpR2U2QnkwVFBJblVRZWZLWWtXVmdzVTNzMURDVG9V?=
 =?utf-8?Q?JLwLfMIZLCozSsYTSOYu6swWq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58ca669-6760-4d87-986f-08dc47b0d573
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 01:06:40.1832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGf09f5//RGTr5dUN3WWdwF6WtkxidEDoJhRfA/gzq/3pwA6llwpzuZxBXQEDvys
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395



On 3/17/24 1:55 PM, Krzysztof Kozlowski wrote:
> On 15/03/2024 22:15, Tanmay Shah wrote:
>> AMD-Xilinx Versal and Versal-NET are successor of ZynqMP platform. ZynqMP
>> remoteproc driver is mostly compatible with new platforms except few
>> platform specific differences.
>> 
>> Versal has same IP of cortex-R5 cores hence maintained compatible string
>> same as ZynqMP platform. However, hardcode TCM addresses are not
>> supported for new platforms and must be provided in device-tree as per
>> new bindings. This makes TCM representation data-driven and easy to
>> maintain. This check is provided in the driver.
>> 
>> For Versal-NET platform, TCM doesn't need to be configured in lockstep
>> mode or split mode. Hence that call to PMC firmware is avoided in the
>> driver for Versal-NET platform.
>> 
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>> ---
>>  drivers/remoteproc/xlnx_r5_remoteproc.c | 19 +++++++++++++++----
>>  1 file changed, 15 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> index d4a22caebaad..193bc159d1b4 100644
>> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
>> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> @@ -323,9 +323,12 @@ static int zynqmp_r5_set_mode(struct zynqmp_r5_core *r5_core,
>>  		return ret;
>>  	}
>>  
>> -	ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
>> -	if (ret < 0)
>> -		dev_err(r5_core->dev, "failed to configure TCM\n");
>> +	/* TCM configuration is not needed in versal-net */
>> +	if (device_is_compatible(r5_core->dev, "xlnx,zynqmp-r5f")) {
>> +		ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
>> +		if (ret < 0)
>> +			dev_err(r5_core->dev, "failed to configure TCM\n");
>> +	}
>>  
>>  	return ret;
>>  }
>> @@ -933,10 +936,17 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>>  	int ret, i;
>>  
>>  	r5_core = cluster->r5_cores[0];
>> +
>> +	/*
>> +	 * New platforms must use device tree for TCM parsing.
>> +	 * Only ZynqMP uses hardcode TCM.
>> +	 */
>>  	if (of_find_property(r5_core->np, "reg", NULL))
>>  		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
>> -	else
>> +	else if (of_machine_is_compatible("xlnx,zynqmp"))
>>  		ret = zynqmp_r5_get_tcm_node(cluster);
> 
> That's poor code. Your drivers should not depend on platform. I don't
> understand why you need to do this and how is even related to this patch.

You are correct, ideally this shouldn't be needed. However, this driver contains
hardcode TCM addresses that were used before TCM bindings were designed and available in
device-tree. This check is provided to maintain backward compatibility with device-tree
where TCM isn't expected.

For new platforms (Versal and Versal-NET) TCM must be provided in device-tree and for
ZynqMP if it's not in device-tree then to maintain backward compatibility hardcode
addresses are used.

Thanks.


> 
> 
> Best regards,
> Krzysztof
> 


