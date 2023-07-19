Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A9675912E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGSJI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjGSJIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:08:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAA410B;
        Wed, 19 Jul 2023 02:08:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F14476607072;
        Wed, 19 Jul 2023 10:08:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689757732;
        bh=92PMMe+Za3IqqLKrrnY1ZyW+3PGalhqsHtuGNXYAPhM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l/jO16z+3Sf0I6YvL2F9Vt1f/m9yqDE4Iw6QWcWE9/ySWhZdSG1QOYYO8ZWrN3Pga
         vZ7VbrAYtlXwY22IXiiYb8CQa8BLQdhPX1gPoLHY+3jqn1T+FV1IM0tj5kve3HN2R1
         iWa1BUYTGSi8utiFgoAGBzp5xSteF1jtJheN2B97PAQFeCQRmplXONybJAlMF6XYLm
         5a0prg0P5PiIcEX9mlVViwrrUCmYmU27o5jgDH24RWkUehRFeRCwz+9D1zBEKrOK+2
         uDRVgOYOj1UV9U2kX9PIQjgA4SPv/y+ks4f9+dJczSrd/YXBA5eXh7Obx7v0Nek9Wu
         evwf9blYsENTQ==
Message-ID: <af808c08-50f7-6c27-921f-b2d0dc79f1e8@collabora.com>
Date:   Wed, 19 Jul 2023 11:08:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] clk: mediatek: Check if clock ID is larger than
 clk_hw_onecell_data size
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230719082033.1229277-1-wenst@chromium.org>
 <a63ffedd-8637-8161-2317-bd36be2867ae@collabora.com>
 <CAGXv+5GimZNPo6QDmCN7o4-qU-iPni=e1vPH5v0Z-Opn_0QjFg@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5GimZNPo6QDmCN7o4-qU-iPni=e1vPH5v0Z-Opn_0QjFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/07/23 10:52, Chen-Yu Tsai ha scritto:
> On Wed, Jul 19, 2023 at 4:36 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 19/07/23 10:20, Chen-Yu Tsai ha scritto:
>>> The MediaTek clock driver library's simple-probe mechanism allocates
>>> clk_hw_onecell_data based on how many clocks are defined. If there's a
>>> mismatch between that and the actual number of clocks defined in the DT
>>> binding, such that a clock ID exceeds the number, then an out-of-bounds
>>> write will occur. This silently corrupts memory, maybe causing a crash
>>> later on that seems unrelated. KASAN can detect this if turned on.
>>>
>>> To avoid getting into said scenario, check if the to be registered
>>> clock's ID will fit in the allocated clk_hw_onecell_data. If not, put
>>> out a big warning and skip the clock.
>>>
>>> One could argue that the proper fix is to let the drivers specify the
>>> number of clocks (based on a DT binding macro) instead. However even
>>> the DT binding macro could be wrong. And having code to catch errors
>>> and give out warnings is better than having silent corruption.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>> ---
>>> This one is less urgent.
>>>
>>> Angelo, do you think we should add a field to struct mtk_clk_desc and
>>> assign CLK_XXX_NR_CLK to it?
>>>
>>
>> I get the point... but I don't know if it is a good idea to add checks for
>> *bad code* in the first place, as bad code shall not happen at all.
>> Validating whether a developer wrote the right thing is something that should
>> be done in code reviews, and such mistakes shouldn't be allowed to happen.
> 
> In theory, yeah. In practice, well, we already have such an error in tree. :p
> 

Yeah, I realize that reviews are done by humans, and humans naturally make
mistakes, which is fine.

I wonder if there is any way to solve this with a build time error... I didn't
try and didn't look though - so I'm just thinking out loud.

>> Besides, if you really want to go this route... In that case I disagree about
>> the `continue`, as I would be inflexible: if your code is bad, I will refuse
>> to register your clocks entirely.
>> That'll force the developer to actually fix it, as parts of the SoC and/or
>> platform will *not work at all* :-)
>>
>> So, in that case...
>>
>>          if (rc->id >= clk_data->num) {
>>                  hw = PTR_ERR(-EINVAL);
>>                  goto err;
>>          }
>>
>> Thoughts?
> 
> That works for me as well. This was more my debug code cleaned up.
> I assume we still want the warning / error message though?
> 

