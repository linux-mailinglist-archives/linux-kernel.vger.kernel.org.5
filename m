Return-Path: <linux-kernel+bounces-74233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C4C85D163
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21E11C222CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99B93B296;
	Wed, 21 Feb 2024 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CtowtaPc"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA21C3B198;
	Wed, 21 Feb 2024 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500514; cv=fail; b=P5Q0q1QyipDN/64FuEqX/Tk5NduQuL0iHpBPmjdP9/isQYvxyZJx6eXYpxc/ogblxtIqOhO6D0PEAGSeNIVCAP4EL7RCk4QhXjcEAZzVmtKLH8d4jFHelIo//B6UWCPa4/DY62Kd4Rtr/eNxd/RAVL4emlE6BPIEGspHs5AeQrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500514; c=relaxed/simple;
	bh=YMJLKFmwuMvotce9RERhnTUzmspQZ3XLRkeylh55RUo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QlQSpJSuskXsp5+IgseNBefX8PCkQq9aDL4THZpLD3yAAS2WFUJ4qVe9KZr0Tp4cei1d6cmSe589vS5QkBMCpilB2/VFHDX0UqdHG5MHvKZ41mHAFLnJvddCEbeqNtHFiimUuBfyOL/zmN7HXrbJBuT5BPgko9PVp3aB0B5Wfq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CtowtaPc; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkvwk3Nm2GVWt6SlUoKgbQmQHuYe9rFWFpeKJCJCKSLd+O5uG7JOOSwci4+T/JDMClefcuoZ577v/R3pznoegE6n5Tnz5/W3y6+DoIsJ9RHiaxwQ5QOsanA4nmoaHZf9DG/3NxlxOSIbiv9xo7K5Gu1tMfPhtunWXcueg9gbMxFUEq9f5NjvSqXgh+7peZsNx9BZYvQyEW5sGY4sobC8s4RkogH8SiZc4+CdNraq69Vn9MU22Vpj73je+OcP4PsjOZIGEM5w3BIs5Xs6SLHAx6pEqvwM8DRQzPs5dRGW2fcrlAjCfIBDAFKAdcrwpEoVHBXM+zfGEKw+qGCyIeCRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiY4ExxKe8cPs7O8MFH0ncv1yuv+dYLUeBgLBzwywgQ=;
 b=jx6XjGxrrlwUTfRcVerEbxYIpr4jFmICLDf9Srf8A8xmm0hLVSfz3X/xPUYWmkUSvYp7LmDdAwSgV+huPWAof+XNZJW1hfZ4Sb3ihMHOnkOfoVwL0U1AVlpzWQI2gtT2iEbxbN2hxNnJBcfy6t7TvUsrliAXkCj/YeW4K1yZS25irELjOb7wCmb875kSgrRy2GXmJ5QMXKSVpk1zV/WcBoCJqJcy+MsBlA4xspcW8J6F8V9U36EZPqJ4ClTS+WfnYjLU8bxr6FUvSRt8s5lFS2ZXEwEwnigzVaL5GwJhbLbAUaT5O2ppZ+Oi6ptoY5cDHNPf4YxC04nS6E3I/JEOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiY4ExxKe8cPs7O8MFH0ncv1yuv+dYLUeBgLBzwywgQ=;
 b=CtowtaPctp1FxUuObUhGKFDlSimBPyw7zzuvJYUoyOYfna1yv+GUXQ9vhnzsB7MgnJhOzwz6nya7P8aqdeU+K9jqWYgosnbCleN8xJxt1CC8gqPqCW3qp94q1edsAKQLN2IxNqQm80+okZQil99l4yjJ5Ls0JfyGoodvjg0cQZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by SA3PR12MB7806.namprd12.prod.outlook.com (2603:10b6:806:31d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 07:28:30 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::57a7:a6a2:46d1:6cba]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::57a7:a6a2:46d1:6cba%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 07:28:30 +0000
