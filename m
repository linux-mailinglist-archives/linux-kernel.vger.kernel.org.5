Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D777E7F67
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjKJRxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjKJRwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:52:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 188CD385D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:31:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 892B412FC;
        Fri, 10 Nov 2023 06:32:18 -0800 (PST)
Received: from [10.57.36.221] (unknown [10.57.36.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1A153F7C5;
        Fri, 10 Nov 2023 06:31:31 -0800 (PST)
Message-ID: <4e594d1e-5d9c-45c8-bffb-186615d69312@arm.com>
Date:   Fri, 10 Nov 2023 14:31:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] drm/panfrost: Turn off clocks and regulators in PM
Content-Language: en-GB
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        boris.brezillon@collabora.com
Cc:     robh@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org,
        kernel@collabora.com
References: <20231109102543.42971-1-angelogioacchino.delregno@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20231109102543.42971-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2023 10:25, AngeloGioacchino Del Regno wrote:
> Changes in v3:
>  - Fixed the order of set_opp/opp_put in patch [5/6]
>  - Clearly specified MediaTek SoC models in patches [4/6], [6/6]
>  - Reordered clk_disable() for suspend in patch [3/6]
>  - Fixed blank line removal and alignment in patch [1/6]
> 
> Changes in v2:
>  - Added hard reset GPU recovery
>  - Tightened polling time for soft reset and power on
>  - New execution time measurements after poweroff fix (see [1])
> 
> [1]: https://lore.kernel.org/all/20231102141507.73481-1-angelogioacchino.delregno@collabora.com/
> 
> At least MediaTek platforms are able to get the GPU clocks and regulators
> completely off during system suspend, allowing to save a bit of power.
> 
> Panfrost is used on more than just MediaTek SoCs and the benefits of this
> can be variable across different SoC models and/or different SoCs from
> different manufacturers: this means that just adding this ability for all
> could result in unexpected issues and breakages on untested SoCs.
> 
> For the aforemenetioned reasons, turning off the clocks and/or regulators
> was implemented inside of a capabilities barrier that shall be enabled on
> a per-SoC basis (in the panfrost_compatible platform data) after testing
> of both benefits and feasibility.
> 
> In this series, I am adding the ability to switch on/off clocks and
> regulators and enabling that on all MediaTek platforms, as I was able
> to successfully test that on multiple Chromebooks featuring different
> MediaTek SoCs; specifically, I've manually tested on MT8186, MT8192 and
> MT8195, while MT8183 got tested only by KernelCI.
> 
> Cheers!
> 
> AngeloGioacchino Del Regno (6):
>   drm/panfrost: Perform hard reset to recover GPU if soft reset fails
>   drm/panfrost: Tighten polling for soft reset and power on
>   drm/panfrost: Implement ability to turn on/off GPU clocks in suspend
>   drm/panfrost: Set clocks on/off during system sleep on MediaTek SoCs
>   drm/panfrost: Implement ability to turn on/off regulators in suspend
>   drm/panfrost: Set regulators on/off during system sleep on MediaTek
>     SoCs

Thanks for your work on this! I've pushed these patches (and 'Really
power off GPU cores') to drm-misc-next.

Steve

> 
>  drivers/gpu/drm/panfrost/panfrost_device.c | 78 ++++++++++++++++++++--
>  drivers/gpu/drm/panfrost/panfrost_device.h | 13 ++++
>  drivers/gpu/drm/panfrost/panfrost_drv.c    |  3 +
>  drivers/gpu/drm/panfrost/panfrost_gpu.c    | 21 ++++--
>  drivers/gpu/drm/panfrost/panfrost_regs.h   |  1 +
>  5 files changed, 105 insertions(+), 11 deletions(-)
> 

