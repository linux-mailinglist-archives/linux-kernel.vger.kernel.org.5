Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BE1771563
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjHFNml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjHFNme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:42:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D85CF;
        Sun,  6 Aug 2023 06:42:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c1c66876aso506639366b.2;
        Sun, 06 Aug 2023 06:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691329347; x=1691934147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3hZ38/+Ms3F1EqmzJCLkF+L8JHXcF7YJ7LY4cDwFEg=;
        b=SPzBm1YdBbtvTEIV1JOBdfR6CA0fgKzXZBB3wpp0DTUZhu9WgsbenYO9PqwDRLMJ+r
         jUk0+YHw+cvFBmxegiMNcXHMYOF0LhZdlj6PZMaO4b+GigEkBr/CTDrEdhkFkMIXspFH
         Ip1Loq5vDqKtT3Ze61BeOgsI1D43+YqY24LuqlLCs8Ovyp6p0DUE82gIDFRkDVCQyKaD
         PXV33GqvZvHkcbEzFA76iGfYKNP5/0TrzUXLyH9s1B2LkUdwYsenlOCyMqsdTg1C/3eS
         50Dwcfc8SbUpIPHleSHvIrasQoEzn/daEwOdElNh7dh8eAFugS7Z0Vrb1uve3j4xwfvA
         kGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691329347; x=1691934147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3hZ38/+Ms3F1EqmzJCLkF+L8JHXcF7YJ7LY4cDwFEg=;
        b=RxHNMxJmah+l1jMVg9sZQIcRdMHmwXlcIQ7Kj3L51vAx8Q4ii6ippi0h1p/L8IZ6sh
         Io2UsEqAGhouBPqlPjBdLqHP2ATgrtyQbD/4h0K4ZaUkviyu2Ld70xcjMEDpU+rwY6KJ
         xTG0b3iMWpYZQqNetO4WIUyW2k3ipZ+BklRbb5xie2uUShcY3j4cqea5DL1Ol8bgRP4j
         MV0uLUymYv3D5Gl3IwG46EPgZrHy1NCmk+vF1PBnAqnVqxBpmkHwSgEPWT4TPs2vV9J5
         w5BpVwDTzu3iU1/cpX0CKl5bU9PJ4UufkHFJV30/H54oFPF/Rd4RHHaMEBpGHGiSMoPV
         dOAQ==
X-Gm-Message-State: AOJu0YxEQ/zQodElquGbZS/t/mLCyAJDAx43WWpQBXhu2opdlNKw40LC
        D5Siz20axnuaapNSp6y8iBQ=
X-Google-Smtp-Source: AGHT+IFW16CLtR9BgIINux3nrolh4qCbKVx72XAqj9WGF2HfXwD3FMUWnvNuC60k/R3N18kMvhM8Qg==
X-Received: by 2002:a17:906:9bdb:b0:987:5761:2868 with SMTP id de27-20020a1709069bdb00b0098757612868mr5498868ejc.11.1691329346257;
        Sun, 06 Aug 2023 06:42:26 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id oz13-20020a170906cd0d00b00992b71d8f19sm1357934ejb.133.2023.08.06.06.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 06:42:25 -0700 (PDT)
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
Subject: Re: [PATCH v5 08/11] clk: sunxi-ng: mux: Support finding closest rate
Date:   Sun, 06 Aug 2023 15:42:24 +0200
Message-ID: <4283806.ejJDZkT8p0@jernej-laptop>
In-Reply-To: <20230806-pll-mipi_set_rate_parent-v5-8-db4f5ca33fc3@oltmanns.dev>
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
 <20230806-pll-mipi_set_rate_parent-v5-8-db4f5ca33fc3@oltmanns.dev>
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

