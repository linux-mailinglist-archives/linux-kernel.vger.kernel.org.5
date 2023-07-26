Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB1076353F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbjGZLjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbjGZLi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:38:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB60F11F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690371486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xorJN/SDeKDU05gI5Z3c6dVEpJ3v55zBDQHrXJxgaKI=;
        b=hi5zso9avOEXToiza55LScX2c7dw2+jVtX2uJlflhnY62xUelLod3G8oh3F7V6+6oQbp9F
        2EgM9fm7vXxck4YYZej/fkEMAlP19YP4c+ozPuhnbVprIE8qzz9qg8MbA7fcjeuDQeqQcN
        20tPlK7sqHLBwnH+kM1DLpKXMaq1lnE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-efID16XNPiK1BzHbfXj1bA-1; Wed, 26 Jul 2023 07:38:05 -0400
X-MC-Unique: efID16XNPiK1BzHbfXj1bA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-992e6840901so99745866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690371483; x=1690976283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xorJN/SDeKDU05gI5Z3c6dVEpJ3v55zBDQHrXJxgaKI=;
        b=YEIJo2SlIWm1sq40AuGmR39VMuHnog9O370i1BX8YZD1CDaiYB3+YlfeFobMFc2wLq
         5J1gFR0w15S+tXGkxQ7G3HV62LJdQQcIyaXR7sUsfW3gSTRCyPmEJZlyR24pevf8/joY
         qB/7lLBfuncVvQA9rIepUaO4cJ/EuLQFBsnbT95pLQ6nN8IGUlZr/KSIkq8EHgYzLPJ1
         3N3CsAcPk5S72AXWMH8TcD0ULtLOOA933iLq+C96RRXPqh5msSPvCgGkQ4BjHRfgOskc
         fTIf+89A4S1A6oHcBCnZQ197QoHCDkcZGMb6goVtcHagsZgafzNEjXULclsVhZY4z7y5
         7qsg==
X-Gm-Message-State: ABy/qLYOLw5+25gwX8moQzWMK8DCuo8lkjiJM3et+hesbY1ZZIRqqn6s
        zQgUIVW8tYojLikeTMvVZaxfzdYXkDdgPAS+NC2LCo2qP4L/wVACtCovLabCPpRBjiKdWzfjFIv
        9Qk1WUckq0MRe+f8WreyUl+xnQlBxL/ql
X-Received: by 2002:a17:907:9625:b0:993:f664:ce25 with SMTP id gb37-20020a170907962500b00993f664ce25mr6492988ejc.19.1690371483224;
        Wed, 26 Jul 2023 04:38:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFYkMeOUHXBWug6XiU5fsOsY8Kp4ZKa+es8U5cNa9A8iPD+KWT7NKkXZCNXoWYMOJrpJOVygQ==
X-Received: by 2002:a17:907:9625:b0:993:f664:ce25 with SMTP id gb37-20020a170907962500b00993f664ce25mr6492975ejc.19.1690371482888;
        Wed, 26 Jul 2023 04:38:02 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:be95:2796:17af:f46c:dea1])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090694c400b009930042510csm9538412ejy.222.2023.07.26.04.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 04:37:49 -0700 (PDT)
Date:   Wed, 26 Jul 2023 07:37:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230726073453-mutt-send-email-mst@kernel.org>
References: <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org>
 <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org>
 <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 09:55:37AM +0800, Jason Wang wrote:
> On Tue, Jul 25, 2023 at 3:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jul 25, 2023 at 11:07:40AM +0800, Jason Wang wrote:
> > > On Mon, Jul 24, 2023 at 3:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Jul 24, 2023 at 02:52:05PM +0800, Jason Wang wrote:
> > > > > On Sat, Jul 22, 2023 at 4:18 AM Maxime Coquelin
> > > > > <maxime.coquelin@redhat.com> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > On 7/21/23 17:10, Michael S. Tsirkin wrote:
> > > > > > > On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wrote:
> > > > > > >>
> > > > > > >>
> > > > > > >> On 7/21/23 16:45, Michael S. Tsirkin wrote:
> > > > > > >>> On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
> > > > > > >>>>
> > > > > > >>>>
> > > > > > >>>> On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > > > > > >>>>> On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
> > > > > > >>>>>> On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > > > >>>>>>>
> > > > > > >>>>>>> Adding cond_resched() to the command waiting loop for a better
> > > > > > >>>>>>> co-operation with the scheduler. This allows to give CPU a breath to
> > > > > > >>>>>>> run other task(workqueue) instead of busy looping when preemption is
> > > > > > >>>>>>> not allowed on a device whose CVQ might be slow.
> > > > > > >>>>>>>
> > > > > > >>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > >>>>>>
> > > > > > >>>>>> This still leaves hung processes, but at least it doesn't pin the CPU any
> > > > > > >>>>>> more.  Thanks.
> > > > > > >>>>>> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > > > > > >>>>>>
> > > > > > >>>>>
> > > > > > >>>>> I'd like to see a full solution
> > > > > > >>>>> 1- block until interrupt
> > > > >
> > > > > I remember in previous versions, you worried about the extra MSI
> > > > > vector. (Maybe I was wrong).
> > > > >
> > > > > > >>>>
> > > > > > >>>> Would it make sense to also have a timeout?
> > > > > > >>>> And when timeout expires, set FAILED bit in device status?
> > > > > > >>>
> > > > > > >>> virtio spec does not set any limits on the timing of vq
> > > > > > >>> processing.
> > > > > > >>
> > > > > > >> Indeed, but I thought the driver could decide it is too long for it.
> > > > > > >>
> > > > > > >> The issue is we keep waiting with rtnl locked, it can quickly make the
> > > > > > >> system unusable.
> > > > > > >
> > > > > > > if this is a problem we should find a way not to keep rtnl
> > > > > > > locked indefinitely.
> > > > >
> > > > > Any ideas on this direction? Simply dropping rtnl during the busy loop
> > > > > will result in a lot of races. This seems to require non-trivial
> > > > > changes in the networking core.
> > > > >
> > > > > >
> > > > > >  From the tests I have done, I think it is. With OVS, a reconfiguration
> > > > > > is performed when the VDUSE device is added, and when a MLX5 device is
> > > > > > in the same bridge, it ends up doing an ioctl() that tries to take the
> > > > > > rtnl lock. In this configuration, it is not possible to kill OVS because
> > > > > > it is stuck trying to acquire rtnl lock for mlx5 that is held by virtio-
> > > > > > net.
> > > > >
> > > > > Yeah, basically, any RTNL users would be blocked forever.
> > > > >
> > > > > And the infinite loop has other side effects like it blocks the freezer to work.
> > > > >
> > > > > To summarize, there are three issues
> > > > >
> > > > > 1) busy polling
> > > > > 2) breaks freezer
> > > > > 3) hold RTNL during the loop
> > > > >
> > > > > Solving 3 may help somehow for 2 e.g some pm routine e.g wireguard or
> > > > > even virtnet_restore() itself may try to hold the lock.
> > > >
> > > > Yep. So my feeling currently is, the only real fix is to actually
> > > > queue up the work in software.
> > >
> > > Do you mean something like:
> > >
> > > rtnl_lock();
> > > queue up the work
> > > rtnl_unlock();
> > > return success;
> > >
> > > ?
> >
> > yes
> 
> We will lose the error reporting, is it a real problem or not?

Fundamental isn't it? Maybe we want a per-device flag for a asynch commands,
and vduse will set it while hardware virtio won't.
this way we only lose error reporting for vduse.

> >
> >
> > > > It's mostly trivial to limit
> > > > memory consumption, vid's is the
> > > > only one where it would make sense to have more than
> > > > 1 command of a given type outstanding.
> > >
> > > And rx mode so this implies we will fail any command if the previous
> > > work is not finished.
> >
> > don't fail it, store it.
> 
> Ok.
> 
> Thanks
> 
> >
> > > > have a tree
> > > > or a bitmap with vids to add/remove?
> > >
> > > Probably.
> > >
> > > Thanks
> > >
> > > >
> > > >
> > > >
> > > > > >
> > > > > > >
> > > > > > >>>>> 2- still handle surprise removal correctly by waking in that case
> > > > >
> > > > > This is basically what version 1 did?
> > > > >
> > > > > https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redhat.com/t/
> > > > >
> > > > > Thanks
> > > >
> > > > Yes - except the timeout part.
> > > >
> > > >
> > > > > > >>>>>
> > > > > > >>>>>
> > > > > > >>>>>
> > > > > > >>>>>>> ---
> > > > > > >>>>>>>      drivers/net/virtio_net.c | 4 +++-
> > > > > > >>>>>>>      1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > >>>>>>>
> > > > > > >>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > >>>>>>> index 9f3b1d6ac33d..e7533f29b219 100644
> > > > > > >>>>>>> --- a/drivers/net/virtio_net.c
> > > > > > >>>>>>> +++ b/drivers/net/virtio_net.c
> > > > > > >>>>>>> @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > > > > > >>>>>>>              * into the hypervisor, so the request should be handled immediately.
> > > > > > >>>>>>>              */
> > > > > > >>>>>>>             while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > > >>>>>>> -              !virtqueue_is_broken(vi->cvq))
> > > > > > >>>>>>> +              !virtqueue_is_broken(vi->cvq)) {
> > > > > > >>>>>>> +               cond_resched();
> > > > > > >>>>>>>                     cpu_relax();
> > > > > > >>>>>>> +       }
> > > > > > >>>>>>>
> > > > > > >>>>>>>             return vi->ctrl->status == VIRTIO_NET_OK;
> > > > > > >>>>>>>      }
> > > > > > >>>>>>> --
> > > > > > >>>>>>> 2.39.3
> > > > > > >>>>>>>
> > > > > > >>>>>>> _______________________________________________
> > > > > > >>>>>>> Virtualization mailing list
> > > > > > >>>>>>> Virtualization@lists.linux-foundation.org
> > > > > > >>>>>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > > > > > >>>>>
> > > > > > >>>
> > > > > > >
> > > > > >
> > > >
> >

