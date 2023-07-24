Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B767975E9FE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 05:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjGXDO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 23:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGXDOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 23:14:55 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24124F3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 20:14:53 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R8QHD6gTVz1KCDJ;
        Mon, 24 Jul 2023 11:14:00 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 11:14:50 +0800
Subject: Re: [PATCH v11 3/4] hisi_acc_vfio_pci: register debugfs for hisilicon
 migration driver
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20230630092457.54902-1-liulongfang@huawei.com>
 <20230630092457.54902-4-liulongfang@huawei.com>
 <20230714160751.551df645.alex.williamson@redhat.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <f01944a8-5668-8a3e-f384-fb9b0fc3b09f@huawei.com>
Date:   Mon, 24 Jul 2023 11:14:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230714160751.551df645.alex.williamson@redhat.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/15 6:07, Alex Williamson wrote:
> On Fri, 30 Jun 2023 17:24:56 +0800
> liulongfang <liulongfang@huawei.com> wrote:
> 
>> From: Longfang Liu <liulongfang@huawei.com>
>>
>> On the debugfs framework of VFIO, if the CONFIG_DEBUG_FS macro is
>> enabled, the debug function is registered for the live migration driver
>> of the HiSilicon accelerator device.
>>
>> After registering the HiSilicon accelerator device on the debugfs
>> framework of live migration of vfio, a directory file "hisi_acc"
>> of debugfs is created, and then three debug function files are
>> created in this directory:
>>
>> data file: used to get the migration data from the driver
>> attr file: used to get device attributes parameters from the driver
>> save file: used to read the data of the live migration device and save
>> it to the driver.
>> io_test: used to test IO read and write for the driver.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 182 ++++++++++++++++++
>>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  11 ++
>>  2 files changed, 193 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> index a1589947e721..a6f5e94bfaf2 100644
>> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/anon_inodes.h>
>>  
>>  #include "hisi_acc_vfio_pci.h"
>> +#include "../../vfio.h"
>>  
>>  /* Return 0 on VM acc device ready, -ETIMEDOUT hardware timeout */
>>  static int qm_wait_dev_not_ready(struct hisi_qm *qm)
>> @@ -606,6 +607,18 @@ hisi_acc_check_int_state(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>>  	}
>>  }
>>  
>> +static void hisi_acc_vf_migf_save(struct hisi_acc_vf_migration_file *src_migf,
>> +	struct hisi_acc_vf_migration_file *dst_migf)
> 
> Consider swapping the args to be more consistent with functions like
> memcpy() where the destination is the first arg and source is the
> second.>
OK, These two parameters can be swapped.

