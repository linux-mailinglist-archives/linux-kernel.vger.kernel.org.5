Return-Path: <linux-kernel+bounces-111322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B14886AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3473B226D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D243D0D0;
	Fri, 22 Mar 2024 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0WG0kGRW"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2E7224FA;
	Fri, 22 Mar 2024 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711104347; cv=fail; b=V6jIl/BMa1tJv82hBzQU8Q646mSQu59Jltkuj1obOYQ0r9dsWr14IaDwhNNd2p5GI3IWmd+N0Jn8cassMDDjVDtMiNijOo6sRXMK1q5bHGPPWLCITdK4hoMi+C8LxzOMzyYyZelzlvIjqqJnH0J3iHbgYjAwQrfBnb86Nku/LsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711104347; c=relaxed/simple;
	bh=6yH3Jkfl/fV17Lu3XVz2bnGXs8NPodsMJhiwzodTSwk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QjtFzOnNcGnyUUS1aRs7YpdjsRGpYw28PtiCJU/3tmOobCr19ctwIPSMB9TBJxAzv80/2KHber8QwMDdTb3OJnZy/4sPTAxZ7XmiJepd5sF0gXTxMeGRD80PRjweyjqYMvv7VfNK8KLFkPwaEuQ2VcrllEQSO5wq+Jl+IiufJow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0WG0kGRW; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REQzzy0IOP9+wpWJaY+iuGeD9rzd9ZM+T/Fry8l+qh5sMTJ+uqQtS3jxIXMVS/3OdBU0Yt0boA6lK7X+K/h3Jo5eeTBDydhPVkLe4K35+JUA5s9ISHYOYSkG7ElCPvHZOkYQhhahr9vNHHn7DWSJTlWxp693bkOk3LyL44PaWw7rB3GmUvJ2aUhQ/d4GkrE5Uw3p+dBL+MLDw5ZbRCekUxkWFeYat5qDyr6ARzUMerAu2xznTj+CEaPUvDpu/uG0RbNhZXPsrm0xWHLKSMg7lKta4n/CHkX9RcPsFXs9DmKDpLxx0J9qr7gE608jXRalhO+nwbr1p54zyghlIcSaKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJ40fTpi1X3XyhbHNfncF3nrCNL+5Ge4jqthzb7jY/c=;
 b=hKHoatiBjt9KK7p0eZ5xlU2iVRHnMle3cGwHto/9CkXqPkiAtgC/hpppr69T2M9Ee/7yTU6asNUWWGCefzMhkbiQlQzWvezm/hA3O4DLMAMj3sAbGx3PkBbagsAHpGgHfb2AL709UOuBnrMQXmzppk7i7FRbKdwKbqod0l646Wqi2/99cr8mI1qtYSahLjvYUdxeQEi4ddZDkSmOxcWrw+0+l9ipGR+pbfKnk1o26vNlXBCZU8ZnhBo4MAzq6P/JSf0KU/mlGu9Y5/JR6EAvxM6uWKWvkeO+8S9Y/AuIeYMzAgEln7D6810dWeqyxpEWYbn5+lO/E8XhiOAB5fTnuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ40fTpi1X3XyhbHNfncF3nrCNL+5Ge4jqthzb7jY/c=;
 b=0WG0kGRWLfJyOMrbTqNfYCErbVgBhoXAEoTRNFNH7Px0WrsxFdtMmKxxn20DVAEUTiBfTzwx8yi71arIiaq1dAsv4kZg3g75Ku5XRhu/y60BL/VDGG4Sdq2Clb5ibROckkMhpDFIC2Gn2fGmLHd7nGojb7G+QTaP0kK/0pzC2YA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 10:45:43 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3%3]) with mapi id 15.20.7409.022; Fri, 22 Mar 2024
 10:45:43 +0000
