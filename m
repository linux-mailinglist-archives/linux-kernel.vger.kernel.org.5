Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A41B771570
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjHFNsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHFNsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:48:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88FFE3;
        Sun,  6 Aug 2023 06:48:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98377c5d53eso506188566b.0;
        Sun, 06 Aug 2023 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691329690; x=1691934490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+Xsg9YY5Dq6KDm40Wq5sVdBaVtBYpXspCdRFB3jlUc=;
        b=cW1U6kol2AVYOcg2TqCC4Wew5k3K69d4xm1LCQ8g2gzInHi8Q2Eh2pcMazj/ZOYgeu
         EBjYTMj4HzMlW8M8JU4cgRq4JaNek6tYN5E7NtM9g3nBHPwbBnRn4OcZRzQNFPz3YFfa
         BuATZYDVCYVI39obMpAT/vkiZy2u0X7EI4vqqqeBdEZ64UGGJVwu4I8TCBwUr4SfY/Nf
         9QLSCpnVtc53LjzACQNojWDzAOcAk7TC3zzR+3AWuVgOvLiXL9VEZ4kQuumZerXRdjno
         4IGQUCcvj8sn4jKvtJwND/UmNn7MVlUjNhkNzxEX+nSrHmIV3frjaN+wgGkESy3k17oW
         NDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691329690; x=1691934490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+Xsg9YY5Dq6KDm40Wq5sVdBaVtBYpXspCdRFB3jlUc=;
        b=JfbXOkbIhGCQpBeSHVGL2ETs6lG9BL2IKeaLHO4vSU0eCqEdf0VVNTJIrrRF0SnOEZ
         2uPL/ciIboC6a+r4+5tg8TtT92xMeJIuzE7XYgzBtBnHE7/J4Nz43sBrhJaJVe4RVbsJ
         J4b3ydXIj8DHaJtej76BmnK+5f5UzGvpTRM/NzPk6sERMiEf0La7h9qsXigi/f6ZW4rW
         0T5jcaYHAPReI77EyZ2mf2Eoy+XwLc7GdC3Ldjf41xKJfy6C8ndksSQdiJtOklVyzkID
         p208iQo4K970mQNRFUM1WTeyVo+qiHUM/aWNzb0JldRqtFM+FuK02KAyIlTSuRLKJgJN
         VfnA==
X-Gm-Message-State: AOJu0YzsUuSVN4nrFvLxqNWRanfPbOjdvHs5/9qurVHg3OtK8Q/bFvMm
        m2m1YOiF4o8E3aUtR/5AL+I=
X-Google-Smtp-Source: AGHT+IEIvAXs0DV7ge7oOrAiLcptXmsCx2UmaHjaSTPXZOkGHv+2G25/3DKb5m3MRtq98l+13U/scQ==
X-Received: by 2002:a17:906:3082:b0:99b:f4fa:805f with SMTP id 2-20020a170906308200b0099bf4fa805fmr5782462ejv.28.1691329690189;
        Sun, 06 Aug 2023 06:48:10 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id r13-20020a170906704d00b0098e34446464sm3946765ejj.25.2023.08.06.06.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 06:48:09 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>, Frank Oltmanns <frank@oltmanns.dev>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frank Oltmanns <frank@oltmanns.dev>
Subject: Re: [PATCH v5 10/11] clk: sunxi-ng: a64: select closest rate for pll-video0
Date:   Sun, 06 Aug 2023 15:48:08 +0200
Message-ID: <2162023.Icojqenx9y@jernej-laptop>
In-Reply-To: <20230806-pll-mipi_set_rate_parent-v5-10-db4f5ca33fc3@oltmanns.dev>
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
 <20230806-pll-mipi_set_rate_parent-v5-10-db4f5ca33fc3@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 06. avgust 2023 ob 15:06:55 CEST je Frank Oltmanns napisal(a):
