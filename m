Return-Path: <linux-kernel+bounces-72371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72C985B285
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072201C215E1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9362257337;
	Tue, 20 Feb 2024 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OwwJKwhj"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B120558AA1;
	Tue, 20 Feb 2024 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708408667; cv=fail; b=pmB67Us71G7MX+0eE8W+B3NTZdRWrhVoXqCnRgJTuUyXf1G6iCfrgm+fXyZWMy/g9jxXveKr9R7OdhbHv2zSZy0Rxo1uueJGViFD/W0nR7v9fVJ6PDcNEshcazTHUttR/qnhH0efS6vIdpAr/qZgHQVFj48124+LNuQ1jyPsQgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708408667; c=relaxed/simple;
	bh=A9YrH7UEH7TMAX6zCppcXIUVV/3uzKemVqS6oWFAhGk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E+B9mQsJYhKy/Oc5y45jWLkramPu1PShaQC+lCF6kBwo5rqmqLldpurWkYPxH9KzfosvJiNCun9gg37bmUPm0WXPX9CWxn8RnkY4l538P1W6ulDEA4CQ275q5hm+H3uTLtDmn+2lUqn/eaKbFOnZJX+mZCBtOAZeA8bjxBwGSZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OwwJKwhj; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F91pXiA08bTDC9oIeH50knkTNA/yPSSjGqcWXXJttRDbdL5ZDjPCeYSiw6KyY0W0GswfXJKRFLRYZVclaVcT3bAGY4GVRKynh12gRU3QXKxqR/WXnKsBIrjwdbRcnp21rkPB39jgDkt/bJvhJKgHKQdAptCW4S9Iy+wlbr/yt5J56Jsy6KpZB/qMlO5p7dNiVK//q+6nkB0ZIEAy6w6TRhL/GeYZbylOVbDwc2ooFreIfuqc4lqHf0tk5Cg7RuWKHTZWuTClLgRytbW8/HIRXwWOa70ry/nFBPxsW94P5/CrNqom+J3Xl+zkHOOC3avfwFH0OnCvivFpjmt20U6oAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jFzjfg1YMEWSieFPMaDbQCdD/1kz7jvAzkjqQiIIkY=;
 b=S04HXG5ijR7xs4CayP3s8Q0/OPXxF6g2DzivCXqkHEXRWJBdMPs6LR/HmUZAIZgUPPpLoesROYVuVISmaTmWATWeurdLyU5dOPFidsbDF/qZrrE8OmA2yZOAa6WdA8Z8+9koMcRPS2Hv1j2M58wyewwCFVo+sEec2eZGEDJzo0v3hKZfcQT/i5s6M1ZfJ6OCIhcugDIOWVpyolxnOAYwOKSD3rMtk5KOhHgWzhACLaXC7qPbmHIusTkn1J1d5IKQqhp2CDSnB5fe4gXguHcRwtPHH79oo+o4pLMrhOBYOsOhS1h7g382kgKZ93mZoXgtj2eigtfXpVNgcLE1oHWYuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jFzjfg1YMEWSieFPMaDbQCdD/1kz7jvAzkjqQiIIkY=;
 b=OwwJKwhj1bDuXlFkALyf+dKC+NRRTRiRF6K2AtECpooGEjD5aAuP/eE5s4Xd5mOy0f/O3HiQUie0dkZiKW2LQ1xOsB1Nkkl2kDABD2tNULTKNpZZE3Tz5kob2qiSxO5JAor8LoXRRDGakO5L5uLwpOPjwzSeDI8kcGp1X5yzTGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 05:57:41 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3%3]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 05:57:41 +0000
