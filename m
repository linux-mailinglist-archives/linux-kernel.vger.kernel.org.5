Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE3B7DB39F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjJ3GlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjJ3GlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:41:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40FBFA
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698647985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5nyjgS0fYQSx/D6IewuJYJKpefagBoQYUrzFE3HJwSY=;
        b=c0JKXf1XNYdZBD54SIInBrEimKqKNX1GM4Np6PyR5+LdsZrBd6kpfJc0XrbSDS7GNTHapq
        SYnESGlbGRiU3aVNaiG3zz8A/C9VZFNS0uOnnp9CMn9W9VLOYw7MZP6SwEMKApowAwsAnl
        843iMCUbZf+fV504MoIqwdQSb94hE3Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-Sa0GpomiOSiIcNA2zBgDCA-1; Mon, 30 Oct 2023 02:39:43 -0400
X-MC-Unique: Sa0GpomiOSiIcNA2zBgDCA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-778999c5f1dso546823485a.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698647983; x=1699252783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5nyjgS0fYQSx/D6IewuJYJKpefagBoQYUrzFE3HJwSY=;
        b=Cz44MnY6GPfRUXKP/16lBlBs4ggamHX0L0wwLnFcrti6qUd46w3LUDkp/4bg+mbmTz
         0NbizyUK4/G4kkp2zfXXaq0QY7DdBPgI8lIfTSnVv25JgdhFxZJgN+bRjBs8CZbJSHEF
         8RLMFnEA7pzHhI+qN1bJrHCYxzraV8jH5I6Q40uO2ubkVPsyd49vvUm/hOf1Dek26H2b
         jIdWW9a2xhD5wqUjJ5LrQJd6fFXAjS5XI0m6fQMgwA2piKcdGRrgzWTwygxv2thqB5r0
         hSICHZkq/WlKPmvUzvTHHZ8V44Uz5AKzwlPKApymb8SSKG9+CNVBttNwcxWDI57OBgiH
         LoIw==
X-Gm-Message-State: AOJu0YyJgLNMyuVqnn9L284oj5i+mWM1N4LM12cZ8p+8VUNJiUaIvi0B
        BoTd0a68YJLAidNSQ6qcDoT9ZxjPMG2G7OVQACQJOmUskpF+CdfADF9Wd3E2/guKHLvN5KWUE91
        Sbfvs9Y+IUBMAeRjwoUGr85xY
X-Received: by 2002:a05:620a:284a:b0:774:3581:588f with SMTP id h10-20020a05620a284a00b007743581588fmr10211184qkp.53.1698647982943;
        Sun, 29 Oct 2023 23:39:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbHw2zXdgTmOe2Ipypz0FWeothc3gJE844cZo0OJypubB7AFZMaV4V7mlETkwq0DTLZNfoTw==
X-Received: by 2002:a05:620a:284a:b0:774:3581:588f with SMTP id h10-20020a05620a284a00b007743581588fmr10211165qkp.53.1698647982600;
        Sun, 29 Oct 2023 23:39:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0? ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
        by smtp.gmail.com with ESMTPSA id e22-20020a05620a209600b007756d233fbdsm3088023qka.37.2023.10.29.23.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 23:39:42 -0700 (PDT)
Message-ID: <365845dd-ffc4-4a0d-b5cd-622e18ae9eef@redhat.com>
Date:   Mon, 30 Oct 2023 07:39:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 1/2] vfio/migration: Add debugfs to live migration
 driver
Content-Language: en-US
To:     Longfang Liu <liulongfang@huawei.com>, alex.williamson@redhat.com,
        jgg@nvidia.com, shameerali.kolothum.thodi@huawei.com,
        jonathan.cameron@huawei.com
Cc:     bcreeley@amd.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
References: <20231028075447.41939-1-liulongfang@huawei.com>
 <20231028075447.41939-2-liulongfang@huawei.com>
