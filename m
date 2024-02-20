Return-Path: <linux-kernel+bounces-72808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE1B85B8DC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37081C22598
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6D3626D6;
	Tue, 20 Feb 2024 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RWpNISvk"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71D46166D;
	Tue, 20 Feb 2024 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424388; cv=fail; b=daavzgpLyXHeJYEtjDjJrpLB1DXHQpnmz2/JonSxuBVXdJfio+EFUTPqCIzxHUcXasHMJw9GrVEl2imnPkWo102L1CeDoeOQ0mUDv2jt9TWTJiwIiEcJX8mbJ85YTk+95tki5sMiaXOOaHVV6N9tb4mh+16Po8FwD9GtjoCxGJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424388; c=relaxed/simple;
	bh=la0MtCk43h3lWF54K5OeUoTopsOkigIvD0gvqEhOWg4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ubyv4N+NdQLye3JDQxFxTgBQQzeO2FsFoiorOSVMS91JFTZcfyysCPa3iLxo2BA4gqtM4hDOlgdU17gyjk1T/5H9VB4SlSoXJ9RsRF7mUaHZZBnYMy3DRMNedVZp1aBn+R1puwoZqcv+M7ifKENM4tXntmUCz9GciiVX6Pn6ucE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RWpNISvk; arc=fail smtp.client-ip=40.107.96.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9V/FpTp/PGyjF26HhoXZun8LqjdVSpcqxpNns4aB6+Xy9TepISR8OiJlNzsiPlKMusobb8QSAbMY0ImjpOwuGQvSyF1dzRgAnn04HtbGNqbsUnxo4mT+O5OIQvSAd4pv3o1GhqJzXyviA63cPOiZ1HAV0X9HU/GhGm6vDKiKdaRMwvA2jl/d11uvIQ8u4LooGkaeyJmjQwABhaWqnvHTjLCGDDwIHZnE3dVhJ+/bWxNfLMB1FT6f+1IGSN8JCbGsnG9+HXLJNk/sU1/RakUZULstjTloqZx4y5Smz9ZjyVnbYaP4XFiPU7rkRxDoXu/QnE3eU26Tp7tNLO1T8Zlgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxID5K3islKrNyrclb+aOQdPGgqOckVkdUA+ABrcHcM=;
 b=E8nBxPD7QS21+bRYB1fy2ftAxwLKmA2Wfn9OYpmyLZfIDdrAVp5ERMbU2ybtXjn9NZdoYGZ2IXBt5CUs0v4+v2ApMBYtUQvizIxwkDcTNSMYj8ADUqZ+om5Ac7BH+4+vZ6aTBu8edM5PhXp+4mvJs4p1CS6sZclH8cJh0+CXYvi58SdpQjVSeJJw7rOqhPUz1/PpSEtxDOXA0W2RW7PQmEpE17ylIxcXo5csGDD29DfvJdg4l8E+6FUCz9g1JNArueVzhYRgYQHZmDQbFN4+5pl/kvMUD5GQWG5GFmxsu3GjjSyWApgNOibHpO/whGvazVCOqbYg1sBZPlF/Zd1VaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxID5K3islKrNyrclb+aOQdPGgqOckVkdUA+ABrcHcM=;
 b=RWpNISvkZiX8m79t2ChLtE4AUULN6zPVE6GzOSS6dIhHjuF14oJ4MLd35blRPQbHYiYeQiEwtfWYGQ8zAi414JzUJT+BwZjsGEvXE6GDGX4contE5kULu2RQEDte4O4AhImzJlLT2xCYSv3+1et6GdtTJYPHZX4Z742FAm42QKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CO6PR12MB5428.namprd12.prod.outlook.com (2603:10b6:5:35c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 10:19:43 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3%3]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 10:19:43 +0000