Dne nedelja, 06. avgust 2023 ob 15:06:53 CEST je Frank Oltmanns napisal(a):
> When finding the best rate for a mux clock, consider rates that are
> higher than the requested rate when CCU_FEATURE_ROUND_CLOSEST is used.
> Furthermore, introduce an initialization macro that sets this flag.
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu_mux.c | 13 ++++++++++++-
>  drivers/clk/sunxi-ng/ccu_mux.h | 38 +++++++++++++++++++++++++++-----------
>  2 files changed, 39 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
> index 3ca695439620..5edc63b46651 100644
> --- a/drivers/clk/sunxi-ng/ccu_mux.c
> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
> @@ -242,6 +242,17 @@ static int ccu_mux_set_parent(struct clk_hw *hw, u8
> index) return ccu_mux_helper_set_parent(&cm->common, &cm->mux, index);
>  }
> 
> +static int ccu_mux_determine_rate(struct clk_hw *hw,
> +				  struct clk_rate_request *req)
> +{
> +	struct ccu_mux *cm = hw_to_ccu_mux(hw);
> +
> +	if (cm->common.features & CCU_FEATURE_CLOSEST_RATE)
> +		return clk_mux_determine_rate_flags(hw, req, 
CLK_MUX_ROUND_CLOSEST);
> +
> +	return clk_mux_determine_rate_flags(hw, req, 0);
> +}
> +
>  static unsigned long ccu_mux_recalc_rate(struct clk_hw *hw,
>  					 unsigned long 
parent_rate)
>  {
> @@ -259,7 +270,7 @@ const struct clk_ops ccu_mux_ops = {
>  	.get_parent	= ccu_mux_get_parent,
>  	.set_parent	= ccu_mux_set_parent,
> 
> -	.determine_rate	= __clk_mux_determine_rate,
> +	.determine_rate	= ccu_mux_determine_rate,
>  	.recalc_rate	= ccu_mux_recalc_rate,
>  };
>  EXPORT_SYMBOL_NS_GPL(ccu_mux_ops, SUNXI_CCU);
> diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
> index 2c1811a445b0..eb1172ebbd94 100644
> --- a/drivers/clk/sunxi-ng/ccu_mux.h
> +++ b/drivers/clk/sunxi-ng/ccu_mux.h
> @@ -46,20 +46,36 @@ struct ccu_mux {
>  	struct ccu_common	common;
>  };
> 
> +#define SUNXI_CCU_MUX_TABLE_WITH_GATE_FEAT(_struct, _name, _parents,
> _table,	\ +				     _reg, _shift, 
_width, _gate,		\
> +				     _flags, _features)		
		\
> +	struct ccu_mux _struct = {					
	\
> +		.enable	= _gate,				
		\
> +		.mux	= _SUNXI_CCU_MUX_TABLE(_shift, _width, 
_table),		\
> +		.common	= {					
		\
> +			.reg		= _reg,			
		\
> +			.hw.init	= CLK_HW_INIT_PARENTS(_name,	
	\
> +							      
_parents,		\
> +							      
&ccu_mux_ops,	\
> +							      
_flags),		\
> +			.features	= _features,			
	\
> +		}						
		\
> +	}
> +
> +#define SUNXI_CCU_MUX_TABLE_WITH_GATE_CLOSEST(_struct, _name, _parents,	
\
> +					      _table, _reg, 
_shift,	\
> +					      _width, _gate, 
_flags)	\
> +	SUNXI_CCU_MUX_TABLE_WITH_GATE_FEAT(_struct, _name, _parents,	
\
> +					   _table, _reg, 
_shift,	\
> +					   _width, _gate, 
_flags,	\
> +					   
CCU_FEATURE_CLOSEST_RATE)
> +
>  #define SUNXI_CCU_MUX_TABLE_WITH_GATE(_struct, _name, _parents, _table,	
\
>  				     _reg, _shift, _width, _gate,	
\
>  				     _flags)			
	\
> -	struct ccu_mux _struct = {					
\
> -		.enable	= _gate,				
	\
> -		.mux	= _SUNXI_CCU_MUX_TABLE(_shift, _width, 
_table),	\
> -		.common	= {					
	\
> -			.reg		= _reg,		
		\
> -			.hw.init	= CLK_HW_INIT_PARENTS(_name,	
\
> -							      
_parents, \
> -							      
&ccu_mux_ops, \
> -							      
_flags),	\
> -		}						
	\
> -	}
> +	SUNXI_CCU_MUX_TABLE_WITH_GATE_FEAT(_struct, _name, _parents,	
\
> +					   _table, _reg, 
_shift,	\
> +					   _width, _gate, 
_flags, 0)
> 
>  #define SUNXI_CCU_MUX_WITH_GATE(_struct, _name, _parents, _reg,		
\
>  				_shift, _width, _gate, _flags)	
	\




