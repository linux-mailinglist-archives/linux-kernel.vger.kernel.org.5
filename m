Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD3F7D0BFA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376684AbjJTJfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376690AbjJTJf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:35:26 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9440AD5E;
        Fri, 20 Oct 2023 02:35:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VuWtWLk_1697794515;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VuWtWLk_1697794515)
          by smtp.aliyun-inc.com;
          Fri, 20 Oct 2023 17:35:16 +0800
Message-ID: <1697794128.4297402-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Date:   Fri, 20 Oct 2023 17:28:48 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Su Hui <suhui@nfschina.com>
Cc:     Su Hui <suhui@nfschina.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        mst@redhat.com, jasowang@redhat.com
References: <20231020092320.209234-1-suhui@nfschina.com>
In-Reply-To: <20231020092320.209234-1-suhui@nfschina.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If any error happens, this function should restore to the old status.

So, whether the err is true, we should goto the virtqueue_enable_after_reset().

If the err is true, that mean the resize new quuee failed, but the queue
status has restored to the old status.

We should ignore the return value of the virtuqueue_resize_xxx().

Do you find other error in the virtuqueue_resize_xxx().

Thanks.


On Fri, 20 Oct 2023 17:23:21 +0800, Su Hui <suhui@nfschina.com> wrote:
> virtqueue_resize_packed() or virtqueue_resize_split() can return
> error code if failed, so add a check for this.
>
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>
> I'm not sure that return directly is right or not,
> maybe there are some process should do before return.
>
>  drivers/virtio/virtio_ring.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 51d8f3299c10..cf662c3a755b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2759,6 +2759,9 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>  	else
>  		err = virtqueue_resize_split(_vq, num);
>
> +	if (err)
> +		return err;
> +
>  	return virtqueue_enable_after_reset(_vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_resize);
> --
> 2.30.2
>
