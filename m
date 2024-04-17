Return-Path: <linux-kernel+bounces-149140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BCF8A8C61
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 265E0B23C86
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE98383BF;
	Wed, 17 Apr 2024 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E9j+V+AF"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092A336AEC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713383865; cv=fail; b=cox0ie5UWs66GW5S7qXRs0frOv1eyaLI+Wy/auye6YeKyeVupzvn9fSg6lUAuir0VYg+B94GfnQSx+ZJHVz9ijeczn71AiX+KCTNY0M0tbg1D8AiYsupbzZQdxVd9H6kspC46EvYfU5T84jNkyv/ehSHF27g61cftD39ROxzoSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713383865; c=relaxed/simple;
	bh=idRU6s8tUa8pTSu82xoE8o42WVFRZZRpRD0iY+NOHyo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MEy/YEXGaJjcocrMcjcLoMhzhUQYX0Xm9PpWQtr+q1bxx0Py5FzKFaBi3wHTom3qOnt/9YBA9amMYYzXeXgXj+F3KcsC9JqAfTWmeekXsP5OgSBUOOkVlk7XEZS+6eVkA2BkCrgXlVgMA7p2poZyGVuHAbzDFFjuBhXBv3qCv3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E9j+V+AF; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtBnQ/dqA8RG4CZjINC5j5zTElodNW/4qCUkpblIKoXCYUAa6gj6Zutj97BWmJaz1jGiSoE3VQrFhs4FC2mdPas3bTK4EpGIVe12AsBymf5IeF/EyK68VOW2L6lp7HZpDUi+vVfnNzpAaf1yzgdxDRPeBBwoz7w1rEuc87oqqW/wF8CUhc0j1PrI1ZDdK4ddueEE4M5dqjLq2APdAx+a04V4IZOgO1FDFviLg3HYroC2/4N7fKbOJ0Y1Zara7BdQFwGLNjrlBU3TvkNZr3Cb4S6trjSv0cg4eY4WM+a1TgEkOVMYeQCnpmj55XiuFWx6HUmEJTIn74h1z7sjPy0o0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTVX1oUTU/SkIQxPAf7CFfIFLxq8P3X2F0E9hwntjRQ=;
 b=kPD/IYbLfbJzcybCJlC7FNTvGsUrxTTkqknERwO1YVFfkbbaixourtaqQenOOAyNzcpMaPj2lrH74W6nNBNnHeHz+m83GCF9C+jLjWo48wDI778YVkcJyx1iXA5CNBnoLn8qo1puaLBm72ya+VUU6TAva7/fGxrWDwq9gf/F0r9yIE0mcXFPSOOwBI/edy+FbVcwyqotYN0XGYPGAJ9Bv2Bai6xlj6yiK66ayD3wLKwRfqxw+k9agkXib2YDNyMA/jwwtACpXMBgRdxYQ6ji1ZZwORDzpT8OyGcHHTLZ8bW8qJQH18SXeVN5OnvsLZpfMYSPwQ6lkvrQCwp7WOHdaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTVX1oUTU/SkIQxPAf7CFfIFLxq8P3X2F0E9hwntjRQ=;
 b=E9j+V+AFI8TzPuDqWwsIUt9t58NYRrcYsSYoEuP0MmL5zFSQsfcpvChO80JNfIhGkEfmhFqZN7wcCoMmWROgbHZlVX+rhSVlUmdMwC7z4REqlSdiwQ0tafIBP8cjN628+pXhV/feK1RV6Z5XRCYitYHyL0t3iMZ3SD8oxr3pehw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Wed, 17 Apr
 2024 19:57:40 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 19:57:40 +0000
Message-ID: <a0630ca1-edda-45d3-a69b-17335afb964a@amd.com>
Date: Wed, 17 Apr 2024 15:57:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/amd/display: Remove unnecessary
 SIGNAL_TYPE_HDMI_TYPE_A check
