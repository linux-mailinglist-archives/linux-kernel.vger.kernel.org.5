Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4E277E7DE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344763AbjHPRra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbjHPRrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:47:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB03F7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692207975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIcyWOk8ct32MvKJ0/Egg3F3gig3WNdJKpxeA9uIkj4=;
        b=U/fporrQw8dR73xGj3/QLH6sLffy2GFcQGciQraLPCdxsvaGa5AZF71A8gywDNp4ntKMK6
        hU1DPQPsChoXovgrsqz4y44A5QknjRKprcJM/NGsmhyqAiMDKvz7S1abPijAX7ibnro6Nx
        P1rIeXrFrI02HJwvVrVnasjC21Vxlcw=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-7fyLDbKUPYiK5fuwBDT_Jg-1; Wed, 16 Aug 2023 13:46:14 -0400
X-MC-Unique: 7fyLDbKUPYiK5fuwBDT_Jg-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-790a9d5b74cso5444139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692207973; x=1692812773;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EIcyWOk8ct32MvKJ0/Egg3F3gig3WNdJKpxeA9uIkj4=;
        b=UxEZ7F+RwMsb7Xl5lx+pGXuJjR1pbI197/z/xwHWV140JodWJ/jxnqbV/KNwUF5R4C
         MVcYEQhsLdsLe56Y8hYLevPSU/Lp1Yoww/QfQ+LIU18wk1EFcYi2AsyTBveh2wjjAaNs
         pIgDXf2BMj4QBL07WexHwEw002K+hx91BGZIZJfI+B3x3CpKqTs6XPk8He6+CXDFgx9U
         Yce7od8yjbRke/m2CMW67fEQgGLPPRaBfBDPgNmP76bZYI8n2ADJ1Bv96Lj9fQf0d84p
         /wDYpKK+bcLGO/Z7twGSKoHm3CTNCWHRflAalPala6peyFXw1geYGjnjhqIpef5AhD2Q
         47Lg==
X-Gm-Message-State: AOJu0YyZOKf6dcsEz5bCdDTErWp2pHRoZS+UQfLnrn7+6FSz7+YS76Mn
        SbCQ3nqsY6YFSmyWV7GbWaf0prWRweHE/TQKRptHKOt1kYnYE0c4j+XR/5Qu/bxCnSGsutCfzHw
        OQoA4YRQVBgZS0QRq7ToqQTWs
X-Received: by 2002:a05:6602:4252:b0:783:3899:e1d7 with SMTP id cc18-20020a056602425200b007833899e1d7mr467134iob.2.1692207973284;
        Wed, 16 Aug 2023 10:46:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpd7qT1AzUsiVSWK8a2LueJWSPxZC1QISs1xCpH2iUKtYPS16fOFHEl1Y/Pqf8gB0adN5sKw==
X-Received: by 2002:a05:6602:4252:b0:783:3899:e1d7 with SMTP id cc18-20020a056602425200b007833899e1d7mr467115iob.2.1692207973050;
        Wed, 16 Aug 2023 10:46:13 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id t3-20020a056602180300b00790af7745b1sm4831179ioh.20.2023.08.16.10.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 10:46:12 -0700 (PDT)
Date:   Wed, 16 Aug 2023 11:46:10 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, Shubham Rohila <shubham.rohila@amd.com>
Subject: Re: [PATCH v6 3/3] vfio-cdx: add bus mastering device feature
 support
Message-ID: <20230816114610.79c9eccc.alex.williamson@redhat.com>
In-Reply-To: <20230810084409.4922-3-nipun.gupta@amd.com>
References: <20230810084409.4922-1-nipun.gupta@amd.com>
        <20230810084409.4922-3-nipun.gupta@amd.com>
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

On Thu, 10 Aug 2023 14:14:09 +0530
Nipun Gupta <nipun.gupta@amd.com> wrote:

> Support Bus master enable and disable on VFIO-CDX devices using
> VFIO_DEVICE_FEATURE_BUS_MASTER flag over VFIO_DEVICE_FEATURE IOCTL.
> 
> Co-developed-by: Shubham Rohila <shubham.rohila@amd.com>
> Signed-off-by: Shubham Rohila <shubham.rohila@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> ---
> 
> Changes v5->v6:
> - Called CDX device reset at cdx_open_device()
> 
> Changes v4->v5:
> - Use device feature IOCTL instead of adding a new VFIO IOCTL
>   for bus master feature.
> 
> Changes in v4:
> - This patch is newly added which uses cdx_set_master() and
>   cdx_clear_master() APIs.
> 
>  drivers/vfio/cdx/main.c | 46 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
> index c376a69d2db2..bf0e1f56e0f9 100644
> --- a/drivers/vfio/cdx/main.c
> +++ b/drivers/vfio/cdx/main.c
> @@ -14,7 +14,7 @@ static int vfio_cdx_open_device(struct vfio_device *core_vdev)
>  		container_of(core_vdev, struct vfio_cdx_device, vdev);
>  	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
>  	int count = cdx_dev->res_count;
> -	int i;
> +	int i, ret;
>  
>  	vdev->regions = kcalloc(count, sizeof(struct vfio_cdx_region),
>  				GFP_KERNEL_ACCOUNT);
> @@ -39,8 +39,11 @@ static int vfio_cdx_open_device(struct vfio_device *core_vdev)
>  		if (!(cdx_dev->res[i].flags & IORESOURCE_READONLY))
>  			vdev->regions[i].flags |= VFIO_REGION_INFO_FLAG_WRITE;
>  	}
> +	ret = cdx_dev_reset(core_vdev->dev);
> +	if (ret)
> +		kfree(vdev->regions);

AIUI, this reset clears bus master, but per the first patch in the
series the ability to set or clear bus master depends on whether the
underlying cdx_ops supports dev_configure.  Apparently all currently
do, but will that always be true?

It seems like this could make a gratuitous call to cdx_clear_master()
to validate the return value and only conditionally support this device
feature based on that result (or fail the device open if it's meant to
be required).

It might also be a good idea to set vdev->regions = NULL in the error
path to avoid the possibility of a double-free.  Thanks,

Alex

>  
> -	return 0;
> +	return ret;
>  }
>  
>  static void vfio_cdx_close_device(struct vfio_device *core_vdev)
> @@ -52,6 +55,44 @@ static void vfio_cdx_close_device(struct vfio_device *core_vdev)
>  	cdx_dev_reset(core_vdev->dev);
>  }
>  
> +static int vfio_cdx_bm_ctrl(struct vfio_device *core_vdev, u32 flags,
> +			    void __user *arg, size_t argsz)
> +{
> +	size_t minsz =
> +		offsetofend(struct vfio_device_feature_bus_master, op);
> +	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
> +	struct vfio_device_feature_bus_master ops;
> +	int ret;
> +
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(ops));
> +	if (ret != 1)
> +		return ret;
> +
> +	if (copy_from_user(&ops, arg, minsz))
> +		return -EFAULT;
> +
> +	switch (ops.op) {
> +	case VFIO_DEVICE_FEATURE_CLEAR_MASTER:
> +		return cdx_clear_master(cdx_dev);
> +	case VFIO_DEVICE_FEATURE_SET_MASTER:
> +		return cdx_set_master(cdx_dev);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int vfio_cdx_ioctl_feature(struct vfio_device *device, u32 flags,
> +				  void __user *arg, size_t argsz)
> +{
> +	switch (flags & VFIO_DEVICE_FEATURE_MASK) {
> +	case VFIO_DEVICE_FEATURE_BUS_MASTER:
> +		return vfio_cdx_bm_ctrl(device, flags, arg, argsz);
> +	default:
> +		return -ENOTTY;
> +	}
> +}
> +
>  static int vfio_cdx_ioctl_get_info(struct vfio_cdx_device *vdev,
>  				   struct vfio_device_info __user *arg)
>  {
> @@ -169,6 +210,7 @@ static const struct vfio_device_ops vfio_cdx_ops = {
>  	.open_device	= vfio_cdx_open_device,
>  	.close_device	= vfio_cdx_close_device,
>  	.ioctl		= vfio_cdx_ioctl,
> +	.device_feature = vfio_cdx_ioctl_feature,
>  	.mmap		= vfio_cdx_mmap,
>  	.bind_iommufd	= vfio_iommufd_physical_bind,
>  	.unbind_iommufd	= vfio_iommufd_physical_unbind,

