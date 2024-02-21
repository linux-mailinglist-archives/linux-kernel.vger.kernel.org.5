Return-Path: <linux-kernel+bounces-74131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F49B85D048
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFF81F2563E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D89F39FF7;
	Wed, 21 Feb 2024 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tIGFbZGh"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2970B2556F;
	Wed, 21 Feb 2024 06:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496072; cv=fail; b=qT8KgetKV8zdnw5UbB84XdEnvNXXg/xpAkSnCnN6LVLldU4p4OcfrcHUSIbWhETxsuAQDc7Ay8B4vqXwmm1GVgdO588Azy5bWwGHbMNqhofFxE4e4uamSTWYja3p1ypUgRKhWTdMll9GKF1c3JW++9IW+Y6WAcEXP9KPfWeLW4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496072; c=relaxed/simple;
	bh=mM1h/8/K+G9Y7XoRX5zmYox5xo626MCBpRVI3xwDAlw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u90KrU5cuTeLS7eUkglFrJnnNrUOL8tzn1sImB5Yssgy9ZY8AWLMkZ4XJFMUW5SaKqGYMDhOuFLq3xu1c2I+IKoJZ/JWuRKrL+a3EdCR847tkf9/1SG18zGXNxpbjok/VruCzvgPDKIbSOtbpfJowq8Rj9ilIDtmodTlI2HplkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tIGFbZGh; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2a7ztlS0n2pewj71dxxJEhKeWuRxi9etilq245+4Azn//uKk91tEKWUyQU1zQrMR1fBOxc++3rQOELSwCGY9saEFxB4iAYqpxR6QxqRTCT6E1YDZz0zuF2DFFmFTxOSP4gO6clMGPAUi7iZQ78Ff0X+7b/AnzCIBQPg33yq1oQb1oKkoSQmF0oMNUN6K5DdzacwV1qMWEPo8okCAgRVD7+xGFHhfHxjafaoMhQe+tl2wL5zjRJrGLrsnToJvgwS5GwVD/OVzgs/U1uP3wkvvo5Hj5KuD+0itDeaOopnN2s4lnspt9xNIsqdcOivJ1fZ8GkIMI/1xuyMhN6tHrW4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeYZg1wAtSlb2gBEtJYquZKYTIJyQnQlpWSuCHqtW68=;
 b=S/LYhWubhJoLr/aqNqPCu/s6toQd4K9TJtLPSDeIBiUyal+Eyina+UpNgtvvfQ7oPsvH48xX9LMbeycAhwYLYPPaCMWFKpAsSJFfKFktrGwAXXu0Ln16s3KWwbxLeHCcdXAyO0x0kqfL58q8O8G4FzbutowE/va/wci4dDJqvfIWY5m9TCf7LeiKlCdZmV7BH9AkJRLk0hHwCXWO840HXsgq/HwMoyptTNiOToOQWSyalbbl7qsqwM/6PDUCTsUu8SALuL5eSd6HlSTvCdfRUefAXQFEZBuN9eZoDVrwusbFA4rM7392bW7+0q4DRv0Zgm2yy0ZsbafZS9QGZM+yUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeYZg1wAtSlb2gBEtJYquZKYTIJyQnQlpWSuCHqtW68=;
 b=tIGFbZGhNQR2TuUmUU//nh6dFNziyI1Qd6ftbjUuOqG+S3Ew9IDPuBYNgTqTMKVfatlBL98KN2bJujWltTZ1fUoeYbMFQM9J53F+lnMz2yFaTpARcBhPitZGJhzUN7Deq3aavm609SVDw/8ZKiVZQuNSa8Jn3wcGp6auUJ2hkrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 06:14:26 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::57a7:a6a2:46d1:6cba]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::57a7:a6a2:46d1:6cba%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 06:14:26 +0000
