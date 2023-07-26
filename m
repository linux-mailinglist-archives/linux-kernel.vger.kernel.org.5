Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D092B7634D0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGZLZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjGZLZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:25:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209B897
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:25:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B242361A85
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08D6C433C8;
        Wed, 26 Jul 2023 11:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690370719;
        bh=G0ZHclprnAKGh08HDuEVoKmi5Z1e944LtvO1D7EFHfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LsShpcp4Q8eQfCBn9BBPQyJbpzZGId8X+EypF9p037pIFrgcDjypCOfFVyOZ5QUD9
         fqtOx2GFDsJ5+oGhLQD/MjUCUQas7SzC1bszzgbGh/aFkoSu6NMuIgHuB81g7OUdwM
         ISvohArvQF2vpRAce5zKUxW1CIWdo/PszYXM+waI=
Date:   Wed, 26 Jul 2023 13:25:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        git@amd.com, pieter.jansen-van-vuuren@amd.com,
        nikhil.agarwal@amd.com, michal.simek@amd.com,
        abhijit.gangurde@amd.com, Shubham Rohila <shubham.rohila@amd.com>
Subject: Re: [PATCH 2/2 v4] vfio-cdx: add ioctl support for bus master enable
Message-ID: <2023072622-frolic-gave-4965@gregkh>
References: <20230726110220.26486-1-nipun.gupta@amd.com>
 <20230726110220.26486-2-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726110220.26486-2-nipun.gupta@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 04:32:20PM +0530, Nipun Gupta wrote:
> add VFIO_DEVICE_CDX_CTRL IOCTL to expose control operations for CDX
> devices to VFIO users. Support Bus master enable and Bus master disable
> on CDX bus control.
> 
> Signed-off-by: Shubham Rohila <shubham.rohila@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>

Who wrote this?  The signed-off-by ordering seems odd.


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

But what is argsz set to?

> + */
> +struct vfio_device_cdx_ctrl {
> +	__u32 argsz;
> +	__u32 op;
> +#define	VFIO_CDX_CTRL_SET_MASTER	0	/* Set Bus Master */
> +#define	VFIO_CDX_CTRL_CLEAR_MASTER	1	/* Clear Bus Master */
> +};
> +#define VFIO_DEVICE_CDX_CTRL		_IO(VFIO_TYPE, VFIO_BASE + 21)
> +

Doesn't vfio stuff require a spec and agreement on the interface
somewhere?  Has that happened here already?

And why an ioctl?  Why would userspace care about this type of control?

thanks,

greg k-h
