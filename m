Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7110E76063A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 05:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjGYDEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 23:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjGYDEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 23:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591E2E71
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 20:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690254207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAc0MlqPg/yL4r1FDNENXbaZwCfWYWLTGb4LIsDUBas=;
        b=XKFQzaEbaLNs3+woVb6rIjwQTKbe2Rd7wa3ldLcDlrUnGAF5FhoZLR724MfOkc0ccSEmB7
        Kx3MYB2FOvveOU+ynWAbQWUOXF5Fa5XuxgBzDTAICmoy/gdGNFPlZIYuidvOlSXTWXleV0
        UrocN1ruE4fRcmxfQKZgAfK/EQFzzj4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-jRZBovpuOG6CAkZb_iKyKg-1; Mon, 24 Jul 2023 23:03:24 -0400
X-MC-Unique: jRZBovpuOG6CAkZb_iKyKg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b93f4c300bso42453491fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 20:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690254203; x=1690859003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAc0MlqPg/yL4r1FDNENXbaZwCfWYWLTGb4LIsDUBas=;
        b=CJxYiCmGV5n5vgHXBrij0yMoa1xk0nu1hE2A0+YOfS8H7PtzLMKxIJYyzPOOSJCGRj
         vtmFMY+gx9Vz2xg+h3hc4NUuinGIytLBk23pfIaXFNlgTgn05T/UOVaxR+xakPlwer3K
         xdidfIzgAXhdjt2adlmMFJ4necSuDe47jMIt42Bim/Af1U4e8QIC92ak2fwQMZ0lzFpc
         jycs/ToQf5FbaQwpOTMlqRH9vgGpNQyse8UKBWbefim+UEXpukRwT9PYXQqzkl7B1WRF
         cPhHeMPYxn7AfMJScwTRZ3YY6SgFUlCfvI6wcEH3sQUQqf5mvNckLyrpwu6jFAHEMbl3
         FN5A==
X-Gm-Message-State: ABy/qLbwgglhThZOZNkKyB/0itKuU+IPY8sDsfDG6b4I5Oshz7zhApo2
        YCBNGnYWkxjI+PmUWxsWsjH7Tq1fpnNRmLmj901kD0II+uuDvN0NQ2cnB5mNwiKv4YM7xhyG7m1
        KoygtjziQ/QRZ5Y1b3MXiKTUAYjPpf6W1w5wp5Y0G
X-Received: by 2002:a2e:a0cc:0:b0:2b9:20fe:4bc4 with SMTP id f12-20020a2ea0cc000000b002b920fe4bc4mr6683070ljm.40.1690254203108;
        Mon, 24 Jul 2023 20:03:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE2j04T9RgeFTKLtV6SB4LuID/VCavX2D/V3hGGpp+Qu72PpJU772k7drhxfEdLsbZ5aZyxH2EWCIDc9aGdJHo=
X-Received: by 2002:a2e:a0cc:0:b0:2b9:20fe:4bc4 with SMTP id
 f12-20020a2ea0cc000000b002b920fe4bc4mr6683061ljm.40.1690254202767; Mon, 24
 Jul 2023 20:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230720083839.481487-3-jasowang@redhat.com> <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org> <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org> <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org> <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <20230723053441-mutt-send-email-mst@kernel.org> <CACGkMEuPcOyjgHkKXrcnofdb5XhYYTrGQeuR3j6Oypr0KZxLMg@mail.gmail.com>
 <20230724031732-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230724031732-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 25 Jul 2023 11:03:11 +0800
Message-ID: <CACGkMEvNqJvLvVqQyrw-5jLDA2RvWkSPfb_RLVZbe_wsM=AK4g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 3:18=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jul 24, 2023 at 02:52:49PM +0800, Jason Wang wrote:
> > On Mon, Jul 24, 2023 at 2:46=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Fri, Jul 21, 2023 at 10:18:03PM +0200, Maxime Coquelin wrote:
> > > >
> > > >
> > > > On 7/21/23 17:10, Michael S. Tsirkin wrote:
> > > > > On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wrote:
> > > > > >
> > > > > >
> > > > > > On 7/21/23 16:45, Michael S. Tsirkin wrote:
> > > > > > > On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wro=
te:
> > > > > > > >
> > > > > > > >
> > > > > > > > On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > > > > > > > > On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson =
wrote:
> > > > > > > > > > On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > > > > > > > >
> > > > > > > > > > > Adding cond_resched() to the command waiting loop for=
 a better