Message-ID: <3a057c60-4b4c-431a-85c3-1f15b757b16b@amd.com>
Date: Fri, 22 Mar 2024 16:15:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RESEND] ASoC: amd: simplify soundwire dependencies for
Content-Language: en-US
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, venkataprasad.potturu@amd.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, arnd@arndb.de,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>,
 Lucas Tanure <lucas.tanure@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240322070353.2367300-1-Vijendar.Mukunda@amd.com>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20240322070353.2367300-1-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::12) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f89f3c3-c350-4548-794b-08dc4a5d38dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qVeTZdj0y3AlUCGFHpJ0lnhXXd2YOnV7NsH9bLCP6MWu8pX2RyFQ1rdCQiIM597jbFd3XFxdj0Q1UOKI91I4vmy7T8gLBmz+M2wXQLUsIOWDBv871e6pa5eq+WZ+4Lb3T6Cyy9Q5yMYPEwUxFIJ3YRH6GI7MvAs32owDeeHA1cjBfp3Za2+ViaZ2+DKOWsnKNx12pZi1iSwiXlMxYCL30ez/YuwrIclo+FK9tpdAybIVSjhBKIcq66i33RqVHiKVMaB/2uIOcapBiCiOBd+Cjxj3SoZXdrbzmaX4Mdxk6SUe9K35/pC9253g4ptpsHnP5SdRGkdpATd60agn4gl8f5KMcoqM0cpvO0uju95vyWwqvY7ZgokIp8RtTfMq8RychDy0oZ6rbeBOc5Fi453PpPKG+F0cdMj5+OCiwaHPZOEQtteEFADKr+PJ4rp5PT6uIkfdYBSZlXpUL7MmcFqEy9ikBZ/yvIHkTqkXkxkRl2Tav+5XhRh/EiHSFkEwoyQKQUyH/xFOzqCBtalWkcRLTIR2xAcSIXiF3WXqH7GhFY+Jw+9cLjRCZl3teVMSew6fyT2nmjXXP2ZYFRfdSjkapHFbZtn004o6hDUYfVLWy1NwtmjvMvdGotMmD6bXluXED8/5IAzWNRhV1LN0bqXpA42LzHd31Ra1rHpeXo98bcM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b09OQmYyWkVXeHhWL2kzRytuMTBkMkVpVDdyLzV1R3R6ZlhzWERpdllZRGNm?=
 =?utf-8?B?aTRNa0FvMU9YTC9tMlZRM3dILzlZVVoxcFNJdWFDQ2ZhU2h3WG1JTmZnOTcv?=
 =?utf-8?B?cGZGVVo5bXJnSVRiSzlIcXdaV0haSWJRVWM3Y1hnRlhYYktSOHpyRUNYbUl5?=
 =?utf-8?B?QXNFVEp5MDVBQm9IdTc5VEx0WDc0RFZGZXA3QjE4RS9zSzFOL05tb1hzelMw?=
 =?utf-8?B?TVZOV1RRbmRRVHhmNGpZZTA1L1k0aWx6dUZNa0w2SlphRlhGLzE5WGVUcGx6?=
 =?utf-8?B?UVlvSFhkN1d5bERwdTNkeWVZQzNwdU81Z2ZQUmhudEtsRzQwS3NLWHI3endv?=
 =?utf-8?B?LzlWaEViT2NQdmYxeGFnUTlHNjRlVSt2eDRGOHg4VGo2UEl0TlRkdVp3eGpS?=
 =?utf-8?B?WW9kZ0t5bUZVcy8xdGRHTTF6Zmp6WHRYenVtRzJ2VjJDRUZ4UTJaM0E2MGp0?=
 =?utf-8?B?Y1NwV04vdEFwcm9rSlZ1UXMwaGNCbU1NbUd3OEpuWklpSXFEa0VyaHREenlP?=
 =?utf-8?B?b0hrckw3UFpWZzU2M3JpZEUybEFGczBhTWhWajVCY21UNU5FRHYzOGtycnVi?=
 =?utf-8?B?cmcxdWdHSENMWVhjc1VkZDZUR2UxQzc5WjQ3MUZmVm9DdTh6RTBuQ1l5ZmZP?=
 =?utf-8?B?QjdwaTlyQ0ZjVXN0TVlhYUt6WnM2WVRNNjBRNjgxeHlRQlpkNG94ZEpDN2Zr?=
 =?utf-8?B?Z05VNm85OWVXMWl0Q3JrdktVKzZYR1hHQk1JUDcxUzdvV1pHczJmUFhqRlo1?=
 =?utf-8?B?ZU5zVUE0Mlk5dWlYSWJmQkVURXBkTkdSL2RMWTY0UDFzNXpZWFNKN1FJS29L?=
 =?utf-8?B?VVQvek5QTTh3K3QxZmhLWWdQNWJmYU5xOGlnMHFKUmxMV2JVZ1NteGNwdWZJ?=
 =?utf-8?B?Q05UZCtONVFNVFlFZEhqYmlvemVxWDUxVVpQWEVXYUc0MDRiU3ZGa1FIeU41?=
 =?utf-8?B?RmIza051M2F5UlNXVnNRaStLZEg1KzNRMEt5ZVdUZ3ozbnRaaUExN1ZqcFU1?=
 =?utf-8?B?WGNuWFZNVWZqT3ZKUEI0bklPYTBKR2l0ZndGUnZDSDFTRHNTa3B0M2U3WVBq?=
 =?utf-8?B?dkhLQ1VvdlRLUVNLNGMwaDQ3a2VaVVRRd1lyUXV5dTdTSVhKdWF2Tm4rR3dG?=
 =?utf-8?B?eTdTM1JXS28wUXZvVVdSb3hDUVR5T2hsTmlpL0tZLzJvRlYvQXd4QktDYTFH?=
 =?utf-8?B?aldqU0JPUUlEZUVuOTNzV0tsKzZlSFIwaUd6VnN2TWVaRHlmZXBIY2phVXpW?=
 =?utf-8?B?aXp5b2RHZjQzUlcxZDZpTDE0bjBxTWNXbXorQ0xUYSs2Z0tYTDlKUWJFdFN0?=
 =?utf-8?B?UWlBQW1HQWJvMTA0SXNDMk9yTEZ2Y3FOVlNNdkRjVVNEaXJ0U1hxTS9MOVlN?=
 =?utf-8?B?TUFwbG82Y012UnNETSt0bDN6c2krTHhPRjdiMXh1YVVYWTZSZnhzK0I2VFlv?=
 =?utf-8?B?OFRPNk1idWgzc0hyeDREUXNTQTN5dlVLRmdFSkt5REFsMXRnY085K0pNRm9H?=
 =?utf-8?B?bkNzc2d2aG1XUGlQOWYzU1h5R3VpbFVJM1Z4V0lndHljekV2enRzUG5rcWdC?=
 =?utf-8?B?dUlUTXl6WnhTd2Uydk1iKzZYK1pRdUxmS2lMYmxrYk0yR1d4VUR2SXpweEJY?=
 =?utf-8?B?RVlyTlgyS1VXczFUbzFPOEhaS0NsWHU2NnlWeW5sbnB5TDN4ZERKMG92MitW?=
 =?utf-8?B?SnFYL1YreGo1eGZVZWNpSTBQc25uMFBKY1BlUXFHYjhQSUQ4MmpDWkxNVk1k?=
 =?utf-8?B?dWNvaUdmaVNEMS8vaFRvYzZ1OWxVTkpaOFc5MHlSNzlFcnNTSEhOVkxaODdh?=
 =?utf-8?B?R0JSeDE5U0NTZC9hTGM3dEpoTzY0VkxjSEtaYjJrc09DM0E5U0pPdXI5QkZD?=
 =?utf-8?B?a1R2Vi9wQ2lmVDQ0YU1QNVpUZzE5WG1ZT0NCNDBmRjFEYXBhSkQvQVJpV2xH?=
 =?utf-8?B?Vy82Sm1FRU9pWkRuYVJCVUE0cnR6MlFneEFBQzJsU29XN2Rqd1dRUUtBcEFU?=
 =?utf-8?B?VUczUnB4bnhSZWM0VXY3YTJiUGg1VkJTdmQ0MjBoRHFMV2kydzZzQ2wrRlg1?=
 =?utf-8?B?RkNDOXQrdklsUjQ5Yi9mc1dnTm5WanVxd0Z6dGMvSzE2MTdWKzRKSkRseit6?=
 =?utf-8?Q?pdwbO5gDIDtTsGbSX5jWfV6aW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f89f3c3-c350-4548-794b-08dc4a5d38dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 10:45:43.0600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3X4x7MyNxw3Eqj0ittyAg5fpc0ee9sr+HlBS0EMitsidPSav/KWQnt/Te7ykZ1+Nu8XEez9SYMc75aB2l8KwGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656

