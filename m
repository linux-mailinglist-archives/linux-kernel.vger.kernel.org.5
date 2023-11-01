Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7FC7DE04C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbjKAL2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKAL2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:28:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5016EFD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 04:28:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B45212F4;
        Wed,  1 Nov 2023 04:28:58 -0700 (PDT)
Received: from [10.57.36.242] (unknown [10.57.36.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A03D33F67D;
        Wed,  1 Nov 2023 04:28:14 -0700 (PDT)
Message-ID: <df86a758-e2a3-4848-8ffb-8fe079bdafbe@arm.com>
Date:   Wed, 1 Nov 2023 11:28:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/panfrost: Implement ability to turn on/off GPU
 clocks in suspend
Content-Language: en-GB
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        boris.brezillon@collabora.com
Cc:     robh@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org,
        kernel@collabora.com
References: <20231030132257.85379-1-angelogioacchino.delregno@collabora.com>
 <20231030132257.85379-2-angelogioacchino.delregno@collabora.com>
 <f6b0d965-f386-48ad-80a7-072c81a9e4a8@arm.com>
 <44c81015-26bf-476a-afbd-45b8c6e42d4b@collabora.com>
 <5a73e1fe-e66f-4cb3-87f4-315a4034e8ba@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <5a73e1fe-e66f-4cb3-87f4-315a4034e8ba@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2023 10:33, AngeloGioacchino Del Regno wrote:
<snip>
>> Anyway, as for the GPU_PM_CLK_DIS feature - I feel like being
>> extremely careful
>> with this is still a good idea... thing is, even if we're sure that
>> the GPU itself
>> is fine with us turning off/on clocks (even aggressively), I'm not
>> sure that *all*
>> of the SoCs using Mali GPUs don't have any kind of quirk and for
>> safety I don't
>> want to place any bets.
>>
>> My idea is to add this with feature opt-in - then, if after some time
>> we discover
>> that all SoCs want it and can safely use it, we can simplify the flow
>> by removing
>> the feature bit.

Yeah I agree it's best to start with opt-in that way we can avoid
regressions and focus the changes on platforms where this matters.

> 
> Sorry for the double email - after some analysis and some trials of your
> wait
> solution, I've just seen that... well, panfrost_gpu_power_off() is, and
> has always
> been entirely broken, as in it has never done any poweroff!
> 
> What it does is:
> 
>     gpu_write(pfdev, TILER_PWROFF_LO, 0);
>     gpu_write(pfdev, SHADER_PWROFF_LO, 0);
>     gpu_write(pfdev, L2_PWROFF_LO, 0);
> 
> ...but the {TILER,SHADER,L2}_PWROFF_LO register is a bitmap and in order
> to request
> poweroff of tiler/shader cores and cache we shall flip bits to 1, but
> this is doing
> the *exact opposite* of what it's supposed to do.
> 
> It's doing nothing, at all.

Doh! I'd looked at that function when replying to your email and still
not spotted that it is broken as you point out!

I guess I always get a little distracted by the fact that it's
technically "broken" in two other ways: first only the _LO registers are
used (but equally there are no implementations with > 32 cores so this
doesn't matter) and secondly we shouldn't really trigger the L2 power
off while the tiler/shader are powering down. Although it doesn't matter
here because the L2 power down will coordinate with the tiler and shader
and do the right thing. In reality a single write is sufficient as the
L2 power down will trigger the dependent cores to power down:

	gpu_write(pfdev, L2_PWROFF_LO, pfdev->features.l2_present);

> I've just fixed that locally (running some tests on MT8195 as we speak)
> like so:
> 
> gpu_write(pfdev, TILER_PWROFF_LO, pfdev->features.tiler_present);
> gpu_write(pfdev, SHADER_PWROFF_LO, pfdev->features.shader_present &
> core_mask);
> gpu_write(pfdev, L2_PWROFF_LO, pfdev->features.l2_present & core_mask);

But this should be fine too - as above the L2 transition will just wait.

Please can you include a fix (as a separate patch) for that in your next
posting? I think that should be worthy of a backport.

> ...and now it appears that I can actually manage clocks aggressively
> during runtime
> power management without any side issues.
> 
> Apparently, v2 of this series will have "more juice" than initially
> intended...


Thanks for looking in to this!

Thanks,

Steve

