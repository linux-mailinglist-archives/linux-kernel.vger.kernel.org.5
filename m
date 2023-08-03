Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50BF76F58B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjHCWS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHCWSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DEC212D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 15:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691101060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lqedb5Fh2GKdlL893XHwOHHQcIrfE339xeTI9boUP/I=;
        b=M9Y1AGSl04goC8blzsGcTKhN3dSQW+QF3BBbxThaqfKGJ1qQP+kFDULWYiCNfv898St+r9
        /0VRfgAwDEOvYKM5xhtqhpVvJEAr2OP4aSXJomzwb3j2eOpHSozWBLNWz0lYjmI1cpup0U
        QoQzROMxwAqa+vzKNQ3gijk47sHjo+E=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-v310EfzCNw--AGcIdNTgiw-1; Thu, 03 Aug 2023 18:17:38 -0400
X-MC-Unique: v310EfzCNw--AGcIdNTgiw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-790c9aa32d5so121324739f.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 15:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691101058; x=1691705858;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lqedb5Fh2GKdlL893XHwOHHQcIrfE339xeTI9boUP/I=;
        b=L+1AqBdc5+5my4sdaJLBUPafF2XLwZkMhHvRHf0pfaG3/nLQbjW74+q+4gKij+ocH+
         siWa7voRUtSg7hv8aKEA+gOaE1OZkWQT0JY4PxZwmHIVsFWs7Ic3Lz0xfuHLnTi1iIeF
         xACOCNh633I/aqFBR01a+2sZbj5OL746WuwiGMNJaiG6p1e9AVptjvMrRjn/8FSyYQi5
         7Fd5StLmHs54OuRYSExsr/wQc9ULuFAwiRb2jT9ZZezzAkYM0Lzok44Hk1nblOKLLPNc
         myexCFc6DYShaPGKYmO0SmHm0BOE23Iz7XpCpH0zaYr5buLxLdMtr4ZHkaGSnDOyCZcc
         JOCg==
X-Gm-Message-State: ABy/qLaNFuDY9r0/eVIAQBBbRcP6ns6CulsC5DA7159mcuI+bhKZH9oe
        sJxYpRIPjWwM1HH1FkTYMzM8K1Ukff40cnuwcDG83GucdAXPYu9L+Bw1goFMr1bbU7E9/F6wTAQ
        iyDR4bE6ILaPDeA3Ec4IeQrwz
X-Received: by 2002:a5d:844d:0:b0:786:cd9c:cf9e with SMTP id w13-20020a5d844d000000b00786cd9ccf9emr18727030ior.2.1691101058213;
        Thu, 03 Aug 2023 15:17:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGSyK/bEo7iAkn941jWSV/BPUv2B+b2Vh3zAwcSZE86Jpcaf29lKw3x1SglFVNEYIC1xKAFYQ==
X-Received: by 2002:a5d:844d:0:b0:786:cd9c:cf9e with SMTP id w13-20020a5d844d000000b00786cd9ccf9emr18727001ior.2.1691101057872;
        Thu, 03 Aug 2023 15:17:37 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id ei2-20020a05663829a200b00428737ce527sm176504jab.63.2023.08.03.15.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 15:17:37 -0700 (PDT)
Date:   Thu, 3 Aug 2023 16:17:36 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, Shubham Rohila <shubham.rohila@amd.com>
Subject: Re: [PATCH v5 3/3] vfio-cdx: add bus mastering device feature
 support
Message-ID: <20230803161736.52dd2d33.alex.williamson@redhat.com>
In-Reply-To: <20230803143253.7817-3-nipun.gupta@amd.com>
References: <20230803143253.7817-1-nipun.gupta@amd.com>
        <20230803143253.7817-3-nipun.gupta@amd.com>
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

On Thu, 3 Aug 2023 20:02:53 +0530
Nipun Gupta <nipun.gupta@amd.com> wrote:

> Support Bus master enable and disable on VFIO-CDX devices using
> VFIO_DEVICE_FEATURE_BUS_MASTER flag over VFIO_DEVICE_FEATURE IOCTL.
> 
> Co-developed-by: Shubham Rohila <shubham.rohila@amd.com>
> Signed-off-by: Shubham Rohila <shubham.rohila@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> ---
> 
> Changes v4->v5:
> - Use device feature IOCTL instead of adding a new VFIO IOCTL
>   for bus master feature.
> 
> Changes in v4:
> - This patch is newly added which uses cdx_set_master() and
>   cdx_clear_master() APIs.
> 
>  drivers/vfio/cdx/main.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
> index c376a69d2db2..6420cf6eb2f9 100644
> --- a/drivers/vfio/cdx/main.c
> +++ b/drivers/vfio/cdx/main.c
> @@ -52,6 +52,45 @@ static void vfio_cdx_close_device(struct vfio_device *core_vdev)
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
> +		cdx_clear_master(cdx_dev);
> +		return 0;
> +	case VFIO_DEVICE_FEATURE_SET_MASTER:
> +		return cdx_set_master(cdx_dev);

It's curious that the implementation of set and clear in CDX call
through to functions with non-void returns, but we simply ignore the
return in cdx_clear_master().  Does something prevent clear from
failing?

I also note internally that true is used for enabling and false for
disabling, which is effectively opposite of the proposed uAPI in the
previous patch.

If the idea here is that the user should assume bus master is disabled
when opening the device, what happens if the user closes the device
with bus master enabled?  What would cleanup that state for the next
user?

Is there a use case for the GET operation in userspace?  Thanks,

Alex

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
> @@ -169,6 +208,7 @@ static const struct vfio_device_ops vfio_cdx_ops = {
>  	.open_device	= vfio_cdx_open_device,
>  	.close_device	= vfio_cdx_close_device,
>  	.ioctl		= vfio_cdx_ioctl,
> +	.device_feature = vfio_cdx_ioctl_feature,
>  	.mmap		= vfio_cdx_mmap,
>  	.bind_iommufd	= vfio_iommufd_physical_bind,
>  	.unbind_iommufd	= vfio_iommufd_physical_unbind,

