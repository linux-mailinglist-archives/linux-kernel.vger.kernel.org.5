Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF7A791E47
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 22:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbjIDUgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 16:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjIDUgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:36:40 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FBF187;
        Mon,  4 Sep 2023 13:36:37 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id E54A33ECA8;
        Mon,  4 Sep 2023 22:36:35 +0200 (CEST)
Date:   Mon, 4 Sep 2023 22:36:33 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, mturquette@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_saahtoma@quicinc.com
Subject: Re: [PATCH V2] clk: qcom: clk-rcg2: Fix clock rate overflow for high
 parent frequencies
Message-ID: <odbwkksa5xl33c6ic6nyqv732drx6e3or3tlxattd5jhg3q5jt@oepczt2vyowt>
References: <20230901073640.4973-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901073640.4973-1-quic_devipriy@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-01 13:06:40, Devi Priya wrote:
> If the parent clock rate is greater than unsigned long max/2 then
> integer overflow happens when calculating the clock rate on 32-bit systems.
> As RCG2 uses half integer dividers, the clock rate is first being
> multiplied by 2 which will overflow the unsigned long max value.
> Hence, replace the common pattern of doing 64-bit multiplication

Wasn't it doing 32-bit multiplication on 32-bit systems?  Glad to see the u64
mul and div cleaned up in the if (mode) block either way though.

> and then a do_div() call with simpler mult_frac call.

mul_frac()

> 
> Fixes: bcd61c0f535a ("clk: qcom: Add support for root clock generators (RCGs)")
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V2:
> 	- Replaced 64-bit multiplication & a do_div call with mult_frac
> 	  call as suggested by Marijn Suijten.

Don't forget to add reviewers to CC on followup revisions :)

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> 	- Updated the subject title
> 	- Added Fixes tag
> 	- Did not pick up the R-b tag due to the above changes.
> 
>  drivers/clk/qcom/clk-rcg2.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index a42f661550ca..f64d69164547 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -159,15 +159,11 @@ static unsigned long
>  calc_rate(unsigned long rate, u32 m, u32 n, u32 mode, u32 hid_div)
>  {
>  	if (hid_div) {
> -		rate *= 2;
> -		rate /= hid_div + 1;
> +		rate = mult_frac(rate, 2, hid_div + 1);
>  	}
>  
>  	if (mode) {
> -		u64 tmp = rate;
> -		tmp *= m;
> -		do_div(tmp, n);
> -		rate = tmp;
> +		rate = mult_frac(rate, m, n);
>  	}
>  
>  	return rate;
> -- 
> 2.34.1
> 