> > > > > > > > > > > co-operation with the scheduler. This allows to give =
CPU a breath to
> > > > > > > > > > > run other task(workqueue) instead of busy looping whe=
n preemption is
> > > > > > > > > > > not allowed on a device whose CVQ might be slow.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > >
> > > > > > > > > > This still leaves hung processes, but at least it doesn=
't pin the CPU any
> > > > > > > > > > more.  Thanks.
> > > > > > > > > > Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I'd like to see a full solution
> > > > > > > > > 1- block until interrupt
> > > > > > > >
> > > > > > > > Would it make sense to also have a timeout?
> > > > > > > > And when timeout expires, set FAILED bit in device status?
> > > > > > >
> > > > > > > virtio spec does not set any limits on the timing of vq
> > > > > > > processing.
> > > > > >
> > > > > > Indeed, but I thought the driver could decide it is too long fo=
r it.
> > > > > >
> > > > > > The issue is we keep waiting with rtnl locked, it can quickly m=
ake the
> > > > > > system unusable.
> > > > >
> > > > > if this is a problem we should find a way not to keep rtnl
> > > > > locked indefinitely.
> > > >
> > > > From the tests I have done, I think it is. With OVS, a reconfigurat=
ion is
> > > > performed when the VDUSE device is added, and when a MLX5 device is
> > > > in the same bridge, it ends up doing an ioctl() that tries to take =
the
> > > > rtnl lock. In this configuration, it is not possible to kill OVS be=
cause
> > > > it is stuck trying to acquire rtnl lock for mlx5 that is held by vi=
rtio-
> > > > net.
> > >
> > > So for sure, we can queue up the work and process it later.
> > > The somewhat tricky part is limiting the memory consumption.
> >
> > And it needs to sync with rtnl somehow, e.g device unregistering which
> > seems not easy.
> >
> > Thanks
>
> since when does device unregister need to send cvq commands?

It doesn't do this now. But if we don't process the work under rtnl,
we need to synchronize with device unregistering.

Thanks

>
> > >
> > >
> > > > >
> > > > > > > > > 2- still handle surprise removal correctly by waking in t=
hat case
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > > ---
> > > > > > > > > > >      drivers/net/virtio_net.c | 4 +++-
> > > > > > > > > > >      1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/v=
irtio_net.c
> > > > > > > > > > > index 9f3b1d6ac33d..e7533f29b219 100644
> > > > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > > > @@ -2314,8 +2314,10 @@ static bool virtnet_send_comma=
nd(struct virtnet_info *vi, u8 class, u8 cmd,
> > > > > > > > > > >              * into the hypervisor, so the request sh=
ould be handled immediately.
> > > > > > > > > > >              */
> > > > > > > > > > >             while (!virtqueue_get_buf(vi->cvq, &tmp) =
&&
> > > > > > > > > > > -              !virtqueue_is_broken(vi->cvq))
> > > > > > > > > > > +              !virtqueue_is_broken(vi->cvq)) {
> > > > > > > > > > > +               cond_resched();
> > > > > > > > > > >                     cpu_relax();
> > > > > > > > > > > +       }
> > > > > > > > > > >
> > > > > > > > > > >             return vi->ctrl->status =3D=3D VIRTIO_NET=
_OK;
> > > > > > > > > > >      }
> > > > > > > > > > > --
> > > > > > > > > > > 2.39.3
> > > > > > > > > > >
> > > > > > > > > > > _______________________________________________
> > > > > > > > > > > Virtualization mailing list
> > > > > > > > > > > Virtualization@lists.linux-foundation.org
> > > > > > > > > > > https://lists.linuxfoundation.org/mailman/listinfo/vi=
rtualization
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>

