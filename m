Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CD57D2AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjJWHA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjJWHAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:00:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC1BEE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:00:22 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5079c846dcfso3858392e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698044420; x=1698649220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJ+L8z2++KdugvZa/TRNkYv4iFz/Yo8vEvV3D34lpNE=;
        b=TaxKObXWgOepRBe2TY1qTkK6XjqtIpJ40XMD5+nnwpawiwz2oXdXoVMiQHWNOs5Op7
         4pxEn9h+u7IjlwkFYxSRB2inJWzIfu2EF6i5lloKcBJvzERL/To/4Seag1aSSmoEgN/m
         VR1iHrpb9w7tafcVM0CBWBwAEy45TCL8UioUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698044420; x=1698649220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJ+L8z2++KdugvZa/TRNkYv4iFz/Yo8vEvV3D34lpNE=;
        b=ROp0W5+3YXffG1w9ZeMin+eYOTF4b96CtSWseEeSVF6Cgxac1/ci9fOjsRPOeky5mf
         KDl0lpHi8voHmpEcwip2Kq1Q1Kgk8kG4iTMkEluS7mQJon3OEj2/MT/5t0Zmic4XVL4u
         tKjAW5cz4j2M/dJzv4rP7FDNE7BhqtpZLN2LLgO+KtAVR9aaU+DLHcCvoawukAgtBzby
         08GHp6qjXYtuRAp2TkI1aMoJ1IaSYzQJDTZ/td8DzB+CnQirDawA+YoVhmYkBbhNO1v/
         nrn5nthKaQ5tDxfaJtTgG7xtiEYRHVGFJ3T8S9TF2de2AL2Opf4WDFgUFI1FSGNRAZ+I
         8jew==
X-Gm-Message-State: AOJu0YxBuddWd2B2cw2ssvJB3N7iJj4oMCdopxr2dzCIZNG1RpKrujpr
        FFWIUd0j2oEoF59CH1TWNAX3eqzDdp6TACL08VKrcg==
X-Google-Smtp-Source: AGHT+IHwxDq3JgGLwq8PRk/AjyW+M05CrhYWE435S1X1mmyZlKTfIy/kiPzAMT03iJC6FZQbnSByYGmjwr2oBHJYVA8=
X-Received: by 2002:a05:6512:4002:b0:507:b911:f869 with SMTP id
 br2-20020a056512400200b00507b911f869mr6888686lfb.43.1698044420324; Mon, 23
 Oct 2023 00:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231018103546.48174-1-angelogioacchino.delregno@collabora.com> <20231018103546.48174-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231018103546.48174-3-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 23 Oct 2023 15:00:09 +0800
Message-ID: <CAGXv+5EoVnfCLfJ+6t8FiwuJq-eyZQZNh9H+7TD+yGkEWFO3pw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: mediatek: mt8195-topckgen: Refactor parents
 for top_dp/edp muxes
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
        msp@baylibre.com, amergnat@baylibre.com, yangyingliang@huawei.com,
        u.kleine-koenig@pengutronix.de, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 6:35=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The top_dp and top_edp muxes can be both parented to either TVDPLL1
> or TVDPLL2, two identically specced PLLs for the specific purpose of
> giving out pixel clock: this becomes a problem when the MediaTek
> DisplayPort Interface (DPI) driver tries to set the pixel clock rate.
>
> In the usecase of two simultaneous outputs (using two controllers),
> it was seen that one of the displays would sometimes display garbled
> output (if any at all) and this was because:
>  - top_edp was set to TVDPLL1, outputting X GHz
>  - top_dp was set to TVDPLL2, outputting Y GHz
>    - mtk_dpi calls clk_set_rate(top_edp, Z GHz)
>      - top_dp is switched to TVDPLL1
>      - TVDPLL1 changes its rate, top_edp outputs the wrong rate.
>      - eDP display is garbled
>
> To solve this issue, remove all TVDPLL1 parents from `top_dp` and
> all TVDPLL2 parents from `top_edp`, plus, necessarily switch both
> clocks to use the new MUX_GATE_CLR_SET_UPD_INDEXED() macro to be
> able to use the right bit index for the new parents list.
>
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/clk/mediatek/clk-mt8195-topckgen.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/med=
iatek/clk-mt8195-topckgen.c
> index 5c426a1c94c7..4529255376e9 100644
> --- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> @@ -417,15 +417,21 @@ static const char * const pwrmcu_parents[] =3D {


Nit: I'd add a comment saying this list isn't the full list for reasons.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

>  static const char * const dp_parents[] =3D {
>         "clk26m",
> -       "tvdpll1_d2",
>         "tvdpll2_d2",
> -       "tvdpll1_d4",
>         "tvdpll2_d4",
> -       "tvdpll1_d8",
>         "tvdpll2_d8",
> -       "tvdpll1_d16",
>         "tvdpll2_d16"
>  };
> +static const u8 dp_parents_idx[] =3D { 0, 2, 4, 6, 8 };
> +
> +static const char * const edp_parents[] =3D {
> +       "clk26m",
> +       "tvdpll1_d2",
> +       "tvdpll1_d4",
> +       "tvdpll1_d8",
> +       "tvdpll1_d16"
> +};
> +static const u8 edp_parents_idx[] =3D { 0, 1, 3, 5, 7 };
>
>  static const char * const disp_pwm_parents[] =3D {
>         "clk26m",
> @@ -957,11 +963,11 @@ static const struct mtk_mux top_mtk_muxes[] =3D {
>         MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_PWRMCU, "top_pwrmcu",
>                 pwrmcu_parents, 0x08C, 0x090, 0x094, 16, 3, 23, 0x08, 6,
>                 CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
> -       MUX_GATE_CLR_SET_UPD(CLK_TOP_DP, "top_dp",
> -               dp_parents, 0x08C, 0x090, 0x094, 24, 4, 31, 0x08, 7),
> +       MUX_GATE_CLR_SET_UPD_INDEXED(CLK_TOP_DP, "top_dp",
> +               dp_parents, dp_parents_idx, 0x08C, 0x090, 0x094, 24, 4, 3=
1, 0x08, 7),
>         /* CLK_CFG_10 */
> -       MUX_GATE_CLR_SET_UPD(CLK_TOP_EDP, "top_edp",
> -               dp_parents, 0x098, 0x09C, 0x0A0, 0, 4, 7, 0x08, 8),
> +       MUX_GATE_CLR_SET_UPD_INDEXED(CLK_TOP_EDP, "top_edp",
> +               edp_parents, edp_parents_idx, 0x098, 0x09C, 0x0A0, 0, 4, =
7, 0x08, 8),
>         MUX_GATE_CLR_SET_UPD(CLK_TOP_DPI, "top_dpi",
>                 dp_parents, 0x098, 0x09C, 0x0A0, 8, 4, 15, 0x08, 9),
>         MUX_GATE_CLR_SET_UPD(CLK_TOP_DISP_PWM0, "top_disp_pwm0",
> --
> 2.42.0
>
