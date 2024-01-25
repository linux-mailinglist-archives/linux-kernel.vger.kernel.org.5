Return-Path: <linux-kernel+bounces-37987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776A583B946
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DFA1F23167
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1812C10A05;
	Thu, 25 Jan 2024 05:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nSzSU+ug"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3103563AC;
	Thu, 25 Jan 2024 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706162208; cv=fail; b=E3pOaH+bfvl4e/brNPGWX17JhqYR4eZPuG72YZVxdA1MthxolnHZtrO6hQnh8flyEBpd1iuFYgbBhkZjz7sdFoDkezf5pz/46AdWRcJtTF9QFuB5m29317ghx/9Bc+9/+Zzx+tVGjN+IAOwogao+rA/C3L9HIldIL1CzJhiMfME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706162208; c=relaxed/simple;
	bh=/V+FWgUjDTEkc0ZUgmzJ58bc6lDaB294oRDMKvgXBZo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ev9NcopCUZ8Ur1JmJ9x/ggPBY1ngoI+wVnKjwzihT4MvU6gb4QKxu2ainZ4vsbFvw8oTYh+/LICS+8F8caL2ttSquAfrrfJlnbJCSSxgShkpaDjGtpDy9pL0wCVFS/wzTeEPdNARPHw+ANeyBVE6JK8JdLZimSekfR9McIlLTKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nSzSU+ug; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4F447m75Bz3FVS0bkWNQdhBlncIYDSRM1RScxd6bUVNMxhtCtWFvvtC6ILI/8s2U7Al9QapnBoQOkYY8qPAQ/D5RmNbduT+9xp6662huCB8Iza07vmq7JUZjW27OLOYxe5gPtjAk1Jm6P3rDB/oat317tebCAq5zyZDo2Lo5Jr8fUkOhSHP7kME6CsGgiIvthSMkgv5vZn8yWs/e3JrjIIfYZi5/rRx40WziTiVel7L3tGuGnrTKlvH+8LKWZI5AUMD5euwwRsV1JGS2dyaKbtIn6OpoR+Tonh2ramh7I9LU/wT6ai9aDvZOB04Ww3DssrjmwqsYum3GBI8J0Awmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnqdeRQS+YUYKCQdKxaWlmnN+2poHQ2FRXNX6yvt1uA=;
 b=N0ZKzhpcShwRT3k7TkahHaDPoLXh7ZrA41U6Ck5/fKcSYfy9oLBrWHS9vSs1YWrlnIQDPIRKWnK3spUpp4BCaWAdDK/5ceW09modI71KG78aPb2JV2nQc4vvg4mYxThtT3b/59P4d+RCY2DVMi9T7HBi/RnMEV83B4Gy5jgtGN8CfLE3sBgd4dRuUuDPReJ5+PFHi3RGV1FQsVkwkYF2ildoPighY8v09iPB61/MNpY9nsRYvOpU8953hH0wDMZs4/f3iOZ0875uIvZCxbKOAjQ3jo38QpK9lHL/XVPysfVAUM2Kwxx+BCgadIf2oYlsBJOankWmilf/8/tQsYXG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnqdeRQS+YUYKCQdKxaWlmnN+2poHQ2FRXNX6yvt1uA=;
 b=nSzSU+ugoBY15i6WsTFsmbWAMSkaWdupusVzAkQo7NkL2vhpVXClLh4Z3xXu0np0KM4ibanEjZAuMoVayna4bGqSi6NuRiCRDOThp5WlRPaopk5QQuj19M9/JIiihzuSKhoufrctdHuEYgR6gDriQGAyhNYLofKMA0ZlWNZ7pVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 05:56:43 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3%2]) with mapi id 15.20.7228.023; Thu, 25 Jan 2024
 05:56:43 +0000
Message-ID: <fd8df604-7023-42f2-a94c-4673c1415a0e@amd.com>
Date: Thu, 25 Jan 2024 11:26:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] iio: hid-sensor-als: Add light chromaticity
 support
