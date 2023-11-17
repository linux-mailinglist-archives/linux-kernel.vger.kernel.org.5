Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3947EFC4F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 00:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346341AbjKQX4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 18:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKQX4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 18:56:45 -0500
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24CA85;
        Fri, 17 Nov 2023 15:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1700265396;
 bh=Akxh1pCwlwZ2/Alq/eq4OWlp6spZ3DqWnVV7jZPqbRo=;
 b=EnxzJ/D0fi2l0fTuqex8iMkg1Uw70Q46mrOe05ZjsoSOA6SrJqB4FfqkXlRUNSn+DORfWMLKU
 0LyzYMX23N4VFwkt16pBt/RjCCtQFhXMnRUUfkC4MDK5YvF/Sck9FYojZUIkDifuxmtx/pWH/cP
 Y45DGQTXe10erHcCO3Xf139isV6m3zo6650XwOkPXCg9V6leFICG7r1ZX78C3jy4qkWUtf+ofEB
 fo9VnjqHib6GqEyCBFsYHOhaYl7WVAZyPuTgmJQJ4n/40+0VcHvLFi3962qR/fhNVRHLq8mv3yB
 y+Ljy4tKoYk9hxNvLy2kXgWjZzS6RlT1/C1oeqVP/rlQ==
Message-ID: <37348be2-c7c4-4eb6-8dd0-e6b18923a88e@kwiboo.se>
Date:   Sat, 18 Nov 2023 00:46:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] drm/rockchip: vop2: Add support for rk3588
Content-Language: en-US
To:     Andy Yan <andyshrk@163.com>, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, s.hauer@pengutronix.de,
        chris.obbard@collabora.com, hjc@rock-chips.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Andy Yan <andy.yan@rock-chips.com>,
        sebastian.reichel@collabora.com
References: <20231114112534.1770731-1-andyshrk@163.com>
 <20231114112855.1771372-1-andyshrk@163.com>
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20231114112855.1771372-1-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6557fb469b02fe711135f205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-14 12:28, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> VOP2 on rk3588:
> 
> Four video ports:
> VP0 Max 4096x2160
> VP1 Max 4096x2160
> VP2 Max 4096x2160
> VP3 Max 2048x1080
> 
> 4 4K Cluster windows with AFBC/line RGB and AFBC-only YUV support
> 4 4K Esmart windows with line RGB/YUV support
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 324 ++++++++++++++++++-
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  57 ++++
>  drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 215 ++++++++++++
>  include/dt-bindings/soc/rockchip,vop2.h      |   4 +
>  4 files changed, 593 insertions(+), 7 deletions(-)
> 

[...]

> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> index 22288ad7f326..4745a9260cf8 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> @@ -34,6 +34,28 @@ static const uint32_t formats_cluster[] = {
>  	DRM_FORMAT_Y210, /* yuv422_10bit non-Linear mode only */
>  };
>  
> +static const uint32_t formats_esmart[] = {
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_ABGR8888,
> +	DRM_FORMAT_RGB888,
> +	DRM_FORMAT_BGR888,
> +	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_BGR565,
> +	DRM_FORMAT_NV12, /* yuv420_8bit linear mode, 2 plane */
> +	DRM_FORMAT_NV21, /* yvu420_8bit linear mode, 2 plane */
> +	DRM_FORMAT_NV16, /* yuv422_8bit linear mode, 2 plane */
> +	DRM_FORMAT_NV61, /* yvu422_8bit linear mode, 2 plane */
> +	DRM_FORMAT_NV24, /* yuv444_8bit linear mode, 2 plane */
> +	DRM_FORMAT_NV42, /* yvu444_8bit linear mode, 2 plane */
> +	DRM_FORMAT_NV15, /* yuv420_10bit linear mode, 2 plane, no padding */

NV20 and NV30 drm format have now been merged into mainline linux,
please add these missing formats. The patch below adds support for them
to rk356x part of vop2 driver.

drm/rockchip: vop2: Add NV20 and NV30 support
https://lore.kernel.org/linux-rockchip/20231025213248.2641962-1-jonas@kwiboo.se/

NV15/NV20/NV30 formats can be tested using modetest from latest main
of libdrm.

modetest: add support for DRM_FORMAT_NV{15,20,30}
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/329

Regards,
Jonas

> +	DRM_FORMAT_YVYU, /* yuv422_8bit[YVYU] linear mode */
> +	DRM_FORMAT_VYUY, /* yuv422_8bit[VYUY] linear mode */
> +	DRM_FORMAT_YUYV, /* yuv422_8bit[YUYV] linear mode */
> +	DRM_FORMAT_UYVY, /* yuv422_8bit[UYVY] linear mode */
> +};
> +
>  static const uint32_t formats_rk356x_esmart[] = {
>  	DRM_FORMAT_XRGB8888,
>  	DRM_FORMAT_ARGB8888,

[...]
