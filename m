Return-Path: <linux-kernel+bounces-77765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D611D8609F7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4681F24D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7B11119E;
	Fri, 23 Feb 2024 04:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b76Xqx/F"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3B010A31
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 04:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708663433; cv=none; b=JvX4NaLyncTvEqebBmanv4ADeZa+yMhlcTL2WU1CCfmljIa01wllFiW0eqq3wC3kE3TGT9jU98L+fenlhkYgAQVf22Y9XkFIkhCUDAlYhAJRYzFDExgl9toOYAY1AyuoPiW2XPDrvwpBn1t770tm0YvNIgVpn7R3U6d/ou4qomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708663433; c=relaxed/simple;
	bh=Ca4fxX1YOQIc9IaTljm5TL6Wj+BZP/Dp47VTszaskxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiAX+5EIfxuUWzDwO4iQPVtlIY1gSCi/tZgzJxP+arl/+E1joBSV9RKIcQy/OzJaqTiqHsWpDUkv6BS6qYT4qrW/Z+3iwGNeYjU4bHCPI+tb4+xfgpCOGUb82zzqhNBtaYthvsT+R7C8bkRK8AKFQZz9QZRKrJTiTAYoW6pa75g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b76Xqx/F; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512a65cd2c7so732229e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708663430; x=1709268230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBx7MOkn9wW9DxztfWR4DG5bZ9dZsBTrKJsnaVTaV5I=;
        b=b76Xqx/Fd4fzyl8ovMUOV499M5dh2vDT5nCpZ7S7dYHGX5yRGIB7Dkr3rrGhgp/zIJ
         WQwu+BWTTlA+NcZv01ZT9lwh22qwk5c4suPxymiEYPF7toQomjQIIfLHRhVUOrJGrE2d
         4J/1k2MZ/HNPPFkuxAiqZf/ZWcU0pCOOLaUxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708663430; x=1709268230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBx7MOkn9wW9DxztfWR4DG5bZ9dZsBTrKJsnaVTaV5I=;
        b=MxVPBA2nP/V30755IzvxZ81xMyzDhi/rR6xhdy3eG1FaJXrXuBqCaP7XhsXDONpBnd
         2WSg7HuwUoPmnArEy0MeB/d34MwECGaRsCyzHZzK3H1adRNaSflfeQBT0v/D0ra/c67b
         OIFf/z8nAORYKTJAm0iJ1rx6fWQjIJRexIZQeAd//umHIMwJl9PfLTa9Fcpk2A+VqNU9
         9Aaa77mXCQRHVEjOhhFLdf9eBS8pr1A5Lq/q6bsge5JMhwmLsEm02Q2WcbN/lW8M0P1B
         TcpTpeyPabdR9rn1HyxpCtNwfMOxYPhoTG0aDLiSh9iiX9GBcqhab9pesRXxRHZYecn5
         AHAA==
X-Forwarded-Encrypted: i=1; AJvYcCVYGpagxce1uxon3C78yWGQ5jYr4HdAxBGbeakXLo4cjZG6i6+1cYZsmHJZi9mugNAx9g56XI0AyP/tqxE5SasgKjusY/IW8SyS+U5s
X-Gm-Message-State: AOJu0YyNz2CTtsuaY8qhuGh4BHxrSYUSjYp0lEQXF30zGxLmxq241Nmv
	y4rDmEl7oHY4rUqDIF9R5HhPqQUL4ylk2opDUU4Nb222I6ytAojOx5DQz8NhKdI6SB4H5u9Y7Ct
	stRGpYuV1Ku268iACPNNHQKemu28cdYM76cmo
X-Google-Smtp-Source: AGHT+IF5QOowQOFza4xh4jiRjjWLNuX1rVomW/9NM2WmASfwoESsVYQHmb/UIiIOu30QnLkqolbWhZLkQamy3+pnN3M=
X-Received: by 2002:ac2:5984:0:b0:512:e091:cb1b with SMTP id
 w4-20020ac25984000000b00512e091cb1bmr566669lfn.13.1708663430207; Thu, 22 Feb
 2024 20:43:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108081834.408403-1-treapking@chromium.org> <20240108081834.408403-2-treapking@chromium.org>
In-Reply-To: <20240108081834.408403-2-treapking@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 23 Feb 2024 12:43:39 +0800
Message-ID: <CAGXv+5GoAauw77wVXx6SXsSma9zP_A1vXLRo=GH2ptjvY=kLgA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] clk: mediatek: mt8183: Enable need_runtime_pm on mt8183-mfgcfg
To: Pin-yen Lin <treapking@chromium.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Weiyi Lu <weiyi.lu@mediatek.com>, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 4:18=E2=80=AFPM Pin-yen Lin <treapking@chromium.org>=
 wrote:
>
> mt8183-mfgcfg has a mutual dependency with genpd during the probing
> stage, so enable need_runtim_pm to prevent a deadlock in the following
> call stack:
>
> CPU0:  genpd_lock --> clk_prepare_lock
> genpd_power_off_work_fn()
>  genpd_lock()
>  generic_pm_domain::power_off()
>     clk_unprepare()
>       clk_prepare_lock()
>
> CPU1: clk_prepare_lock --> genpd_lock
> clk_register()
>   __clk_core_init()
>     clk_prepare_lock()
>     clk_pm_runtime_get()
>       genpd_lock()
>
> Do a runtime PM get at the probe function to make sure clk_register()
> won't acquire the genpd lock.
>
> Fixes: acddfc2c261b ("clk: mediatek: Add MT8183 clock support")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Note that this compliments a patch [1] adding the power domain for the mfgc=
fg
clock controller node, which has been floating around for almost 3 years.

[1] https://lore.kernel.org/linux-mediatek/20210414073108.3899082-1-ikjn@ch=
romium.org/

> ---
>
> (no changes since v1)
>
>  drivers/clk/mediatek/clk-mt8183-mfgcfg.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c b/drivers/clk/media=
tek/clk-mt8183-mfgcfg.c
> index ba504e19d420..62d876e150e1 100644
> --- a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
> +++ b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
> @@ -29,6 +29,7 @@ static const struct mtk_gate mfg_clks[] =3D {
>  static const struct mtk_clk_desc mfg_desc =3D {
>         .clks =3D mfg_clks,
>         .num_clks =3D ARRAY_SIZE(mfg_clks),
> +       .need_runtime_pm =3D true,
>  };
>
>  static const struct of_device_id of_match_clk_mt8183_mfg[] =3D {
> --
> 2.43.0.472.g3155946c3a-goog
>

