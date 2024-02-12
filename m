Return-Path: <linux-kernel+bounces-61945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DDB8518C5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5571C21719
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE763D0CD;
	Mon, 12 Feb 2024 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DZJEBtgo"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CE63D0B8;
	Mon, 12 Feb 2024 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754487; cv=fail; b=ukIebBy9DNyvoQZ3JYEbfwAz1Os58ofSXnqDQzCedTQFe6heBava3C7GpGVZ8aVgn0r7eKcmLRi8X2AaiyP88E/GJw0GUqo+O4u+FPsDelqAX01dpbJ5BhztnGA0D4O/27oL4+vc8YvRUU5ThZNHIBwIPBHmCjxIeE0nXSac+hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754487; c=relaxed/simple;
	bh=B4mY6pPW3qiLFpJffCHDuyaWuhIEThXdaWzZpoKMbvQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OdO32msvxz/o053XBXd3IQfIu3PnhOUowtyBH3Yfu1fwuVGVISf0KkoCcoky3L8O0R1BHgzh3K+Ogsou3TZcuUdZIDUvKxwM/blY8pzEj/H9+fF1INZOdNN12AKJg9aGkQ311wGTm7qmvUHNHFPjpeHE6UithBaO/3tB7WgB8UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DZJEBtgo; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCfFaysNs/qeRr1FoEHXtPLKjezyMzXE3CEmB92Ddw2tz+zc6ZCspNgY4tOxyvljMBy4R81YoWKWypOZAs3FeNausEEZ1ayrOSSsLmTyNJ9zKIycfyyz7XVB55lG41NGINwH5y2U2dTzx3QkYUnV54/ookow+3pIc4OrnVjAKQ+uJag8X3YyjOm7jGHIfj849H1zgiQam/fXBHeVEIYNn8XWWR7xNEtTYQ4j21WTiygAhLbMvJrqRkUF5Sk9EopHSvKzDt2lqb3D5j8NISbJvz9JMCVrzBuBPIkbLWwU+fbh7qgCq5Vc0rXMWbFMMvLesihYWR9/xJ1vlY83e4f77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHARQQ4/I67ajJmBpZTtx9Jl31uk6vpWMA7a0hfEcj4=;
 b=ZAsQnsdzHS6kw6jlP1fLAzCOX1dza3qHHVJDSLDKOKEyJC2MyvgLHhvIpXVzt+GKNI3Lx4mhgqlGVboOiXIeUyqdYMS4ilGqMzSYrdgY+gwAsNemZWnB7h8e3ulf9sn5HD/Yrj7Lqtm6pg1ncfBBeZraEQub4s8405WUTURW6RjHsKP5ziFXDdkPPdIaTtDe/AyOgFtNi02TKBNxPXtzccoBLxFNXPnWoDKAyBsVSMR1NEr2Cp1Dpqy3wdwVAl8hT+RAr4Ceb/QggqPTyk1a6LfCQ528Z+yfGSUboL750pg17ugFXKWvd6mdNuMSRRvolsZQ4bXMVvldIsQLJ9okOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHARQQ4/I67ajJmBpZTtx9Jl31uk6vpWMA7a0hfEcj4=;
 b=DZJEBtgoPE5XcedoVTcLsoZ7lYqhCpXj7P3ld1Zky5weQsJaMGkxJGqYtJ9T7Ye8y5u1SYjR58ORHTQlX2AL08mq6vNGvGAxi8wTzwIU455pc6zq7OMpUhq9FYe5aF1FgS7ItVO6265BV0wvnu+eVdo4QJojxcP6RcoygUXgtwLkHCb/tWsPsD4zieZyd1JqbkjZ1TrzbJXfm6svDSjet/wsAWr8OJnOrEk6bi1BfF46YkQAFg3tdO5FTZpqhzy9ev5lVbaM7hb8PeKQ8BY8gX4aANGBlYaSp6sZ1yn/1Bva1iHKBQdlLRyEslykpRetUDLAOEG6UOPtL5Yl+I8bEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.21; Mon, 12 Feb
 2024 16:14:41 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7%5]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 16:14:40 +0000
