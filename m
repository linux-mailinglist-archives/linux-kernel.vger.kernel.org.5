Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC5875665C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjGQOa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGQOay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:30:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDFFE4F;
        Mon, 17 Jul 2023 07:30:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 20DFC66020AE;
        Mon, 17 Jul 2023 15:30:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689604251;
        bh=JZ9CqbZe62FM8un3k54BF5lgTvBzK8Bjpc1+KbmZsgQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PEO+xjEj4b6bNuktP1A7EAt68PSO8uqRhM9P528Ijn4bYzt+lhKv+aXxX1TSphMyG
         v1YezT2c1wQXELGEZeZGt5/QwKb7GnlM31K+se6IdJZ9H2fh26GVJPUG/6ef12es8P
         +zyr7/xHhx2zgnVyP2rwFZuP0cGcpVxgtAoXzJebrOz6PDFtrId3xd75cBJzpJY/JH
         sUImzhdJNWPpWGhktrPNZPaM5BkOkRnOU2dGq4LJod56u39aIOpZ0skmpri2HAQCt5
         9Hb73sU7zYoY1NMxrOvIl+laug25d5fU3o35RZUjoThkxN3UvDpRqLapqVVKtDGCoc
         d9vZwsgxe6npA==
Message-ID: <24d17b07-1e8d-05f6-46b7-9da1ff1bed7a@collabora.com>
Date:   Mon, 17 Jul 2023 16:30:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
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
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <jxgy2pvns4ri2aj5nmdhb4zbluseuzdejbplh2avwz63df2cfx@grrrdm6ujzi4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/07/23 13:24, Maxime Ripard ha scritto:
> On Mon, Jul 17, 2023 at 11:13:26AM +0200, AngeloGioacchino Del Regno wrote:
>> Il 17/07/23 09:48, Maxime Ripard ha scritto:
>>> Hi,
>>>
>>> On Fri, Jul 14, 2023 at 12:19:00PM +0800, Chen-Yu Tsai wrote:
>>>> On Thu, Jul 13, 2023 at 9:22 PM Alexandre Mergnat <amergnat@baylibre.com> wrote:
>>>>> On 13/07/2023 09:21, AngeloGioacchino Del Regno wrote:
>>>>>> The top_dp and top_edp muxes can be both parented to either TVDPLL1
>>>>>> or TVDPLL2, two identically specced PLLs for the specific purpose of
>>>>>> giving out pixel clock: this becomes a problem when the MediaTek
>>>>>> DisplayPort Interface (DPI) driver tries to set the pixel clock rate.
>>>>>>
>>>>>> In the usecase of two simultaneous outputs (using two controllers),
>>>>>> it was seen that one of the displays would sometimes display garbled
>>>>>> output (if any at all) and this was because:
>>>>>>     - top_edp was set to TVDPLL1, outputting X GHz
>>>>>>     - top_dp was set to TVDPLL2, outputting Y GHz
>>>>>>       - mtk_dpi calls clk_set_rate(top_edp, Z GHz)
>>>>>>         - top_dp is switched to TVDPLL1
>>>>>>         - TVDPLL1 changes its rate, top_edp outputs the wrong rate.
>>>>>>         - eDP display is garbled
>>>>>>
>>>>>> To solve this issue, remove all TVDPLL1 parents from `top_dp` and
>>>>>> all TVDPLL2 parents from `top_edp`, plus, necessarily switch both
>>>>>> clocks to use the new MUX_GATE_CLR_SET_UPD_INDEXED() macro to be
>>>>>> able to use the right bit index for the new parents list.
>>>>>>
>>>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>>>> ---
>>>>>>     drivers/clk/mediatek/clk-mt8195-topckgen.c | 22 ++++++++++++++--------
>>>>>>     1 file changed, 14 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
>>>>>> index 81daa24cadde..abb3721f6e1b 100644
>>>>>> --- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
>>>>>> +++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
>>>>>> @@ -417,15 +417,21 @@ static const char * const pwrmcu_parents[] = {
>>>>>>
>>>>>>     static const char * const dp_parents[] = {
>>>>>>         "clk26m",
>>>>>> -     "tvdpll1_d2",
>>>>>>         "tvdpll2_d2",
>>>>>> -     "tvdpll1_d4",
>>>>>>         "tvdpll2_d4",
>>>>>> -     "tvdpll1_d8",
>>>>>>         "tvdpll2_d8",
>>>>>> -     "tvdpll1_d16",
>>>>>>         "tvdpll2_d16"
>>>>>>     };
>>>>>> +static const u8 dp_parents_idx[] = { 0, 2, 4, 6, 8 };
>>>>>> +
>>>>>> +static const char * const edp_parents[] = {
>>>>>> +     "clk26m",
>>>>>> +     "tvdpll1_d2",
>>>>>> +     "tvdpll1_d4",
>>>>>> +     "tvdpll1_d8",
>>>>>> +     "tvdpll1_d16"
>>>>>> +};
>>>>>> +static const u8 edp_parents_idx[] = { 0, 1, 3, 5, 7 };
>>>>>
>>>>> AFAII your solution is to force a specific TVDPLLX for each display, and
>>>>> it isn't dynamic.
>>>>>
>>>>> Do you think it's possible to do that using the DTS ? I'm asking
>>>>> because, IMHO, this kind of setup is more friendly/readable/flexible in
>>>>> the DTS than hardcoded into the driver.
>>>>
>>>> (CC-ing Maxime, who has some experience in the matter.)
>>>
>>> It's not clear to me what the context is, but I'll try my best :)
>>>
>>
>> I'll try to explain briefly.
>>
>> On *some* MediaTek platforms, there are two *identical* PLLs for HDMI/(e)DP,
>> which are internal to the SoC; clocks for HDMI/eDP/DP controller*s* can be
>> parented either PLL (as you see from this commit)
> 
> So the HDMI controller can be parented either to the first or second PLL
> (and same thing for the (e)DP controllers)?
> 

