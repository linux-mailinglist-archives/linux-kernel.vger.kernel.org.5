Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A56A7D5039
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjJXMuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjJXMuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:50:05 -0400
X-Greylist: delayed 404 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Oct 2023 05:50:00 PDT
Received: from mail-m49203.qiye.163.com (mail-m49203.qiye.163.com [45.254.49.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8790B9B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:50:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha256;
        b=UHrTmeSHrqpiHdcOamHgQaAJb2h9+KyyQVQcQn0b7Mx7zc67kwERIw6q4Y2mpseJxNjoieASmXauE3B3S9w8reaBx0TJTIB0TAICu6Jwi0HcfvF5xZJnlUemBFeN9tyY64QXiqdm05KP7jmVV8btJKa/hZB4gNGCqEqQ25rQpAY=;
        s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
        bh=BeGKd1zRDgUMe8T8OLiWdtvhv6/lo9wdPYUqunmKOOM=;
        h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.141] (unknown [58.22.7.114])
        by mail-m12779.qiye.163.com (Hmail) with ESMTPA id 954C878024B;
        Tue, 24 Oct 2023 20:41:33 +0800 (CST)
Message-ID: <107e7a80-ace1-441d-89c9-44e6465fefbd@rock-chips.com>
Date:   Tue, 24 Oct 2023 20:41:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/rockchip: vop: Fix color for RGB888/BGR888 format on
 VOP full
Content-Language: en-US
To:     Christopher Obbard <chris.obbard@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel <kernel@collabora.com>
References: <20231023211158.424489-1-jonas@kwiboo.se>
 <a505d18044ccef9f188df91bc2afe73e6a15635f.camel@collabora.com>
From:   Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <a505d18044ccef9f188df91bc2afe73e6a15635f.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkMfSVZISkMZGEkeQxodTR1VEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
        tLWQY+
X-HM-Tid: 0a8b61b4639cb24fkuuu954c878024b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PT46Kio4CTwwVj0xGBA3IjAe
        OTpPChJVSlVKTUJDSk5KSUJPT0tKVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
        WUFZTkNVSUlVTFVKSk9ZV1kIAVlBT0NOQjcG
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

On 10/24/23 16:49, Christopher Obbard wrote:
> Hi Jonas,
>
> On Mon, 2023-10-23 at 21:11 +0000, Jonas Karlman wrote:
>> Use of DRM_FORMAT_RGB888 and DRM_FORMAT_BGR888 on e.g. RK3288, RK3328
>> and RK3399 result in wrong colors being displayed.
>>
>> The issue can be observed using modetest:
>>
>>    modetest -s <connector_id>@<crtc_id>:1920x1080-60@RG24
>>    modetest -s <connector_id>@<crtc_id>:1920x1080-60@BG24
>>
>> Vendor 4.4 kernel apply an inverted rb swap for these formats on VOP
>> full (major = 3).
>>
>> Fix colors by applying rb swap similar to vendor 4.4 kernel.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> How about a fixes tag? Seems like this was introduced in commit 85a359f25388
> ("drm/rockchip: Add BGR formats to VOP")
>
>> ---
>>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> index b3d0b6ae9294..a1ce09a22f83 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> @@ -247,14 +247,17 @@ static inline void vop_cfg_done(struct vop *vop)
>>   	VOP_REG_SET(vop, common, cfg_done, 1);
>>   }
>>   
>> -static bool has_rb_swapped(uint32_t format)
>> +static bool has_rb_swapped(uint32_t version, uint32_t format)
>>   {
>>   	switch (format) {
>>   	case DRM_FORMAT_XBGR8888:
>>   	case DRM_FORMAT_ABGR8888:
>> -	case DRM_FORMAT_BGR888:
>>   	case DRM_FORMAT_BGR565:
>>   		return true;
>> +	case DRM_FORMAT_RGB888:
>> +		return VOP_MAJOR(version) == 3;
>> +	case DRM_FORMAT_BGR888:
>> +		return VOP_MAJOR(version) != 3;
> The hardcoded bits are quite scary as it applies to all hardware variants ;-).
> Is it worth adding an inline comment to describe what is going on and how it
> relates to VOPL and VOPH? Or would it be even better to add this as a quirk in
> the various vop_data structs?


Every vop hardware has a version(including VOPB/VOPL), so I think use 
VOP_MAJOR to distinguish is ok. Of course it's better

to add some comments. As for adding some quirk in vop_data, I have the 
idea of adding a table to describe the drm format and it's (rb/uv swap, 
afbc)

capability, but I think this is can be done in the future.

>
>
> Cheers!
>
> Chris
>
>>   	default:
>>   		return false;
>>   	}
>> @@ -1035,7 +1038,7 @@ static void vop_plane_atomic_update(struct drm_plane
>> *plane,
>>   	VOP_WIN_SET(vop, win, dsp_info, dsp_info);
>>   	VOP_WIN_SET(vop, win, dsp_st, dsp_st);
>>   
>> -	rb_swap = has_rb_swapped(fb->format->format);
>> +	rb_swap = has_rb_swapped(vop->data->version, fb->format->format);
>>   	VOP_WIN_SET(vop, win, rb_swap, rb_swap);
>>   
>>   	/*
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
