Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EF277155C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjHFNmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHFNmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:42:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2F6EB;
        Sun,  6 Aug 2023 06:42:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c1c66876aso506611866b.2;
        Sun, 06 Aug 2023 06:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691329322; x=1691934122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WALMtuY1q1u1v35LOtFmRB/W8nnlZgs+IUgJZUZJB0U=;
        b=A9eYjVViIUx+U9ndZZB3LBOJzWoPLQQrEzAEL8Mmh8TnVNZQc49pdCRWQtj7JtEb8F
         0tNn3ojMm1cKd9dr2sxCx6/vFzf+jpu5Kd4RaOQXaSid6j+L9y0rqjwyqIxf2e1u1tBo
         vIfHBOdNcjKUa+fMQpcTiqjkOH1Ap8DCmcBGPA+4SX6s33/zxJgv2x2GBU80D1eS615v
         d5Zyyyn4HcR4Ue0IkRmXchg4PytWoPG71mKFn4LRymr8C61l3fKnD29mjGP83m25/l4H
         6ToQEEC93r3Yo6MU1ofAcdVDVHwB48A52JhneL9DoWPa9ye7Qt4P8D5I7ioz5dOuT5R/
         AVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691329322; x=1691934122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WALMtuY1q1u1v35LOtFmRB/W8nnlZgs+IUgJZUZJB0U=;
        b=Nej6M4VQw2jH+AMZmtx7tJczILOy3CeSih/RGEgnPzgDV3UlhEFKwXcXWORSJ1h8Ex
         1sRGZQzlRhVJ/OAhm504m+L/BXZlwTOFHH6rN9sRNaDbUzCy8FxALkvNQJMk70Giayvu
         VjumnNntWkDGOiI4JH+PcW6JaSbu9pA/2WnG4A15vv+dGVTwk36aIB6ETDClGJ/xPNgB
         P121AV3LQLO1sQaYxm3PY0SrxcGFLLOZaZb4ytTNJZrWILWs4KBwdv+gl/vVfrAm5wv9
         1IDiYGkB7SnHr4cJPeGlsqDTYfRnL2ldi+9BPTFn9dx+30LXywQ1aESgM2ZJxvnYblsD
         6B1A==
X-Gm-Message-State: AOJu0YweU7XbIrUugLS2sJZbkWK3AzcVHdojJo+DUhz0HY/YdeYXuVv8
        rELVhMEKFxeN63ZX5uOedss=
X-Google-Smtp-Source: AGHT+IEtEzCGJpEmyOm8rqHxaOABvTf08nsDkY1uDvN0+mjBqCJOh9uBwh7X4BPVJzO7KxvRNvs3og==
X-Received: by 2002:a17:906:142:b0:99b:d698:152e with SMTP id 2-20020a170906014200b0099bd698152emr6406034ejh.42.1691329322434;
        Sun, 06 Aug 2023 06:42:02 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id bg14-20020a170906a04e00b009786c8249d6sm4001307ejb.175.2023.08.06.06.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 06:42:01 -0700 (PDT)
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
Subject: Re: [PATCH v5 06/11] clk: sunxi-ng: nm: Support finding closest rate
Date:   Sun, 06 Aug 2023 15:42:00 +0200
Message-ID: <3432648.QJadu78ljV@jernej-laptop>
In-Reply-To: <20230806-pll-mipi_set_rate_parent-v5-6-db4f5ca33fc3@oltmanns.dev>
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
 <20230806-pll-mipi_set_rate_parent-v5-6-db4f5ca33fc3@oltmanns.dev>
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

