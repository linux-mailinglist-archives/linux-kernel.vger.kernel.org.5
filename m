Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DE8777769
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjHJLmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjHJLmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:42:31 -0400
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD52C6;
        Thu, 10 Aug 2023 04:42:29 -0700 (PDT)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 10 Aug
 2023 14:42:26 +0300
Received: from [192.168.211.130] (10.0.253.138) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Aug
 2023 14:42:25 +0300
Message-ID: <8a547455-1f5b-f3bf-3fcc-553760940deb@fintech.ru>
Date:   Thu, 10 Aug 2023 04:42:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] video/hdmi: convert *_infoframe_init() functions to void
Content-Language: en-US
To:     Maxime Ripard <mripard@kernel.org>
CC:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Alain Volmat" <alain.volmat@foss.st.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Emma Anholt <emma@anholt.net>, "Helge Deller" <deller@gmx.de>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <intel-gfx@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <amd-gfx@lists.freedesktop.org>, <linux-tegra@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>, <lvc-project@linuxtesting.org>
References: <20230808180245.7474-1-n.zhandarovich@fintech.ru>
 <ibwl2bpz5bs72co4ivkvjcc35lv5mqyuvj2hbr3p54hliujklm@uje662ldqfdw>
From:   Nikita Zhandarovich <n.zhandarovich@fintech.ru>
In-Reply-To: <ibwl2bpz5bs72co4ivkvjcc35lv5mqyuvj2hbr3p54hliujklm@uje662ldqfdw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.0.253.138]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 8/10/23 01:13, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Aug 08, 2023 at 11:02:45AM -0700, Nikita Zhandarovich wrote:
>> Four hdmi_*_infoframe_init() functions that initialize different
>> types of hdmi infoframes only return the default 0 value, contrary to
>> their descriptions. Yet these functions are still unnecessarily checked
>> against possible errors in case of failure.
>>
>> Remove redundant error checks in calls to following functions:
>> - hdmi_spd_infoframe_init
>> - hdmi_audio_infoframe_init
>> - hdmi_vendor_infoframe_init
>> - hdmi_drm_infoframe_init
>> Also, convert these functions to 'void' and fix their descriptions.
> 
> I'm not sure what value it actually adds. None of them return any
> errors, but very well might if we started to be a bit serious about it.
> 
> Since the error handling is already there, then I'd rather leave it
> there.

There is definitely no particular urgency to this change.

Since these functions don't perform anything complex and aren't updated
regularly, my main goal was to remove unnecessary (at the moment) checks
and fix up their somewhat misleading descriptions. Cleaning up, in other
words. But I understand your point of view.

If you don't think this patch is warranted at this point, I totally
understand.

> 
>> Fixes: 2c676f378edb ("[media] hdmi: added unpack and logging functions for InfoFrames")
> 
> I'm confused about that part. What does it fix exactly?
> 
> Maxime

I added the 'Fixes:' tag mostly as a requirement for patch's
description. Once again, it doesn't "fix" anything broken as much as it
cleans up stuff.

Best regards,
Nikita





