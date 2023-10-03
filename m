Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623327B6A58
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbjJCNWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbjJCNWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:22:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD691A7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696339279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DsSmi/Zt5uME6pvWTbk/N7D0/KT5w+J1b0pUC4h/oVU=;
        b=WPl4+n1qBHhYJD4DGHLfhzq/oDcozTZCLKmBwASpBb7563/+pnxpaL4LAspI6W7QNoEOnB
        9505oDB4rZVbQIMFFyQmvGhJn+qHJ3RNwq45JbQxknj9kq2jHyYdIK+Qc5EgdnHDHtLjAy
        1YGx2fvEukyACtyPmuWx40K315iYRi8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-n2zzl4W7N8Wrk30mvTR-SQ-1; Tue, 03 Oct 2023 09:21:18 -0400
X-MC-Unique: n2zzl4W7N8Wrk30mvTR-SQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3249655593dso783251f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 06:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696339277; x=1696944077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsSmi/Zt5uME6pvWTbk/N7D0/KT5w+J1b0pUC4h/oVU=;
        b=mULUgTZqN4tB2HVnb9+B0fCICkJn03LG4PScVCKxef0y2hJ5oDCspLXWVSLO8oGtPp
         CC/wchmgdNACHfdM5HAEfwMc6BymrwJkGvGmiKqCDkp8nmO5TPfTmmul3W95GycSv+43
         6PNNID4S2gNiiCv+DlJz/XSw6dkfcZxhZsTiQKgE5aBZ0I2ZHtYJC/LQ1r91FT/pYF2l
         I1dXtkS111wj4NlJZXYtnARdEp8NUGZxxCLOfv2vJzBHP4GygKpOywKzRaI36DwQHaTY
         tcbz+ZtVaL7EFG2LK6BFUXgvbZoaJW5n7yn8bmPRF4R1v7NmvbtEiwN/9ldBRlQMfsTw
         84WA==
X-Gm-Message-State: AOJu0Yww3/PB+miVP8BaquEQnSeYElAtTfzUnozMY2SpmA/txTOZvUjP
        XA8iao/I7s9ScVjNyOFt8TPvn5gpN3p/OyQTkAn8NZd0sB3tGn9YyA7VyqSGIEtXLoflMO4g8Go
        lqGm7gAflD+ybEGN+uiNFYaWF
X-Received: by 2002:a5d:568e:0:b0:321:5d9f:2d9f with SMTP id f14-20020a5d568e000000b003215d9f2d9fmr12401805wrv.47.1696339276762;
        Tue, 03 Oct 2023 06:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8jHDDQmTthN89Peo1PU8EJm/OLgNDz81/4SvjYgSZiWjXE3UuxBzNPv1BWoXgEuGYxf3wJg==
X-Received: by 2002:a5d:568e:0:b0:321:5d9f:2d9f with SMTP id f14-20020a5d568e000000b003215d9f2d9fmr12401757wrv.47.1696339276284;
        Tue, 03 Oct 2023 06:21:16 -0700 (PDT)
Received: from redhat.com ([2.52.132.27])
        by smtp.gmail.com with ESMTPSA id j17-20020a5d5651000000b0031f82743e25sm1569843wrw.67.2023.10.03.06.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 06:21:15 -0700 (PDT)
Date:   Tue, 3 Oct 2023 09:20:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jiqian Chen <Jiqian.Chen@amd.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        qemu-devel@nongnu.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        Honglei Huang <Honglei1.Huang@amd.com>,
        Julia Zhang <Julia.Zhang@amd.com>,
        Huang Rui <Ray.Huang@amd.com>
Subject: Re: [LINUX KERNEL PATCH v5 1/2] virtio_pci: Add freeze_mode for
 virtio_pci_common_cfg
Message-ID: <20231003091644-mutt-send-email-mst@kernel.org>
References: <20230919104607.2282248-1-Jiqian.Chen@amd.com>
 <20230919104607.2282248-2-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919104607.2282248-2-Jiqian.Chen@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 06:46:06PM +0800, Jiqian Chen wrote:
