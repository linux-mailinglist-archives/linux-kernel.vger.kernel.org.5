Return-Path: <linux-kernel+bounces-52104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD91849427
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4EF51C22F7F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DFEC2FE;
	Mon,  5 Feb 2024 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wXNHsWgG"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B93D10A11;
	Mon,  5 Feb 2024 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116585; cv=fail; b=PKQpvFsCkI/BsDKe5UsRkWhdDZj5g947AWBRsqrq5BO7gP9SLkuLOY5l3SizphXTYUPm1rB/rF6hfTqbdW2WhY5bxuPgeh/N6r86mvOIraymOVLMqpjlo3DZ4f932l281xkUrCk4PjghdjKgzccyOVH9KewEbwJTwmYSROaEtCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116585; c=relaxed/simple;
	bh=1oN5DJDK8NuRj/D1jNVXF7xgbFHCQupLfPSdg2lGunY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bVJw3WbCssxmYr3i3lI8BnzwtV9KlfnmOZfp6gKqdekk4yUcXlBrujdD8UnBvQU1dtUfi1F3A1FAtdlw+DOJfwznJfzGbXDuHQvHz2eOyBEQwSGTJBfJEzg/NWqeubNE/ytZbG/+YHVh73pqu1AUrgMgqkk3PPdAVF57c9tt9dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wXNHsWgG; arc=fail smtp.client-ip=40.107.212.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSE+GB9vPs6ZOmYIBDolm9QHQkkwidyu1PvHTxif/8KMDly1V4KEZn/3g8fXJeD1XLkMNtBVuDpsNrCBXW2QTXDQXIrelovRXAZLOcLFRtHy6U4kRZKtSb1LuOtJZcT1n29IRC4MgKZ6dsiWJPjK29v/mIF5uYF5JtFYJ8bpl4HNTp+mSYSdTSHdu1+la8WuPmnQasNnUGFzmR5HKssjtI07S+14CtAlR7mK/8h+8PyjDFb4tD20GiCzLEPb4ugNG2ij5CrZsG7adIuPtsrNy3HWo1wrlXps70xPXv1VIqcbKUOrGUX7caauCRUzxu+2xd2Xe2QkwRRTMVA8/Lfvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQZqPoG8JbbtqMfUjnH4b0NLOVkqpqnJ/D1xLXg32QI=;
 b=groYn7YwrhQBSs5KR94I3tAb6Y1i610bM2XcrB/dCFRllhUrjqvp7pV+v+otE8FsLTqSCwPbK4seiwyvNW0aDm0FqGiiTrFmMvYfY7Nz4ztmbVB+yzJEv87Pok8CHgDnIbVYx/a+R0VlGZKFhH/CWy1AIOP82jGu+IOlMzvkQCHjPUroLlMwuYO1rIQlZr+4ChQkJr32KAjBui1GcQARYxZiCx6XCJHGmZ4EoaLuHD5HcjkBc7BVeBRv9+fGwzRRgl8uRfy2MOa0a6ANMZzcL56syvqpR9V8ojlIQ7xpLelRI/yOVcc+JSC8RV+qKytnfgZRy3BupZGr5wqn9ilBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQZqPoG8JbbtqMfUjnH4b0NLOVkqpqnJ/D1xLXg32QI=;
 b=wXNHsWgGVYP2TbV0tH0z1AKHBZdPaGy+RsoKYhyhZs8HlTwvvTOntU0jnSFg1OleEYDxQa9wHw5QdilFJlKTpveOzpxLNwWpwKuefTFZp2JvCCPDVi9JnfLmTLhR2LDru/+lJP3hcbXOqRSFRzNoFLB1AaHAFES06+E0eGcMbWQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Mon, 5 Feb
 2024 07:03:00 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7270.016; Mon, 5 Feb 2024
 07:03:00 +0000
Message-ID: <39fbe614-82c0-4ec1-87b8-dacf72628220@amd.com>
Date: Mon, 5 Feb 2024 08:02:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/4] firmware: xilinx: Add ZynqMP efuse access API
To: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
 srinivas.kandagatla@linaro.org, kalyani.akula@amd.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
