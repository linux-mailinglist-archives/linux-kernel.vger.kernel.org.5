Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A83477157B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjHFN5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHFN5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:57:08 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B4B102;
        Sun,  6 Aug 2023 06:57:06 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RJgxC5Jwjz9sbh;
        Sun,  6 Aug 2023 15:57:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691330223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UWdULM/cMKhvgQZZICo8f8j2JPsZ03rAx8n6aRyuTRA=;
        b=cRrsE4QE68olJg41DT12TrP6oz9WiyLfh3ctxU8hb6u72TCHbjPe9kNDHQEtpjCu5h4CrJ
        G8sKs9jUK90tY8wNxFnRYBsd8ksnBchzceLuUYuW4BZ6KDans2C1W9qgmtgfk4V4FeGZaf
        WSKB+PIQbC3x8SfejzP9l6fLvB9cBoLFe3ccIfsg6N+I9VWqkUB/OtaDlXNJpr/LcmZkma
        ong5/6JgPHopQGK0/5/J/auUoD8jDqYB64gEgz9MIZ3aLTZ5zRMn8yf3seQSJrWaimAagW
        srxG6/Q4OkM0Rb0EE0G8idbPWvLQvgbsFCV4KB0Eo0gRqB0Rkiw+V8y5h10KiA==
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
 <20230806-pll-mipi_set_rate_parent-v5-2-db4f5ca33fc3@oltmanns.dev>
 <3752134.kQq0lBPeGt@jernej-laptop>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/11] clk: sunxi-ng: nkm: consider alternative
 parent rates when determining rate
In-reply-to: <3752134.kQq0lBPeGt@jernej-laptop>
Date:   Sun, 06 Aug 2023 15:57:00 +0200
Message-ID: <87h6pc9sur.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-08-06 at 15:32:29 +0200, Jernej =C5=A0krabec <jernej.skrabec@gmail.=
com> wrote:
> Dne nedelja, 06. avgust 2023 ob 15:06:47 CEST je Frank Oltmanns napisal(a=
):
>> In case the CLK_SET_RATE_PARENT flag is set, consider using a different
>> parent rate when determining a new rate.
>>
>> To find the best match for the requested rate, perform the following
>> steps for each NKM combination:
>>  - calculate the optimal parent rate,
>>  - find the best parent rate that the parent clock actually supports
>>  - use that parent rate to calculate the effective rate.
>>
>> In case the clk does not support setting the parent rate, use the same
>> algorithm as before.
>>
>> Acked-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>> ---
>>  drivers/clk/sunxi-ng/ccu_nkm.c | 45
>> +++++++++++++++++++++++++++++++++++++++++- 1 file changed, 44
>> insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_n=
km.c
>> index f267142e58b3..ea1b77e9b57f 100644
>> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
>> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
>> @@ -6,6 +6,7 @@
>>
>>  #include <linux/clk-provider.h>
>>  #include <linux/io.h>
>> +#include <linux/math.h>
>
> Why do you need above include?

It's not needed. It's a leftover from an earlier version. I'll remove it
in v6.

Thank you for your review,
  Frank

>
> Best regards,
> Jernej
>
>>
>>  #include "ccu_gate.h"
>>  #include "ccu_nkm.h"
>> @@ -16,6 +17,45 @@ struct _ccu_nkm {
>>  	unsigned long	m, min_m, max_m;
>>  };
>>
>> +static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw
>> *parent_hw, +
>        unsigned long *parent, unsigned long rate,
>> +
> struct _ccu_nkm *nkm)
>> +{
>> +	unsigned long best_rate =3D 0, best_parent_rate =3D *parent, tmp_parent
> =3D
>> *parent; +	unsigned long best_n =3D 0, best_k =3D 0, best_m =3D 0;
>> +	unsigned long _n, _k, _m;
>> +
>> +	for (_k =3D nkm->min_k; _k <=3D nkm->max_k; _k++) {
>> +		for (_n =3D nkm->min_n; _n <=3D nkm->max_n; _n++) {
>> +			for (_m =3D nkm->min_m; _m <=3D nkm->max_m; _m++)
> {
>> +				unsigned long tmp_rate;
>> +
>> +				tmp_parent =3D
> clk_hw_round_rate(parent_hw, rate * _m / (_n * _k));
>> +
>> +				tmp_rate =3D tmp_parent * _n * _k /
> _m;
>> +				if (tmp_rate > rate)
>> +					continue;
>> +
>> +				if ((rate - tmp_rate) < (rate -
> best_rate)) {
>> +					best_rate =3D tmp_rate;
>> +					best_parent_rate =3D
> tmp_parent;
>> +					best_n =3D _n;
>> +					best_k =3D _k;
>> +					best_m =3D _m;
>> +				}
>> +			}
>> +		}
>> +	}
>> +
>> +	nkm->n =3D best_n;
>> +	nkm->k =3D best_k;
>> +	nkm->m =3D best_m;
>> +
>> +	*parent =3D best_parent_rate;
>> +
>> +	return best_rate;
>> +}
>> +
>>  static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned l=
ong
>> rate, struct _ccu_nkm *nkm)
>>  {
>> @@ -124,7 +164,10 @@ static unsigned long ccu_nkm_round_rate(struct
>> ccu_mux_internal *mux, if (nkm->common.features &
>> CCU_FEATURE_FIXED_POSTDIV)
>>  		rate *=3D nkm->fixed_post_div;
>>
>> -	rate =3D ccu_nkm_find_best(*parent_rate, rate, &_nkm);
>> +	if (!clk_hw_can_set_rate_parent(&nkm->common.hw))
>> +		rate =3D ccu_nkm_find_best(*parent_rate, rate, &_nkm);
>> +	else
>> +		rate =3D ccu_nkm_find_best_with_parent_adj(parent_hw,
> parent_rate, rate,
>> &_nkm);
>>
>>  	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>>  		rate /=3D nkm->fixed_post_div;
