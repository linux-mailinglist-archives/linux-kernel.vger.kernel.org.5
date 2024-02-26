Return-Path: <linux-kernel+bounces-80593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AA5866A17
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA98AB2135C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3878179B2;
	Mon, 26 Feb 2024 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ctOgAJLi"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5087E14B820;
	Mon, 26 Feb 2024 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708929177; cv=fail; b=rsnONcUq+I/KNvsxmNg2TM4qMPnO+5lhvvMbzX1mUcSvBRKDj/q1L8EG2ZOGz02qX5FTM1yoDRYC2lYKlaruKljL1y0M+tgv6gGxmgzf5uiaV3mEeEeYPwEOHTfwNcrlkmAstLU4y7FGgPoO64DBEtG46pxkd1FjOaOU7worSN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708929177; c=relaxed/simple;
	bh=m9fas99cnCSfv5+0VNBrg1AUm9XoooakiORFCuXhPgY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q64fFt2sLVgKSxjOBB81feFlSCphAEBkTx32ktedcifxQMteOo/4E+e1KM84kK4th1kNvFEIRZh75kqscb1uJsxXq+xmGGQv592GrKITzghe+lRqFyOiXuXXsrvdVZJ4N/ev4LBg7uhDDcvrwnEy6+cHFJHaIbGyYuB6KgaVtIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ctOgAJLi; arc=fail smtp.client-ip=40.107.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAK1Ix24P1Hs74JIyWIFnl3D3X0MHUIPJ2YkRqVPKBgJl8RUq4HglTgEmFcmwBbiAGZX6HfUwC7Kx6ePHx2JOXI/pHT07ZPRwALLzGHwxEOjVYe7A9gJU9aoKY7HaNp/vhDlkZ6snDZQNRt6z8Al8E/N3GOs4h0ppvMgqxEjhdV6iHjZXtvdMVftWMJiiphWJ3jNAlg91vNwl8c7jtHxHPkfWTI96hq5zC9Hm59frOUDZ+Q3XNQcxUph315nht2AI9HD6nJ+y0/dIWIRPmmy/7gxM4vCEDFB2jq3J9K/ksE9CrHierrAkarf1iQ+SZ7q7LnqBwwO8m7ranfFEIbSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eo6FOkZM5s8DZN/vy0o0btMiR3QiJTrWwngr+xWBQgs=;
 b=C/MIFGEFVgTUILD3acRzXiAvRG93TXjJ3SHe4Ua8wBye+5Dg5VX2zr8ZKNUDMFpJrZrkXI3vc05sGyAV4XbLyqI7tpgAMiqHhQ2oc7AxlI5oXP57lFlSMDaGvplB/MOufrLyONCRPgGPGMOoie/Wilt6BUCKagixdKU1cTQeVun8S8uPfXCmavF9nGPO4neyfXXWC3n0jm50Ki5h4rlGTpoDkTGcmLrJ1uEKMz388KWsas2XmjxECFeeulG1GYzAPGFJuZ3313bbLZvTNyWC9k0uQDRS/bP1Eh5hFLFGk/SztZ60XObRp0GPJRzCRRoMtfG5avL85ASS0Ir9ik2s8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eo6FOkZM5s8DZN/vy0o0btMiR3QiJTrWwngr+xWBQgs=;
 b=ctOgAJLiJtRAU0Gfh6vOfzcoJhZN07+Tgbkiojc6IZvdSLJa6hqZz+NTsorof51DxH3wQYEBFR0vIfh2PUbr1XfgI0GGngq+KtrIxZqVeIscz/+KYZRNx5CC1TU3jxdZ74uXdt+wbcLv70i+W8f49xbeBZy5zKSJjvRDDV7ZQp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by SA1PR12MB6872.namprd12.prod.outlook.com (2603:10b6:806:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 06:32:52 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3%3]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 06:32:52 +0000
Message-ID: <06d494bc-e649-4ff1-9c05-967d1f5c0727@amd.com>
Date: Mon, 26 Feb 2024 12:02:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: amd: simplify soundwire dependencies for legacy
 stack
To: Mark Brown <broonie@kernel.org>
Cc: Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 Mario.Limonciello@amd.com, arnd@arndb.de, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Lucas Tanure <lucas.tanure@collabora.com>,
 Syed Saba Kareem <Syed.SabaKareem@amd.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Venkata prasad Potturu <venkataprasad.potturu@amd.com>