Dne nedelja, 06. avgust 2023 ob 15:06:51 CEST je Frank Oltmanns napisal(a):
> Use the helper function ccu_is_better_rate() to determine the rate that
> is closest to the requested rate, thereby supporting rates that are
> higher than the requested rate if the clock uses the
> CCU_FEATURE_CLOSEST_RATE.
> 
> Add the macro SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST which
> sets CCU_FEATURE_CLOSEST_RATE.
> 
> To avoid code duplication, add the macros
> SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT that allows selecting
> arbitrary features and use it in the original
> SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX as well as the newly introduced
> SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST macros.
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu_nm.c | 13 +++++-------
>  drivers/clk/sunxi-ng/ccu_nm.h | 48
> ++++++++++++++++++++++++++++++++++++++++--- 2 files changed, 50
> insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
> index c1fd11542c45..ffac3deb89d6 100644
> --- a/drivers/clk/sunxi-ng/ccu_nm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nm.c
> @@ -27,8 +27,8 @@ static unsigned long ccu_nm_calc_rate(unsigned long
> parent, return rate;
>  }
> 
> -static unsigned long ccu_nm_find_best(unsigned long parent, unsigned long
> rate, -				      struct _ccu_nm *nm)
> +static unsigned long ccu_nm_find_best(struct ccu_common *common, unsigned
> long parent, +				      unsigned long 
rate, struct _ccu_nm *nm)
>  {
>  	unsigned long best_rate = 0;
>  	unsigned long best_n = 0, best_m = 0;
> @@ -39,10 +39,7 @@ static unsigned long ccu_nm_find_best(unsigned long
> parent, unsigned long rate, unsigned long tmp_rate =
> ccu_nm_calc_rate(parent,
>  								
  _n, _m);
> 
> -			if (tmp_rate > rate)
> -				continue;
> -
> -			if ((rate - tmp_rate) < (rate - best_rate)) 
{
> +			if (ccu_is_better_rate(common, rate, 
tmp_rate, best_rate)) {
>  				best_rate = tmp_rate;
>  				best_n = _n;
>  				best_m = _m;
> @@ -159,7 +156,7 @@ static long ccu_nm_round_rate(struct clk_hw *hw,
> unsigned long rate, _nm.min_m = 1;
>  	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
> 
> -	rate = ccu_nm_find_best(*parent_rate, rate, &_nm);
> +	rate = ccu_nm_find_best(&nm->common, *parent_rate, rate, &_nm);
> 
>  	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate /= nm->fixed_post_div;
> @@ -210,7 +207,7 @@ static int ccu_nm_set_rate(struct clk_hw *hw, unsigned
> long rate, &_nm.m, &_nm.n);
>  	} else {
>  		ccu_sdm_helper_disable(&nm->common, &nm->sdm);
> -		ccu_nm_find_best(parent_rate, rate, &_nm);
> +		ccu_nm_find_best(&nm->common, parent_rate, rate, &_nm);
>  	}
> 
>  	spin_lock_irqsave(nm->common.lock, flags);
> diff --git a/drivers/clk/sunxi-ng/ccu_nm.h b/drivers/clk/sunxi-ng/ccu_nm.h
> index 2904e67f05a8..93c11693574f 100644
> --- a/drivers/clk/sunxi-ng/ccu_nm.h
> +++ b/drivers/clk/sunxi-ng/ccu_nm.h
> @@ -108,7 +108,7 @@ struct ccu_nm {
>  		},					
		\
>  	}
> 
> -#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(_struct, _name,	\
> +#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT(_struct, _name,	\
>  						 _parent, 
_reg,		\
>  						 _min_rate, 
_max_rate,	\
>  						 _nshift, 
_nwidth,	\
> @@ -116,7 +116,8 @@ struct ccu_nm {
>  						 _frac_en, 
_frac_sel,	\
>  						 
_frac_rate_0,		\
>  						 
_frac_rate_1,		\
> -						 _gate, 
_lock, _flags)	\
> +						 _gate, 
_lock, _flags,	\
> +						 _features)	
	\
>  	struct ccu_nm _struct = {					
\
>  		.enable		= _gate,			
	\
>  		.lock		= _lock,			
	\
> @@ -129,7 +130,7 @@ struct ccu_nm {
>  		.max_rate	= _max_rate,				
\
>  		.common		= {				
	\
>  			.reg		= _reg,		
		\
> -			.features	= CCU_FEATURE_FRACTIONAL,	
\
> +			.features	= _features,			
\
>  			.hw.init	= CLK_HW_INIT(_name,		
\
>  						      
_parent,		\
>  						      
&ccu_nm_ops,	\
> @@ -137,6 +138,47 @@ struct ccu_nm {
>  		},					
		\
>  	}
> 
> +#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(_struct, _name,	\
> +						 _parent, 
_reg,		\
> +						 _min_rate, 
_max_rate,	\
> +						 _nshift, 
_nwidth,	\
> +						 _mshift, 
_mwidth,	\
> +						 _frac_en, 
_frac_sel,	\
> +						 
_frac_rate_0,		\
> +						 
_frac_rate_1,		\
> +						 _gate, 
_lock, _flags)	\
> +	SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT(_struct, _name,	\
> +						_parent, 
_reg,		\
> +						_min_rate, 
_max_rate,	\
> +						_nshift, 
_nwidth,	\
> +						_mshift, 
_mwidth,	\
> +						_frac_en, 
_frac_sel,	\
> +						
_frac_rate_0,		\
> +						
_frac_rate_1,		\
> +						_gate, 
_lock, _flags,	\
> +						
CCU_FEATURE_FRACTIONAL)
> +
> +#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST(_struct, _name, \
> +						 _parent, 
_reg,		\
> +						 _min_rate, 
_max_rate,	\
> +						 _nshift, 
_nwidth,	\
> +						 _mshift, 
_mwidth,	\
> +						 _frac_en, 
_frac_sel,	\
> +						 
_frac_rate_0,		\
> +						 
_frac_rate_1,		\
> +						 _gate, 
_lock, _flags)	\
> +	SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT(_struct, _name,	\
> +						_parent, 
_reg,		\
> +						_min_rate, 
_max_rate,	\
> +						_nshift, 
_nwidth,	\
> +						_mshift, 
_mwidth,	\
> +						_frac_en, 
_frac_sel,	\
> +						
_frac_rate_0,		\
> +						
_frac_rate_1,		\
> +						_gate, 
_lock, _flags,	\
> +						
CCU_FEATURE_FRACTIONAL |\
> +						
CCU_FEATURE_CLOSEST_RATE)
> +
>  #define SUNXI_CCU_NM_WITH_GATE_LOCK(_struct, _name, _parent, _reg,	\
>  				    _nshift, _nwidth,		
	\
>  				    _mshift, _mwidth,		
	\




