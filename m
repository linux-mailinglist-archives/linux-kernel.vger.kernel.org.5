Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD7E7583B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjGRRqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGRRqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14902170F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689702312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RWC6ADV50O55tl91IYOjtEy8ajvZy/YtOVN1kKlnYVU=;
        b=LXB3gDdNQ55ROLA9SZQS23Xq9lrnkJUBu4uBQ62TQtA4luoJIHphL14EYs0+bkTE73w00z
        S5zoHpF9lEYWGb3DFaZ8n0m9L93x8bkTkusV2C7tYwS3OG/z/h3MX5KUQc2AUXI5WVNT9m
        WkJnuNFndf2Fop5H1FvpK/EYL4DcAos=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-_jfqWgYVMYeB-S8dsMdp0Q-1; Tue, 18 Jul 2023 13:45:09 -0400
X-MC-Unique: _jfqWgYVMYeB-S8dsMdp0Q-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a3c76a8accso9821827b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689702309; x=1690307109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWC6ADV50O55tl91IYOjtEy8ajvZy/YtOVN1kKlnYVU=;
        b=e2h0ZSvhzSlXBunNZ+cphlyn49cQaoA6b4QgK7Wa9DgzuaAiE3bXu7xtlOHW3lZq4v
         wOqQOZ1zwzypzNNJ5uftjH27z5/MOpEKohiwdhCul0CU8zSYXvpEVhTPQpBZwT1amTSZ
         ZeyVjLBvPHfQ9bp25uu3j0IcP7XhTUMfZ9V8xneWs+z6fuIIMvBBRLVboFoOIpeLmp7V
         MN+pJI097lhWr3KmhmMaMppS52ohtpx5eQQspmj/CN8Q58NtbFDqss/M8Fxa8jL1p2nN
         Ylrdx+9HgJvNPErs3rzMUNQrVz99GDkIToqYqlyxiaZ3eqbRf0NfmZHdIMtXbSaGlcYU
         Mm1A==
X-Gm-Message-State: ABy/qLatzEYXi6cg63wSG8NiYSQQjeaO9MljhRxtk5EryfNjbLh/TZCK
        7mB4m6AnluIC3HKcgqjGvU0mQ1V3wOMcvfqRk1I3fiQjmPvOTYAblkbGsL8QImK22rxeU1hzFaP
        EDbx9lxpykmFk7+u+oFHDFzWb
X-Received: by 2002:a05:6808:1310:b0:3a3:53a0:9d2 with SMTP id y16-20020a056808131000b003a353a009d2mr18493227oiv.28.1689702308723;
        Tue, 18 Jul 2023 10:45:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFba39XA9gMhNRK0VAu/Vn73y/n8L6hNRVIdj7i1QE66wlB+gBJaracUCyGV2MUegBiRVShfQ==
X-Received: by 2002:a05:6808:1310:b0:3a3:53a0:9d2 with SMTP id y16-20020a056808131000b003a353a009d2mr18493206oiv.28.1689702308466;
        Tue, 18 Jul 2023 10:45:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4? ([2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4])
        by smtp.gmail.com with ESMTPSA id m18-20020ae9e712000000b0076825e43d98sm735620qka.125.2023.07.18.10.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 10:45:08 -0700 (PDT)
Message-ID: <04b41307-b1a9-62d0-4996-a8c655b46892@redhat.com>
Date:   Tue, 18 Jul 2023 19:45:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v11 1/4] vfio/migration: Add debugfs to live migration
 driver
Content-Language: en-US
To:     liulongfang <liulongfang@huawei.com>, alex.williamson@redhat.com,
        jgg@nvidia.com, shameerali.kolothum.thodi@huawei.com,
        jonathan.cameron@huawei.com
Cc:     cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linuxarm@openeuler.org
References: <20230630092457.54902-1-liulongfang@huawei.com>
 <20230630092457.54902-2-liulongfang@huawei.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230630092457.54902-2-liulongfang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/23 11:24, liulongfang wrote:
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
>      |        +--hisi_acc
>      |            +--attr
>      |            +--data
>      |            +--save
>      |            +--io_test
>      |
>      +---<dev_name2>
>           +---migration
>               +--state
>               +--hisi_acc
>                   +--attr
>                   +--data
>                   +--save
>                   +--io_test
> 
> debugfs will create a public root directory "vfio" file.
> then create a dev_name() file for each live migration device.
> First, create a unified state acquisition file of "migration"
> in this device directory.
> Then, create a public live migration state lookup file "state"
> Finally, create a directory file based on the device type,
> and then create the device's own debugging files under
> this directory file.
> 
> Here, HiSilicon accelerator creates three debug files:
> attr: used to export the attribute parameters of the
> current live migration device.
> data: used to export the live migration data of the current
> live migration device.
> save: used to read the current live migration device's data
> and save it to the driver.
> io_test: used to test the IO read and write for the driver.
> 
> The live migration function of the current device can be tested by
> operating the debug files, and the functional status of the equipment
> and software at each stage can be tested step by step without
> performing the complete live migration function. And after the live
> migration is performed, the migration device data of the live migration
> can be obtained through the debug files.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>   drivers/vfio/Makefile       |  1 +
>   drivers/vfio/vfio.h         | 14 +++++++
>   drivers/vfio/vfio_debugfs.c | 78 +++++++++++++++++++++++++++++++++++++
>   drivers/vfio/vfio_main.c    |  9 ++++-
>   include/linux/vfio.h        |  7 ++++
>   5 files changed, 108 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/vfio/vfio_debugfs.c
> 
> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> index 66f418aef5a9..6829c58210dc 100644
> --- a/drivers/vfio/Makefile
> +++ b/drivers/vfio/Makefile
> @@ -7,6 +7,7 @@ vfio-y += vfio_main.o \
>   vfio-$(CONFIG_IOMMUFD) += iommufd.o
>   vfio-$(CONFIG_VFIO_CONTAINER) += container.o
>   vfio-$(CONFIG_VFIO_VIRQFD) += virqfd.o
> +vfio-$(CONFIG_DEBUG_FS) += vfio_debugfs.o
>   
>   obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
>   obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 7b19c621e0e6..729c52ef579a 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -264,4 +264,18 @@ static inline void vfio_device_put_kvm(struct vfio_device *device)
>   }
>   #endif
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
>   #endif
> diff --git a/drivers/vfio/vfio_debugfs.c b/drivers/vfio/vfio_debugfs.c
> new file mode 100644
> index 000000000000..7bff30f76bd9
> --- /dev/null
> +++ b/drivers/vfio/vfio_debugfs.c
> @@ -0,0 +1,78 @@
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

