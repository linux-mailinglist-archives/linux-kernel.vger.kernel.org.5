Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8EA7E1B75
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjKFHbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjKFHbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:31:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D80FA
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 23:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699255828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F51eSuY4Oi2D0gkQWdIKjqvRwfkp9jTrFlX6owadixE=;
        b=fW02jtHLC8uecPeNmrOqg0LiOkKvhVFS5YDll2wq/H8YtoMZDhjPiMkiDfdPOwpT5Xz0cG
        jz+Pc5xdN5Ct/IKsqNrhwTBXw2BwkgAunZqxUwRsZ0LcceHcWrCuCI8HSXNUwZ1VzMhaGE
        8l5/AUsKf0NlgRYR+i7zZTqQJTE1Fxs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-VYBZ0nleNpCICL8Sz6F1zw-1; Mon, 06 Nov 2023 02:30:26 -0500
X-MC-Unique: VYBZ0nleNpCICL8Sz6F1zw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507a3ae32beso3794068e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 23:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699255825; x=1699860625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F51eSuY4Oi2D0gkQWdIKjqvRwfkp9jTrFlX6owadixE=;
        b=ImyHlsd5UdJb/nFG+m2VjvS+tOrkADky+JnN2dJ/N3guwszZskzXlE6UsKSR3zlctD
         1HDCbWTvXX8epprNhxxCQ9/jbvpBrIEpxDqv2eU62+evgqySeLcowpvfHx1Xb2VYvw6k
         PTuaorjIj8maJD3hSK3L4tdizGQZoOt8AAFkOcrouMeL5/pmKBBd1gNgalVCdBeEnxGl
         54M6woeVCR9IGi2Mh07ODXuyRRF+2gymub6oeChTaKD6SaTzoxABRDvprqChrOCRMeN9
         qsZa0lfz27t4nVAM9L/tV4p8Xa53EktHGiTILqmj+Da8CnRcZC2THu6/O5F80mc4i5v2
         ZPUw==
X-Gm-Message-State: AOJu0YxeX20q9FV1QCD8aBFm/QErVCZtYCDVrgXLVxioZtlNUnMORCb7
        qSGQkYKkThSJIXY4UG4vNHk/KCHdrbl+KjCMnwC5hhlxwU7e4A2Pg3FXPDqVX5n6Bfz6U5OdpdU
        Ltvo4WDK82lTFP+6P9bFhFpdBieGrC1a8hsq21Ib5
X-Received: by 2002:a05:6512:3e08:b0:503:99d:5a97 with SMTP id i8-20020a0565123e0800b00503099d5a97mr28482713lfv.20.1699255825095;
        Sun, 05 Nov 2023 23:30:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHur0uXYPVe6IlJPXMRunyH5xL4ebGdX/vCL/0AKGxbasEI2KxpGo3WC3Ky/u+84NkABZC4UMdi2leH4CxHzsw=
X-Received: by 2002:a05:6512:3e08:b0:503:99d:5a97 with SMTP id
 i8-20020a0565123e0800b00503099d5a97mr28482691lfv.20.1699255824752; Sun, 05
 Nov 2023 23:30:24 -0800 (PST)
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-4-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-4-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 6 Nov 2023 15:30:13 +0800
Message-ID: <CACGkMEtVfHL2WPwxkYEfTKBE10uWfB2a75QQOO8rzn3=Y9FiBg@mail.gmail.com>
Subject: Re: [RFC v1 3/8] vhost: Add 3 new uapi to support iommufd
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 4, 2023 at 1:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> VHOST_VDPA_SET_IOMMU_FD: bind the device to iommufd device
>
> VDPA_DEVICE_ATTACH_IOMMUFD_AS: Attach a vdpa device to an iommufd
> address space specified by IOAS id.
>
> VDPA_DEVICE_DETACH_IOMMUFD_AS: Detach a vdpa device
> from the iommufd address space
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

[...]

> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index f5c48b61ab62..07e1b2c443ca 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -219,4 +219,70 @@
>   */
>  #define VHOST_VDPA_RESUME              _IO(VHOST_VIRTIO, 0x7E)
>
> +/* vhost_vdpa_set_iommufd
> + * Input parameters:
> + * @iommufd: file descriptor from /dev/iommu; pass -1 to unset
> + * @iommufd_ioasid: IOAS identifier returned from ioctl(IOMMU_IOAS_ALLOC=
)
> + * Output parameters:
> + * @out_dev_id: device identifier
> + */
> +struct vhost_vdpa_set_iommufd {
> +       __s32 iommufd;
> +       __u32 iommufd_ioasid;
> +       __u32 out_dev_id;
> +};
> +
> +#define VHOST_VDPA_SET_IOMMU_FD \
> +       _IOW(VHOST_VIRTIO, 0x7F, struct vhost_vdpa_set_iommufd)
> +
> +/*
> + * VDPA_DEVICE_ATTACH_IOMMUFD_AS -
> + * _IOW(VHOST_VIRTIO, 0x7f, struct vdpa_device_attach_iommufd_as)
> + *
> + * Attach a vdpa device to an iommufd address space specified by IOAS
> + * id.
> + *
> + * Available only after a device has been bound to iommufd via
> + * VHOST_VDPA_SET_IOMMU_FD
> + *
> + * Undo by VDPA_DEVICE_DETACH_IOMMUFD_AS or device fd close.
> + *
> + * @argsz:     user filled size of this data.
> + * @flags:     must be 0.
> + * @ioas_id:   Input the target id which can represent an ioas
> + *             allocated via iommufd subsystem.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +struct vdpa_device_attach_iommufd_as {
> +       __u32 argsz;
> +       __u32 flags;
> +       __u32 ioas_id;
> +};

I think we need to map ioas to vDPA AS, so there should be an ASID
from the view of vDPA?

Thanks

> +
> +#define VDPA_DEVICE_ATTACH_IOMMUFD_AS \
> +       _IOW(VHOST_VIRTIO, 0x82, struct vdpa_device_attach_iommufd_as)
> +
> +/*
> + * VDPA_DEVICE_DETACH_IOMMUFD_AS
> + *
> + * Detach a vdpa device from the iommufd address space it has been
> + * attached to. After it, device should be in a blocking DMA state.
> + *
> + * Available only after a device has been bound to iommufd via
> + * VHOST_VDPA_SET_IOMMU_FD
> + *
> + * @argsz:     user filled size of this data.
> + * @flags:     must be 0.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +struct vdpa_device_detach_iommufd_as {
> +       __u32 argsz;
> +       __u32 flags;
> +};
> +
> +#define VDPA_DEVICE_DETACH_IOMMUFD_AS \
> +       _IOW(VHOST_VIRTIO, 0x83, struct vdpa_device_detach_iommufd_as)
> +
>  #endif
> --
> 2.34.3
>

