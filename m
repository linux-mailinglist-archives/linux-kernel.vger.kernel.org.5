Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FDA75B778
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjGTTIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjGTTHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:07:53 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8AB2D4D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:07:46 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 54FD220231;
        Thu, 20 Jul 2023 21:07:43 +0200 (CEST)
Date:   Thu, 20 Jul 2023 21:07:41 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_saahtoma@quicinc.com
Subject: Re: [PATCH] clk: qcom: clk-rcg2: Fix wrong RCG clock rate for high
 parent frequencies
Message-ID: <v2jtnqomqr3bmewtollty2wlu73ymtbobt3pd5aypprmezhow2@edrb3w3kz56b>
References: <20230720083304.28881-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720083304.28881-1-quic_devipriy@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you retitle this to state "overflow" rather than just "wrong"?
That's more descriptive.

E.g "Fix clockrate overflow for high parent frequencies"

On 2023-07-20 14:03:04, Devi Priya wrote:
> If the parent clock rate is greater than unsigned long max/2 then
> integer overflow happens when calculating the clock rate on 32-bit systems.
> As RCG2 uses half integer dividers, the clock rate is first being
> multiplied by 2 which will overflow the unsigned long max value. So, use
> unsigned long long for rate computations to avoid overflow.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  drivers/clk/qcom/clk-rcg2.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index e22baf3a7112..42d00b134975 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -156,18 +156,18 @@ static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)
>   *            hid_div       n
>   */
>  static unsigned long
> -calc_rate(unsigned long rate, u32 m, u32 n, u32 mode, u32 hid_div)
> +calc_rate(unsigned long parent_rate, u32 m, u32 n, u32 mode, u32 hid_div)
>  {
> +	u64 rate = parent_rate;
> +
>  	if (hid_div) {
>  		rate *= 2;
> -		rate /= hid_div + 1;
> +		do_div(rate, hid_div + 1);

I'm pretty sure mult_frac() could have solved this as well, without
temporarily going to u64?

    mult_frac(rate, 2, hid_div + 1)

>  	}
>  
>  	if (mode) {
> -		u64 tmp = rate;
> -		tmp *= m;
> -		do_div(tmp, n);
> -		rate = tmp;
> +		rate *= m;
> +		do_div(rate, n);

    mult_frac(rate, m, n)

Or am I totally wrong?

- Marijn

>  	}
>  
>  	return rate;
> -- 
> 2.17.1
> 
