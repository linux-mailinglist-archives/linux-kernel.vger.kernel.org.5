Return-Path: <linux-kernel+bounces-32403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F47835B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63691C208F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA210DF6E;
	Mon, 22 Jan 2024 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B/9fy1H+"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCDDDF54;
	Mon, 22 Jan 2024 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705906557; cv=fail; b=Kh1gyK2iA/WP2u1Igz25xnjNlSmQDR1eaUzv0+GKd9gPXSlPNwn4ZaaHF2pSR53rc4qulDSD97WjcbbzrHS+E022rAmTCZmmxwmf21vPtj4sfcYLtye0tPI2QjxZhkN6qQLA2h34lvOVYThS1aJZH4J7cIizZfThOcznd+/M0B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705906557; c=relaxed/simple;
	bh=ZFz2+Nfe22PtS4ekpnCV+eG/xylhW/3I17i4qoxIAdE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=itaT1LaNZoT2TzGgG5lQgG9hejrUaGW0YOMHLmZHLcK5SIglddggU+sKRQBxdUuwuB5qaGsrj+4Gf0OCAMRmT4n7PtqgUa5tSWCPsabjLX6YnAwElTMNSfKmrC8hMMkv/72I85AzXO7XjxvwnGnUZZjBNIzllbAlORNVboD13Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B/9fy1H+; arc=fail smtp.client-ip=40.107.101.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzJskRYUhaRczFiA+ZVgjxe0rs/YL64hZGEy3lxrz0eMDbh68oCs+ZabTvKw3AgarP7Cn8EdxIHtVHY6ekuPfda48fbZUIC7wCdIdomvdBOasMhTPrXaAnUAddHmBNa52CKD4VylRE1p8UPP0plP6HAtNhKlF4X0/84fWXL3y1I0wbo+awt0vc3N699MVHBQJ9K+Qbri2q2W/ojQF3ZF6UE4kaykv0QpgMlxRxr4/O0Wxdw6wS0xlkhJVpnc+jNtY8SggBkwCutCy9JKaDg72YFYN01b8HDZyBDcOO059z42o8dGbRbpAhUvIwslsolB55RILR67MJFmu5zh2sVBVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/bTVhc1soV/Kyj7PXwmqqAo8M2AZUuP1jJr/FOsu/0=;
 b=fVIMU/m8ahH44y62YwlM6fduzyAtXf0nq9HATnMHjComqaHujvUR8Wfl+cZLDhLqz1opELQIrHkrYPSHXg3C02hJFftGQmVjkkBOZmbb2MbTiPpxUCL3MDvl/2HTEelqoPZdSZgT7FTZ32+2Z1tsdwSMFpnnDnCVUvQBLqZgngEXueHlAkJB7Apttww0IAl0huelty4S1Sm7AjcBmWqb0vPHTAzzhos2zZfZ6rdOoqa7XAF0oAk9zTCXSXvQwbNMv/MfztUNzA+MjW2oS2TIaQd8jjhi3YkDJe9Qxa3uHfdA8ZPKqwM4ZS1A1BMMpK+nygGxvt05v+YJzLHwIbdOow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/bTVhc1soV/Kyj7PXwmqqAo8M2AZUuP1jJr/FOsu/0=;
 b=B/9fy1H+jevS4DoNrwTRFDh0WOB8KNbfZGZvbolUMQTL+JvWlw0a+QIdRHRPUWG//bKzjLZhN4PRJCcD6AfOpipG7zSwm6aZoL8fLQJM6ZAcZQmUReO4ElgYGsOqMRIL67DHLpDAq3EGFoaw5seHDv/t0R7nztmoqvM6Pzewozk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Mon, 22 Jan
 2024 06:55:53 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 06:55:53 +0000
Message-ID: <6e9ae678-7301-4a99-8644-cfbc11816cc6@amd.com>
Date: Mon, 22 Jan 2024 07:55:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: pinctrl-zynqmp: Use devm_kcalloc() instead of
 devm_kzalloc()