To: Andri Yngvason <andri@yngvason.is>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Simon Ser <contact@emersion.fr>, Werner Sembach <wse@tuxedocomputers.com>
References: <20240115160554.720247-1-andri@yngvason.is>
 <20240115160554.720247-2-andri@yngvason.is>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240115160554.720247-2-andri@yngvason.is>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0452.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::18) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH7PR12MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db495a2-c87e-4788-a090-08dc5f18a060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5JReknz6Y/HyqUT+Z8rqs3QK9mbujLxtxVDY6BnrYVtGD6nvkug5EAwYR3/mrgpcqND+/sOa9qG84dSl2gqyi8kRkAflFPCdVVLzy8i2XCXFVqGzH5Xql6h3TpiBuPXdtG1jHoiAC/fByi5zufUq2BFTRGhTtHSzIYJO3HignOcY6xYGg6oFvsZtM4lwD77IHDi5JhGjIKi5lZGqzFLV9VIh8MF/Q/X5EFguCToRr7cwEjlSwCED5ZgwSnq3NPqIhu3139RScDKP/K73eiKk5XeHZCYdZNGnrxk8R/bMbHPBQs14Fy+jRPxoiY5q68JQpCBLq8tgJf5b5VDAXKhSWH61rGSR1MVgCnvpCFCOpY4RRtFgQZgkbmyPsdxERY2GrjDau5raLcGmhLO5T4pcAvv+P3Fgid8JpMR3RUnoa/x4n7wCDyyj+l8yps/pWNggSrX5pa5IeLlTSA62eWi/jGRdXvstDrqfA+598cc6cneMtecLi6YOjjaHGZ1gsirwCwtfJ/eiW06igK21iIq+EyoNCrlz0ShFnssdv3HlHpufydjZG/3g3USiDcetjjf/WWvfE3qPkxTnDu8VVQDHNnXTjNMXQCVQsKWLt1J46tJNbK+x6wB50q6VUrb+NMIQTsEE7oKCuf43fKwM1RwNT9Dr5MfqVqXffCA2o5IhtLf2HJ1TMgxoXbsCxNecfaCo1brLoPXHoJwvIcV/Zus6hQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjE5bXR1U1I1WlVra3J1YTY3RkZ5WFp3NHRCdHoySkM2K091SXJGelBqOFBE?=
 =?utf-8?B?cnRMaW5TUEdwRElYaWFRZkZzbFlwa0d1dXh2RTRNR2VuUmlvQzNFYTZoYWo4?=
 =?utf-8?B?ZWM0T2Z3L2FaSCtVQlh2WjVEWU4vRFdlL254THZ3cWEvYTBVUW5NVHF6WnBP?=
 =?utf-8?B?KzdGRktGZFB0V1pTcnVwWEZuVXdTMUtjam1vcGgybEFodXA1b0hMcXEzMFZD?=
 =?utf-8?B?TWU2N2ZnL3NNNUN2TmNiMDJwVnhtVWYzK2J1WFZIZmVTM1J0cWlhSUplOUpT?=
 =?utf-8?B?ZFM1Zk1YbFdQM1RlWjljeWtsUFdHcjFSRm9UY0VNalZvdzRVOHUxaVFONWtk?=
 =?utf-8?B?bDcvMVc5Rzg5U05aRXhXYnBnckdRTzBkN25uMzJIUXhkMWhOVWJ2TmVBaUNk?=
 =?utf-8?B?M1ZmakFvY3hWQmVRN2JtbDVWYTdqOUNRb3BGL0xITWxnWmJ0M1I1ZUMyWXl5?=
 =?utf-8?B?NmNiSVFSUGJpbzd0S1R3RDU5V25iak1TRVlGNTBjS3JmcFZrcUwreTRuTnc5?=
 =?utf-8?B?c3o3VllqV0IyVjFWQlBMRGxtSUFwSlRmWnBaendzWUVNWnRLdXZlczQxVnBU?=
 =?utf-8?B?ZHZodUtLSUVFbDA4R0dncENEUy94Slo1ejFPOGQyU2V2eS81UmtPRDZqcHlV?=
 =?utf-8?B?YnZTSDFoZTFpUUozWXBtejJ0R3VPZU9DV1ZmbGkrbTFCUCs3UVg3ZXFBbXZH?=
 =?utf-8?B?REZSbEo5aFpXTnRhSlN3UzBxMlJmSDFwbXU5M3VtSXpaclMxai9waXEyTmNV?=
 =?utf-8?B?di9WcnBvaGRKRWNKSDRMZlNFNVlCK3EyQUNNMWo4NDdLcjFic2l6SVRoTkll?=
 =?utf-8?B?bWsvMVZ1ZTJ4WG53SWZldklWanQ1TFEzcEEzWkZ2OHNxNy8zY0tIZDJUd3k1?=
 =?utf-8?B?SUo0YnBESlVUMGtoYTVKdDZlRG1VTkQvQ2xKeHY1b2dUNEg2aW9mS2lCc1FG?=
 =?utf-8?B?OFZpTTM4S0I0Y2NndTY5THdaYnEwQ3k2RkgrbHkxTSt1WjM1cnY1R0VzTmFN?=
 =?utf-8?B?b1RRZXlHNXZhQjJnZ3g4YUFpcXljNmhEdGRpclhxNHFQRHJqTHZ5bjBIeWI1?=
 =?utf-8?B?cmlBSHVmY3NIZUduNDdCb053bmdHYjI0TkhuemVEc01uN3ZxbkdMMmpjYU8v?=
 =?utf-8?B?TzdUZTZBUWVFN3pmM0d1WklIY2NxTXczMkU0S1JrZlZLdUR6WDdkZUFPdUpD?=
 =?utf-8?B?a3h5clpYMVRrNmRnYm13MS9jRDRWV0t6NFNzMURoczRpKzlsdzRiZ3B0d3dI?=
 =?utf-8?B?RXVJNzJ0MEdyUTZYczdUZUdLSE11cENvZ21qOC9xYzlGcFRpZ0Y5Sm0zRjU3?=
 =?utf-8?B?NnVmNVoxb3VwMXVJdTgvUDMvWmMyMmFROUluS1RCN1JIeVJ5YXRpMnlPd3kz?=
 =?utf-8?B?NlFQdkNPdVNsWkNaODVpY082cWxwbjAydGRTTnFJcjhpSmdJVzNvRittNmRP?=
 =?utf-8?B?Y0JQdmVGVEtSaUN1QWM0TEFCZUV4U2xkODZUT0lUUDh3d0k2NXVFY05kWDh2?=
 =?utf-8?B?TTh5YTJjNFNkamRMWC9Vc3dYUm50bGhFakN3WjVDQkJOckdEK3ludmQzZysw?=
 =?utf-8?B?WE40SzZpTGJCSnFVdHoyTmhSS1B3UGFpamZtV0VBODFrY1QxMHB2N3QrYlpx?=
 =?utf-8?B?eXdEN3lDdDlUUiszQ0FBRE9uN2lDZlowWUo2MzlxZUVJWGdFMGxTWFIzOWl4?=
 =?utf-8?B?eWVjd24zS0NDNjBWUUVFRGEzVXNrTThJeWFzRGdYWTkra3lNdDNsMkg3VDN5?=
 =?utf-8?B?VkJhZGNESDEwbTlQN0NUbFdBa3RhMUNTT1h2ckJFUkluZUlEaVBScHVEMFJs?=
 =?utf-8?B?eER0RUo2cDhodnpkYUxxT0x2enBUUUlySFU5MEg1aExoR0hNdHVZbjllZ3dP?=
 =?utf-8?B?dXBzVG96MjQ2VG1kQUw4U2dZVTluKzhaT0E4eWk5YXRBU0xOL3MxeGVKcDhR?=
 =?utf-8?B?SFpLdkd3QWFQdnNOSndlcGVDeGYxSEdkMmxyalBhUHYydlVibVEveGNTd0Jq?=
 =?utf-8?B?Tmd6cUd0RzdmMisveTdka2tQYWF5anJnSmRZRzViTWQvZTJKbjhvQ1g5alZO?=
 =?utf-8?B?WlRqLzUxS1owaTZtUmRBSWxURVdOcFk3UzhFeDhqblFtRWVvYThRQ3QwZE82?=
 =?utf-8?Q?K7aElovMzpQj/kMRoRjUKTfih?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db495a2-c87e-4788-a090-08dc5f18a060
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 19:57:40.5013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGnWL3JQ5JcEGUu6njjziQ485Dwb+3DaB/uD2Sofz5XRkNBSDDpoY0SrIqOv+0XyEW9jcXw5Siu1uJNaXzzQEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7820



