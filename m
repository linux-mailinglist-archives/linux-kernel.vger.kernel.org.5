Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C097D3074
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjJWK6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjJWK60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:58:26 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19ABD6E;
        Mon, 23 Oct 2023 03:58:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VukpPyF_1698058699;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VukpPyF_1698058699)
          by smtp.aliyun-inc.com;
          Mon, 23 Oct 2023 18:58:20 +0800
Message-ID: <1698058354.8316164-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Date:   Mon, 23 Oct 2023 18:52:34 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>, Su Hui <suhui@nfschina.com>
References: <20231020092320.209234-1-suhui@nfschina.com>
 <20231020053047-mutt-send-email-mst@kernel.org>
 <1697794601.5857713-2-xuanzhuo@linux.alibaba.com>
 <20231020054140-mutt-send-email-mst@kernel.org>
 <1697795422.0986886-1-xuanzhuo@linux.alibaba.com>
 <20231020055943-mutt-send-email-mst@kernel.org>
 <1698028017.8052797-1-xuanzhuo@linux.alibaba.com>
 <d4aa3f76-3e08-a852-a948-b88226a37fdd@nfschina.com>
 <1698029596.5404413-3-xuanzhuo@linux.alibaba.com>
 <46aee820-6c01-ed8a-613b-5c57258d749e@nfschina.com>
 <1698040004.5365264-4-xuanzhuo@linux.alibaba.com>
 <6a7d1006-0988-77ea-0991-9c7b422d78e1@nfschina.com>
 <1698054722.2894735-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1698054722.2894735-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 17:52:02 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> On Mon, 23 Oct 2023 17:50:46 +0800, Su Hui <suhui@nfschina.com> wrote:
> > On 2023/10/23 13:46, Xuan Zhuo wrote:
> > >>>>>>>> Well, what are the cases where it can happen practically?
> > >>>>>>> Device error. Such as vp_active_vq()
> > >>>>>>>
> > >>>>>>> Thanks.
> > >>>>>> Hmm interesting. OK. But do callers know to recover?
> > >>>>> No.
> > >>>>>
> > >>>>> So I think WARN + broken is suitable.
> > >>>>>
> > >>>>> Thanks.
> > >>>> Sorry for the late, is the following code okay?
> > >>>>
> > >>>> @@ -2739,7 +2739,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > >>>>                         void (*recycle)(struct virtqueue *vq, void *buf))
> > >>>>     {
> > >>>>            struct vring_virtqueue *vq = to_vvq(_vq);
> > >>>> -       int err;
> > >>>> +       int err, err_reset;
> > >>>>
> > >>>>            if (num > vq->vq.num_max)
> > >>>>                    return -E2BIG;
> > >>>> @@ -2759,7 +2759,15 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > >>>>            else
> > >>>>                    err = virtqueue_resize_split(_vq, num);
> > >>>>
> > >>>> -       return virtqueue_enable_after_reset(_vq);
> > >>>> +       err_reset = virtqueue_enable_after_reset(_vq);
> > >>>> +
> > >>>> +       if (err) {
> > >>> No err.
> > >>>
> > >>> err is not important.
> > >>> You can remove that.
> > >> Emm, I'm a little confused that which code should I remove ?
> > >>
> > >>
> > >> like this:
> > >> 	if (vq->packed_ring)
> > >> 		virtqueue_resize_packed(_vq, num);
> > >> 	else
> > >> 		virtqueue_resize_split(_vq, num);
> > >>
> > >> And we should set broken and warn inside virtqueue_enable_after_reset()?
> >
> > In my opinion, we should return the error code of virtqueue_resize_packed() / virtqueue_resize_split().
> > But if this err is not important, this patch makes no sense.
> > Maybe I misunderstand somewhere...
> > If you think it's worth sending a patch, you can send it :).(I'm not familiar with this code).
>
> OK.

Hi Michael,

The queue reset code is wrote with the CONFIG_VIRTIO_HARDEN_NOTIFICATION.

When we disable the vq, the broken is true until we re-enable it.

So when we re-enable it fail, the vq is broken status.

Normally, this just happens on the buggy device.
So I think that is enough.

Thanks.


	static int vp_modern_disable_vq_and_reset(struct virtqueue *vq)
	{
		[...]

		vp_modern_set_queue_reset(mdev, vq->index);

		[...]

	#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
->>		__virtqueue_break(vq);
	#endif

		[...]
	}

	static int vp_modern_enable_vq_after_reset(struct virtqueue *vq)
	{
		[...]

		if (vp_modern_get_queue_reset(mdev, index))
			return -EBUSY;

		if (vp_modern_get_queue_enable(mdev, index))
			return -EBUSY;

		err = vp_active_vq(vq, info->msix_vector);
		if (err)
			return err;

		}

		[...]

	#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
->>		__virtqueue_unbreak(vq);
	#endif

		[...]
	}




>
> Thanks.
>
>
> >
> > Thanks,
> > Su Hui
> >