Content-Language: en-US
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 jikos@kernel.org, jic23@kernel.org, lars@metafoo.de,
 Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240109180007.3373784-1-srinivas.pandruvada@linux.intel.com>
 <20240109180007.3373784-5-srinivas.pandruvada@linux.intel.com>
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20240109180007.3373784-5-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::14) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e820f2c-0fb4-4c0a-2b6b-08dc1d6a67e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PHvxJ+boKcYDLLJekEvrpqh9kG47UXIjEHkusfb5PE4cQw/8Tlq4nEEj7v6J3dMtnCW79Afn43WDjvSXbUtR4NCFebO4SUbeWXcOIpORE/8O8Po7/qbEeZ1++qoeqemKYO9C2faHWfMmNNQumQNMoeFnvz4vZAC23dx2+KJoqio5rlz6BIf6o9P948THdC1fkJrIaFQMbC8VSWfvmo6WFVUxWwNjCq4xxaRIymgbaNBVMWF5MPqkwm1RFOdhHXqYj6pQhl7t/E07tXlPjXyFljBdYsksHe01ILV7MibvuvdfRjOWnLQsT6aMZIH6uaZ97goD2x/ouvE7sSy9MRhrBmMe8XOyxBiKEYLzAlwP05LNNxxOj1V6j1+Z0zWlW+XLtAdg1A5lhckqNi9/gzfyVrhd7goaDqna5USxp/EV4HalHjiNtMMAQ4jeMqKxGINzsxK+E23InTUuQPSVav2uZ+MD4czUwQda9qRXqDExbTJb4f4VD9Uc1mfr+IG1sr9/EeGa8epvRZxOyW5eZGJBvS/bEpPtiRsj+6FYMOwDcgSR33nY4RXEqBIt6qXVzMg/2FGldDKcmj/MVMXo/hHZwiZTInZWgzqLvwlnostBZ6sL26w5Bq854IFw3ILR2jY57ABc0nbTirYZg7mxmm17Qw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31696002)(5660300002)(2906002)(41300700001)(36756003)(31686004)(66476007)(66946007)(66556008)(6512007)(316002)(6636002)(83380400001)(6506007)(38100700002)(6666004)(53546011)(478600001)(6486002)(2616005)(26005)(8676002)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFJVOVFkRHBNdURvY1VQakJIYXhhdEdYYnBqU1YrYzFXRlBOaTFKbXhyUTBi?=
 =?utf-8?B?SFlQajhtTkpKQ000ZjArMm5Eak9HK0hqRGE0eHZsaXBUc3NMMURHTkdYUkV6?=
 =?utf-8?B?Q0k5Z2x4V2xVdGN6MVhsaXlFaHM3d1FTb3AwWmY3REltdHNIdUJYaVlJYTNN?=
 =?utf-8?B?L1RhenhwVzV1T3RlRU42WElFUmlQWmpHM2JoMzhnbGNtL3ZUYlVMczRnLyt1?=
 =?utf-8?B?OUpLTy9kcE9SaHJnOTUzeXR4UXFYM3piYmFQbm1XN3orNmVKM3FLaHBvVDNS?=
 =?utf-8?B?bGQ4Ly93dmJ5eldXT3IyNXk3ZHpnSG8zV2cxc0FkN2tuMUZHV2dVS2VZL0NR?=
 =?utf-8?B?SWVHN1pra0owd3E2dWVFemdTT0NSNHhZS3ZZOHZxZW1hZkM2WDJ2SE9BVU05?=
 =?utf-8?B?bXVmNHV0WVNPYnlPTHBiUGdJN1FJdFZvTStYUElRKzM3QzBUSW1iaUNMaFIr?=
 =?utf-8?B?eTllazVXRW9SU0dYU1k4K2lLNThXSkUycHJBR21aSFh3MTBJUmNqUHM3cTJE?=
 =?utf-8?B?T2lOMmp5WkdmRS9iMkVvbUR4UnVOQUtaVzlISFNrWXNrQWNHVlQraDZLL1NO?=
 =?utf-8?B?Y0pqUCtWaERuYU5pOUNDUTg0WHhydjVpN2FFU1hzeXhjZmxWYTRWeW11dGZh?=
 =?utf-8?B?VEdvMTN6dHI1V0VZRVd2Mk9Rd3RqVVI4aTczSXNOVnFReGkvTzlnSVZoM09N?=
 =?utf-8?B?TFhZYnp4WHV2L1M0RUFMU0dad0dUa0RIQjFNMkhoR3F5ZEEwcXZXdnZFOVpJ?=
 =?utf-8?B?LzBUMDZGQW5FVDdQZ1VvNkRuem9oMVMybkFoL05NdVAyTTk5MlBZalZ6cVcr?=
 =?utf-8?B?c0ErWXRNSnB3VVB1REVsUUJDRmkrVU9VdkdhUzZCNzhRT0hDQ25DTVNHR2ZP?=
 =?utf-8?B?QUhZSE1rTlFMNUloUXVwcEtRR2o3K1lpc3NybG5TTFJuaVpFTVVJTGJjMngz?=
 =?utf-8?B?NjRZWHRmVjRhQndidG9nSGQrODBTaW1Hdm9MTG9JaWNZTWZjLzMveTYwSVlr?=
 =?utf-8?B?WEc2elJWS2MvVTk0MFg5dnh0MFE0WGlLbHJNTkNoTldQSTRCK1hTbXQxYTlP?=
 =?utf-8?B?aGhWcG1vWjRpcmZiTkNUK1UwcE9kRkVMNlNCS3JqSXBMSzdOSXdNL1E3N2xS?=
 =?utf-8?B?aEFWZVgzY241NWJOSVp2MUpzbHZ5c3RTK05KN1ZYRVZzVGNQVkVyS1Z4Rkg4?=
 =?utf-8?B?dTUwLzlyWGhpaHBYZXpybDFRTlhaSWtacUY3ektjQlM4cm9YNlR0V09OWEZz?=
 =?utf-8?B?R2NkcFA3eWUzd3Y2cWN0QjhNUTJDenVuM3ZQN0E0WHFCWDFjd01qSTZmMFRt?=
 =?utf-8?B?eElKclNhelNxOWozRUJDMXI4ZldyaStFWmFTNk1NTUEyc1VmZTFKTHlPUkUw?=
 =?utf-8?B?SWVRNGRqaWp4aS8vN2tFVEZaWTR2aGtBV2hYNm9DV0hKSjA2THIwWU5MeSs3?=
 =?utf-8?B?VXprSlBXeW1WeW9kcW1HUGQ2WStwMFhTWUFmSFk5OWR1aURpeE4xYU1RdGhw?=
 =?utf-8?B?Y2Z0dElMNURmYjc4K3VOMHRuUS9hQk8yaWlUem1sbUkzWG1GQUJaSlRuNkRx?=
 =?utf-8?B?L2Q0MlNrMUE2K2VSK2o1OWRFRENqWUtYaS83NC9BeU5iYUNNK1A3VHJjM0dt?=
 =?utf-8?B?bXdzdXpuOGQwWWViQTJjc3FDbVkwVmdiT0gyMDFQMmRpSThZcXF0S1I2amJh?=
 =?utf-8?B?RmRFREYwQ21IZ3BSWEx6c251Qlh3TTFKTVNtUWNPZlNtTTBQRUZkMDlYakZ4?=
 =?utf-8?B?SElRelVaNVZ4ekpKSDlwSjFKSzZjOEt2ZzVQY1FBbWV1Mlp0SEc1QWVRUVVN?=
 =?utf-8?B?d1pLakxzcmMwUkliaVhjeU9ESlhSTzB2ZDF2QmlheVg4eWc1TFVKa2Z0cGEx?=
 =?utf-8?B?cGo2cVdKWlBVNHpUbmN1MjRxdExiNHJKWXp3NUpYdjJLdnptaTJCWTVLN2E3?=
 =?utf-8?B?dWFsa2NJUmhZRVJDVmEwRFpiTllhMU9Gbkc5SStIT1Rod0llMWp5QnN4NWJ6?=
 =?utf-8?B?T2JrcHFCdHJCM21OT3VwcU5TYzQrUXhhdmFzWFlSdFptZTlTZVB2SUFONE1J?=
 =?utf-8?B?bUNIS1JSdFlNemFnMXo2WUFNeUNVZFllNHFZdWgzNEV4V05LWWtYSU1QTjZ5?=
 =?utf-8?Q?Rpt+MkqwKD7pwYfypaf8rufZ9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e820f2c-0fb4-4c0a-2b6b-08dc1d6a67e9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 05:56:42.9927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InOnk4xxXgBg6UtWVC1/RLOkmTZcVi/IrevRQ/eu+077aEPya1y7w8EbM2Tm08RJF6nrh8N0rtJQsQQh1mwifQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024

