Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A917D3268
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjJWLTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjJWLTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FEA10B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698059927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jnC1GGwxL9Zbpu28wAk0w4sz4UIRk93Qqt6FyBIuiIY=;
        b=OsjJLnhxtfNjxWFuC4XYDgCUrHf/ImAbRRK/QL3tppXdntq5mdVfUM4/YjfnGm8dunV1se
        ualDDRBIfocyC0meOVROirs1rW1MVX6QifYKj8j7oyPtHYeO8g7TSZCjCIr6EBFSmESx7g
        Enz/mEtztGVcG/ytRM/TPMkB2CHcQ4Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-l0MsIuJ4OhKOnWnhGnGaCg-1; Mon, 23 Oct 2023 07:18:46 -0400
X-MC-Unique: l0MsIuJ4OhKOnWnhGnGaCg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4084a9e637eso20359925e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698059924; x=1698664724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnC1GGwxL9Zbpu28wAk0w4sz4UIRk93Qqt6FyBIuiIY=;
        b=SsukewJTHiIYF15tfdUTdAO/HFT3MEFlOHi1/kTlRTZPKPbVNN0tyibyE05w5dKGUW
         Pu8J58I9rGWXBnAuqpwALcCwDQGtoBLof3KKjjWsByYcPTGr9FbdtVMPjojl8RYgmoT6
         jhTpXubwsrqpDdOrs2oaZNtTtbRKp3mnnwbrW5lNOdDKi89yxjJi9NBeJVkItqEkqcjm
         FooTEMpFR9E7VBGe8irNPwGccE8C9oMYYvfoRD6bOHM1qbbSAgoXB9VxYhgbOlWMHZPz
         uJBYwatTgJBTeOXQAwwOAlP2tpZsHTfLQqQ/HrBbI3vuDJJnXSCSd/a0xWQNpMZOOmPj
         LHUg==
X-Gm-Message-State: AOJu0Yy4PfSDjL2vkvDlOqMelWbaG1qwnFbRIltmaDubhuNzExR+vhFj
        +vnoEJxzhDLV+3LDDIkvAi54vB5e8v+2ZZoMV9vp9MhFXjPXWsT16zsA0exSE9L1nqV/7Jm3j24
        G/CjMO33MO3jO1+Zo1gyCaL8XUOjJUyTi
X-Received: by 2002:a05:600c:3b17:b0:405:39c1:a98b with SMTP id m23-20020a05600c3b1700b0040539c1a98bmr6781857wms.20.1698059924735;
        Mon, 23 Oct 2023 04:18:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlNOSbGZV0psNxYVAdk0xozr8uaYafLwOEKQtbvzrUCUXDsWv/S3FBPkSASbIRrVthMSMMVg==
X-Received: by 2002:a05:600c:3b17:b0:405:39c1:a98b with SMTP id m23-20020a05600c3b1700b0040539c1a98bmr6781844wms.20.1698059924402;
        Mon, 23 Oct 2023 04:18:44 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:e88f:2c2c:db43:583d:d30e])
        by smtp.gmail.com with ESMTPSA id c39-20020a05600c4a2700b0040588d85b3asm13601617wmp.15.2023.10.23.04.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 04:18:43 -0700 (PDT)
Date:   Mon, 23 Oct 2023 07:18:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Su Hui <suhui@nfschina.com>
Subject: Re: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Message-ID: <20231023071752-mutt-send-email-mst@kernel.org>
References: <1697795422.0986886-1-xuanzhuo@linux.alibaba.com>
 <20231020055943-mutt-send-email-mst@kernel.org>
 <1698028017.8052797-1-xuanzhuo@linux.alibaba.com>
 <d4aa3f76-3e08-a852-a948-b88226a37fdd@nfschina.com>
 <1698029596.5404413-3-xuanzhuo@linux.alibaba.com>
 <46aee820-6c01-ed8a-613b-5c57258d749e@nfschina.com>
 <1698040004.5365264-4-xuanzhuo@linux.alibaba.com>
 <6a7d1006-0988-77ea-0991-9c7b422d78e1@nfschina.com>
 <1698054722.2894735-1-xuanzhuo@linux.alibaba.com>
 <1698058354.8316164-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1698058354.8316164-2-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 06:52:34PM +0800, Xuan Zhuo wrote:
> On Mon, 23 Oct 2023 17:52:02 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > On Mon, 23 Oct 2023 17:50:46 +0800, Su Hui <suhui@nfschina.com> wrote:
> > > On 2023/10/23 13:46, Xuan Zhuo wrote:
> > > >>>>>>>> Well, what are the cases where it can happen practically?
> > > >>>>>>> Device error. Such as vp_active_vq()
> > > >>>>>>>
> > > >>>>>>> Thanks.
> > > >>>>>> Hmm interesting. OK. But do callers know to recover?
> > > >>>>> No.
> > > >>>>>
> > > >>>>> So I think WARN + broken is suitable.
> > > >>>>>
> > > >>>>> Thanks.
> > > >>>> Sorry for the late, is the following code okay?
> > > >>>>
> > > >>>> @@ -2739,7 +2739,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > > >>>>                         void (*recycle)(struct virtqueue *vq, void *buf))
> > > >>>>     {
> > > >>>>            struct vring_virtqueue *vq = to_vvq(_vq);
> > > >>>> -       int err;
> > > >>>> +       int err, err_reset;
> > > >>>>
> > > >>>>            if (num > vq->vq.num_max)
> > > >>>>                    return -E2BIG;
> > > >>>> @@ -2759,7 +2759,15 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > > >>>>            else
> > > >>>>                    err = virtqueue_resize_split(_vq, num);
> > > >>>>
> > > >>>> -       return virtqueue_enable_after_reset(_vq);
> > > >>>> +       err_reset = virtqueue_enable_after_reset(_vq);
> > > >>>> +
> > > >>>> +       if (err) {
> > > >>> No err.
> > > >>>
> > > >>> err is not important.
> > > >>> You can remove that.
> > > >> Emm, I'm a little confused that which code should I remove ?
> > > >>
> > > >>
> > > >> like this:
> > > >> 	if (vq->packed_ring)
> > > >> 		virtqueue_resize_packed(_vq, num);
> > > >> 	else
> > > >> 		virtqueue_resize_split(_vq, num);
> > > >>
> > > >> And we should set broken and warn inside virtqueue_enable_after_reset()?
> > >
> > > In my opinion, we should return the error code of virtqueue_resize_packed() / virtqueue_resize_split().
> > > But if this err is not important, this patch makes no sense.
> > > Maybe I misunderstand somewhere...
> > > If you think it's worth sending a patch, you can send it :).(I'm not familiar with this code).
> >
> > OK.
> 
> Hi Michael,
> 
> The queue reset code is wrote with the CONFIG_VIRTIO_HARDEN_NOTIFICATION.
> 
> When we disable the vq, the broken is true until we re-enable it.
> 
> So when we re-enable it fail, the vq is broken status.
> 
> Normally, this just happens on the buggy device.
> So I think that is enough.
> 
> Thanks.

I don't know what to do about CONFIG_VIRTIO_HARDEN_NOTIFICATION.
It's known to be broken and it does not look like there's
active effort to revive it - should we just drop it for now?


> 
> 	static int vp_modern_disable_vq_and_reset(struct virtqueue *vq)
> 	{
> 		[...]
> 
> 		vp_modern_set_queue_reset(mdev, vq->index);
> 
> 		[...]
> 
> 	#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> ->>		__virtqueue_break(vq);
> 	#endif
> 
> 		[...]
> 	}
> 
> 	static int vp_modern_enable_vq_after_reset(struct virtqueue *vq)
> 	{
> 		[...]
> 
> 		if (vp_modern_get_queue_reset(mdev, index))
> 			return -EBUSY;
> 
> 		if (vp_modern_get_queue_enable(mdev, index))
> 			return -EBUSY;
> 
> 		err = vp_active_vq(vq, info->msix_vector);
> 		if (err)
> 			return err;
> 
> 		}
> 
> 		[...]
> 
> 	#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> ->>		__virtqueue_unbreak(vq);
> 	#endif
> 
> 		[...]
> 	}
> 
> 
> 
> 
> >
> > Thanks.
> >
> >
> > >
> > > Thanks,
> > > Su Hui
> > >