I don't have any strong opinions on this specific matter. My only concern is
that we'd increase the kernel size with those prints that should never happen
anyway...

...but again, I'll leave that choice to you - no strong opinions.

> The other choice would be adding .num_clks for CLK_XXX_NR_CLKS to
> mtk_clk_desc. What are your thoughts on that?
> 

A u16 wouldn't waste all that much memory, so that could cover the case in
which someone specifies *less* clocks than normal.
That'd be something necessary if we're really following that validation route,
as the actual validation would be *incomplete* without that, I think.

> ChenYu
> 
>> Cheers!
>> Angelo
>>
>>>    drivers/clk/mediatek/clk-gate.c | 11 +++++++++
>>>    drivers/clk/mediatek/clk-mtk.c  | 43 +++++++++++++++++++++++++++++++++
>>>    2 files changed, 54 insertions(+)
>>>
>>> diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
>>> index 67d9e741c5e7..bb7c536ef60f 100644
>>> --- a/drivers/clk/mediatek/clk-gate.c
>>> +++ b/drivers/clk/mediatek/clk-gate.c
>>> @@ -222,6 +222,11 @@ int mtk_clk_register_gates(struct device *dev, struct device_node *node,
>>>        for (i = 0; i < num; i++) {
>>>                const struct mtk_gate *gate = &clks[i];
>>>
>>> +             if (WARN(gate->id >= clk_data->num,
>>> +                      "%pOF: gateclock ID (%d)larger than expected (%d)\n",
>>> +                      node, gate->id, clk_data->num))
>>> +                     continue;
>>> +
>>>                if (!IS_ERR_OR_NULL(clk_data->hws[gate->id])) {
>>>                        pr_warn("%pOF: Trying to register duplicate clock ID: %d\n",
>>>                                node, gate->id);
>>> @@ -251,6 +256,9 @@ int mtk_clk_register_gates(struct device *dev, struct device_node *node,
>>>        while (--i >= 0) {
>>>                const struct mtk_gate *gate = &clks[i];
>>>
>>> +             if (gate->id >= clk_data->num)
>>> +                     continue;
>>> +
>>>                if (IS_ERR_OR_NULL(clk_data->hws[gate->id]))
>>>                        continue;
>>>
>>> @@ -273,6 +281,9 @@ void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
>>>        for (i = num; i > 0; i--) {
>>>                const struct mtk_gate *gate = &clks[i - 1];
>>>
>>> +             if (gate->id >= clk_data->num)
>>> +                     continue;
>>> +
>>>                if (IS_ERR_OR_NULL(clk_data->hws[gate->id]))
>>>                        continue;
>>>
>>> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
>>> index 2e55368dc4d8..09d50a15db77 100644
>>> --- a/drivers/clk/mediatek/clk-mtk.c
>>> +++ b/drivers/clk/mediatek/clk-mtk.c
>>> @@ -94,6 +94,10 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
>>>        for (i = 0; i < num; i++) {
>>>                const struct mtk_fixed_clk *rc = &clks[i];
>>>
>>> +             if (WARN(rc->id >= clk_data->num,
>>> +                      "Fixed clock ID (%d) larger than expected (%d)\n", rc->id, clk_data->num))
>>> +                     continue;
>>> +
>>>                if (!IS_ERR_OR_NULL(clk_data->hws[rc->id])) {
>>>                        pr_warn("Trying to register duplicate clock ID: %d\n", rc->id);
>>>                        continue;
>>> @@ -117,6 +121,9 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
>>>        while (--i >= 0) {
>>>                const struct mtk_fixed_clk *rc = &clks[i];
>>>
>>> +             if (rc->id >= clk_data->num)
>>> +                     continue;
>>> +
>>>                if (IS_ERR_OR_NULL(clk_data->hws[rc->id]))
>>>                        continue;
>>>
>>> @@ -139,6 +146,9 @@ void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
>>>        for (i = num; i > 0; i--) {
>>>                const struct mtk_fixed_clk *rc = &clks[i - 1];
>>>
>>> +             if (rc->id >= clk_data->num)
>>> +                     continue;
>>> +
>>>                if (IS_ERR_OR_NULL(clk_data->hws[rc->id]))
>>>                        continue;
>>>
>>> @@ -160,6 +170,11 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
>>>        for (i = 0; i < num; i++) {
>>>                const struct mtk_fixed_factor *ff = &clks[i];
>>>
>>> +             if (WARN(ff->id >= clk_data->num,
>>> +                      "Fixed factor clock ID (%d) larger than expected (%d)\n",
>>> +                      ff->id, clk_data->num))
>>> +                     continue;
>>> +
>>>                if (!IS_ERR_OR_NULL(clk_data->hws[ff->id])) {
>>>                        pr_warn("Trying to register duplicate clock ID: %d\n", ff->id);
>>>                        continue;
>>> @@ -183,6 +198,9 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
>>>        while (--i >= 0) {
>>>                const struct mtk_fixed_factor *ff = &clks[i];
>>>
>>> +             if (ff->id >= clk_data->num)
>>> +                     continue;
>>> +
>>>                if (IS_ERR_OR_NULL(clk_data->hws[ff->id]))
>>>                        continue;
>>>
>>> @@ -205,6 +223,9 @@ void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
>>>        for (i = num; i > 0; i--) {
>>>                const struct mtk_fixed_factor *ff = &clks[i - 1];
>>>
>>> +             if (ff->id >= clk_data->num)
>>> +                     continue;
>>> +
>>>                if (IS_ERR_OR_NULL(clk_data->hws[ff->id]))
>>>                        continue;
>>>
>>> @@ -339,6 +360,11 @@ int mtk_clk_register_composites(struct device *dev,
>>>        for (i = 0; i < num; i++) {
>>>                const struct mtk_composite *mc = &mcs[i];
>>>
>>> +             if (WARN(mc->id >= clk_data->num,
>>> +                      "Composite clock ID (%d) larger than expected (%d)\n",
>>> +                      mc->id, clk_data->num))
>>> +                     continue;
>>> +
>>>                if (!IS_ERR_OR_NULL(clk_data->hws[mc->id])) {
>>>                        pr_warn("Trying to register duplicate clock ID: %d\n",
>>>                                mc->id);
>>> @@ -362,6 +388,9 @@ int mtk_clk_register_composites(struct device *dev,
>>>        while (--i >= 0) {
>>>                const struct mtk_composite *mc = &mcs[i];
>>>
>>> +             if (mc->id >= clk_data->num)
>>> +                     continue;
>>> +
>>>                if (IS_ERR_OR_NULL(clk_data->hws[mcs->id]))
>>>                        continue;
>>>
>>> @@ -384,6 +413,9 @@ void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
>>>        for (i = num; i > 0; i--) {
>>>                const struct mtk_composite *mc = &mcs[i - 1];
>>>
>>> +             if (mc->id >= clk_data->num)
>>> +                     continue;
>>> +
>>>                if (IS_ERR_OR_NULL(clk_data->hws[mc->id]))
>>>                        continue;
>>>
>>> @@ -407,6 +439,11 @@ int mtk_clk_register_dividers(struct device *dev,
>>>        for (i = 0; i <  num; i++) {
>>>                const struct mtk_clk_divider *mcd = &mcds[i];
>>>
>>> +             if (WARN(mcd->id >= clk_data->num,
>>> +                      "Divider clock ID (%d) larger than expected (%d)\n",
>>> +                      mcd->id, clk_data->num))
>>> +                     continue;
>>> +
>>>                if (!IS_ERR_OR_NULL(clk_data->hws[mcd->id])) {
>>>                        pr_warn("Trying to register duplicate clock ID: %d\n",
>>>                                mcd->id);
>>> @@ -432,6 +469,9 @@ int mtk_clk_register_dividers(struct device *dev,
>>>        while (--i >= 0) {
>>>                const struct mtk_clk_divider *mcd = &mcds[i];
>>>
>>> +             if (mcd->id >= clk_data->num)
>>> +                     continue;
>>> +
>>>                if (IS_ERR_OR_NULL(clk_data->hws[mcd->id]))
>>>                        continue;
>>>
>>> @@ -454,6 +494,9 @@ void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
>>>        for (i = num; i > 0; i--) {
>>>                const struct mtk_clk_divider *mcd = &mcds[i - 1];
>>>
>>> +             if (mcd->id >= clk_data->num)
>>> +                     continue;
>>> +
>>>                if (IS_ERR_OR_NULL(clk_data->hws[mcd->id]))
>>>                        continue;
>>>
>>


