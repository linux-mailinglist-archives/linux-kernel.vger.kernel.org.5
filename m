Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF23760658
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 05:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjGYDIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 23:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGYDIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 23:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A98E76
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 20:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690254475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VsrFcx7CKuChRWMATh1+NSjWHNvI5lnlCZ+wKzBTyhE=;
        b=BnKozPRiTrK8Bllwqg+dlerJSSnRz5wyizWdq7HCGuZl3SeFyu/JCB2JyPSZ1k0lzptyNy
        eKT5mrnA09nPz8m9C2ylh92q9D8hEPcOmU8U58iM5ExtJQ4AwsywZrWFt600KB+h/xIRVt
        Ub9zrgdmpr5r8Do7IuRy3sB4hWVCYkg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-bX7Z1jCTMnKAhbXTfRkn2A-1; Mon, 24 Jul 2023 23:07:53 -0400
X-MC-Unique: bX7Z1jCTMnKAhbXTfRkn2A-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b6f0527454so41146301fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 20:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690254472; x=1690859272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsrFcx7CKuChRWMATh1+NSjWHNvI5lnlCZ+wKzBTyhE=;
        b=ewjN2B5Gv8Xs1oHxVsKboYkE8d6az9Y+gnprvrL7Qr1Lv+ji7C/y5pkZfOzP4EAhHU
         ZXraXRxoglYofr+7h1HZS3JZGlMUsb+Em8hc5l9iFnwmynQc6i3Kcd0bo8ODVcgcTJem
         Sb70AzSbhEqCmZmVwxyDQTMbvflUSDx+S78qgw5HUnyOqzppxGybuKWoCo0KXbSbAbfe
         0g1ZmZGJu2r9DfE7UNujz26cvD4CmFCXP08OGv9LT6rHzYVuV2hm7LW6wEDKw6hWIFnD
         yuCOJxma1tYZ84l7WjKU36NYl8NOuCI34Z1azOKKn2lgKPBwd9Gw5rLm6u67l0GcIQkO
         3PdQ==
X-Gm-Message-State: ABy/qLYW902/n+iawYmMImO6Q6fiOP/53kvkA0pj8tdyWz6cjt+kISvj
        cWuuoVEVGrSP4okEI5UqSscvPOvWalFaPM45SGMTgCSugCBmzPtjYEzIgf+K2iUrTyKMHovfEdv
        uqNKyBMTJDqXypruXY07L+pFu8yASrPCuAfFkYqQS
X-Received: by 2002:a2e:92d0:0:b0:2b4:65bf:d7b with SMTP id k16-20020a2e92d0000000b002b465bf0d7bmr6750639ljh.2.1690254471983;
        Mon, 24 Jul 2023 20:07:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFldEasInu8/EU/4WmFQMOs6DD/Y7YsaR0vjQ1PPmGDpzLFjM8Ou0Nzwjk+3kPaljEexhz/8vzlaUYQeVLu7N4=
X-Received: by 2002:a2e:92d0:0:b0:2b4:65bf:d7b with SMTP id
 k16-20020a2e92d0000000b002b465bf0d7bmr6750625ljh.2.1690254471671; Mon, 24 Jul
 2023 20:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230720083839.481487-1-jasowang@redhat.com> <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com> <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com> <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com> <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com> <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230724025720-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 25 Jul 2023 11:07:40 +0800
Message-ID: <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
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

On Mon, Jul 24, 2023 at 3:17=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jul 24, 2023 at 02:52:05PM +0800, Jason Wang wrote:
> > On Sat, Jul 22, 2023 at 4:18=E2=80=AFAM Maxime Coquelin
> > <maxime.coquelin@redhat.com> wrote:
> > >
> > >
> > >
> > > On 7/21/23 17:10, Michael S. Tsirkin wrote:
> > > > On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wrote:
> > > >>
> > > >>
> > > >> On 7/21/23 16:45, Michael S. Tsirkin wrote:
> > > >>> On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
> > > >>>>
> > > >>>>
> > > >>>> On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > > >>>>> On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
> > > >>>>>> On 7/20/23 1:38 AM, Jason Wang wrote:
> > > >>>>>>>
> > > >>>>>>> Adding cond_resched() to the command waiting loop for a bette=
r
> > > >>>>>>> co-operation with the scheduler. This allows to give CPU a br=
eath to
> > > >>>>>>> run other task(workqueue) instead of busy looping when preemp=
tion is
> > > >>>>>>> not allowed on a device whose CVQ might be slow.
> > > >>>>>>>
> > > >>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > >>>>>>
> > > >>>>>> This still leaves hung processes, but at least it doesn't pin =
the CPU any
> > > >>>>>> more.  Thanks.
> > > >>>>>> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > > >>>>>>
> > > >>>>>
> > > >>>>> I'd like to see a full solution
> > > >>>>> 1- block until interrupt
> >
> > I remember in previous versions, you worried about the extra MSI
> > vector. (Maybe I was wrong).
> >
> > > >>>>
> > > >>>> Would it make sense to also have a timeout?
> > > >>>> And when timeout expires, set FAILED bit in device status?
> > > >>>
> > > >>> virtio spec does not set any limits on the timing of vq
> > > >>> processing.
> > > >>
> > > >> Indeed, but I thought the driver could decide it is too long for i=
t.
> > > >>
> > > >> The issue is we keep waiting with rtnl locked, it can quickly make=
 the
