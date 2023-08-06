Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A1C771549
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjHFNci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHFNcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:32:35 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F714C9;
        Sun,  6 Aug 2023 06:32:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so56693931fa.2;
        Sun, 06 Aug 2023 06:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691328751; x=1691933551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkF8V9SS0Dv10Mhzf8yo4sbGOfqu3VWFivFwQBx9BP8=;
        b=SuQitmxEhvU/1w8QJiYfUxj+Tqz5kpgI3A5tIKj/rSs862S8vCH8MYUKDKMz5zUVr2
         0veZrYBG3IiXFiUORkM5LcDl450UGWI2KZpsBJWezv5ht15CK3VbaRnyBmVD4gvpk0J1
         M7KYnuRGzSEeBAAeY8Xe2hfdmkitvFpwH5aJFbPFyKjGKXNR5Ql61lsPJzsQOdd0fT+h
         SdVYCmteP0u5atDkkokhz4bak8dQrPAGwlHE5Wxk+Pud2kOusRexueld61C2UMZmRpLa
         UKK1pJR3yGnPXmETF5Knr27eWtB72fE/wBpsMIaWcYjwS8SEgFXOaXM9uI7B760gYN43
         cSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691328751; x=1691933551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkF8V9SS0Dv10Mhzf8yo4sbGOfqu3VWFivFwQBx9BP8=;
        b=Rj0fQIgeW1uX0EgQgUtOYS/5v+ROM2voCnk4f2dvvkDJSTe/JBpKI17I24Yd8xe4nv
         2QGX2mon8JCzkWlfjeEgZo4EP/4T5XFgVwCCseVTrxHnwBeVTOtOtCsOmk7mA58iFM66
         xAOhEOPsU1/6kN018SPpE1tAX1F9PDuJGXfm2mzPJhIUHJrlP/iY8CL+8svu1LVD5CS5
         R3/Xua61fpCTKQkH0pMtgCimIzu1u3SkvSm21IQ14HC4LqeH08ZN7P/uCO7gfQqDYasD
         PlsBlySplKJZXpTIh5dCNZjO/xXR6lbSekSTyRqlxBb6tY5z7wzeXwGb1sne+YjvxLhW
         96HA==
X-Gm-Message-State: AOJu0Yy+XczmNNlU5k1NY0Bwhv0Qsyy+KHCudxGPt69MMqoMTrTKeFcY
        rhnv0uJn9Qp+SG1uckBdf+c=
X-Google-Smtp-Source: AGHT+IG8L0BCJQj+X/JTbu7KGvHDe3BekcFFTKfTsvi0Xii9e25tarI8/ohJObfCqVIqTL9ftLKh3w==
X-Received: by 2002:ac2:4db0:0:b0:4fe:8c4:44f6 with SMTP id h16-20020ac24db0000000b004fe08c444f6mr4148158lfe.56.1691328751029;
        Sun, 06 Aug 2023 06:32:31 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id p23-20020a056402075700b0052237839229sm3912648edy.21.2023.08.06.06.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 06:32:30 -0700 (PDT)
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
Subject: Re: [PATCH v5 02/11] clk: sunxi-ng: nkm: consider alternative parent rates
 when determining rate
Date:   Sun, 06 Aug 2023 15:32:29 +0200
Message-ID: <3752134.kQq0lBPeGt@jernej-laptop>
In-Reply-To: <20230806-pll-mipi_set_rate_parent-v5-2-db4f5ca33fc3@oltmanns.dev>
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
 <20230806-pll-mipi_set_rate_parent-v5-2-db4f5ca33fc3@oltmanns.dev>
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

Dne nedelja, 06. avgust 2023 ob 15:06:47 CEST je Frank Oltmanns napisal(a):
> In case the CLK_SET_RATE_PARENT flag is set, consider using a different
> parent rate when determining a new rate.
> 
> To find the best match for the requested rate, perform the following
> steps for each NKM combination:
>  - calculate the optimal parent rate,
>  - find the best parent rate that the parent clock actually supports
>  - use that parent rate to calculate the effective rate.
> 
> In case the clk does not support setting the parent rate, use the same
> algorithm as before.
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
>  drivers/clk/sunxi-ng/ccu_nkm.c | 45
> +++++++++++++++++++++++++++++++++++++++++- 1 file changed, 44
> insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index f267142e58b3..ea1b77e9b57f 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -6,6 +6,7 @@
> 
>  #include <linux/clk-provider.h>
>  #include <linux/io.h>
> +#include <linux/math.h>

Why do you need above include?

Best regards,
Jernej

> 
>  #include "ccu_gate.h"
>  #include "ccu_nkm.h"
> @@ -16,6 +17,45 @@ struct _ccu_nkm {
>  	unsigned long	m, min_m, max_m;
>  };
> 
> +static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw
> *parent_hw, +						
       unsigned long *parent, unsigned long rate,
> +						       
struct _ccu_nkm *nkm)
> +{
> +	unsigned long best_rate = 0, best_parent_rate = *parent, tmp_parent 
=
> *parent; +	unsigned long best_n = 0, best_k = 0, best_m = 0;
> +	unsigned long _n, _k, _m;
> +
> +	for (_k = nkm->min_k; _k <= nkm->max_k; _k++) {
> +		for (_n = nkm->min_n; _n <= nkm->max_n; _n++) {
> +			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) 
{
> +				unsigned long tmp_rate;
> +
> +				tmp_parent = 
clk_hw_round_rate(parent_hw, rate * _m / (_n * _k));
> +
> +				tmp_rate = tmp_parent * _n * _k / 
_m;
> +				if (tmp_rate > rate)
> +					continue;
> +
> +				if ((rate - tmp_rate) < (rate - 
best_rate)) {
> +					best_rate = tmp_rate;
> +					best_parent_rate = 
tmp_parent;
> +					best_n = _n;
> +					best_k = _k;
> +					best_m = _m;
> +				}
> +			}
> +		}
> +	}
> +
> +	nkm->n = best_n;
> +	nkm->k = best_k;
> +	nkm->m = best_m;
> +
> +	*parent = best_parent_rate;
> +
> +	return best_rate;
> +}
> +
>  static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long
> rate, struct _ccu_nkm *nkm)
>  {
> @@ -124,7 +164,10 @@ static unsigned long ccu_nkm_round_rate(struct
> ccu_mux_internal *mux, if (nkm->common.features &
> CCU_FEATURE_FIXED_POSTDIV)
>  		rate *= nkm->fixed_post_div;
> 
> -	rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
> +	if (!clk_hw_can_set_rate_parent(&nkm->common.hw))
> +		rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
> +	else
> +		rate = ccu_nkm_find_best_with_parent_adj(parent_hw, 
parent_rate, rate,
> &_nkm);
> 
>  	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate /= nkm->fixed_post_div;




