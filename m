Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1949B786A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240594AbjHXInH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbjHXImk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:42:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C151709
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692866523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IsB/rgE71MKRCAfugQoyX1VTNTlOQvUYEhfYQX7N874=;
        b=JlN/3UFfr9XQLohJBMtabr5wjyjLIc7UZrZK4A0uZ20uWy6GSWlJwFrUDMNwIzmNT8A4Fe
        8NhuoXWumtYqRTusoROZT/oQoZvSoCH1S9iUFWt5pE8p80QD1vu3EDu/hT0XMWZviqdjpd
        SsSjUR+odpRlJyid/95Mdg9N+MiYb64=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-HYmbCOsxNuuGjj2XnVH6ag-1; Thu, 24 Aug 2023 04:41:57 -0400
X-MC-Unique: HYmbCOsxNuuGjj2XnVH6ag-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b9d5bc6161so14250151fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692866516; x=1693471316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsB/rgE71MKRCAfugQoyX1VTNTlOQvUYEhfYQX7N874=;
        b=lr6yXUlDhy2Mi/cSAV1N5cZ3iGv/1ml0DVYInq8OwRJI7LAcTbkCQa67vlp/OPcE9w
         kt3UPeIm8SCC43H0eiMskJsaqSdbvGJrWLD6UrdUenX5wf9lMGU0iEiZuZYlAN53XJjx
         0EhlRByWpi/zH/w7/1H1k4Ur2GwD7mirUTtd4NFWqyVDxK+pRTYisyX0pR9oW0IRMC6W
         XvU/RHjA7toNEsZdL/52yjV82AWXManLAizI1p9NopVt99veuzHEhNLLfle1rZcjluiz
         cxgfiHYvb1eU2dmSOj9mO8SbyZU8y9b+zx/LpeTXmnuxgMDrkea7eNiFOdzuecF1a5D5
         0g7A==
X-Gm-Message-State: AOJu0YyfOzYU5xUokS4//j/s/IOQPg9oKytffU75fk/JD3URUi+1X+7f
        kCQEuVFbOG56lpiMQHz1n218TYEKuOr607Zyw+GPCMj7vJlpNVNd7Xl0Sz2eK3vQo1Hels2b9um
        /tMivBCucnI3jcjryes7+TJl1YdWyIUKZL6KyEifF
X-Received: by 2002:a2e:a795:0:b0:2b6:7c3a:6adc with SMTP id c21-20020a2ea795000000b002b67c3a6adcmr12550898ljf.5.1692866516043;
        Thu, 24 Aug 2023 01:41:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZUHPWZDKgvC3dNDa3Zh4y3brX0dAkFwoJfBWqG0XeVgAinujTjApQBRr3j9aCYGGyak4hQCHpLkui5aRtbIw=
X-Received: by 2002:a2e:a795:0:b0:2b6:7c3a:6adc with SMTP id
 c21-20020a2ea795000000b002b67c3a6adcmr12550879ljf.5.1692866515666; Thu, 24
 Aug 2023 01:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230824073710.2677348-1-lee@kernel.org> <20230824073710.2677348-5-lee@kernel.org>
In-Reply-To: <20230824073710.2677348-5-lee@kernel.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 24 Aug 2023 10:41:44 +0200
Message-ID: <CACO55tvZ+mv7xxRB4hbM7ttTnJznbyVAs41fn1Dq-rEeLUWYyg@mail.gmail.com>
Subject: Re: [PATCH 04/20] drm/nouveau/nvkm/subdev/volt/gk20a: Demote
 kerneldoc abuses
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 9:37=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:49: warning: This comme=
nt starts with '/**', but isn't a kernel-doc comment. Refer Documentation/d=
oc-guide/kernel-doc.rst
>  drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:62: warning: This comme=
nt starts with '/**', but isn't a kernel-doc comment. Refer Documentation/d=
oc-guide/kernel-doc.rst
>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c b/drivers/g=
pu/drm/nouveau/nvkm/subdev/volt/gk20a.c
> index 8c2faa9645111..ccac88da88648 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c
> @@ -45,7 +45,7 @@ static const struct cvb_coef gk20a_cvb_coef[] =3D {
>         /* 852 */ { 1608418, -21643, -269,     0,    763,  -48},
>  };
>
> -/**
> +/*
>   * cvb_mv =3D ((c2 * speedo / s_scale + c1) * speedo / s_scale + c0)
>   */
>  static inline int
> @@ -58,7 +58,7 @@ gk20a_volt_get_cvb_voltage(int speedo, int s_scale, con=
st struct cvb_coef *coef)
>         return mv;
>  }
>
> -/**
> +/*
>   * cvb_t_mv =3D
>   * ((c2 * speedo / s_scale + c1) * speedo / s_scale + c0) +
>   * ((c3 * speedo / s_scale + c4 + c5 * T / t_scale) * T / t_scale)
> --
> 2.42.0.rc1.204.g551eb34607-goog
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

