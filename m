Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C577F068F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjKSNtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSNtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:49:00 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4459AD8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 05:48:57 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r4iAQ-0000jH-0q; Sun, 19 Nov 2023 14:48:54 +0100
Message-ID: <9195ca1f-1d72-4616-8bdf-62f9f5c636b9@leemhuis.info>
Date:   Sun, 19 Nov 2023 14:48:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Radeon regression in 6.6 kernel
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Phillip Susi <phill@thesusis.net>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux AMDGPU <amd-gfx@lists.freedesktop.org>
References: <87edgv4x3i.fsf@vps.thesusis.net>
 <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <ZVoMklvIVClr_IIH@archie.me>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZVoMklvIVClr_IIH@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700401737;7e7189c3;
X-HE-SMSGID: 1r4iAQ-0000jH-0q
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.23 14:24, Bagas Sanjaya wrote:
> On Sun, Nov 19, 2023 at 04:47:01PM +1000, Dave Airlie wrote:
>>> On 12.11.23 01:46, Phillip Susi wrote:
>>>> I had been testing some things on a post 6.6-rc5 kernel for a week or
>>>> two and then when I pulled to a post 6.6 release kernel, I found that
>>>> system suspend was broken.  It seems that the radeon driver failed to
>>>> suspend, leaving the display dead, the wayland display server hung, and
>>>> the system still running.  I have been trying to bisect it for the last
>>>> few days and have only been able to narrow it down to the following 3
>>>> commits:
>>>>
>>>> There are only 'skip'ped commits left to test.
>>>> The first bad commit could be any of:
>>>> 56e449603f0ac580700621a356d35d5716a62ce5
>>>> c07bf1636f0005f9eb7956404490672286ea59d3
>>>> b70438004a14f4d0f9890b3297cd66248728546c
>>>> We cannot bisect more!
>>>
>>> Hmm, not a single reply from the amdgpu folks. Wondering how we can
>>> encourage them to look into this.
>>>
>>> Phillip, reporting issues by mail should still work, but you might have
>>> more luck here, as that's where the amdgpu afaics prefer to track bugs:
>>> https://gitlab.freedesktop.org/drm/amd/-/issues
>>>
>>> When you file an issue there, please mention it here.
>>>
>>> Furthermore it might help if you could verify if 6.7-rc1 (or rc2, which
>>> comes out later today) or 6.6.2-rc1 improve things.

BTW, ignore the "6.6.2-rc1" here, I misunderstood one detail earlier. Sorry.

>> It would also be good to test if reverting any of these is possible or not.

Good point, sorry, forgot to mention that.

> Hi Dave,
> 
> AFAIK commit c07bf1636f0005 ("MAINTAINERS: Update the GPU Scheduler email")
> doesn't seem to do with this regression as it doesn't change any amdgpu code
> that may introduce the regression.

Bagas, sorry for being blunt here, I know you mean well. But I feel the
need to say the following in the open, as this otherwise falls back on
me and regression tracking.

Stating the above is not very helpful, as Dave for sure will know.
Telling Phillip that he likely can skip that commit might have been
something different. But I guess even for most users that are able to do
a bisection it's obvious and maybe not worth pointing out.

Ciao, Thorsten
