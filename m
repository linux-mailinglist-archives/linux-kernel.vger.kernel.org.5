Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F1676DDE6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 04:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjHCCPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 22:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHCCPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 22:15:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7107518D;
        Wed,  2 Aug 2023 19:15:11 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bcf2de59cso60969966b.0;
        Wed, 02 Aug 2023 19:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691028910; x=1691633710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=unkis5nXNs66F8VIMqSk5MoQfKJubskRTJFUPZd8qbw=;
        b=k1jX/fjz8FkLDLaxCgVrmFEJuJOa6PlfRIOdx4jo1nBpHhdVWAwDEQUPMl92Dj7i+s
         /AtOYhnL8sCreORgAgG+mFSo9RaBNL0Wmzpw+SE0MZv86SsicfZIX+YcUBDQSg72DNJ5
         LuJzisNL4IVjh4B1xGHaTgRr240XVQVG+fcjzmyN/qBSDnQKOavbGZgRzVNvrowJGASe
         2NCNenCsPqNX85acun6Ez5JK/T49iwuC7H2MbAe+L5nSycE8vxkpMPiM/SlC1nKWiYWa
         81LTouMO7tgBCY7LNPze6oWXCY89ke2WX0NU6pNnAg7uoNdj+0suDBxQgWpVy6XBjBue
         hq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691028910; x=1691633710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unkis5nXNs66F8VIMqSk5MoQfKJubskRTJFUPZd8qbw=;
        b=UOyh+ZyTbF4hvdqc1ag1qEAl59GVVyxc5/KUK6eBvs9dfhw00dLBqqY+BG1qV1Q7Xc
         PZOVBMf1VqHm4r1UukhDURscryUy8uIgrQkMnREiwYlPdamrW4c9RcB8rutwxgxUTpn/
         WeFOVV5v2HSbGKiBBj5VFgiD09S5ibEFFRDSrOdYkuzxAzUuyMREOrTdIGZZEXeFnt0B
         qkjb1GPAZRDaIKLotaWJHycTOQCWa3EQDWEVC/R35y6Cak4sPgjMQExXWHzIYEzmgpMo
         gZ3pWuEwHO7PeQ3rr5Igq7ChbP0xz5TCuxiL1l6z+Myvpxt3LkIC+cCr0LPn/Tr9g9hG
         BBrg==
X-Gm-Message-State: ABy/qLak7E9ht0udf62XQx0mkl+WYpQ16SqvDskWArQdoQnCb72D6XV3
        P9ijdyFtklPp9kU0oSVZWJS+vJSrcF3Ed65zfiTIQ2sdp7w=
X-Google-Smtp-Source: APBJJlGfaOHFrEispGkCIYBL3pBtijSTK2Andpe3ZctM0sw1IZGwRKwVImEjxbYXaed1UDCcW5GfPRF56xFdEy3SCnw=
X-Received: by 2002:a17:907:2c77:b0:992:48b7:99e3 with SMTP id
 ib23-20020a1709072c7700b0099248b799e3mr6243347ejc.63.1691028909671; Wed, 02
 Aug 2023 19:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230622152017.2512101-1-kherbst@redhat.com>
In-Reply-To: <20230622152017.2512101-1-kherbst@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 3 Aug 2023 12:14:57 +1000
Message-ID: <CAPM=9ty8KT+JNu3x_qu4_1+Xg91Hdhyak_4_AVOfRQ0GMDjD9w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/nouveau/gr: enable memory loads on helper
 invocation on all channels
To:     Karol Herbst <kherbst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023 at 01:20, Karol Herbst <kherbst@redhat.com> wrote:
>
> We have a lurking bug where Fragment Shader Helper Invocations can't load
> from memory. But this is actually required in OpenGL and is causing random
> hangs or failures in random shaders.
>
> It is unknown how widespread this issue is, but shaders hitting this can
> end up with infinite loops.
>
> We enable those only on all Kepler and newer GPUs where we use our own
> Firmware.
>
> Nvidia's firmware provides a way to set a kernelspace controlled list of
> mmio registers in the gr space from push buffers via MME macros.

seems sane,

Reviewed-by: Dave Airlie <airlied@redhat.com>
>
> v2: drop code for gm200 and newer.
>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: nouveau@lists.freedesktop.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h  |  1 +
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c  |  4 +++-
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c  | 10 ++++++++++
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c |  1 +
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c  |  1 +
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c  |  1 +
>  6 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h
> index 00dbeda7e346..de161e7a04aa 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h
> @@ -117,6 +117,7 @@ void gk104_grctx_generate_r418800(struct gf100_gr *);
>
>  extern const struct gf100_grctx_func gk110_grctx;
>  void gk110_grctx_generate_r419eb0(struct gf100_gr *);
> +void gk110_grctx_generate_r419f78(struct gf100_gr *);
>
>  extern const struct gf100_grctx_func gk110b_grctx;
>  extern const struct gf100_grctx_func gk208_grctx;
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c
> index 94233d0119df..52a234b1ef01 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c
> @@ -906,7 +906,9 @@ static void
>  gk104_grctx_generate_r419f78(struct gf100_gr *gr)
>  {
>         struct nvkm_device *device = gr->base.engine.subdev.device;
> -       nvkm_mask(device, 0x419f78, 0x00000001, 0x00000000);
> +
> +       /* bit 3 set disables loads in fp helper invocations, we need it enabled */
> +       nvkm_mask(device, 0x419f78, 0x00000009, 0x00000000);
>  }
>
>  void
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c
> index 4391458e1fb2..3acdd9eeb74a 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c
> @@ -820,6 +820,15 @@ gk110_grctx_generate_r419eb0(struct gf100_gr *gr)
>         nvkm_mask(device, 0x419eb0, 0x00001000, 0x00001000);
>  }
>
> +void
> +gk110_grctx_generate_r419f78(struct gf100_gr *gr)
> +{
> +       struct nvkm_device *device = gr->base.engine.subdev.device;
> +
> +       /* bit 3 set disables loads in fp helper invocations, we need it enabled */
> +       nvkm_mask(device, 0x419f78, 0x00000008, 0x00000000);
> +}
> +
>  const struct gf100_grctx_func
>  gk110_grctx = {
>         .main  = gf100_grctx_generate_main,
> @@ -854,4 +863,5 @@ gk110_grctx = {
>         .gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
>         .r418800 = gk104_grctx_generate_r418800,
>         .r419eb0 = gk110_grctx_generate_r419eb0,
> +       .r419f78 = gk110_grctx_generate_r419f78,
>  };
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c
> index 7b9a34f9ec3c..5597e87624ac 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c
> @@ -103,4 +103,5 @@ gk110b_grctx = {
>         .gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
>         .r418800 = gk104_grctx_generate_r418800,
>         .r419eb0 = gk110_grctx_generate_r419eb0,
> +       .r419f78 = gk110_grctx_generate_r419f78,
>  };
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c
> index c78d07a8bb7d..612656496541 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c
> @@ -568,4 +568,5 @@ gk208_grctx = {
>         .dist_skip_table = gf117_grctx_generate_dist_skip_table,
>         .gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
>         .r418800 = gk104_grctx_generate_r418800,
> +       .r419f78 = gk110_grctx_generate_r419f78,
>  };
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c
> index beac66eb2a80..9906974ac3f0 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c
> @@ -988,4 +988,5 @@ gm107_grctx = {
>         .r406500 = gm107_grctx_generate_r406500,
>         .gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
>         .r419e00 = gm107_grctx_generate_r419e00,
> +       .r419f78 = gk110_grctx_generate_r419f78,
>  };
> --
> 2.41.0
>
