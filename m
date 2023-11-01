Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E7B7DDAB0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377231AbjKABpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377306AbjKABpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:45:21 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EC5102
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 18:45:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VvIssn4_1698803110;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VvIssn4_1698803110)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 09:45:11 +0800
Message-ID: <1698803104.3925707-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_pci: move structure to a header
Date:   Wed, 1 Nov 2023 09:45:04 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <110d3058179284b092722827bef4f74f8ba0c622.1698769192.git.mst@redhat.com>
In-Reply-To: <110d3058179284b092722827bef4f74f8ba0c622.1698769192.git.mst@redhat.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 12:19:54 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> These are guest/host interfaces so belong in the header
> where e.g. qemu will know to find them.
> Note: we added a new structure as opposed to extending existing one
> because someone might be relying on the size of the existing structure
> staying unchanged.  Add a warning to avoid using sizeof.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/virtio/virtio_pci_modern_dev.c |  7 ++++---
>  include/linux/virtio_pci_modern.h      |  7 -------
>  include/uapi/linux/virtio_pci.h        | 11 +++++++++++
>  3 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index e2a1fe7bb66c..7de8b1ebabac 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -294,9 +294,10 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>
>  	err = -EINVAL;
>  	mdev->common = vp_modern_map_capability(mdev, common,
> -				      sizeof(struct virtio_pci_common_cfg), 4,
> -				      0, sizeof(struct virtio_pci_modern_common_cfg),
> -				      &mdev->common_len, NULL);
> +			      sizeof(struct virtio_pci_common_cfg), 4, 0,
> +			      offsetofend(struct virtio_pci_modern_common_cfg,
> +					  queue_reset),
> +			      &mdev->common_len, NULL);
>  	if (!mdev->common)
>  		goto err_map_common;
>  	mdev->isr = vp_modern_map_capability(mdev, isr, sizeof(u8), 1,
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index d0f2797420f7..a09e13a577a9 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -5,13 +5,6 @@
>  #include <linux/pci.h>
>  #include <linux/virtio_pci.h>
>
> -struct virtio_pci_modern_common_cfg {
> -	struct virtio_pci_common_cfg cfg;
> -
> -	__le16 queue_notify_data;	/* read-write */
> -	__le16 queue_reset;		/* read-write */
> -};
> -
>  /**
>   * struct virtio_pci_modern_device - info for modern PCI virtio
>   * @pci_dev:	    Ptr to the PCI device struct
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index f703afc7ad31..44f4dd2add18 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -166,6 +166,17 @@ struct virtio_pci_common_cfg {
>  	__le32 queue_used_hi;		/* read-write */
>  };
>
> +/*
> + * Warning: do not use sizeof on this: use offsetofend for
> + * specific fields you need.
> + */
> +struct virtio_pci_modern_common_cfg {
> +	struct virtio_pci_common_cfg cfg;
> +
> +	__le16 queue_notify_data;	/* read-write */
> +	__le16 queue_reset;		/* read-write */
> +};
> +
>  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
>  struct virtio_pci_cfg_cap {
>  	struct virtio_pci_cap cap;
> --
> MST
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
