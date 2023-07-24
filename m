Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7356B75EC06
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjGXGxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGXGxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:53:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B46E74
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690181539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Eib/snGZK+J1TMIQVgytcC6Q8KrElag1cRiuwxI9z0=;
        b=aHydBLBk3vybP6fJfHosAJC7B2W0UZjBsHEJIXmplT0jn4j5hf5zqW8e953Y5CUeKof8Fg
        526AtRXn/EGUT+XoBx+HH6F7dwK5m7VD4ydXHH8tMan/R5Rom8oEh8gZpP1zXMwG6h5uvr
        96o7H6W5ftfuJKPUPlWni25v2IzNc9Y=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-GruqDLMePj6EpsXV8EKkXA-1; Mon, 24 Jul 2023 02:52:18 -0400
X-MC-Unique: GruqDLMePj6EpsXV8EKkXA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b980182002so10761421fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690181536; x=1690786336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Eib/snGZK+J1TMIQVgytcC6Q8KrElag1cRiuwxI9z0=;
        b=VmzgkVQWb/m6C9WXKZ7QZFmhkqSiea2aWSQQakBmYlVoJVLm1Q5Il0T/4AIZvtMPyg
         /QAJ92hWmaaQf+a0+eVAqtzCdjq9UeY+iefa16oMm+Up06UctGWRhUFyvx+EMaxNzU7K
         iNMJXesOkCitw+HR6g1Lh16feVej7/ChlHpPIoteRv6YWiwIXLVCS6oAuRdiS+9hy3Mp
         v0iyFyhdu9fkXgKXbvlJV+JY15rNOlfALWoGpw01UJVeS0a2MhjfLoos0XSqAASyKNhS
         Sp7M78hLOv8GucwqUdrg1RaRSUnZzyCs1z10QgvDIeYaUAgPXlSSfu+JMe7s4ZWyL0Zp
         b8JA==
X-Gm-Message-State: ABy/qLbhIlkSZ5lGiyLBoweM4vI2Vy+ESUDn839z8ufExaVmRDr1aJlf
        CBmqZC8L5RkPxb8Ywf/CxgYVe59iTLhL7tooX+aZGiNqacDrMTJ1OLb5gKorTJN0IvSqyjyoObo
        X/ovltlp+h3HPTamQG36PrksInwHYx11xO21mjwSW
X-Received: by 2002:a05:6512:31d5:b0:4f8:75d5:e14f with SMTP id j21-20020a05651231d500b004f875d5e14fmr4458705lfe.28.1690181536587;
        Sun, 23 Jul 2023 23:52:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHDHx3flX3L5UV3ZIswai/MSqeClmvnFN71NppKSREFI3wWmLRUTGY01mBOLnmYfijXmI8rLbTx4htqybF7Zqw=
X-Received: by 2002:a05:6512:31d5:b0:4f8:75d5:e14f with SMTP id
 j21-20020a05651231d500b004f875d5e14fmr4458700lfe.28.1690181536270; Sun, 23
 Jul 2023 23:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230720083839.481487-1-jasowang@redhat.com> <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com> <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com> <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com> <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
In-Reply-To: <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 24 Jul 2023 14:52:05 +0800
Message-ID: <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 4:18=E2=80=AFAM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
>
> On 7/21/23 17:10, Michael S. Tsirkin wrote:
> > On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wrote:
> >>
> >>
> >> On 7/21/23 16:45, Michael S. Tsirkin wrote:
> >>> On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
> >>>>
> >>>>
> >>>> On 7/20/23 23:02, Michael S. Tsirkin wrote:
> >>>>> On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
> >>>>>> On 7/20/23 1:38 AM, Jason Wang wrote:
> >>>>>>>
> >>>>>>> Adding cond_resched() to the command waiting loop for a better
> >>>>>>> co-operation with the scheduler. This allows to give CPU a breath=
 to
> >>>>>>> run other task(workqueue) instead of busy looping when preemption=
 is
> >>>>>>> not allowed on a device whose CVQ might be slow.
> >>>>>>>
> >>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >>>>>>
> >>>>>> This still leaves hung processes, but at least it doesn't pin the =
CPU any
> >>>>>> more.  Thanks.
> >>>>>> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> >>>>>>
> >>>>>
> >>>>> I'd like to see a full solution
> >>>>> 1- block until interrupt

I remember in previous versions, you worried about the extra MSI
vector. (Maybe I was wrong).

> >>>>
> >>>> Would it make sense to also have a timeout?
> >>>> And when timeout expires, set FAILED bit in device status?
> >>>
> >>> virtio spec does not set any limits on the timing of vq
> >>> processing.
> >>
> >> Indeed, but I thought the driver could decide it is too long for it.
> >>
> >> The issue is we keep waiting with rtnl locked, it can quickly make the
> >> system unusable.
> >
> > if this is a problem we should find a way not to keep rtnl
> > locked indefinitely.

Any ideas on this direction? Simply dropping rtnl during the busy loop
will result in a lot of races. This seems to require non-trivial
changes in the networking core.

>
>  From the tests I have done, I think it is. With OVS, a reconfiguration
> is performed when the VDUSE device is added, and when a MLX5 device is
> in the same bridge, it ends up doing an ioctl() that tries to take the
> rtnl lock. In this configuration, it is not possible to kill OVS because
> it is stuck trying to acquire rtnl lock for mlx5 that is held by virtio-
> net.

Yeah, basically, any RTNL users would be blocked forever.

And the infinite loop has other side effects like it blocks the freezer to =
work.

To summarize, there are three issues

1) busy polling
2) breaks freezer
3) hold RTNL during the loop

Solving 3 may help somehow for 2 e.g some pm routine e.g wireguard or
even virtnet_restore() itself may try to hold the lock.

>
> >
> >>>>> 2- still handle surprise removal correctly by waking in that case

This is basically what version 1 did?

https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redhat.co=
m/t/

Thanks

> >>>>>
> >>>>>
> >>>>>
> >>>>>>> ---
> >>>>>>>      drivers/net/virtio_net.c | 4 +++-
> >>>>>>>      1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >>>>>>> index 9f3b1d6ac33d..e7533f29b219 100644
> >>>>>>> --- a/drivers/net/virtio_net.c
> >>>>>>> +++ b/drivers/net/virtio_net.c
> >>>>>>> @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct vi=
rtnet_info *vi, u8 class, u8 cmd,
> >>>>>>>              * into the hypervisor, so the request should be hand=
led immediately.
> >>>>>>>              */
> >>>>>>>             while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> >>>>>>> -              !virtqueue_is_broken(vi->cvq))
> >>>>>>> +              !virtqueue_is_broken(vi->cvq)) {
> >>>>>>> +               cond_resched();
> >>>>>>>                     cpu_relax();
> >>>>>>> +       }
> >>>>>>>
> >>>>>>>             return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> >>>>>>>      }
> >>>>>>> --
> >>>>>>> 2.39.3
> >>>>>>>
> >>>>>>> _______________________________________________
> >>>>>>> Virtualization mailing list
> >>>>>>> Virtualization@lists.linux-foundation.org
> >>>>>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> >>>>>
> >>>
> >
>