To: Erick Archer <erick.archer@gmx.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240119181909.7079-1-erick.archer@gmx.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240119181909.7079-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0123.eurprd09.prod.outlook.com
 (2603:10a6:803:78::46) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c5a8ae-77bc-48b6-218a-08dc1b172d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LycUgGcpgCMuBsOotmgz1Zas/A7Us+wIZlHj7rnQTvmdJslKoudwGzPgBYFgKMgIELrYWuSsgS6QDdWaMBctaDvTm7u2zhy4bf9622i4yx2gqqTqOkvt5ZwVkd+TOhcTfZxuYmz4ZFcITal4vVAXmzAlgpX4FOysaXF3rnXViBrbR8fYSvSH+KecSbWLjCYBpe8MOkigEJKmUontUw7CYIRGbVo95z0Q/+EjNAH0FhYoo8TxeiX4BIJT7p3LTDPHY6XtZ/iIrEyBFyRX/eJtXKn52ApfxbrHjUg60EzBURgVWbw1F7d11kceMVZZAvBOzPbISLd6aUWMxw+wM8YWE2vHSL6hGjd8KgcX3NWXZccqLlRm4R/KKKxpA/+nwjIrgCpRwFObsQS2fZrkgqUR2QtFEbWF/4cQ7paqT5TPM/5j5ydWH0Rre08ZF/GAfIzm3dVWyX2z2jsfNFi+YRe4ysi2YSd/znDic2oikNCXtET1Eof9VlBLaF0FGrFqiYMcBKZd3nBh6f4HFucP6eHvxMEUaHV1pi3ZYAE0Cl2pq4DsG23cCC38NIwrW9Fctp5vvrpwBgdQyUUX/gQkMO5XN+AwKG9dU9HnrwSBT5ONKNmq7qB3PN7pC+6wic7E2xX9k8VmLOu9y2vKy4v1IPjKI7Uaf4a0W/k7kLXZhmAexF7AHCb6Tbd1uNolSPM8vZYsy6A1v3R1Qi+YNfhQiuyeCw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(6666004)(6506007)(6512007)(2616005)(26005)(38100700002)(53546011)(86362001)(83380400001)(31696002)(36756003)(2906002)(6486002)(966005)(5660300002)(41300700001)(44832011)(66946007)(316002)(4326008)(8936002)(110136005)(478600001)(8676002)(66476007)(66556008)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGZYSW5nbHV6d1VlYVgraDVrbzNTcEg1MFNWVUw5SFNHRVR6bkFoSVNIbXVH?=
 =?utf-8?B?SFhndis3RGgwN1E2cStXWUhYSCtmUHNsVDl3cHpySDR2S21IR1p0OVU5MVFG?=
 =?utf-8?B?VHN3d0VicHFpMFN3bmxndkNRSkM4ZmhYZzVmUmNOZGMydmk1UEFTSm5zeHFq?=
 =?utf-8?B?alRNYmlQOVg1bENQdElQTzduSnRudlFybC9hck0ySXdPSkhwK1g3TGJNa2VI?=
 =?utf-8?B?VDNxVXBnNjVuWlhWTVF0U0tkUDNLTWprZEVkR214Y1ptL1ViL3M4aHNMUUJF?=
 =?utf-8?B?ZDVQYzNsR2NkR25vbDBjVVVHSTRtY3N6Y1FKR2NFMTJETnhNNUtFT3VGVHJs?=
 =?utf-8?B?cDdBMk9jTm1ua3dxcUpGU2UrVWt6U3dtR2hPUThFOGJpUVhPN3daRjVSbnMr?=
 =?utf-8?B?eERlR2dqaU1BNml2NHV3cEhDSGxVbjFqWWVDeWF5LzFZYTdudVdXdEFscGhh?=
 =?utf-8?B?NjFZT3pJYTNScHZVMmRPWHp5RjBQZXNlZnRNWUo2ZTVPZUtMMW56cWRSbStF?=
 =?utf-8?B?WWhySTFuMENIMDkzRzgvcWJBZHMvQndMNlQyZW52N1lEWTlYMDBkQXNYRFlH?=
 =?utf-8?B?NEtxUmVFMFJQY083UzlqdnRWMXk1OHpMU2dNUW91ZjVVMzVwU0RJaExQVm93?=
 =?utf-8?B?MlhxZDJlNUZxM3ZsWDNQRlRicGxMcHVNaWVxbW1DYnpEZ2VhQnlLZE1SYlR3?=
 =?utf-8?B?WFdTanAxRE95enN1cXZtYVlFSVZKLzNWZkNidUxQWDkyRStIQzZJbnFMM3I0?=
 =?utf-8?B?TkMzUUtSTjdEVk80WExMbWZmbThlSHRrN2t4RGxTVUtTTnNWOXZxZnFHalh2?=
 =?utf-8?B?WndDZ1lhWHR4d0k0VEFXaVhFOW1CVDhJK3FFVkt1SUU4M001N2NJRGQ4RkJR?=
 =?utf-8?B?VXJnMmVaWXcrZ2wxcFVhNXg1ZldJczV2emhKaElIMU00KytXOHJsWFMzMWZa?=
 =?utf-8?B?MVJCeENxZC9HdWY0cE1YYzBvTW5yU2FKaXg5ZDR3UjRjbTFOWWZhNGQvWXFK?=
 =?utf-8?B?VGNxRmRMazU3TVgxcG1tQTJhMVlTb0YyaGpOOWpLWHNuNEV6bnJDeDdNczgr?=
 =?utf-8?B?aDA1aytQQ3BxR2ZBdjNlWXcwYkRsQXorNUU0QVlqMmRsYmxLUlljMEtPYWdZ?=
 =?utf-8?B?Mm14bHVpb05VT2NYZmhmZnVzaHBOVkYxUUNrbDlmMzVjZ3prQmY0Q05WNVdI?=
 =?utf-8?B?VHl6UEgvSVNVVFVnQzFoaWxwc2VuY0pYV3NqNkZxZWhKYkh5a1dDdjY5VkFp?=
 =?utf-8?B?amdWMk52eUl0VlZTRlBRRDJlTnQ3dytMUS9aTmhHT1YxYmhSaUdLMEdtWFRS?=
 =?utf-8?B?Z1VhOTUvOVJsLzBzc3hOZlcrUzBOM0FlaGdHU0NYUXdxN0ZkM3VqWkQ4NHNK?=
 =?utf-8?B?MkhHMkF0YVViRkhGUnJ0OGlvNzhWWWFWeTV0dEI2aGxIaytlTXVVZG9jVVJ3?=
 =?utf-8?B?ZEtMalZMeUoxaW1BbFR3UEhrUVNzVmhVZGV5MzZtZFpVS21td1pCaitkYXIy?=
 =?utf-8?B?UXlqejBPNjl1VE1qekFLQzczMm1wOXp0VkplRTRoWTJCdmFVdjdzWXAyQTkw?=
 =?utf-8?B?cnhvZHN5bGM3ZWh5YWNzWjRXUHAvKzNyZGx4WDJLQ3ZLQi9qa2c3Q0lGQTVl?=
 =?utf-8?B?YjVPejdDeXp0ZFFUQWo3R2xkcXpYaTZ4ZkFzcnoxelp3b1VGVHJhY3YrN2Nv?=
 =?utf-8?B?MjR4cWcxK2VBYklUVk03ZVJST2FBUWZiRm1ieEE2MllrMHVVYWw2QXlZOEQw?=
 =?utf-8?B?ZnFDKytGRGVGeXgwMWhyZ3dTSS9HVjhiK0hFSHlUVkJuWXZYVElycmFlSHhU?=
 =?utf-8?B?QWp5ODZ1U2pydk9sRjVwOGQ2d2QvbFhicEpZZVpXNHZoaWtQMTN5S1RkN2Nh?=
 =?utf-8?B?WTV1dU5jdXV1Qis2dlVUeldSOFNxaEw3SmY3T0hRcHVURGpXRXkzWHFZVW5a?=
 =?utf-8?B?TEh3cmNTUU5GcGdFR2h5bXNvY3MzZGJSQnJQaTJaNWE4SVNJbmdUelZTZVF4?=
 =?utf-8?B?ZFdwQTVXYUd4UmVRTjFrcURLOWxMeVNzUXpTY2NxUnlOWVdmbUp6S3pPL0xQ?=
 =?utf-8?B?UUVJVmZsNndkSGR4dmRydklNenM5VTVoZFE3OWZNOHlnSi9XUDZJS2JoUDBT?=
 =?utf-8?Q?DtiZSgNnO/MJi4peUnlLSjnNi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c5a8ae-77bc-48b6-218a-08dc1b172d27
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 06:55:53.8227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsrjPpExqYZ0WMXEHM7+iKyjulMT9JrryS18DRbZRRt8HDwsaxFSSPx6gBJl30A4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524



