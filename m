Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BA67590AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjGSIxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjGSIwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:52:54 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD4F1723
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:52:51 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-791b8525b59so2407197241.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689756770; x=1690361570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMiqDw7X7t0YrSOOzvan9lAW+Fd4IqCvmMQSBgwW2RU=;
        b=n+QWAsjwEYrhOL660gbbzKYpPFBdtY/VRGDpk3zAR6D3OrchbXWU+3Rrhk/8HnroPz
         2A/lfOsc4NwsLmiBopMXoDu4BzqbEL+LkBibDmm1tfKSBIMB2GAVJi/VQJxAYQxZegpA
         /6GuiB4id+r4oKFChsW0y+qMYpiZHC4/Tq1MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689756770; x=1690361570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMiqDw7X7t0YrSOOzvan9lAW+Fd4IqCvmMQSBgwW2RU=;
        b=SNNUuz8BfWKaQS+wcTu1Fba9gSLer4ppmaxTSgbnVJ+h1dE4WbNC2kp3meWiR+Wywj
         w8yaY/lw/4oVsIoXxHMsizjgi64xaPbJ/vsz9jChW+c9h2G7TTvZeRs2OJHQJsvW8mTp
         9bR79n3mcRJwzdMmrq0eDba9/6BnGE0k4XDC+pnY++QUMIzuL4HKGXDELAY5lKZpm7Qv
         5/LfcDyfDYeL95wRWHUuai1+JCffCl40CJbZj9yTZNTENwKgtdshDRipb2/dm7WjYkzM
         QArWXRqFqSVM8BGbNoa1jDADBhcdfisXQcc9HM0Wu7Iy7rxJ4efjljoRcYvGswlrx/hq
         oHuw==
X-Gm-Message-State: ABy/qLaPVMOFlItlQQvvccVqvveg4H9qabzED3+wquHjP+qb0O92AUdT
        XvlIzbJ2yUsn+bOUg+2Ew4egGOwbO4P2b5s4rEqhtw==
X-Google-Smtp-Source: APBJJlFMB/51phMKvUpHT3Rcml2q3l4gVhVhjiZDDgMbXw9h+TT8DiP7jHpkQfpm9gOT379kwzlpBCyQqBRLcLnf03Q=
X-Received: by 2002:a67:fd59:0:b0:443:873a:16b8 with SMTP id
 g25-20020a67fd59000000b00443873a16b8mr9329375vsr.30.1689756770172; Wed, 19
 Jul 2023 01:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230719082033.1229277-1-wenst@chromium.org> <a63ffedd-8637-8161-2317-bd36be2867ae@collabora.com>
In-Reply-To: <a63ffedd-8637-8161-2317-bd36be2867ae@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 19 Jul 2023 16:52:39 +0800
Message-ID: <CAGXv+5GimZNPo6QDmCN7o4-qU-iPni=e1vPH5v0Z-Opn_0QjFg@mail.gmail.com>
Subject: Re: [PATCH] clk: mediatek: Check if clock ID is larger than
 clk_hw_onecell_data size
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 4:36=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 19/07/23 10:20, Chen-Yu Tsai ha scritto:
> > The MediaTek clock driver library's simple-probe mechanism allocates
> > clk_hw_onecell_data based on how many clocks are defined. If there's a
> > mismatch between that and the actual number of clocks defined in the DT
> > binding, such that a clock ID exceeds the number, then an out-of-bounds
> > write will occur. This silently corrupts memory, maybe causing a crash
> > later on that seems unrelated. KASAN can detect this if turned on.
> >
> > To avoid getting into said scenario, check if the to be registered
> > clock's ID will fit in the allocated clk_hw_onecell_data. If not, put
> > out a big warning and skip the clock.
> >
> > One could argue that the proper fix is to let the drivers specify the
> > number of clocks (based on a DT binding macro) instead. However even
> > the DT binding macro could be wrong. And having code to catch errors
> > and give out warnings is better than having silent corruption.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > This one is less urgent.
> >
> > Angelo, do you think we should add a field to struct mtk_clk_desc and
> > assign CLK_XXX_NR_CLK to it?
> >
>
> I get the point... but I don't know if it is a good idea to add checks fo=
r
> *bad code* in the first place, as bad code shall not happen at all.
> Validating whether a developer wrote the right thing is something that sh=
ould
> be done in code reviews, and such mistakes shouldn't be allowed to happen=
.

In theory, yeah. In practice, well, we already have such an error in tree. =
:p

> Besides, if you really want to go this route... In that case I disagree a=
bout
> the `continue`, as I would be inflexible: if your code is bad, I will ref=
use
> to register your clocks entirely.
> That'll force the developer to actually fix it, as parts of the SoC and/o=
r
> platform will *not work at all* :-)
>
> So, in that case...
>
>         if (rc->id >=3D clk_data->num) {
>                 hw =3D PTR_ERR(-EINVAL);
>                 goto err;
>         }
>
> Thoughts?

That works for me as well. This was more my debug code cleaned up.
I assume we still want the warning / error message though?

The other choice would be adding .num_clks for CLK_XXX_NR_CLKS to
mtk_clk_desc. What are your thoughts on that?

ChenYu

> Cheers!
> Angelo
>
> >   drivers/clk/mediatek/clk-gate.c | 11 +++++++++
> >   drivers/clk/mediatek/clk-mtk.c  | 43 ++++++++++++++++++++++++++++++++=
+
> >   2 files changed, 54 insertions(+)
> >
> > diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk=
-gate.c
> > index 67d9e741c5e7..bb7c536ef60f 100644
> > --- a/drivers/clk/mediatek/clk-gate.c
> > +++ b/drivers/clk/mediatek/clk-gate.c
> > @@ -222,6 +222,11 @@ int mtk_clk_register_gates(struct device *dev, str=
uct device_node *node,
> >       for (i =3D 0; i < num; i++) {
> >               const struct mtk_gate *gate =3D &clks[i];
> >
> > +             if (WARN(gate->id >=3D clk_data->num,
> > +                      "%pOF: gateclock ID (%d)larger than expected (%d=
)\n",
> > +                      node, gate->id, clk_data->num))
> > +                     continue;
> > +
> >               if (!IS_ERR_OR_NULL(clk_data->hws[gate->id])) {
> >                       pr_warn("%pOF: Trying to register duplicate clock=
 ID: %d\n",
> >                               node, gate->id);
> > @@ -251,6 +256,9 @@ int mtk_clk_register_gates(struct device *dev, stru=
ct device_node *node,
> >       while (--i >=3D 0) {
> >               const struct mtk_gate *gate =3D &clks[i];
> >
> > +             if (gate->id >=3D clk_data->num)
> > +                     continue;
> > +
> >               if (IS_ERR_OR_NULL(clk_data->hws[gate->id]))
> >                       continue;
> >
> > @@ -273,6 +281,9 @@ void mtk_clk_unregister_gates(const struct mtk_gate=
 *clks, int num,
> >       for (i =3D num; i > 0; i--) {
> >               const struct mtk_gate *gate =3D &clks[i - 1];
> >
> > +             if (gate->id >=3D clk_data->num)
> > +                     continue;
> > +
> >               if (IS_ERR_OR_NULL(clk_data->hws[gate->id]))
> >                       continue;
> >
> > diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-=
mtk.c
> > index 2e55368dc4d8..09d50a15db77 100644
> > --- a/drivers/clk/mediatek/clk-mtk.c
> > +++ b/drivers/clk/mediatek/clk-mtk.c
> > @@ -94,6 +94,10 @@ int mtk_clk_register_fixed_clks(const struct mtk_fix=
ed_clk *clks, int num,
> >       for (i =3D 0; i < num; i++) {
> >               const struct mtk_fixed_clk *rc =3D &clks[i];
> >
> > +             if (WARN(rc->id >=3D clk_data->num,
> > +                      "Fixed clock ID (%d) larger than expected (%d)\n=
", rc->id, clk_data->num))
> > +                     continue;
> > +
> >               if (!IS_ERR_OR_NULL(clk_data->hws[rc->id])) {
> >                       pr_warn("Trying to register duplicate clock ID: %=
d\n", rc->id);
> >                       continue;
> > @@ -117,6 +121,9 @@ int mtk_clk_register_fixed_clks(const struct mtk_fi=
xed_clk *clks, int num,
> >       while (--i >=3D 0) {
> >               const struct mtk_fixed_clk *rc =3D &clks[i];
> >
> > +             if (rc->id >=3D clk_data->num)
> > +                     continue;
> > +
> >               if (IS_ERR_OR_NULL(clk_data->hws[rc->id]))
> >                       continue;
> >
> > @@ -139,6 +146,9 @@ void mtk_clk_unregister_fixed_clks(const struct mtk=
_fixed_clk *clks, int num,
> >       for (i =3D num; i > 0; i--) {
> >               const struct mtk_fixed_clk *rc =3D &clks[i - 1];
> >
> > +             if (rc->id >=3D clk_data->num)
> > +                     continue;
> > +
> >               if (IS_ERR_OR_NULL(clk_data->hws[rc->id]))
> >                       continue;
> >
> > @@ -160,6 +170,11 @@ int mtk_clk_register_factors(const struct mtk_fixe=
d_factor *clks, int num,
> >       for (i =3D 0; i < num; i++) {
> >               const struct mtk_fixed_factor *ff =3D &clks[i];
> >
> > +             if (WARN(ff->id >=3D clk_data->num,
> > +                      "Fixed factor clock ID (%d) larger than expected=
 (%d)\n",
> > +                      ff->id, clk_data->num))
> > +                     continue;
> > +
> >               if (!IS_ERR_OR_NULL(clk_data->hws[ff->id])) {
> >                       pr_warn("Trying to register duplicate clock ID: %=
d\n", ff->id);
> >                       continue;
> > @@ -183,6 +198,9 @@ int mtk_clk_register_factors(const struct mtk_fixed=
_factor *clks, int num,
> >       while (--i >=3D 0) {
> >               const struct mtk_fixed_factor *ff =3D &clks[i];
> >
> > +             if (ff->id >=3D clk_data->num)
> > +                     continue;
> > +
> >               if (IS_ERR_OR_NULL(clk_data->hws[ff->id]))
> >                       continue;
> >
> > @@ -205,6 +223,9 @@ void mtk_clk_unregister_factors(const struct mtk_fi=
xed_factor *clks, int num,
> >       for (i =3D num; i > 0; i--) {
> >               const struct mtk_fixed_factor *ff =3D &clks[i - 1];
> >
> > +             if (ff->id >=3D clk_data->num)
> > +                     continue;
> > +
> >               if (IS_ERR_OR_NULL(clk_data->hws[ff->id]))
> >                       continue;
> >
> > @@ -339,6 +360,11 @@ int mtk_clk_register_composites(struct device *dev=
,
> >       for (i =3D 0; i < num; i++) {
> >               const struct mtk_composite *mc =3D &mcs[i];
> >
> > +             if (WARN(mc->id >=3D clk_data->num,
> > +                      "Composite clock ID (%d) larger than expected (%=
d)\n",
> > +                      mc->id, clk_data->num))
> > +                     continue;
> > +
> >               if (!IS_ERR_OR_NULL(clk_data->hws[mc->id])) {
> >                       pr_warn("Trying to register duplicate clock ID: %=
d\n",
> >                               mc->id);
> > @@ -362,6 +388,9 @@ int mtk_clk_register_composites(struct device *dev,
> >       while (--i >=3D 0) {
> >               const struct mtk_composite *mc =3D &mcs[i];
> >
> > +             if (mc->id >=3D clk_data->num)
> > +                     continue;
> > +
> >               if (IS_ERR_OR_NULL(clk_data->hws[mcs->id]))
> >                       continue;
> >
> > @@ -384,6 +413,9 @@ void mtk_clk_unregister_composites(const struct mtk=
_composite *mcs, int num,
> >       for (i =3D num; i > 0; i--) {
> >               const struct mtk_composite *mc =3D &mcs[i - 1];
> >
> > +             if (mc->id >=3D clk_data->num)
> > +                     continue;
> > +
> >               if (IS_ERR_OR_NULL(clk_data->hws[mc->id]))
> >                       continue;
> >
> > @@ -407,6 +439,11 @@ int mtk_clk_register_dividers(struct device *dev,
> >       for (i =3D 0; i <  num; i++) {
> >               const struct mtk_clk_divider *mcd =3D &mcds[i];
> >
> > +             if (WARN(mcd->id >=3D clk_data->num,
> > +                      "Divider clock ID (%d) larger than expected (%d)=
\n",
> > +                      mcd->id, clk_data->num))
> > +                     continue;
> > +
> >               if (!IS_ERR_OR_NULL(clk_data->hws[mcd->id])) {
> >                       pr_warn("Trying to register duplicate clock ID: %=
d\n",
> >                               mcd->id);
> > @@ -432,6 +469,9 @@ int mtk_clk_register_dividers(struct device *dev,
> >       while (--i >=3D 0) {
> >               const struct mtk_clk_divider *mcd =3D &mcds[i];
> >
> > +             if (mcd->id >=3D clk_data->num)
> > +                     continue;
> > +
> >               if (IS_ERR_OR_NULL(clk_data->hws[mcd->id]))
> >                       continue;
> >
> > @@ -454,6 +494,9 @@ void mtk_clk_unregister_dividers(const struct mtk_c=
lk_divider *mcds, int num,
> >       for (i =3D num; i > 0; i--) {
> >               const struct mtk_clk_divider *mcd =3D &mcds[i - 1];
> >
> > +             if (mcd->id >=3D clk_data->num)
> > +                     continue;
> > +
> >               if (IS_ERR_OR_NULL(clk_data->hws[mcd->id]))
> >                       continue;
> >
>