Message-ID: <465d1076-163c-4933-a9b5-e4e8736f5748@amd.com>
Date: Tue, 20 Feb 2024 11:27:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: amd: fix soundwire dependencies
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kai Vehmanen
 <kai.vehmanen@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240219093900.644574-1-arnd@kernel.org>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20240219093900.644574-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::32) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: e9578477-6c2a-48a4-ed16-08dc31d8d990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e4oo9+TNkgVgFw3gd6lV/bEXUV/4LWFI6x8WjVFC5HI1b5KgCY3PACwdCSqX1ZPfHYogSc5ghyuIzGC6g8IhOlfopQMh6OPa1kGgnaKCRFJPCzuocA8ohqw9wfE2pU47pi2YIsHL3/WvxhsDInmNeObDRFWEsCVFQbhtySvYnTllDHfsut7oxUxHUjrBmMEw1cyGhXE3bOczDWFc+tH1ieGd1gNtvEN9bsVmMH/y3SwzjlZLTk/B8nmFhMEgEZoQAY2spcHLz0hjBewL8t5jP4JZ0lPIZF0AvbmR5gPufzlVXX1PJi6GgtMg1cIxO+r4OZtphfhv6s1+KFUmvl/f494MgPbx0dqaxn63uRF5rMS59R8USVMIjJFmsPJ0djFfoVJM16hsbUte2HZdKGJhlGlmHJXjL2B5/1WGPhqWF2Xr4hDjLZJr5PQCESp3UG7vsEN8pDmylSZqXoMFiG+FSeNGEZvFbvV8h3oMgSLnR1lAWAx00uKeJym6nNPh6ej58Atn9GAy/sVKBzpJk8F+aNb62tRI4T+dAIj974FU3LY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjV3SjlkZnQzcUJGUWU2YjZjYUM0SnN3M09VZmdOaDBUQ2RFVDEwM0xOVks0?=
 =?utf-8?B?QVptR05iUTRud1hpMTZEQmN6ZEZUdC9TUTNnRnVXN0cyUXBLWm84RXlVbGY2?=
 =?utf-8?B?b1YrZ0plVmFHcWt3YjM1Q2srQ3dEWnkvd3prNkpRemgrZGYxaUd5ZGFWSTYx?=
 =?utf-8?B?OG9jdWlSNnkvbzJqYnpCUXhVR1JsNnV2S2s4MlN6MzBWbWpTSzkrd1hkcGg4?=
 =?utf-8?B?NVpEdW43aThFWlRPSEhlRUNsREpJYUdjMGFoQ1VZQ0xWeXZJS280cGtOQnVl?=
 =?utf-8?B?ZHBwcGk2TEw1SHE4Rm1iaU1Qdk1CYWY4UGI3d3BXNEpiZEdncGIxYVo1VHBU?=
 =?utf-8?B?TkdIUlllMmpxVHZFNmJldkkzUm5WanpiUFBMMi9RVy9FYW40RTR4cHFzb1RU?=
 =?utf-8?B?SGNqSDMrWGtTQWVCSHpTY1M5ak8vMGdmTGU5M1N2YjMxWk5tbnZxR1JGaisz?=
 =?utf-8?B?Z2hna3RYZGNhY1pGbG84SVJ6VkJSYy9GaHhNRUtBUXdRaHhYOHRPRGNlU1NM?=
 =?utf-8?B?OHRJMXdUVFlrL1p1ZVV4VFMxR2ZxRTBFbk9wZUVwMHZhZXdnd0lLZkgxTUYr?=
 =?utf-8?B?b1ozaXZEL1VEQkxiaDJ2MW9xUTV4a0NWdGRRbmJFZ3dMa0pMdWpPN085M3g1?=
 =?utf-8?B?WUJFY21helBLaGQ4ZEFDb0RwUVI4R2FKbk9jVUZ4b0NUS1U3dk1ROTZGSm9K?=
 =?utf-8?B?ak9BQmVwZDZXNFZaYmpUOHgvZlhXdnc0QzdOYnhrOGJGV1VpbTNTYjluZ05H?=
 =?utf-8?B?U1lGMjNOZXFqRE9ORldyRGFHQUcxYnNoMXVydUZpMzgwbWdjVy9XN2NQNzI2?=
 =?utf-8?B?K0MzeEdFb25MVU5TVFI4TDQybHNUOXJ1cm5NTnJZWUhzUnhJZmdmR2V3ajk2?=
 =?utf-8?B?c2ZOTTlscW5tNmlPMDVCZ0t1N3NnSGlXTzlnNTM1WW9SWUx6YUl1VXZCL2F6?=
 =?utf-8?B?RFNqcVo5czZDMUZkRTYzY3pibmxDQ0thdnJWVXBTK3pEN2dIUWxiT0hZUCsy?=
 =?utf-8?B?U0lqWFFwc293WXRGcE9nNFNOWldpU2FUQUpRZkhJNHprR2FJVWh1M2ZXVGJo?=
 =?utf-8?B?YTdXbDBVNmQ3aTdoMExjSnlsbnVnbkkwVHZZQTU1ODltSndHY1ZDYzNuRFJE?=
 =?utf-8?B?NkM0cnVEY1lBNk9lUFlSRjg2ZWZQWFJERHpDN0VBd0czalpEYUYzcTJsSlJl?=
 =?utf-8?B?UEs2UDJCZ29mUEpNWWgrbFZlMGg4cXdMdG82S2djUTVBNDFnd1RrUnV3QWJm?=
 =?utf-8?B?MGYvek9mOENmMGZiV1lDeVpMeDY4STRiYkZoNHM0WkJrSXJSdnVrQUk1ZVMw?=
 =?utf-8?B?YWhSVFVQeHdEczhJeHlGMlZBYlBVN0tYajZNL1N1Tld0K0ZXSHlGSU9Wb2lh?=
 =?utf-8?B?Z1ZDZFRrWW0renQ5ekY2Ym5pak1rNGR1WENvNmoyenpuQVRxRVp6ODRUdFNV?=
 =?utf-8?B?bmRaakRsTEQ5RVFGcUZsanlGQ1FBdXlFdkl4ajg0Vll0aEtWTGtNZmJHT3V4?=
 =?utf-8?B?QkdERTg1R2NETGkwZTR1T002eW00YUFKVm9wVmYxQklBdlVUdnJxNDJPd2VQ?=
 =?utf-8?B?RnVxV0lXMWR3SnZHSlpDQ2VkcHZVNnZnRzdHeDhaYThIaU5Xekkrc0tjUXZx?=
 =?utf-8?B?VWxZQVl0R2NJQjlOVGJqdzFxZTVnam81cFZyNXBHUk1Ld096Q2dGMndjY2hl?=
 =?utf-8?B?dEw5amVDS1Y5OG52YXFabE9PSzEvaDZwZnFCbER0YXUvbytheGxRZmVCaU9z?=
 =?utf-8?B?aGZwNlQ5Yi9hdTFma3U4TGdPQXFhUjZKWjUyUVBMT2VHYmpmazl1ZnN6SGJm?=
 =?utf-8?B?SWVzUys3SFR6Kzh6dzNYa1IwdlJZZURLaUk0aFNLR1ZpQzV5SkxjaHFMbnlQ?=
 =?utf-8?B?MHpWdWV5Q3p5S0NFYzhrNXkwN2grYzAzQ2kvakJiVXRXOENqRG9TUFhjWExC?=
 =?utf-8?B?bXlSNXQ1d24zN2xnK04wUnd0ejIrSXAvZWczM04wb0Q2NElCTTB4a21sU0hk?=
 =?utf-8?B?OHdEYTBMWFZ3VVJ0b0tCSGp2WG5xYmYxWXVZTWhkUDZIM29RNEVMWFlUMGZV?=
 =?utf-8?B?MnRyUlFISUNsTTJUZUx1ZmdBRTJNSHY2RTN4UjBCVEh5bldqRXh0S3RQRmYx?=
 =?utf-8?Q?1YI2WAoPmi1uLlUnu8x3bnDSp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9578477-6c2a-48a4-ed16-08dc31d8d990
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 05:57:41.6066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lro8EO66BZVHxEZ9ujGc+Dt2p290s5dzdhaQQpc8V2Ud+/+uUJ5AuEFhuclx+H9lKG8Nq4KmiOJZanMI0BkszQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874