>> +{
>> +	if (!dst_migf)
>> +		return;
>> +
>> +	dst_migf->disabled = false;
>> +	dst_migf->total_length = src_migf->total_length;
>> +	memcpy(&dst_migf->vf_data, &src_migf->vf_data,
>> +		    sizeof(struct acc_vf_data));
>> +}
>> +
>>  static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *migf)
>>  {
>>  	mutex_lock(&migf->lock);
>> @@ -618,12 +631,16 @@ static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *migf)
>>  static void hisi_acc_vf_disable_fds(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>>  {
>>  	if (hisi_acc_vdev->resuming_migf) {
>> +		hisi_acc_vf_migf_save(hisi_acc_vdev->resuming_migf,
>> +						hisi_acc_vdev->debug_migf);
>>  		hisi_acc_vf_disable_fd(hisi_acc_vdev->resuming_migf);
>>  		fput(hisi_acc_vdev->resuming_migf->filp);
>>  		hisi_acc_vdev->resuming_migf = NULL;
>>  	}
>>  
>>  	if (hisi_acc_vdev->saving_migf) {
>> +		hisi_acc_vf_migf_save(hisi_acc_vdev->saving_migf,
>> +						hisi_acc_vdev->debug_migf);
>>  		hisi_acc_vf_disable_fd(hisi_acc_vdev->saving_migf);
>>  		fput(hisi_acc_vdev->saving_migf->filp);
>>  		hisi_acc_vdev->saving_migf = NULL;
>> @@ -1303,6 +1320,164 @@ static long hisi_acc_vfio_pci_ioctl(struct vfio_device *core_vdev, unsigned int
>>  	return vfio_pci_core_ioctl(core_vdev, cmd, arg);
>>  }
>>  
>> +static int hisi_acc_vf_debug_check(struct seq_file *seq, struct vfio_device *vdev)
>> +{
>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
>> +	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
>> +
>> +	if (!vdev->mig_ops || !migf) {
>> +		seq_printf(seq, "%s\n", "device not support debugfs!");
> 
> "device does not support debugfs"?
> 
OK,"device does not support live migration"

>> +		return -EINVAL;
>> +	}
>> +
>> +	/* If device not opened, the debugfs operation will trigger calltrace */
>> +	if (!vdev->open_count) {
>> +		seq_printf(seq, "%s\n", "device not opened!");
>> +		return -EINVAL;
>> +	}
> 
> What prevents this from racing release of the device?
>
Now there are only read operations for debugfs. The open_count here only needs
to be used to prevent read operations when the device is not opened.
There is no need to deal with competition issues.

>> +
>> +	return 0;
>> +}
>> +
>> +static int hisi_acc_vf_debug_io(struct seq_file *seq, void *data)
>> +{
>> +	struct device *vf_dev = seq->private;
>> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
>> +	struct vfio_device	*vdev = &core_device->vdev;
> 
> A tab sneaked in here.
> 
Thanks.

>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
>> +	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
>> +	u64 value;
>> +	int ret;
>> +
>> +	ret = hisi_acc_vf_debug_check(seq, vdev);
>> +	if (ret)
>> +		goto io_err;
>> +
>> +	ret = qm_wait_dev_not_ready(vf_qm);
>> +	if (ret) {
>> +		seq_printf(seq, "%s\n", "VF device not ready!");
>> +		goto io_err;
>> +	}
>> +
>> +	value = readl(vf_qm->io_base + QM_MB_CMD_SEND_BASE);
>> +	seq_printf(seq, "%s:0x%llx\n", "debug mailbox val", value);
>> +
>> +io_err:
>> +	return 0;
> 
> A goto that simply returns seems unnecessary vs return at the error
Ok, no need to use goto here. The following one is also handled in the same way.

> condition.  Also why don't we return the errno for error cases?  Do we> even need seq_printf() calls for error cases?
>

Added logging of seq_printf only on critical steps.

>> +}
>> +
>> +static int hisi_acc_vf_debug_save(struct seq_file *seq, void *data)
>> +{
>> +	struct device *vf_dev = seq->private;
>> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
>> +	struct vfio_device	*vdev = &core_device->vdev;
> 
> Another tab.
> 
OK.

>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
>> +	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
>> +	int ret;
>> +
>> +	ret = hisi_acc_vf_debug_check(seq, vdev);
>> +	if (ret)
>> +		goto save_err;
>> +
>> +	ret = vf_qm_state_save(hisi_acc_vdev, migf);
>> +	if (ret) {
>> +		seq_printf(seq, "%s\n", "failed to save device data!");
>> +		goto save_err;
>> +	}
>> +	seq_printf(seq, "%s\n", "successful to save device data!");
>> +
>> +save_err:
>> +	return 0;
>> +}
>> +
>> +static int hisi_acc_vf_data_read(struct seq_file *seq, void *data)
>> +{
>> +	struct device *vf_dev = seq->private;
>> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
>> +	struct vfio_device	*vdev = &core_device->vdev;
> 
> Tab.
> 
OK.
>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
>> +	struct hisi_acc_vf_migration_file *debug_migf = hisi_acc_vdev->debug_migf;
>> +	size_t vf_data_sz = offsetofend(struct acc_vf_data, padding);
>> +
>> +	if (debug_migf && debug_migf->total_length)
>> +		seq_hex_dump(seq, "Mig Data:", DUMP_PREFIX_OFFSET, 16, 1,
>> +				(unsigned char *)&debug_migf->vf_data,
>> +				vf_data_sz, false);
>> +	else
>> +		seq_printf(seq, "%s\n", "device not migrated!");
>> +
>> +	return 0;
>> +}
>> +
>> +static int hisi_acc_vf_attr_read(struct seq_file *seq, void *data)
>> +{
>> +	struct device *vf_dev = seq->private;
>> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
>> +	struct vfio_device	*vdev = &core_device->vdev;
> 
> Tab.
> 
OK.
>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
>> +	struct hisi_acc_vf_migration_file *debug_migf = hisi_acc_vdev->debug_migf;
>> +
>> +	if (debug_migf && debug_migf->total_length) {
>> +		seq_printf(seq,
>> +			 "acc device:\n"
>> +			 "device  state: %d\n"
>> +			 "device  ready: %u\n"
>> +			 "data    valid: %d\n"
>> +			 "data     size: %lu\n",
>> +			 hisi_acc_vdev->mig_state,
>> +			 hisi_acc_vdev->vf_qm_state,
>> +			 debug_migf->disabled,
>> +			 debug_migf->total_length);
>> +	} else {
>> +		seq_printf(seq, "%s\n", "device not migrated!");
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int hisi_acc_vfio_debug_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>> +{
>> +	struct vfio_device *vdev = &hisi_acc_vdev->core_device.vdev;
>> +	struct dentry *vfio_dev_migration = NULL;
>> +	struct dentry *vfio_hisi_acc = NULL;
>> +	struct device *dev = vdev->dev;
>> +	void *migf = NULL;
>> +
>> +	if (!debugfs_initialized())
>> +		return 0;
>> +
>> +	migf = kzalloc(sizeof(struct hisi_acc_vf_migration_file), GFP_KERNEL);
>> +	if (!migf)
>> +		return -ENOMEM;
>> +	hisi_acc_vdev->debug_migf = migf;
>> +
>> +	vfio_dev_migration = debugfs_lookup("migration", vdev->debug_root);
>> +	if (!vfio_dev_migration) {
>> +		dev_err(dev, "failed to lookup migration debugfs file!\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	vfio_hisi_acc = debugfs_create_dir("hisi_acc", vfio_dev_migration);
>> +	debugfs_create_devm_seqfile(dev, "data", vfio_hisi_acc,
>> +				  hisi_acc_vf_data_read);
>> +	debugfs_create_devm_seqfile(dev, "attr", vfio_hisi_acc,
>> +				  hisi_acc_vf_attr_read);
>> +	debugfs_create_devm_seqfile(dev, "io_test", vfio_hisi_acc,
>> +				  hisi_acc_vf_debug_io);
>> +	debugfs_create_devm_seqfile(dev, "save", vfio_hisi_acc,
>> +				  hisi_acc_vf_debug_save);
>> +
>> +	return 0;
>> +}
>> +
>> +static void hisi_acc_vf_debugfs_exit(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>> +{
>> +	if (!debugfs_initialized())
>> +		return;
>> +
>> +	kfree(hisi_acc_vdev->debug_migf);
>> +}
>> +
>>  static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
>>  {
>>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
>> @@ -1323,6 +1498,7 @@ static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
>>  	}
>>  
>>  	vfio_pci_core_finish_enable(vdev);
>> +
>>  	return 0;
>>  }
>>  
>> @@ -1420,9 +1596,14 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
>>  	ret = vfio_pci_core_register_device(&hisi_acc_vdev->core_device);
>>  	if (ret)
>>  		goto out_put_vdev;
>> +
>> +	if (ops == &hisi_acc_vfio_pci_migrn_ops)
>> +		hisi_acc_vfio_debug_init(hisi_acc_vdev);
>>  	return 0;
>>  
>>  out_put_vdev:
>> +	if (ops == &hisi_acc_vfio_pci_migrn_ops)
>> +		hisi_acc_vf_debugfs_exit(hisi_acc_vdev);
> 
> Why do we need this?  There's no case where debug_init occurs before
> this goto.
>

Yes. These two lines are not needed here.

>>  	vfio_put_device(&hisi_acc_vdev->core_device.vdev);
>>  	return ret;
>>  }
>> @@ -1431,6 +1612,7 @@ static void hisi_acc_vfio_pci_remove(struct pci_dev *pdev)
>>  {
>>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
>>  
>> +	hisi_acc_vf_debugfs_exit(hisi_acc_vdev);
>>  	vfio_pci_core_unregister_device(&hisi_acc_vdev->core_device);
>>  	vfio_put_device(&hisi_acc_vdev->core_device.vdev);
>>  }
>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
>> index dcabfeec6ca1..ef50b12f018d 100644
>> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
>> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
>> @@ -49,6 +49,14 @@
>>  #define QM_EQC_DW0		0X8000
>>  #define QM_AEQC_DW0		0X8020
>>  
>> +#define VFIO_DEV_DBG_LEN		256
>> +
>> +enum mig_debug_cmd {
>> +	STATE_SAVE,
>> +	STATE_RESUME,
>> +	RW_IO_TEST,
>> +};
> 
> Unused.
> 
OK.

> Thanks,
> Alex
> 
Thanks,
Longfang.
>> +
>>  struct acc_vf_data {
>>  #define QM_MATCH_SIZE offsetofend(struct acc_vf_data, qm_rsv_state)
>>  	/* QM match information */
>> @@ -113,5 +121,8 @@ struct hisi_acc_vf_core_device {
>>  	spinlock_t reset_lock;
>>  	struct hisi_acc_vf_migration_file *resuming_migf;
>>  	struct hisi_acc_vf_migration_file *saving_migf;
>> +
>> +	/* For debugfs */
>> +	struct hisi_acc_vf_migration_file *debug_migf;
>>  };
>>  #endif /* HISI_ACC_VFIO_PCI_H */
> 
> .
> 
