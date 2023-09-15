Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6B37A27A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbjIOUGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbjIOUGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 543C030CA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694808305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7NfUcQ09mB7dsUpfhcIFawf5HcTW8vmdNnitXI7u8bM=;
        b=ZiEZMDp33p0qZtPWxOburXIX/8YeaMSf2IwfNKHBnsXOU9TP7LJsZb49F2r/R7l9zwFKYT
        LnwsMuUEsxSTuhTjigVqaU+o5sMuh/KwPRPnnbC5gw0AL+YJYYfgKCkFPvQFqlN5eIgzrs
        1Hz0EfLDUrIlYiPvQ3YP+k/bOPY25wQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-U1wShcj9Nre_NeKJe2awBQ-1; Fri, 15 Sep 2023 16:05:01 -0400
X-MC-Unique: U1wShcj9Nre_NeKJe2awBQ-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7907f181babso237575039f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808300; x=1695413100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NfUcQ09mB7dsUpfhcIFawf5HcTW8vmdNnitXI7u8bM=;
        b=JUcShhqUmRvTY4h8AE1RDcADnv0mHtUQjzTWmEOWlhB5U9MiNQHD8PEXNj7Bn1o4dq
         S0xOdNCmXoIpu51r6/ih5Udefn6lNhfSYO0ccaVMieJ98we59ASoIhvH6cKkDsKONLgh
         /pyrkm0hPOdo/H9frVNVkmAzFSdvFKI3L4zVXvB0oRUmAQAceEwA7JdqLOP+Z/svqdjt
         i6KAtsMbibNRSaiGKlcVjM3itIbFG2lyU1ZKNtp2f/7SMan/0mkfsWq3Qf6zSA+NwjYb
         SUJb9Oi90kCkbzY92roInH5sdZ+ltEvjaNlFgN2brPPaCEEelNHiSTp/GIF613stdNMM
         7Cvg==
X-Gm-Message-State: AOJu0YxfgjZhUs4fP+2ap+kirThg1nKWnrOTkGHnAuRDOCVOLXraeNWr
        tIrCFOQssrFkV0mJVRUxzVqMfFA71xwKDtKUy3twMBzl+PHNzMowRhsTB/ZahltLKQYxyh9vHMp
        VOEO7xpWMh+xFzbhBxYOx8K+K
X-Received: by 2002:a5e:d60f:0:b0:786:ca40:cc88 with SMTP id w15-20020a5ed60f000000b00786ca40cc88mr2412924iom.11.1694808300565;
        Fri, 15 Sep 2023 13:05:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG79Z55l7FWxwdyALDEtiQh1NRLDz1G37ohGh9uUvII18nmS6T558Af+KIpjkgLftQaXJ32DQ==
X-Received: by 2002:a5e:d60f:0:b0:786:ca40:cc88 with SMTP id w15-20020a5ed60f000000b00786ca40cc88mr2412906iom.11.1694808300220;
        Fri, 15 Sep 2023 13:05:00 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id j3-20020a02cc63000000b0042b320c13aasm1290128jaq.89.2023.09.15.13.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:04:59 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:04:58 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     kvm@vger.kernel.org, David Laight <David.Laight@ACULAB.COM>,
        linux-kernel@vger.kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 2/3] vfio: use __aligned_u64 in struct
 vfio_device_gfx_plane_info
