Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D5D7DDA3C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376958AbjKAAhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbjKAAhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C931BED
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 17:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698798978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C+GS7S1zs+RWJZ2acWzMVg8OF7MBFMELnGIFo6WBEv4=;
        b=ObSwoSiQf4jlFNWVIHbm31Tm+L66Tm1BHZ5IOQGBD0znkrfl6M332bAkVZl/5wvLvN3e+p
        7fKFIYouGXfW2E9JnqdVc6aE3my2J0B943wlTk3j/UhEC1rEEO0Ze3iPSA205F4SsxiwUz
        sHKAOOoqfvgpy8P18ELOZ7Xhh2ZF5qU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-xgIu9efTO4GGLwv-3ucOtQ-1; Tue, 31 Oct 2023 20:35:56 -0400
X-MC-Unique: xgIu9efTO4GGLwv-3ucOtQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507d4583c4cso7059661e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 17:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698798954; x=1699403754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+GS7S1zs+RWJZ2acWzMVg8OF7MBFMELnGIFo6WBEv4=;
        b=wB7zKytoPrORWxc0Tmv5tejFmbQVncJoxm+WthvFAfVBKjhUzpt4wsfwO4SR+7wQ+w
         0KeCpvZAL47kpCo28qGnZleaJFzeydJAon5wlea3vMwOVVI8+xZOQUnb2tZCW/Mlj3WT
         N3JAy5d3knIMPjoLkDAySdmnL/ucTXt2uJroSZkE6Vz0mCpcMCZGKG6HZOVS3mAtQPvD
         qJkxjzKc9t39Wt/fbjMzdrA3Y22/qagw6hDqj/PqI41/6BAi9lDBHblWByKoBsj6Tx+2
         Ku5cfmjlcnQyuxOfRHaRNjEKvefXIhFafLPAIT9BtPdcCV1fQiBxNox82eyXa2/0zp89
         7tNw==
X-Gm-Message-State: AOJu0YyMOzH9M97oeNMbeV6T1crMcqWkmJkVHrVF7JFxhucKWK6SX83x
        YOXCzaY1YuZzJ6nLZzJ2cyCxkYaYZi1kRMylHv/8opPCsWxP1KCkxwdS0wPVW5vR4NXcpkW/N8P
        +qRZcHxCQkpiGlysBFahJT0pl0otEezP4CEcAO8hUdJ3gAKlaxqo=
X-Received: by 2002:a05:6512:2396:b0:503:343a:829f with SMTP id c22-20020a056512239600b00503343a829fmr14598979lfv.23.1698798954040;
        Tue, 31 Oct 2023 17:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg+1pMD7BGHcsWb0wYXFGaP9FuBcGzatueA1YF+p9rYE0YMGk4z2qP+9HpSwembnuzfBCTmKuQjRRFMXs3AHM=
X-Received: by 2002:a05:6512:2396:b0:503:343a:829f with SMTP id
 c22-20020a056512239600b00503343a829fmr14598971lfv.23.1698798953743; Tue, 31
 Oct 2023 17:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231031144339.121453-1-sgarzare@redhat.com> <CAJaqyWfr123zWdM8E+H4bnfrdvv-KEvZ7r5eN+fY428G6v95Hg@mail.gmail.com>
In-Reply-To: <CAJaqyWfr123zWdM8E+H4bnfrdvv-KEvZ7r5eN+fY428G6v95Hg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 1 Nov 2023 08:35:42 +0800
Message-ID: <CACGkMEvRCdCT4A5r9up0U+Pj5m44f5V2Fw_dcPJvnJk7NBtrLQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: allocate the buffer zeroed
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Qing Wang <qinwang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 1, 2023 at 1:52=E2=80=AFAM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Tue, Oct 31, 2023 at 3:44=E2=80=AFPM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >
> > Deleting and recreating a device can lead to having the same
> > content as the old device, so let's always allocate buffers
> > completely zeroed out.
> >
> > Fixes: abebb16254b3 ("vdpa_sim_blk: support shared backend")
> > Suggested-by: Qing Wang <qinwang@redhat.com>
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_s=
im/vdpa_sim_blk.c
> > index b3a3cb165795..b137f3679343 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > @@ -437,7 +437,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev=
 *mdev, const char *name,
> >         if (blk->shared_backend) {
> >                 blk->buffer =3D shared_buffer;
> >         } else {
> > -               blk->buffer =3D kvmalloc(VDPASIM_BLK_CAPACITY << SECTOR=
_SHIFT,
> > +               blk->buffer =3D kvzalloc(VDPASIM_BLK_CAPACITY << SECTOR=
_SHIFT,
> >                                        GFP_KERNEL);
> >                 if (!blk->buffer) {
> >                         ret =3D -ENOMEM;
> > @@ -495,7 +495,7 @@ static int __init vdpasim_blk_init(void)
> >                 goto parent_err;
> >
> >         if (shared_backend) {
> > -               shared_buffer =3D kvmalloc(VDPASIM_BLK_CAPACITY << SECT=
OR_SHIFT,
> > +               shared_buffer =3D kvzalloc(VDPASIM_BLK_CAPACITY << SECT=
OR_SHIFT,
> >                                          GFP_KERNEL);
> >                 if (!shared_buffer) {
> >                         ret =3D -ENOMEM;
> > --
> > 2.41.0
> >
>

