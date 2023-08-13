Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1C477A698
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 15:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjHMNlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 09:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjHMNls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 09:41:48 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F371713
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 06:41:47 -0700 (PDT)
Received: from p200300cf17418700333267be2b9ea1d1.dip0.t-ipconnect.de ([2003:cf:1741:8700:3332:67be:2b9e:a1d1]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qVBLY-00073T-2b; Sun, 13 Aug 2023 15:41:32 +0200
Message-ID: <3df95e6d-8237-1c43-e220-a9bdb5d6e044@leemhuis.info>
Date:   Sun, 13 Aug 2023 15:41:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] HDMI connector detection broken in 6.3 on Intel(R)
 Celeron(R) N3060 integrated graphics
Content-Language: en-US, de-DE
To:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        Imre Deak <imre.deak@intel.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <87v8dmr6ty.fsf@gmail.com>
 <f32b4636-969c-3b9e-6802-5991f511739e@leemhuis.info>
 <87il9l2ymf.fsf@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <87il9l2ymf.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691934107;1aceff32;
X-HE-SMSGID: 1qVBLY-00073T-2b
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.23 20:10, Mikhail Rudenko wrote:
> On 2023-08-11 at 08:45 +02, Thorsten Leemhuis <regressions@leemhuis.info> wrote:
>> On 10.08.23 21:33, Mikhail Rudenko wrote:
>>> The following is a copy an issue I posted to drm/i915 gitlab [1] two
>>> months ago. I repost it to the mailing lists in hope that it will help
>>> the right people pay attention to it.
>>
>> Thx for your report. Wonder why Dmitry (who authored a4e771729a51) or
>> Thomas (who committed it) it didn't look into this, but maybe the i915
>> devs didn't forward the report to them.

For the record: they did, and Jani mentioned already. Sorry, should have
phrased this differently.

>> Let's see if these mails help. Just wondering: does reverting
>> a4e771729a51 from 6.5-rc5 or drm-tip help as well?
> 
> I've redone my tests with 6.5-rc5, and here are the results:
> (1) 6.5-rc5 -> still affected
> (2) 6.5-rc5 + revert a4e771729a51 -> not affected
> (3) 6.5-rc5 + two patches [1][2] suggested on i915 gitlab by @ideak -> not affected (!)
> 
> Should we somehow tell regzbot about (3)?

That's good to know, thx. But the more important things are:

* When will those be merged? They are not yet in next yet afaics, so it
might take some time to mainline them, especially at this point of the
devel cycle. Imre, could you try to prod the right people so that these
are ideally upstreamed rather sooner than later, as they fix a regression?
* They if possible ideally should be tagged for backporting to 6.4, as
this is a regression from the 6.3 cycle.

But yes, let's tell regzbot that fixes are available, too:

#regzbot fix: drm/i915: Fix HPD polling, reenabling the output poll work
as needed

(for the record: that's the second of two patches apparently needed)

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

>> BTW, there was an earlier report about a problem with a4e771729a51 that
>> afaics was never addressed, but it might be unrelated.
>> https://lore.kernel.org/all/20230328023129.3596968-1-zhouzongmin@kylinos.cn/
> [1] https://patchwork.freedesktop.org/patch/548590/?series=121050&rev=1
> [2] https://patchwork.freedesktop.org/patch/548591/?series=121050&rev=1

