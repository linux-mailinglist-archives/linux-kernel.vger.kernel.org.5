Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63D075906C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjGSIhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjGSIhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:37:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96724172E;
        Wed, 19 Jul 2023 01:36:56 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4752A6606F57;
        Wed, 19 Jul 2023 09:36:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689755814;
        bh=+psTFYYw5BO1qwTHZg8HUhRdI3ujR0TGp1ezqW9WCsM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iBNLuqWU/awwuoe4Bsh0pJZi72KqrdMVm5AyFdnnQuFEHWDHQ1AUMZXaPNVUzAR+3
         /6DzuXCozZ0DmmDSoFd0QFlaXQrhDkb5oS7i8bTp7d9hfoqRi7ztjPf33OBuAlFa8f
         E4I7SaHy/T6Cqc9EX1GfoJQFr+L0V+Nx3c1XEHaRZdWj7I/ejoXIsrdmqx9ht9ci+X
         OXnpaMC8usOqclKLCDQZ3v7dOaZ1A6+is4KRJXkixOI6srSOTt1Xn4jivvN6VydFNB
         snuPBqH/6bmfnIYrFIGtDTgg01PoKYWYhMDFKqzCsL5U8fBbVs/5okxtQ8FMBuhNjz
         cGTE4HXA3GtqQ==
Message-ID: <a63ffedd-8637-8161-2317-bd36be2867ae@collabora.com>
Date:   Wed, 19 Jul 2023 10:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] clk: mediatek: Check if clock ID is larger than
 clk_hw_onecell_data size
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230719082033.1229277-1-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230719082033.1229277-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/07/23 10:20, Chen-Yu Tsai ha scritto:
> The MediaTek clock driver library's simple-probe mechanism allocates
> clk_hw_onecell_data based on how many clocks are defined. If there's a
> mismatch between that and the actual number of clocks defined in the DT
> binding, such that a clock ID exceeds the number, then an out-of-bounds
> write will occur. This silently corrupts memory, maybe causing a crash
> later on that seems unrelated. KASAN can detect this if turned on.
> 
> To avoid getting into said scenario, check if the to be registered
> clock's ID will fit in the allocated clk_hw_onecell_data. If not, put
> out a big warning and skip the clock.
> 
> One could argue that the proper fix is to let the drivers specify the
> number of clocks (based on a DT binding macro) instead. However even
> the DT binding macro could be wrong. And having code to catch errors
> and give out warnings is better than having silent corruption.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> This one is less urgent.
> 
> Angelo, do you think we should add a field to struct mtk_clk_desc and
> assign CLK_XXX_NR_CLK to it?
> 

I get the point... but I don't know if it is a good idea to add checks for
*bad code* in the first place, as bad code shall not happen at all.
Validating whether a developer wrote the right thing is something that should
be done in code reviews, and such mistakes shouldn't be allowed to happen.

Besides, if you really want to go this route... In that case I disagree about
the `continue`, as I would be inflexible: if your code is bad, I will refuse
to register your clocks entirely.
That'll force the developer to actually fix it, as parts of the SoC and/or
platform will *not work at all* :-)

So, in that case...

	if (rc->id >= clk_data->num) {
		hw = PTR_ERR(-EINVAL);
		goto err;
	}

Thoughts?

Cheers!
Angelo

