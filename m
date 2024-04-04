Return-Path: <linux-kernel+bounces-132077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DBC898F64
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E965E1F23590
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762BC136653;
	Thu,  4 Apr 2024 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7EfPCgM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79611350D6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261263; cv=none; b=p4zqqMYG+9xAwX9yBvYBr1fGWFssiGZebsTr60RmvY2ti/jXRKbk+TaDWuVXhbVK34bPKuIY/nTLYAfJpxjU2VUEOtwlu9J9EmBAM24PH6gCrQXejpbxYb0d7NeABmd4qCkpijuDuF0PPJGUa+marAceFLPCIJNsh1bbNkrscY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261263; c=relaxed/simple;
	bh=i7WATPS2IjX67RwTlFpylXesJL1upUa4U4/b+NGDnIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWpFPLmEeOujtxivIjEfmYsRkuWq0Oswzdt2+ndB3lAq6pVwnirRhkNz37afbVWho0Q66KCNQcfj3TOxBmWaOkIjywopjLEwmMj8T81x3NtX1+1MifXDf5xeBkZH1nEp79/N2zNdwaqt9laq1LtwnqmKcVoo2yDw9gdpFa89HNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7EfPCgM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712261259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sl2/FPiYdy2p3lmFeId4Cuo5P5POdxfNhZu08uPgK0k=;
	b=I7EfPCgMzKZrWF4TGVC6G+mFpKGr1k9LItd1IRo6EDJ4+JMsLXnB1q28pjLzZg6rObqw+e
	xmHFghlUcYGwWX6VlxIEeog+g6XfrToi9jEY1NIveW92CH4UlN47ZPJ/UNIrTe915gc02x
	R1JUPJ/f3zCNQjzjTmw103ih5MAAZqE=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-H7hPdkqpOWCrecbxH79PFQ-1; Thu, 04 Apr 2024 16:07:38 -0400
X-MC-Unique: H7hPdkqpOWCrecbxH79PFQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbf092a502so139318439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712261257; x=1712866057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sl2/FPiYdy2p3lmFeId4Cuo5P5POdxfNhZu08uPgK0k=;
        b=s0qP1dsWICRVsZpiOUpFJZTMuS40B5V91ekBiQA9hLsiL/h6kJNI9IwDjTZRmpXMVf
         uE1GZsBSOW5FvyDBB4MZDcJuxpDZrNO939UPPiQ9mkSfZ7E0HTy4exKeEJMX9CHWfgGu
         Q6T+SIGYRyOFyk4r/4LiKtG8V0+X1Z76BW0Ilo2vWYolHZqSRV0RbY+ByjTpQGMCEW76
         sagOz4vJMUS70TKtK9hM7BKJHLM6zXlVBrwxnvJUyi0mOHVm1N0W0O2LPx55HJbsSfyq
         4NVHSQqnULEj3Dhfnw9SOndjeUE6hDUpLY+MIAsgJt81gZjQoN9zKdGjP9kQmDZqBd3O
         hbWA==
X-Forwarded-Encrypted: i=1; AJvYcCXfdHZUlLvmUFEoCn1HD2SvztNTIvt5djBYGG+Zh6yky7uqTt2DrYC+Zq5pfHmBI1U4Or+6MBsQUi0JU7nStvwOwWXvcsG5cNvbN6ax
X-Gm-Message-State: AOJu0YzADGfjy3uPJugvEqsTmvuVrGpem7YMdcHdJS8OQHPxWQA9RdV7
	Mg4lbvzNOcjmAvzfp7PFYqZ6vI+Q0rv796hTDgVkX7t9tkPiqaXXzvvexNTKBq/KYBxLBuJ+n35
	4C/+NOgC/zj4x9cfdlsAJRIEGeJvAF9XVOLfzIaBR9LqzH63gVowjVCcAlS73kQ==
X-Received: by 2002:a6b:4f12:0:b0:7d3:569c:d7af with SMTP id d18-20020a6b4f12000000b007d3569cd7afmr2146790iob.4.1712261257214;
        Thu, 04 Apr 2024 13:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe9vRJD5u4yez4H5+2VMnEYFzKR1U6/NnuY8dQv4MsaFkVhUTFkg6oPnSfzFq4G8AZVKxFdA==
X-Received: by 2002:a6b:4f12:0:b0:7d3:569c:d7af with SMTP id d18-20020a6b4f12000000b007d3569cd7afmr2146770iob.4.1712261256884;
        Thu, 04 Apr 2024 13:07:36 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id u13-20020a02aa8d000000b00476e6c429e5sm75521jai.121.2024.04.04.13.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 13:07:36 -0700 (PDT)
Date: Thu, 4 Apr 2024 14:07:35 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Longfang Liu <liulongfang@huawei.com>
Cc: <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
 <jonathan.cameron@huawei.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v4 3/4] hisi_acc_vfio_pci: register debugfs for
 hisilicon migration driver
Message-ID: <20240404140735.2174528d.alex.williamson@redhat.com>
In-Reply-To: <20240402032432.41004-4-liulongfang@huawei.com>
References: <20240402032432.41004-1-liulongfang@huawei.com>
	<20240402032432.41004-4-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 11:24:31 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> On the debugfs framework of VFIO, if the CONFIG_VFIO_DEBUGFS macro is
> enabled, the debug function is registered for the live migration driver
> of the HiSilicon accelerator device.
> 
> After registering the HiSilicon accelerator device on the debugfs
> framework of live migration of vfio, a directory file "hisi_acc"
> of debugfs is created, and then three debug function files are
> created in this directory:
> 
>    vfio
>     |
>     +---<dev_name1>
>     |    +---migration
>     |        +--state
>     |        +--hisi_acc
>     |            +--attr
>     |            +--data
>     |            +--save
>     |            +--cmd_state
>     |
>     +---<dev_name2>
>          +---migration
>              +--state
>              +--hisi_acc
>                  +--attr
>                  +--data
>                  +--save
>                  +--cmd_state
> 
> data file: used to get the migration data from the driver
> attr file: used to get device attributes parameters from the driver
> save file: used to read the data of the live migration device and save
> it to the driver.
> cmd_state: used to get the cmd channel state for the device.
> 
> +----------------+        +--------------+       +---------------+
> | migration dev  |        |   src  dev   |       |   dst  dev    |
> +-------+--------+        +------+-------+       +-------+-------+
>         |                        |                       |
>         |                        |                       |
>         |                        |                       |
>         |                        |                       |
>   save  |                 +------v-------+       +-------v-------+
>         |                 |  saving_mif  |       | resuming_migf |
>         |                 |     file     |       |     file      |
>         |                 +------+-------+       +-------+-------+
>         |                        |                       |
>         |        mutex           |                       |
> +-------v--------+               |                       |
> |                |               |                       |
> | debug_migf file<---------------+-----------------------+
> |                |             copy
> +-------+--------+
>         |
>    cat  |
>         |
> +-------v--------+
> |     user       |
> +----------------+
> 
> In debugfs scheme. The driver creates a separate debug_migf file.
> It is completely separated from the two files of live migration,
> thus preventing debugfs data from interfering with migration data.
> Moreover, it only performs read operations on the device.
> 
> For serialization of debugfs:
> First, it only writes data when performing a debugfs save operation.

This distinction between "writing" and "copying" is very confusing.

> Second, it is only copied from the file on the migration device
> when the live migration is complete.

Why does it do this at all?  If you're looking for a postmortem of the
user generated buffer, that should be explicitly stated.

> These two operations are mutually exclusive through mutex.

The mutual exclusion between debugfs operations is not the concern, the
question is whether there's serialization that prevents the debugfs
operations from interfering with the user migration flow.  Nothing here
seems to prevent concurrent use of the debugfs interface proposed here
with a user migration.

> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 204 ++++++++++++++++++
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  11 +
>  2 files changed, 215 insertions(+)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index bf358ba94b5d..9f563a31a2a1 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -15,6 +15,7 @@
>  #include <linux/anon_inodes.h>
>  
>  #include "hisi_acc_vfio_pci.h"
> +#include "../../vfio.h"

This include seems not to be required.

>  
>  /* Return 0 on VM acc device ready, -ETIMEDOUT hardware timeout */
>  static int qm_wait_dev_not_ready(struct hisi_qm *qm)
> @@ -618,6 +619,22 @@ hisi_acc_check_int_state(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>  	}
>  }
>  
> +static void hisi_acc_vf_migf_save(struct hisi_acc_vf_core_device *hisi_acc_vdev,
> +	struct hisi_acc_vf_migration_file *src_migf)

Seems this should be named something relative to debug since it's only
purpose is to copy the migration file to the debug migration file.

> +{
> +	struct hisi_acc_vf_migration_file *dst_migf = hisi_acc_vdev->debug_migf;
> +
> +	if (!dst_migf)
> +		return;
> +
> +	mutex_lock(&hisi_acc_vdev->enable_mutex);
> +	dst_migf->disabled = src_migf->disabled;

In the cases where this is called, the caller is about to call
hisi_acc_vf_disable_fd() which sets disabled = true and then
hisi_acc_vf_debug_save() doesn't touch the value!  What does it even
mean to copy this value, let alone print it as part of the debugfs
output later?


> +	dst_migf->total_length = src_migf->total_length;
> +	memcpy(&dst_migf->vf_data, &src_migf->vf_data,
> +		    sizeof(struct acc_vf_data));
> +	mutex_unlock(&hisi_acc_vdev->enable_mutex);
> +}
> +
>  static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *migf)
>  {
>  	mutex_lock(&migf->lock);
> @@ -630,12 +647,14 @@ static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *migf)
>  static void hisi_acc_vf_disable_fds(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>  {
>  	if (hisi_acc_vdev->resuming_migf) {
> +		hisi_acc_vf_migf_save(hisi_acc_vdev, hisi_acc_vdev->resuming_migf);
>  		hisi_acc_vf_disable_fd(hisi_acc_vdev->resuming_migf);
>  		fput(hisi_acc_vdev->resuming_migf->filp);
>  		hisi_acc_vdev->resuming_migf = NULL;
>  	}
>  
>  	if (hisi_acc_vdev->saving_migf) {
> +		hisi_acc_vf_migf_save(hisi_acc_vdev, hisi_acc_vdev->saving_migf);

Why are these buffers copied to the debug_migf in this case?  This can
happen asynchronous to accessing the debugfs migration file and there's
no serialization.

>  		hisi_acc_vf_disable_fd(hisi_acc_vdev->saving_migf);
>  		fput(hisi_acc_vdev->saving_migf->filp);
>  		hisi_acc_vdev->saving_migf = NULL;
> @@ -1144,6 +1163,7 @@ static int hisi_acc_vf_qm_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>  	if (!vf_qm->io_base)
>  		return -EIO;
>  
> +	mutex_init(&hisi_acc_vdev->enable_mutex);
>  	vf_qm->fun_type = QM_HW_VF;
>  	vf_qm->pdev = vf_dev;
>  	mutex_init(&vf_qm->mailbox_lock);
> @@ -1294,6 +1314,181 @@ static long hisi_acc_vfio_pci_ioctl(struct vfio_device *core_vdev, unsigned int
>  	return vfio_pci_core_ioctl(core_vdev, cmd, arg);
>  }
>  
> +static int hisi_acc_vf_debug_check(struct seq_file *seq, struct vfio_device *vdev)
> +{
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
> +	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
> +	int ret;
> +

lockdep_assert_held(...)

> +	if (!vdev->mig_ops || !migf) {
> +		seq_printf(seq, "%s\n", "device does not support live migration!");
> +		return -EINVAL;

Isn't the -EINVAL sufficient?

> +	}
> +
> +	/**
> +	 * When the device is not opened, the io_base is not mapped.
> +	 * The driver cannot perform device read and write operations.
> +	 */
> +	if (hisi_acc_vdev->dev_opened != DEV_OPEN) {

Why are we assigning and testing a bool against and enum?!

> +		seq_printf(seq, "%s\n", "device not opened!");
> +		return -EINVAL;
> +	}
> +
> +	ret = qm_wait_dev_not_ready(vf_qm);
> +	if (ret) {
> +		seq_printf(seq, "%s\n", "VF device not ready!");
> +		return -EINVAL;

-EBUSY?  Again, not sure why we need the seq_printf() in addition to
the error value.

> +	}
> +
> +	return 0;
> +}
> +
> +static int hisi_acc_vf_debug_cmd(struct seq_file *seq, void *data)
> +{
> +	struct device *vf_dev = seq->private;
> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
> +	struct vfio_device *vdev = &core_device->vdev;
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
> +	u64 value;
> +	int ret;
> +
> +	mutex_lock(&hisi_acc_vdev->enable_mutex);
> +	ret = hisi_acc_vf_debug_check(seq, vdev);
> +	if (ret) {
> +		mutex_unlock(&hisi_acc_vdev->enable_mutex);
> +		return 0;

Why do we squash the error return here and throughout?

> +	}
> +
> +	value = readl(vf_qm->io_base + QM_MB_CMD_SEND_BASE);
> +	mutex_unlock(&hisi_acc_vdev->enable_mutex);
> +	seq_printf(seq, "%s:0x%llx\n", "mailbox cmd channel state is OK", value);

We didn't test the value, what makes the state OK?  Can this readl() or
those in qm_wait_dev_not_ready() interfere with the main device flow?

> +
> +	return 0;
> +}
> +
> +static int hisi_acc_vf_debug_save(struct seq_file *seq, void *data)
> +{
> +	struct device *vf_dev = seq->private;
> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
> +	struct vfio_device *vdev = &core_device->vdev;
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
> +	struct acc_vf_data *vf_data = &migf->vf_data;
> +	int ret;
> +
> +	mutex_lock(&hisi_acc_vdev->enable_mutex);
> +	ret = hisi_acc_vf_debug_check(seq, vdev);
> +	if (ret) {
> +		mutex_unlock(&hisi_acc_vdev->enable_mutex);
> +		return 0;
> +	}
> +
> +	vf_data->vf_qm_state = QM_READY;
> +	ret = vf_qm_read_data(&hisi_acc_vdev->vf_qm, vf_data);
> +	if (ret) {
> +		mutex_unlock(&hisi_acc_vdev->enable_mutex);
> +		seq_printf(seq, "%s\n", "failed to save device data!");
> +		return 0;
> +	}
> +
> +	migf->total_length = sizeof(struct acc_vf_data);
> +	mutex_unlock(&hisi_acc_vdev->enable_mutex);
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
> +	else
> +		seq_printf(seq, "%s\n", "device not migrated!");

"device state not saved"?  Although I don't recall why this doesn't
just return an errno.

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

This is redundant to migration/state, however note
hisi_acc_vfio_pci_get_device_state() protects the value with state
mutex while reading it.

> +			 hisi_acc_vdev->vf_qm_state,

What's the purpose of this, it's ready or not, what does that mean?

> +			 debug_migf->disabled,

What's the purpose of this?

> +			 debug_migf->total_length);

Why not just have this printed or inferred via the above data_read
function, this all seems unnecessary.

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

Fails to build without CONFIG_DEBUG_FS=y  There should be a dependency
on CONFIG_VFIO_DEBUGFS here somewhere.

> +	if (!vfio_dev_migration) {
> +		kfree(migf);

hisi_acc_vdev->debug_migf still points at this freed buffer, the return
value of this function is not tested, allows a use-after-free in
all of the below debugfs interfaces.

> +		dev_err(dev, "failed to lookup migration debugfs file!\n");
> +		return -ENODEV;
> +	}
> +
> +	vfio_hisi_acc = debugfs_create_dir("hisi_acc", vfio_dev_migration);
> +	debugfs_create_devm_seqfile(dev, "data", vfio_hisi_acc,
> +				  hisi_acc_vf_data_read);
> +	debugfs_create_devm_seqfile(dev, "attr", vfio_hisi_acc,
> +				  hisi_acc_vf_attr_read);
> +	debugfs_create_devm_seqfile(dev, "cmd_state", vfio_hisi_acc,
> +				  hisi_acc_vf_debug_cmd);
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

Double free if the lookup in init fails.

> +}
> +
>  static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
>  {
>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
> @@ -1311,9 +1506,11 @@ static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
>  			return ret;
>  		}
>  		hisi_acc_vdev->mig_state = VFIO_DEVICE_STATE_RUNNING;
> +		hisi_acc_vdev->dev_opened = DEV_OPEN;

 = true!

>  	}
>  
>  	vfio_pci_core_finish_enable(vdev);
> +
>  	return 0;
>  }
>  
> @@ -1322,7 +1519,10 @@ static void hisi_acc_vfio_pci_close_device(struct vfio_device *core_vdev)
>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
>  	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
>  
> +	hisi_acc_vdev->dev_opened = DEV_CLOSE;
> +	mutex_lock(&hisi_acc_vdev->enable_mutex);
>  	iounmap(vf_qm->io_base);
> +	mutex_unlock(&hisi_acc_vdev->enable_mutex);
>  	vfio_pci_core_close_device(core_vdev);
>  }
>  
> @@ -1413,6 +1613,9 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
>  	ret = vfio_pci_core_register_device(&hisi_acc_vdev->core_device);
>  	if (ret)
>  		goto out_put_vdev;
> +
> +	if (ops == &hisi_acc_vfio_pci_migrn_ops)
> +		hisi_acc_vfio_debug_init(hisi_acc_vdev);
>  	return 0;
>  
>  out_put_vdev:
> @@ -1425,6 +1628,7 @@ static void hisi_acc_vfio_pci_remove(struct pci_dev *pdev)
>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
>  
>  	vfio_pci_core_unregister_device(&hisi_acc_vdev->core_device);
> +	hisi_acc_vf_debugfs_exit(hisi_acc_vdev);
>  	vfio_put_device(&hisi_acc_vdev->core_device.vdev);
>  }
>  
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> index 7a9dc87627cd..3a20d81d105c 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> @@ -52,6 +52,11 @@
>  #define QM_EQC_DW0		0X8000
>  #define QM_AEQC_DW0		0X8020
>  
> +enum acc_dev_state {
> +	DEV_CLOSE = 0x0,
> +	DEV_OPEN,
> +};
> +
>  struct acc_vf_data {
>  #define QM_MATCH_SIZE offsetofend(struct acc_vf_data, qm_rsv_state)
>  	/* QM match information */
> @@ -114,5 +119,11 @@ struct hisi_acc_vf_core_device {
>  	int vf_id;
>  	struct hisi_acc_vf_migration_file *resuming_migf;
>  	struct hisi_acc_vf_migration_file *saving_migf;
> +
> +	/* To make sure the device is enabled */
> +	struct mutex enable_mutex;
> +	bool dev_opened;
> +	/* For debugfs */
> +	struct hisi_acc_vf_migration_file *debug_migf;
>  };
>  #endif /* HISI_ACC_VFIO_PCI_H */


