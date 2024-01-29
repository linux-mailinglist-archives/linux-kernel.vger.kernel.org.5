Return-Path: <linux-kernel+bounces-42767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52F384066A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7BE287951
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57135629EE;
	Mon, 29 Jan 2024 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GXG6mdVM"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B101B629EC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533951; cv=fail; b=rrz7Y8aEBhbNOMDxxEGR1Yrn35Ry+mlr009BKYsogavUt3KROlkEWMIW8c2bFTVeHB0dtSxu3Qa9/CFlI5PmsIEyUCAD8LW0nk92U11Y7+9HN5No9O40qtdIxJu5oHPtN/0JUZf/mDzV3oLVLPuvmnsgbIN/WersjdgWOxgnHoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533951; c=relaxed/simple;
	bh=gx1/1X+kcRrverq7wRoK/5Fl96H9Ss4G5BaGhLhQ65c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Satcsce3T9mohc6E3VwuLZfzVTY5jP9he0mKm0en/t1d4P/HE1Vk6tioL3D3ODiWSBHay3B47jrax+UhnkF0NcTRlr21ZfmjalHsEljpmNI/6iqOAgHGU3W6CREV0HzGBJkQmxjZNYb5n4Z1sLSR5fIYtk1AnfOiMZGiYvODt5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GXG6mdVM; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVe5dLHiVnjB9KQqbN2DIFGhlsRcLMc98p52x2Y+RitaIAcDxOmD3DTPizqCS9iL0/0RpDrmAVbdfwU17yoph9YicDc4RLbKPl02DNhtN3Mv3y0M/tB/Md/YqQv7RpzgPujlWCPv8lnZuUkNIgvUvssRP6WFZ1r700kY+srawar6a4lbAT/IsftfiRwmTt8vrces2bIrQGnSQ3fmN+UKqavERs/1ViPb94g4goa3nD1bWDsBdfRIBDiv0x6+6VzB5XbAfJO8KKbMQhc3RBW5uZ6AjBMuGm6APpin7UAuFYwJiyMj/NXkOK5twIDOH1HNrbm9g9tV5ucqQd2+6W8qwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmDyXjbguPWVgkpuOIK9GWY6kWLBJ3Q1m2gCbNuLb1k=;
 b=UrYEM/G3/ZsQuATyPyMeMHyBFEgbtSg0b61wcg7Ga45OEhfp3sksc1FCQGSmMfw4nksLt1V9eweh+VxDeMueFfrS5Pc5CJNAhVl8yRV2GpY/zQI+RgjkrbBP9MchVEU9rQVXjEi7bwiQ5k9xHpGwT9H7wZq1U9WiTagGBN4r+k2AW/CPBpaiuoTp2gDquJbFR6eWxtS4gt9g8f+G698EIh03/hdx9YPoFh7bPv/0C5Rg/erUpi/cbmDLMJIPFVRMUQLtwnOrX9nv9vbf6txqN5TzX460wabzULWcdrsDP0tYdtenNYo8eiV5yXuVuqXnds9ioOe0XRzKK0rk6AS29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmDyXjbguPWVgkpuOIK9GWY6kWLBJ3Q1m2gCbNuLb1k=;
 b=GXG6mdVMbAFWWKn+MiMY/0nFJE4fnHXLfkoeAHlPjwnzRrS5TpRwEKlf1G9c71xQWgtv3Qynwte/xTbGFBV0F+GoVgrzc8CiuUTreG1Ij0iSGvrRxCpTeynMFDbTu+H9ot2trDec1YDc5+6heSpkSr5NNFlUldQxTp+C29axzEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB5434.namprd12.prod.outlook.com (2603:10b6:510:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 13:12:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 13:12:27 +0000
Message-ID: <cab2246a-5ed8-4651-999f-260c1c4275ad@amd.com>
Date: Mon, 29 Jan 2024 14:12:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drm/virtio: Implement device_attach
Content-Language: en-US
To: Julia Zhang <julia.zhang@amd.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Daniel Vetter
 <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Erik Faye-Lund <kusmabite@gmail.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <marek.olsak@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>,
 Huang Rui <ray.huang@amd.com>
References: <20240129103118.3258781-1-julia.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240129103118.3258781-1-julia.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB5434:EE_
X-MS-Office365-Filtering-Correlation-Id: 392fd4b7-5b73-40f1-62a9-08dc20cbf0ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ogDy/xhbMfT4ythnYapmm213yKGNZrwna3BH3yhqiDUFQ9iaJ+aXMHdqiVWE118jK4XPTnL+KpoR6lTLZV55+UPvIsES3sc2IvsfyIzF/KUVFlsrXAKxt5KyqpaBD3meR16hjGu2eovKMMqlQRf8WYM52ZEiu1/v9jhUDQpGrD2jTzBevr7qW32Hj2eRkzclBk7kEE/24HhkGGTUkzvmkgRI49tvfVSLVLMlYXWk7SSZxxnyAexaVdI+RN0W8sliTHdYTQMSIrkPLctRaiURHvi0kLTzgDT2d7Oq8/4d3y4fzGuKg0iLXBCMLeZ/xk4FqDi4g84Mxt/NDvOVJU2T2pVtRCslacnZriF1ikeNFvvP79N3hMN/KqRJDPUTYyXooo1BdBAV/+rESVJ3OnYw9daiGrDTign084+nhS07LFJyyswHqBoKJPp37Q6m8ddeKS7E8Qr7OPGUfPrVx+PZhcuSKo8bjhis+yjc/WTBiWLCwm4/lj3pfybemr3X9qte0Q4GRCzO3hgsxLnVr4iKwQdPCZ+fTjt17b5KMYYjPAMOCiMnt6qC2xQg8Aff05DgzlYhRgVHjhCmFR7HM+54rOPh7RdwyoUmDQGPFNDf5EjvKd67BDNJDPCWtSB1dvWDdwIYW6ZFWOyRW0RNBO86TA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(83380400001)(6666004)(6512007)(6506007)(2616005)(38100700002)(5660300002)(7416002)(4326008)(8936002)(8676002)(41300700001)(66946007)(316002)(478600001)(6486002)(2906002)(66476007)(54906003)(110136005)(66556008)(86362001)(36756003)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVNFai9FdE1GNWpTdW1KZFA1U2wwaXFFbUpLa2tiYnEzWDFBVThBbkJubjQy?=
 =?utf-8?B?UDJPMlQxbis2aEIzM2M2K2UrYzUybE4yeVBUVXkzTUh0cU1rL2ZGUkUrVE5I?=
 =?utf-8?B?VGpUK3JvWlNYY1BJMU5TL01mQWl3WkdRbzdWRGg4L0NyU3RwSEdFZUlSeGdn?=
 =?utf-8?B?eTJ5ZzZrTkJmZlVvWlBacVVEbnN1Yi9wY3VCcnNJZ0tpc2NFMmJCeTFvZkJM?=
 =?utf-8?B?UUMyS0RHa2RKMG16cFBndE1FdDdwS3krYW1EVEV6VVdLM3VBZ1hOTDRNWS9h?=
 =?utf-8?B?Rk40ZVRQb0JHdFg2MjRmd0tXRUgxaXdnZmhJcW0wQWVFRVZBem9FYXRZRERI?=
 =?utf-8?B?bGwwSjdBeExDbHNZa2w3eGFvS0M2REZ6RVZWVlBweWNFcHdFVWplLytrbmRn?=
 =?utf-8?B?OFhxTGJWOGR2UkpGS3d6RXRYckFWK2pMWkRiZUpLa2xzRTVrS1gzemdBYW02?=
 =?utf-8?B?WWs0Y01Zd3pPN1lDcDlmUkV2Sys0Z3hyVUcwelJ1djRvQWxyOXNGVkdjUE5D?=
 =?utf-8?B?UERKV1NpMHluc0U3UHJlOEJGcXIwbW1BNnhVUjExY1FTMlBkTW9kSE1SRFZM?=
 =?utf-8?B?MG1EVjUyTlBhbURUcjJLWS9hSWMxOGYwOVY2M2syM2RZeElxNEUxeWxuVFk2?=
 =?utf-8?B?cTFOWk9RUndlcE1jVkwzZldYN1JsNG95Q1V2eUMwSjgzTWhGOFdYWTFrS2R6?=
 =?utf-8?B?RU5MTWtUS24rTXBrc20zcUZFYnlBQnFlUGEvUmpXUDJCV0tCZGdDcHhrZWM5?=
 =?utf-8?B?cDBMUW00NWZhOXgwQklKQUZDM2prcUREbGtBNUExQ0lYY0ZaUUdvU3ZZcmZz?=
 =?utf-8?B?TDNVbDFzWUM0YXJicWVvTktmZDVoUFhkQU9KRHhBR2gwK2tBQTJYRXdVU1hE?=
 =?utf-8?B?R1FUSG1WSmVUdzNoSEJLbE05byt1M3FodkdKSE5aSE5zZVNsdzJ6OGV4cWcy?=
 =?utf-8?B?b1VOSDhRZFFCZmo2dFo5a0JxdE5nd3F1aWs3VVR5N2hSTjVWNjRuTk5jK0V5?=
 =?utf-8?B?VkZLbmxUbWlNSEoxRXJqR0t4VXpHamJ2SkIrNHlKUnRNV1JCTW9zUFFlcUlq?=
 =?utf-8?B?bFNEYzZrZXVmWStJWGg3UTJLRmhlYWtPaUxOcUFwd2J3UWN4NDBrVnJEUTIw?=
 =?utf-8?B?bWptL08yOGdoWGdBWjFKWE9LNXhRMzVtYW9vckE1UFJaamtUZTBJSDA3SkFl?=
 =?utf-8?B?dTA2WldNbDZHdFIrSmIxUXdHRzdBaFo1eUxibTMrWGlpeU1WYWxaSGpIOSt0?=
 =?utf-8?B?Z0JDOHJpZG1rRGJIbHZVaTI4LzJIT0QvaDlnMjgzR21yd1Q0TmlhWlFCYks4?=
 =?utf-8?B?NjlzQUNkODhjampJckV5bUtadFA4NU0wNzR5STdQUVdwVkpRZm54bnBGWGJP?=
 =?utf-8?B?R2l3UVlwYUhRb0VxWTJ5MEdZM0daZ3UwSXhUOXpTZllvK0N4c281TnhDVmNj?=
 =?utf-8?B?RG50RWo4eEd1RElsUjVtSGdIb1RvNHY5TnoxR3lMeFhROTQzbmV2MjZWd0pE?=
 =?utf-8?B?NndFMktuNklwV0o5VmFZSW9Nb01sSk1NMVd2V2dseTBqOEFrSloxeGlaamZJ?=
 =?utf-8?B?cUJENWE1L1IyZ09naHJwaU1ncEg2Q2RnbzhMUi9DbEhHZlVqQzYzV2NuSC81?=
 =?utf-8?B?U0ZyWEVWejFFaDloUlpqOE5zQ3ZnR2NPclNKWUtZRkN0RTdTak9vaURPOWpa?=
 =?utf-8?B?VmR3WEh0UWFtZXZWOUJkWSt0VDBVemp5ZTlWZlZOenBMdjFWcHJteWZZMTBn?=
 =?utf-8?B?T1BrSGhoZUhoS1FMRHZUMXdpRDJ2ZmJRRmticFB6WmtjMVVOVWxSZE1ucjcy?=
 =?utf-8?B?Um1kMHNDRTRKY2xJN01nVVNZeExhZXVZeUpseGcveCtISVROSGRrYzNQWFNP?=
 =?utf-8?B?VTBKVDNmcFlJV2hqTTlaMWpSMFVOcCtXTFNIUFExbXd1SXV3bmlrcVFPMGJj?=
 =?utf-8?B?bytKWkpiZHpaWUpmcnNWRzljeFZhZWQvQmxLRU5IMThrNlNKU3c1L3JHcGhm?=
 =?utf-8?B?RmwzWlRKSzFwTTRhYW14bGFRY2FaYTdsQ3p0MlFMSW9VSFNuZHNXUEpzRVNF?=
 =?utf-8?B?TEtPZitGSnlFOWl6NlhSYVA2N3IvcTcyZ0E2TW1kaXpvcnh5dkR2YTZsa01s?=
 =?utf-8?Q?6+W+1iJRyM6GUmXVHURNDrn+1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392fd4b7-5b73-40f1-62a9-08dc20cbf0ef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 13:12:27.4961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLDDj74CSMEKjgnrg8sfpEbGoYi1bHS4+R5anCwno6YJGEbVIc7DprFdK+Z0ph5z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5434

Am 29.01.24 um 11:31 schrieb Julia Zhang:
> As vram objects don't have backing pages and thus can't implement
> drm_gem_object_funcs.get_sg_table callback. This removes drm dma-buf
> callbacks in virtgpu_gem_map_dma_buf()/virtgpu_gem_unmap_dma_buf()
> and implement virtgpu specific map/unmap/attach callbacks to support
> both of shmem objects and vram objects.
>
> Signed-off-by: Julia Zhang <julia.zhang@amd.com>

I need to find more time to look into the code, but of hand I would say 
that this is the correct solution.

Regards,
Christian.

> ---
>   drivers/gpu/drm/virtio/virtgpu_prime.c | 40 +++++++++++++++++++++++---
>   1 file changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> index 44425f20d91a..b490a5343b06 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> @@ -49,11 +49,26 @@ virtgpu_gem_map_dma_buf(struct dma_buf_attachment *attach,
>   {
>   	struct drm_gem_object *obj = attach->dmabuf->priv;
>   	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> +	struct sg_table *sgt;
> +	int ret;
>   
>   	if (virtio_gpu_is_vram(bo))
>   		return virtio_gpu_vram_map_dma_buf(bo, attach->dev, dir);
>   
> -	return drm_gem_map_dma_buf(attach, dir);
> +	sgt = drm_prime_pages_to_sg(obj->dev,
> +				    to_drm_gem_shmem_obj(obj)->pages,
> +				    obj->size >> PAGE_SHIFT);
> +	if (IS_ERR(sgt))
> +		return sgt;
> +
> +	ret = dma_map_sgtable(attach->dev, sgt, dir, DMA_ATTR_SKIP_CPU_SYNC);
> +	if (ret) {
> +		sg_free_table(sgt);
> +		kfree(sgt);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return sgt;
>   }
>   
>   static void virtgpu_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
> @@ -63,12 +78,29 @@ static void virtgpu_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
>   	struct drm_gem_object *obj = attach->dmabuf->priv;
>   	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
>   
> +	if (!sgt)
> +		return;
> +
>   	if (virtio_gpu_is_vram(bo)) {
>   		virtio_gpu_vram_unmap_dma_buf(attach->dev, sgt, dir);
> -		return;
> +	} else {
> +		dma_unmap_sgtable(attach->dev, sgt, dir, DMA_ATTR_SKIP_CPU_SYNC);
> +		sg_free_table(sgt);
> +		kfree(sgt);
>   	}
> +}
> +
> +static int virtgpu_gem_device_attach(struct dma_buf *dma_buf,
> +				     struct dma_buf_attachment *attach)
> +{
> +	struct drm_gem_object *obj = attach->dmabuf->priv;
> +	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> +	int ret = 0;
> +
> +	if (!virtio_gpu_is_vram(bo) && obj->funcs->pin)
> +		ret = obj->funcs->pin(obj);
>   
> -	drm_gem_unmap_dma_buf(attach, sgt, dir);
> +	return ret;
>   }
>   
>   static const struct virtio_dma_buf_ops virtgpu_dmabuf_ops =  {
> @@ -83,7 +115,7 @@ static const struct virtio_dma_buf_ops virtgpu_dmabuf_ops =  {
>   		.vmap = drm_gem_dmabuf_vmap,
>   		.vunmap = drm_gem_dmabuf_vunmap,
>   	},
> -	.device_attach = drm_gem_map_attach,
> +	.device_attach = virtgpu_gem_device_attach,
>   	.get_uuid = virtgpu_virtio_get_uuid,
>   };
>   