Message-ID: <8ffbe7ae-67e9-4a3f-9866-3cd744729971@nvidia.com>
Date: Mon, 12 Feb 2024 16:14:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ARM: tegra: set correct naming for Tegra Note 7
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Shubhi Garg <shgarg@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240212071843.6679-1-clamor95@gmail.com>
 <20240212071843.6679-2-clamor95@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240212071843.6679-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0136.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::15) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|BL1PR12MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: dc476693-dfc6-4900-576a-08dc2be5b785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P9Q8ECAAVtykBbM5+8NFMncpmiZf/7crUxsTUZurQVnx5ZCSYIwPjH6uzv7h+PkMsFfUTF82DTmVxszsMMFQNWScptL22pyDOAoG/1+Kz5G/UsAXHI1mqBEdl+K3cw89w4iMvsRtMKJ5JJFmfHWYUD877cPvgoTsapK4fBpYsHOTGPFC2M2kshOXTEWq7/RtZE3Fl07offTdFZOEyPY76zIWUjBSgcRmhxw2JfepTX3kVZYwAOu6XLx1wScRFQby3WjsuUGtW85hkA/zwP19nO1/B6Zrh4o+DvwSeVYNZrKyqZut8dFOehKz9LiFfXUi/UdzBOr2SeEPf4QTFzNvTuayycZeyDVYV6XFzKmfIajvc1zPccUXf7SSq3FdrRzfP+H7q5+xy8UQR/91n6YH3PzYDEe5ruP0InjEPRO7dcXuTCoraxp1DVh4J3Pm3mtnK8MvnC9dctGlEWIsKV5fKQkbR76Xp1Uk/iNtWm7R39lCnyZQ9t/titiipAhWspDabdG36BI8Vq+zTOjJbNFKvcTRLv9b+/oYlEP/xgzZwFnKdSkV/HQVZ0tZCfpdBBee
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(6506007)(6486002)(6512007)(36756003)(2906002)(31696002)(5660300002)(66946007)(86362001)(38100700002)(478600001)(55236004)(6636002)(110136005)(53546011)(316002)(83380400001)(4326008)(66476007)(66556008)(8676002)(8936002)(2616005)(41300700001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y042R0pEUkxWYXc0SGl5akZMTFNTVldrTDdkd3dYdkY0Zk5JYVdCY3VTbWh6?=
 =?utf-8?B?S2NodWNGOUJkRHJOVk5UbzE3OGllY21vdTNjM0wzUDBIK0VLWWIvamdHdUpX?=
 =?utf-8?B?b2pDeENUdTAvMUdPTW5OdkdjVTdvMXNyb0V1Si9RZ2VHblFINGh2UC9jemJG?=
 =?utf-8?B?ais0bVQ4cXVhZGRSeVZlelYrQXl0c3I4RExiejFsSys5L216b09RTnFSMFg5?=
 =?utf-8?B?MnNMcEtncjJRc01PNG45cllDeFhhUWhlTzhRRUZkWkdIcWtnNldxVDNJWjAx?=
 =?utf-8?B?eE5tQVNMbW92R2F2TnE4YVhsZ09Db3JFY1hBNTVBUVEwQUhMeGgvWFJRNWdx?=
 =?utf-8?B?UnFFYnIrcVpkSWlWcHgyc3A5WU9XdlZHYXE4aGZuVkd0bVpYZWhjUUlyL2FW?=
 =?utf-8?B?UU1SdlRRZVA0bm14Smx0YjJibGRKK2hEUWZCcE5YZm1XVk8wdVRzUVdhbXIv?=
 =?utf-8?B?aW9FdHZNNjIwZ2R0UUZ2WDE2bnhYMm5RWDU3cDJGM0JQMUdWTTlXRXNEbWlF?=
 =?utf-8?B?TDBxemdtcDVQdTlmZlJQZjRNQ1pxZkpQdC85aDZBM0hyZU5kZ21YMTlGNE9N?=
 =?utf-8?B?RzJoSEFkL2lGQmpZaGtOQzZuTDNxUThKL0dEb2o5ZUpJcjBjOWFnRFhQaWZv?=
 =?utf-8?B?cjNEUnZERTEvZitWRHE4WEVSM3pZb1NxcVFRLytCUkcrM3VvaGw4eXpPamtq?=
 =?utf-8?B?UlRsWkw3Ulp2VlFLa2IvdDdQcDlYb1NOY050dFF5ekR1RStkYldiV2V2cXJn?=
 =?utf-8?B?cmxHbjBiZmo1WmZDc3ltK0dMdWJ6ZXBTWHV3ZWxNQXhuNDVrOTNoeFdGTG1P?=
 =?utf-8?B?V2tEMFRHKzB4MzlMVzNsVjVZbVI5aGwzZ0RYS2RsT1gydjJOS0NDVWV5TkNQ?=
 =?utf-8?B?bnVRMnRWQzFIMjVNc002TlYxOFhVN0prRWRnMithS1ZJbUYvZ2ZyZDZGaE1R?=
 =?utf-8?B?ZVo5MUtvem1ublBvL1FHazRlWkNKNzZVUUpvRUxGR2sxNmVoMHBWMjl5N0Nn?=
 =?utf-8?B?cGRqTkMvdG5TYk5JY1RwaUZ2bTdTTnN4U3RLQUxmWG5IK3VvVWJtWkp0OUEr?=
 =?utf-8?B?ckY3WnhiR0ljMXdSeTZJMVl1b3BjN3hrek5lOWczbU91cjJvazFWY1NKRGlX?=
 =?utf-8?B?UEF6aVNENDB6MjF1N2NkVm5xQ2NzSlVndEFldTFxaEl0dkNWaWNSOFhWdVdE?=
 =?utf-8?B?TW1yakRaRHRlVVNJOTV5QURSSjNpaVQ4QXMvRVJnR29GT1lnRVZuVms5OERB?=
 =?utf-8?B?bVY4dDU2V3FSNURjWTUzdVlRZEFXUnJtdEhWYWo3eFpzZ082djJWRmRkUElv?=
 =?utf-8?B?MlBTckVUcnVRUE9NcFFaR2h3VkdJckRCU2syMjlORG5aM2ZRaTlMVHZQSDVC?=
 =?utf-8?B?L2w3QTY3Tko5K2xraEs0bzJpZTdMcDRsVUFPMmx3Mmg0dUxUSjhVNEdOeGtR?=
 =?utf-8?B?R29QNDRzSUZCenE3R1ZoMkJ2WkpPU09DUWV6UytWR2k1WDNFOTNJK3ZheE1P?=
 =?utf-8?B?Nnp6QUY1OUJNUVNGYlFmR1FhYllJR2NNbk4zQkxIYzdneTBUTU5YcTZ1dENn?=
 =?utf-8?B?VnpWVFluQ3I5MUNYM1pnODB1UVh5cHZoUFFHc0lxR1lsem9qQ1hhWURiSUEv?=
 =?utf-8?B?RnhrWTZmVis1ZkxBbWI1SVZTSHFHOWFkU0RpaUlYbldDRXdYdENyYU5mY0x2?=
 =?utf-8?B?U2dBK0dnYncydS80aE5pZ2FObk9yRzN1WEoxNXVpSTJPYWlhM3R1N2RqTWRW?=
 =?utf-8?B?eGIvTytZeGZQU1FNSWJaMk0zbjdmQVc4KzRpVnRCeXEya28vY1ZkZ3p6QXZz?=
 =?utf-8?B?bUMxenZITEEzWktpbTBhenZjaTlrSFpqQXhpWFUwYnpQSHhFd0drWjFhWDMz?=
 =?utf-8?B?bTFJVTdidzZETEk5clVlUjdScmdLN2dPTzAycGRyMjlkMVIxNEdkM1ErQ1l0?=
 =?utf-8?B?M25BWjZicVZYRzZmRVVseWQ2VmNhemxIVkp4cWcrMWJkWU1QRlQ0NTNGV2pO?=
 =?utf-8?B?Z0JDdm80K05Hb3RnK2Rob2NNZzN0VGlnU09IWTRwdUMvektnQ2RKaGxCYVJC?=
 =?utf-8?B?alhRSTdsMlBSbjlVK3lRcXIrNDdFYVpTMFUxZ0VWNDRhYWY4cHNlZUpKSmRs?=
 =?utf-8?Q?RHO+f4WduCxJbakI9DVD1WnqG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc476693-dfc6-4900-576a-08dc2be5b785
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 16:14:40.8706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAgUjQ9e+YtnpT5Oa8SrYG6zfJ7NFr/InIDtVR8Xc/L8EgmvEGzJ4jcW1PySpA/39i6m5yg5uqZFgnp/HmFLXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363


On 12/02/2024 07:18, Svyatoslav Ryhel wrote:
> Correct codename of Tegra Note 7 is "tegratab", while model
> name should be "NVIDIA Tegra Note 7". Fix this inconsistency.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   arch/arm/boot/dts/nvidia/Makefile                            | 4 ++--
>   .../{tegra114-tn7.dts => tegra114-nvidia-tegratab.dts}       | 5 +++--
>   2 files changed, 5 insertions(+), 4 deletions(-)
>   rename arch/arm/boot/dts/nvidia/{tegra114-tn7.dts => tegra114-nvidia-tegratab.dts} (98%)
> 
> diff --git a/arch/arm/boot/dts/nvidia/Makefile b/arch/arm/boot/dts/nvidia/Makefile
> index 7a422f150488..474f3fbbd99d 100644
> --- a/arch/arm/boot/dts/nvidia/Makefile
> +++ b/arch/arm/boot/dts/nvidia/Makefile
> @@ -2,8 +2,8 @@
>   dtb-$(CONFIG_ARCH_TEGRA_114_SOC) += \
>   	tegra114-asus-tf701t.dtb \
>   	tegra114-dalmore.dtb \
> -	tegra114-roth.dtb \
> -	tegra114-tn7.dtb
> +	tegra114-nvidia-tegratab.dtb \
> +	tegra114-roth.dtb
>   dtb-$(CONFIG_ARCH_TEGRA_124_SOC) += \
>   	tegra124-apalis-eval.dtb \
>   	tegra124-apalis-v1.2-eval.dtb \
> diff --git a/arch/arm/boot/dts/nvidia/tegra114-tn7.dts b/arch/arm/boot/dts/nvidia/tegra114-nvidia-tegratab.dts
> similarity index 98%
> rename from arch/arm/boot/dts/nvidia/tegra114-tn7.dts
> rename to arch/arm/boot/dts/nvidia/tegra114-nvidia-tegratab.dts
> index bfbdb345575a..30b2ed91be23 100644
> --- a/arch/arm/boot/dts/nvidia/tegra114-tn7.dts
> +++ b/arch/arm/boot/dts/nvidia/tegra114-nvidia-tegratab.dts
> @@ -5,8 +5,9 @@
>   #include "tegra114.dtsi"
>   
>   / {
> -	model = "Tegra Note 7";
> -	compatible = "nvidia,tn7", "nvidia,tegra114";
> +	model = "NVIDIA Tegra Note 7";
> +	compatible = "nvidia,tegratab", "nvidia,tegra114";
> +	chassis-type = "tablet";

No mention of adding the chassis-type in the commit message. Seems like 
that should be a separate change.

Jon

-- 
nvpublic

