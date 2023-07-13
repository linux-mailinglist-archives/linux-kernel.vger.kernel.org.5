Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860C5751CED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjGMJN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjGMJMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:12:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4289E2D76
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689239504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JgFtZUgh5go8zila2S4ZY5xFxZuToGtLb3sGveBEJbY=;
        b=ZR7jw0ZiH+CeXMHxrNQCRJQjEBLCravxENWfAJN/LccI+WeQkFYXdLvPiwj0VpFTe7fYnA
        ED1GaPD35iF7P7PryetibjmP9eqHB40tRbFQgP5MyYfbHYuFUwj8r1uN2vx/6vuvhGnktF
        b3ISwkYZFw0RMS+q/meeKATfAnGdGso=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-BU26ttaAOJutxHqrJtNIEw-1; Thu, 13 Jul 2023 05:11:40 -0400
X-MC-Unique: BU26ttaAOJutxHqrJtNIEw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b6fdb8d0acso1260161fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689239499; x=1689844299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgFtZUgh5go8zila2S4ZY5xFxZuToGtLb3sGveBEJbY=;
        b=ErvCTZYDvA2OaH1QuVaCYXfaBnBRXOu/J0YbOEg7scTkZCDQcm4VCzOUdIPkTL5IXF
         dPoLJje52hohdXT2of5mIMiE0LjByrEYg7iDBTKHLo0Ufs1zCaHfPKUnRsN0g4+kVC6t
         loAG0htl0wFLSNsdThtm7FBDWuZisRzMUdZ3ePrZ019DbmPlHtSpRjrTmJ/IFY7soBtG
         /WUPEAS37CNegAVdQz71UjY/HKUwFx2NkwT7mPlCOQugkvJkrAWgFTL9hTDj01+JB83Z
         TlY6TGY9oUBxLwX5yW2Y3scmJreSr+D3Xcm+RJgFMiYjJtRNAKAHl4Y6lO/tbNv7k3i1
         hQQQ==
X-Gm-Message-State: ABy/qLZOMgq4Ugu9fqXSmgMyNx7jjlxRiGlxXskTYpMlfqh5n0aYP1lU
        IUfj61HeOIFfSw2hEs6JoerqXT8zRzen84Uxe4Xp0IARhhsdQojhV6bEOdKb6TeVBPHNNNHPbWK
        V5jmL/PMarWIU+n9k6KdKfq/nOEWKP0HnAb+ULAwD
X-Received: by 2002:a2e:a790:0:b0:2b6:99a7:2fb4 with SMTP id c16-20020a2ea790000000b002b699a72fb4mr1029817ljf.0.1689239499531;
        Thu, 13 Jul 2023 02:11:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHNMXMfFllIlbsS7OgZ8tt30TUpflSFE8vHptSmh10AZhpcrU0369e6fqWHgckt6hGkADlesM/GIl6gUWcIL/8=
X-Received: by 2002:a2e:a790:0:b0:2b6:99a7:2fb4 with SMTP id
 c16-20020a2ea790000000b002b699a72fb4mr1029800ljf.0.1689239499293; Thu, 13 Jul
 2023 02:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230710062932.53655-1-xujianghui@cdjrlc.com> <7ab55aa7169d6a3bd0309b43c3de592e@208suo.com>
In-Reply-To: <7ab55aa7169d6a3bd0309b43c3de592e@208suo.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 13 Jul 2023 11:11:28 +0200
Message-ID: <CACO55tu=5HKnywnnV499YkVUg-o_HY8gMEQHozkLDdbNE=YQwg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/i2c: do not use assignment in if condition
To:     sunran001@208suo.com
Cc:     airlied@gmail.com, daniel@ffwll.ch, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 9:23=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> Assignments in if condition are less readable and error-prone.  Fixes
> also checkpatch warning:
>
> ERROR: do not use assignment in if condition
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
> index d063d0dc13c5..098051d3755c 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
> @@ -209,7 +209,8 @@ nvkm_i2c_aux_new_(const struct nvkm_i2c_aux_func
> *func,
>             struct nvkm_i2c_pad *pad, int id,
>             struct nvkm_i2c_aux **paux)
>   {
> -    if (!(*paux =3D kzalloc(sizeof(**paux), GFP_KERNEL)))
> +    *paux =3D kzalloc(sizeof(**paux), GFP_KERNEL);
> +    if (!*paux)
>           return -ENOMEM;
>       return nvkm_i2c_aux_ctor(func, pad, id, *paux);
>   }
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

