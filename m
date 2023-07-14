Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F0C75307F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjGNETR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjGNETO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:19:14 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058CC2699
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:19:13 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-45739737afcso416467e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689308352; x=1691900352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJ25wMfM7kSzvTpXtpsgLxWUjdQihI5rOBPsjaMGVAo=;
        b=VWDDDPziqbsgTDMNy7zZmb86l38MhITudT4cM4e/pk1R5tTaVbJ7SRftIJBTiTKnLE
         hAJr+PC2+Cgo9c9NFnBydJLfeEDX3tIo/F8OHlWUnYrdH0hB4A5e4/IlSMIsOM2cy1h8
         6UqNOkaZG3cUSiU7I6riqPP49XUbPxoejek2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689308352; x=1691900352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJ25wMfM7kSzvTpXtpsgLxWUjdQihI5rOBPsjaMGVAo=;
        b=BhOAaQOTmxMXIXqV7C25D1XVZ4y6wWPPxZZzK5j658d6oYHD2BkM/TjNmYhFsEbZKz
         ow8Sjx1KKq1fF3pzO5Q+Fo4UAj05UUV0HAtN/QCsMACVgzELCT1zKGDlrnHZzUzSvkj7
         916nzwJIDNe2OeNDe0poKn0V+68jfh2pgSFyBzjfXL39UNz5vOkYQiQjCNGQgFJRAZMq
         qUmnwfkSCgjIyMm4xy0Uxg+zfJdk0sOCePgNDDMW0gngzoT2P9cr7QS8j1zBNf9zgDkF
         Upx9IhsSj7te2ASGP/4DrLKuedUCvUpLsktHTy7SHbHp5uiFIwRLDgY8BP+FOHNry+wW
         ofcA==
X-Gm-Message-State: ABy/qLZcjqIhoXP/PBuGdlWVZHPjUIpMpZS2Y8fKRaMXzGp6W4LaWCww
        mnXPXqnR3/R8T/ab5dq5+WoRsZ7d+yjBvPuALqxWsQ==
X-Google-Smtp-Source: APBJJlEzmNK7jvt1ONHasiafzxX7B304oncYEYsEDIFGu363Kn4Q4BRNgW0aGtp4K7TFa8nhJnTX03CsOGRtGuS3/8w=
X-Received: by 2002:a67:fe17:0:b0:443:5b1f:12e4 with SMTP id
 l23-20020a67fe17000000b004435b1f12e4mr1511250vsr.9.1689308352063; Thu, 13 Jul
 2023 21:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230713072138.84117-1-angelogioacchino.delregno@collabora.com>
 <20230713072138.84117-3-angelogioacchino.delregno@collabora.com> <9a0817c2-4101-5c21-977d-77ac0d83a067@baylibre.com>
In-Reply-To: <9a0817c2-4101-5c21-977d-77ac0d83a067@baylibre.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 14 Jul 2023 12:19:00 +0800
Message-ID: <CAGXv+5E7YYdkG7GtxG90KzdAG8Kke+74Amtbw4mmyVNZgDZHRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: mediatek: mt8195-topckgen: Refactor parents for
 top_dp/edp muxes
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, sboyd@kernel.org,
        mturquette@baylibre.com, matthias.bgg@gmail.com, msp@baylibre.com,
        yangyingliang@huawei.com, u.kleine-koenig@pengutronix.de,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        mripard@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 9:22=E2=80=AFPM Alexandre Mergnat <amergnat@baylibr=
