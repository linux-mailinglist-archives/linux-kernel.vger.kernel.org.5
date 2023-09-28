Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E917B2614
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjI1Tqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjI1Tqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:46:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5A21A8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695930360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60E5WNNxgSCl+tFz6iAjN5CoPA2wZHwA5yijdmM+h1U=;
        b=ZXxgfRVAugtyXWHUUKdEMrfzeNE7OBHk3oBM5DfFs2lNIwu6ccas79//76nrOTSRkKwoGy
        OpZrunhCUk6ycUg8neSQojzOfcQ5581BbvELNg44IkpXTG+gSdk7S/mRAgmrmrh/t5q7LO
        daYo4NPRBqsRtVAINJSAUYoUAG4qp0g=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-m8_hBWQSMquPi4uv0itooQ-1; Thu, 28 Sep 2023 15:45:59 -0400
X-MC-Unique: m8_hBWQSMquPi4uv0itooQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-797f3f27badso1674516539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695930358; x=1696535158;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=60E5WNNxgSCl+tFz6iAjN5CoPA2wZHwA5yijdmM+h1U=;
        b=tkAr0jnNz5omE8Tsv/Wf2v23bS74cHHCu1bqjzDbCiOaXpZpQoVyaIsXGuJOamZqNh
         mQ7Riu0Ger3iqVmpOSL43ETRZRHUxJyX/bLfN/tQKXZtfZMiYnfbL0WDN2ea5uJUWg4u
         hciO29R30k4kr8gheUC+uEpIlLjbtRjL2uN7K+fUrOIC/E48rkO+w8k3pfYDLAxVj4TD
         doCXWSB32GYTRsK4YPcJWvBmsV3liRnYLk4jJddMwl+h7bUpR4ohgplO3N1jKZ7i9Tl1
         7BUMcdETFsul6wdACzVy7REqXo8NAWLQBLhHckyf2mSSd/F9/mx8tt0Sbv3ejOMns6qY
         iXHA==
X-Gm-Message-State: AOJu0YwfTetyBRxihMD1jpqcdPpKNvwTkvoE+So6B6OvWtP3wL+NncOu
        n1wvCIlJZKY8uUW14B/Thxodee66gsw0+/7Jaun2+rDgfuG0r7YfmW+AQtM3k3sy9j28tAS42qJ
        fTNG2j650owj6aD+WMUWVPCFc
X-Received: by 2002:a5e:c908:0:b0:794:d833:4a8a with SMTP id z8-20020a5ec908000000b00794d8334a8amr2118400iol.0.1695930358344;
        Thu, 28 Sep 2023 12:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTIpcOxqtSjd2ba/myuh51/GOw731q/iLcMd6z1TSsoqJRnI+GIsSKs1QDQUKIYUTiWxiRog==
X-Received: by 2002:a5e:c908:0:b0:794:d833:4a8a with SMTP id z8-20020a5ec908000000b00794d8334a8amr2118389iol.0.1695930358047;
        Thu, 28 Sep 2023 12:45:58 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id z12-20020a6b5c0c000000b007864c26fd35sm4678742ioh.13.2023.09.28.12.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 12:45:57 -0700 (PDT)
Date:   Thu, 28 Sep 2023 13:45:50 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     <ankita@nvidia.com>
Cc:     <jgg@nvidia.com>, <akpm@linux-foundation.org>,
        <tony.luck@intel.com>, <bp@alien8.de>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, <aniketa@nvidia.com>, <cjia@nvidia.com>,
        <kwankhede@nvidia.com>, <targupta@nvidia.com>, <vsethi@nvidia.com>,
        <acurrid@nvidia.com>, <anuaggarwal@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-edac@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v1 4/4] vfio/nvgpu: register device memory for poison
 handling
