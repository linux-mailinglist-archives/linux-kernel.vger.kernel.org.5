Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF837D7B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 05:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjJZDg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 23:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZDgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 23:36:25 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA10A3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 20:36:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VuwQJX._1698291378;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VuwQJX._1698291378)
          by smtp.aliyun-inc.com;
          Thu, 26 Oct 2023 11:36:18 +0800
Message-ID: <1698291366.898542-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2] virtio_pci: Switch away from deprecated irq_set_affinity_hint
Date:   Thu, 26 Oct 2023 11:36:06 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com,
        virtualization@lists.linux-foundation.org
References: <20231025145319.380775-1-jakub@cloudflare.com>
In-Reply-To: <20231025145319.380775-1-jakub@cloudflare.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 16:53:19 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> Since commit 65c7cdedeb30 ("genirq: Provide new interfaces for affinity
> hints") irq_set_affinity_hint is being phased out.
>
> Switch to new interfaces for setting and applying irq affinity hints.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks.

> ---
> v2:
>  - Leave cpumask_copy as is. We can't pass pointer to stack memory as hint.
>    Proposed a change to IRQ affinity interface to address this limitation:
>    https://lore.kernel.org/r/20231025141517.375378-1-jakub@cloudflare.com
>
> v1: https://lore.kernel.org/r/20231019101625.412936-2-jakub@cloudflare.com
> ---
>  drivers/virtio/virtio_pci_common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index c2524a7207cf..7a5593997e0e 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -242,7 +242,7 @@ void vp_del_vqs(struct virtio_device *vdev)
>  			if (v != VIRTIO_MSI_NO_VECTOR) {
>  				int irq = pci_irq_vector(vp_dev->pci_dev, v);
>
> -				irq_set_affinity_hint(irq, NULL);
> +				irq_update_affinity_hint(irq, NULL);
>  				free_irq(irq, vq);
>  			}
>  		}
> @@ -443,10 +443,10 @@ int vp_set_vq_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
>  		mask = vp_dev->msix_affinity_masks[info->msix_vector];
>  		irq = pci_irq_vector(vp_dev->pci_dev, info->msix_vector);
>  		if (!cpu_mask)
> -			irq_set_affinity_hint(irq, NULL);
> +			irq_update_affinity_hint(irq, NULL);
>  		else {
>  			cpumask_copy(mask, cpu_mask);
> -			irq_set_affinity_hint(irq, mask);
> +			irq_set_affinity_and_hint(irq, mask);
>  		}
>  	}
>  	return 0;
> --
> 2.41.0
>
