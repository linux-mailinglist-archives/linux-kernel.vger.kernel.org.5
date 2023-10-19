Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F0F7CFA38
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345806AbjJSNC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbjJSNCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:02:17 -0400
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com [47.90.199.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F9449F7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:59:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VuU3cJJ_1697720225;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VuU3cJJ_1697720225)
          by smtp.aliyun-inc.com;
          Thu, 19 Oct 2023 20:57:06 +0800
Message-ID: <1697720122.49851-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/2] virtio_pci: Don't make an extra copy of cpu affinity mask
Date:   Thu, 19 Oct 2023 20:55:22 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Caleb Raitto <caraitto@google.com>,
        virtualization@lists.linux-foundation.org
References: <20231019101625.412936-1-jakub@cloudflare.com>
In-Reply-To: <20231019101625.412936-1-jakub@cloudflare.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 12:16:24 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> Since commit 19e226e8cc5d ("virtio: Make vp_set_vq_affinity() take a
> mask.") it is actually not needed to have a local copy of the cpu mask.


Could you give more info to prove this?

If you are right, I think you should delete all code about msix_affinity_masks?

Thanks.

>
> Pass the cpu mask we got as argument to set the irq affinity hint.
>
> Cc: Caleb Raitto <caraitto@google.com>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index c2524a7207cf..8927bc338f06 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -433,21 +433,14 @@ int vp_set_vq_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
>  	struct virtio_device *vdev = vq->vdev;
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	struct virtio_pci_vq_info *info = vp_dev->vqs[vq->index];
> -	struct cpumask *mask;
>  	unsigned int irq;
>
>  	if (!vq->callback)
>  		return -EINVAL;
>
>  	if (vp_dev->msix_enabled) {
> -		mask = vp_dev->msix_affinity_masks[info->msix_vector];
>  		irq = pci_irq_vector(vp_dev->pci_dev, info->msix_vector);
> -		if (!cpu_mask)
> -			irq_set_affinity_hint(irq, NULL);
> -		else {
> -			cpumask_copy(mask, cpu_mask);
> -			irq_set_affinity_hint(irq, mask);
> -		}
> +		irq_set_affinity_hint(irq, cpu_mask);
>  	}
>  	return 0;
>  }
> --
> 2.41.0
>
