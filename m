Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5997D2885
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjJWC2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjJWC2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:28:13 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA28E6;
        Sun, 22 Oct 2023 19:28:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vud6gWk_1698028084;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vud6gWk_1698028084)
          by smtp.aliyun-inc.com;
          Mon, 23 Oct 2023 10:28:05 +0800
Message-ID: <1698028017.8052797-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Date:   Mon, 23 Oct 2023 10:26:57 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Su Hui <suhui@nfschina.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20231020092320.209234-1-suhui@nfschina.com>
 <20231020053047-mutt-send-email-mst@kernel.org>
 <1697794601.5857713-2-xuanzhuo@linux.alibaba.com>
 <20231020054140-mutt-send-email-mst@kernel.org>
 <1697795422.0986886-1-xuanzhuo@linux.alibaba.com>
 <20231020055943-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231020055943-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 06:08:06 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Oct 20, 2023 at 05:50:22PM +0800, Xuan Zhuo wrote:
> > On Fri, 20 Oct 2023 05:42:14 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Fri, Oct 20, 2023 at 05:36:41PM +0800, Xuan Zhuo wrote:
> > > > On Fri, 20 Oct 2023 05:34:32 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > On Fri, Oct 20, 2023 at 05:23:21PM +0800, Su Hui wrote:
> > > > > > virtqueue_resize_packed() or virtqueue_resize_split() can return
> > > > > > error code if failed, so add a check for this.
> > > > > >
> > > > > > Signed-off-by: Su Hui <suhui@nfschina.com>
> > > > > > ---
> > > > > >
> > > > > > I'm not sure that return directly is right or not,
> > > > > > maybe there are some process should do before return.
> > > > >
> > > > > yes - presizely what virtqueue_enable_after_reset does.
> > > > >
> > > > > Error handling in virtqueue_enable_after_reset is really weird BTW.
> > > > > For some reason it overrides the error code returned.
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > >  drivers/virtio/virtio_ring.c | 3 +++
> > > > > >  1 file changed, 3 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > index 51d8f3299c10..cf662c3a755b 100644
> > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > @@ -2759,6 +2759,9 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > > > > >  	else
> > > > > >  		err = virtqueue_resize_split(_vq, num);
> > > > > >
> > > > > > +	if (err)
> > > > > > +		return err;
> > > > > > +
> > > > > >  	return virtqueue_enable_after_reset(_vq);
> > > > >
> > > > > So I think it should be something like:
> > > > >
> > > > > 	int err_reset = virtqueue_enable_after_reset(_vq);
> > > > > 	BUG_ON(err_reset);
> > > > >
> > > > > 	return err;
> > > > >
> > > >
> > > > How about WARN and vq->broken?
> > > >
> > > > Thanks.
> > >
> > > Well, what are the cases where it can happen practically?
> >
> > Device error. Such as vp_active_vq()
> >
> > Thanks.
>
> Hmm interesting. OK. But do callers know to recover?


No.

So I think WARN + broken is suitable.

Thanks.


>
> >
> > >
> > > >
> > > > >
> > > > >
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(virtqueue_resize);
> > > > > > --
> > > > > > 2.30.2
> > > > >
> > >
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
