Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1AD7B71B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjJCT12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjJCT10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E019E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696361205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmvac0+nCBspSOw72OLLM3jxa5W06zS7d4a2x39A/5Y=;
        b=UdpsgcemvkTKy8VIx2ABhaecYJdvqGNMNWEbJOOBn6Ufv1m1evs8xK28qpAcKMuDsYcXNb
        XIiITy9mJ0l0r4V10xypGoOuH+a1URsM5gHd2DHHC8r4UkKnr4oNGHusGvVDDkyYA8Su8P
        vPidXDQSkh6m521Lks7B0T0TXVDZ0BI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-OJVCkBezM5m0IVY_cIrqbA-1; Tue, 03 Oct 2023 15:26:34 -0400
X-MC-Unique: OJVCkBezM5m0IVY_cIrqbA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-79f9edb0086so93035139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361193; x=1696965993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmvac0+nCBspSOw72OLLM3jxa5W06zS7d4a2x39A/5Y=;
        b=P4HXELye4RHTgDYOWC3H6fW3Ks1V1sghhcDGzAkRzHoQ6sieKcpveyUlyCLAVrQ/iG
         R8AR7pj3L7rcYioZWKkuVX72EIbOTNxXyMS8FXQ1fkHN2ts0hDqS4ZTWKoqo4LbiKGfN
         MkbG4nPSbT+UpxPBbGjAt4L2MLmzTcnsIOCbKENgQbjigaPhZ2FP4JHvVcEiHuvUPO8M
         6QwBFck1t7bpZzTZRBpFpNxWX9IOIU2EAFYFSH0hh34iMMOcTXPrTvlGlZaFn7CjmFju
         LysTFkGGDP9VUo8SX+4SyTgOvscBgICnoNhN3Uopehsow9eDQ4MMrYgDRlVDNOp00oe4
         Owgg==
X-Gm-Message-State: AOJu0Yz4JAXcDY+yDuqG9BhaYpnNitMGGnVhghkZbimzJW39/08qnHCZ
        ECsb8tDbp8CxHvwHldAIjWVdOQM37twfiv4WAzXBG0dj2xn5ukD3EL4xndrb/HoBqWINfDHej2O
        hRPPY269b4wRsRf7q6xLjDNce
X-Received: by 2002:a6b:7841:0:b0:79f:e99b:474a with SMTP id h1-20020a6b7841000000b0079fe99b474amr374161iop.18.1696361193571;
        Tue, 03 Oct 2023 12:26:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw5GOJ9DdPDIPQA+j2UtS4Rl3tEFK+LobJ6u7UTXBKHUJ0p795hvu0/5xmKkl6+KoH9oNqng==
X-Received: by 2002:a6b:7841:0:b0:79f:e99b:474a with SMTP id h1-20020a6b7841000000b0079fe99b474amr374144iop.18.1696361193234;
        Tue, 03 Oct 2023 12:26:33 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id g5-20020a0566380bc500b0042b6f103e62sm494092jad.133.2023.10.03.12.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:26:32 -0700 (PDT)
Date:   Tue, 3 Oct 2023 13:26:30 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <bcreeley@amd.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: Re: [PATCH v16 1/2] vfio/migration: Add debugfs to live migration
 driver
Message-ID: <20231003132630.764d9488.alex.williamson@redhat.com>
In-Reply-To: <20230926093356.56014-2-liulongfang@huawei.com>
References: <20230926093356.56014-1-liulongfang@huawei.com>
        <20230926093356.56014-2-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 26 Sep 2023 17:33:55 +0800
liulongfang <liulongfang@huawei.com> wrote:

> From: Longfang Liu <liulongfang@huawei.com>
> 
> There are multiple devices, software and operational steps involved
> in the process of live migration. An error occurred on any node may
> cause the live migration operation to fail.
> This complex process makes it very difficult to locate and analyze
> the cause when the function fails.
> 
> In order to quickly locate the cause of the problem when the
> live migration fails, I added a set of debugfs to the vfio
> live migration driver.
> 
>     +-------------------------------------------+
>     |                                           |
>     |                                           |
>     |                  QEMU                     |
>     |                                           |
>     |                                           |
>     +---+----------------------------+----------+
>         |      ^                     |      ^
>         |      |                     |      |
>         |      |                     |      |
>         v      |                     v      |
>      +---------+--+               +---------+--+
>      |src vfio_dev|               |dst vfio_dev|
>      +--+---------+               +--+---------+
>         |      ^                     |      ^
>         |      |                     |      |
>         v      |                     |      |
>    +-----------+----+           +-----------+----+
>    |src dev debugfs |           |dst dev debugfs |
>    +----------------+           +----------------+
> 
> The entire debugfs directory will be based on the definition of
> the CONFIG_DEBUG_FS macro. If this macro is not enabled, the
> interfaces in vfio.h will be empty definitions, and the creation
> and initialization of the debugfs directory will not be executed.
> 
>    vfio
>     |
>     +---<dev_name1>
>     |    +---migration
>     |        +--state
>     |
>     +---<dev_name2>
>          +---migration
>              +--state
> 
> debugfs will create a public root directory "vfio" file.
> then create a dev_name() file for each live migration device.
> First, create a unified state acquisition file of "migration"
> in this device directory.
> Then, create a public live migration state lookup file "state"
> Finally, create a directory file based on the device type,
> and then create the device's own debugging files under
> this directory file.

