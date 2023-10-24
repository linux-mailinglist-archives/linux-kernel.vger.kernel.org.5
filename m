Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1037D590F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbjJXQpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344008AbjJXQpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:45:36 -0400
X-Greylist: delayed 605 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Oct 2023 09:45:33 PDT
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661E0DA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1698165931;
 bh=k21LPgbaXuVTMNzlRaDriqzC8GcqWDmt35DfR5fv1k8=;
 b=Zj7d2prE8w9UZwqGs0Ga2Vo0Lsdlfrsvqglxv10X2xgd3bWrvOsim7HXVlPPtKfrSL4VhTkaA
 fB7i6yK2Auqz6Y9Z5hRH4dNPq330VNf7M3SuctVKRiu0rOWx1ggX/qcIHl4NS8+kMynf0X30uNP
 Z+eONfJAUCvIrgaY+JW74w5HM/yNxYIpgyvCyu/d/SMePaUZtINzentxcBgW2Sz2jrPGMPHqKPA
 3g4EH7hMnBe2cUdkMtyZPX3lXaFajoPP/S/3ryN8D6tbYpLK8Nco/zDCcA0ad9GRtpMBrb7URJC
 wnsMxaF4nKPqMuxODV5XP9HgvluauFN0r71gIpQVTmBg==
Message-ID: <fef3c504-aa69-4575-abb0-15e6ded67858@kwiboo.se>
Date:   Tue, 24 Oct 2023 18:35:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/rockchip: vop: Fix color for RGB888/BGR888 format on
 VOP full
Content-Language: en-US
To:     Andy Yan <andy.yan@rock-chips.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
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
 <107e7a80-ace1-441d-89c9-44e6465fefbd@rock-chips.com>
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <107e7a80-ace1-441d-89c9-44e6465fefbd@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6537f2474f8c8c0dd69aa635
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-24 14:41, Andy Yan wrote:
> Hi:
> 
> On 10/24/23 16:49, Christopher Obbard wrote:
>> Hi Jonas,
>>
>> On Mon, 2023-10-23 at 21:11 +0000, Jonas Karlman wrote:
>>> Use of DRM_FORMAT_RGB888 and DRM_FORMAT_BGR888 on e.g. RK3288, RK3328
>>> and RK3399 result in wrong colors being displayed.
>>>
>>> The issue can be observed using modetest:
>>>
>>>    modetest -s <connector_id>@<crtc_id>:1920x1080-60@RG24
>>>    modetest -s <connector_id>@<crtc_id>:1920x1080-60@BG24
>>>
>>> Vendor 4.4 kernel apply an inverted rb swap for these formats on VOP
>>> full (major = 3).
>>>
>>> Fix colors by applying rb swap similar to vendor 4.4 kernel.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> How about a fixes tag? Seems like this was introduced in commit 85a359f25388
>> ("drm/rockchip: Add BGR formats to VOP")

That commit added BGR888 format, the RGB888 format goes back to from
when driver was initially added. This patch depend on a macro that was
introduced later, in commit eb5cb6aa9a72 ("drm/rockchip: vop: add a
series of vop support"). Still think commit 85a359f25388 is best commit
to use in a fixes tag.

Will include a fixes tag for 85a359f25388 in v2.

>>
>>> ---
>>>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 9 ++++++---
>>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>> b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>> index b3d0b6ae9294..a1ce09a22f83 100644
>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>> @@ -247,14 +247,17 @@ static inline void vop_cfg_done(struct vop *vop)
>>>   	VOP_REG_SET(vop, common, cfg_done, 1);
>>>   }
>>>   
>>> -static bool has_rb_swapped(uint32_t format)
>>> +static bool has_rb_swapped(uint32_t version, uint32_t format)
>>>   {
>>>   	switch (format) {
>>>   	case DRM_FORMAT_XBGR8888:
>>>   	case DRM_FORMAT_ABGR8888:
>>> -	case DRM_FORMAT_BGR888:
>>>   	case DRM_FORMAT_BGR565:
>>>   		return true;
>>> +	case DRM_FORMAT_RGB888:
>>> +		return VOP_MAJOR(version) == 3;
>>> +	case DRM_FORMAT_BGR888:
>>> +		return VOP_MAJOR(version) != 3;
>> The hardcoded bits are quite scary as it applies to all hardware variants ;-).
>> Is it worth adding an inline comment to describe what is going on and how it
>> relates to VOPL and VOPH? Or would it be even better to add this as a quirk in
>> the various vop_data structs?
> 

I will add a comment in v2.

It would be a quirk that apply for all VOP full framework, IP version 3.x,
SoCs so checking VOP_MAJOR seem like a good option.

See commit eb5cb6aa9a72 ("drm/rockchip: vop: add a series of vop support")
for a list of SoCs that use VOP full framework:

  Vop Full framework now has following vops:
  IP version    chipname
    3.1           rk3288
    3.2           rk3368
    3.4           rk3366
    3.5           rk3399 big
    3.6           rk3399 lit
    3.7           rk3228
    3.8           rk3328

  major version: used for IP structure, Vop full framework is 3,
                 vop little framework is 2.

There are currently three struct vop_data that is missing version declaration:

- rk3036_vop should use VOP_VERSION(2, 2)
- rk3126_vop should use VOP_VERSION(2, 4)
- rk3188_vop guessing is 2.0/2.1 (same/similar as rk3066)

Since none of them are 3.x / VOP full framework, this patch should only
fix/change behavior for affected 3.x / VOP full framework SoCs.

Regards,
Jonas

> 
> Every vop hardware has a version(including VOPB/VOPL), so I think use 
> VOP_MAJOR to distinguish is ok. Of course it's better
> 
> to add some comments. As for adding some quirk in vop_data, I have the 
> idea of adding a table to describe the drm format and it's (rb/uv swap, 
> afbc)
> 
> capability, but I think this is can be done in the future.
> 
>>
>>
>> Cheers!
>>
>> Chris
>>
>>>   	default:
>>>   		return false;
>>>   	}
>>> @@ -1035,7 +1038,7 @@ static void vop_plane_atomic_update(struct drm_plane
>>> *plane,
>>>   	VOP_WIN_SET(vop, win, dsp_info, dsp_info);
>>>   	VOP_WIN_SET(vop, win, dsp_st, dsp_st);
>>>   
>>> -	rb_swap = has_rb_swapped(fb->format->format);
>>> +	rb_swap = has_rb_swapped(vop->data->version, fb->format->format);
>>>   	VOP_WIN_SET(vop, win, rb_swap, rb_swap);
>>>   
>>>   	/*

