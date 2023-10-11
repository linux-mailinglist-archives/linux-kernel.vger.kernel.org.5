Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80357C5655
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347034AbjJKOEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbjJKOD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:03:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FEF1AA;
        Wed, 11 Oct 2023 07:03:50 -0700 (PDT)
Date:   Wed, 11 Oct 2023 16:03:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697033028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ryEPlAkCfnJebPNGelFxUu+Exl4LiDYxPfbPUhgQHM=;
        b=0tIyDf3E/7ceKdkTn+Bk4QcH0B8CgZDdg2PHfOYp4XRpDjQR+fg4H8OPwFaCJUuqFeqHL2
        R5F6YFLSHAU9GAE0miJbUPLFEJVs+zqPaZSzlhteq5VsQgyStsBMX3ewa5sqSpshMn8a3t
        LqqUTxuK3cAVtek/pLxLFUE7rkHEVDjbTHiJUomHZOEa7VTlvG2zmeIrsf8s5Gc9VG+6Sp
        RYdXlqFnuGOWOm8PhsK/lw/s/tFsYprecreWkJhCQVIqKv2cvLZiAU5mYTOwyn8lVEr75g
        dZAJEvqWwJ9Pai2IsWOkfD8ZPtf8ragn3F3CG7MPbE1GWzrUj2BgnWN9kxV4tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697033028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ryEPlAkCfnJebPNGelFxUu+Exl4LiDYxPfbPUhgQHM=;
        b=XR4TPWAkuaMPAhKQWqLauiWnZWk4PYD1G+fUxdKno3O6+LMGMLmcP2sxUMJLwE8j7Ypo2p
        b1EmuD1WvQBNxhCQ==
From:   Benedikt Spranger <b.spranger@linutronix.de>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH 1/1] clk: socfpga: gate: Fix of by factor 2 for serial
 console
Message-ID: <20231011160339.51e3ff1e@mitra>
In-Reply-To: <xcq3wiayrfa67pn4thepgewrcif4fdhplykvb4nkwgmxd3i7yo@vcimkuy32qd4>
References: <20231005095927.12398-1-b.spranger@linutronix.de>
        <20231005095927.12398-2-b.spranger@linutronix.de>
        <qpskbgigcaoyjuhzeguz366cjukv3ij7utlbkra5edhwn6uzh4@bdedm6vs62y5>
        <20231005203202.08b5d1cf@mitra>
        <ujs6kaisllqu3qzm76qkwpmdy2vnulp6z742ooclbsdz36zl5f@m7ujgar4pwqs>
        <xcq3wiayrfa67pn4thepgewrcif4fdhplykvb4nkwgmxd3i7yo@vcimkuy32qd4>
Organization: Linutronix GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 11:17:22 +0200
Maxime Ripard <mripard@kernel.org> wrote:

Hi,

> Could you test that patch?
The system booted fine. Serial console is working as expected

> ----8<----
> 
> diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
> index 8dd601bd8538..486a4d84e418 100644
> --- a/drivers/clk/socfpga/clk-gate.c
> +++ b/drivers/clk/socfpga/clk-gate.c
> @@ -87,10 +87,8 @@ static int socfpga_clk_set_parent(struct clk_hw *hwclk, u8 parent)
>  	return 0;
>  }
> 
> -static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
> -	unsigned long parent_rate)
> +static u32 socfpga_clk_get_div(struct socfpga_gate_clk *socfpgaclk)
>  {
> -	struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
>  	u32 div = 1, val;
> 
>  	if (socfpgaclk->fixed_div)
> @@ -105,12 +103,33 @@ static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
>  			div = (1 << val);
>  	}
> 
> +	return div;
> +}
> +
> +static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
> +					     unsigned long parent_rate)
> +{
> +	struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
> +	u32 div = socfpga_clk_get_div(socfpgaclk);
> +
>  	return parent_rate / div;
>  }
> 
> +
> +static int socfpga_clk_determine_rate(struct clk_hw *hw,
                                                       *hwclk,
> +				      struct clk_rate_request *req)
> +{
> +	struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
> +	u32 div = socfpga_clk_get_div(socfpgaclk);
> +
> +	req->rate = req->best_parent_rate / div;
> +
> +	return 0;
> +}
> +
>  static struct clk_ops gateclk_ops = {
>  	.recalc_rate = socfpga_clk_recalc_rate,
> -	.determine_rate = clk_hw_determine_rate_no_reparent,
> +	.determine_rate = socfpga_clk_determine_rate,
>  	.get_parent = socfpga_clk_get_parent,
>  	.set_parent = socfpga_clk_set_parent,
>  };

Regards
    Benedikt Spranger