Message-ID: <986950b3-d747-4ff0-9a56-3b9e2c2476d0@amd.com>
Date: Wed, 21 Feb 2024 12:58:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] ASoC: SOF: amd: Move signed_fw_image to struct
 acp_quirk_entry
Content-Language: en-US
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20240220201623.438944-1-cristian.ciocaltea@collabora.com>
 <20240220201623.438944-2-cristian.ciocaltea@collabora.com>
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <20240220201623.438944-2-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::19) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|SA3PR12MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf32450-55d3-4760-80cc-08dc32aeb3c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QSiv9534egdvq4ZNA0TP/WujHZhiH5rB3ILRTI8ZC2XFQegzw2Dcydao7+D/FFJ/T0qeSBi75D4pAxljHe1JjrZZZimJT5ihJP+fZLADuFP0dgzurRRrhNsUELObGI1qF0Pm4U0aKJRBtS9aDWQHQmVvXJMewGfnovniQmmd/uKKbN3cjFMe/xJdJ5eakwOOCd0cNY3evMtIlCiFysN4A/ZgzDs5R4YJ7D5xtM0FGQNOJ03ZhgUeAQnquiOgggsXq29pfGPCMntD8WiZXwfOLeoqgtdHHBMSIQUbC1wnbSccBooG0jG0+IECZsiT588/O4EoufeyInb2vnMn7J8FThilCmQNheszLSOPIpS3STVa7ozUwF/bytxmoJ/hZcU0kO1UpJoVE7R+zXpeZ93QJE7WkDI7KWY+SH+uNHpYUZ0HORuVhho7X7bXFtBiiBwSIvqNh27e+/PMNxSwbcCoccmsNHWXSh1q9LyIUG3L2TBu1SniAUcrxrbVcJmYTpB50cLRhLbH3pnCKrEG4XlB9YtYpZ3qCJ9MCwrY3eHUUaYUzC88LVgffzcBv6QsXUXR9ozM6jPt6DK83EmNL2laqAToSfxLUoB4VNMxsDamksE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjN3bHZ0L0ppcUVObkZpT1NWVXZoSEtQZnE2aVdJNkNVQlhzS2E4NE9qZlZE?=
 =?utf-8?B?czlRRTlGdWJOb0ltN0JRNGkyTVRicm9mR2h2a2MyOXlaQm9Ga29CMWR4dkZw?=
 =?utf-8?B?S2JKVlQ4czVzTkRSYjlmVUF6TVQ5Y1AwRThYMjMxS3cwY00wK3FSUXgrZnJB?=
 =?utf-8?B?VE9ENTJMRVdTME8xWHNCV1M4aUhiNDFTb2M1YWkwbFkyWGlRZ25PQnBmTUFx?=
 =?utf-8?B?aTJDMitFR2lBY1d6elU2ci9Jam5lMnczQmF5cGJuclYvSjQ3bE8xOWRLRGhq?=
 =?utf-8?B?eWlpd0JWaFlGUHR1SGU2NmNkQzlpVjlrMDU5SVFEa2hJcEN5T1NCaEZyRTho?=
 =?utf-8?B?N1h4QThGVk9CY21hMEQzcmtDU2tscjUwR0hCM1dCRHQ0QmlYZU93UzkxTWJY?=
 =?utf-8?B?ejNLMDJ6UUl5QWxpUi84djJWSGVHQlJrNnlCcTlHc1BFVzdlenVTSjZwdVpa?=
 =?utf-8?B?Vm1HRTFTcFRieGRoTGphWFBveTZiT3lqdEJuakR3WWs2SWUza3lBSCt3K3gv?=
 =?utf-8?B?ZWRpeVArTCtGUnZ0eXpVWEVaeDdEQ1RBNGRZQVNHWVBqNWlpQXFWcUJZWTF3?=
 =?utf-8?B?cjNHOGpiV2F6UExQYlNwZFZOOE1yQzZEM2hrdFZrSFo4SzFGbWJ1enpxZGNh?=
 =?utf-8?B?Q1pMZ09NeEJsVkNMa243S05wS0VCN1FFYXZCTWFaRUNlNE5xaC9JeGYzMnlj?=
 =?utf-8?B?UG5LSjNaamVQU04zVWprc1R4cnkxeFVISHViYUVXTktDU3p4MDhnVzJYZy90?=
 =?utf-8?B?NzFEUEdIbTRwREF5NTRyZWg5OHFFV1l2SkZxOWpiY0xlTko5L043T0RRWWtD?=
 =?utf-8?B?OElCME9OaGZ0dnR6V2NvMkRmWnp5VzBoNFpPd1UxM0ovbFZ6Y0I5cDByK0tt?=
 =?utf-8?B?cW5zTUlvMENjd0crM2Q0WjVOZlpTUXNBNkF5b2JrTndYbk9oQnA0MDRZU2xF?=
 =?utf-8?B?MlpPbCthSlFtWFR2V2lNYXg0K1Z5SHBiMVp3a2Vta0wzSDB5eGpuOExXWDZ0?=
 =?utf-8?B?QjdIdStScFR3akJyVFhKWUNoeEUrOHVwOGtHcGdCR29ObzBRaThIOEJQRWdN?=
 =?utf-8?B?L0VCN2taclBZL0w1OVF1REh6cklyOXh4T3FMUXNIdk5kemFyRXVNR1NobHRm?=
 =?utf-8?B?TENQSmdXSThRQzdHYU5sVVpQdDNEQmlkemdaS2ZwZjI4ZmNKdzFrazNWZjdS?=
 =?utf-8?B?MjRnZE12L2ZHNVh6RGVlMWd6OHNyUDUxV0UwMVdlMWNXb1g0a0E1MFVEdkZC?=
 =?utf-8?B?Q0NOSTM2aGdRWDdDV3FoQXZpVjVQcDc0UVBxRHlYR1NjeUlBdnlPY3NZRGlx?=
 =?utf-8?B?d0s0WEdXbGFRK3hJanZsZGNKQWFFdWNQQUx5V0gwWkswMFVEVzNxbkRFNEN0?=
 =?utf-8?B?VnhvOEFYTnpaTCtlYVk2ck5UU3JER2NKVitUQVh5Q0tnSmJkT0ZWR2o3bkhY?=
 =?utf-8?B?WklHdHJia01XYWZyWkM2eDFJT3NxWjJHN2QrYjZNVUV2b3hEbEJ5bVdiSjR4?=
 =?utf-8?B?RXVNZmpIbm85Tmw3NkRLalZ3ek04YlhOM1pCVVRVUXQ4dlA1NzY5NzZsMlQ3?=
 =?utf-8?B?MTFIS09QdHFyaU5DZEQ0RTZLUHMrU2ttKzY1dTQ3S3NlRmo5ZWoxb3YzNTJa?=
 =?utf-8?B?ZHlmbmRlZVlFRHVHc2grVExFOXprVXlzbXZGOUN4NDhweHZaYlhaUXpXbFp3?=
 =?utf-8?B?T2NPdlpSaS9oUnlYN2N4TlRLWkVnU1VqMWxRdEVzclVtRWxIcGhYVUUwUSt1?=
 =?utf-8?B?bmI1VzlwVjkwZkNsVTlnUC8zcXNSa3doK0NkZ21vYlRZa0FsYUd5cFp1YktC?=
 =?utf-8?B?ZCtLVVZyVDlpdnYxQlUzN3pSU2dXT29tK3pXSEJHR1A0U25UQjRJZDFUNHYx?=
 =?utf-8?B?bmZ4S04vWG1CdlVMUXMzc3IvSmcxNnBselJKVW9oZFZlZ1FCcGNZbkk2RzN1?=
 =?utf-8?B?OWgzYldyWHhMWVhic0FFbUx5MWN5WWhYUHhYZndEWXZLbzMwMDEzK0pVS0xX?=
 =?utf-8?B?bUUyNHBONzdGb2JRVEM5QXFLZ3AxYUZOY2Q3bG14Zi9tUzZ6VmdTM1RpRXdQ?=
 =?utf-8?B?ODRna3VKYysrdmoybWduTjJMQmZ2V2RzWCtYQ2pBcm5OWHd0dWY5TzA5b2Vp?=
 =?utf-8?Q?7xtuweSWsjt3qNcIBQeNYuVfZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf32450-55d3-4760-80cc-08dc32aeb3c8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 07:28:30.5336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1hzMNaG3siYONKFf9Hc9tHHAnC0VXJINIOkQZ9p0ph1etKbcybjNKG3KdJiYIpOYhtrfrcwG+tfMq3vqUvGnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7806