We're talking about DP/eDP specifically here, but yeah, you got it! :-)

>> The PLL's rate can be changed in runtime and you want to use PLL dividers to
>> get the final pixel clock (that's to obviously reduce the PLL jitter).
>>
>>>> assigned-parents doesn't prevent your system from reparenting the clocks
>>>> back to a conflicting configuration.
>>>
>>> Yep, it's very much a one-off thing. There's no guarantee at the moment,
>>> and semantics-wise we could change the whole thing at probe time and it
>>> would be fine.
>>>
>>
>> Would be fine... but more complicated I think?
> 
> My point wasn't that you should do it, but that you can't rely on the
> parent or rate sticking around.
> 

Cool, I'm happy that we think alike. That's also my point...

>>>> AFAIK the recommended way to deal with this is to use
>>>> clk_set_rate_exclusive() and co. in whatever consumer driver that
>>>> needs exclusive control on the clock rate.
>>>
>>> I guess it works, but it looks to me like the issue here is that the
>>> provider should disable it entirely? My expectation for
>>> clk_set_rate_exclusive() is that one user needs to lock the clock rate
>>> to operate properly.
>>>
>>> If the provider expectation is that the rate or parent should never
>>> changed, then that needs to be dealt with at the provider level, ie
>>> through the clk_ops.
>>>
>>>> However I'm not sure if that works for parents. It should, given the
>>>> original use case was for the sunxi platforms, which like the MediaTek
>>>> platform here has 2 PLLs for video related consumers, but I couldn't
>>>> find code verifying it.
>>>
>>> If you want to prevent clocks from ever being reparented, you can use
>>> the new clk_hw_determine_rate_no_reparent() determine_rate
>>> implementation.
>>>
>>
>> We want the clocks to be reparented, as we need them to switch parents as
>> explained before... that's more or less how the tree looks:
>>
>> TVDPLL(x) -> PLL Divider (fixed) -> MUX -> Gate -> Controller
>>
>> Besides, I think that forcing *one* parent to the dp/edp mux would produce a
>> loss of the flexibility that the clock framework provides.
>>
>> I again want to emphasize on the fact that TVDPLL1 and TVDPLL2 are *identical*
>> in specs, and on that there will never be a MT8195 SoC that has only one of
>> the two PLLs, for obvious reasons...
>>
>> P.S.: If you need more context, I'll be glad to answer to any other question!
> 
> Then I have no idea what the question is :)
> 
> What are you trying to achieve / fix, and how can I help you ? :)
> 

Chen-Yu, Alexandre had/have questions about if there was any other solution instead
of using the solution of *this* commit, so, if there's any other better solution
than the one that I've sent as this commit.

I'm the one saying that this commit is the best solution :-P

Cheers,
Angelo