> When guest vm does S3, Qemu will reset and clear some things of virtio
> devices, but guest can't aware that, so that may cause some problems.
> For excample, Qemu calls virtio_reset->virtio_gpu_gl_reset, that will
> destroy render resources of virtio-gpu. As a result, after guest resume,
> the display can't come back and we only saw a black screen. Due to guest
> can't re-create all the resources, so we need to let Qemu not to destroy
> them when S3.
> 
> For above purpose, this patch add a new parameter named freeze_mode to
> struct virtio_pci_common_cfg, and when guest suspends, it can set
> freeze_mode to be FREEZE_S3, so that virtio devices can change their
> reset behavior on Qemu side according to that mode.
> 
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
>  drivers/virtio/virtio.c                | 13 +++++++++++++
>  drivers/virtio/virtio_pci_modern.c     |  9 +++++++++
>  drivers/virtio/virtio_pci_modern_dev.c | 16 ++++++++++++++++
>  include/linux/virtio_config.h          |  1 +
>  include/linux/virtio_pci_modern.h      |  2 ++
>  include/uapi/linux/virtio_pci.h        | 16 ++++++++++++++--
>  6 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 3893dc29eb26..b4eb8369d5a1 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -7,6 +7,7 @@
>  #include <linux/idr.h>
>  #include <linux/of.h>
>  #include <uapi/linux/virtio_ids.h>
> +#include <uapi/linux/virtio_pci.h>
>  
>  /* Unique numbering for virtio devices. */
>  static DEFINE_IDA(virtio_index_ida);
> @@ -486,10 +487,20 @@ void unregister_virtio_device(struct virtio_device *dev)
>  EXPORT_SYMBOL_GPL(unregister_virtio_device);
>  
>  #ifdef CONFIG_PM_SLEEP
> +static void virtio_set_freeze_mode(struct virtio_device *dev, u16 mode)
> +{
> +	if (!dev->config->set_freeze_mode)
> +		return;
> +	might_sleep();
> +	dev->config->set_freeze_mode(dev, mode);
> +}
> +
>  int virtio_device_freeze(struct virtio_device *dev)
>  {
>  	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>  
> +	virtio_set_freeze_mode(dev, VIRTIO_PCI_FREEZE_MODE_FREEZE_S3);
> +
>  	virtio_config_disable(dev);
>  
>  	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
> @@ -544,6 +555,8 @@ int virtio_device_restore(struct virtio_device *dev)
>  
>  	virtio_config_enable(dev);
>  
> +	virtio_set_freeze_mode(dev, VIRTIO_PCI_FREEZE_MODE_UNFREEZE);
> +
>  	return 0;
>  
>  err:
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index d6bb68ba84e5..846b70919cbd 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -491,6 +491,13 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
>  	return true;
>  }
>  
> +static void vp_set_freeze_mode(struct virtio_device *vdev, u16 mode)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +
> +	vp_modern_set_freeze_mode(&vp_dev->mdev, mode);
> +}
> +
>  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.get		= NULL,
>  	.set		= NULL,
> @@ -509,6 +516,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.get_shm_region  = vp_get_shm_region,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> +	.set_freeze_mode = vp_set_freeze_mode,
>  };
>  
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> @@ -529,6 +537,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.get_shm_region  = vp_get_shm_region,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> +	.set_freeze_mode = vp_set_freeze_mode,
>  };
>  
>  /* the PCI probing function */
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index aad7d9296e77..4a6f7d130b6e 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -203,6 +203,8 @@ static inline void check_offsets(void)
>  		     offsetof(struct virtio_pci_common_cfg, queue_used_lo));
>  	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_USEDHI !=
>  		     offsetof(struct virtio_pci_common_cfg, queue_used_hi));
> +	BUILD_BUG_ON(VIRTIO_PCI_COMMON_F_MODE !=
> +		     offsetof(struct virtio_pci_common_cfg, freeze_mode));
>  }
>  
>  /*
> @@ -714,6 +716,20 @@ void __iomem *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
>  }
>  EXPORT_SYMBOL_GPL(vp_modern_map_vq_notify);
>  
> +/*
> + * vp_modern_set_freeze_mode - set freeze mode to device
> + * @mdev: the modern virtio-pci device
> + * @mode: the mode set to device
> + */
> +void vp_modern_set_freeze_mode(struct virtio_pci_modern_device *mdev,
> +				 u16 mode)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +
> +	vp_iowrite16(mode, &cfg->freeze_mode);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_set_freeze_mode);
> +
>  MODULE_VERSION("0.1");
>  MODULE_DESCRIPTION("Modern Virtio PCI Device");
>  MODULE_AUTHOR("Jason Wang <jasowang@redhat.com>");
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 2b3438de2c4d..2a7443ff7f12 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -120,6 +120,7 @@ struct virtio_config_ops {
>  			       struct virtio_shm_region *region, u8 id);
>  	int (*disable_vq_and_reset)(struct virtqueue *vq);
>  	int (*enable_vq_after_reset)(struct virtqueue *vq);
> +	void (*set_freeze_mode)(struct virtio_device *vdev, u16 mode);
>  };
>  
>  /* If driver didn't advertise the feature, it will never appear. */
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index 067ac1d789bc..ba6eed216ded 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -121,4 +121,6 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev);
>  void vp_modern_remove(struct virtio_pci_modern_device *mdev);
>  int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
>  void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
> +void vp_modern_set_freeze_mode(struct virtio_pci_modern_device *mdev,
> +		   u16 mode);
>  #endif
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index f703afc7ad31..725ace458a1b 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -140,6 +140,15 @@ struct virtio_pci_notify_cap {
>  	__le32 notify_off_multiplier;	/* Multiplier for queue_notify_off. */
>  };
>  
> +typedef enum {
> +       VIRTIO_PCI_FREEZE_MODE_UNFREEZE = 0,
> +       VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 = 3,
> +} virtio_pci_freeze_mode_t;

