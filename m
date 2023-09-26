Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF937AE3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 04:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjIZCsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 22:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjIZCsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 22:48:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED66310E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 19:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695696443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ItET0pMqX+FXEFMhJ+U3a+Ugm6kdUA0QYgdt+0g1epA=;
        b=NsEThshGwCV3AzOIpbSqRUaw3bFthILlH6V/sAe+DKtASA5khBNq0TmVoQic9C3nRBksW0
        rj/qmOFawdoQ2glJ7DuncKA6i0fyX220ePM8m6kC8DW0upqnvWmzkY5aLtgeKyoPfLEJz6
        jIhDpmkShYFMDK/Ot4oiYxBFhbtOCXw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-0tNpFwCnP3yYPQxuy-rJUw-1; Mon, 25 Sep 2023 22:47:21 -0400
X-MC-Unique: 0tNpFwCnP3yYPQxuy-rJUw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50421897564so11617638e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 19:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695696440; x=1696301240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItET0pMqX+FXEFMhJ+U3a+Ugm6kdUA0QYgdt+0g1epA=;
        b=Fsn0VMmxB+zQ5lfvE1sR5lR8LetqKp9X2Vdnzv5E+rkFNxcJdK/HIqsDyD2NOKGrfH
         Tsis1u4fZK4UMfQEDJhPaO/DL1YQAScmVaRJp9OlJonrX5yNprgz/Uq0BzVqUOgXC24L
         GdXXBUjREtviyGYRlVO87A+1rAzoICi26qmNU8Tlc/WZhFYYYphw0dGUHwTF0c3wRP2w
         tep9IQM1S588PRjyOG45cNcWj1qUWcb8nVn8mIN3JIrKHi2JWzugs1+QBZTD6SLX5pUR
         oHdVwRSUYAipDzz1NhUSstbdF0HaHo0VZ1Altsf6/cCnOEyNGRMAvg5h2AGoOzDdfM1V
         mg3w==
X-Gm-Message-State: AOJu0Yx+i7WTNESWRfUH1wwmBqdY7fKQVGk7HxOqXsAsjd27QYOEHBrs
        EtrBnhPlf5kR5BwJzyTv67F/JPYo7z3lBPKEplIWR4yKxVh+DeJhjRur1AIPemZVioBRC/SXCj3
        yKiMlCI/EWzNaV/2xh8sK/yNJ/gCUJo2Vl06pFJSW
X-Received: by 2002:a05:6512:29a:b0:503:303:9e2d with SMTP id j26-20020a056512029a00b0050303039e2dmr6664860lfp.5.1695696439799;
        Mon, 25 Sep 2023 19:47:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVfoDQ70MvGrrFuSM5F4u5jc1N+fSkvSpE6P8ei76cf78SA8yD0wv/BtCLlpJJLc55YsUP/ur6WGFsVmTMMm4=
X-Received: by 2002:a05:6512:29a:b0:503:303:9e2d with SMTP id
 j26-20020a056512029a00b0050303039e2dmr6664849lfp.5.1695696439422; Mon, 25 Sep
 2023 19:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com> <20230923170540.1447301-6-lulu@redhat.com>
In-Reply-To: <20230923170540.1447301-6-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 26 Sep 2023 10:47:08 +0800
Message-ID: <CACGkMEtWhYPy==_OEEEO=cV7A5Wv-UGMt7FvPeMW4goNtO51FA@mail.gmail.com>
Subject: Re: [RFC 5/7] vdpa: Add new vdpa_config_ops
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 1:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add new vdpa_config_ops to support iommufd
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  include/linux/vdpa.h | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 6d0f5e4e82c2..4ada5bd6f90e 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -5,6 +5,7 @@
>  #include <linux/kernel.h>
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
> +#include <linux/iommufd.h>
>  #include <linux/vhost_iotlb.h>
>  #include <linux/virtio_net.h>
>  #include <linux/if_ether.h>
> @@ -91,6 +92,12 @@ struct vdpa_device {
>         struct vdpa_mgmt_dev *mdev;
>         unsigned int ngroups;
>         unsigned int nas;
> +       struct iommufd_access *iommufd_access;
> +       struct iommufd_device *iommufd_device;
> +       struct iommufd_ctx *iommufd_ictx;
> +       unsigned long *vq_bitmap;
> +       atomic_t iommufd_users;
> +       bool iommufd_attached;
>  };
>
>  /**
> @@ -282,6 +289,15 @@ struct vdpa_map_file {
>   *                             @iova: iova to be unmapped
>   *                             @size: size of the area
>   *                             Returns integer: success (0) or error (< =
0)
> + * @bind_iommufd:              use vdpa_iommufd_physical_bind for an IOM=
MU
> + *                             backed device.
> + *                             otherwise use vdpa_iommufd_emulated_bind
> + * @unbind_iommufd:            use vdpa_iommufd_physical_unbind for an I=
OMMU
> + *                             backed device.
> + *                             otherwise, use vdpa_iommufd_emulated_unbi=
nd
> + * @attach_ioas:               use vdpa_iommufd_physical_attach_ioas for=
 an
> + *                             IOMMU backed device.
> + * @detach_ioas:               Opposite of attach_ioas

Those should be marked as mandatory only for parents with specific
translations (e.g simulator and mlx5_vdpa).

Or anything I missed?

Thanks


>   * @free:                      Free resources that belongs to vDPA (opti=
onal)
>   *                             @vdev: vdpa device
>   */
> @@ -341,6 +357,12 @@ struct vdpa_config_ops {
>                          u64 iova, u64 size);
>         int (*set_group_asid)(struct vdpa_device *vdev, unsigned int grou=
p,
>                               unsigned int asid);
> +       /* IOMMUFD ops */
> +       int (*bind_iommufd)(struct vdpa_device *vdev, struct iommufd_ctx =
*ictx,
> +                           u32 *out_device_id);
> +       void (*unbind_iommufd)(struct vdpa_device *vdev);
> +       int (*attach_ioas)(struct vdpa_device *vdev, u32 *pt_id);
> +       int (*detach_ioas)(struct vdpa_device *vdev);
>
>         /* Free device resources */
>         void (*free)(struct vdpa_device *vdev);
> @@ -510,4 +532,14 @@ struct vdpa_mgmt_dev {
>  int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
>  void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
>
> -#endif /* _LINUX_VDPA_H */
> +int vdpa_iommufd_physical_bind(struct vdpa_device *vdpa,
> +                              struct iommufd_ctx *ictx, u32 *out_device_=
id);
> +void vdpa_iommufd_physical_unbind(struct vdpa_device *vdpa);
> +int vdpa_iommufd_physical_attach_ioas(struct vdpa_device *vdpa, u32 *pt_=
id);
> +int vdpa_iommufd_emulated_bind(struct vdpa_device *vdpa,
> +                              struct iommufd_ctx *ictx, u32 *out_device_=
id);
> +void vdpa_iommufd_emulated_unbind(struct vdpa_device *vdpa);
> +int vdpa_iommufd_emulated_attach_ioas(struct vdpa_device *vdpa, u32 *pt_=
id);
> +int vdpa_iommufd_emulated_detach_ioas(struct vdpa_device *vdpa);
> +
> +#endif
> --
> 2.34.3
>

