Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9B77D460C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 05:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjJXDh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 23:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjJXDhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 23:37:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E6B83;
        Mon, 23 Oct 2023 20:37:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA808C433C7;
        Tue, 24 Oct 2023 03:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698118671;
        bh=YwS7fpAn8GYq+ycGNrZLGcNoPLL/m1ouHBG1tLxpjOI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DznAzuMndKCSVwnuNxZ0LwSURLYuvYBCIRO9ARmxplQ1caCts7t2UKAW3upwNYrcL
         +p7WmKKvF7IGYMvcjcDzg/jii852UsiEUon9E9Ql+LQoPgjKRVhSGAI06OpCSyv/lr
         CJRz+FwaLYYvDX8Ybmq9WsCo2Y0/93Q+4daSXtJipO9/ryq4N7Odk+3+JgW9cPwiMB
         te9XieUs9oHiAfPzEKwTV1gwJKO0lEZM8OBlwYmu1fzd4KgnBQN2FZQcXRryjTeMwn
         mrfRWfTiFMboCtclKW+H2H60bm3xLQrwmpZWOxTTh7YIvkzET7nFacNkfu2jfpCtiN
         6CsYF8nfgF3SQ==
Message-ID: <3ff911fa4c417a81462813f975ac757f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231016113002.15929-3-jay.buddhabhatti@amd.com>
References: <20231016113002.15929-1-jay.buddhabhatti@amd.com> <20231016113002.15929-3-jay.buddhabhatti@amd.com>
Subject: Re: [PATCH RESEND 2/2] drivers: clk: zynqmp: update divider round rate logic
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     Jay Buddhabhatti <jay.buddhabhatti@amd.com>, michal.simek@amd.com,
        mturquette@baylibre.com
Date:   Mon, 23 Oct 2023 20:37:49 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jay Buddhabhatti (2023-10-16 04:30:02)
> Currently zynqmp divider round rate is considering single parent and
> calculating rate and parent rate accordingly. But if divider clock flag
> is set to SET_RATE_PARENT then its not trying to traverse through all
> parent rate and not selecting best parent rate from that. So use common
> divider_round_rate() which is traversing through all clock parents and
> its rate and calculating proper parent rate.
>=20
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> ---
>  drivers/clk/zynqmp/divider.c | 70 ++++++------------------------------
>  1 file changed, 10 insertions(+), 60 deletions(-)

Can't argue against removing that many lines!

>=20
> diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
> index 33a3b2a22659..a42c183d7e5d 100644
> --- a/drivers/clk/zynqmp/divider.c
> +++ b/drivers/clk/zynqmp/divider.c
> @@ -193,23 +149,17 @@ static long zynqmp_clk_divider_round_rate(struct cl=
k_hw *hw,
>                 return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
>         }
> =20
> -       bestdiv =3D zynqmp_divider_get_val(*prate, rate, divider->flags);
> -
> -       /*
> -        * In case of two divisors, compute best divider values and return
> -        * divider2 value based on compute value. div1 will  be automatic=
ally
> -        * set to optimum based on required total divider value.
> -        */
> -       if (div_type =3D=3D TYPE_DIV2 &&
> -           (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
> -               zynqmp_get_divider2_val(hw, rate, divider, &bestdiv);
> +       max =3D divider->max_div;
> +       while (max !=3D 0) {
> +               if ((max & 1) =3D=3D 1)
> +                       width++;
> +               max =3D max >> 1;

Is this ffs()?

>         }
> =20
> -       if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && divider->is_f=
rac)
> -               bestdiv =3D rate % *prate ? 1 : bestdiv;
> +       rate =3D divider_round_rate(hw, rate, prate, NULL, width, divider=
->flags);
> =20
> -       bestdiv =3D min_t(u32, bestdiv, divider->max_div);
> -       *prate =3D rate * bestdiv;
> +       if (divider->is_frac && (clk_hw_get_flags(hw) & CLK_SET_RATE_PARE=
NT) && (rate % *prate))
> +               *prate =3D rate;