we don't normally do typedefs.

> +
> +#define VIRTIO_PCI_FREEZE_MODE_MASK \
> +	((1 << VIRTIO_PCI_FREEZE_MODE_UNFREEZE) | \
> +	(1 << VIRTIO_PCI_FREEZE_MODE_FREEZE_S3))
> +

not sure why is this useful generally.

>  /* Fields in VIRTIO_PCI_CAP_COMMON_CFG: */
>  struct virtio_pci_common_cfg {
>  	/* About the whole device. */
> @@ -164,6 +173,8 @@ struct virtio_pci_common_cfg {
>  	__le32 queue_avail_hi;		/* read-write */
>  	__le32 queue_used_lo;		/* read-write */
>  	__le32 queue_used_hi;		/* read-write */
> +
> +	__le16 freeze_mode;		/* read-write */
>  };
>

Your patch will likely break uses of sizeof(struct virtio_pci_common_cfg)
on existing devices.
  
>  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
> @@ -202,8 +213,9 @@ struct virtio_pci_cfg_cap {
>  #define VIRTIO_PCI_COMMON_Q_AVAILHI	44
>  #define VIRTIO_PCI_COMMON_Q_USEDLO	48
>  #define VIRTIO_PCI_COMMON_Q_USEDHI	52
> -#define VIRTIO_PCI_COMMON_Q_NDATA	56
> -#define VIRTIO_PCI_COMMON_Q_RESET	58
> +#define VIRTIO_PCI_COMMON_F_MODE	56


F_ here stands for freeze? Please don't abbreviate.
Q for queue is a pun that works, F for freeze doesn't.


> +#define VIRTIO_PCI_COMMON_Q_NDATA	58
> +#define VIRTIO_PCI_COMMON_Q_RESET	60
>  
>  #endif /* VIRTIO_PCI_NO_MODERN */
>  
> -- 
> 2.34.1

