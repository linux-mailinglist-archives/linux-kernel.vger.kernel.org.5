Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B3C7CC811
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344168AbjJQPxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjJQPxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:53:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401109E;
        Tue, 17 Oct 2023 08:53:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BB6C433C8;
        Tue, 17 Oct 2023 15:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697557979;
        bh=OuFCZ+mYBxI9aVlshoc+ddPbEgGI46T/EB1CuvYd5qI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0X0OfUBXEveGf+R6NCA1uaCZYBR5VaujRjI25ewIyjGS2C36IiAzeE/vClaOcb44
         T5oQTLhp8UsMpVhDI2axpM+vxATQO3m6woP7QzHBmFcYr912env/r7qbJ+yYaMfuDL
         usfx9uuaVlpHGxYmCfrNT2VK4Fo1aA52tWE0mTbd5Ycj3eFsvLrOsC7XkeXpZ3Nnk6
         s4i89Aygtx6Tj/2allA08CpvR71vE28Uo12PVRt51LQDPKWNVj1HDIbQS6Gkmu4PCH
         tWgaruXeG6ofkNOHgegijWhyawiI7R2bhIFZx2FUNJ2FR1frrISZt43q+OKKsZSqAJ
         5x1U95qw7bhQw==
Date:   Tue, 17 Oct 2023 08:52:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-clk@vger.kernel.org, tsbogend@alpha.franken.de,
        sboyd@kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        arnd@kernel.org, yangshiji66@outlook.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] clk: ralink: mtmips: quiet unused variable warning
Message-ID: <20231017155257.GA710773@dev-arch.thelio-3990X>
References: <20230827023932.501102-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827023932.501102-1-sergio.paracuellos@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 04:39:32AM +0200, Sergio Paracuellos wrote:
> When CONFIG_OF is disabled then the matching table is not referenced and
> the following warning appears:
> 
> drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'mtmips_of_match' [-Wunused-const-variable]
> 821 |   static const struct of_device_id mtmips_of_match[] = {
>     |                          ^
> 
> There are two match tables in the driver: one for the clock driver and the
> other for the reset driver. The only difference between them is that the
> clock driver uses 'data' and does not have 'ralink,rt2880-reset' compatible.
> Both just can be merged into a single one just by adding the compatible
> 'ralink,rt2880-reset' entry to 'mtmips_of_match[]', which will allow it to
> be used for 'mtmips_clk_driver' (which doesn't use the data) as well as for
> 'mtmips_clk_init()' (which doesn't need get called for 'ralink,rt2880-reset').
> 
> Doing in this way ensures that 'CONFIG_OF' is not disabled anymore so the
> above warning disapears.
> 
> Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for MTMIPS SoCs")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307242310.CdOnd2py-lkp@intel.com/
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Changes in v2:
> - Merge two match tables into one to properly avoid this warning.
> 
> PATCH in v1: https://lore.kernel.org/lkml/20230802092647.3000666-1-sergio.paracuellos@gmail.com/T/
> 
>  drivers/clk/ralink/clk-mtmips.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mtmips.c
> index 1e7991439527..50a443bf79ec 100644
> --- a/drivers/clk/ralink/clk-mtmips.c
> +++ b/drivers/clk/ralink/clk-mtmips.c
> @@ -821,6 +821,10 @@ static const struct mtmips_clk_data mt76x8_clk_data = {
>  };
>  
>  static const struct of_device_id mtmips_of_match[] = {
> +	{
> +		.compatible = "ralink,rt2880-reset",
> +		.data = NULL,
> +	},
>  	{
>  		.compatible = "ralink,rt2880-sysc",
>  		.data = &rt2880_clk_data,
> @@ -1088,25 +1092,11 @@ static int mtmips_clk_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct of_device_id mtmips_clk_of_match[] = {
> -	{ .compatible = "ralink,rt2880-reset" },
> -	{ .compatible = "ralink,rt2880-sysc" },
> -	{ .compatible = "ralink,rt3050-sysc" },
> -	{ .compatible = "ralink,rt3052-sysc" },
> -	{ .compatible = "ralink,rt3352-sysc" },
> -	{ .compatible = "ralink,rt3883-sysc" },
> -	{ .compatible = "ralink,rt5350-sysc" },
> -	{ .compatible = "ralink,mt7620-sysc" },
> -	{ .compatible = "ralink,mt7628-sysc" },
> -	{ .compatible = "ralink,mt7688-sysc" },
> -	{}
> -};
> -
>  static struct platform_driver mtmips_clk_driver = {
>  	.probe = mtmips_clk_probe,
>  	.driver = {
>  		.name = "mtmips-clk",
> -		.of_match_table = mtmips_clk_of_match,
> +		.of_match_table = mtmips_of_match,
>  	},
>  };
>  
> -- 
> 2.25.1
> 