> > > >> system unusable.
> > > >
> > > > if this is a problem we should find a way not to keep rtnl
> > > > locked indefinitely.
> >
> > Any ideas on this direction? Simply dropping rtnl during the busy loop
> > will result in a lot of races. This seems to require non-trivial
> > changes in the networking core.
> >
> > >
> > >  From the tests I have done, I think it is. With OVS, a reconfigurati=
on
> > > is performed when the VDUSE device is added, and when a MLX5 device i=
s
> > > in the same bridge, it ends up doing an ioctl() that tries to take th=
e
> > > rtnl lock. In this configuration, it is not possible to kill OVS beca=
use
> > > it is stuck trying to acquire rtnl lock for mlx5 that is held by virt=
io-
> > > net.
> >
> > Yeah, basically, any RTNL users would be blocked forever.
> >
> > And the infinite loop has other side effects like it blocks the freezer=
 to work.
> >
> > To summarize, there are three issues
> >
> > 1) busy polling
> > 2) breaks freezer
> > 3) hold RTNL during the loop
> >
> > Solving 3 may help somehow for 2 e.g some pm routine e.g wireguard or
> > even virtnet_restore() itself may try to hold the lock.
>
> Yep. So my feeling currently is, the only real fix is to actually
> queue up the work in software.

Do you mean something like:

rtnl_lock();
queue up the work
rtnl_unlock();
return success;

?

> It's mostly trivial to limit
> memory consumption, vid's is the
> only one where it would make sense to have more than
> 1 command of a given type outstanding.

And rx mode so this implies we will fail any command if the previous
work is not finished.

> have a tree
> or a bitmap with vids to add/remove?

Probably.

Thanks

>
>
>
> > >
> > > >
> > > >>>>> 2- still handle surprise removal correctly by waking in that ca=
se
> >
> > This is basically what version 1 did?
> >
> > https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redha=
t.com/t/
> >
> > Thanks
>
> Yes - except the timeout part.
>
>
> > > >>>>>
> > > >>>>>
> > > >>>>>
> > > >>>>>>> ---
> > > >>>>>>>      drivers/net/virtio_net.c | 4 +++-
> > > >>>>>>>      1 file changed, 3 insertions(+), 1 deletion(-)
> > > >>>>>>>
> > > >>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_ne=
t.c
> > > >>>>>>> index 9f3b1d6ac33d..e7533f29b219 100644
> > > >>>>>>> --- a/drivers/net/virtio_net.c
> > > >>>>>>> +++ b/drivers/net/virtio_net.c
> > > >>>>>>> @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struc=
t virtnet_info *vi, u8 class, u8 cmd,
> > > >>>>>>>              * into the hypervisor, so the request should be =
handled immediately.
> > > >>>>>>>              */
> > > >>>>>>>             while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > >>>>>>> -              !virtqueue_is_broken(vi->cvq))
> > > >>>>>>> +              !virtqueue_is_broken(vi->cvq)) {
> > > >>>>>>> +               cond_resched();
> > > >>>>>>>                     cpu_relax();
> > > >>>>>>> +       }
> > > >>>>>>>
> > > >>>>>>>             return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> > > >>>>>>>      }
> > > >>>>>>> --
> > > >>>>>>> 2.39.3
> > > >>>>>>>
> > > >>>>>>> _______________________________________________
> > > >>>>>>> Virtualization mailing list
> > > >>>>>>> Virtualization@lists.linux-foundation.org
> > > >>>>>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualiza=
tion
> > > >>>>>
> > > >>>
> > > >
> > >
>