e.com> wrote:
> On 13/07/2023 09:21, AngeloGioacchino Del Regno wrote:
> > The top_dp and top_edp muxes can be both parented to either TVDPLL1
> > or TVDPLL2, two identically specced PLLs for the specific purpose of
> > giving out pixel clock: this becomes a problem when the MediaTek
> > DisplayPort Interface (DPI) driver tries to set the pixel clock rate.
> >
> > In the usecase of two simultaneous outputs (using two controllers),
> > it was seen that one of the displays would sometimes display garbled
> > output (if any at all) and this was because:
> >   - top_edp was set to TVDPLL1, outputting X GHz
> >   - top_dp was set to TVDPLL2, outputting Y GHz
> >     - mtk_dpi calls clk_set_rate(top_edp, Z GHz)
> >       - top_dp is switched to TVDPLL1
> >       - TVDPLL1 changes its rate, top_edp outputs the wrong rate.
> >       - eDP display is garbled
> >
> > To solve this issue, remove all TVDPLL1 parents from `top_dp` and
> > all TVDPLL2 parents from `top_edp`, plus, necessarily switch both
> > clocks to use the new MUX_GATE_CLR_SET_UPD_INDEXED() macro to be
> > able to use the right bit index for the new parents list.
> >
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> > ---
> >   drivers/clk/mediatek/clk-mt8195-topckgen.c | 22 ++++++++++++++-------=
-
> >   1 file changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/m=
ediatek/clk-mt8195-topckgen.c
> > index 81daa24cadde..abb3721f6e1b 100644
> > --- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
> > +++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> > @@ -417,15 +417,21 @@ static const char * const pwrmcu_parents[] =3D {
> >
> >   static const char * const dp_parents[] =3D {
> >       "clk26m",
> > -     "tvdpll1_d2",
> >       "tvdpll2_d2",
> > -     "tvdpll1_d4",
> >       "tvdpll2_d4",
> > -     "tvdpll1_d8",
> >       "tvdpll2_d8",
> > -     "tvdpll1_d16",
> >       "tvdpll2_d16"
> >   };
> > +static const u8 dp_parents_idx[] =3D { 0, 2, 4, 6, 8 };
> > +
> > +static const char * const edp_parents[] =3D {
> > +     "clk26m",
> > +     "tvdpll1_d2",
> > +     "tvdpll1_d4",
> > +     "tvdpll1_d8",
> > +     "tvdpll1_d16"
> > +};
> > +static const u8 edp_parents_idx[] =3D { 0, 1, 3, 5, 7 };
>
> AFAII your solution is to force a specific TVDPLLX for each display, and
> it isn't dynamic.
>
> Do you think it's possible to do that using the DTS ? I'm asking
> because, IMHO, this kind of setup is more friendly/readable/flexible in
> the DTS than hardcoded into the driver.

(CC-ing Maxime, who has some experience in the matter.)

assigned-parents doesn't prevent your system from reparenting the clocks
back to a conflicting configuration.

AFAIK the recommended way to deal with this is to use
clk_set_rate_exclusive() and co. in whatever consumer driver that needs
exclusive control on the clock rate. However I'm not sure if that works
for parents. It should, given the original use case was for the sunxi
platforms, which like the MediaTek platform here has 2 PLLs for video
related consumers, but I couldn't find code verifying it.


ChenYu

> >
> >   static const char * const disp_pwm_parents[] =3D {
> >       "clk26m",
> > @@ -957,11 +963,11 @@ static const struct mtk_mux top_mtk_muxes[] =3D {
> >       MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_PWRMCU, "top_pwrmcu",
> >               pwrmcu_parents, 0x08C, 0x090, 0x094, 16, 3, 23, 0x08, 6,
> >               CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
> > -     MUX_GATE_CLR_SET_UPD(CLK_TOP_DP, "top_dp",
> > -             dp_parents, 0x08C, 0x090, 0x094, 24, 4, 31, 0x08, 7),
> > +     MUX_GATE_CLR_SET_UPD_INDEXED(CLK_TOP_DP, "top_dp",
> > +             dp_parents, dp_parents_idx, 0x08C, 0x090, 0x094, 24, 4, 3=
1, 0x08, 7),
> >       /* CLK_CFG_10 */
> > -     MUX_GATE_CLR_SET_UPD(CLK_TOP_EDP, "top_edp",
> > -             dp_parents, 0x098, 0x09C, 0x0A0, 0, 4, 7, 0x08, 8),
> > +     MUX_GATE_CLR_SET_UPD_INDEXED(CLK_TOP_EDP, "top_edp",
> > +             edp_parents, edp_parents_idx, 0x098, 0x09C, 0x0A0, 0, 4, =
7, 0x08, 8),
> >       MUX_GATE_CLR_SET_UPD(CLK_TOP_DPI, "top_dpi",
> >               dp_parents, 0x098, 0x09C, 0x0A0, 8, 4, 15, 0x08, 9),
> >       MUX_GATE_CLR_SET_UPD(CLK_TOP_DISP_PWM0, "top_disp_pwm0",
>
> --
> Regards,
> Alexandre