Message-ID: <20230915140458.392e436a.alex.williamson@redhat.com>
In-Reply-To: <20230829182720.331083-3-stefanha@redhat.com>
References: <20230829182720.331083-1-stefanha@redhat.com>
        <20230829182720.331083-3-stefanha@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 14:27:19 -0400
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> The memory layout of struct vfio_device_gfx_plane_info is
> architecture-dependent due to a u64 field and a struct size that is not
> a multiple of 8 bytes:
> - On x86_64 the struct size is padded to a multiple of 8 bytes.
> - On x32 the struct size is only a multiple of 4 bytes, not 8.
> - Other architectures may vary.
> 
> Use __aligned_u64 to make memory layout consistent. This reduces the
> chance of 32-bit userspace on a 64-bit kernel breakage.
> 
> This patch increases the struct size on x32 but this is safe because of
> the struct's argsz field. The kernel may grow the struct as long as it
> still supports smaller argsz values from userspace (e.g. applications
> compiled against older kernel headers).
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/uapi/linux/vfio.h        | 3 ++-
>  drivers/gpu/drm/i915/gvt/kvmgt.c | 4 +++-
>  samples/vfio-mdev/mbochs.c       | 6 ++++--
>  samples/vfio-mdev/mdpy.c         | 4 +++-
>  4 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 94007ca348ed..777374dd7725 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -816,7 +816,7 @@ struct vfio_device_gfx_plane_info {
>  	__u32 drm_plane_type;	/* type of plane: DRM_PLANE_TYPE_* */
>  	/* out */
>  	__u32 drm_format;	/* drm format of plane */
> -	__u64 drm_format_mod;   /* tiled mode */
> +	__aligned_u64 drm_format_mod;   /* tiled mode */
>  	__u32 width;	/* width of plane */
>  	__u32 height;	/* height of plane */
>  	__u32 stride;	/* stride of plane */
> @@ -829,6 +829,7 @@ struct vfio_device_gfx_plane_info {
>  		__u32 region_index;	/* region index */
>  		__u32 dmabuf_id;	/* dma-buf id */
>  	};
> +	__u32 reserved;
>  };
>  
>  #define VFIO_DEVICE_QUERY_GFX_PLANE _IO(VFIO_TYPE, VFIO_BASE + 14)
> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
> index 9cd9e9da60dd..813cfef23453 100644
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -1382,7 +1382,7 @@ static long intel_vgpu_ioctl(struct vfio_device *vfio_dev, unsigned int cmd,
>  		intel_gvt_reset_vgpu(vgpu);
>  		return 0;
>  	} else if (cmd == VFIO_DEVICE_QUERY_GFX_PLANE) {
> -		struct vfio_device_gfx_plane_info dmabuf;
> +		struct vfio_device_gfx_plane_info dmabuf = {};
>  		int ret = 0;
>  
>  		minsz = offsetofend(struct vfio_device_gfx_plane_info,
> @@ -1392,6 +1392,8 @@ static long intel_vgpu_ioctl(struct vfio_device *vfio_dev, unsigned int cmd,
>  		if (dmabuf.argsz < minsz)
>  			return -EINVAL;
>  
> +		minsz = min(dmabuf.argsz, sizeof(dmabuf));
> +
>  		ret = intel_vgpu_query_plane(vgpu, &dmabuf);
>  		if (ret != 0)
>  			return ret;
> diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
> index 3764d1911b51..78aa977ae597 100644
> --- a/samples/vfio-mdev/mbochs.c
> +++ b/samples/vfio-mdev/mbochs.c
> @@ -1262,7 +1262,7 @@ static long mbochs_ioctl(struct vfio_device *vdev, unsigned int cmd,
>  
>  	case VFIO_DEVICE_QUERY_GFX_PLANE:
>  	{
> -		struct vfio_device_gfx_plane_info plane;
> +		struct vfio_device_gfx_plane_info plane = {};
>  
>  		minsz = offsetofend(struct vfio_device_gfx_plane_info,
>  				    region_index);
> @@ -1273,11 +1273,13 @@ static long mbochs_ioctl(struct vfio_device *vdev, unsigned int cmd,
>  		if (plane.argsz < minsz)
>  			return -EINVAL;
>  
> +		outsz = min_t(unsigned long, plane.argsz, sizeof(plane));

Sorry, I'm struggling with why these two sample drivers use min_t()
when passed the exact same args as kvmgt above which just uses min().

But more importantly I'm also confused why we need this at all.  The
buffer we're copying to is provided by the user, so what's wrong with
leaving the user provided reserved data?  Are we just trying to return
a zero'd reserved field if argsz allows for it?

Any use of the reserved field other than as undefined data would need
to be associated with a flags bit, so I don't think it's buying us
anything to return it zero'd.  What am I missing?  Thanks,

Alex

> +
>  		ret = mbochs_query_gfx_plane(mdev_state, &plane);
>  		if (ret)
>  			return ret;
>  
> -		if (copy_to_user((void __user *)arg, &plane, minsz))
> +		if (copy_to_user((void __user *)arg, &plane, outsz))
>  			return -EFAULT;
>  
>  		return 0;
> diff --git a/samples/vfio-mdev/mdpy.c b/samples/vfio-mdev/mdpy.c
> index 064e1c0a7aa8..f5c2effc1cec 100644
> --- a/samples/vfio-mdev/mdpy.c
> +++ b/samples/vfio-mdev/mdpy.c
> @@ -591,7 +591,7 @@ static long mdpy_ioctl(struct vfio_device *vdev, unsigned int cmd,
>  
>  	case VFIO_DEVICE_QUERY_GFX_PLANE:
>  	{
> -		struct vfio_device_gfx_plane_info plane;
> +		struct vfio_device_gfx_plane_info plane = {};
>  
>  		minsz = offsetofend(struct vfio_device_gfx_plane_info,
>  				    region_index);
> @@ -602,6 +602,8 @@ static long mdpy_ioctl(struct vfio_device *vdev, unsigned int cmd,
>  		if (plane.argsz < minsz)
>  			return -EINVAL;
>  
> +		minsz = min_t(unsigned long, plane.argsz, sizeof(plane));
> +
>  		ret = mdpy_query_gfx_plane(mdev_state, &plane);
>  		if (ret)
>  			return ret;