Hi Srinivas,


On 1/9/2024 11:30 PM, Srinivas Pandruvada wrote:
> From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>
> On some platforms, ambient color sensors also support the x and y light
> colors, which represent the coordinates on the CIE 1931 chromaticity
> diagram. Add light chromaticity x and y.
>
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> I don't have a system to test this patch.
> Hi Basavraj,
> Please test.

After fixing both comments in patch 1 all works fine.

Thanks,
--
Basavaraj

>
> v3:
> Simplilified as no special processing is required in als_parse_report()
>
> v2:
> Original patch from Basavaraj Natikar <Basavaraj.Natikar@amd.com> is
> modified to prevent failure when the new usage id is not found in the
> descriptor.
>
>  drivers/iio/light/hid-sensor-als.c | 48 ++++++++++++++++++++++++++++++
>  include/linux/hid-sensor-ids.h     |  3 ++
>  2 files changed, 51 insertions(+)
>
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index 0d54eb59e47d..9c31febc84b8 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -17,6 +17,8 @@ enum {
>  	CHANNEL_SCAN_INDEX_INTENSITY,
>  	CHANNEL_SCAN_INDEX_ILLUM,
>  	CHANNEL_SCAN_INDEX_COLOR_TEMP,
> +	CHANNEL_SCAN_INDEX_CHROMATICITY_X,
> +	CHANNEL_SCAN_INDEX_CHROMATICITY_Y,
>  	CHANNEL_SCAN_INDEX_MAX
>  };
>  
> @@ -45,6 +47,8 @@ static const u32 als_usage_ids[] = {
>  	HID_USAGE_SENSOR_LIGHT_ILLUM,
>  	HID_USAGE_SENSOR_LIGHT_ILLUM,
>  	HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
> +	HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X,
> +	HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y,
>  };
>  
>  static const u32 als_sensitivity_addresses[] = {
> @@ -86,6 +90,30 @@ static const struct iio_chan_spec als_channels[] = {
>  		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
>  		.scan_index = CHANNEL_SCAN_INDEX_COLOR_TEMP,
>  	},
> +	{
> +		.type = IIO_CHROMATICITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_X,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +		BIT(IIO_CHAN_INFO_HYSTERESIS) |
> +		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
> +		.scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_X,
> +	},
> +	{
> +		.type = IIO_CHROMATICITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_Y,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +		BIT(IIO_CHAN_INFO_HYSTERESIS) |
> +		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
> +		.scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_Y,
> +	},
>  	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
>  };
>  
> @@ -129,6 +157,16 @@ static int als_read_raw(struct iio_dev *indio_dev,
>  			min = als_state->als[chan->scan_index].logical_minimum;
>  			address = HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE;
>  			break;
> +		case  CHANNEL_SCAN_INDEX_CHROMATICITY_X:
> +			report_id = als_state->als[chan->scan_index].report_id;
> +			min = als_state->als[chan->scan_index].logical_minimum;
> +			address = HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X;
> +			break;
> +		case  CHANNEL_SCAN_INDEX_CHROMATICITY_Y:
> +			report_id = als_state->als[chan->scan_index].report_id;
> +			min = als_state->als[chan->scan_index].logical_minimum;
> +			address = HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y;
> +			break;
>  		default:
>  			report_id = -1;
>  			break;
> @@ -257,6 +295,16 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
>  		als_state->scan.illum[scan_index] = sample_data;
>  		ret = 0;
>  		break;
> +	case HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X:
> +		scan_index = als_state->scan.scan_index[CHANNEL_SCAN_INDEX_CHROMATICITY_X];
> +		als_state->scan.illum[scan_index] = sample_data;
> +		ret = 0;
> +		break;
> +	case HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y:
> +		scan_index = als_state->scan.scan_index[CHANNEL_SCAN_INDEX_CHROMATICITY_Y];
> +		als_state->scan.illum[scan_index] = sample_data;
> +		ret = 0;
> +		break;
>  	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
>  		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
>  								    *(s64 *)raw_data);
> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> index 8af4fb3e0254..6730ee900ee1 100644
> --- a/include/linux/hid-sensor-ids.h
> +++ b/include/linux/hid-sensor-ids.h
> @@ -22,6 +22,9 @@
>  #define HID_USAGE_SENSOR_DATA_LIGHT				0x2004d0
>  #define HID_USAGE_SENSOR_LIGHT_ILLUM				0x2004d1
>  #define HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE		0x2004d2
> +#define HID_USAGE_SENSOR_LIGHT_CHROMATICITY			0x2004d3
> +#define HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X			0x2004d4
> +#define HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y			0x2004d5
>  
>  /* PROX (200011) */
>  #define HID_USAGE_SENSOR_PROX                                   0x200011


