Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E077E1CC9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjKFI62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjKFI60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:58:26 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1D383
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:58:23 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507962561adso5488352e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699261101; x=1699865901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhaNPZ5ALKGhgIwmnk7EA8sPdVUBa/gDuKElje8KGZk=;
        b=JLziYkhUrV+OEVBt7CaBG5mhiS1bY1jxhuk/7vLFvK6BiWMbrjo+n5SiB5vB9Bl15k
         W0AcA2Bi6Sdc5nqiOMYi1JqI3YOJcb21htw6fl3CsCv0fb2b7YTFhph12/2lSUjVvNTn
         eK96/0BbgTfAp8Z9YDuwBpe0X6IESmW2YVVwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699261101; x=1699865901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhaNPZ5ALKGhgIwmnk7EA8sPdVUBa/gDuKElje8KGZk=;
        b=P3MNhKxOBjaA6GUMZYPpqCWLIZavteoVOid3mFmkQinF0dQJ3loi8SPEm2AvMzLrgv
         dPFlEGJbx85PU45XSkeTjuE/fovuWGVuzuH0siURVSpyPrNG0gnCexSxcC87lymVDNJ8
         f3ZsOmv5gQKbZqNhTO/Tbc5qyhqPZPj9YeZ7GhVRKZbic8gxNd/WXRinGjw/pNIqUruu
         BnU1LCX/BLo79YnKqEmNrOSKeZ8uKhGeoWtj1U+a8hvM8NvKhcOfoqOWGc+Fl/DL2Mmz
         0a8tvj/IYN6YkSPJ3Ww6EIqBIC0502tY9jNteeJWYyeGHJcv+odPaJpcJyj1tN2/3+eY
         xb0A==
X-Gm-Message-State: AOJu0Yxxj9nQ/NWvfG/UT+j0X2hMI+x3ptkV3JTJf6f2nO7bskiOw/fy
        +w+kEtS1+AZQO0gMU2QCiPhUpfMclfrUa0U9hQB2JA==
X-Google-Smtp-Source: AGHT+IFkEVvTTQVRt+p9CHlozj8K2Y8M2HQgxYsSM7s84s2T7tu9AUMdVItvQURRV6ZxtQMxORH9/2hymWtojECviag=
X-Received: by 2002:a05:6512:3245:b0:509:49fc:c25c with SMTP id
 c5-20020a056512324500b0050949fcc25cmr8787028lfr.28.1699261101126; Mon, 06 Nov
 2023 00:58:21 -0800 (PST)
MIME-Version: 1.0
References: <20231103102533.69280-1-angelogioacchino.delregno@collabora.com> <20231103102533.69280-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231103102533.69280-4-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 6 Nov 2023 16:58:09 +0800
Message-ID: <CAGXv+5Hjj1=5Tii1-Pt01oVdPE2qCc8E0DVjzm7UeA_m5cMW=A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] clk: mediatek: mt8188-topckgen: Refactor parents
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
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 6:25=E2=80=AFPM AngeloGioacchino Del Regno
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
>  - top_dp is switched to TVDPLL1
>  - TVDPLL1 changes its rate, top_edp outputs the wrong rate.
>  - eDP display is garbled
>
> To solve this issue, remove all TVDPLL1 parents from `top_dp` and
> all TVDPLL2 parents from `top_edp`, plus, necessarily switch both
> clocks to use the new MUX_GATE_CLR_SET_UPD_INDEXED() macro to be
> able to use the right bit index for the new parents list.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