Message-ID: <133770ce-98b0-4e36-b21e-1468c45fad0e@amd.com>
Date: Wed, 21 Feb 2024 11:44:16 +0530
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
X-ClientProxiedBy: PN2PR01CA0198.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::7) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 38968bb2-8800-4086-467d-08dc32a45ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sA0TaHt0tNKb6cKjK58HB23M8NNxInz7NfunfQp2HQASIJDDH7U3Ku/qxrKwyFICoR6lxgvt8o1fORlP7XIX/LgwGQw6o77Y2vtK9EZ3ENzmf/HMfF6SK/9i08mXq7gt+6IS2BvGnK0Ma8dor1lPJHORx7RtdVP+wxhDhWWCtExCObVCZOYH1/Gkn5l0do39F59PCi3a8Sa1dnmgxFTyVHARRrg7ce9P0Pwtqreb/jGWg3Z7rBqdnNxEF2s7JEOwLgbfsKBoSDUUAd8BW1nJ7i2QYQH5tAZSzV0Yw78dP06044ckiRYrmkeB8thnaduY5I/4erVXJOJ44fAGolZTXeq60+JSdBy1uDeOz3NZ+GeL54drh13F5+kCi2YMN0JevLfmzH3CIewIMgMSEW2qScJhAChmeSGa6aax7EuRjjdiQoe30M+2/K5MfL1gJ9wlfGuUPaL35OCfrx+ygzIgWg6CFbME/jiM9RzVZ9RMpKVDVwVo7E+K+mR+g4yV1eabH965dp7hrF0raJyhF9gnAh8HU7W7qQ+pX9/wcWyIzwEMLpfUCLXILCpcbk744/jfmNVQ1ofbkyY8FcDcsTiMNzYvyTqIX/o861++miAv9K4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDRsbkc1cGNkMXRlVjZ4UzB0eHB0N3lWMk1qaVVCMWNQSW9hQyt1aWtGajlR?=
 =?utf-8?B?STR3ZUFHdzljS2pzZHRTK1E1WkVKOGhKZWxuNVZWZGJKR2RZNUg4VlNtUVJx?=
 =?utf-8?B?eXB0TUM2RzN3TkRlNEYwbVFYZWNjbFhFSUpibStSMGhvSFNoeWpnWnNqd0lE?=
 =?utf-8?B?Ri9JbkM0SS8wcTdCb0RnaE1odUZBOFVXRjZqbGIrZG5LM2FYTXc0UjExWXlU?=
 =?utf-8?B?cXNGWWFmRnAxNjhOaENxYXkzaHM4dTh0SXp5Z0lyUXE2QktsRnoxYng4RXFC?=
 =?utf-8?B?R1ZJQm91S1JrbVZ4eHJnV0trREpMbmZBc1NEaDdLWG1hQTUzNGVnak1yeDBQ?=
 =?utf-8?B?M2QvOXpqd1luN1VZRUZMaE45TENwdCtOOXdWb3h3Y0hvTHFCVVN5VGtWaVA2?=
 =?utf-8?B?bC9oKytMeUFZN3lHN1VKdERudXh0Z1J2UWtaeXBxV1dhMnJlTjI4aWp0TDhw?=
 =?utf-8?B?ZEtHMWtjQkxnMVh1dWNyM2ViRHhja0IyTVJVaDRiQ2crQ2Z2R1oxRHU4RElv?=
 =?utf-8?B?KzJaMkYzMXQ5MCt2N09YYkhRSFVkOWM3UTFHUDNFbkRkcDlVU0xWdHpjWEJ2?=
 =?utf-8?B?V1B2ZjZtT2hTUlVxV09BTS84RU9Qcy9ycnVQQi9QaFJSV3BkUVFxM1hmTWEx?=
 =?utf-8?B?OXZ6ay9lc3hYYmdjejZDSTF1MjdmVEUwQzk4VlFyYWYvVW9BVHFYU3R4U215?=
 =?utf-8?B?M0Z4U3lVdmxSaHpXOHBWd0lwQURDWklpVXpkaEIrWGVEU1BuandlWXVpY2dH?=
 =?utf-8?B?dUxjeEdMblV5UGh6RHBrMy9XbE5yZkVYcEhoZndXd21OMkdnUkJjdmxZcnVt?=
 =?utf-8?B?YVFHRW95KzJHNHF6T3pYclc0aGZhRzIvZTgrakdrUmlBQm0yZ2J3T0YzRGpu?=
 =?utf-8?B?eSt4YWtFT3VySjdRd2JDdW0rKzdEZ1UxVnBLUFV3TEpJL3psbDQ1Ykxyam1R?=
 =?utf-8?B?YkVmQ1pJNlFRUUNFTGZYdXd6VmFuUDNJdTVaU3lnb2w5dzFkdGVCaHlzbzlY?=
 =?utf-8?B?OUcvbHB5Mkh3R1Y3LytlekRNT2NvOGM3VzY3TGt3MnlQdkpldGN0em9Qc0Va?=
 =?utf-8?B?bW5FVU1oQW5OT2RzdGJ4azROU0FpS00vQzUvRVRzUW9QS3BUWGd2NHlvYXN5?=
 =?utf-8?B?VDB0ZVljRHdxNmRzSTlza1RhbkdyNWNGVDlScm1sbUFGRi8rTlZkZ25IK3dF?=
 =?utf-8?B?UVg3V2QzLzJIcW1ITjhza1FDcHVEYlhYVFNDdzBZQWtqbGtneE42c3dOd1JC?=
 =?utf-8?B?QXFkKzBXZjYwLzhkVkdTOEhmdXlvekFXZUVLN2dZbWpxcFdPV0xSTHpUbmdH?=
 =?utf-8?B?WWt2MEVTZ09QbHhzYm9lTjF6VEM5QWhsYWRIY0NxK3J2NUE2V25xMHJVOVFw?=
 =?utf-8?B?aE9ic3NTSlBGTkczK1pSK2ludXNXQS9pRjNIOHJCYVpDL3Y3ZEd3TEI4cGxi?=
 =?utf-8?B?eExDZGEzZjBCK09aR25zK29ZSmRqOGxsWmYvS3dzTUVuZ2g1L1p5d0J4NmUz?=
 =?utf-8?B?aW9PRnYvQ2J1SCtaTTNTYUIza3ppQkZrU3RtdmZscHZVSGF4ZGF4MUlnNVls?=
 =?utf-8?B?SkthRDJrckVvRllCVnM3NEdLdHpOK2d5Yk5vSXhQVERlSjRPYlg0SWRmcCtv?=
 =?utf-8?B?MlhhOXdMSGZVWkxtdE5CU3Z2ODJYU3dCUlBIREQxdHN4RXF3bjVCNlVqRDRt?=
 =?utf-8?B?Z3k5dldqQ094eU4wM1pFeDYrdS9vdjBMeVhlT1NsQlBHQlhINk1CMU5kY2p3?=
 =?utf-8?B?SU1wYzJPSldMcVhSOFptb1o0bDZWLzFEYUNibzlEUWw1cFJTeWtaY2srVysw?=
 =?utf-8?B?UDM3ZFJWZ0laOWJDTmxuUjVYUzllMjN4elZoVUNkZGRFaEdCYWpWL2liVG16?=
 =?utf-8?B?RDFrSG5SUC9raUdzeUNhMExQQURsWVVCT3RYMWVFT2M0MjQ0QWk3bTg3L0dJ?=
 =?utf-8?B?MW5ldzIwTE9NbzFZQTZMZWp5bFRENlJqa1hQYUpsb3MvOXNweGlmZDFwY2RB?=
 =?utf-8?B?Ly9kWm5BaVhteUMvOXdZSCtZZmlwMEdDOEVqU1R6cjZLSFVBZ01OM1g3MUU2?=
 =?utf-8?B?NUVvbmYrcVlSWSs1emVKdk96bTdFWGtwTGxmY2h2SlQ1WVB4V2V3a3c0eUl0?=
 =?utf-8?Q?ROvX6BwjuX75vLs4K4ijXQhje?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38968bb2-8800-4086-467d-08dc32a45ae1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 06:14:26.3872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VD4+KDouV5J8HGM3SC/NKEsM9JMkXVwR7WlopYeTxgH4uX5DWbdFP6k/cuLGCVQnsvkbl15IgA93UsFr5cvw1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918


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

Also please use scripts/get_maintainer.pl in CC while sending patches, 
then only
maintainers get notified your changes.

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

