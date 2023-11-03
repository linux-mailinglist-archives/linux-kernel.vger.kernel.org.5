Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4587DFE65
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 04:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjKCD2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 23:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjKCD2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 23:28:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E9719E;
        Thu,  2 Nov 2023 20:28:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9c3aec5f326so540443866b.1;
        Thu, 02 Nov 2023 20:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698982110; x=1699586910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zb/a36wLOX8RMsCCsQ/Odv/4Pe7YOEMbRJ5Kk+EkPKg=;
        b=RCW08A5LFe0uQ5cYvG65HdGznvgkdt+iZE3KqWUp09BvudoUx25Ga0eZ1niD8PvN9r
         VaVxkANEel8xcNC+HSUlaM0EvMG9MBzEwgbS9ULX9ElFTgcXXwlY5Vt+HyA5H0fzOyYa
         fbqVSXAqUgzO4aWEC8IGRs3BgIMFnDOPYtmXkhSLxyxF5tDkJmaACHj6sBEDXq0TZdeL
         +TIGXM+klAtLc8akx8uoUJHWBPjbLXAj5lrLEySZIvDOp5D24C8cf3zBtGArGzFYfKHe
         yY4A5O0lsiC8qnPZONOmYAyHmx0VnijDWmsK32h9Z6clquKrHQtYfHX3LlfX+eIATmru
         347w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698982110; x=1699586910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zb/a36wLOX8RMsCCsQ/Odv/4Pe7YOEMbRJ5Kk+EkPKg=;
        b=Xr1L0/4FETA+G9yNsYtFuKBNjyqWF26kEfQYP8JMZ0BJpkhLMxATYOKOPwCJDSTPSA
         jwHWMhD6b6b6FASCbM+CRShw0dai7pb7v2a/KMzbAbEy+G7oDqkYqcT+qSJeYCVEy9bV
         Bjnc9hNdMlKpsXZ3Tj3hDUfa7MjoLhrKIfcsHTfB6o4xOKw20yIuYfhcqLjnJK++mMgs
         2v4ul4jPEE17SsPPhOhI6BjlDXpGGPSe+G+MK4b0ICnwJIqFRjjVtcptVj7tC5+dQP2s
         hQwrttlCGSAKN5QBuhwYrFuZ2PggnQEQINP1CWsKiBgVlDmmwkwZgsDgfCzyne9a0FPe
         g6QQ==
X-Gm-Message-State: AOJu0YySRg/ZQqFIMp1ZN66q+D5Mv2UnfKs10DPlzfrnoo+H9Ew9Q7Um
        saJwMhUPl6eae4HZaYDPfeWuGeOxPGYXYNXIWW4=
X-Google-Smtp-Source: AGHT+IHLoKNmS9eyyf4W6p2GhUKWMvawf2nQfjJZXE6Hghrwd8VFwEN8fXmOqR7kdMieSsVR+kgjZ++bD2Ima2x2qt0=
X-Received: by 2002:a17:907:968d:b0:9b2:b808:6a1c with SMTP id
 hd13-20020a170907968d00b009b2b8086a1cmr1385757ejc.35.1698982109881; Thu, 02
 Nov 2023 20:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231103024119.15031-1-dakr@redhat.com>
In-Reply-To: <20231103024119.15031-1-dakr@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 3 Nov 2023 13:28:18 +1000
Message-ID: <CAPM=9tx7n+v-c-Qjd7O9GFOgyX4EbFZ=Jk_VOM9i0z6BmocJZw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/gr/gf100-: unlock mutex failing to create
 golden context
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     nouveau@lists.freedesktop.org, faith@gfxstrand.net,
        lyude@redhat.com, kherbst@redhat.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2023 at 12:41, Danilo Krummrich <dakr@redhat.com> wrote:
>
> Do not return from gf100_gr_chan_new() with fecs mutex held when failing
> to create the golden context image.

Reviewed-by: Dave Airlie <airlied@redhat.com>
>
> Cc: <stable@vger.kernel.org> # v6.2+
> Fixes: ca081fff6ecc ("drm/nouveau/gr/gf100-: generate golden context during first object alloc")
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> index c494a1ff2d57..f72d3aa33442 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> @@ -442,6 +442,7 @@ gf100_gr_chan_new(struct nvkm_gr *base, struct nvkm_chan *fifoch,
>         if (gr->data == NULL) {
>                 ret = gf100_grctx_generate(gr, chan, fifoch->inst);
>                 if (ret) {
> +                       mutex_unlock(&gr->fecs.mutex);
>                         nvkm_error(&base->engine.subdev, "failed to construct context\n");
>                         return ret;
>                 }
> --
> 2.41.0
>
