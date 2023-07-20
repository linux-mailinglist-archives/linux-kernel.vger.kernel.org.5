Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D5075B919
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjGTU71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGTU7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4602D6A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 13:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689886705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4dqf8Jjm5t/QS+Vt8DTpJf/dAD7LQ0qakHIdy8mWAJw=;
        b=UmnmSsDSkxAsM+SRlaAfp6nq3cW26g1IopSZYBJyqvSOoIYwIt4k9LceIX0ML1rESVaaQp
        xmPBtSVHcjCr9X1hYMX9HY37Lxr/2YJ/nu3va33RJGa1kObWvE0IGpMscKqAaaBSFvrsb1
        Mdsm6fEcigpUid0I8ii5giOVydu5+y8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-MV3LVQ9KNo2HYUvtZ77miA-1; Thu, 20 Jul 2023 16:58:24 -0400
X-MC-Unique: MV3LVQ9KNo2HYUvtZ77miA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-316f39e3e89so1061426f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 13:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689886703; x=1690491503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dqf8Jjm5t/QS+Vt8DTpJf/dAD7LQ0qakHIdy8mWAJw=;
        b=BkjSumx2+dPJmXSKhAqI10vOdOtAxVFv1JVoC3pM86jlIZROD6B/cAi8wggr6/X86E
         zrBG6F8IxmHNT4F9HsZrF7jPesKL9TOqhkU0SYhNtrQUbmlzGtYLMS9QyGDW/OxSlTTD
         Mia1jtDNccExMKH3LCNrZHF+SFfv7bSEAvYznodZNcxmA7jF0P3KlX3akro6eHfV9dbE
         /x2wwBwYRXoE7wh1JCLCTUa00moU7Xpit1Irsgj4J8KUM9vmHheJ+5ORykG13iChP/FB
         i8tkmlJt4NwiUJliOrw6+2sBsv8eb/rmymkUAedBKpp6IG6g/I2o3F2wRnc8v0BE5hBz
         wy5A==
X-Gm-Message-State: ABy/qLZTVOnf8htome5PV4S1pPE59Cb2lxLciGLPVt0hx3HJZcHCOTfo
        1AXTswCimIdVIHnWr6PlqhXev1rWF9zTrOS5uMcBuKll1oVX4c+hlobLTwPQa8tWYECDL3hWC88
        ERJBNalMN6IjjvBXD2p+rWL5/
X-Received: by 2002:adf:fc48:0:b0:314:77a:c2a6 with SMTP id e8-20020adffc48000000b00314077ac2a6mr24902wrs.25.1689886703221;
        Thu, 20 Jul 2023 13:58:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGGGVPES+OLvpID+VHOy6r8D1EwH01kkL+pN8O6wPgr+LrofdyHrBq3n7dIj/lcIXZPoNV3xA==
X-Received: by 2002:adf:fc48:0:b0:314:77a:c2a6 with SMTP id e8-20020adffc48000000b00314077ac2a6mr24892wrs.25.1689886702902;
        Thu, 20 Jul 2023 13:58:22 -0700 (PDT)
Received: from redhat.com ([2.52.16.41])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d6889000000b0031432c2fb95sm2275327wru.88.2023.07.20.13.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:58:22 -0700 (PDT)
Date:   Thu, 20 Jul 2023 16:58:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Shannon Nelson <shannon.nelson@amd.com>
Cc:     Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, edumazet@google.com,
        maxime.coquelin@redhat.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230720164930-mutt-send-email-mst@kernel.org>
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <b949697e-319a-7cc1-84d8-1391713fa645@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b949697e-319a-7cc1-84d8-1391713fa645@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 08:31:13AM -0700, Shannon Nelson wrote:
> On 7/20/23 1:38 AM, Jason Wang wrote:
> > 
> > Adding cond_resched() to the command waiting loop for a better
> > co-operation with the scheduler. This allows to give CPU a breath to
> > run other task(workqueue) instead of busy looping when preemption is
> > not allowed on a device whose CVQ might be slow.
> > 
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >   drivers/net/virtio_net.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 9f3b1d6ac33d..e7533f29b219 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> >           * into the hypervisor, so the request should be handled immediately.
> >           */
> >          while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > -              !virtqueue_is_broken(vi->cvq))
> > +              !virtqueue_is_broken(vi->cvq)) {
> > +               cond_resched();
> >                  cpu_relax();
> > +       }
> 
> The cover letter suggests that this addresses the infinite poll for buggy
> devices, but I don't see how that is resolved here.  This should make it a
> little nicer to the system, but it still is going to poll forever on a
> device that has gone catatonic.  Is there a reason that I'm missing that we
> don't have a polling limit here?
> 
> sln

we don't know what the limit would be. but given it's a workqueue
now, why does it still have to poll as opposed to blocking?


> > 
> >          return vi->ctrl->status == VIRTIO_NET_OK;
> >   }
> > --
> > 2.39.3
> > 
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization

