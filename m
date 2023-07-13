Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CCD751CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjGMJPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjGMJPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D6DB4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689239670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KAprlvR1Ix2PbgQmaBalxSCG9P2sXZzbouDbbLDyB+A=;
        b=R0PBHlv0+dXPUdBcmn/Wz3aE3jsHeQ/914qE8V2rUGlaMOeBYEaFZ1Fp1gCkBbd8I7Itoe
        cG1M+2eiOtj3doRGme8pDpWFhJ/GElPVy3AdAg9lTVEY7O6lgT35TFkRxnxIr9zCYz1YwM
        gA9a0aVt00JSVFXirjy7nI/22QsOZoQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-9Esh9TjQPhCz1AnW1NH2fQ-1; Thu, 13 Jul 2023 05:14:29 -0400
X-MC-Unique: 9Esh9TjQPhCz1AnW1NH2fQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b6fdb8d0acso1266291fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689239667; x=1689844467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAprlvR1Ix2PbgQmaBalxSCG9P2sXZzbouDbbLDyB+A=;
        b=iz+VE/OpESgwSPzOSupbTWjCgKNAYykZ8hlZT5seAPNvhSLaiiF2VwiJl4BvzrJ2lV
         X0fkTluwtpzFup27g2/lQftssCEF1v2C0mJEco28LTV3loesLLnfAvDMV30GVWPKv14K
         uT4E9EzavBLVWJbXNWtwiOMpgdDqIHvCg2qKp5cVb5W1YIOs6c5PxATUXCAbuc9S+OR1
         EsTc7mKUDLUl7cxTzIPO1y5okHtfpm+FvEV6Kt2yXVpCaXJt34+c+hWdG4cPiLKxZr/F
         NrMYtZeUB7Wh7ffjAu8hiaCQWTLDmYef1V0Ku+AF7ndTPPsYtHZlG5vKr5VLOat/ApCE
         zTVA==
X-Gm-Message-State: ABy/qLbrZDon3AM43jYPVSp1Dv8h6ylf+mP8ATgfMYlU29A7M70P3zMG
        fo4qTiRSSE7CVkUuV4mc1JSBPFUXcg4dJfE6QuJi9TUttihaDODc9IVZ/Ktq+E8/UvKC5iNpMHz
        jAcTGUgOFtgivn2GRfgjlwkk/JtS44B5RZubRapd5
X-Received: by 2002:a2e:a790:0:b0:2b6:99a7:2fb4 with SMTP id c16-20020a2ea790000000b002b699a72fb4mr1037274ljf.0.1689239667744;
        Thu, 13 Jul 2023 02:14:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEkshQIMfUIvgmhESYeAU1+QrImVvQD8hS/q4nZ4jzkB6vlgYRDkE2AQxSAa5zT+wKB/ukH3fmIoOvzD5m3kis=
X-Received: by 2002:a2e:a790:0:b0:2b6:99a7:2fb4 with SMTP id
 c16-20020a2ea790000000b002b699a72fb4mr1037259ljf.0.1689239667458; Thu, 13 Jul
 2023 02:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230710070505.53916-1-xujianghui@cdjrlc.com> <1ddf673283e93e83d912066f2241b976@208suo.com>
 <ZKvK4NXzkKZTE35E@debian.me> <CACO55tuG+4=4MTGq=FRuuP8dJaAHwtMCy3e9H8v5d8dVGsnkJw@mail.gmail.com>
In-Reply-To: <CACO55tuG+4=4MTGq=FRuuP8dJaAHwtMCy3e9H8v5d8dVGsnkJw@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 13 Jul 2023 11:14:16 +0200
Message-ID: <CACO55tubrPUcdcsfavOqNt6_oqibNceVLGmpjS3Vtz13RqELGw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/iccsense:
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     sunran001@208suo.com, airlied@gmail.com, daniel@ffwll.ch,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 11:13=E2=80=AFAM Karol Herbst <kherbst@redhat.com> =
wrote:
>
> On Mon, Jul 10, 2023 at 11:10=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.=
com> wrote:
> >
> > On Mon, Jul 10, 2023 at 03:06:47PM +0800, sunran001@208suo.com wrote:
> > > Fixed error: 'do not use assignment in if condition'
> > >
> > > This patch fixes error: 'do not use assignment in if condition'
> > > in drm/nouveau/iccsense
> >
> > I guess this is checkpatch fix, right?
> >
> > >
> > > Signed-off-by: Ran Sun <sunran001@208suo.com>
> > > ---
> > >  drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> > > b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> > > index 8f0ccd3664eb..2428f3d6e477 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> > > @@ -322,7 +322,8 @@ int
> > >  nvkm_iccsense_new_(struct nvkm_device *device, enum nvkm_subdev_type=
 type,
> > > int inst,
> > >             struct nvkm_iccsense **iccsense)
> > >  {
> > > -    if (!(*iccsense =3D kzalloc(sizeof(**iccsense), GFP_KERNEL)))
> > > +    *iccsense =3D kzalloc(sizeof(**iccsense), GFP_KERNEL);
> > > +    if (!*iccsense)
> > >          return -ENOMEM;
> > >      INIT_LIST_HEAD(&(*iccsense)->sensors);
> > >      INIT_LIST_HEAD(&(*iccsense)->rails);
> >
> > Your patch is corrupted (tabs converted to spaces) because you're using
> > Roundcube. Please use git-send-mail(1) instead.
> >
>
> oh right, I didn't notice with the patches I reviewed already here.
> Yeah, none of them apply, please use git to send those patches.
>

also please send them all together in a single series the next time.

> > Thanks.
> >
> > --
> > An old man doll... just what I always wanted! - Clara

