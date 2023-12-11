Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A5480D4E7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345152AbjLKSDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345117AbjLKSDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:03:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA83E95
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702317832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MaxmWb0gmmOa2NNadHjgN+9H3pLxhDx5JIlGNJciyGA=;
        b=Pouv8Xf3Zy3EV+ekmlFj9KlaZy0AKLgUG1P+4QRZt94FJM1oQ2mS/SLwewXRNTn6Nx2QDE
        hG3U/OPd6IyD9lwNPnVi7zX1E23chMEd/CvtkiNHOnVyYblyytW9AhLDMYMXCrnisFhrqh
        gtK9gWSxEIk0jVwFQF/Zy/9EHRG8C50=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-92kqU4hkP_m4AteO-dRIaw-1; Mon, 11 Dec 2023 13:03:50 -0500
X-MC-Unique: 92kqU4hkP_m4AteO-dRIaw-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6d9feae8dfdso3690083a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317829; x=1702922629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaxmWb0gmmOa2NNadHjgN+9H3pLxhDx5JIlGNJciyGA=;
        b=ha+pyRdLpy0v2JaOngpSsHVoa/TySFT1GgA95ZJGoYH22jx7OP32qO1VTb5Flk257b
         csDdIvO71FIj72dIUyVyD4oATMviQXlo5bLjcafqjzovaLuaD3PegMWD4X1v5hlupqSP
         ccrynIkxz4B8suqURazrL6MGLWKXXNqws4lvvWhFqwjkmKZs6rbEWPCPfKXF7Xt6/H3G
         U6Jo7F2NGMANo62W7TckpQHvouFJgHD7k5H5krig9i1qa7UkIZNbeBXYLCeLGkPvY7t6
         RwMSsosf+2ckYRRT589yoEh9zXRoZBHetMgbJzDLD6KjqGgO682NZanqq/Ju9PPfsTxM
         ikng==
X-Gm-Message-State: AOJu0YwoSKFrgFYq/fJ91lQjehtS/06tUNbMGfLPme/+x6lYQcb1uPga
        4vy2Nxv24kzxGzGzud2QkYjyhTpXBH2DiP0kUan+jDqM+Ev2BRA/kjIHry3Hu/QcyneLhVX9RgI
        NAcz6QO0/e+h1rvKe5dEEd34U
X-Received: by 2002:a9d:4e8f:0:b0:6d8:8053:af56 with SMTP id v15-20020a9d4e8f000000b006d88053af56mr5256028otk.39.1702317829724;
        Mon, 11 Dec 2023 10:03:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSgJpcgGM/uc3eXwfGlIeFBE+F5c01rkGI5ZWrgUL/mGmyGdintBKaoq0B478Ka1tOjndr+w==
X-Received: by 2002:a9d:4e8f:0:b0:6d8:8053:af56 with SMTP id v15-20020a9d4e8f000000b006d88053af56mr5256002otk.39.1702317829439;
        Mon, 11 Dec 2023 10:03:49 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id c25-20020a9d6859000000b006d9a7a7048asm1827521oto.49.2023.12.11.10.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 10:03:48 -0800 (PST)
Date:   Mon, 11 Dec 2023 11:03:45 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
        xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: Re: [PATCH 3/3] vfio: Report PASID capability via
 VFIO_DEVICE_FEATURE ioctl
Message-ID: <20231211110345.1b4526c6.alex.williamson@redhat.com>
In-Reply-To: <20231127063909.129153-4-yi.l.liu@intel.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
        <20231127063909.129153-4-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2023 22:39:09 -0800
Yi Liu <yi.l.liu@intel.com> wrote:

> This reports the PASID capability data to userspace via VFIO_DEVICE_FEATURE,
> hence userspace could probe PASID capability by it. This is a bit different
> with other capabilities which are reported to userspace when the user reads
> the device's PCI configuration space. There are two reasons for this.
> 
>  - First, Qemu by default exposes all available PCI capabilities in vfio-pci
>    config space to the guest as read-only, so adding PASID capability in the
>    vfio-pci config space will make it exposed to the guest automatically while
>    an old Qemu doesn't really support it.