On 2024-01-15 11:05, Andri Yngvason wrote:
> From: Werner Sembach <wse@tuxedocomputers.com>
> 
> Remove unnecessary SIGNAL_TYPE_HDMI_TYPE_A check that was performed in the
> drm_mode_is_420_only() case, but not in the drm_mode_is_420_also() &&
> force_yuv420_output case.
> 
> Without further knowledge if YCbCr 4:2:0 is supported outside of HDMI,
> there is no reason to use RGB when the display
> reports drm_mode_is_420_only() even on a non HDMI connection.
> 
> This patch also moves both checks in the same if-case. This  eliminates an
> extra else-if-case.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Signed-off-by: Andri Yngvason <andri@yngvason.is>
> Tested-by: Andri Yngvason <andri@yngvason.is>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f6575d7dee971..cc4d1f7f97b98 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5575,11 +5575,7 @@ static void fill_stream_properties_from_drm_display_mode(
>  	timing_out->v_border_bottom = 0;
>  	/* TODO: un-hardcode */
>  	if (drm_mode_is_420_only(info, mode_in)
> -			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
> -		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
> -	else if (drm_mode_is_420_also(info, mode_in)
> -			&& aconnector
> -			&& aconnector->force_yuv420_output)
> +			|| (drm_mode_is_420_also(info, mode_in) && aconnector->force_yuv420_output))

We need to keep the && aconnector NULL check here, otherwise
writeback connectors will blow up.

Harry

>  		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
>  	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
>  			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)