We don't actually do the thing claimed in this last statement.
 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/vfio/Makefile       |  1 +
>  drivers/vfio/vfio.h         | 14 ++++++
>  drivers/vfio/vfio_debugfs.c | 87 +++++++++++++++++++++++++++++++++++++
>  drivers/vfio/vfio_main.c    | 14 +++++-
>  include/linux/vfio.h        |  7 +++
>  5 files changed, 121 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/vfio/vfio_debugfs.c
> 
> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> index c82ea032d352..7934ac829989 100644
> --- a/drivers/vfio/Makefile
> +++ b/drivers/vfio/Makefile
> @@ -8,6 +8,7 @@ vfio-$(CONFIG_VFIO_GROUP) += group.o
>  vfio-$(CONFIG_IOMMUFD) += iommufd.o
>  vfio-$(CONFIG_VFIO_CONTAINER) += container.o
>  vfio-$(CONFIG_VFIO_VIRQFD) += virqfd.o
> +vfio-$(CONFIG_DEBUG_FS) += vfio_debugfs.o

I see that other subsystems create Kconfig entries allowing more fine
grained control of DEBUGFS support.  Wouldn't it make sense to have a
VFIO_DEBUGFS config option, similar to IOMMU_DEBUGFS?

Also, with our trend towards less redundant file naming, this could
just be debugfs.[co].