>   drivers/clk/mediatek/clk-gate.c | 11 +++++++++
>   drivers/clk/mediatek/clk-mtk.c  | 43 +++++++++++++++++++++++++++++++++
>   2 files changed, 54 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
> index 67d9e741c5e7..bb7c536ef60f 100644
> --- a/drivers/clk/mediatek/clk-gate.c
> +++ b/drivers/clk/mediatek/clk-gate.c
> @@ -222,6 +222,11 @@ int mtk_clk_register_gates(struct device *dev, struct device_node *node,
>   	for (i = 0; i < num; i++) {
>   		const struct mtk_gate *gate = &clks[i];
>   
> +		if (WARN(gate->id >= clk_data->num,
> +			 "%pOF: gateclock ID (%d)larger than expected (%d)\n",
> +			 node, gate->id, clk_data->num))
> +			continue;
> +
>   		if (!IS_ERR_OR_NULL(clk_data->hws[gate->id])) {
>   			pr_warn("%pOF: Trying to register duplicate clock ID: %d\n",
>   				node, gate->id);
> @@ -251,6 +256,9 @@ int mtk_clk_register_gates(struct device *dev, struct device_node *node,
>   	while (--i >= 0) {
>   		const struct mtk_gate *gate = &clks[i];
>   
> +		if (gate->id >= clk_data->num)
> +			continue;
> +
>   		if (IS_ERR_OR_NULL(clk_data->hws[gate->id]))
>   			continue;
>   
> @@ -273,6 +281,9 @@ void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
>   	for (i = num; i > 0; i--) {
>   		const struct mtk_gate *gate = &clks[i - 1];
>   
> +		if (gate->id >= clk_data->num)
> +			continue;
> +
>   		if (IS_ERR_OR_NULL(clk_data->hws[gate->id]))
>   			continue;
>   
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index 2e55368dc4d8..09d50a15db77 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -94,6 +94,10 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
>   	for (i = 0; i < num; i++) {
>   		const struct mtk_fixed_clk *rc = &clks[i];
>   
> +		if (WARN(rc->id >= clk_data->num,
> +			 "Fixed clock ID (%d) larger than expected (%d)\n", rc->id, clk_data->num))
> +			continue;
> +
>   		if (!IS_ERR_OR_NULL(clk_data->hws[rc->id])) {
>   			pr_warn("Trying to register duplicate clock ID: %d\n", rc->id);
>   			continue;
> @@ -117,6 +121,9 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
>   	while (--i >= 0) {
>   		const struct mtk_fixed_clk *rc = &clks[i];
>   
> +		if (rc->id >= clk_data->num)
> +			continue;
> +
>   		if (IS_ERR_OR_NULL(clk_data->hws[rc->id]))
>   			continue;
>   
> @@ -139,6 +146,9 @@ void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
>   	for (i = num; i > 0; i--) {
>   		const struct mtk_fixed_clk *rc = &clks[i - 1];
>   
> +		if (rc->id >= clk_data->num)
> +			continue;
> +
>   		if (IS_ERR_OR_NULL(clk_data->hws[rc->id]))
>   			continue;
>   
> @@ -160,6 +170,11 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
>   	for (i = 0; i < num; i++) {
>   		const struct mtk_fixed_factor *ff = &clks[i];
>   
> +		if (WARN(ff->id >= clk_data->num,
> +			 "Fixed factor clock ID (%d) larger than expected (%d)\n",
> +			 ff->id, clk_data->num))
> +			continue;
> +
>   		if (!IS_ERR_OR_NULL(clk_data->hws[ff->id])) {
>   			pr_warn("Trying to register duplicate clock ID: %d\n", ff->id);
>   			continue;
> @@ -183,6 +198,9 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
>   	while (--i >= 0) {
>   		const struct mtk_fixed_factor *ff = &clks[i];
>   
> +		if (ff->id >= clk_data->num)
> +			continue;
> +
>   		if (IS_ERR_OR_NULL(clk_data->hws[ff->id]))
>   			continue;
>   
> @@ -205,6 +223,9 @@ void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
>   	for (i = num; i > 0; i--) {
>   		const struct mtk_fixed_factor *ff = &clks[i - 1];
>   
> +		if (ff->id >= clk_data->num)
> +			continue;
> +
>   		if (IS_ERR_OR_NULL(clk_data->hws[ff->id]))
>   			continue;
>   
> @@ -339,6 +360,11 @@ int mtk_clk_register_composites(struct device *dev,
>   	for (i = 0; i < num; i++) {
>   		const struct mtk_composite *mc = &mcs[i];
>   
> +		if (WARN(mc->id >= clk_data->num,
> +			 "Composite clock ID (%d) larger than expected (%d)\n",
> +			 mc->id, clk_data->num))
> +			continue;
> +
>   		if (!IS_ERR_OR_NULL(clk_data->hws[mc->id])) {
>   			pr_warn("Trying to register duplicate clock ID: %d\n",
>   				mc->id);
> @@ -362,6 +388,9 @@ int mtk_clk_register_composites(struct device *dev,
>   	while (--i >= 0) {
>   		const struct mtk_composite *mc = &mcs[i];
>   
> +		if (mc->id >= clk_data->num)
> +			continue;
> +
>   		if (IS_ERR_OR_NULL(clk_data->hws[mcs->id]))
>   			continue;
>   
> @@ -384,6 +413,9 @@ void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
>   	for (i = num; i > 0; i--) {
>   		const struct mtk_composite *mc = &mcs[i - 1];
>   
> +		if (mc->id >= clk_data->num)
> +			continue;
> +
>   		if (IS_ERR_OR_NULL(clk_data->hws[mc->id]))
>   			continue;
>   
> @@ -407,6 +439,11 @@ int mtk_clk_register_dividers(struct device *dev,
>   	for (i = 0; i <  num; i++) {
>   		const struct mtk_clk_divider *mcd = &mcds[i];
>   
> +		if (WARN(mcd->id >= clk_data->num,
> +			 "Divider clock ID (%d) larger than expected (%d)\n",
> +			 mcd->id, clk_data->num))
> +			continue;
> +
>   		if (!IS_ERR_OR_NULL(clk_data->hws[mcd->id])) {
>   			pr_warn("Trying to register duplicate clock ID: %d\n",
>   				mcd->id);
> @@ -432,6 +469,9 @@ int mtk_clk_register_dividers(struct device *dev,
>   	while (--i >= 0) {
>   		const struct mtk_clk_divider *mcd = &mcds[i];
>   
> +		if (mcd->id >= clk_data->num)
> +			continue;
> +
>   		if (IS_ERR_OR_NULL(clk_data->hws[mcd->id]))
>   			continue;
>   
> @@ -454,6 +494,9 @@ void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
>   	for (i = num; i > 0; i--) {
>   		const struct mtk_clk_divider *mcd = &mcds[i - 1];
>   
> +		if (mcd->id >= clk_data->num)
> +			continue;
> +
>   		if (IS_ERR_OR_NULL(clk_data->hws[mcd->id]))
>   			continue;
>   

