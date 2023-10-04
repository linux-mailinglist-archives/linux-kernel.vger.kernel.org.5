Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E457B8544
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243316AbjJDQ3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjJDQ3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:29:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B661BF;
        Wed,  4 Oct 2023 09:29:46 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1793966003B0;
        Wed,  4 Oct 2023 17:29:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696436984;
        bh=eY3J6B+d3OqRFON8pdfHkkKrg0jpP3yRtk7Fqx4owG0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PnTZ8o7+tYlOzZFUqUMVdJWa2t5ikPnSOB9Vdx/fXDEbaeIYvzjGGKqkCZmD4kmv8
         qm/WNio/tTtJsMwBVKjzm0TWZFnxujkDy6ihwvyCnnVvNVk57rdqq+C3uXI5345vDo
         yvPORxxKHBWoBQ0WfBFg0IJa6NW7Sqtj6C9ob6kEiw3FNFwbOnR/Sl2jjeWgoWyHpy
         jQ+HSF1YlbSg4/sJIyUjb2qQknPTJ7pCm6HEQbAFEWlkJtPVq+HkQDqRJ1l0FF2dIr
         QX9U72uLPVApTFgn3AcuWIXlrhkIvvdP7oBIpTTU2wSRu7gzjGHOZ1fhur/5mCiDvE
         OPpZJS99IsPEQ==
Message-ID: <d88b72f1-6a60-dc7d-6922-1dde278a61db@collabora.com>
Date:   Wed, 4 Oct 2023 18:29:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] clk: mediatek: mt8195-topckgen: Refactor parents for
 top_dp/edp muxes
Content-Language: en-US
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Mergnat <amergnat@baylibre.com>, sboyd@kernel.org,
        mturquette@baylibre.com, matthias.bgg@gmail.com, msp@baylibre.com,
        yangyingliang@huawei.com, u.kleine-koenig@pengutronix.de,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230713072138.84117-1-angelogioacchino.delregno@collabora.com>
 <20230713072138.84117-3-angelogioacchino.delregno@collabora.com>
 <9a0817c2-4101-5c21-977d-77ac0d83a067@baylibre.com>
 <CAGXv+5E7YYdkG7GtxG90KzdAG8Kke+74Amtbw4mmyVNZgDZHRA@mail.gmail.com>
 <jv6daj2w3pwjtde3m3m26yg4wyxbbio4zqra5yqc4gb32ri5ub@noinbbkjovwm>
 <25724ee3-858a-01eb-352b-3edbfad31c8e@collabora.com>
 <jxgy2pvns4ri2aj5nmdhb4zbluseuzdejbplh2avwz63df2cfx@grrrdm6ujzi4>
 <24d17b07-1e8d-05f6-46b7-9da1ff1bed7a@collabora.com>
 <hd2ydj33vp3dsri4czx6frxxvir6vxnovc27n6rrgs4qqbtrjz@whhyt2iinq5k>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <hd2ydj33vp3dsri4czx6frxxvir6vxnovc27n6rrgs4qqbtrjz@whhyt2iinq5k>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/07/23 11:03, Maxime Ripard ha scritto:
> On Mon, Jul 17, 2023 at 04:30:48PM +0200, AngeloGioacchino Del Regno wrote:
>>>>>> AFAIK the recommended way to deal with this is to use
>>>>>> clk_set_rate_exclusive() and co. in whatever consumer driver that
>>>>>> needs exclusive control on the clock rate.
>>>>>
>>>>> I guess it works, but it looks to me like the issue here is that the
>>>>> provider should disable it entirely? My expectation for
>>>>> clk_set_rate_exclusive() is that one user needs to lock the clock rate
>>>>> to operate properly.
>>>>>
>>>>> If the provider expectation is that the rate or parent should never
>>>>> changed, then that needs to be dealt with at the provider level, ie
>>>>> through the clk_ops.
>>>>>
>>>>>> However I'm not sure if that works for parents. It should, given the
>>>>>> original use case was for the sunxi platforms, which like the MediaTek
>>>>>> platform here has 2 PLLs for video related consumers, but I couldn't
>>>>>> find code verifying it.
>>>>>
>>>>> If you want to prevent clocks from ever being reparented, you can use
>>>>> the new clk_hw_determine_rate_no_reparent() determine_rate
>>>>> implementation.
>>>>>
>>>>
>>>> We want the clocks to be reparented, as we need them to switch parents as
>>>> explained before... that's more or less how the tree looks:
>>>>
>>>> TVDPLL(x) -> PLL Divider (fixed) -> MUX -> Gate -> Controller
>>>>
>>>> Besides, I think that forcing *one* parent to the dp/edp mux would produce a
>>>> loss of the flexibility that the clock framework provides.
>>>>
>>>> I again want to emphasize on the fact that TVDPLL1 and TVDPLL2 are *identical*
>>>> in specs, and on that there will never be a MT8195 SoC that has only one of
>>>> the two PLLs, for obvious reasons...
>>>>
>>>> P.S.: If you need more context, I'll be glad to answer to any other question!
>>>
>>> Then I have no idea what the question is :)
>>>
>>> What are you trying to achieve / fix, and how can I help you ? :)
>>
>> Chen-Yu, Alexandre had/have questions about if there was any other solution instead
>> of using the solution of *this* commit, so, if there's any other better solution
>> than the one that I've sent as this commit.
>>
>> I'm the one saying that this commit is the best solution :-P
> 
> I went back to the original patch, and my understanding is that, when
> running two output in parallel, the modeset of one can affect the second
> one, and that's bad, right?
> 
> If so, then you usually have multiple ways to fix this:
> 
>   - This patch
>   - Using clk_set_rate_exclusive like Chen-Yu suggested
>   - Using a notifier to react to a rate change and adjust
> 
> I'm not aware of any "official" guidelines at the clock framework level
> regarding which to pick and all are fine.
> 
> My opinion though would be to use clk_set_rate_exclusive(), for multiple
> reasons.
> 
> The first one is that it models correctly what you consumer expects:
> that the rate is left untouched. This can happen in virtually any
> situation where you have one clock in the same subtree changing rate,
> while the patch above will only fix that particular interference.
> 
> The second one is that, especially with DP, you only have a handful of
> rates you'll need to reach. 148MHz, 297MHz, 594MHz, and possibly a bunch
> of others for eDP panels. It's thus likely to have both controllers
> having the same frequency requirement, and thus it makes it possible to
> run from only one PLL and shut the other down.
> 
> This patch will introduce orphan clocks issues that are always a bit
> bothersome. A notifier would be troublesome to use and will probably
> introduce glitches plus some weird interaction with scrambling if you
> ever support it.
> 
> So, yeah, using clk_set_rate_exclusive() seems like the best option to me :)
> 
> Maxime

Sorry for resurrecting a very old thread, I was able to come back to this issue
right now: there's an issue that I can't really think about how to solve with
just the usage of clk_set_rate_exclusive().

Remembering that the clock tree is as following:
TVDPLL(x) -> PLL Divider (fixed) ->
-> MUX (can choose any of TVDPLL(1/2)_d(2/4/6/8/16)) -> Gate -> Controller

The DPI driver is doing:
1. Check the best factor for setting rate of a TVDPLL
2. Set rate of one TVDPLL (specified in DT): clk_set_rate(dpi->tvd_clk, rate);
    2a. Read the rate of that PLL again to know the precise clock output
3. Set rate on the Gate clock (forwards to MUX, selecting TVDPLL(x)_d(y)):
    clk_set_rate(dpi->pixel_clk, rate);


Now, the issue is: if I change the final pixel_clk rate setting to _exclusive(),
nothing still guarantees that we will be selecting the TVDPLL that we have
manipulated in step 2, look at the following example.

tvd_clk == TVDPLL1
pixel_clk == TOP_DP (can be muxed to any tvdpll1/2 dividers!)

clk_set_rate(tvdpll1, something); new_rate = clk_get_rate(tvdpll1)

...calculations... new_rate = pixclk * factor;
...more calculations....

clk_set_rate(pixel_clk, calculated_something)
        ^^^^^^

There is still no guarantee that pixel_clk is getting parented to one of the
TVDPLL1 dividers, as it could still get parented to a TVDPLL2 divider instead
if the other controller has set TVDPLL2 to "an acceptable rate": it's true that
this would work - yes but suboptimally! - because we want to set a specific
factor to reduce jitter on the final pixel clock.


....And I came back to this commit being again the best solution for me because....

1. You also seem to agree with me that a notifier would be troublesome and would
    probably introduce glitches; and
2. clk_set_rate_exclusive() doesn't give me any guarantee about selecting the same
    PLL that the driver was manipulating before.


Am I underestimating and/or ignoring anything else in all of that?

Cheers,
Angelo
