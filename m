Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6547E75EC09
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjGXGyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGXGyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DC3E55
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690181583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pKG/QpR2RzRLFZUHbEZEOsoTAlRHGNWkIflkbnf814=;
        b=FBDoHLF90gR6yzb5LXKlLXj8JE/FjdLWSpHffYJDkw5PZYFhVvEU9qf6Oyq1IWQnVg599t
        LbN1zyRxp2ZY/aDkJAr5jwMU20VCe0nnDZZsYwzJ1a9LKQI5mafWBT0sVPDThMd8BzY+np
        OihEAwzfVrpsweAscNrCmjmEPcccXyQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-cdgTaQJcMYeWX2M-5C6zDg-1; Mon, 24 Jul 2023 02:53:02 -0400
X-MC-Unique: cdgTaQJcMYeWX2M-5C6zDg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b6f97c9d54so34091061fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690181580; x=1690786380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pKG/QpR2RzRLFZUHbEZEOsoTAlRHGNWkIflkbnf814=;
        b=lYssCbgWNVP1MZVcQ8197elmx2y9Gh+HutXy/A9VYoghblNcm+/UnsG01AQV5QylY0
         svLq+cCndm6lsunx/zkSFi9tNjw5KQ6Y2/LWeBIkczl1Av2HIWgU9bTDaDsjJTaFaNvl
         lWAhyuUbSEMuVNBO+bfP7D+xifyWtbgglNz69RIkK2dgcy1d1UNNJZ3r4S1JVb95cxir
         a/ZalIU+32gnyYwx7AA57j0/UNwbuQfnQgSdW1+ggcBBdT8PwE9AjC/0WN/BEz+rID4q
         hAEzb2ucvvirhmi7iVnGWqy5FUfNJbPqisLGLtx3RA2NEFErMeTHa0io6AwrKwGC2K6D
         9i7g==
X-Gm-Message-State: ABy/qLYfornGcecb/v5j1WoIveQ+wkpYgbxhx/cHf+hTqAd6B+f72HO5
        RBvEdpC9p+ygOmE/8S6OL/x70HhHL6qFGaBGfXqOEzXOMrDJ5g6LAZL4xKr6j1GhUe6kZM/S9+g
        40KW/6gheyCVrrLmCmtWNtiPYbZ9bP83zs3J6xFvs
X-Received: by 2002:a05:651c:205:b0:2b5:9f54:e290 with SMTP id y5-20020a05651c020500b002b59f54e290mr4905530ljn.0.1690181580678;
        Sun, 23 Jul 2023 23:53:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGAmLS3rinVGsLd7AiJM7P6pJi3Om6DIylJcrxKdBPPEYm9eGwGfcqzWBBrKCtsdHC9O5nMYXmIxWSEsqiejcM=
X-Received: by 2002:a05:651c:205:b0:2b5:9f54:e290 with SMTP id
 y5-20020a05651c020500b002b59f54e290mr4905511ljn.0.1690181580374; Sun, 23 Jul
 2023 23:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230720083839.481487-1-jasowang@redhat.com> <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com> <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com> <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com> <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com> <20230723053441-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230723053441-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 24 Jul 2023 14:52:49 +0800
Message-ID: <CACGkMEuPcOyjgHkKXrcnofdb5XhYYTrGQeuR3j6Oypr0KZxLMg@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 2:46=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jul 21, 2023 at 10:18:03PM +0200, Maxime Coquelin wrote:
> >
> >
> > On 7/21/23 17:10, Michael S. Tsirkin wrote:
> > > On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wrote:
> > > >
> > > >
> > > > On 7/21/23 16:45, Michael S. Tsirkin wrote:
> > > > > On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
> > > > > >
> > > > > >
> > > > > > On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > > > > > > On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrot=
e:
> > > > > > > > On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > > > > > >
> > > > > > > > > Adding cond_resched() to the command waiting loop for a b=
etter
> > > > > > > > > co-operation with the scheduler. This allows to give CPU =
a breath to
> > > > > > > > > run other task(workqueue) instead of busy looping when pr=
eemption is
> > > > > > > > > not allowed on a device whose CVQ might be slow.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > >
> > > > > > > > This still leaves hung processes, but at least it doesn't p=
in the CPU any
> > > > > > > > more.  Thanks.
> > > > > > > > Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > > > > > > >
> > > > > > >
> > > > > > > I'd like to see a full solution
> > > > > > > 1- block until interrupt
> > > > > >
> > > > > > Would it make sense to also have a timeout?
> > > > > > And when timeout expires, set FAILED bit in device status?
> > > > >
> > > > > virtio spec does not set any limits on the timing of vq
> > > > > processing.
> > > >
> > > > Indeed, but I thought the driver could decide it is too long for it=
.
> > > >
> > > > The issue is we keep waiting with rtnl locked, it can quickly make =
the
> > > > system unusable.
> > >
> > > if this is a problem we should find a way not to keep rtnl
> > > locked indefinitely.
> >
> > From the tests I have done, I think it is. With OVS, a reconfiguration =
is
> > performed when the VDUSE device is added, and when a MLX5 device is
> > in the same bridge, it ends up doing an ioctl() that tries to take the
> > rtnl lock. In this configuration, it is not possible to kill OVS becaus=
e
> > it is stuck trying to acquire rtnl lock for mlx5 that is held by virtio=
-
> > net.
>
> So for sure, we can queue up the work and process it later.
> The somewhat tricky part is limiting the memory consumption.

And it needs to sync with rtnl somehow, e.g device unregistering which
seems not easy.

Thanks

>
>
> > >
> > > > > > > 2- still handle surprise removal correctly by waking in that =
case
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > > ---
> > > > > > > > >      drivers/net/virtio_net.c | 4 +++-
> > > > > > > > >      1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virti=
o_net.c
> > > > > > > > > index 9f3b1d6ac33d..e7533f29b219 100644
> > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(s=
truct virtnet_info *vi, u8 class, u8 cmd,
> > > > > > > > >              * into the hypervisor, so the request should=
 be handled immediately.
> > > > > > > > >              */
> > > > > > > > >             while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > > > > > -              !virtqueue_is_broken(vi->cvq))
> > > > > > > > > +              !virtqueue_is_broken(vi->cvq)) {
> > > > > > > > > +               cond_resched();
> > > > > > > > >                     cpu_relax();
> > > > > > > > > +       }
> > > > > > > > >
> > > > > > > > >             return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> > > > > > > > >      }
> > > > > > > > > --
> > > > > > > > > 2.39.3
> > > > > > > > >
> > > > > > > > > _______________________________________________
> > > > > > > > > Virtualization mailing list
> > > > > > > > > Virtualization@lists.linux-foundation.org
> > > > > > > > > https://lists.linuxfoundation.org/mailman/listinfo/virtua=
lization
> > > > > > >
> > > > >
> > >
>