Message-ID: <e16dc980-fd69-4b5b-9c68-6107dd2f3145@amd.com>
Date: Tue, 20 Feb 2024 15:49:32 +0530
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
X-ClientProxiedBy: PN0PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::19) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CO6PR12MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: 1487af41-41b9-4c83-8ccd-08dc31fd7444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xlWQo0r5BXSgxf2iAxuLfHkXDvhuEM4c39uH6GRjOTeXHRwiwYCwHEiQZhU22cOjrVUbr3k6KAA1e7BfAEMrMsr4iK3qo2A0H97QPcyiQbO1/CWbZyIeSonvhyvHEGBpTG4jFybRKvZ3QrDy9C19WHRPwWCOsH02VfyoOk6QMGUi7z9ZUhyGQDP3wIRMJ09HYvLMUjCXJeLGFZ3jN96iw/X+4WpYdJK3aGuqmkGFo78i5V+Eq/rlTvQLe382amVGiGLr6V7Taxw0m4yaB8nktu3tEl7hL9m6rwfTLGLPIWAqDMF2ifzyrG1p9mEfMVFP8OtKE7emL/mX8hTEuVzcFqoAMB13lYgLhHMd3rbIIlQ0LRyIBTfFgm4VeVPyLVd0swXQw/Yd/4ee2Kja8Gb0BPAO52y5L5ndsWMcvL9Xwgb2xZuCX9093I2KSW54of3oqD/uac/pbz3D50g9vKRlLgaHtB+qbCnBrKSdMof+pNw0HguOgBASXQrZPliUUTpqy2hGgDzQWauvXQR8XyQtbkKlwx0boXD7SNWzVRNuDJs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDN2VWZES3pycm9aVjFkYkpHMWJyNVlQc3JNb2E1ckU4SHdWUVoydHEzNnJV?=
 =?utf-8?B?UC9CRTd6aTY0VXYzN2NSQzZNZlRYeFZDSGFENDVNeW43ci9yTzg3eFIxZlcw?=
 =?utf-8?B?cUk1VlpPMGdZUWs3ZkxFM1ZJaDZYclFRbWp0TC9tZW9QaFhVaDlmV1VVL1lS?=
 =?utf-8?B?OU1UdG8wS1dOZGpmQ1dDRjhQNGo1eDc4eU9XTFAzZUI3K2ZzOWZpMzBSRDB4?=
 =?utf-8?B?c0JkQjRiTmZQOUxuWjJOM25vSytJWHhhN1lPcjNLVW96NUlxTE4zNkJycUVP?=
 =?utf-8?B?NTZucmVMaExqQjhPeDl0MERlMmk0VUNBcmdwOFpEV1lUZjVobVhCZVFDd29y?=
 =?utf-8?B?TVR0bkJDSGYyWWlydmJpbWNoczNxTXhLa01OUTkvS2FFb2RMVHpHS3hFQW8v?=
 =?utf-8?B?bVZEUENodEVCSHdtWDRmQkFzSUV2dGdBa1pRSGZRcXFTSzNza3ZPM2RaRzJn?=
 =?utf-8?B?d1NlTEFtM0dqdXV1dzRQZEpTWFYxc3o0ZjdOOE1rSzVlczNRY0x2eGF3cVE2?=
 =?utf-8?B?NnNYbkJiVytCcXFvNGxlSy9nMlhGUXAzZk4rYUFTbmxIWk9qZzdXYmhiMlFs?=
 =?utf-8?B?cDR3WTVlSjhHVjJ2amJUN2thRmFXMUF4K1NndmhLWlZxcmVmSDFhRkc4SG9p?=
 =?utf-8?B?ZUNVWXpZTkxOUmNtL25kbWR6NGkyMGJDdFVnOGlUaDUzUkovejJkTUZZc1NV?=
 =?utf-8?B?L2FkSG1RWGkzZGErL2l0aTBXbFhxbUx6ZURMYmd0Qlg2cmZHVDVSallFKzBM?=
 =?utf-8?B?ZVBwWjhZSEl4bDh3SXErbzV1RSsxZnQwOHBvcWIwYitESzE0eng3Q3NhbWdY?=
 =?utf-8?B?VTN4U2NPNFVsRXlkVVhYSmI1ZkZ2NWtTaGR2NFA5Y1ZrZjJFWitoRnlzZzUv?=
 =?utf-8?B?VU14L2twc1NaQ2ZacUw5Z2J6VGlGTDBiK0p2SXFxZTZmMWJoWUtXSHBnY2NK?=
 =?utf-8?B?WVZwQXpLRy84eEZSY1hvVFpwWWFpazgrQ3hIZ0c5OFB1ZG9kNjBWVGRoMW9j?=
 =?utf-8?B?V0V1Y29BSWxjbFAzemFRZFpuT0dPd0xvYzZyUUxDRHhkZ3hBbzhKUzNDUDVK?=
 =?utf-8?B?eWk4T1dmR0VqQWtCWHVpMjJSSysrLzhtLzdCQW1Ga2w5WC9FUDdLc1BWVXBL?=
 =?utf-8?B?RFNxM3RLNWFZNWhHS0d0SUxwRGNxTk52ZFh4M1hRTkZsWHBUaENlSGx4eU9y?=
 =?utf-8?B?WDhGWnZ0RlVuc2JZNFRyOThEV0pCOHAvRVZpcW1WSHA2TXVOdlZVdDhTSnNn?=
 =?utf-8?B?TlZWblBKM2dZa08raFBIOU10Tzk5Wk1rREMyRmF3VHJKSVhVZi8rQ1dMS1BV?=
 =?utf-8?B?eHNqd3Iydi91QXMvV0pwVkVOSFd4eDIzdFV2UDVFdzdWV1dETUg0WHdVbGVa?=
 =?utf-8?B?Sk5zVFhwMTgyOVdzL0Q0Q3BoR0FTRjFJTy9nSjNrQXJjUzYxZk1Ub0dHT1NF?=
 =?utf-8?B?dzNXUU5XNFVVTXNVS2dENGhDWnhnNi9vekRwU0NrQTQ3ejFnTFhZNXN2SU5Z?=
 =?utf-8?B?TjBtdit6QmR3UFZjS3hzOWhKcnhObUc4YWgycVAxS0Q1TnV1VXNqTC9EVFA4?=
 =?utf-8?B?aFo1VVVtcmRjbkZvcEpoZWxmbm1iNDQxQ2owZ0hBWk95by9nQStiYkl0QlFi?=
 =?utf-8?B?VGk0cDVYZittaWhtdXFWVndTOUdKUkNUdG1NTXQzaFVHR3ZobEM5M09pNVlO?=
 =?utf-8?B?cVkwODN2ajZVYlczUW1wSGV2Qmw1UzkxTE9EeXl0elBlT3Y2VDN6Y0JHOEVP?=
 =?utf-8?B?ZTZNcHNNQ3lZS2lSemY3cUpqVDRrRGZxN2lNQUVkT1FZU1JvMmdobmZZbGFz?=
 =?utf-8?B?VkozTm9iVGg2WE1wcEo0MzZqem94TXdacU9TVzFnRStHYnRUT3MxQlJUd25Y?=
 =?utf-8?B?TzJidXJkMEZzeFZLRjYyeC9FK0RucXNRTytBK20xMXhoSU9mMlZpWDhnZGdU?=
 =?utf-8?B?ZDN5dmtSTXJsbjlOK3huZFp0UUpGN0pWeUZtekNEUzZWVG5SenFBb2JFajY5?=
 =?utf-8?B?UlNzdlRXVks0UFMrV3gxKzE3R2w1NTNRTStwRWFHV2kyQWNsODg2V3B3am92?=
 =?utf-8?B?UWRrUGhXUXFsd0lHc0RNM1k2RlFaSlphc3hnL05YYitSTmlRVHpjR1Nhd2du?=
 =?utf-8?Q?uXwNOhIcBJRc0z6D4gmlRqonF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1487af41-41b9-4c83-8ccd-08dc31fd7444
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:19:43.0888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfYBXCrJsNqBVuow8DZ6FGuxb+ua54ytQLi2kVNnL7m2FuKPD/21vyGg6gPLu9LY9sfqDpjvB8wOoKEZ0+tZ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5428

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
Tested-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
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


