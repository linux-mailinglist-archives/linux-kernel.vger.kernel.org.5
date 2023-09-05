Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5E5793040
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjIEUr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjIEUr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:47:27 -0400
X-Greylist: delayed 426 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:47:24 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F02113;
        Tue,  5 Sep 2023 13:47:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4527CC433C7;
        Tue,  5 Sep 2023 20:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693946418;
        bh=6OpsPJP4XjfqnisD11vFNxFbp8JALAsZzg5eN/wcwUg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=c/4JUAHjqfywDpLHsZ6vXB0Y2whTeGW+/I21fqhL7dGUG72ukus6qcVyuXheR3rz6
         n/DOXc4aOPdBRdkZfscvkcBTs1+GC2SbsWImyz3y5FmPKGcaAiXakzp3VkBd7Lsu/U
         THt56ogfx8nWgz6IOFuMrED5rZbEHESv2E8y+K/XDZOFyJAOkiJVFREuo3rE9t/IQN
         ng9sAnY/AkdWyzmGZmJMOUImX1RKxPy8a6ruO6NxrAhF9QrsZ2drou2P/qrhskVSXZ
         Tou/LKRpEjSXSB6yRZMf8VpwSuakeoS5cPVPvBbKgYuwCn+5V+Jomp7jGnXSjV/x1r
         /vbS8B7bDliNg==
Message-ID: <3fe1655e30d62493a24e1f97ab7bf710.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230901070041.13463-1-quic_devipriy@quicinc.com>
References: <20230901070041.13463-1-quic_devipriy@quicinc.com>
Subject: Re: [PATCH V2] clk: qcom: clk-alpha-pll: Use determine_rate instead of round_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_devipriy@quicinc.com, quic_saahtoma@quicinc.com
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
Date:   Tue, 05 Sep 2023 13:40:15 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Devi Priya (2023-09-01 00:00:41)
> The round_rate() API returns a long value as the errors are reported using
> negative error codes. This leads to long overflow when the clock rate
> exceeds 2GHz.As the clock controller treats the clock rate above signed
> long max as an error, use determine_rate in place of round_rate as the
> determine_rate API does not possess such limitations.

Does this fix something, or is it preparing for PLLs that run faster
than 2GHz?

>=20
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V2:
>         - Updated divider_round_rate to divider_determine_rate as=20
>           suggested by Stephen Boyd.
>=20
>  drivers/clk/qcom/clk-alpha-pll.c | 125 +++++++++++++++++--------------
>  1 file changed, 68 insertions(+), 57 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alph=
a-pll.c
> index 1c2a72840cd2..de2b7e2784ec 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -2353,22 +2362,24 @@ static unsigned long clk_rivian_evo_pll_recalc_ra=
te(struct clk_hw *hw,
>         return parent_rate * l;
>  }
> =20
> -static long clk_rivian_evo_pll_round_rate(struct clk_hw *hw, unsigned lo=
ng rate,
> -                                         unsigned long *prate)
> +static int clk_rivian_evo_pll_determine_rate(struct clk_hw *hw,
> +                                            struct clk_rate_request *req)
>  {
>         struct clk_alpha_pll *pll =3D to_clk_alpha_pll(hw);
>         unsigned long min_freq, max_freq;
>         u32 l;
>         u64 a;
> =20
> -       rate =3D alpha_pll_round_rate(rate, *prate, &l, &a, 0);
> -       if (!pll->vco_table || alpha_pll_find_vco(pll, rate))
> -               return rate;
> +       req->rate =3D alpha_pll_round_rate(req->rate, req->best_parent_ra=
te,
> +                                        &l, &a, 0);
> +       if (!pll->vco_table || alpha_pll_find_vco(pll, req->rate))
> +               return 0;
> =20
>         min_freq =3D pll->vco_table[0].min_freq;
>         max_freq =3D pll->vco_table[pll->num_vco - 1].max_freq;
> =20
> -       return clamp(rate, min_freq, max_freq);
> +       req->rate =3D clamp(req->rate, min_freq, max_freq);
> +       return 0;
>  }

Is this any different from clk_alpha_pll_determine_rate()? I think the
only difference is alpha_pll_width, which could probably be some
argument passed to an alpha_pll_determine_rate() function that does the
internal clamping. It could also take a struct clk_rate_request then so
that we don't pass individual members of that struct.
