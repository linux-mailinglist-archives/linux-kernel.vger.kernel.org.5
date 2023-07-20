Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FEE75A43D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 04:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjGTCGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 22:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjGTCGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 22:06:46 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DCA1FF9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 19:06:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vnnt3WB_1689818801;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vnnt3WB_1689818801)
          by smtp.aliyun-inc.com;
          Thu, 20 Jul 2023 10:06:42 +0800
Message-ID: <1689818793.8129647-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v1] virtio-pci: Fix legacy device flag setting error in probe
Date:   Thu, 20 Jul 2023 10:06:33 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Feng Liu <feliu@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Bodong Wang <bodong@nvidia.com>, Feng Liu <feliu@nvidia.com>,
        Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20230719154550.79536-1-feliu@nvidia.com>
In-Reply-To: <20230719154550.79536-1-feliu@nvidia.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 11:45:50 -0400, Feng Liu <feliu@nvidia.com> wrote:
> The 'is_legacy' flag is used to differentiate between legacy vs modern
> device. Currently, it is based on the value of vp_dev->ldev.ioaddr.
> However, due to the shared memory of the union between struct
> virtio_pci_legacy_device and struct virtio_pci_modern_device, when
> virtio_pci_modern_probe modifies the content of struct
> virtio_pci_modern_device, it affects the content of struct
> virtio_pci_legacy_device, and ldev.ioaddr is no longer zero, causing
> the 'is_legacy' flag to be set as true. To resolve issue, when legacy
> device is probed, mark 'is_legacy' as true, when modern device is
> probed, keep 'is_legacy' as false.
>
> Fixes: 4f0fc22534e3 ("virtio_pci: Optimize virtio_pci_device structure size")
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


> ---
>  drivers/virtio/virtio_pci_common.c | 2 --
>  drivers/virtio/virtio_pci_legacy.c | 1 +
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index a6c86f916dbd..c2524a7207cf 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -557,8 +557,6 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>
>  	pci_set_master(pci_dev);
>
> -	vp_dev->is_legacy = vp_dev->ldev.ioaddr ? true : false;
> -
>  	rc = register_virtio_device(&vp_dev->vdev);
>  	reg_dev = vp_dev;
>  	if (rc)
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 2257f1b3d8ae..d9cbb02b35a1 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -223,6 +223,7 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
>  	vp_dev->config_vector = vp_config_vector;
>  	vp_dev->setup_vq = setup_vq;
>  	vp_dev->del_vq = del_vq;
> +	vp_dev->is_legacy = true;
>
>  	return 0;
>  }
> --
> 2.37.1 (Apple Git-137.1)
>