On 19/02/24 15:08, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The soundwire-amd driver has a bit of a layering violation requiring
> the SOF driver to directly call into its exported symbols rather than
> through an abstraction.
>
> The SND_SOC_SOF_AMD_SOUNDWIRE Kconfig symbol tries to deal with the
> dependency by selecting SOUNDWIRE_AMD in a complicated set of conditions,
> but gets it wrong for a configuration involving SND_SOC_SOF_AMD_COMMON=y,
> SND_SOC_SOF_AMD_ACP63=m, and SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE=m
> SOUNDWIRE_AMD=m, which results in a link failure:
>
> ld.lld: error: undefined symbol: sdw_amd_get_slave_info
>>>> referenced by acp-common.c
> ld.lld: error: undefined symbol: amd_sdw_scan_controller
> ld.lld: error: undefined symbol: sdw_amd_probe
> ld.lld: error: undefined symbol: sdw_amd_exit
>>>> referenced by acp.c
>>>>               sound/soc/sof/amd/acp.o:(amd_sof_acp_remove) in archive vmlinux.a
> In essence, the SND_SOC_SOF_AMD_COMMON option cannot be built-in when
> trying to link against a modular SOUNDWIRE_AMD driver.
>
> Since CONFIG_SOUNDWIRE_AMD is a user-visible option, it really should
> never be selected by another driver in the first place, so replace the
> extra complexity with a normal Kconfig dependency in SND_SOC_SOF_AMD_SOUNDWIRE,
> plus a top-level check that forbids any of the AMD SOF drivers from being
> built-in with CONFIG_SOUNDWIRE_AMD=m.
>
> In normal configs, they should all either be built-in or all loadable
> modules anyway, so this simplification does not limit any real usecases.