This could be external to all VFIO. See comment below.
  
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
> +	case VFIO_DEVICE_STATE_RUNNING:
> +		seq_printf(seq, "%s\n", "RUNNING");
> +		break;
> +	case VFIO_DEVICE_STATE_STOP_COPY:
> +		seq_printf(seq, "%s\n", "STOP_COPY");
> +		break;
> +	case VFIO_DEVICE_STATE_STOP:
> +		seq_printf(seq, "%s\n", "STOP");
> +		break;
> +	case VFIO_DEVICE_STATE_RESUMING:
> +		seq_printf(seq, "%s\n", "RESUMING");
> +		break;
> +	case VFIO_DEVICE_STATE_RUNNING_P2P:
> +		seq_printf(seq, "%s\n", "RESUMING_P2P");
> +		break;
> +	case VFIO_DEVICE_STATE_ERROR:
> +		seq_printf(seq, "%s\n", "ERROR");
> +		break;
> +	default:
> +		seq_printf(seq, "%s\n", "Invalid");
> +	}
> +
> +	return 0;
> +}
> +
> +void vfio_device_debugfs_init(struct vfio_device *vdev)
> +{
> +	struct dentry *vfio_dev_migration = NULL;
> +	struct device *dev = &vdev->device;
> +
> +	vdev->debug_root = debugfs_create_dir(dev_name(vdev->dev), vfio_debugfs_root);
> +	vfio_dev_migration = debugfs_create_dir("migration", vdev->debug_root);
> +
> +	debugfs_create_devm_seqfile(dev, "state", vfio_dev_migration,
> +				  vfio_device_state_read);
> +}
> +
> +void vfio_device_debugfs_exit(struct vfio_device *vdev)
> +{
> +	debugfs_remove_recursive(vdev->debug_root);
> +}

I would simply use :

	if (IS_ENABLED(CONFIG_DEBUG_FS))
		debugfs_remove_recursive(vdev->debug_root);

where vfio_device_debugfs_exit() is called.

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
ditto.

> +}
> +
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index f0ca33b2e1df..18d050ec9a12 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -282,7 +282,8 @@ static int __vfio_register_dev(struct vfio_device *device,
>   
>   	/* Refcounting can't start until the driver calls register */
>   	refcount_set(&device->refcount, 1);
> -
> +	if (device->mig_ops)
> +		vfio_device_debugfs_init(device);

I think we should prepare ground for more debugfs files than just migration
related things. Migration is clearly a very good candidate, but there could
be more. I have a couple out of tree patches to collect statistics on VMA
usage and resets for instance which could be included.


Thanks,

C.

>   	vfio_device_group_register(device);
>   
>   	return 0;
> @@ -339,6 +340,8 @@ void vfio_unregister_group_dev(struct vfio_device *device)
>   		}
>   	}
>   
> +	if (device->mig_ops)
> +		vfio_device_debugfs_exit(device);
>   	vfio_device_group_unregister(device);
>   
>   	/* Balances device_add in register path */
> @@ -1415,7 +1418,10 @@ static int __init vfio_init(void)
>   		goto err_dev_class;
>   	}
>   
> +
> +	vfio_debugfs_create_root();
>   	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
> +
>   	return 0;
>   
>   err_dev_class:
> @@ -1433,6 +1439,7 @@ static void __exit vfio_cleanup(void)
>   	vfio_virqfd_exit();
>   	vfio_group_cleanup();
>   	xa_destroy(&vfio_device_set_xa);
> +	vfio_debugfs_remove_root();
>   }
>   
>   module_init(vfio_init);
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 2c137ea94a3e..a114b430be31 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -62,6 +62,13 @@ struct vfio_device {
>   	struct iommufd_device *iommufd_device;
>   	bool iommufd_attached;
>   #endif
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

