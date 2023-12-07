Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8484A8086C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjLGLbm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Dec 2023 06:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjLGLbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:31:41 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666DDA3;
        Thu,  7 Dec 2023 03:31:46 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9F85524E317;
        Thu,  7 Dec 2023 19:31:44 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 7 Dec
 2023 19:31:44 +0800
Received: from [192.168.60.132] (180.164.60.184) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 7 Dec
 2023 19:31:46 +0800
Message-ID: <580e13ab-a73e-4ce7-999a-8a8685faf2dd@starfivetech.com>
Date:   Thu, 7 Dec 2023 19:31:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 4/6] drm/vs: Add KMS crtc&plane
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "suijingfeng@loongson.cn" <suijingfeng@loongson.cn>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        William Qiu <william.qiu@starfivetech.com>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
References: <20231204123315.28456-1-keith.zhao@starfivetech.com>
 <20231204123315.28456-5-keith.zhao@starfivetech.com>
 <7acd5af8fd4c5bf6ee0614f72cf6cb6751c89dc3.camel@icenowy.me>
From:   Keith Zhao <keith.zhao@starfivetech.com>
In-Reply-To: <7acd5af8fd4c5bf6ee0614f72cf6cb6751c89dc3.camel@icenowy.me>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/7 16:41, Icenowy Zheng wrote:
> 在 2023-12-04星期一的 20:33 +0800，Keith Zhao写道：
> *snip*
> 
>> +static void update_cursor_plane(struct vs_dc *dc, struct vs_plane
>> *plane,
>> +                               struct drm_plane *drm_plane,
>> +                               struct drm_atomic_state *drm_state)
>> +{
>> +       struct drm_plane_state *state =
>> drm_atomic_get_new_plane_state(drm_state,
>> +                                                                    
>>   drm_plane);
>> +       struct vs_plane_state *plane_state =
>> to_vs_plane_state(state);
>> +       struct drm_framebuffer *drm_fb = state->fb;
>> +       struct dc_hw_cursor cursor;
>> +
>> +       cursor.address = plane_state->dma_addr[0];
>> +       cursor.x = state->crtc_x;
>> +       cursor.y = state->crtc_y;
> 
> From my experiments on poking with registers on T-Head TH1520 (also
> uses DC8200 display controller and a similar driver), the DC8200
> hardware have a different definition of cursor position X and Y with
> the CRTC plane state.
> 
> For CRTC plane state, hot_x and hot_y are only provided as reference,
> and the cursor should be displayed with its (0,0) drawn to (crtc_x,
> crtc_y) ([XY]_crtc are values specified in CRTC state, the right part
> of the assignments here), when the cursor is moved to (0,0) but the hot
> point is not (0,0), it could be negative.
> 
> However, for DC8200 registers definition, cursor XY position could not
> be negative -- the cursor will disappear then; because in its
> definition, the cursor XY position should be where the cursor is
> pointing to, instead of its (0,0). DC8200 will draw (0,0) of the cursor
> to (x - hot_x, y - hot_y). So to met the expectation of the KMS plane
> settings, the DC8200 position should be set to (crtc_x + hot_x, crtc_y
> + hot_y) instead. Thus these two lines of code should be:
> 
> ```
>         cursor.x = state->crtc_x + drm_fb->hot_x;
>         cursor.y = state->crtc_y + drm_fb->hot_y;
> ```
> 
> 
>> +       cursor.hot_x = drm_fb->hot_x;
>> +       cursor.hot_y = drm_fb->hot_y;
>> +       cursor.display_id = to_vs_display_id(dc, state->crtc);
>> +       update_cursor_size(state, &cursor);
>> +       cursor.enable = true;
>> +
>> +       dc_hw_update_cursor(&dc->hw, cursor.display_id, &cursor);
>> +}
> *snip
hello Icenowy:
you are deep understanding on dc8200.
by the way of practice
I tested this change on the debian desktop, is there a way to compare the cursor behavior change?
Thanks



