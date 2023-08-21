Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C63B7821B0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 04:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjHUCxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 22:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjHUCxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 22:53:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C659C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 19:53:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so3365245a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 19:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692586401; x=1693191201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yk6N/H89rG2XGekr3UL0YyNLbJwptjYVEPotSs/smck=;
        b=c02Zp6aXh2uGpgMqgk2Ppw1Vt7hCRaxZCVWABIl3WHT24TcytfIuKm4oZSNQgEP2yK
         OcQm6IvMgQv+CHW2txcg7SDef4G7r+izU1rclrNE74wGdRyagBEVQNj13+GYlC9ZtA00
         9qtjn6V/QBTvzL5ncpbyeMC+vZE9fFdWnazykiXvXEUQcv5Twm0nXJyuRY0FnKBBF5x+
         7jIC6BCMrbErVNqwHHkQn5O8NmzTbhYfJv3bgnXRbWxw6YvRuSyaZVAkZFSlT8nPZglA
         8jKalMKZlGSDkknmAQ0d684eoEp58dLZagKvgLU7e3yIdXfbz8EZQZZ2ldMzjMCmPgl5
         bnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692586401; x=1693191201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yk6N/H89rG2XGekr3UL0YyNLbJwptjYVEPotSs/smck=;
        b=el7uIHM5rgRB+Bk21mXeut5Z0bYy6z/CQI5LK3hwArzETMS5CygqV6JgBEEThXZ0N9
         SiR4oKVTD+NOUviwhj+E/NLNUUt52/CyKU4ZwKA8c37nyzLPgDv7g9jhn0/QgvOW5c1c
         ViESKeu6ISqHbgU87C1qH3T49/O2o0c2FLlrLF0s5rjDV86FhIzyuQ4GZcub28MfwYDN
         wUFyGQkNUrPn2Hwod0geHDrAGhMq5zg7+qBaovu++75NZ3NR7Fo4M21IlyL1usGSRjX7
         q+1FSj8tq7/YSPpe2wsXLJ7tQK/vPGQcwSfXTaVnK5zUN+84iKV5htbF732lk3byeCEZ
         1K2Q==
X-Gm-Message-State: AOJu0Yy7OlMOgTeSMxAxx6vEnXn3zp75K5DL3ZA+0bvquH19ke9qHADf
        PW/t9VaoPPplzDgnfq2i1935uuzP7EeZ9UV7/wH2Tt+jzkOWKw==
X-Google-Smtp-Source: AGHT+IGpcuIkBMuljYqNy8fyhXeLygXxQIfEVdNqZXzRPTI7GcpoBSmzuovQead8nkhaQOuXQke305jrcS0G63+23J4=
X-Received: by 2002:a17:906:5a68:b0:99b:d178:f059 with SMTP id
 my40-20020a1709065a6800b0099bd178f059mr3755330ejc.35.1692586401025; Sun, 20
 Aug 2023 19:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230820222920.2344-1-dakr@redhat.com>
In-Reply-To: <20230820222920.2344-1-dakr@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 21 Aug 2023 12:53:09 +1000
Message-ID: <CAPM=9txjnd_MrhANjoGqJ4iU1sNvz92MdsRUm_XbzGR-=daBTg@mail.gmail.com>
Subject: Re: [PATCH drm-misc-next] drm/nouveau: uvmm: fix unset region pointer
 on remap
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, bskeggs@redhat.com, kherbst@redhat.com,
        lyude@redhat.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Dave Airlie <airlied@redhat.com>

On Mon, 21 Aug 2023 at 08:29, Danilo Krummrich <dakr@redhat.com> wrote:
>
> Transfer the region pointer of a uvma to the new uvma(s) on re-map to
> prevent potential shader faults when the re-mapped uvma(s) are unmapped.
>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_uvmm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> index 3a1e8538f205..aae780e4a4aa 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -639,6 +639,7 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
>                         struct drm_gpuva *va = r->unmap->va;
>                         struct uvmm_map_args remap_args = {
>                                 .kind = uvma_from_va(va)->kind,
> +                               .region = uvma_from_va(va)->region,
>                         };
>                         u64 ustart = va->va.addr;
>                         u64 urange = va->va.range;
>
> base-commit: 25205087df1ffe06ccea9302944ed1f77dc68c6f
> --
> 2.41.0
>
