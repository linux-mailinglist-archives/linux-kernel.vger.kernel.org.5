Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E974771565
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjHFNmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjHFNmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:42:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEB3CF;
        Sun,  6 Aug 2023 06:42:37 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bcc0adab4so538004466b.2;
        Sun, 06 Aug 2023 06:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691329356; x=1691934156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LoHGPu8IpfDYgrD6hmP69AEq8M3KHDNqeucyT7xavk=;
        b=e31EXnHqqydR0vQ7KcOdhFsm9djEjHw2KOfQ3MAUdRmWPTth/JJGWamB+KTuVk/E9n
         0hLyOXbCAkPIx0Ly6lrqrhAW/nMU0SKSnboLKsmWK2Vm06XBBCxbFlgd/A5VqEJJQ3oH
         p0HG5B1wIKIgl3FMmYXo0NuZoCxHXX9EYo8BJvpOkwl9ulH0kfY7eC+ctrYagQH+GDnn
         G9JE1qdlij9WzZWZx43qV5AtHUmAYUWk6qIKOkyLADrjQhD3l7hn12m/vPP82jR/KMW0
         pwHB+Xet82ZSTe0vTuWXgpY+e8Ash5nEHc3CWcLqg2XjFt+6eu7f9Jejf+ddCwj0TfTs
         OAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691329356; x=1691934156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LoHGPu8IpfDYgrD6hmP69AEq8M3KHDNqeucyT7xavk=;
        b=ALFkrwSeIycV2vlYOkSRN5c7e0Lnbqikr7Sb/lHyA5HCGzSOi9IbNkatG2/k3CnmD8
         h4CmTnZkFu6ot0LlR6yEHn9YxAQOiEOGkPjsQ0C674WC8t88KylaOqrTcXHhAmOJX3hY
         F0s1kCKnobU3Gtsckb53oWlUJWZYjkO6Djp7ClRUks1odq75VEEeMaV9fUgiuLchSIq3
         hSsReXfe8AMwV9lCcbv9gOJq2XrCHzpH0pURfg50bRMuO8VhWDEmyx0QsS9M+EXWZHZx
         NRXBXziP96syIFjtjL0qEFhc2ajB0R2xNQ1TABtLjwHOp5GxSYX+90ZR/3V2QGZfLFcS
         c+VQ==
X-Gm-Message-State: AOJu0YzlcO1F3VGDJzR2shrglHwM3cxn6Ms7IpNQPUjeOljghfFvnRUH
        YnEn5nuqrvAgP4SR65uXTpQ=
X-Google-Smtp-Source: AGHT+IHt8eOgUZMwTJFbpuI4I0oAJPsetlSgPXbGhOvSfkEKVilaWQIYmTqAhEXpAUA4dllBBHhjGA==
X-Received: by 2002:a17:906:3f48:b0:99b:ed53:5c12 with SMTP id f8-20020a1709063f4800b0099bed535c12mr5184402ejj.17.1691329356069;
        Sun, 06 Aug 2023 06:42:36 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id c9-20020a170906d18900b0099bc038eb2bsm3898285ejz.58.2023.08.06.06.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 06:42:35 -0700 (PDT)
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
Subject: Re: [PATCH v5 09/11] clk: sunxi-ng: div: Support finding closest rate
Date:   Sun, 06 Aug 2023 15:42:34 +0200
Message-ID: <3570165.R56niFO833@jernej-laptop>
In-Reply-To: <20230806-pll-mipi_set_rate_parent-v5-9-db4f5ca33fc3@oltmanns.dev>
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
 <20230806-pll-mipi_set_rate_parent-v5-9-db4f5ca33fc3@oltmanns.dev>
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

Dne nedelja, 06. avgust 2023 ob 15:06:54 CEST je Frank Oltmanns napisal(a):
> Add initalization macros for divisor clocks with mux
> (SUNXI_CCU_M_WITH_MUX) to support finding the closest rate. This clock
> type requires the appropriate flags to be set in the .common structure
> (for the mux part of the clock) and the .div part.
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu_div.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_div.h
> index 948e2b0c0c3b..90d49ee8e0cc 100644
> --- a/drivers/clk/sunxi-ng/ccu_div.h
> +++ b/drivers/clk/sunxi-ng/ccu_div.h
> @@ -143,6 +143,26 @@ struct ccu_div {
>  		},					
		\
>  	}
> 
> +#define SUNXI_CCU_M_WITH_MUX_TABLE_GATE_CLOSEST(_struct, _name,		
\
> +						_parents, 
_table,	\
> +						_reg,		
	\
> +						_mshift, 
_mwidth,	\
> +						_muxshift, 
_muxwidth,	\
> +						_gate, 
_flags)		\
> +	struct ccu_div _struct = {					
\
> +		.enable	= _gate,				
	\
> +		.div	= _SUNXI_CCU_DIV_FLAGS(_mshift, _mwidth, 
CLK_DIVIDER_ROUND_CLOSEST),
> \ +		.mux	= _SUNXI_CCU_MUX_TABLE(_muxshift, _muxwidth, 
_table), \
> +		.common	= {					
	\
> +			.reg		= _reg,			
	\
> +			.hw.init	= CLK_HW_INIT_PARENTS(_name,	
\
> +							      
_parents, \
> +							      
&ccu_div_ops, \
> +							      
_flags),	\
> +			.features	= CCU_FEATURE_CLOSEST_RATE,	
\
> +		},						
	\
> +	}
> +
>  #define SUNXI_CCU_M_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
>  				  _mshift, _mwidth, _muxshift, 
_muxwidth, \
>  				  _gate, _flags)		
	\
> @@ -152,6 +172,16 @@ struct ccu_div {
>  					_muxshift, _muxwidth,	
	\
>  					_gate, _flags)
> 
> +#define SUNXI_CCU_M_WITH_MUX_GATE_CLOSEST(_struct, _name, _parents,	
\
> +					  _reg, _mshift, 
_mwidth,	\
> +					  _muxshift, _muxwidth,	
	\
> +					  _gate, _flags)	
	\
> +	SUNXI_CCU_M_WITH_MUX_TABLE_GATE_CLOSEST(_struct, _name,		
\
> +						_parents, 
NULL,		\
> +						_reg, 
_mshift, _mwidth,	\
> +						_muxshift, 
_muxwidth,	\
> +						_gate, 
_flags)
> +
>  #define SUNXI_CCU_M_WITH_MUX(_struct, _name, _parents, _reg,		
\
>  			     _mshift, _mwidth, _muxshift, _muxwidth,	
\
>  			     _flags)				
	\




