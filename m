Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF78B763D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjGZREQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGZREO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE7EE73
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690391006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YTHU5KGIN72XwRDX6Te2xrLhuE/MJIHjmFdCC4F9WgQ=;
        b=CoMf+OV1MhkscUn4v24gxwQVS9RWnYP9RSXuEXdcd9vHYBuVJ3f2jexe66Q/8fYfGa1Z1H
        r10mMGk0ul6BFJpbQAh+WS571NMeRvrKNJ52yzDDeJQRsOea3ELXAZh9bZmwnlUOM/R2ce
        42TGY8bFv9JceMXYFGNYrYY20ae5VzU=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-Lid0hWSpMZGkw8_gRmDNSw-1; Wed, 26 Jul 2023 13:03:25 -0400
X-MC-Unique: Lid0hWSpMZGkw8_gRmDNSw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7867b689079so458962139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690391004; x=1690995804;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTHU5KGIN72XwRDX6Te2xrLhuE/MJIHjmFdCC4F9WgQ=;
        b=kAk/e6ljl8EyhnrrtEIv3TSFrqLBftKYW49EZWZpJ1QIQSX6zRDnaPiqi617BZqReO
         OHjJ6i3lf5YrDNAPaJ/PBSgBPGXavDSDlFKzrRtSAG36heAy3/vrQ+xKqhbO6XrWT8w4
         L7Ym2toSlT6nf4Ow58YQV6Ei1ZXhgHc5TzgckIkTLWLQWs0zudtSEdjC1TG/vLseL35g
         Vc6AT/U1oPuTrk854zvgFkAH/kSqNv5Bn1qMqsCA7d2pQGgIL7oplqjdfHun8vDG2MTD
         dXkI7y/tC2fvEVeq4ex+7ZsLKR7IFKEjq0ixKdRGrrYhiwuPzfEYoqKWP4te4rsNhtiy
         UjOA==
X-Gm-Message-State: ABy/qLZsJgs/XjGljq+jH9QruknKdkiOXuwZr20Qu2D0sDNIfK9mHM3b
        K5lXc+ytCChq+fH38D/Y3fyZhyXzjt0c2+1gAsSTFibVch/nRHZxja/Vae2B/x/KlvsBuxoCHK5
        eoDZHg38GNXjPiIFE2ahy80hf
X-Received: by 2002:a05:6602:2292:b0:783:58d1:823a with SMTP id d18-20020a056602229200b0078358d1823amr2667769iod.9.1690391004233;
        Wed, 26 Jul 2023 10:03:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHKhzdrZ8CYPYrnkLHmtugF6D488N0jJO2lhuSyPa/mW0zSXSJEPulne0bCiFwAsS01Lz4Hfg==
X-Received: by 2002:a05:6602:2292:b0:783:58d1:823a with SMTP id d18-20020a056602229200b0078358d1823amr2667743iod.9.1690391003984;
        Wed, 26 Jul 2023 10:03:23 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id i21-20020a02cc55000000b0041627abe120sm4279288jaq.160.2023.07.26.10.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 10:03:23 -0700 (PDT)
Date:   Wed, 26 Jul 2023 11:03:22 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, Shubham Rohila <shubham.rohila@amd.com>
Subject: Re: [PATCH 2/2 v4] vfio-cdx: add ioctl support for bus master
 enable
Message-ID: <20230726110322.7074371a.alex.williamson@redhat.com>
In-Reply-To: <20230726110220.26486-2-nipun.gupta@amd.com>
References: <20230726110220.26486-1-nipun.gupta@amd.com>
        <20230726110220.26486-2-nipun.gupta@amd.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 16:32:20 +0530
Nipun Gupta <nipun.gupta@amd.com> wrote:

> add VFIO_DEVICE_CDX_CTRL IOCTL to expose control operations for CDX
> devices to VFIO users. Support Bus master enable and Bus master disable
> on CDX bus control.
> 
> Signed-off-by: Shubham Rohila <shubham.rohila@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> ---
> 
> Changes in v4:
> - This patch is newly added which uses cdx_set_master() and
>   cdx_clear_master() APIs.
> 
>  drivers/vfio/cdx/main.c   | 26 ++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h | 14 ++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
> index c376a69d2db2..c39a965716f4 100644
> --- a/drivers/vfio/cdx/main.c
> +++ b/drivers/vfio/cdx/main.c
> @@ -98,6 +98,30 @@ static int vfio_cdx_ioctl_get_region_info(struct vfio_cdx_device *vdev,
>  	return copy_to_user(arg, &info, minsz) ? -EFAULT : 0;
>  }
>  
> +static int vfio_cdx_ioctl_ctrl(struct vfio_cdx_device *vdev,
> +			       struct vfio_device_cdx_ctrl __user *arg)
> +{
> +	unsigned long minsz = offsetofend(struct vfio_device_cdx_ctrl, op);
> +	struct cdx_device *cdx_dev = to_cdx_device(vdev->vdev.dev);
> +	struct vfio_device_cdx_ctrl ops;
> +
> +	if (copy_from_user(&ops, arg, minsz))
> +		return -EFAULT;
> +
> +	if (ops.argsz < minsz)
> +		return -EINVAL;
> +
> +	switch (ops.op) {
> +	case VFIO_CDX_CTRL_CLEAR_MASTER:
> +		cdx_clear_master(cdx_dev);
> +		return 0;
> +	case VFIO_CDX_CTRL_SET_MASTER:
> +		return cdx_set_master(cdx_dev);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static long vfio_cdx_ioctl(struct vfio_device *core_vdev,
>  			   unsigned int cmd, unsigned long arg)
>  {
> @@ -112,6 +136,8 @@ static long vfio_cdx_ioctl(struct vfio_device *core_vdev,
>  		return vfio_cdx_ioctl_get_region_info(vdev, uarg);
>  	case VFIO_DEVICE_RESET:
>  		return cdx_dev_reset(core_vdev->dev);
> +	case VFIO_DEVICE_CDX_CTRL:
> +		return vfio_cdx_ioctl_ctrl(vdev, uarg);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 20c804bdc09c..5f6a58f9f8e2 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1649,6 +1649,20 @@ struct vfio_iommu_spapr_tce_remove {
>  };
>  #define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
>  
> +/**
> + * VFIO_DEVICE_CDX_CTRL - _IO(VFIO_TYPE, VFIO_BASE + 21)
> + *
> + * Control CDX device.
> + * Variable op is set as per the operation required
> + */
> +struct vfio_device_cdx_ctrl {
> +	__u32 argsz;
> +	__u32 op;
> +#define	VFIO_CDX_CTRL_SET_MASTER	0	/* Set Bus Master */
> +#define	VFIO_CDX_CTRL_CLEAR_MASTER	1	/* Clear Bus Master */
> +};
> +#define VFIO_DEVICE_CDX_CTRL		_IO(VFIO_TYPE, VFIO_BASE + 21)
> +
>  /* ***************************************************************** */
>  
>  #endif /* _UAPIVFIO_H */

This doesn't follow standard conventions for a vfio ioctl.  Not knowing
how CDX works, is there really a need for this ioctl vs enabling bus
master when the device is opened and clearing it when closed?  I think
this is effectively the behavior of vfio-platform.  Otherwise, I assume
this is not a high frequency operation, would the VFIO_DEVICE_FEATURE
ioctl be an option?  Thanks,

Alex