From:   =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20231028075447.41939-2-liulongfang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/23 09:54, Longfang Liu wrote:
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
>      +-------------------------------------------+
>      |                                           |
>      |                                           |
>      |                  QEMU                     |
>      |                                           |
>      |                                           |
>      +---+----------------------------+----------+
>          |      ^                     |      ^
>          |      |                     |      |
>          |      |                     |      |
>          v      |                     v      |
>       +---------+--+               +---------+--+
>       |src vfio_dev|               |dst vfio_dev|
>       +--+---------+               +--+---------+
>          |      ^                     |      ^
>          |      |                     |      |
>          v      |                     |      |
>     +-----------+----+           +-----------+----+
>     |src dev debugfs |           |dst dev debugfs |
>     +----------------+           +----------------+
> 
> The entire debugfs directory will be based on the definition of
> the CONFIG_DEBUG_FS macro. If this macro is not enabled, the
> interfaces in vfio.h will be empty definitions, and the creation
> and initialization of the debugfs directory will not be executed.
> 
>     vfio
>      |
>      +---<dev_name1>
>      |    +---migration
>      |        +--state
>      |
>      +---<dev_name2>
>           +---migration
>               +--state
> 
> debugfs will create a public root directory "vfio" file.
> then create a dev_name() file for each live migration device.
> First, create a unified state acquisition file of "migration"
> in this device directory.
> Then, create a public live migration state lookup file "state".
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   drivers/vfio/Kconfig      | 10 +++++
>   drivers/vfio/Makefile     |  1 +
>   drivers/vfio/debugfs.c    | 90 +++++++++++++++++++++++++++++++++++++++
>   drivers/vfio/vfio.h       | 14 ++++++
>   drivers/vfio/vfio_main.c  |  4 ++
>   include/linux/vfio.h      |  7 +++
>   include/uapi/linux/vfio.h |  1 +
>   7 files changed, 127 insertions(+)
>   create mode 100644 drivers/vfio/debugfs.c
> 
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index 6bda6dbb4878..ceae52fd7586 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -80,6 +80,16 @@ config VFIO_VIRQFD
>   	select EVENTFD
>   	default n
>   
> +config VFIO_DEBUGFS
> +	bool "Export VFIO internals in DebugFS"
> +	depends on DEBUG_FS
> +	help
> +	  Allows exposure of VFIO device internals. This option enables
> +	  the use of debugfs by VFIO drivers as required. The device can
> +	  cause the VFIO code create a top-level debug/vfio directory
> +	  during initialization, and then populate a subdirectory with
> +	  entries as required.
> +
>   source "drivers/vfio/pci/Kconfig"
>   source "drivers/vfio/platform/Kconfig"
>   source "drivers/vfio/mdev/Kconfig"
> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> index c82ea032d352..d43a699d55b1 100644
> --- a/drivers/vfio/Makefile
> +++ b/drivers/vfio/Makefile
> @@ -8,6 +8,7 @@ vfio-$(CONFIG_VFIO_GROUP) += group.o
>   vfio-$(CONFIG_IOMMUFD) += iommufd.o
>   vfio-$(CONFIG_VFIO_CONTAINER) += container.o
>   vfio-$(CONFIG_VFIO_VIRQFD) += virqfd.o
> +vfio-$(CONFIG_VFIO_DEBUGFS) += debugfs.o
>   
>   obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
>   obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o
> diff --git a/drivers/vfio/debugfs.c b/drivers/vfio/debugfs.c
> new file mode 100644
> index 000000000000..9f02ae15e084
> --- /dev/null
> +++ b/drivers/vfio/debugfs.c
> @@ -0,0 +1,90 @@
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
> +	BUILD_BUG_ON(VFIO_DEVICE_STATE_NR !=
> +		VFIO_DEVICE_STATE_PRE_COPY_P2P + 1);
> +
> +	ret = vdev->mig_ops->migration_get_state(vdev, &state);
> +	if (ret)
> +		return -EINVAL;
> +
> +	switch (state) {
> +	case VFIO_DEVICE_STATE_ERROR:
> +		seq_puts(seq, "ERROR\n");
> +		break;
> +	case VFIO_DEVICE_STATE_STOP:
> +		seq_puts(seq, "STOP\n");
> +		break;
> +	case VFIO_DEVICE_STATE_RUNNING:
> +		seq_puts(seq, "RUNNING\n");
> +		break;
> +	case VFIO_DEVICE_STATE_STOP_COPY:
> +		seq_puts(seq, "STOP_COPY\n");
> +		break;
> +	case VFIO_DEVICE_STATE_RESUMING:
> +		seq_puts(seq, "RESUMING\n");
> +		break;
> +	case VFIO_DEVICE_STATE_RUNNING_P2P:
> +		seq_puts(seq, "RUNNING_P2P\n");
> +		break;
> +	case VFIO_DEVICE_STATE_PRE_COPY:
> +		seq_puts(seq, "PRE_COPY\n");
> +		break;
> +	case VFIO_DEVICE_STATE_PRE_COPY_P2P:
> +		seq_puts(seq, "PRE_COPY_P2P\n");
> +		break;
> +	default:
> +		seq_puts(seq, "Invalid\n");
> +	}
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
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 307e3f29b527..bde84ad344e5 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -448,4 +448,18 @@ static inline void vfio_device_put_kvm(struct vfio_device *device)
>   }
>   #endif
>   
> +#ifdef CONFIG_VFIO_DEBUGFS
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
> +#endif /* CONFIG_VFIO_DEBUGFS */
> +
>   #endif
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index e31e1952d7b8..94f02b6891ac 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -311,6 +311,7 @@ static int __vfio_register_dev(struct vfio_device *device,
>   	refcount_set(&device->refcount, 1);
>   
>   	vfio_device_group_register(device);
> +	vfio_device_debugfs_init(device);
>   
>   	return 0;
>   err_out:
> @@ -378,6 +379,7 @@ void vfio_unregister_group_dev(struct vfio_device *device)
>   		}
>   	}
>   
> +	vfio_device_debugfs_exit(device);
>   	/* Balances vfio_device_set_group in register path */
>   	vfio_device_remove_group(device);
>   }
> @@ -1676,6 +1678,7 @@ static int __init vfio_init(void)
>   	if (ret)
>   		goto err_alloc_dev_chrdev;
>   
> +	vfio_debugfs_create_root();
>   	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
>   	return 0;
>   
> @@ -1691,6 +1694,7 @@ static int __init vfio_init(void)
>   
>   static void __exit vfio_cleanup(void)
>   {
> +	vfio_debugfs_remove_root();
>   	ida_destroy(&vfio.device_ida);
>   	vfio_cdev_cleanup();
>   	class_destroy(vfio.device_class);
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 454e9295970c..769d7af86225 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -69,6 +69,13 @@ struct vfio_device {
>   	u8 iommufd_attached:1;
>   #endif
>   	u8 cdev_opened:1;
> +#ifdef CONFIG_DEBUG_FS
> +	/*
> +	 * debug_root is a static property of the vfio_device
> +	 * which must be set prior to registering the vfio_device.
> +	 */
> +	struct dentry *debug_root;
> +#endif
>   };
>   
>   /**
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 7f5fb010226d..2b68e6cdf190 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1219,6 +1219,7 @@ enum vfio_device_mig_state {
>   	VFIO_DEVICE_STATE_RUNNING_P2P = 5,
>   	VFIO_DEVICE_STATE_PRE_COPY = 6,
>   	VFIO_DEVICE_STATE_PRE_COPY_P2P = 7,
> +	VFIO_DEVICE_STATE_NR,
>   };
>   
>   /**

