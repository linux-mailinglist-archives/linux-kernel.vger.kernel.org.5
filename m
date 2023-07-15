Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DFF7547E4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjGOJYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGOJYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCE73A82
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 02:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689412997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T67vF7lK28TebQE5iDVY482spLCTkCO2SL9TUb1C5Xo=;
        b=cvakwiVGNEbmv6c2hlmId7WQNDwueS0EfRvIwYyEXSQMl7hvwH0QC7Ri7ZDvHx0xQDnxc+
        8waxNQgxDY3zUbrE9AiaLnq9ShOWjWy/y6EOl9FD1Y9FoPbOCnKCudbecEB+RIrDme2386
        4mXQKKa4FLj1u0OohjhSRT8Xwq7t/9Y=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-GKL0dW94NUCkWM_23n4nLw-1; Sat, 15 Jul 2023 05:23:14 -0400
X-MC-Unique: GKL0dW94NUCkWM_23n4nLw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b04d5ed394so4834941fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 02:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689412992; x=1690017792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T67vF7lK28TebQE5iDVY482spLCTkCO2SL9TUb1C5Xo=;
        b=jgIHcgwqd0PsT/E6rDihHO2nKyJCm5CJufstHxTDuBrxcIu1uFukkUzz1Cu6NPEQRk
         QX2isdumFI3wwP2ZMLz7MPeErGe5q+vtnt2ypkU0A3Y24gfuLH3ShOORrx3cCNvSuoJP
         cs9T0trbCLOs2ibaOR0m7y2YhIsenEDzupGIpVl3eg5/haH9lAN+x704QE0fYzPsEleN
         h5MpB8L1TkjQyHWxDD+hR9MMXWXdSoWewcMmrJ75haAuUj1C8Or9J1OMjd5E3+oTud2w
         cPyAcTBhXXelpHkVJTqszDQkKLfqBt21xnqMVaWrdJy1hb3yvkDuLjScKnO77EZ/BLmQ
         M1sg==
X-Gm-Message-State: ABy/qLZSc9egNRAk2coPCh7UcptDwJ/qcdi5aUYbRzTphrifwFLvKFn5
        2UilDE+d1be32j7B2HZ4RlqEWCWuDei6XySY2v+9HdfuD5h8Yn5CVv//OywMAw2155jHt7CLzOf
        tcoyERY+rq/41JV+jsmBxZ7z4rU5y1thzeRXwZSlE
X-Received: by 2002:a05:651c:2123:b0:2b6:a662:b879 with SMTP id a35-20020a05651c212300b002b6a662b879mr964535ljq.3.1689412992752;
        Sat, 15 Jul 2023 02:23:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFalwUBzCDIhgeQM4PgOEFdZlcRiXI5UE3UZbzH859X91WuS1+9/Njeg/b/sg7vTRMDlagQb8LNWaQla49OP5g=
X-Received: by 2002:a05:651c:2123:b0:2b6:a662:b879 with SMTP id
 a35-20020a05651c212300b002b6a662b879mr964525ljq.3.1689412992377; Sat, 15 Jul
 2023 02:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <5c894d0a8a178628ca200d054004be3c@208suo.com> <f25017a660f8a3a4e49258a1d96003dc@208suo.com>
 <2f4a7303e305d07fdd9c15a9dc95dc5f@208suo.com> <d0d767fb0dd3a9b7642559f379dbb0d6@208suo.com>
 <0ad4154429aaa41ca26da859c3f35784@208suo.com> <856d1130fad58062ea454da297fa64348382bda2.camel@redhat.com>
In-Reply-To: <856d1130fad58062ea454da297fa64348382bda2.camel@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Sat, 15 Jul 2023 11:23:01 +0200
Message-ID: <CACO55tu08XTx=TZQK=RyCGRdFVDQN9m+X+y3F3V0H7nuwyycRw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/fifo:Fix Nineteen occurrences of the gk104.c
 error: ERROR: : trailing statements should be on next line