References: <20240226062853.2100457-1-Vijendar.Mukunda@amd.com>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20240226062853.2100457-1-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::20) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|SA1PR12MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 030db1db-acd6-4892-9655-08dc3694c22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hrs7+7GdYlwkIlpIMqkXNRTgEBDkTdSQnsVlC71+aEohWmBdzhKNuwYXXP3TB816UuEqRXJPk8xB2sNndNo6Ig+5idfPXoROoTK8jQwa2DWon+Co405xQhF5bmT19+wqY4232AYoSm//lIJxOPWkEFS1Koz0Rd7hytxMhiDHhBmepHjSfcYBgWacVCNzEWioYNWwwDxyg6EOicaXpKXwy+fzG4bD3BgR8jkyKZH3qq7cNnXhFfuOhc7NIconcblCyrRTg0RBa4pywf/YLHgncM/scb8l6OuCETuYz9pY0sW0+FlQLCyS8BQD9YrtdLkY46LxMCJytYcU8eNpXbOP/OGhFMobfgGQGzbzmd9yacfQGQ9GCcpTuPivrxQhVPEgv1krva5sgnJtSl9NNKw5I/cOp0IRumzWfYrZQ7a+n1nLlAfN7/w5DWUc7z80pKNnbt/vtvfRkLQlXlB16T8oOa/P1u+absc6n6og04vu4OD8jUSB4SaHWAxmMjz0q+8NwEOmHCiiySwUr6Rw+SwCj2KUCYcBzHlYDBYh1hH2zhpec2g7KDMeeSynQMCuEXQPYaw3YxzS9cvWZP84/M6GInxAZ1DdZa1e1q6ATVEJXDYQ4+88Uli6dGQalQP9HlWwKb6ngdmnwtfbsO090Iraww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnAzUlg0N1B2dTkvbGtQMWFScFA4VlBGUWdtQ2U1dERLRHV4VnV5UFBvZlNL?=
 =?utf-8?B?WDNadm9EczdkZ0dNRWcra3pCRzNqSVVuK0E3SWZtWGRzL2kvWERGakF4Q1NW?=
 =?utf-8?B?aEtYb0hvRDZLWnYyUmpNdU9RdzNEYlJtSm5pYlVsSnBpTmJkZ1R0STBLZ3JB?=
 =?utf-8?B?OWp1a1J2ZGhMOGtCbGZmWkNmWkhaVXNYVGlLSEVoTEh6Qm5DQTg1dWpzakZw?=
 =?utf-8?B?aHJvY2N4ZjZKSXloMTFvWWZxT1dOU0tIVG11b3daQm9ieTlJQVZsUEVlMnA4?=
 =?utf-8?B?d2llQVlsU0xmNUhGNnY3WEtuVkpyUDAxY1FmWGczK0dLczg4Y1g1ei9HSjhy?=
 =?utf-8?B?c05OSjd6U1h6aWQ5enRHeGFJRVZtN3g0dUFrSVRHemtpVml4RTJrVW0vdGFa?=
 =?utf-8?B?SmFXSFE4b2R5b0ZmYnhRT05MRWhXSG9kRWR4c2FSWnR1TEtYbDJaaUNvNk5i?=
 =?utf-8?B?Z0I5SjB6aGRUU3dVeEljbHEwWWQzL2pvMGw1bVBwMURrOTJFV2JRVHFQYlFJ?=
 =?utf-8?B?NU1HcGphM3E2cHJ2Nnoxa09rZFpCRjJXV2FsbENLVngrSFgyZGcxenpBeDJm?=
 =?utf-8?B?enZiTHlXSTVqdy9wSW8vclowbmxWVzZMbkVXS0lRMVpGRUp0TUFkc3BkdHph?=
 =?utf-8?B?TEhyTjdYNlZ6aGhidWVxTHZSeHlkRFhxR2RxajcwbjByRzQ2VXFhV1FqOGpn?=
 =?utf-8?B?Mk9FQndTSnhWYVJHVUlOU3pweFk3UkhHTDg0REkxY1BsM3FMTTZrSWNpVDIy?=
 =?utf-8?B?MUQ4dWhLWkxXV2h2Qjh6Qzl6L3U4QlIwYk8vSDhYdU53eUVGWm1oUU5XK1lE?=
 =?utf-8?B?c01FSzM1bEcxcm5uNHFoV3VaSExUZ3VsK2RJQWQzeldKZEF4NkVUeDVVUnYv?=
 =?utf-8?B?VkVMTVM2OVl4aW5xcnUyNGlCTkVXYVdrRWI2NzZRcEliUWx3Qk5sQWYxNTFC?=
 =?utf-8?B?VWQ1SFBxSUJJZ3NoTFIvL3JYUlNHVTRTMENWaWovejZtbkh4MWlCMHpnTmlO?=
 =?utf-8?B?WEdIWEp5ZG9HZ3V6STg4SDN3Qkd5c2NZMlU0UnY2WHB2eG1kSGtEdVJKKzNa?=
 =?utf-8?B?a1JDd1RtR1dEL3Rkb2VNNU9aaFJTU3BTRjhzL2RHRFl6cGFGUEo0YW90eGVN?=
 =?utf-8?B?Nlc4ZlVQYTRWN0VvMmFnV3lvdnlLZ3dUTUh0UENwRUwvQi9FdEExaVZQL3RK?=
 =?utf-8?B?dzhaSTRDRmI1T3Y5emhZTjE1QUYyUE9NcmtxYldwV2RWREJ2OStNTFVFRUNC?=
 =?utf-8?B?bzAzN0o2RHZqc3ljUmE3UjRUMDYwZzRJZXRQM1F3T1FGRFh3eTRaSnBXeENN?=
 =?utf-8?B?Sm05bmdTa3VxTU42WjVVSGd1NEE0Ylg4NU51S3RTTGw4ZWI0ZHp0UGh2QWNi?=
 =?utf-8?B?ZTd0OGNld0hMYVcrbCtYVWdpQUpnMThGZzhxVmNGZmNka0NKQzVvZlJ4TDhh?=
 =?utf-8?B?WXFHZy83QStMbXB1dGM3bXMrZFEySy93aWU0RzBRTDJQRlFaUEJhUStjRWtZ?=
 =?utf-8?B?a1FVckhtYnRQZ3NGc1pocEdpemNzeHVMaW1hODR5UER1ckNvT1ppVmRLa05W?=
 =?utf-8?B?Rm1ISEhteFZkdzFuTGNVSW5OOXQ1TUxKQUFMUERCMk9CajlidkZENmhxQ3o5?=
 =?utf-8?B?ZlV0TGFEdmR6TWRjaGdvTVR1MExabnQ5TStZU3VCQWwydW44czZiYVNkLytl?=
 =?utf-8?B?VUFYdTRqQzhUZzV6QkVrSkdHZXZSUzlGUk4xc0w0SHEvQkl4L1R3SVk2L1NL?=
 =?utf-8?B?cjBBQklDT2dzYUM1OVRuaFlxV3FlSnJMYVlnVVh5V0htL2hBYThQQ1dtdHFk?=
 =?utf-8?B?d09JQU0wVmZUQkdLN2N6UE9vc0ZpWVpxeDdlSUtZSFU3YWpNeGNlMXZ5QkF4?=
 =?utf-8?B?RjhNSzdUbTVIL0kvM3duZFJRR1NhS1ExVnFiei9ieVZ4cFlJVmxrVkxVN0o3?=
 =?utf-8?B?M2ZjWTJVcW0rcWZxd3ZkN1dadTdZaXlCNGkzVEFHaGhGcHRhSDhVSVRabW5E?=
 =?utf-8?B?Z2hiRUFsc09RTXNkQUN5WjYwM2U0WVl2T2VHQitIMmdrTS9VdzBub29JNVQx?=
 =?utf-8?B?TDlKaWFJSUdXZlRHQ0w0ZkxvSVdpbCtSYmV4MUp6Y0toUnNjcTVYM2YybXRo?=
 =?utf-8?Q?8WcRxTvJ4+g3a6biaw0vtuef6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030db1db-acd6-4892-9655-08dc3694c22b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 06:32:52.5769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpDu8YhJgg6hK5PJRb+pjrA5YVIXkOpZMjOE/Q7qfg/WSa/EB2lMwW1Zh8ghOwVLFaXXFNcujczBQ8IaeX+Log==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6872

On 26/02/24 11:58, Vijendar Mukunda wrote:
> The CONFIG_SOUNDWIRE_AMD is a user-visible option, it should be never
> selected by another driver.
> So replace the extra complexity with a normal Kconfig dependency in
> SND_SOC_AMD_SOUNDWIRE.
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