References: <20240202113843.17999-1-praveen.teja.kundanala@amd.com>
 <20240202113843.17999-2-praveen.teja.kundanala@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240202113843.17999-2-praveen.teja.kundanala@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0031.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::20) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: b38bf78a-3010-4d2c-bda3-08dc26187d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OTPS1/QjgJrHb7WkMsj0raL3daZTbuNnYBGg4VOnHixMKR9eSUBzMmJiQO9b2o18iEhbTaEpkYP2Lz7/y+2NYLIHSqfbGLkA/z767RU738leyuxfJhpW+EvTdBvG9gHpE+1HUzUVf/0IebPwriWRsryojhtQ1jg+fUeul6ReTPwJC4W31bJnPLeTYV6eLHcgXtp44oocbh6v9hkfZwfQyeiETfr9mfYZ3e4kTiKCrRjHR2jn1/dU8TEXmFcXif7be/P9Zt4Ht8gDXWO1iFo/2GPMWeKHN2LrepbCBtyYxWBUQhwooLNmE7gsL8uN7RDD+3K31uM9+5Vi3MpivDt+KP6GqyEzw/s2ux5jDrxVSRAX14y1hysq62BXE36bsWrRL+Ws5bUCXh4lI/T0LlI/i2NL1uh+Mc/Jhuo+KU6SAiuer+LFehJMzzeu30ndF4Tu/kjiIJ6K80SwdddG0GxNaz9x/CxNCsZTeIQV+U59sC/jJtWqKcbtbHrdVA6nnbcSQbdTAOQC+qrvCzQgCqYhaPpxyDiGihtS8j6R43jEOusIeZRzFZ9Ey/gU9fkU6MN92MAHKMiLpc3gv/rmZ5UxXIWaNmqyXsq449JEsGxAIBgDEKVrR/bFzN1sUkZE3h41AyWbUCRlpkTrjntsh0bx9Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(2616005)(478600001)(6666004)(53546011)(6506007)(6486002)(41300700001)(6512007)(8676002)(66556008)(4326008)(8936002)(36756003)(66476007)(66946007)(44832011)(83380400001)(316002)(38100700002)(31686004)(2906002)(5660300002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTl1aHdLb0x4YUdkMkJLbGFKckZ6RHBjUVdaZGhjbUdsQWllUDVtQUpZR1Ry?=
 =?utf-8?B?VUxrVS9IS1owWGRQK1NCN05QVjQwemVxeXQ3S245TTgySUdRbVVhRytIRDFt?=
 =?utf-8?B?OUNOZ20vY1dTR0RQUkwzTFBMOGJCZXdCZXJteTd2Qit6TFZidGFJTksveEJM?=
 =?utf-8?B?SWsyY3ZsdHdSejUwY1QrMUNIT0YyL09ZMWw5L1lyLy9SdFlOTWJTQnlDb3I1?=
 =?utf-8?B?YU9URENuNHB4REpETFErLzROa3drVGVMSFpPcUJTSW9RcW5YUlloeE1laEZy?=
 =?utf-8?B?M25DcWVqRnFPM0lUMFpiTkozTVRSTjhYZUJlUXdFQ1Q2RHhEZk1WWVUrU2k3?=
 =?utf-8?B?SFE2UTZXVEdBTHF1eFNtNmMvdm1maVpVdlJERWY1VmJoeVpJbTlabjdJZzMw?=
 =?utf-8?B?YnRMcDI0MVVNc0lZTzhJZzhKOWE3L2kycHpDc0xJNVdJTHZqc0VzNkpGbTZp?=
 =?utf-8?B?OHV6bEdkK1piRHh3T0JIbjhoanJxYVlQNUNJaDRwVkplSFJnWWpaYklnNllt?=
 =?utf-8?B?TElqYWJuUlhKUnNuUXpKYjNvUEcvQThiZmF2b0JKK2ZBK1RwTW5Zd0RyYUJi?=
 =?utf-8?B?NlhRQnJrYWJjN3o1c0VzTVYxbk9MTUMydWJCRFZPSFBKV21zQ1R2UTN2eFlw?=
 =?utf-8?B?NjhLdXZWZ01ubWRKYkI2a2c5ekJicnl3eUlZU1Bub2VUcUpveW1VUWdHa0xs?=
 =?utf-8?B?elNRSXpRbXVMUFgyVFU0S1BrZExPVnBHZnRXTUExMFlrWlNtNVIrNGcwc1FP?=
 =?utf-8?B?M0RVYkJJMWRNMDJqbFNjazZXU0k3T0p1RjA1TGVyRXU2TnBFN1N2MEt2eXpS?=
 =?utf-8?B?eE05MWN3WHNOVkxMamZ3emFpbWUwRG81RHFCVVVLS2lnRmVSdHFGRDE5b0lr?=
 =?utf-8?B?dnpWS00zS3daa05tNDlNdXNTdFVrRXB0OFI1aHk3OThTY0JMeFJiWVdYSmFJ?=
 =?utf-8?B?Tnc2ZllmcGtnOTNkeWc5UTU2YTlLNUNpeWJPUDd0TUJOMGVPU0s5eE9DUnpu?=
 =?utf-8?B?WnFzQ0hDbExlRG1HNnJtZkFQN1MrMmtPZXNyMUZ1NGpFL21LSEJsY3l0NFNL?=
 =?utf-8?B?OXRpVlViY21Nd2VsbG9RUmROOXZvK3pwb1daSk5adWpGQms2QXNybG1JUlNs?=
 =?utf-8?B?VnZ1NDdsVzNra2F0TzUwZ3h6WkYyOUlJdGtrNlhJWGUya1M3TWNISllxT1Z6?=
 =?utf-8?B?S1QyYlYwSWZTU2FiZUZrZVFsbENHS2hqT1dQbVJjR0xuOGw5UHVwaEhGbmVt?=
 =?utf-8?B?M2doMS9IUFg3TURrTUFUMS9Fc2F5T1ViMVBibytab25CNXgxclNOSjk4M2NK?=
 =?utf-8?B?ZjF2d3hLcDBOMEgwM0RRYnBUR1NKbmtneEthRmZXUUlJeEdnSjNObXFEZ29S?=
 =?utf-8?B?TC9FMHBHdkpEQ3dQNjZ1QTFvOHkyS0JtVnc2ejJnajdPS2NBd0JZT25XU2ZS?=
 =?utf-8?B?U1VJWER5eEl4bUJvZVlnblltZk5lM2hVRTlQWFVRWEdYbThOeFR0ZVR0WXBM?=
 =?utf-8?B?VE0rVkFRUlJCRVZDN2E2VnZMeUdnZk5rVVgxNjNQejJWTDZ2S3RjWjV1VENT?=
 =?utf-8?B?S09xUEFyQkU5azFxeFF3aGJKR2hqUUlRYi92WG9DRndzSWVkTzc3OFdpcTlW?=
 =?utf-8?B?ZFVSNzZnSm1XUndoRmV0V3ZwaUtQSitzVkIxNTAwSi9aY0Q4MHVxQjNKNEta?=
 =?utf-8?B?Q1Y0WjJQYzNVbTBLN0R4RmVxWnZWS2tvdU1xck0vRG5nMEoySmQvd042L012?=
 =?utf-8?B?MGVrQmlFYmpDTFZISHF3Z1RmUWNKV0s1WkJ0Q01abnQ4UTVBQmZ4ZE81ZTU4?=
 =?utf-8?B?citLdHhCSkxud1dpekc5RkxpblhodVZjYUUvdG40YTFIVXhHYjFPTmZscDEy?=
 =?utf-8?B?a2pWVkV1Q2w3VDJNS1pwTVpuRHlUOXA0bGt6bDcvejJDUFVmcDQwczExUkU2?=
 =?utf-8?B?S0VWa0tCOTVhYjN3QnBWK2dCWXZucndYaE53K092YzlBd2FxdG9IYkgrTDZt?=
 =?utf-8?B?ek5rdmRSdUhudEsrZFJrSDVNRFhPNFFWMDNYeFRKYTJHSWJMdkVMYXlZeDJ2?=
 =?utf-8?B?bk5KNW1vSkg1YlVjU29uVzIxZlBaYmNwVmlEZmFKUGx6SFRpbEpSR2ltbG9H?=
 =?utf-8?Q?J+1REVnRB7XPzDpCmvKIxKRw4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38bf78a-3010-4d2c-bda3-08dc26187d6e
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 07:03:00.7506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sTRfU5a/ZY3HPZMGzgH66SGvQqNTky8rHzzdVpUu73Z3yo6neu+cRlJRJdPOXl7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632



On 2/2/24 12:38, Praveen Teja Kundanala wrote:
> Add zynqmp_pm_efuse_access API in the ZynqMP
> firmware for read/write access of efuse memory.
> 
> Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
> ---
>   drivers/firmware/xilinx/zynqmp.c     | 25 +++++++++++++++++++++++++
>   include/linux/firmware/xlnx-zynqmp.h |  8 ++++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 79789f0563f6..9bc45357e1a8 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -3,6 +3,7 @@
>    * Xilinx Zynq MPSoC Firmware layer
>    *
>    *  Copyright (C) 2014-2022 Xilinx, Inc.
> + *  Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
>    *
>    *  Michal Simek <michal.simek@amd.com>
>    *  Davorin Mista <davorin.mista@aggios.com>
> @@ -1384,6 +1385,30 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out)
>   }
>   EXPORT_SYMBOL_GPL(zynqmp_pm_aes_engine);
>   
> +/**
> + * zynqmp_pm_efuse_access - Provides access to efuse memory.
> + * @address:	Address of the efuse params structure
> + * @out:		Returned output value
> + *
> + * Return:	Returns status, either success or error code.
> + */
> +int zynqmp_pm_efuse_access(const u64 address, u32 *out)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!out)
> +		return -EINVAL;
> +
> +	ret = zynqmp_pm_invoke_fn(PM_EFUSE_ACCESS, ret_payload, 2,
> +				  upper_32_bits(address),
> +				  lower_32_bits(address));
> +	*out = ret_payload[1];
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_efuse_access);
> +
>   /**
>    * zynqmp_pm_sha_hash - Access the SHA engine to calculate the hash
>    * @address:	Address of the data/ Address of output buffer where
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 9a7e52739251..1a069a56c961 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -3,6 +3,7 @@
>    * Xilinx Zynq MPSoC Firmware layer
>    *
>    *  Copyright (C) 2014-2021 Xilinx
> + *  Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
>    *
>    *  Michal Simek <michal.simek@amd.com>
>    *  Davorin Mista <davorin.mista@aggios.com>
> @@ -171,6 +172,7 @@ enum pm_api_id {
>   	PM_CLOCK_GETPARENT = 44,
>   	PM_FPGA_READ = 46,
>   	PM_SECURE_AES = 47,
> +	PM_EFUSE_ACCESS = 53,
>   	PM_FEATURE_CHECK = 63,
>   };
>   
> @@ -562,6 +564,7 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
>   			      const u32 qos,
>   			      const enum zynqmp_pm_request_ack ack);
>   int zynqmp_pm_aes_engine(const u64 address, u32 *out);
> +int zynqmp_pm_efuse_access(const u64 address, u32 *out);
>   int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags);
>   int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags);
>   int zynqmp_pm_fpga_get_status(u32 *value);
> @@ -749,6 +752,11 @@ static inline int zynqmp_pm_aes_engine(const u64 address, u32 *out)
>   	return -ENODEV;
>   }
>   
> +static inline int zynqmp_pm_efuse_access(const u64 address, u32 *out)
> +{
> +	return -ENODEV;
> +}
> +
>   static inline int zynqmp_pm_sha_hash(const u64 address, const u32 size,
>   				     const u32 flags)
>   {

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