Tested this patch. SOUNWIRE_AMD flag is not selected by default causing
AMD SOF driver for ACP 6.3 platform is build without enabling SoundWire.
>
> Fixes: d948218424bf ("ASoC: SOF: amd: add code for invoking soundwire manager helper functions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/sof/amd/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/sof/amd/Kconfig b/sound/soc/sof/amd/Kconfig
> index c3bbe6c70fb2..2729c6eb3feb 100644
> --- a/sound/soc/sof/amd/Kconfig
> +++ b/sound/soc/sof/amd/Kconfig
> @@ -6,6 +6,7 @@
>  
>  config SND_SOC_SOF_AMD_TOPLEVEL
>  	tristate "SOF support for AMD audio DSPs"
> +	depends on SOUNDWIRE_AMD || !SOUNDWIRE_AMD
>  	depends on X86 || COMPILE_TEST
>  	help
>  	  This adds support for Sound Open Firmware for AMD platforms.
> @@ -62,15 +63,14 @@ config SND_SOC_SOF_ACP_PROBES
>  
>  config SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE
>  	tristate
> -	select SOUNDWIRE_AMD if SND_SOC_SOF_AMD_SOUNDWIRE != n
>  	select SND_AMD_SOUNDWIRE_ACPI if ACPI
>  
>  config SND_SOC_SOF_AMD_SOUNDWIRE
>  	tristate "SOF support for SoundWire based AMD platforms"
>  	default SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE
>  	depends on SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE
> -	depends on ACPI && SOUNDWIRE
> -	depends on !(SOUNDWIRE=m && SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE=y)
> +	depends on ACPI
> +	depends on SOUNDWIRE_AMD
>  	help
>  	  This adds support for SoundWire with Sound Open Firmware
>  	  for AMD platforms.