On 22/03/24 12:33, Vijendar Mukunda wrote:
> The CONFIG_SOUNDWIRE_AMD is a user-visible option, it should be never
> selected by another driver.
> So replace the extra complexity with a normal Kconfig dependency in
> SND_SOC_AMD_SOUNDWIRE.
Please ignore this patch, as the commit title has not been posted
completely.
>
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/Kconfig | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
> index fa74635cee08..3508f5a96b75 100644
> --- a/sound/soc/amd/Kconfig
> +++ b/sound/soc/amd/Kconfig
> @@ -134,15 +134,14 @@ config SND_SOC_AMD_RPL_ACP6x
>  
>  config SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE
>  	tristate
> -	select SOUNDWIRE_AMD if SND_SOC_AMD_SOUNDWIRE != n
>  	select SND_AMD_SOUNDWIRE_ACPI if ACPI
>  
>  config SND_SOC_AMD_SOUNDWIRE
>  	tristate "Support for SoundWire based AMD platforms"
>  	default SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE
>  	depends on SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE
> -	depends on ACPI && SOUNDWIRE
> -	depends on !(SOUNDWIRE=m && SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE=y)
> +	depends on ACPI
> +	depends on SOUNDWIRE_AMD
>  	help
>  	  This adds support for SoundWire for AMD platforms.
>  	  Say Y if you want to enable SoundWire links with SOF.


