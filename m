Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E057E5A5F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjKHPpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjKHPpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:45:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBF9E1FEE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:45:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4E531476;
        Wed,  8 Nov 2023 07:45:49 -0800 (PST)
Received: from [10.1.36.61] (e122027.cambridge.arm.com [10.1.36.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 239E93F7C5;
        Wed,  8 Nov 2023 07:45:02 -0800 (PST)
Message-ID: <2a8ef3de-713f-4855-b7c9-1034ba19da35@arm.com>
Date:   Wed, 8 Nov 2023 15:45:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] drm/panfrost: Set regulators on/off during system
 sleep on MediaTek SoCs
Content-Language: en-GB
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        boris.brezillon@collabora.com
Cc:     robh@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org,
        kernel@collabora.com
References: <20231102142643.75288-1-angelogioacchino.delregno@collabora.com>
 <20231102142643.75288-7-angelogioacchino.delregno@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20231102142643.75288-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2023 14:26, AngeloGioacchino Del Regno wrote:
> All of the MediaTek SoCs supported by Panfrost can completely cut power
> to the GPU during full system sleep without any user-noticeable delay
> in the resume operation, as shown by measurements taken on multiple
> MediaTek SoCs.
> 
> As an example, for MT8195 - a "before" with only runtime PM operations
> (so, without turning on/off regulators), and an "after" executing both
> the system sleep .resume() handler and .runtime_resume() (so the time
> refers to T_Resume + T_Runtime_Resume):
> 
> Average Panfrost-only system sleep resume time, before: ~33500ns
> Average Panfrost-only system sleep resume time, after:  ~336200ns
> 
> Keep in mind that this additional ~308200 nanoseconds delay happens only
> in resume from a full system suspend, and not in runtime PM operations,
> hence it is acceptable.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

As with patch 4, please can you confirm which SoCs you've tested and
what level of testing. I'm more interested in the correctness (i.e. not
hanging) rather than performance because as you point out it's only the
full system suspend path that takes the performance hit.

Steve

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 82f3c5fe9c58..f63382d9ab04 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -734,7 +734,7 @@ static const struct panfrost_compatible mediatek_mt8183_b_data = {
>  	.supply_names = mediatek_mt8183_b_supplies,
>  	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
>  	.pm_domain_names = mediatek_mt8183_pm_domains,
> -	.pm_features = BIT(GPU_PM_CLK_DIS),
> +	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
>  };
>  
>  static const char * const mediatek_mt8186_pm_domains[] = { "core0", "core1" };
> @@ -743,7 +743,7 @@ static const struct panfrost_compatible mediatek_mt8186_data = {
>  	.supply_names = mediatek_mt8183_b_supplies,
>  	.num_pm_domains = ARRAY_SIZE(mediatek_mt8186_pm_domains),
>  	.pm_domain_names = mediatek_mt8186_pm_domains,
> -	.pm_features = BIT(GPU_PM_CLK_DIS),
> +	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
>  };
>  
>  static const char * const mediatek_mt8192_supplies[] = { "mali", NULL };
> @@ -754,7 +754,7 @@ static const struct panfrost_compatible mediatek_mt8192_data = {
>  	.supply_names = mediatek_mt8192_supplies,
>  	.num_pm_domains = ARRAY_SIZE(mediatek_mt8192_pm_domains),
>  	.pm_domain_names = mediatek_mt8192_pm_domains,
> -	.pm_features = BIT(GPU_PM_CLK_DIS),
> +	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
>  };
>  
>  static const struct of_device_id dt_match[] = {