Message-ID: <20230928134550.55fd9d8b.alex.williamson@redhat.com>
In-Reply-To: <20230920140210.12663-5-ankita@nvidia.com>
References: <20230920140210.12663-1-ankita@nvidia.com>
        <20230920140210.12663-5-ankita@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 19:32:10 +0530
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
>=20
> The nvgrace-gpu-vfio-pci module [1] maps the device memory to the user VA
> (Qemu) using remap_pfn_range() without adding the memory to the kernel.
> The device memory pages are not backed by struct page. Patches 1-3
> implements the mechanism to handle ECC/poison on memory page without
> struct page and expose a registration function. This new mechanism is
> leveraged here.
> =C2=A0
> The module registers its memory region with the kernel MM for ECC handling
> using the register_pfn_address_space() registration API exposed by the
> kernel. It also defines a failure callback function pfn_memory_failure()
> to get the poisoned PFN from the MM.
> =C2=A0
> The module track poisoned PFN as a bitmap with a bit per PFN. The PFN is
> communicated by the kernel MM to the module through the failure function,
> which sets the appropriate bit in the bitmap.
> =C2=A0
> The module also defines a VMA fault ops for the module. It returns
> VM_FAULT_HWPOISON in case the bit for the PFN is set in the bitmap.
>=20
> [1] https://lore.kernel.org/all/20230915025415.6762-1-ankita@nvidia.com/
>=20
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  drivers/vfio/pci/nvgrace-gpu/main.c | 107 +++++++++++++++++++++++++++-
>  drivers/vfio/vfio.h                 |  11 ---
>  drivers/vfio/vfio_main.c            |   3 +-
>  include/linux/vfio.h                |  15 ++++
>  4 files changed, 123 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgra=
ce-gpu/main.c
> index ba323f2d8ea1..1c89ce0cc1cc 100644
> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c
> @@ -6,6 +6,10 @@
>  #include <linux/pci.h>
>  #include <linux/vfio_pci_core.h>
>  #include <linux/vfio.h>
> +#ifdef CONFIG_MEMORY_FAILURE
> +#include <linux/bitmap.h>
> +#include <linux/memory-failure.h>
> +#endif
> =20
>  struct nvgrace_gpu_vfio_pci_core_device {
>  	struct vfio_pci_core_device core_device;
> @@ -13,8 +17,85 @@ struct nvgrace_gpu_vfio_pci_core_device {
>  	size_t memlength;
>  	void *memmap;
>  	struct mutex memmap_lock;
> +#ifdef CONFIG_MEMORY_FAILURE
> +	struct pfn_address_space pfn_address_space;
> +	unsigned long *pfn_bitmap;
> +#endif
>  };
> =20
> +#ifdef CONFIG_MEMORY_FAILURE
> +void nvgrace_gpu_vfio_pci_pfn_memory_failure(struct pfn_address_space *p=
fn_space,
> +		unsigned long pfn)
> +{
> +	struct nvgrace_gpu_vfio_pci_core_device *nvdev =3D container_of(
> +		pfn_space, struct nvgrace_gpu_vfio_pci_core_device, pfn_address_space);
> +	unsigned long mem_offset =3D pfn - pfn_space->node.start;
> +
> +	if (mem_offset >=3D nvdev->memlength)
> +		return;
> +
> +	/*
> +	 * MM has called to notify a poisoned page. Track that in the bitmap.
> +	 */
> +	__set_bit(mem_offset, nvdev->pfn_bitmap);
> +}
> +
> +struct pfn_address_space_ops nvgrace_gpu_vfio_pci_pas_ops =3D {
> +	.failure =3D nvgrace_gpu_vfio_pci_pfn_memory_failure,
> +};
> +
> +static int
> +nvgrace_gpu_vfio_pci_register_pfn_range(struct nvgrace_gpu_vfio_pci_core=
_device *nvdev,
> +					struct vm_area_struct *vma)
> +{
> +	unsigned long nr_pages;
> +	int ret =3D 0;
> +
> +	nr_pages =3D nvdev->memlength >> PAGE_SHIFT;
> +
> +	nvdev->pfn_address_space.node.start =3D vma->vm_pgoff;
> +	nvdev->pfn_address_space.node.last =3D vma->vm_pgoff + nr_pages - 1;
> +	nvdev->pfn_address_space.ops =3D &nvgrace_gpu_vfio_pci_pas_ops;
> +	nvdev->pfn_address_space.mapping =3D vma->vm_file->f_mapping;
> +
> +	ret =3D register_pfn_address_space(&(nvdev->pfn_address_space));
> +
> +	return ret;
> +}
> +
> +static vm_fault_t nvgrace_gpu_vfio_pci_fault(struct vm_fault *vmf)
> +{
> +	unsigned long mem_offset =3D vmf->pgoff - vmf->vma->vm_pgoff;
> +	struct vfio_device *core_vdev;
> +	struct nvgrace_gpu_vfio_pci_core_device *nvdev;
> +
> +	if (!(vmf->vma->vm_file))
> +		goto error_exit;
> +
> +	core_vdev =3D vfio_device_from_file(vmf->vma->vm_file);
> +
> +	if (!core_vdev)
> +		goto error_exit;
> +
> +	nvdev =3D container_of(core_vdev,
> +			struct nvgrace_gpu_vfio_pci_core_device, core_device.vdev);
> +
> +	/*
> +	 * Check if the page is poisoned.
> +	 */
> +	if (mem_offset < (nvdev->memlength >> PAGE_SHIFT) &&
> +		test_bit(mem_offset, nvdev->pfn_bitmap))
> +		return VM_FAULT_HWPOISON;
> +
> +error_exit:
> +	return VM_FAULT_ERROR;
> +}
> +
> +static const struct vm_operations_struct nvgrace_gpu_vfio_pci_mmap_ops =
=3D {
> +	.fault =3D nvgrace_gpu_vfio_pci_fault,
> +};
> +#endif
> +
>  static int nvgrace_gpu_vfio_pci_open_device(struct vfio_device *core_vde=
v)
>  {
>  	struct vfio_pci_core_device *vdev =3D
> @@ -46,6 +127,9 @@ static void nvgrace_gpu_vfio_pci_close_device(struct v=
fio_device *core_vdev)
> =20
>  	mutex_destroy(&nvdev->memmap_lock);
> =20
> +#ifdef CONFIG_MEMORY_FAILURE
> +	unregister_pfn_address_space(&(nvdev->pfn_address_space));
> +#endif
>  	vfio_pci_core_close_device(core_vdev);
>  }
> =20
> @@ -104,8 +188,12 @@ static int nvgrace_gpu_vfio_pci_mmap(struct vfio_dev=
ice *core_vdev,
>  		return ret;
> =20
>  	vma->vm_pgoff =3D start_pfn;
> +#ifdef CONFIG_MEMORY_FAILURE
> +	vma->vm_ops =3D &nvgrace_gpu_vfio_pci_mmap_ops;
> =20
> -	return 0;
> +	ret =3D nvgrace_gpu_vfio_pci_register_pfn_range(nvdev, vma);
> +#endif
> +	return ret;
>  }
> =20
>  static long
> @@ -406,6 +494,19 @@ nvgrace_gpu_vfio_pci_fetch_memory_property(struct pc=
i_dev *pdev,
> =20
>  	nvdev->memlength =3D memlength;
> =20
> +#ifdef CONFIG_MEMORY_FAILURE
> +	/*
> +	 * A bitmap is maintained to track the pages that are poisoned. Each
> +	 * page is represented by a bit. Allocation size in bytes is
> +	 * determined by shifting the device memory size by PAGE_SHIFT to
> +	 * determine the number of pages; and further shifted by 3 as each
> +	 * byte could track 8 pages.
> +	 */
> +	nvdev->pfn_bitmap
> +		=3D vzalloc((nvdev->memlength >> PAGE_SHIFT)/BITS_PER_TYPE(char));
> +	if (!nvdev->pfn_bitmap)
> +		ret =3D -ENOMEM;
> +#endif
>  	return ret;
>  }
> =20
> @@ -442,6 +543,10 @@ static void nvgrace_gpu_vfio_pci_remove(struct pci_d=
ev *pdev)
>  	struct nvgrace_gpu_vfio_pci_core_device *nvdev =3D nvgrace_gpu_drvdata(=
pdev);
>  	struct vfio_pci_core_device *vdev =3D &nvdev->core_device;
> =20
> +#ifdef CONFIG_MEMORY_FAILURE
> +	vfree(nvdev->pfn_bitmap);
> +#endif
> +
>  	vfio_pci_core_unregister_device(vdev);
>  	vfio_put_device(&vdev->vdev);
>  }
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 307e3f29b527..747094503909 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -16,17 +16,6 @@ struct iommufd_ctx;
>  struct iommu_group;
>  struct vfio_container;
> =20
> -struct vfio_device_file {
> -	struct vfio_device *device;
> -	struct vfio_group *group;
> -
> -	u8 access_granted;
> -	u32 devid; /* only valid when iommufd is valid */
> -	spinlock_t kvm_ref_lock; /* protect kvm field */
> -	struct kvm *kvm;
> -	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lo=
ck */
> -};
> -
>  void vfio_device_put_registration(struct vfio_device *device);
>  bool vfio_device_try_get_registration(struct vfio_device *device);
>  int vfio_df_open(struct vfio_device_file *df);
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 40732e8ed4c6..a7dafd7c64a6 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1309,7 +1309,7 @@ const struct file_operations vfio_device_fops =3D {
>  	.mmap		=3D vfio_device_fops_mmap,
>  };
> =20
> -static struct vfio_device *vfio_device_from_file(struct file *file)
> +struct vfio_device *vfio_device_from_file(struct file *file)
>  {
>  	struct vfio_device_file *df =3D file->private_data;
> =20
> @@ -1317,6 +1317,7 @@ static struct vfio_device *vfio_device_from_file(st=
ruct file *file)
>  		return NULL;
>  	return df->device;
>  }
> +EXPORT_SYMBOL_GPL(vfio_device_from_file);
> =20
>  /**
>   * vfio_file_is_valid - True if the file is valid vfio file
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 454e9295970c..d88af251e931 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -361,4 +361,19 @@ int vfio_virqfd_enable(void *opaque, int (*handler)(=
void *, void *),
>  		       struct virqfd **pvirqfd, int fd);
>  void vfio_virqfd_disable(struct virqfd **pvirqfd);
> =20
> +/*
> + * VFIO device file.
> + */
> +struct vfio_device_file {
> +	struct vfio_device *device;
> +	struct vfio_group *group;
> +	u8 access_granted;
> +	u32 devid; /* only valid when iommufd is valid */
> +	spinlock_t kvm_ref_lock; /* protect kvm field */
> +	struct kvm *kvm;
> +	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lo=
ck */
> +};

What here necessitates moving this to the more public header?  Thanks,

Alex

> +
> +struct vfio_device *vfio_device_from_file(struct file *file);
> +
>  #endif /* VFIO_H */

