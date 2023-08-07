Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28E577316A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjHGVoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjHGVob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DB710CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 14:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691444625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lkH2uwfGDRWWzLZLUrEglTo37QdRduAcqvXLnrQWxTg=;
        b=S3A0574fdkNuxHstv1ZBf3hs4RoE5YqXKZcwWz3TZVaRBeE4hGGZxVejmawv0NlH0c3BQE
        zYMcYDtCd30wYbcE4bmQw3Q+6GbX69cYjXe6i/YM7hfdDC2vUOAgPEMBs2O3MlcQumK8GW
        +ldL+SV3AQzn2Y9dWDHUNs678ejnSJE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-kSGjqF6NP9O2L1S-SHlKKA-1; Mon, 07 Aug 2023 17:43:42 -0400
X-MC-Unique: kSGjqF6NP9O2L1S-SHlKKA-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-34913c7cf1bso49181405ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 14:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691444622; x=1692049422;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lkH2uwfGDRWWzLZLUrEglTo37QdRduAcqvXLnrQWxTg=;
        b=hA/J+dzqZTP5K67tbwR8XpaeOxh4JPsPVPLbXUiQuis+DemY44BQq2M780YF56t5yy
         ffwBEONuEkMU8m1pcspX8SBSQWoEvO8xT3VWCO8vdfd1Qn3FSlLV5Yy0yHHyUaKZ369h
         mbjCs2/OpXSmUyG8LCNeubOgiI7PsObphg+vWZjt3KOWqGUPWQV3YEUkIxJFwowSSi4y
         W7C7e9RrWMvt568Pz3fJxVnhel6/vKMTF/gjb7FplA5Ykj3Z0J91MJF+H1jC0Bs4Lr/C
         FsrYf8IC+ZzyJVVEggPpa9BJqYgKTjH19lMrtK3qzeKWBptMP8ejtNTr2NW8n9Ymdf+R
         Z++A==
X-Gm-Message-State: AOJu0YynAjSTA85K9mY93v4qBi5d7vlko/+rDCYMupnuksDAGDK6RCN0
        77YLuer26Ukn5tWRSipEv/qkAsk2QebpptVzli+zAdbS//EZ0EcA0FsCWMBn04vyLxsdwrWBu1P
        fprjW2fltDf00u153sGyix0hY
X-Received: by 2002:a05:6e02:1c24:b0:349:7832:5cd with SMTP id m4-20020a056e021c2400b00349783205cdmr540132ilh.1.1691444621796;
        Mon, 07 Aug 2023 14:43:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1ijTF5BLrHQVWnRsVkicJxhe2S6+wvAo3TTuAJG57poFBv+WALpts4K2txfmNMrDEssJQbw==
X-Received: by 2002:a05:6e02:1c24:b0:349:7832:5cd with SMTP id m4-20020a056e021c2400b00349783205cdmr540120ilh.1.1691444621389;
        Mon, 07 Aug 2023 14:43:41 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id v13-20020a92c6cd000000b00345d6297aa7sm3015495ilm.16.2023.08.07.14.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:43:40 -0700 (PDT)
Date:   Mon, 7 Aug 2023 15:43:39 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v12 3/4] hisi_acc_vfio_pci: register debugfs for
 hisilicon migration driver
Message-ID: <20230807154339.5e347d1d.alex.williamson@redhat.com>
In-Reply-To: <20230728072104.64834-4-liulongfang@huawei.com>
References: <20230728072104.64834-1-liulongfang@huawei.com>
        <20230728072104.64834-4-liulongfang@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 15:21:03 +0800
liulongfang <liulongfang@huawei.com> wrote:

> From: Longfang Liu <liulongfang@huawei.com>
> 
> On the debugfs framework of VFIO, if the CONFIG_DEBUG_FS macro is
> enabled, the debug function is registered for the live migration driver
> of the HiSilicon accelerator device.
> 
> After registering the HiSilicon accelerator device on the debugfs
> framework of live migration of vfio, a directory file "hisi_acc"
> of debugfs is created, and then three debug function files are
> created in this directory:
> 
> data file: used to get the migration data from the driver
> attr file: used to get device attributes parameters from the driver
> save file: used to read the data of the live migration device and save
> it to the driver.
> io_test: used to test IO read and write for the driver.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 178 ++++++++++++++++++
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |   3 +
>  2 files changed, 181 insertions(+)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index 242ad319932a..a811dc237a29 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -15,6 +15,7 @@
>  #include <linux/anon_inodes.h>
>  
>  #include "hisi_acc_vfio_pci.h"
> +#include "../../vfio.h"
>  
>  /* Return 0 on VM acc device ready, -ETIMEDOUT hardware timeout */
>  static int qm_wait_dev_not_ready(struct hisi_qm *qm)
> @@ -606,6 +607,18 @@ hisi_acc_check_int_state(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>  	}
>  }
>  
> +static void hisi_acc_vf_migf_save(struct hisi_acc_vf_migration_file *dst_migf,
> +	struct hisi_acc_vf_migration_file *src_migf)
> +{
> +	if (!dst_migf)
> +		return;
> +
> +	dst_migf->disabled = false;
> +	dst_migf->total_length = src_migf->total_length;
> +	memcpy(&dst_migf->vf_data, &src_migf->vf_data,
> +		    sizeof(struct acc_vf_data));
> +}
> +
>  static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *migf)
>  {
>  	mutex_lock(&migf->lock);
> @@ -618,12 +631,16 @@ static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *migf)
>  static void hisi_acc_vf_disable_fds(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>  {
>  	if (hisi_acc_vdev->resuming_migf) {
> +		hisi_acc_vf_migf_save(hisi_acc_vdev->debug_migf,
> +						hisi_acc_vdev->resuming_migf);
>  		hisi_acc_vf_disable_fd(hisi_acc_vdev->resuming_migf);
>  		fput(hisi_acc_vdev->resuming_migf->filp);
>  		hisi_acc_vdev->resuming_migf = NULL;
>  	}
>  
>  	if (hisi_acc_vdev->saving_migf) {
> +		hisi_acc_vf_migf_save(hisi_acc_vdev->debug_migf,
> +						hisi_acc_vdev->saving_migf);
>  		hisi_acc_vf_disable_fd(hisi_acc_vdev->saving_migf);
>  		fput(hisi_acc_vdev->saving_migf->filp);
>  		hisi_acc_vdev->saving_migf = NULL;
> @@ -1303,6 +1320,162 @@ static long hisi_acc_vfio_pci_ioctl(struct vfio_device *core_vdev, unsigned int
>  	return vfio_pci_core_ioctl(core_vdev, cmd, arg);
>  }
>  
> +static int hisi_acc_vf_debug_check(struct seq_file *seq, struct vfio_device *vdev)
> +{
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
> +
> +	if (!vdev->mig_ops || !migf) {
> +		seq_printf(seq, "%s\n", "device does not support live migration!");
> +		return -EINVAL;
> +	}
> +
> +	/* If device not opened, the debugfs operation will trigger calltrace */
> +	if (!vdev->open_count) {
> +		seq_printf(seq, "%s\n", "device not opened!");
> +		return -EINVAL;
> +	}

Following up on the previous reply:

https://lore.kernel.org/all/f01944a8-5668-8a3e-f384-fb9b0fc3b09f@huawei.com/

>> What prevents this from racing release of the device?
>>
> Now there are only read operations for debugfs. The open_count here only needs
> to be used to prevent read operations when the device is not opened.
> There is no need to deal with competition issues.

The explanation doesn't make sense to me, if we're not protecting that
open_count remains elevated for the code path alluded to in the
comment, then this test is useless.  If the calltrace can happen when
the device is not open then it can happen when the device is closed
immediately after this test is performed.

> +
> +	return 0;
> +}
> +
> +static int hisi_acc_vf_debug_io(struct seq_file *seq, void *data)
> +{
> +	struct device *vf_dev = seq->private;
> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
> +	struct vfio_device *vdev = &core_device->vdev;
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
> +	u64 value;
> +	int ret;
> +
> +	ret = hisi_acc_vf_debug_check(seq, vdev);
> +	if (ret)
> +		return 0;
> +

For example, open_count can can be zero here regardless of the test in
the previous function.

> +	ret = qm_wait_dev_not_ready(vf_qm);
> +	if (ret) {
> +		seq_printf(seq, "%s\n", "VF device not ready!");
> +		return 0;
> +	}
> +
> +	value = readl(vf_qm->io_base + QM_MB_CMD_SEND_BASE);
> +	seq_printf(seq, "%s:0x%llx\n", "debug mailbox val", value);
> +
> +	return 0;
> +}

I still don't understand why the debugfs file is called "io_test" for
reading the mailbox.

> +
> +static int hisi_acc_vf_debug_save(struct seq_file *seq, void *data)
> +{
> +	struct device *vf_dev = seq->private;
> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
> +	struct vfio_device *vdev = &core_device->vdev;
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
> +	int ret;
> +
> +	ret = hisi_acc_vf_debug_check(seq, vdev);
> +	if (ret)
> +		return 0;

Nothing requires that open_count is still elevated here.

> +
> +	ret = vf_qm_state_save(hisi_acc_vdev, migf);
> +	if (ret) {
> +		seq_printf(seq, "%s\n", "failed to save device data!");
> +		return 0;
> +	}
> +	seq_printf(seq, "%s\n", "successful to save device data!");
> +
> +	return 0;
> +}
> +
> +static int hisi_acc_vf_data_read(struct seq_file *seq, void *data)
> +{
> +	struct device *vf_dev = seq->private;
> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
> +	struct vfio_device *vdev = &core_device->vdev;
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_acc_vf_migration_file *debug_migf = hisi_acc_vdev->debug_migf;
> +	size_t vf_data_sz = offsetofend(struct acc_vf_data, padding);
> +
> +	if (debug_migf && debug_migf->total_length)
> +		seq_hex_dump(seq, "Mig Data:", DUMP_PREFIX_OFFSET, 16, 1,
> +				(unsigned char *)&debug_migf->vf_data,
> +				vf_data_sz, false);

The previous save function attempts to make sure the device is open,
but there's no attempt to drop the debug_migf data when the device is
closed, so we can read the save data regardless of the device being
opened or opened within the same instance where the data was saved.  Is
this intentional?

> +	else
> +		seq_printf(seq, "%s\n", "device not migrated!");
> +
> +	return 0;
> +}
> +
> +static int hisi_acc_vf_attr_read(struct seq_file *seq, void *data)
> +{
> +	struct device *vf_dev = seq->private;
> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
> +	struct vfio_device *vdev = &core_device->vdev;
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_acc_vf_migration_file *debug_migf = hisi_acc_vdev->debug_migf;
> +
> +	if (debug_migf && debug_migf->total_length) {
> +		seq_printf(seq,
> +			 "acc device:\n"
> +			 "device  state: %d\n"
> +			 "device  ready: %u\n"
> +			 "data    valid: %d\n"
> +			 "data     size: %lu\n",
> +			 hisi_acc_vdev->mig_state,
> +			 hisi_acc_vdev->vf_qm_state,
> +			 debug_migf->disabled,

This is only ever false?

> +			 debug_migf->total_length);
> +	} else {
> +		seq_printf(seq, "%s\n", "device not migrated!");
> +	}
> +
> +	return 0;
> +}
> +
> +static int hisi_acc_vfio_debug_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
> +{
> +	struct vfio_device *vdev = &hisi_acc_vdev->core_device.vdev;
> +	struct dentry *vfio_dev_migration = NULL;
> +	struct dentry *vfio_hisi_acc = NULL;
> +	struct device *dev = vdev->dev;
> +	void *migf = NULL;
> +
> +	if (!debugfs_initialized())
> +		return 0;
> +
> +	migf = kzalloc(sizeof(struct hisi_acc_vf_migration_file), GFP_KERNEL);
> +	if (!migf)
> +		return -ENOMEM;
> +	hisi_acc_vdev->debug_migf = migf;
> +
> +	vfio_dev_migration = debugfs_lookup("migration", vdev->debug_root);
> +	if (!vfio_dev_migration) {
> +		dev_err(dev, "failed to lookup migration debugfs file!\n");
> +		return -ENODEV;

The allocation of debug_migf is rather wasted if we get here.

> +	}
> +
> +	vfio_hisi_acc = debugfs_create_dir("hisi_acc", vfio_dev_migration);
> +	debugfs_create_devm_seqfile(dev, "data", vfio_hisi_acc,
> +				  hisi_acc_vf_data_read);
> +	debugfs_create_devm_seqfile(dev, "attr", vfio_hisi_acc,
> +				  hisi_acc_vf_attr_read);

Why do we want separate debugfs files for meta data vs data?  ie. why
isn't the hex dump just another line of output along with the meta data?

> +	debugfs_create_devm_seqfile(dev, "io_test", vfio_hisi_acc,
> +				  hisi_acc_vf_debug_io);
> +	debugfs_create_devm_seqfile(dev, "save", vfio_hisi_acc,
> +				  hisi_acc_vf_debug_save);
> +
> +	return 0;
> +}
> +
> +static void hisi_acc_vf_debugfs_exit(struct hisi_acc_vf_core_device *hisi_acc_vdev)
> +{
> +	if (!debugfs_initialized())
> +		return;
> +
> +	kfree(hisi_acc_vdev->debug_migf);
> +}
> +
>  static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
>  {
>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
> @@ -1323,6 +1496,7 @@ static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
>  	}
>  
>  	vfio_pci_core_finish_enable(vdev);
> +
>  	return 0;
>  }
>  
> @@ -1422,6 +1596,9 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
>  	ret = vfio_pci_core_register_device(&hisi_acc_vdev->core_device);
>  	if (ret)
>  		goto out_put_vdev;
> +
> +	if (ops == &hisi_acc_vfio_pci_migrn_ops)
> +		hisi_acc_vfio_debug_init(hisi_acc_vdev);
>  	return 0;
>  
>  out_put_vdev:
> @@ -1433,6 +1610,7 @@ static void hisi_acc_vfio_pci_remove(struct pci_dev *pdev)
>  {
>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
>  
> +	hisi_acc_vf_debugfs_exit(hisi_acc_vdev);

This frees debug_migf

>  	vfio_pci_core_unregister_device(&hisi_acc_vdev->core_device);

This triggers the recursive removal of the debugfs seqfiles.  There's a
use-after-free race here where we can dump the contents of the freed
buffer.  Thanks,

Alex

>  	vfio_put_device(&hisi_acc_vdev->core_device.vdev);
>  }
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> index dcabfeec6ca1..93f44bcf53ee 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> @@ -113,5 +113,8 @@ struct hisi_acc_vf_core_device {
>  	spinlock_t reset_lock;
>  	struct hisi_acc_vf_migration_file *resuming_migf;
>  	struct hisi_acc_vf_migration_file *saving_migf;
> +
> +	/* For debugfs */
> +	struct hisi_acc_vf_migration_file *debug_migf;
>  };
>  #endif /* HISI_ACC_VFIO_PCI_H */