>  obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
>  obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 307e3f29b527..09b00757d0bb 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -448,4 +448,18 @@ static inline void vfio_device_put_kvm(struct vfio_device *device)
>  }
>  #endif
>  
> +#ifdef CONFIG_DEBUG_FS
> +void vfio_debugfs_create_root(void);
> +void vfio_debugfs_remove_root(void);
> +
> +void vfio_device_debugfs_init(struct vfio_device *vdev);
> +void vfio_device_debugfs_exit(struct vfio_device *vdev);
> +#else
> +static inline void vfio_debugfs_create_root(void) { }
> +static inline void vfio_debugfs_remove_root(void) { }
> +
> +static inline void vfio_device_debugfs_init(struct vfio_device *vdev) { }
> +static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { }
> +#endif /* CONFIG_DEBUG_FS */
> +
>  #endif
> diff --git a/drivers/vfio/vfio_debugfs.c b/drivers/vfio/vfio_debugfs.c
> new file mode 100644
> index 000000000000..b79bdef08357
> --- /dev/null
> +++ b/drivers/vfio/vfio_debugfs.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, HiSilicon Ltd.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +#include <linux/vfio.h>
> +#include "vfio.h"
> +
> +static struct dentry *vfio_debugfs_root;
> +
> +static int vfio_device_state_read(struct seq_file *seq, void *data)
> +{
> +	struct device *vf_dev = seq->private;
> +	struct vfio_device *vdev = container_of(vf_dev, struct vfio_device, device);
> +	enum vfio_device_mig_state state;
> +	int ret;
> +
> +	ret = vdev->mig_ops->migration_get_state(vdev, &state);
> +	if (ret)
> +		return -EINVAL;
> +
> +	switch (state) {
> +	case VFIO_DEVICE_STATE_STOP:
> +		seq_printf(seq, "%s\n", "STOP");
> +		break;
> +	case VFIO_DEVICE_STATE_RUNNING:
> +		seq_printf(seq, "%s\n", "RUNNING");
> +		break;
> +	case VFIO_DEVICE_STATE_STOP_COPY:
> +		seq_printf(seq, "%s\n", "STOP_COPY");
> +		break;
> +	case VFIO_DEVICE_STATE_RESUMING:
> +		seq_printf(seq, "%s\n", "RESUMING");
> +		break;
> +	case VFIO_DEVICE_STATE_RUNNING_P2P:
> +		seq_printf(seq, "%s\n", "RUNNING_P2P");
> +		break;
> +	case VFIO_DEVICE_STATE_PRE_COPY:
> +		seq_printf(seq, "%s\n", "PRE_COPY");
> +		break;
> +	case VFIO_DEVICE_STATE_PRE_COPY_P2P:
> +		seq_printf(seq, "%s\n", "PRE_COPY_P2P");
> +		break;
> +	case VFIO_DEVICE_STATE_ERROR:
             ^^^^^^^^^^^^^^^^^^^^^^^

> +		seq_printf(seq, "%s\n", "ERROR");
> +		break;
> +	default:
> +		seq_printf(seq, "%s\n", "Invalid");
> +	}

Not exactly in the order they're defined:

enum vfio_device_mig_state {
        VFIO_DEVICE_STATE_ERROR = 0,
        ^^^^^^^^^^^^^^^^^^^^^^^
        VFIO_DEVICE_STATE_STOP = 1,
        VFIO_DEVICE_STATE_RUNNING = 2,
	...

I also suggested last time some means to keep this in sync with the set
of states defined.  Maybe there are better suggestions, but one way to
do that could be:

diff --git a/drivers/vfio/vfio_debugfs.c b/drivers/vfio/vfio_debugfs.c
index ee6b1831b3e5..1ec90b90d150 100644
--- a/drivers/vfio/vfio_debugfs.c
+++ b/drivers/vfio/vfio_debugfs.c
@@ -18,6 +18,9 @@ static int vfio_device_state_read(struct seq_file *seq, void *data)
        enum vfio_device_mig_state state;
        int ret;
 
+       BUILD_BUG_ON(VFIO_DEVICE_STATE_NR !=
+                    VFIO_DEVICE_STATE_PRE_COPY_P2P + 1);
+
        ret = vdev->mig_ops->migration_get_state(vdev, &state);
        if (ret)
                return -EINVAL;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 7f5fb010226d..2b68e6cdf190 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1219,6 +1219,7 @@ enum vfio_device_mig_state {
        VFIO_DEVICE_STATE_RUNNING_P2P = 5,
        VFIO_DEVICE_STATE_PRE_COPY = 6,
        VFIO_DEVICE_STATE_PRE_COPY_P2P = 7,
+       VFIO_DEVICE_STATE_NR,
 };
 
 /**

Thanks,
Alex


> +
> +	return 0;
> +}
> +
> +void vfio_device_debugfs_init(struct vfio_device *vdev)
> +{
> +	struct device *dev = &vdev->device;
> +
> +	vdev->debug_root = debugfs_create_dir(dev_name(vdev->dev), vfio_debugfs_root);
> +
> +	if (vdev->mig_ops) {
> +		struct dentry *vfio_dev_migration = NULL;
> +
> +		vfio_dev_migration = debugfs_create_dir("migration", vdev->debug_root);
> +		debugfs_create_devm_seqfile(dev, "state", vfio_dev_migration,
> +					  vfio_device_state_read);
> +	}
> +}
> +
> +void vfio_device_debugfs_exit(struct vfio_device *vdev)
> +{
> +	debugfs_remove_recursive(vdev->debug_root);
> +}
> +
> +void vfio_debugfs_create_root(void)
> +{
> +	vfio_debugfs_root = debugfs_create_dir("vfio", NULL);
> +}
> +
> +void vfio_debugfs_remove_root(void)
> +{
> +	debugfs_remove_recursive(vfio_debugfs_root);
> +	vfio_debugfs_root = NULL;
> +}
> +
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index cfad824d9aa2..4e3ced20d2d1 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -309,7 +309,6 @@ static int __vfio_register_dev(struct vfio_device *device,
>  
>  	/* Refcounting can't start until the driver calls register */
>  	refcount_set(&device->refcount, 1);
> -
>  	vfio_device_group_register(device);
>  
>  	return 0;
> @@ -320,7 +319,15 @@ static int __vfio_register_dev(struct vfio_device *device,
>  
>  int vfio_register_group_dev(struct vfio_device *device)
>  {
> -	return __vfio_register_dev(device, VFIO_IOMMU);
> +	int ret;
> +
> +	ret = __vfio_register_dev(device, VFIO_IOMMU);
> +	if (ret)
> +		return ret;
> +
> +	vfio_device_debugfs_init(device);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(vfio_register_group_dev);
>  
> @@ -378,6 +385,7 @@ void vfio_unregister_group_dev(struct vfio_device *device)
>  		}
>  	}
>  
> +	vfio_device_debugfs_exit(device);
>  	/* Balances vfio_device_set_group in register path */
>  	vfio_device_remove_group(device);
>  }
> @@ -1662,6 +1670,7 @@ static int __init vfio_init(void)
>  	if (ret)
>  		goto err_alloc_dev_chrdev;
>  
> +	vfio_debugfs_create_root();
>  	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
>  	return 0;
>  
> @@ -1677,6 +1686,7 @@ static int __init vfio_init(void)
>  
>  static void __exit vfio_cleanup(void)
>  {
> +	vfio_debugfs_remove_root();
>  	ida_destroy(&vfio.device_ida);
>  	vfio_cdev_cleanup();
>  	class_destroy(vfio.device_class);
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 454e9295970c..769d7af86225 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -69,6 +69,13 @@ struct vfio_device {
>  	u8 iommufd_attached:1;
>  #endif
>  	u8 cdev_opened:1;
> +#ifdef CONFIG_DEBUG_FS
> +	/*
> +	 * debug_root is a static property of the vfio_device
> +	 * which must be set prior to registering the vfio_device.
> +	 */
> +	struct dentry *debug_root;
> +#endif
>  };
>  
>  /**

