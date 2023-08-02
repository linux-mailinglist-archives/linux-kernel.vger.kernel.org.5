Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC7576C17F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 02:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjHBAa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 20:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjHBAay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 20:30:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAF42706
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 17:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690936203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JEPRqnrXwb3l4TJ06XhQbxlgbhupJt14UvT9sNXZCIE=;
        b=SJojtvUpuK3zEHWkCafvPFBOhKxI49gjWAlPSa78pnEFqYVUesd4IrVxkv7NWoxw4rILWI
        Sz5uQovGomt/ttb0+V1GRYDk8fl+68hSmOel0WHGoeuSqw/eo3wTewyDmHo12k3VX3Svyp
        81XVb/KnJ2uWkda38OmOBkSsxvOgzOU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-s3zyhh1bMPOj_4KmcRUHOQ-1; Tue, 01 Aug 2023 20:30:01 -0400
X-MC-Unique: s3zyhh1bMPOj_4KmcRUHOQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a355c9028so396471766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 17:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690936200; x=1691541000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEPRqnrXwb3l4TJ06XhQbxlgbhupJt14UvT9sNXZCIE=;
        b=Wo9kFhpqpTzK6IQ+juTjyYeuJaDcbivhge1l6gCrCau9KDVABi/tSi6f464F7qkA6Q
         jMN7LITk5feOSInNf3/B/Kge0MsCzfMETfUe6GlHoRrnFLgbwVFQclwTdvCDtHlzpG1/
         WvdiYGonOw6WsK6m9+3J+1+EpK0e445FOGDo0FXDgZV1XYaYbZT0OqkVLmEP/bBmJaE9
         Yj2yGbXxqLn5/6opRkApKVVsOtGJnRUDUHhme771kb7tYcRG1N/T239NogKbGFUvgwI6
         2oB8JGQ3So6RGwOl/of9eSToLRhqeBNI/asW6kKXKW5g+sFkiKsmDAcqN1mXPWAn+JyK
         DD6A==
X-Gm-Message-State: ABy/qLY3WhhCoKaBrQ6nDbyk/6T5/FafWRGA2lfd8/uQmoq9WPGGRbSm
        sUCJK74JRo9Gk9usuh1KkVKncnLCcKv2p7/vFtnp83reTwPUoMhoLYe36bR8sJprMCSdta5vYqG
        JbFNL03tuE1tYdu/w8wyIaQgx7b1YrvFiGD6nGHwt
X-Received: by 2002:aa7:c70c:0:b0:522:1d1d:1de8 with SMTP id i12-20020aa7c70c000000b005221d1d1de8mr3286011edq.2.1690936200508;
        Tue, 01 Aug 2023 17:30:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFx1QEk6Wt7mgwZeLoPkC/v2tLO3nowSJ6Fb0/AI9een9o9+8vvJclanIeNS83Ib46bpT27AuIhKC9/5Sur9Hs=
X-Received: by 2002:aa7:c70c:0:b0:522:1d1d:1de8 with SMTP id
 i12-20020aa7c70c000000b005221d1d1de8mr3286001edq.2.1690936200208; Tue, 01 Aug
 2023 17:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230727172354.68243-2-dtatulea@nvidia.com> <CACGkMEt5+O1Q1=SvPpD5kwhEnoLNva73Uew0vaWBVXW3xE-o0Q@mail.gmail.com>
In-Reply-To: <CACGkMEt5+O1Q1=SvPpD5kwhEnoLNva73Uew0vaWBVXW3xE-o0Q@mail.gmail.com>
From:   Lei Yang <leiyang@redhat.com>
Date:   Wed, 2 Aug 2023 08:29:23 +0800
Message-ID: <CAPpAL=yA-H8OXSz0XmVNff7isCS9Zq8UiH9L+zq6B27aOJrrZg@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Correct default number of queues when MQ is on
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>
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

QE performed sanity testing on this patch using a real nic's
vhost_vdpa device with multi queues, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>




On Fri, Jul 28, 2023 at 9:42=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Jul 28, 2023 at 1:25=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.c=
om> wrote:
> >
> > The standard specifies that the initial number of queues is the
> > default, which is 1 (1 tx, 1 rx).
> >
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index 9138ef2fb2c8..6b6eb69a8a90 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -2517,7 +2517,15 @@ static int mlx5_vdpa_set_driver_features(struct =
vdpa_device *vdev, u64 features)
> >         else
> >                 ndev->rqt_size =3D 1;
> >
> > -       ndev->cur_num_vqs =3D 2 * ndev->rqt_size;
> > +       /* Device must start with 1 queue pair, as per VIRTIO v1.2 spec=
, section
> > +        * 5.1.6.5.5 "Device operation in multiqueue mode":
> > +        *
> > +        * Multiqueue is disabled by default.
> > +        * The driver enables multiqueue by sending a command using cla=
ss
> > +        * VIRTIO_NET_CTRL_MQ. The command selects the mode of multique=
ue
> > +        * operation, as follows: ...
> > +        */
> > +       ndev->cur_num_vqs =3D 2;
> >
> >         update_cvq_info(mvdev);
> >         return err;
> > --
> > 2.41.0
> >
>

