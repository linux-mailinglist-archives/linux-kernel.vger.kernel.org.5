Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414918118E2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbjLMQOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbjLMQNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:13:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32E0B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:13:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BF1C433C8;
        Wed, 13 Dec 2023 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702484036;
        bh=qrD0MrsY/L+ptpyJGJ+B+8mNoxKA92VdRp7Ypgf5fYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2Y/VWIUrFnciX2ebT4ABNR8Osjl7qn5YgrItr8tv5vMeIikgDgkpPW6nFZagRniS
         XGUs6B5SL/B4sU2eRQM+tf1Y3YTUIPdQyIfeNAnw9kOp7+00GArd7aNY6e1KXasDmL
         cAs8L8NOy9/K5gmzfS60qGg5khi4gJtqUBs3guwdQHdEgfvX5IyuJTtiLrTJWJLQmH
         Zq+zI6KvT+0BHJ7W1rZOOugcmjObEzgpyFGWJ3vsg5IYNexoRWyAJDEvUi0PfqONkS
         1x/aKwzDIDGpKEBt2KuLYTbKfLSvyqoIokb9I1dFwgv3wsUNXrR5xT/pvV7+WEt0f+
         8Mhx8enV1AvqQ==
Date:   Wed, 13 Dec 2023 16:13:52 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Alex Vinarskis <alex.vinarskis@gmail.com>
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Fix the fractional clock divider
 flags
Message-ID: <20231213161352.GQ111411@google.com>
References: <20231211111441.3910083-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231211111441.3910083-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023, Andy Shevchenko wrote:

> The conversion to CLK_FRAC_DIVIDER_POWER_OF_TWO_PS uses wrong flags
> in the parameters and hence miscalculates the values in the clock
> divider. Fix this by applying the flag to the proper parameter.
> 
> Fixes: 82f53f9ee577 ("clk: fractional-divider: Introduce POWER_OF_TWO_PS flag")
> Reported-by: Alex Vinarskis <alex.vinarskis@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
> index 177915845ba2..eff423f7dd28 100644
> --- a/drivers/mfd/intel-lpss.c
> +++ b/drivers/mfd/intel-lpss.c
> @@ -309,8 +309,8 @@ static int intel_lpss_register_clock_divider(struct intel_lpss *lpss,
>  
>  	snprintf(name, sizeof(name), "%s-div", devname);
>  	tmp = clk_register_fractional_divider(NULL, name, __clk_get_name(tmp),
> +					      0, lpss->priv, 1, 15, 16, 15,
>  					      CLK_FRAC_DIVIDER_POWER_OF_TWO_PS,
> -					      lpss->priv, 1, 15, 16, 15, 0,
>  					      NULL);

What an ugly interface.  Intel-only too, right?

Have you also fixed this in: drivers/acpi/acpi_lpss.c

>  	if (IS_ERR(tmp))
>  		return PTR_ERR(tmp);
> -- 
> 2.43.0.rc1.1.gbec44491f096
> 

-- 
Lee Jones [李琼斯]
