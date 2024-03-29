Return-Path: <linux-kernel+bounces-124790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4C0891C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD461F21F1F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D63189A54;
	Fri, 29 Mar 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Nm+Bbixr"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A6189225
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716144; cv=none; b=uIl28+YJbELTpWrQxvo75SYalO4fByzXt2aTn2CSVlSQUjf74QNYtiHIk5Zh0X45iEEqxNXPz7IxgeghyUxxtaPT8cSdVg51ciWkl1wKJIIxo35PjGFgl2VPP63e/QCF7GyBqtqb4KXkpdOaKn+j1MrU7X7E806DgdpYy0CKMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716144; c=relaxed/simple;
	bh=aW75Pf5PCkrJMf1ksZuRg3I8Ka7EdMqN9hNvjaTVqXo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=TW9mKD5iv4hVmaS5cDgqTTPoqS/pNqrfPtFNOf88b7grOa9gvcIBCiLZF12ckdZSBY11r7sGNJ8tUkWRDlDO1LMJZIH3zP/ty7A6wrhEsnsoC8nZOPvgRohjwZlglUSc9oqSCvxMlwg4/vz3HpLuoAm1+zIH9UBccRLFZhMewaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Nm+Bbixr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33fd8a2a407so1306765f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 05:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711716139; x=1712320939; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=gxIUq/XIwTd2Gc2JEpjZeBosj5SKpZKViU9S1xrv8oA=;
        b=Nm+BbixrmM+RP2kZGcbe1iIHKgatd/epCXiAdEvPZERhP/5f/AUMY5jagbn0f7TzPF
         O2KL5sk9Jhm5kfHa1E+7m3m9DgYf2REO92BZPuu+HAKe6qKVrG9A9lWCQ0kAW1ujtqoL
         yN/sAIUys2Dka/1N1BeBdOAMoBmSTG6e6spePGQG7Hs5gsjX3CzlrzxRPjNrnm7XYaJs
         mMLez4rrCwcDZrPu6+3i8C/EgciUorLuummVhNlMrAxUcfd4JtR8dsCEsWtGy2SlInvu
         ZiUHYpsVZVELUrcaCn6/dg2KJ0QIG9Cgo7vXoWNFgqRd0s4dHWBmJh3zC0myN0LqK0Mg
         5HDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711716139; x=1712320939;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxIUq/XIwTd2Gc2JEpjZeBosj5SKpZKViU9S1xrv8oA=;
        b=OaWUoqZCW4Rdelu7PQpffcM2+bZbRHRLq4NnMpv0n8KyfivuHMBFz7yU2+g6EIpAAx
         vGTqgSV0Px5FDF0021dAqcBhmfWDod99vYzpucUBjD/4lk0/hHyw4NRVYn0O796nlv67
         uEwjXmtKYmSDc5TiG4x2JsA9Jqf7aqMCoIvXRQvXX+6+YovcyJXBpK+sM46zmjTw5oHi
         Da7qtD90Ffmi3KmYFIkEGiRD/HmMjI+SHDpj+SqIW+qGP83BVOsJ33l1xb3DT2ch/iv6
         NeFRO2hDiIkCyEynNknnMCkZUAB9wTuBKgJvOhsmjz6xPgkwbqKBtxPA3531dzxHaMS/
         sq9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPNpFnNAi0IyvPjTx+NJOjVi+FLl8O1KumJ0CSmt8kwQypTdtPW7aV16bLqxcyi3fHSuP3gkusnna4oAG9Uh+Rif9y2WcMG/8rJ8BJ
X-Gm-Message-State: AOJu0Yxw+OyftOGhNjnS5OsvZpsjIg1ySwpgmJbYHqJQ9VssJ6MUmc1/
	yD1Z9Ncf60cGlf/aHVHxRL10XUEi91bMVvBNyQ03ybPiBrdIvNnYYGEqP1Qy2zE=
X-Google-Smtp-Source: AGHT+IFmRrWRL7hTq/l4Iz/3FrZli79Wex7IvqjNpeiE1QS/yuVWtde+4D/dIohJP9FpdUBEQoTyuw==
X-Received: by 2002:adf:f18f:0:b0:341:a640:b516 with SMTP id h15-20020adff18f000000b00341a640b516mr1257720wro.70.1711716139601;
        Fri, 29 Mar 2024 05:42:19 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:f8f5:63d4:de5b:e4de])
        by smtp.gmail.com with ESMTPSA id ch9-20020a5d5d09000000b0034330c9eccasm3640999wrb.79.2024.03.29.05.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 05:42:19 -0700 (PDT)
References: <20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-0-04f55de44604@linaro.org>
 <20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-3-04f55de44604@linaro.org>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Nicolas Belin <nbelin@baylibre.com>,
 Jagan Teki <jagan@amarulasolutions.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v11 3/7] clk: meson: g12a: make VCLK2 and ENCL clock
 path configurable by CCF
Date: Fri, 29 Mar 2024 13:35:11 +0100
In-reply-to: <20240325-amlogic-v6-4-upstream-dsi-ccf-vim3-v11-3-04f55de44604@linaro.org>
Message-ID: <1jv8558b11.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Mon 25 Mar 2024 at 12:09, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> In order to setup the DSI clock, let's make the unused VCLK2 clock path
> configuration via CCF.
>
> The nocache option is removed from following clocks:
> - vclk2_sel
> - vclk2_input
> - vclk2_div
> - vclk2
> - vclk_div1
> - vclk2_div2_en
> - vclk2_div4_en
> - vclk2_div6_en
> - vclk2_div12_en
> - vclk2_div2
> - vclk2_div4
> - vclk2_div6
> - vclk2_div12
> - cts_encl_sel
>
> vclk2 and vclk2_div uses the newly introduced vclk regmap driver
> to handle the enable and reset bits.
>
> In order to set a rate on cts_encl via the vclk2 clock path,
> the NO_REPARENT flag is set on cts_encl_sel & vclk2_sel in order
> to keep CCF from selection a parent.
> The parents of cts_encl_sel & vclk2_sel are expected to be defined
> in DT or manually set by the display driver at some point.
>
> The following clock scheme is to be used for DSI:
>
> xtal
> \_ gp0_pll_dco
>    \_ gp0_pll
>       |- vclk2_sel
>       |  \_ vclk2_input
>       |     \_ vclk2_div
>       |        \_ vclk2
>       |           \_ vclk2_div1
>       |              \_ cts_encl_sel
>       |                 \_ cts_encl	-> to VPU LCD Encoder
>       |- mipi_dsi_pxclk_sel
>       \_ mipi_dsi_pxclk_div
>          \_ mipi_dsi_pxclk		-> to DSI controller
>
> The mipi_dsi_pxclk_div is set as bypass with a single /1 entry in div_table
> in order to use the same GP0 for mipi_dsi_pxclk and vclk2_input.
>
> The SET_RATE_PARENT is only set on the mipi_dsi_pxclk_sel clock so the
> DSI bitclock is the reference base clock to calculate the vclk2_div value
> when pixel clock is set on the cts_encl endpoint.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/clk/meson/Kconfig |  1 +
>  drivers/clk/meson/g12a.c  | 72 ++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 53 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 8a9823789fa3..59a40a49f8e1 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -144,6 +144,7 @@ config COMMON_CLK_G12A
>  	select COMMON_CLK_MESON_EE_CLKC
>  	select COMMON_CLK_MESON_CPU_DYNDIV
>  	select COMMON_CLK_MESON_VID_PLL_DIV
> +	select COMMON_CLK_MESON_VCLK
>  	select MFD_SYSCON
>  	help
>  	  Support for the clock controller on Amlogic S905D2, S905X2 and S905Y2
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 90f4c6103014..083882e53b65 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -22,6 +22,7 @@
>  #include "clk-regmap.h"
>  #include "clk-cpu-dyndiv.h"
>  #include "vid-pll-div.h"
> +#include "vclk.h"
>  #include "meson-eeclk.h"
>  #include "g12a.h"
>  
> @@ -3165,7 +3166,7 @@ static struct clk_regmap g12a_vclk2_sel = {
>  		.ops = &clk_regmap_mux_ops,
>  		.parent_hws = g12a_vclk_parent_hws,
>  		.num_parents = ARRAY_SIZE(g12a_vclk_parent_hws),
> -		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
> +		.flags = CLK_SET_RATE_NO_REPARENT,
>  	},
>  };
>  
> @@ -3193,7 +3194,6 @@ static struct clk_regmap g12a_vclk2_input = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2_sel.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>  	},
>  };
>  
> @@ -3215,19 +3215,32 @@ static struct clk_regmap g12a_vclk_div = {
>  };
>  
>  static struct clk_regmap g12a_vclk2_div = {
> -	.data = &(struct clk_regmap_div_data){
> -		.offset = HHI_VIID_CLK_DIV,
> -		.shift = 0,
> -		.width = 8,
> +	.data = &(struct meson_vclk_div_data){
> +		.div = {
> +			.reg_off = HHI_VIID_CLK_DIV,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.enable = {
> +			.reg_off = HHI_VIID_CLK_DIV,
> +			.shift   = 16,
> +			.width   = 1,
> +		},
> +		.reset = {
> +			.reg_off = HHI_VIID_CLK_DIV,
> +			.shift   = 17,
> +			.width   = 1,
> +		},
> +		.flags = CLK_DIVIDER_ROUND_CLOSEST,
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "vclk2_div",
> -		.ops = &clk_regmap_divider_ops,
> +		.ops = &meson_vclk_div_ops,
>  		.parent_hws = (const struct clk_hw *[]) {
>  			&g12a_vclk2_input.hw
>  		},
>  		.num_parents = 1,
> -		.flags = CLK_GET_RATE_NOCACHE,
> +		.flags = CLK_SET_RATE_GATE,
>  	},
>  };
>  
> @@ -3246,16 +3259,24 @@ static struct clk_regmap g12a_vclk = {
>  };
>  
>  static struct clk_regmap g12a_vclk2 = {
> -	.data = &(struct clk_regmap_gate_data){
> -		.offset = HHI_VIID_CLK_CNTL,
> -		.bit_idx = 19,
> +	.data = &(struct meson_vclk_gate_data){
> +		.enable = {
> +			.reg_off = HHI_VIID_CLK_CNTL,
> +			.shift   = 19,
> +			.width   = 1,
> +		},
> +		.reset = {
> +			.reg_off = HHI_VIID_CLK_CNTL,
> +			.shift   = 15,
> +			.width   = 1,
> +		},
>  	},
>  	.hw.init = &(struct clk_init_data) {
>  		.name = "vclk2",
> -		.ops = &clk_regmap_gate_ops,
> +		.ops = &meson_vclk_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2_div.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3339,7 +3360,7 @@ static struct clk_regmap g12a_vclk2_div1 = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3353,7 +3374,7 @@ static struct clk_regmap g12a_vclk2_div2_en = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3367,7 +3388,7 @@ static struct clk_regmap g12a_vclk2_div4_en = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3381,7 +3402,7 @@ static struct clk_regmap g12a_vclk2_div6_en = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3395,7 +3416,7 @@ static struct clk_regmap g12a_vclk2_div12_en = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &g12a_vclk2.hw },
>  		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3461,6 +3482,7 @@ static struct clk_fixed_factor g12a_vclk2_div2 = {
>  			&g12a_vclk2_div2_en.hw
>  		},
>  		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3474,6 +3496,7 @@ static struct clk_fixed_factor g12a_vclk2_div4 = {
>  			&g12a_vclk2_div4_en.hw
>  		},
>  		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3487,6 +3510,7 @@ static struct clk_fixed_factor g12a_vclk2_div6 = {
>  			&g12a_vclk2_div6_en.hw
>  		},
>  		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3500,6 +3524,7 @@ static struct clk_fixed_factor g12a_vclk2_div12 = {
>  			&g12a_vclk2_div12_en.hw
>  		},
>  		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> @@ -3561,7 +3586,7 @@ static struct clk_regmap g12a_cts_encl_sel = {
>  		.ops = &clk_regmap_mux_ops,
>  		.parent_hws = g12a_cts_parent_hws,
>  		.num_parents = ARRAY_SIZE(g12a_cts_parent_hws),
> -		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
> +		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
>  	},
>  };
>  
> @@ -3717,15 +3742,22 @@ static struct clk_regmap g12a_mipi_dsi_pxclk_sel = {
>  		.ops = &clk_regmap_mux_ops,
>  		.parent_hws = g12a_mipi_dsi_pxclk_parent_hws,
>  		.num_parents = ARRAY_SIZE(g12a_mipi_dsi_pxclk_parent_hws),
> -		.flags = CLK_SET_RATE_NO_REPARENT,
> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
>  	},
>  };
>  
> +/* Force as bypass by forcing a single /1 table entry, and not rely of boot value */

The comment here is not entirely accurate.

The table below will actually force to only use a 1 divider on
set_rate(), not on boot, AFAICT.

The boot value will stay in the register until the first call to set_rate().

Considering this is quite fragile as it is, It would be nice to prefix
the updated comment with "FIXME"

> +static const struct clk_div_table g12a_mipi_dsi_pxclk_div_table[] = {
> +	{ .val = 0, .div = 1 },
> +	{ /* sentinel */ },
> +};
> +
>  static struct clk_regmap g12a_mipi_dsi_pxclk_div = {
>  	.data = &(struct clk_regmap_div_data){
>  		.offset = HHI_MIPIDSI_PHY_CLK_CNTL,
>  		.shift = 0,
>  		.width = 7,
> +		.table = g12a_mipi_dsi_pxclk_div_table,
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "mipi_dsi_pxclk_div",


-- 
Jerome

