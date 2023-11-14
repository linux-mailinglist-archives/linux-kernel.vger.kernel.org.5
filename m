Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2537EB45B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjKNQEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjKNQEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:04:02 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E24131
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:03:58 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a822f96aedso68645827b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699977838; x=1700582638; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=84sMBLOoP3332x+kaQPC6WEmGeMSigBRO9sqFIeWhaw=;
        b=zvsGM/400BiQFbWcUKAVEWlmUA5gGCtVyA7WHcVkhEOhrKOkUNlKAWCJrFkJ5F6V5d
         RiLtazUazVEMlB4tSR6QoeUS+dkV8zLua03mPPjQoEaCj2xLXsBf3z/E08uBNPQabxG9
         B97R44PalDhR4OaHn8xYdWEq4R7SCMXFxL9hbGPkxF0VT+XAJsP3xl/psLwnJnKb7n+n
         +jDSBtYKgkhiNsS49ZsX49K2JtGjefcFXsWBE0KgN1Om6l/XgtPlN0wFkAtX0FMU232q
         00xtXgGMgVVvukri1SOXJdhkNDSBFLj4meCKb/DMC/69RLuMgKAkDK1/ZOrbNIq6ZVrW
         xVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699977838; x=1700582638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84sMBLOoP3332x+kaQPC6WEmGeMSigBRO9sqFIeWhaw=;
        b=oSPJWCKpgyeCvMEs38at2Xn3k4kAwIIdrXSMW0qUCfYJjmhbOcdt1LJOVsfKqpcIKd
         Ln9MqRirbNFEJFDJH7MDwG5fQEaoZ8RsNUYDrpAJgjFexqQPSrG84e00PPg2qT19Pms6
         o0234Pu1S4m9fMpbtx/MoZNsdsaQURmhC97HRQe3KCRCRaoczavKdlvi7rAcuigskP5d
         2v5ionRU1Ztb2Lo9Uu+mUb/cewQFYPFifAy/7bBA39GrNsk//24a+Pvh94AevKvr3+Xp
         Sa9I7XCdRs3SAZoqq3vDPj9CFgWOnb0mz/HdGemvdkku7fG94pjHDmWmob9rRLA2flrZ
         W/cw==
X-Gm-Message-State: AOJu0YynzImW8H+WjQW7GDXF9bl7hYxawM40vtIHewSCTsRGjQ/w2F6w
        xxVqC2fHj3E22JC4cVq7mkcDBEmeh0e2jS43Xz4ewxYw8M0F4JEn
X-Google-Smtp-Source: AGHT+IFIv/dr950N6/LEfu34S82r9+GhcCMi5FKjW5Jcm5LagL4BVhGWPQCJjXVH0we8WxFPHGlKtF0/97aoe9Dk3L4=
X-Received: by 2002:a0d:f304:0:b0:5a8:2b82:a031 with SMTP id
 c4-20020a0df304000000b005a82b82a031mr9872136ywf.26.1699977837957; Tue, 14 Nov
 2023 08:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev> <20231114150130.497915-4-sui.jingfeng@linux.dev>
In-Reply-To: <20231114150130.497915-4-sui.jingfeng@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 14 Nov 2023 18:03:47 +0200
Message-ID: <CAA8EJprhnxx6bS6cn1JAbdzyB_+N1BbajkuO8zs2_OxXPeV84Q@mail.gmail.com>
Subject: Re: [PATCH 3/8] drm/bridge: it66121: Add a helper function to read
 bus width
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 at 17:09, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> From: Sui Jingfeng <suijingfeng@loongson.cn>
>
> Group those relavent code lines (which with common purpose) into one helper
> function, suppress the dependency on DT to function level. Just trivial
> cleanup, no functional change.
>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 32 ++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 83dbdbfc9ed8..0f78737adc83 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -320,6 +320,26 @@ static inline struct it66121_ctx *bridge_to_it66121(struct drm_bridge *bridge)
>         return container_of(bridge, struct it66121_ctx, bridge);
>  }
>
> +static int it66121_of_read_bus_width(struct device *dev, u32 *bus_width)

Using a pointer to return int value doesn't look right. Just return a
signed int here and if it is not an error, assign it to ctx->bus_width

> +{
> +       struct device_node *np;
> +       u32 bw;
> +
> +       np = of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
> +       if (!np)
> +               return -EINVAL;
> +
> +       of_property_read_u32(np, "bus-width", &bw);
> +       of_node_put(np);
> +
> +       if (bw != 12 && bw != 24)
> +               return -EINVAL;
> +
> +       *bus_width = bw;
> +
> +       return 0;
> +}
> +
>  static const struct regmap_range_cfg it66121_regmap_banks[] = {
>         {
>                 .name = "it66121",
> @@ -1525,19 +1545,13 @@ static int it66121_probe(struct i2c_client *client)
>         if (!ctx)
>                 return -ENOMEM;
>
> -       ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
> -       if (!ep)
> -               return -EINVAL;
> -
>         ctx->dev = dev;
>         ctx->client = client;
>         ctx->info = i2c_get_match_data(client);
>
> -       of_property_read_u32(ep, "bus-width", &ctx->bus_width);
> -       of_node_put(ep);
> -
> -       if (ctx->bus_width != 12 && ctx->bus_width != 24)
> -               return -EINVAL;
> +       ret = it66121_of_read_bus_width(dev, &ctx->bus_width);
> +       if (ret)
> +               return ret;
>
>         ep = of_graph_get_remote_node(dev->of_node, 1, -1);
>         if (!ep) {
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
