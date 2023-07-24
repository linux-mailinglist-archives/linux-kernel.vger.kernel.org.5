Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7483075E9DD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjGXCmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjGXCmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:42:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44670E6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 19:42:08 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R8PVV56rCzNmW4;
        Mon, 24 Jul 2023 10:38:42 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 10:42:04 +0800
Subject: Re: [PATCH v11 1/4] vfio/migration: Add debugfs to live migration
 driver
To:     =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
        <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>
References: <20230630092457.54902-1-liulongfang@huawei.com>
 <20230630092457.54902-2-liulongfang@huawei.com>
 <04b41307-b1a9-62d0-4996-a8c655b46892@redhat.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <77467797-f609-6197-c359-d3192832e2e7@huawei.com>
Date:   Mon, 24 Jul 2023 10:42:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <04b41307-b1a9-62d0-4996-a8c655b46892@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/19 1:45, Cédric Le Goater Wrote:
> On 6/30/23 11:24, liulongfang wrote:
>> From: Longfang Liu <liulongfang@huawei.com>
>>
>> There are multiple devices, software and operational steps involved
>> in the process of live migration. An error occurred on any node may
>> cause the live migration operation to fail.
>> This complex process makes it very difficult to locate and analyze
>> the cause when the function fails.
>>
>> In order to quickly locate the cause of the problem when the
>> live migration fails, I added a set of debugfs to the vfio
>> live migration driver.
>>
>>      +-------------------------------------------+
>>      |                                           |
>>      |                                           |
>>      |                  QEMU                     |
>>      |                                           |
>>      |                                           |
>>      +---+----------------------------+----------+
>>          |      ^                     |      ^
>>          |      |                     |      |
>>          |      |                     |      |
>>          v      |                     v      |
>>       +---------+--+               +---------+--+
>>       |src vfio_dev|               |dst vfio_dev|
>>       +--+---------+               +--+---------+
>>          |      ^                     |      ^
>>          |      |                     |      |
>>          v      |                     |      |
>>     +-----------+----+           +-----------+----+
>>     |src dev debugfs |           |dst dev debugfs |
>>     +----------------+           +----------------+
>>
>> The entire debugfs directory will be based on the definition of
>> the CONFIG_DEBUG_FS macro. If this macro is not enabled, the
>> interfaces in vfio.h will be empty definitions, and the creation
>> and initialization of the debugfs directory will not be executed.
>>
>>     vfio
>>      |
>>      +---<dev_name1>
>>      |    +---migration
>>      |        +--state
>>      |        +--hisi_acc
>>      |            +--attr
>>      |            +--data
>>      |            +--save
>>      |            +--io_test
>>      |
>>      +---<dev_name2>
>>           +---migration
>>               +--state
>>               +--hisi_acc
>>                   +--attr
>>                   +--data
>>                   +--save
>>                   +--io_test
>>
>> debugfs will create a public root directory "vfio" file.
>> then create a dev_name() file for each live migration device.
>> First, create a unified state acquisition file of "migration"
>> in this device directory.
>> Then, create a public live migration state lookup file "state"
>> Finally, create a directory file based on the device type,
>> and then create the device's own debugging files under
>> this directory file.
>>
>> Here, HiSilicon accelerator creates three debug files:
>> attr: used to export the attribute parameters of the
>> current live migration device.
>> data: used to export the live migration data of the current
>> live migration device.
>> save: used to read the current live migration device's data
>> and save it to the driver.
>> io_test: used to test the IO read and write for the driver.
>>
>> The live migration function of the current device can be tested by
>> operating the debug files, and the functional status of the equipment
>> and software at each stage can be tested step by step without
>> performing the complete live migration function. And after the live
>> migration is performed, the migration device data of the live migration
>> can be obtained through the debug files.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>   drivers/vfio/Makefile       |  1 +
>>   drivers/vfio/vfio.h         | 14 +++++++
>>   drivers/vfio/vfio_debugfs.c | 78 +++++++++++++++++++++++++++++++++++++
>>   drivers/vfio/vfio_main.c    |  9 ++++-
>>   include/linux/vfio.h        |  7 ++++
>>   5 files changed, 108 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/vfio/vfio_debugfs.c
>>
>> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
>> index 66f418aef5a9..6829c58210dc 100644
>> --- a/drivers/vfio/Makefile
>> +++ b/drivers/vfio/Makefile
>> @@ -7,6 +7,7 @@ vfio-y += vfio_main.o \
>>   vfio-$(CONFIG_IOMMUFD) += iommufd.o
>>   vfio-$(CONFIG_VFIO_CONTAINER) += container.o
>>   vfio-$(CONFIG_VFIO_VIRQFD) += virqfd.o
>> +vfio-$(CONFIG_DEBUG_FS) += vfio_debugfs.o
>>     obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
>>   obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o
>> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
>> index 7b19c621e0e6..729c52ef579a 100644
>> --- a/drivers/vfio/vfio.h
>> +++ b/drivers/vfio/vfio.h
>> @@ -264,4 +264,18 @@ static inline void vfio_device_put_kvm(struct vfio_device *device)
>>   }
>>   #endif
>>   +#ifdef CONFIG_DEBUG_FS
>> +void vfio_debugfs_create_root(void);
>> +void vfio_debugfs_remove_root(void);
>> +
>> +void vfio_device_debugfs_init(struct vfio_device *vdev);
>> +void vfio_device_debugfs_exit(struct vfio_device *vdev);
>> +#else
>> +static inline void vfio_debugfs_create_root(void) { }
>> +static inline void vfio_debugfs_remove_root(void) { }
>> +
>> +static inline void vfio_device_debugfs_init(struct vfio_device *vdev) { }
>> +static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { }
>> +#endif /* CONFIG_DEBUG_FS */
>> +
>>   #endif
>> diff --git a/drivers/vfio/vfio_debugfs.c b/drivers/vfio/vfio_debugfs.c
>> new file mode 100644
>> index 000000000000..7bff30f76bd9
>> --- /dev/null
>> +++ b/drivers/vfio/vfio_debugfs.c
>> @@ -0,0 +1,78 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2023, HiSilicon Ltd.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/debugfs.h>
>> +#include <linux/seq_file.h>
>> +#include <linux/vfio.h>
>> +#include "vfio.h"
>> +
>> +static struct dentry *vfio_debugfs_root;
> 
> This could be external to all VFIO. See comment below.
>  
>> +
>> +static int vfio_device_state_read(struct seq_file *seq, void *data)
>> +{
>> +    struct device *vf_dev = seq->private;
>> +    struct vfio_device *vdev = container_of(vf_dev, struct vfio_device, device);
>> +    enum vfio_device_mig_state state;
>> +    int ret;
>> +
>> +    ret = vdev->mig_ops->migration_get_state(vdev, &state);
>> +    if (ret)
>> +        return -EINVAL;
>> +
>> +    switch (state) {
>> +    case VFIO_DEVICE_STATE_RUNNING:
>> +        seq_printf(seq, "%s\n", "RUNNING");
>> +        break;
>> +    case VFIO_DEVICE_STATE_STOP_COPY:
>> +        seq_printf(seq, "%s\n", "STOP_COPY");
>> +        break;
>> +    case VFIO_DEVICE_STATE_STOP:
>> +        seq_printf(seq, "%s\n", "STOP");
>> +        break;
>> +    case VFIO_DEVICE_STATE_RESUMING:
>> +        seq_printf(seq, "%s\n", "RESUMING");
>> +        break;
>> +    case VFIO_DEVICE_STATE_RUNNING_P2P:
>> +        seq_printf(seq, "%s\n", "RESUMING_P2P");
>> +        break;
>> +    case VFIO_DEVICE_STATE_ERROR:
>> +        seq_printf(seq, "%s\n", "ERROR");
>> +        break;
>> +    default:
>> +        seq_printf(seq, "%s\n", "Invalid");
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +void vfio_device_debugfs_init(struct vfio_device *vdev)
>> +{
>> +    struct dentry *vfio_dev_migration = NULL;
>> +    struct device *dev = &vdev->device;
>> +
>> +    vdev->debug_root = debugfs_create_dir(dev_name(vdev->dev), vfio_debugfs_root);
>> +    vfio_dev_migration = debugfs_create_dir("migration", vdev->debug_root);
>> +
>> +    debugfs_create_devm_seqfile(dev, "state", vfio_dev_migration,
>> +                  vfio_device_state_read);
>> +}
>> +
>> +void vfio_device_debugfs_exit(struct vfio_device *vdev)
>> +{
>> +    debugfs_remove_recursive(vdev->debug_root);
>> +}
> 
> I would simply use :
> 
>     if (IS_ENABLED(CONFIG_DEBUG_FS))
>         debugfs_remove_recursive(vdev->debug_root);
> 
> where vfio_device_debugfs_exit() is called.
> 
These functions have been processed by CONFIG_DEBUG_FS in vfio.h.
The effect is almost the same.

>> +
>> +void vfio_debugfs_create_root(void)
>> +{
>> +    vfio_debugfs_root = debugfs_create_dir("vfio", NULL);
>> +}
>> +
>> +void vfio_debugfs_remove_root(void)
>> +{
>> +    debugfs_remove_recursive(vfio_debugfs_root);
>> +    vfio_debugfs_root = NULL;
> ditto.
>
ditto.

>> +}
>> +
>> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
>> index f0ca33b2e1df..18d050ec9a12 100644
>> --- a/drivers/vfio/vfio_main.c
>> +++ b/drivers/vfio/vfio_main.c
>> @@ -282,7 +282,8 @@ static int __vfio_register_dev(struct vfio_device *device,
>>         /* Refcounting can't start until the driver calls register */
>>       refcount_set(&device->refcount, 1);
>> -
>> +    if (device->mig_ops)
>> +        vfio_device_debugfs_init(device);
> 
> I think we should prepare ground for more debugfs files than just migration
> related things. Migration is clearly a very good candidate, but there could
> be more. I have a couple out of tree patches to collect statistics on VMA
> usage and resets for instance which could be included.
> 
> 
> Thanks,
> 
> C.

OK, this suggestion of yours is very good.
I can put this judgment processing into vfio_device_debugfs_init().
If your patch needs to add debugfs, you can add it in vfio_device_debugfs_init().

Thanks,
Longfang.
> 
>>       vfio_device_group_register(device);
>>         return 0;
>> @@ -339,6 +340,8 @@ void vfio_unregister_group_dev(struct vfio_device *device)
>>           }
>>       }
>>   +    if (device->mig_ops)
>> +        vfio_device_debugfs_exit(device);
>>       vfio_device_group_unregister(device);
>>         /* Balances device_add in register path */
>> @@ -1415,7 +1418,10 @@ static int __init vfio_init(void)
>>           goto err_dev_class;
>>       }
>>   +
>> +    vfio_debugfs_create_root();
>>       pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
>> +
>>       return 0;
>>     err_dev_class:
>> @@ -1433,6 +1439,7 @@ static void __exit vfio_cleanup(void)
>>       vfio_virqfd_exit();
>>       vfio_group_cleanup();
>>       xa_destroy(&vfio_device_set_xa);
>> +    vfio_debugfs_remove_root();
>>   }
>>     module_init(vfio_init);
>> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
>> index 2c137ea94a3e..a114b430be31 100644
>> --- a/include/linux/vfio.h
>> +++ b/include/linux/vfio.h
>> @@ -62,6 +62,13 @@ struct vfio_device {
>>       struct iommufd_device *iommufd_device;
>>       bool iommufd_attached;
>>   #endif
>> +#ifdef CONFIG_DEBUG_FS
>> +    /*
>> +     * debug_root is a static property of the vfio_device
>> +     * which must be set prior to registering the vfio_device.
>> +     */
>> +    struct dentry *debug_root;
>> +#endif
>>   };
>>     /**
> 
> .
> 