On 1/19/24 19:19, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific devm_kcalloc() function instead of the
> argument size * count in the devm_kzalloc() function.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
>   drivers/pinctrl/pinctrl-zynqmp.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
> index f2be341f73e1..5c46b7d7ebcb 100644
> --- a/drivers/pinctrl/pinctrl-zynqmp.c
> +++ b/drivers/pinctrl/pinctrl-zynqmp.c
> @@ -562,7 +562,7 @@ static int zynqmp_pinctrl_prepare_func_groups(struct device *dev, u32 fid,
>   	const char **fgroups;
>   	int ret, index, i;
> 
> -	fgroups = devm_kzalloc(dev, sizeof(*fgroups) * func->ngroups, GFP_KERNEL);
> +	fgroups = devm_kcalloc(dev, func->ngroups, sizeof(*fgroups), GFP_KERNEL);
>   	if (!fgroups)
>   		return -ENOMEM;
> 
> @@ -754,7 +754,7 @@ static int zynqmp_pinctrl_prepare_function_info(struct device *dev,
>   	if (ret)
>   		return ret;
> 
> -	funcs = devm_kzalloc(dev, sizeof(*funcs) * pctrl->nfuncs, GFP_KERNEL);
> +	funcs = devm_kcalloc(dev, pctrl->nfuncs, sizeof(*funcs), GFP_KERNEL);
>   	if (!funcs)
>   		return -ENOMEM;
> 
> @@ -768,7 +768,7 @@ static int zynqmp_pinctrl_prepare_function_info(struct device *dev,
>   		pctrl->ngroups += funcs[i].ngroups;
>   	}
> 
> -	groups = devm_kzalloc(dev, sizeof(*groups) * pctrl->ngroups, GFP_KERNEL);
> +	groups = devm_kcalloc(dev, pctrl->ngroups, sizeof(*groups), GFP_KERNEL);
>   	if (!groups)
>   		return -ENOMEM;
> 
> @@ -830,7 +830,7 @@ static int zynqmp_pinctrl_prepare_pin_desc(struct device *dev,
>   	if (ret)
>   		return ret;
> 
> -	pins = devm_kzalloc(dev, sizeof(*pins) * *npins, GFP_KERNEL);
> +	pins = devm_kcalloc(dev, *npins, sizeof(*pins), GFP_KERNEL);
>   	if (!pins)
>   		return -ENOMEM;
> 
> --
> 2.25.1
> 

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