To:     Lyude Paul <lyude@redhat.com>
Cc:     huzhi001@208suo.com, bskeggs@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 1:07=E2=80=AFAM Lyude Paul <lyude@redhat.com> wrote=
:
>
> NAK - checkpatch.pl is a (strongish) guideline, but not a rule. In the ca=
ses
> corrected in the patch series here, we format the switch cases on single =
lines
> as it dramatically improves the readability of what is otherwise just a /=
long/
> list of slightly different static mappings. I don't believe we're the onl=
y
> part of the kernel to do this either.
>

I wished there was a place to document something like "patches whose
only reason is 'checkpatch.pl' said so" will be rejected.

I think following some checkpatch rules are sane, but then the
argument should be "makes code more clear" or "converts risky coding
practises to less risky ones". Or do we have such a place? Maybe we
should patch checkpatch.pl instead to throw a warning

> On Fri, 2023-07-14 at 14:58 +0800, huzhi001@208suo.com wrote:
> > Signed-off-by: ZhiHu <huzhi001@208suo.com>
> > ---
> >   .../gpu/drm/nouveau/nvkm/engine/fifo/gk104.c  | 40 ++++++++++++++----=
-
> >   1 file changed, 29 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
> > b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
> > index d8a4d773a58c..b99e0a7c96bb 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
> > @@ -137,15 +137,29 @@ gk104_ectx_bind(struct nvkm_engn *engn, struct
> > nvkm_cctx *cctx, struct nvkm_chan
> >       u64 addr =3D 0ULL;
> >
> >       switch (engn->engine->subdev.type) {
> > -    case NVKM_ENGINE_SW    : return;
> > -    case NVKM_ENGINE_GR    : ptr0 =3D 0x0210; break;
> > -    case NVKM_ENGINE_SEC   : ptr0 =3D 0x0220; break;
> > -    case NVKM_ENGINE_MSPDEC: ptr0 =3D 0x0250; break;
> > -    case NVKM_ENGINE_MSPPP : ptr0 =3D 0x0260; break;
> > -    case NVKM_ENGINE_MSVLD : ptr0 =3D 0x0270; break;
> > -    case NVKM_ENGINE_VIC   : ptr0 =3D 0x0280; break;
> > -    case NVKM_ENGINE_MSENC : ptr0 =3D 0x0290; break;
> > -    case NVKM_ENGINE_NVDEC :
> > +    case NVKM_ENGINE_SW:
> > +        return;
> > +    case NVKM_ENGINE_GR:
> > +        ptr0 =3D 0x0210;
> > +        break;
> > +    case NVKM_ENGINE_SEC:
> > +        ptr0 =3D 0x0220;
> > +        break;
> > +    case NVKM_ENGINE_MSPDEC:
> > +        ptr0 =3D 0x0250;
> > +        break;
> > +    case NVKM_ENGINE_MSPPP:
> > +        ptr0 =3D 0x0260;
> > +        break;
> > +    case NVKM_ENGINE_MSVLD:
> > +        ptr0 =3D 0x0270;
> > +        break;
> > +    case NVKM_ENGINE_VIC:
> > +        ptr0 =3D 0x0280; break;
> > +    case NVKM_ENGINE_MSENC:
> > +        ptr0 =3D 0x0290;
> > +        break;
> > +    case NVKM_ENGINE_NVDEC:
> >           ptr1 =3D 0x0270;
> >           ptr0 =3D 0x0210;
> >           break;
> > @@ -435,8 +449,12 @@ gk104_runl_commit(struct nvkm_runl *runl, struct
> > nvkm_memory *memory, u32 start,
> >       int target;
> >
> >       switch (nvkm_memory_target(memory)) {
> > -    case NVKM_MEM_TARGET_VRAM: target =3D 0; break;
> > -    case NVKM_MEM_TARGET_NCOH: target =3D 3; break;
> > +    case NVKM_MEM_TARGET_VRAM:
> > +        target =3D 0;
> > +        break;
> > +    case NVKM_MEM_TARGET_NCOH:
> > +        target =3D 3;
> > +        break;
>
> This one isn't very long, but I'd still say it's definitely a lot easier =
to
> read in the compact form. If anything, the only change I would make here =
is
> formatting the default: case to be on a single line as well
>
> >       default:
> >           WARN_ON(1);
> >           return;
>
> --
> Cheers,
>  Lyude Paul (she/her)
>  Software Engineer at Red Hat
>

