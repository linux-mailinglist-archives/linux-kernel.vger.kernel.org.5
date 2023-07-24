Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8C775EC5A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjGXHT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGXHTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0493CE49
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690183108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y0B0LDFyq4zI8oaMOy4L4JGnwpFi6s+eOhQWQ3J6Ico=;
        b=ZpXx+3TH82NKHhs0CFc1Ow6Exy1N7VXTcxDv/hLDxPzfgt2wMNsSoYbIZRitkPrKbFWu+x
        /NYnw2m70Fn/sFB+Z/2M5fJO1lSNeD3o11a7rQlkHd80IRvlX9ioM1zOMGv44MQ8D7tr9A
        Gj2lOejS1HvuuKB30PqPjeuaxUxyE4A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-QRF-8cGwNTaUXzh-VaxHBw-1; Mon, 24 Jul 2023 03:18:26 -0400
X-MC-Unique: QRF-8cGwNTaUXzh-VaxHBw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fa8cd898e0so26272335e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690183105; x=1690787905;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0B0LDFyq4zI8oaMOy4L4JGnwpFi6s+eOhQWQ3J6Ico=;
        b=CQ5rL7whYfzNu9axZo2XB2FY6AavUzH9cAkr/fpFXEjscwgMQ/M9FJnFM97ZCuwvJF
         JxPhtroQ5qwmH0hrlKZbwlkC5BYkbP+pz4X8Ls9Wf2EWs2rnURHo0K3nRbXJhHZikVW3
         jiS7sFRl+o1UbItcjjEEL7537558aPut7NB8pCJm6A9icw3GAPRZTsxm0Tapv3xGR/vd
         /PSJcp8ORO9wWo9auCC0qrbIKl8G+XGAb/oRxNnb+yaucEGFDkfyh+GSEYtLDq6rprlA
         s6lZZOq03ye81WJ4KgKMlVem8/Ybj5oe9xf4Sial2wJSjwurQ+pr9l0t1GCZ77yp+AiU
         mUwA==
X-Gm-Message-State: ABy/qLZ0PPPFeYVCbX5ScfPPsKFmknUiUb/iLMkg0jxsbLeDcYtXTj1S
        zWUPLI3QrabU6HBQwN9tGZwsJVyJ7qLpu1ToELYFtaqrCPrJ5JaHH3Dsk02/glKy19qs6uqyzQY
        KXF4CwRU8OMVkE99Q+VzpAGYt
X-Received: by 2002:a5d:680c:0:b0:316:f3cf:6f12 with SMTP id w12-20020a5d680c000000b00316f3cf6f12mr7144972wru.48.1690183105198;
        Mon, 24 Jul 2023 00:18:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH4oQz23HfbqktSC+1wQUVQJBJFRQUjCUkFXV4QoTY6r9ynKNys0rX0Lb7SYQf/AnOdWkAvZQ==
X-Received: by 2002:a5d:680c:0:b0:316:f3cf:6f12 with SMTP id w12-20020a5d680c000000b00316f3cf6f12mr7144949wru.48.1690183104901;
        Mon, 24 Jul 2023 00:18:24 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e0:3800:a16e:b2a0:7d06:58aa])
        by smtp.gmail.com with ESMTPSA id m9-20020a5d56c9000000b00313e2abfb8dsm11944520wrw.92.2023.07.24.00.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 00:18:24 -0700 (PDT)
Date:   Mon, 24 Jul 2023 03:18:21 -0400
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
Message-ID: <20230724031732-mutt-send-email-mst@kernel.org>
References: <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <20230723053441-mutt-send-email-mst@kernel.org>
 <CACGkMEuPcOyjgHkKXrcnofdb5XhYYTrGQeuR3j6Oypr0KZxLMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuPcOyjgHkKXrcnofdb5XhYYTrGQeuR3j6Oypr0KZxLMg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 02:52:49PM +0800, Jason Wang wrote:
> On Mon, Jul 24, 2023 at 2:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jul 21, 2023 at 10:18:03PM +0200, Maxime Coquelin wrote:
> > >
> > >
> > > On 7/21/23 17:10, Michael S. Tsirkin wrote:
> > > > On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wrote:
> > > > >
> > > > >
> > > > > On 7/21/23 16:45, Michael S. Tsirkin wrote:
> > > > > > On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
> > > > > > >
> > > > > > >
> > > > > > > On 7/20/23 23:02, Michael S. Tsirkin wrote:
> > > > > > > > On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
> > > > > > > > > On 7/20/23 1:38 AM, Jason Wang wrote:
> > > > > > > > > >
> > > > > > > > > > Adding cond_resched() to the command waiting loop for a better
> > > > > > > > > > co-operation with the scheduler. This allows to give CPU a breath to
> > > > > > > > > > run other task(workqueue) instead of busy looping when preemption is
> > > > > > > > > > not allowed on a device whose CVQ might be slow.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > >
> > > > > > > > > This still leaves hung processes, but at least it doesn't pin the CPU any
> > > > > > > > > more.  Thanks.
> > > > > > > > > Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > > > > > > > >
> > > > > > > >
> > > > > > > > I'd like to see a full solution
> > > > > > > > 1- block until interrupt
> > > > > > >
> > > > > > > Would it make sense to also have a timeout?
> > > > > > > And when timeout expires, set FAILED bit in device status?
> > > > > >
> > > > > > virtio spec does not set any limits on the timing of vq
> > > > > > processing.
> > > > >
> > > > > Indeed, but I thought the driver could decide it is too long for it.
> > > > >
> > > > > The issue is we keep waiting with rtnl locked, it can quickly make the
> > > > > system unusable.
> > > >
> > > > if this is a problem we should find a way not to keep rtnl
> > > > locked indefinitely.
> > >
> > > From the tests I have done, I think it is. With OVS, a reconfiguration is
> > > performed when the VDUSE device is added, and when a MLX5 device is
> > > in the same bridge, it ends up doing an ioctl() that tries to take the
> > > rtnl lock. In this configuration, it is not possible to kill OVS because
> > > it is stuck trying to acquire rtnl lock for mlx5 that is held by virtio-
> > > net.
> >
> > So for sure, we can queue up the work and process it later.
> > The somewhat tricky part is limiting the memory consumption.
> 
> And it needs to sync with rtnl somehow, e.g device unregistering which
> seems not easy.
> 
> Thanks

since when does device unregister need to send cvq commands?

> >
> >
> > > >
> > > > > > > > 2- still handle surprise removal correctly by waking in that case
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > >      drivers/net/virtio_net.c | 4 +++-
> > > > > > > > > >      1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > > > > index 9f3b1d6ac33d..e7533f29b219 100644
> > > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > > @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > > > > > > > > >              * into the hypervisor, so the request should be handled immediately.
> > > > > > > > > >              */
> > > > > > > > > >             while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > > > > > > -              !virtqueue_is_broken(vi->cvq))
> > > > > > > > > > +              !virtqueue_is_broken(vi->cvq)) {
> > > > > > > > > > +               cond_resched();
> > > > > > > > > >                     cpu_relax();
> > > > > > > > > > +       }
> > > > > > > > > >
> > > > > > > > > >             return vi->ctrl->status == VIRTIO_NET_OK;
> > > > > > > > > >      }
> > > > > > > > > > --
> > > > > > > > > > 2.39.3
> > > > > > > > > >
> > > > > > > > > > _______________________________________________
> > > > > > > > > > Virtualization mailing list
> > > > > > > > > > Virtualization@lists.linux-foundation.org
> > > > > > > > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > > > > > > >
> > > > > >
> > > >
> >

