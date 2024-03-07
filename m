Return-Path: <linux-kernel+bounces-96109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4FB875739
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF9428625F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D512A13792E;
	Thu,  7 Mar 2024 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6Jhcrs/"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412E61369BD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839881; cv=none; b=Ao5YwW3YjuH4B17VI3WN0xd9R2uSYenEPm9owuQzOoSmqO/dH/x2fDYVo7HqIuLsWDYOgbo2ycXBqI/gl7u2QCQh0D7oqGhXb+newgPE0qHq40l2+bzpWhdax3qOe5uOHlBiirPOgYmd4amUPWx8b0dWYgpVQSMmT4igIs8KSOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839881; c=relaxed/simple;
	bh=wjHLIsIjsz5YtE4R2c+azsfc9D2Q1R8pthpsCOBRyQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVwJtQ/3ahUuyfD0VvA1ZBPaCbxWIetN4TULvuNKlx0KS//OM6ao2MFJLoUg+ea8+yHRrOq7N3LtbfsWSfByOxPzSCnt6a0sQ3pXYlRZFeW6rW9uY+ttFaAmDxsksZBnV8ex2alCAYr8Fmu7xNUJJUFTc2ubGAl7LZRcqZA3akg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n6Jhcrs/; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60982a6d8a7so1686667b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709839878; x=1710444678; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PCETR6xATNNqCCnkCbkWB2goU+g4Ke4A3ZOjvnBM1l4=;
        b=n6Jhcrs/39KJnnbv+P+CCcbTmX3xxQPDlFvubXjNMRwMWe74Vekma7zMlQq9KhvTVm
         LYUGx3hn/2z9+b20FZS+MnRIPzGaJAuRQzYZCzWpA0knFeD3u7UtCR5ZzXKVekc7N4pP
         JNw2kH+yP8ilNm8IUW/nsoVjSQ3h3rV3zB4CxhLI3KNCbG2jSWH5/C42wJj8eyjSbCUa
         IDqAJ8CtXAYeh9STcwudKi5W4n/JMQvoopU2oAT/jZS5y0qZEMR+RdVz5CvaTSujet/D
         U9g0z8cpIoFCjuyNkoDf/nVlKkxIcUBpOtFIn3uNDae95HxIq8ijukUU1tyUeuihGUCH
         +ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709839878; x=1710444678;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCETR6xATNNqCCnkCbkWB2goU+g4Ke4A3ZOjvnBM1l4=;
        b=e+pOcLWXmKjzML9nHhsw2C7iNE1YXZvp1FtIa5DRGIvtdAIMeZPSgQu3Og9yiWncbx
         bCk2xubk6Jjd6OL+TKDIdNsTHg7cpKA+478HwDMlGuzVB4Hkfnap87gUhxEF5fo9PtGB
         oY/6nkiqN2RASe0noeYxt6ptyKig/o4bt5GReka6rU2Q9pN1E1evw629Sd+sNnIvu4kU
         t5ejQeKV+hhW46sIk5xUjH/66sP8aRIDa68a3B0n1AwY4PM6mQZS67/Pe8KTmDnwUw5N
         w/iPttqnc2jTyu6zTRXb8CV00imn5kioZ0RHwTRPLRo4NQhzoGM3R3Fsud3wagwR4zLU
         zd4A==
X-Forwarded-Encrypted: i=1; AJvYcCUgzYfYTnBO/VrcMz6HLLxL2p9PV3Afqzj0jacv2D2aT5wR+9USuiyHjJYYNAlUKFsyO+jz3RvJzCyf8/Yyc4REbFv3IuFCWst+0tld
X-Gm-Message-State: AOJu0YxNK3IZXhjQo6vqc7YCFiiF9iRJtiJVde2U7v+EfiGQ51UVVkVl
	shuJ22xwlHeQdaG2zQazTo9bbgv/LybqHFCgF7VQ4oZpj2pNuwHz90UqKGzQYrAwxborPTgfn/A
	2ybN8CXCeVyDwMjE0WMZ3JF/3y3NNPD6Lo3cA/A==
X-Google-Smtp-Source: AGHT+IG/lG/+9pIjKimGHVPHBUoVUFsLKcsfXtMQ9jFwKu2z17RjD9mEueX+OHf6CusgAmcRzq+qXYbJlHF7JWFlHEg=
X-Received: by 2002:a0d:f6c3:0:b0:609:8719:b935 with SMTP id
 g186-20020a0df6c3000000b006098719b935mr20208837ywf.8.1709839878122; Thu, 07
 Mar 2024 11:31:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307172334.1753343-1-sui.jingfeng@linux.dev> <20240307172334.1753343-5-sui.jingfeng@linux.dev>
