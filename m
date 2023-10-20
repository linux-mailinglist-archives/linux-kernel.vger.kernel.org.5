Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BDA7D0C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376697AbjJTJnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376601AbjJTJnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:43:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885C8C2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697794941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B8zhNyoPjCzPI6JP3Ig1aNei31DQ1+NDAezu4yisodc=;
        b=UxtIqX+MWVWF0WopgYGyA3jaTL5QiWIRt+a4vAsLS2hf//RM8u5VZWT8FyzAHYgHIE+qQx
        mscpg7WRahrcNA45CULBmKGy7Xu/J6VAgBf31Oy8ul6cfnAkueGZ9jdgpLEIM3cFmalDUl
        X1ZAnvvnjbGV26LzYCKCr6YnY9XzGsQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-Pc5woKiDNdSm7SbBggyydQ-1; Fri, 20 Oct 2023 05:42:19 -0400
X-MC-Unique: Pc5woKiDNdSm7SbBggyydQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4084e4ce543so3842295e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697794937; x=1698399737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8zhNyoPjCzPI6JP3Ig1aNei31DQ1+NDAezu4yisodc=;
        b=Eoe1Y39bDRnEcvKbh2pgvr5Qd/em3GXwV0iMezBDbONb/MvQrhxvAF+jk70+K/9dIa
         7kT97ZGtNCTYsFu0rmPytq8OLMfb1Etj+m7+sCKOEpzbT5PPCY1lkX0diX/ts56eTI/e
         kGqFqkx0UJibgLNx57xLx2etwBaQl0Gk31PfTPCqv9yKhZiIqi9NoWlDodLKTPN9oz2E
         OgjDEfekn3dAtCoYtWrhOqOoMfSGEw9L1SPGWDfoc2xqQFWML7IObiXeM85GeYXvOaTc
         85/Ifm2z5H17LoK9KqxPCAtpfaZXCt1S6hlxl0ety9RU3XRDdr+gEiLimgSh1mbxLCqC
         8Xeg==
X-Gm-Message-State: AOJu0Yyu2Nbq0Du27ATzmLmfn1zWDfS10Wm5J59ySqRVRyli3XqotY4J
        qsc+fzIkfxS1QdXtYPq2MOaAx0T1lGr6RWN+YNhgHKp/Xo682KLVjnOQd2YLCuFcbdIN58yDHq+
        jOSWedswQ+HP2MdfBdTYYp8aHjMXydiYD
X-Received: by 2002:a05:600c:5010:b0:401:b652:b6cf with SMTP id n16-20020a05600c501000b00401b652b6cfmr1071101wmr.13.1697794937689;
        Fri, 20 Oct 2023 02:42:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM1EM6T+wMVFzF33cC7Y8KaN3eWcPR5dXbra2BbI2AyJPoDU5x0TqLATbg4eiyQEcfWjjlHA==
X-Received: by 2002:a05:600c:5010:b0:401:b652:b6cf with SMTP id n16-20020a05600c501000b00401b652b6cfmr1071091wmr.13.1697794937447;
        Fri, 20 Oct 2023 02:42:17 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b00402ff8d6086sm1734198wmg.18.2023.10.20.02.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 02:42:16 -0700 (PDT)
Date:   Fri, 20 Oct 2023 05:42:14 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Su Hui <suhui@nfschina.com>
Subject: Re: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Message-ID: <20231020054140-mutt-send-email-mst@kernel.org>
References: <20231020092320.209234-1-suhui@nfschina.com>
 <20231020053047-mutt-send-email-mst@kernel.org>
 <1697794601.5857713-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697794601.5857713-2-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 05:36:41PM +0800, Xuan Zhuo wrote:
> On Fri, 20 Oct 2023 05:34:32 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Fri, Oct 20, 2023 at 05:23:21PM +0800, Su Hui wrote:
> > > virtqueue_resize_packed() or virtqueue_resize_split() can return
> > > error code if failed, so add a check for this.
> > >
> > > Signed-off-by: Su Hui <suhui@nfschina.com>
> > > ---
> > >
> > > I'm not sure that return directly is right or not,
> > > maybe there are some process should do before return.
> >
> > yes - presizely what virtqueue_enable_after_reset does.
> >
> > Error handling in virtqueue_enable_after_reset is really weird BTW.
> > For some reason it overrides the error code returned.
> >
> >
> >
> >
> >
> > >  drivers/virtio/virtio_ring.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 51d8f3299c10..cf662c3a755b 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -2759,6 +2759,9 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > >  	else
> > >  		err = virtqueue_resize_split(_vq, num);
> > >
> > > +	if (err)
> > > +		return err;
> > > +
> > >  	return virtqueue_enable_after_reset(_vq);
> >
> > So I think it should be something like:
> >
> > 	int err_reset = virtqueue_enable_after_reset(_vq);
> > 	BUG_ON(err_reset);
> >
> > 	return err;
> >
> 
> How about WARN and vq->broken?
> 
> Thanks.

Well, what are the cases where it can happen practically?

> 
> >
> >
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_resize);
> > > --
> > > 2.30.2
> >

