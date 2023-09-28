Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FCD7B1AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjI1L0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjI1L01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:26:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44B01719;
        Thu, 28 Sep 2023 04:24:51 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 37EE76607336;
        Thu, 28 Sep 2023 12:24:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695900290;
        bh=W/205ZyIxCbiuSv0AgUlUg37VTFSi/1Fl14e/tpAOfY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gl3T4VSuuRiG/ynLxxA6IrAqaxfor42cWWcEVcvxZ3Yzu8t8onfQBM9hCu3VUp7Yc
         jWnPguYyzroEvrqkt/W2hgdw9lO+z7BqAeO4CPrxXIdo1y+oWrrpLPtyZI65Qs8yry
         hWzhdGK0SItMY1QvUk74lxc/SNu3NtrLy2TLZtJHfpM64iqxMlAHP6J9I6dHfRsq3U
         8+HnL51zlcvYJGjBatZLZK/QaQlwEeUMFNMQTTnThN1nOagYM2W92XNBL41yk835Kf
         zmzAaGSLuFu+bh7lje0KVVpREbFQar+xPs0h6ClDtYTfWfzRaNujx5LHnlH7lM82jw
         hn7kLc+HQ9yXQ==
Message-ID: <64367e0c-6ec9-8dfa-ab9c-51b530247f74@collabora.com>
Date:   Thu, 28 Sep 2023 13:24:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v7 5/5] drm/panfrost: Implement generic DRM object RSS
 reporting function
Content-Language: en-US
To:     =?UTF-8?Q?Adri=c3=a1n_Larumbe?= <adrian.larumbe@collabora.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        healych@amazon.com, kernel@collabora.com,
        tvrtko.ursulin@linux.intel.com, boris.brezillon@collabora.com
References: <20230927213133.1651169-1-adrian.larumbe@collabora.com>
 <20230927213133.1651169-6-adrian.larumbe@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230927213133.1651169-6-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/09/23 23:29, Adrián Larumbe ha scritto:
> BO's RSS is updated every time new pages are allocated on demand and mapped
> for the object at GPU page fault's IRQ handler, but only for heap buffers.
> The reason this is unnecessary for non-heap buffers is that they are mapped
> onto the GPU's VA space and backed by physical memory in their entirety at
> BO creation time.
> 
> This calculation is unnecessary for imported PRIME objects, since heap
> buffers cannot be exported by our driver, and the actual BO RSS size is the
> one reported in its attached dmabuf structure.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> ---
>   drivers/gpu/drm/panfrost/panfrost_gem.c | 15 +++++++++++++++
>   drivers/gpu/drm/panfrost/panfrost_gem.h |  5 +++++
>   drivers/gpu/drm/panfrost/panfrost_mmu.c |  1 +
>   3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> index 7d8f83d20539..4365434b48db 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -208,6 +208,20 @@ static enum drm_gem_object_status panfrost_gem_status(struct drm_gem_object *obj
>   	return res;
>   }
>   
> +static size_t panfrost_gem_rss(struct drm_gem_object *obj)
> +{
> +	struct panfrost_gem_object *bo = to_panfrost_bo(obj);
> +
> +	if (bo->is_heap) {
> +		return bo->heap_rss_size;
> +	} else if (bo->base.pages) {
> +		WARN_ON(bo->heap_rss_size);
> +		return bo->base.base.size;
> +	} else {
> +		return 0;
> +	}

I would do, instead...

......
	if (bo->is_heap) {
		return bo->heap_rss_size;
	} else if (bo->base.pages) {
		WARN_ON(bo->heap_rss_size);
		return bo->base.base.size;
	}

	return 0;
}

Apart from that,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