Shouldn't we also be working on hiding the PASID capability in QEMU
ASAP?  This feature only allows QEMU to know PASID control is actually
available, not the guest.  Maybe we're hoping this is really only used
by VFs where there's no capability currently exposed to the guest?

>  - Second, PASID capability does not exit on VFs (instead shares the cap of

s/exit/exist/

>    the PF). Creating a virtual PASID capability in vfio-pci config space needs
>    to find a hole to place it, but doing so may require device specific
>    knowledge to avoid potential conflict with device specific registers like
>    hiden bits in VF config space. It's simpler by moving this burden to the
>    VMM instead of maintaining a quirk system in the kernel.

This feels a bit like an incomplete solution though and we might
already posses device specific knowledge in the form of a variant
driver.  Should this feature structure include a flag + field that
could serve to generically indicate to the VMM a location for
implementing the PASID capability?  The default core implementation
might fill this only for PFs where clearly an emualted PASID capability
can overlap the physical capability.  Thanks,

Alex

> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 47 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h        | 13 +++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 1929103ee59a..8038aa45500e 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1495,6 +1495,51 @@ static int vfio_pci_core_feature_token(struct vfio_device *device, u32 flags,
>  	return 0;
>  }
>  
> +static int vfio_pci_core_feature_pasid(struct vfio_device *device, u32 flags,
> +				       struct vfio_device_feature_pasid __user *arg,
> +				       size_t argsz)
> +{
> +	struct vfio_pci_core_device *vdev =
> +		container_of(device, struct vfio_pci_core_device, vdev);
> +	struct vfio_device_feature_pasid pasid = { 0 };
> +	struct pci_dev *pdev = vdev->pdev;
> +	u32 capabilities = 0;
> +	int ret;
> +
> +	/* We do not support SET of the PASID capability */
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
> +				 sizeof(pasid));
> +	if (ret != 1)
> +		return ret;
> +
> +	/*
> +	 * Needs go to PF if the device is VF as VF shares its PF's
> +	 * PASID Capability.
> +	 */
> +	if (pdev->is_virtfn)
> +		pdev = pci_physfn(pdev);
> +
> +	if (!pdev->pasid_enabled)
> +		goto out;
> +
> +#ifdef CONFIG_PCI_PASID
> +	pci_read_config_dword(pdev, pdev->pasid_cap + PCI_PASID_CAP,
> +			      &capabilities);
> +#endif
> +
> +	if (capabilities & PCI_PASID_CAP_EXEC)
> +		pasid.capabilities |= VFIO_DEVICE_PASID_CAP_EXEC;
> +	if (capabilities & PCI_PASID_CAP_PRIV)
> +		pasid.capabilities |= VFIO_DEVICE_PASID_CAP_PRIV;
> +
> +	pasid.width = (capabilities >> 8) & 0x1f;
> +
> +out:
> +	if (copy_to_user(arg, &pasid, sizeof(pasid)))
> +		return -EFAULT;
> +	return 0;
> +}
> +
>  int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  				void __user *arg, size_t argsz)
>  {
> @@ -1508,6 +1553,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  		return vfio_pci_core_pm_exit(device, flags, arg, argsz);
>  	case VFIO_DEVICE_FEATURE_PCI_VF_TOKEN:
>  		return vfio_pci_core_feature_token(device, flags, arg, argsz);
> +	case VFIO_DEVICE_FEATURE_PASID:
> +		return vfio_pci_core_feature_pasid(device, flags, arg, argsz);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 495193629029..8326faf8622b 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1512,6 +1512,19 @@ struct vfio_device_feature_bus_master {
>  };
>  #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
>  
> +/**
> + * Upon VFIO_DEVICE_FEATURE_GET, return the PASID capability for the device.
> + * Zero width means no support for PASID.
> + */
> +struct vfio_device_feature_pasid {
> +	__u16 capabilities;
> +#define VFIO_DEVICE_PASID_CAP_EXEC	(1 << 0)
> +#define VFIO_DEVICE_PASID_CAP_PRIV	(1 << 1)
> +	__u8 width;
> +	__u8 __reserved;
> +};
> +#define VFIO_DEVICE_FEATURE_PASID 11
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**