On 2/21/24 01:46, Cristian Ciocaltea wrote:
> The signed_fw_image member of struct sof_amd_acp_desc is used to enable
> signed firmware support in the driver via the acp_sof_quirk_table.
>
> In preparation to support additional use cases of the quirk table (i.e.
> adding new flags), move signed_fw_image to a new struct acp_quirk_entry
> and update all references to it accordingly.
>
> No functional changes intended.
If there are no new flags currently being used in this patch, and also
no functional changes added, in this case this patch is really required?

Also please use scripts/get_maintainer.pl and add authors in CC while 
sending patches, then only
maintainers and code authors gets notified your changes.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>   sound/soc/sof/amd/acp-loader.c |  2 +-
>   sound/soc/sof/amd/acp.c        | 47 ++++++++++++++++++----------------
>   sound/soc/sof/amd/acp.h        |  6 ++++-
>   sound/soc/sof/amd/vangogh.c    |  9 +++++--
>   4 files changed, 38 insertions(+), 26 deletions(-)
>
> diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
> index d2d21478399e..aad904839b81 100644
> --- a/sound/soc/sof/amd/acp-loader.c
> +++ b/sound/soc/sof/amd/acp-loader.c
> @@ -173,7 +173,7 @@ int acp_dsp_pre_fw_run(struct snd_sof_dev *sdev)
>   
>   	adata = sdev->pdata->hw_pdata;
>   
> -	if (adata->signed_fw_image)
> +	if (adata->quirks && adata->quirks->signed_fw_image)
>   		size_fw = adata->fw_bin_size - ACP_FIRMWARE_SIGNATURE;
>   	else
>   		size_fw = adata->fw_bin_size;
> diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
> index 9b3c26210db3..9d9197fa83ed 100644
> --- a/sound/soc/sof/amd/acp.c
> +++ b/sound/soc/sof/amd/acp.c
> @@ -20,12 +20,14 @@
>   #include "acp.h"
>   #include "acp-dsp-offset.h"
>   
> -#define SECURED_FIRMWARE 1
> -
>   static bool enable_fw_debug;
>   module_param(enable_fw_debug, bool, 0444);
>   MODULE_PARM_DESC(enable_fw_debug, "Enable Firmware debug");
>   
> +static struct acp_quirk_entry quirk_valve_galileo = {
> +	.signed_fw_image = true,
> +};
> +
>   const struct dmi_system_id acp_sof_quirk_table[] = {
>   	{
>   		/* Steam Deck OLED device */
> @@ -33,7 +35,7 @@ const struct dmi_system_id acp_sof_quirk_table[] = {
>   			DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
>   			DMI_MATCH(DMI_PRODUCT_NAME, "Galileo"),
>   		},
> -		.driver_data = (void *)SECURED_FIRMWARE,
> +		.driver_data = &quirk_valve_galileo,
>   	},
>   	{}
>   };
> @@ -254,7 +256,7 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
>   		}
>   	}
>   
> -	if (adata->signed_fw_image)
> +	if (adata->quirks && adata->quirks->signed_fw_image)
>   		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_INCLUDE_HDR, ACP_SHA_HEADER);
>   
>   	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_STRT_ADDR, start_addr);
> @@ -738,26 +740,27 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
>   	sdev->debug_box.offset = sdev->host_box.offset + sdev->host_box.size;
>   	sdev->debug_box.size = BOX_SIZE_1024;
>   
> -	adata->signed_fw_image = false;
>   	dmi_id = dmi_first_match(acp_sof_quirk_table);
> -	if (dmi_id && dmi_id->driver_data) {
> -		adata->fw_code_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
> -						    "sof-%s-code.bin",
> -						    chip->name);
> -		if (!adata->fw_code_bin) {
> -			ret = -ENOMEM;
> -			goto free_ipc_irq;
> +	if (dmi_id) {
> +		adata->quirks = dmi_id->driver_data;
> +
> +		if (adata->quirks->signed_fw_image) {
> +			adata->fw_code_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
> +							    "sof-%s-code.bin",
> +							    chip->name);
> +			if (!adata->fw_code_bin) {
> +				ret = -ENOMEM;
> +				goto free_ipc_irq;
> +			}
> +
> +			adata->fw_data_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
> +							    "sof-%s-data.bin",
> +							    chip->name);
> +			if (!adata->fw_data_bin) {
> +				ret = -ENOMEM;
> +				goto free_ipc_irq;
> +			}
>   		}
> -
> -		adata->fw_data_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
> -						    "sof-%s-data.bin",
> -						    chip->name);
> -		if (!adata->fw_data_bin) {
> -			ret = -ENOMEM;
> -			goto free_ipc_irq;
> -		}
> -
> -		adata->signed_fw_image = dmi_id->driver_data;
>   	}
>   
>   	adata->enable_fw_debug = enable_fw_debug;
> diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
> index 947068da39b5..b648ed194b9f 100644
> --- a/sound/soc/sof/amd/acp.h
> +++ b/sound/soc/sof/amd/acp.h
> @@ -207,6 +207,10 @@ struct sof_amd_acp_desc {
>   	u64 sdw_acpi_dev_addr;
>   };
>   
> +struct acp_quirk_entry {
> +	bool signed_fw_image;
> +};
> +
>   /* Common device data struct for ACP devices */
>   struct acp_dev_data {
>   	struct snd_sof_dev  *dev;
> @@ -236,7 +240,7 @@ struct acp_dev_data {
>   	u8 *data_buf;
>   	dma_addr_t sram_dma_addr;
>   	u8 *sram_data_buf;
> -	bool signed_fw_image;
> +	struct acp_quirk_entry *quirks;
>   	struct dma_descriptor dscr_info[ACP_MAX_DESC];
>   	struct acp_dsp_stream stream_buf[ACP_MAX_STREAM];
>   	struct acp_dsp_stream *dtrace_stream;
> diff --git a/sound/soc/sof/amd/vangogh.c b/sound/soc/sof/amd/vangogh.c
> index de15d21aa6d9..bc6ffdb5471a 100644
> --- a/sound/soc/sof/amd/vangogh.c
> +++ b/sound/soc/sof/amd/vangogh.c
> @@ -143,6 +143,7 @@ EXPORT_SYMBOL_NS(sof_vangogh_ops, SND_SOC_SOF_AMD_COMMON);
>   int sof_vangogh_ops_init(struct snd_sof_dev *sdev)
>   {
>   	const struct dmi_system_id *dmi_id;
> +	struct acp_quirk_entry *quirks;
>   
>   	/* common defaults */
>   	memcpy(&sof_vangogh_ops, &sof_acp_common_ops, sizeof(struct snd_sof_dsp_ops));
> @@ -151,8 +152,12 @@ int sof_vangogh_ops_init(struct snd_sof_dev *sdev)
>   	sof_vangogh_ops.num_drv = ARRAY_SIZE(vangogh_sof_dai);
>   
>   	dmi_id = dmi_first_match(acp_sof_quirk_table);
> -	if (dmi_id && dmi_id->driver_data)
> -		sof_vangogh_ops.load_firmware = acp_sof_load_signed_firmware;
> +	if (dmi_id) {
> +		quirks = dmi_id->driver_data;
> +
> +		if (quirks->signed_fw_image)
> +			sof_vangogh_ops.load_firmware = acp_sof_load_signed_firmware;
> +	}
>   
>   	return 0;
>   }

