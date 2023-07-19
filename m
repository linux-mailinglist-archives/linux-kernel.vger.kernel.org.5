Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21304759F3F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjGSUE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjGSUEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:04:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68922F0;
        Wed, 19 Jul 2023 13:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0E8E61807;
        Wed, 19 Jul 2023 20:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D7CC433C8;
        Wed, 19 Jul 2023 20:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689797091;
        bh=0iKypu0kymTeD57KjtrMnZG3ybCTpOA4DfWhM2jjUOU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=g4iAn8M9Y2zWazYP8g4VgHvj9qbowkKoguznJHd7M+5DI1D6NecNuwAsSEo2OpkSH
         xedrocvcG6ll1IIw5g1HA7Z6zzqRggLca8gUoCIFvv0MsafwvDHpYp1Mln46w9IMAX
         Yr5yDxfkpxY6SePMBzj0kJyjlrDa+CuabMqEWFqGWSTOybstNm0CPrz4R7Xy9mhd4v
         +Qzhp7SP09R7IXPzkDNeQyXgU0cXVPx4hGcgv9SiRIJEsYwzLKYUVMPvqfUUTPs8++
         lWTbCo//XArPpW0HDII69NIDvFx2kzTqHgn+DLDxp9Z8g0/GS6B8VGOCHCwF0YJKiW
         3NNjPA9rMrioQ==
Message-ID: <f726290fe0678217f2e17b6a68c20d42.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230710093206.18894-1-quic_devipriy@quicinc.com>
References: <20230710093206.18894-1-quic_devipriy@quicinc.com>
Subject: Re: [PATCH] clk: qcom: clk-alpha-pll: Use determine_rate instead of round_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_saahtoma@quicinc.com
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
Date:   Wed, 19 Jul 2023 13:04:48 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Devi Priya (2023-07-10 02:32:06)
> @@ -1094,25 +1099,25 @@ static const struct clk_div_table clk_alpha_2bit_=
div_table[] =3D {
>         { }
>  };
> =20
> -static long
> -clk_alpha_pll_postdiv_round_rate(struct clk_hw *hw, unsigned long rate,
> -                                unsigned long *prate)
> +static int clk_alpha_pll_postdiv_determine_rate(struct clk_hw *hw,
> +                                               struct clk_rate_request *=
req)
>  {
>         struct clk_alpha_pll_postdiv *pll =3D to_clk_alpha_pll_postdiv(hw=
);
>         const struct clk_div_table *table;
> +       unsigned long rate =3D req->rate;
> =20
>         if (pll->width =3D=3D 2)
>                 table =3D clk_alpha_2bit_div_table;
>         else
>                 table =3D clk_alpha_div_table;
> =20
> -       return divider_round_rate(hw, rate, prate, table,
> -                                 pll->width, CLK_DIVIDER_POWER_OF_TWO);
> +       req->rate =3D divider_round_rate(hw, rate, &req->best_parent_rate=
, table,

Can you use divider_determine_rate() instead?

> +                                      pll->width, CLK_DIVIDER_POWER_OF_T=
WO);
> +       return 0;
>  }
> =20
> -static long
> -clk_alpha_pll_postdiv_round_ro_rate(struct clk_hw *hw, unsigned long rat=
e,
> -                                   unsigned long *prate)
> +static int clk_alpha_pll_postdiv_determine_ro_rate(struct clk_hw *hw,
> +                                                  struct clk_rate_reques=
t *req)
>  {
>         struct clk_alpha_pll_postdiv *pll =3D to_clk_alpha_pll_postdiv(hw=
);
>         u32 ctl, div;
[...]
> @@ -1452,14 +1459,16 @@ clk_trion_pll_postdiv_recalc_rate(struct clk_hw *=
hw, unsigned long parent_rate)
>         return (parent_rate / div);
>  }
> =20
> -static long
> -clk_trion_pll_postdiv_round_rate(struct clk_hw *hw, unsigned long rate,
> -                                unsigned long *prate)
> +static int
> +clk_trion_pll_postdiv_determine_rate(struct clk_hw *hw,
> +                                    struct clk_rate_request *req)
>  {
>         struct clk_alpha_pll_postdiv *pll =3D to_clk_alpha_pll_postdiv(hw=
);
> =20
> -       return divider_round_rate(hw, rate, prate, pll->post_div_table,
> -                                 pll->width, CLK_DIVIDER_ROUND_CLOSEST);
> +       req->rate =3D divider_round_rate(hw, req->rate, &req->best_parent=
_rate,

divider_determine_rate()?

> +                                      pll->post_div_table, pll->width,
> +                                      CLK_DIVIDER_ROUND_CLOSEST);
> +       return 0;
>  };
> =20
>  static int
> @@ -1485,18 +1494,21 @@ clk_trion_pll_postdiv_set_rate(struct clk_hw *hw,=
 unsigned long rate,
> =20
>  const struct clk_ops clk_alpha_pll_postdiv_trion_ops =3D {
>         .recalc_rate =3D clk_trion_pll_postdiv_recalc_rate,
> -       .round_rate =3D clk_trion_pll_postdiv_round_rate,
> +       .determine_rate =3D clk_trion_pll_postdiv_determine_rate,
>         .set_rate =3D clk_trion_pll_postdiv_set_rate,
>  };
>  EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_trion_ops);
> =20
> -static long clk_alpha_pll_postdiv_fabia_round_rate(struct clk_hw *hw,
> -                               unsigned long rate, unsigned long *prate)
> +static int
> +clk_alpha_pll_postdiv_fabia_determine_rate(struct clk_hw *hw,
> +                                          struct clk_rate_request *req)
>  {
>         struct clk_alpha_pll_postdiv *pll =3D to_clk_alpha_pll_postdiv(hw=
);
> =20
> -       return divider_round_rate(hw, rate, prate, pll->post_div_table,
> -                               pll->width, CLK_DIVIDER_ROUND_CLOSEST);
> +       req->rate =3D divider_round_rate(hw, req->rate, &req->best_parent=
_rate,
> +                                      pll->post_div_table, pll->width,
> +                                       CLK_DIVIDER_ROUND_CLOSEST);

divider_determine_rate()?