In-Reply-To: <20240307172334.1753343-5-sui.jingfeng@linux.dev>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 7 Mar 2024 21:31:06 +0200
Message-ID: <CAA8EJpqtPRfe1VL_ACYEOSq=iNMkZ03-fwVv3XdVrpTObZFu1w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm-bridge: it66121: Use fwnode API to acquire
 device properties
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Phong LE <ple@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 19:24, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Make this driver less DT-dependent by calling the freshly created helpers,
> should be no functional changes for DT based systems. But open the door for
> otherwise use cases. Even though there is no user emerged yet, this still
> do no harms. In fact, we reduce some boilerplate across drm bridge drivers.
>
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 63 ++++++++++++++++------------
>  1 file changed, 36 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 1c3433b5e366..a2cf2be86065 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -15,7 +15,6 @@
>  #include <linux/bitfield.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> -#include <linux/of_graph.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/regulator/consumer.h>
> @@ -1480,7 +1479,7 @@ static int it66121_audio_codec_init(struct it66121_ctx *ctx, struct device *dev)
>
>         dev_dbg(dev, "%s\n", __func__);
>
> -       if (!of_property_read_bool(dev->of_node, "#sound-dai-cells")) {
> +       if (!fwnode_property_present(dev_fwnode(dev), "#sound-dai-cells")) {
>                 dev_info(dev, "No \"#sound-dai-cells\", no audio\n");
>                 return 0;
>         }
> @@ -1503,13 +1502,37 @@ static const char * const it66121_supplies[] = {
>         "vcn33", "vcn18", "vrf12"
>  };
>
> +static int it66121_read_bus_width(struct fwnode_handle *fwnode, u32 port,
> +                                 u32 *bus_width)
> +{
> +       struct fwnode_handle *endpoint;
> +       u32 val;
> +       int ret;
> +
> +       endpoint = fwnode_graph_get_endpoint_by_id(fwnode, port, 0, 0);
> +       if (!endpoint)
> +               return -EINVAL;
> +
> +       ret = fwnode_property_read_u32(endpoint, "bus-width", &val);
> +       fwnode_handle_put(endpoint);
> +       if (ret)
> +               return ret;
> +
> +       if (val != 12 && val != 24)
> +               return -EINVAL;
> +
> +       *bus_width = val;
> +
> +       return 0;
> +}
> +
>  static int it66121_probe(struct i2c_client *client)
>  {
>         u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
> -       struct device_node *ep;
>         int ret;
>         struct it66121_ctx *ctx;
>         struct device *dev = &client->dev;
> +       struct fwnode_handle *fwnode = dev_fwnode(dev);
>
>         if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>                 dev_err(dev, "I2C check functionality failed.\n");
> @@ -1520,37 +1543,23 @@ static int it66121_probe(struct i2c_client *client)
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
> -
> -       ep = of_graph_get_remote_node(dev->of_node, 1, -1);
> -       if (!ep) {
> -               dev_err(ctx->dev, "The endpoint is unconnected\n");
> -               return -EINVAL;
> -       }
> -
> -       if (!of_device_is_available(ep)) {
> -               of_node_put(ep);
> -               dev_err(ctx->dev, "The remote device is disabled\n");
> -               return -ENODEV;
> -       }
> +       /* Endpoint of port@0 contains the bus-width property */
> +       ret = it66121_read_bus_width(fwnode, 0, &ctx->bus_width);

There is no need to pass port as an argument to that function.


> +       if (ret)
> +               return ret;
>
> -       ctx->next_bridge = of_drm_find_bridge(ep);
> -       of_node_put(ep);
> +       ctx->next_bridge = drm_bridge_find_next_bridge_by_fwnode(fwnode, 1);
>         if (!ctx->next_bridge) {
>                 dev_dbg(ctx->dev, "Next bridge not found, deferring probe\n");
>                 return -EPROBE_DEFER;
> +       } else if (IS_ERR(ctx->next_bridge)) {
> +               ret = PTR_ERR(ctx->next_bridge);
> +               dev_err(dev, "Error in founding the next bridge: %d\n", ret);
> +               return ret;

Nit: I'd usually expect this part to be in a different order: first
check for error, then check for absence. But that's a minor thing.

>         }
>
>         i2c_set_clientdata(client, ctx);
> @@ -1584,9 +1593,9 @@ static int it66121_probe(struct i2c_client *client)
>         }
>
>         ctx->bridge.funcs = &it66121_bridge_funcs;
> -       ctx->bridge.of_node = dev->of_node;
>         ctx->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
>         ctx->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
> +       drm_bridge_set_node(&ctx->bridge, fwnode);
>
>         ret = devm_request_threaded_irq(dev, client->irq, NULL, it66121_irq_threaded_handler,
>                                         IRQF_ONESHOT, dev_name(dev), ctx);
> --
> 2.34.1
>


--
With best wishes
Dmitry