> Selecting the closest rate for pll-video0 instead of the closest rate
> that is less than the requested rate has no downside for this clock,
> while allowing for selecting a more suitable rate, e.g. for the
> connected panels.
> 
> Furthermore, the algorithm that sets an NKM clock's parent benefits from
> the closest rate. Without it, the NKM clock's rate might drift away from
> the requested rate in the multiple successive calls to
> ccu_nkm_determine_rate that the clk framework performs when setting a
> clock rate.
> 
> Therefore, configure pll-video0 and, in consequence, all of its
> descendents to select the closest rate.
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 33
> ++++++++++++++------------------- 1 file changed, 14 insertions(+), 19
> deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c index a139a5c438d4..73c84d20f3ee
> 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> @@ -68,7 +68,7 @@ static SUNXI_CCU_NM_WITH_SDM_GATE_LOCK(pll_audio_base_clk,
> "pll-audio-base", BIT(28),	/* lock */
>  				       CLK_SET_RATE_UNGATE);
> 
> -static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video0_clk,
> "pll-video0", +static
> SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST(pll_video0_clk,
> "pll-video0", "osc24M", 0x010,
>  						192000000,	
/* Minimum rate */
>  						1008000000,	
/* Maximum rate */
> @@ -181,6 +181,7 @@ static struct ccu_nkm pll_mipi_clk = {
>  		.hw.init	= CLK_HW_INIT("pll-mipi", "pll-video0",
>  					      &ccu_nkm_ops,
>  					      
CLK_SET_RATE_UNGATE | CLK_SET_RATE_PARENT),
> +		.features	= CCU_FEATURE_CLOSEST_RATE,
>  	},
>  };
> 
> @@ -531,24 +532,18 @@ static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de",
> de_parents,
> 
>  static const char * const tcon0_parents[] = { "pll-mipi", "pll-video0-2x"
> }; static const u8 tcon0_table[] = { 0, 2, };
> -static SUNXI_CCU_MUX_TABLE_WITH_GATE(tcon0_clk, "tcon0", tcon0_parents,
> +static SUNXI_CCU_MUX_TABLE_WITH_GATE_CLOSEST(tcon0_clk, "tcon0",
> tcon0_parents, tcon0_table, 0x118, 24, 3, BIT(31),
>  				     CLK_SET_RATE_PARENT);
> 
>  static const char * const tcon1_parents[] = { "pll-video0", "pll-video1" };
> static const u8 tcon1_table[] = { 0, 2, };
> -static struct ccu_div tcon1_clk = {
> -	.enable		= BIT(31),
> -	.div		= _SUNXI_CCU_DIV(0, 4),
> -	.mux		= _SUNXI_CCU_MUX_TABLE(24, 2, tcon1_table),
> -	.common		= {
> -		.reg		= 0x11c,
> -		.hw.init	= CLK_HW_INIT_PARENTS("tcon1",
> -						      
tcon1_parents,
> -						      
&ccu_div_ops,
> -						      
CLK_SET_RATE_PARENT),
> -	},
> -};
> +static SUNXI_CCU_M_WITH_MUX_TABLE_GATE_CLOSEST(tcon1_clk, "tcon1",
> tcon1_parents, +					       
tcon1_table, 0x11c,
> +					       0, 4,	/* M */
> +					       24, 2,	/* mux 
*/
> +					       BIT(31),	/* gate 
*/
> +					       
CLK_SET_RATE_PARENT);
> 
>  static const char * const deinterlace_parents[] = { "pll-periph0",
> "pll-periph1" }; static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk,
> "deinterlace", deinterlace_parents, @@ -578,8 +573,8 @@ static
> SUNXI_CCU_GATE(avs_clk,		"avs",		"osc24M", 
0x144, BIT(31), 0);
> 
>  static const char * const hdmi_parents[] = { "pll-video0", "pll-video1" };
> -static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", hdmi_parents,
> -				 0x150, 0, 4, 24, 2, BIT(31), 
CLK_SET_RATE_PARENT);
> +static SUNXI_CCU_M_WITH_MUX_GATE_CLOSEST(hdmi_clk, "hdmi", hdmi_parents,
> +					 0x150, 0, 4, 24, 2, 
BIT(31), CLK_SET_RATE_PARENT);
> 
>  static SUNXI_CCU_GATE(hdmi_ddc_clk,	"hdmi-ddc",	"osc24M",
>  		      0x154, BIT(31), 0);
> @@ -591,9 +586,9 @@ static SUNXI_CCU_M_WITH_MUX_GATE(mbus_clk, "mbus",
> mbus_parents,
> 
>  static const char * const dsi_dphy_parents[] = { "pll-video0",
> "pll-periph0" }; static const u8 dsi_dphy_table[] = { 0, 2, };
> -static SUNXI_CCU_M_WITH_MUX_TABLE_GATE(dsi_dphy_clk, "dsi-dphy",
> -				       dsi_dphy_parents, 
dsi_dphy_table,
> -				       0x168, 0, 4, 8, 2, 
BIT(15), CLK_SET_RATE_PARENT);
> +static SUNXI_CCU_M_WITH_MUX_TABLE_GATE_CLOSEST(dsi_dphy_clk, "dsi-dphy",
> +					       
dsi_dphy_parents, dsi_dphy_table,
> +					       0x168, 0, 4, 8, 
2, BIT(15), CLK_SET_RATE_PARENT);
> 
>  static SUNXI_CCU_M_WITH_GATE(gpu_clk, "gpu", "pll-gpu",
>  			     0x1a0, 0, 3, BIT(31), 
CLK_SET_RATE_PARENT);




