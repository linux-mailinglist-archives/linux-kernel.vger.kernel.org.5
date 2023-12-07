Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1478380837A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjLGIqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjLGIqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:46:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64728C6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701938789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S45mCIVP8tXMlQy/LkNkOy2M4lsUi2H4wMiVuvDZzy8=;
        b=gVf9iER0wo79+lpOHwPbhqseHEn1I214cXKoVJOoPViB8iDeL7oDpmAcVq8gcITwhfsMgQ
        u0FPvbH70sBs0FQGYJReloJWCNjzmQ9lH6UtENcn+1vhJX0Cnj/LA2o1TmUkpOMXV/FLlc
        sg8OoIkrJy0K/RreEe+peGHyVpRxb0M=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-oq-Y9kW1MgGKeKgrNEahvQ-1; Thu, 07 Dec 2023 03:46:27 -0500
X-MC-Unique: oq-Y9kW1MgGKeKgrNEahvQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-286e0d3e04dso774491a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 00:46:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701938787; x=1702543587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S45mCIVP8tXMlQy/LkNkOy2M4lsUi2H4wMiVuvDZzy8=;
        b=rylcgwMTvgcG6o+oUKeMVR21DsK1y/JfQosYHjrzheU/RakK/mUvh/LTATWjJJGFaR
         lpIe9mG40nhhhSmRdLZO0nSgrIyzU6wKyDobhGLIp4lHRU2zAD0cF4yTGCIHS6KQihvL
         gmBW9ZOutV1sh295ss7ISpc3y+ZDXqWiYDg0U1xnEupwlVKqPashlKeNebZMjX1OBjjk
         5MrGfSmFAj+cpXA3LeyM5kVZ/v64bMzB2IU+tIvdEW/ZPQSrDE/wk1g08CqYeaD9A+j3
         13Niik5JSfD5CoZmCzo2KEZU+fL/kjQvEWxAyRJ9FoGGt4WSGLtS9iO3ay/bgQ+tZn+M
         KGnA==
X-Gm-Message-State: AOJu0YwlsjABavYs5jtZpTVzFN3wm1VEg9VwXOrQiK6vMVXYl15Ps+l1
        BAWb+Kt4KDauRKzTlz8nx1DoTA613xOywZf2YJIBu60tD/Mj5odQ1HwseVsK09Pm63EJgXiN2Vf
        Ph20zyOj0vPNklDA2Tlay24HzeD8c8wsPeQnTOlLK
X-Received: by 2002:a17:90b:234a:b0:288:9282:7c17 with SMTP id ms10-20020a17090b234a00b0028892827c17mr886719pjb.80.1701938786897;
        Thu, 07 Dec 2023 00:46:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4gyKGta7cpog0ORvM1uktlxTI8mNJIKN2VVJzhf6Al11/Ss8DWl8n8RSZQ9Belv4chT6EvPVK4k5lh/sJfiI=
X-Received: by 2002:a17:90b:234a:b0:288:9282:7c17 with SMTP id
 ms10-20020a17090b234a00b0028892827c17mr886708pjb.80.1701938786629; Thu, 07
 Dec 2023 00:46:26 -0800 (PST)
MIME-Version: 1.0
References: <20231205083444.3029239-1-lulu@redhat.com> <20231205083444.3029239-7-lulu@redhat.com>
In-Reply-To: <20231205083444.3029239-7-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 7 Dec 2023 16:46:15 +0800
Message-ID: <CACGkMEvycvCUjjdKvK50dmoQbDL79Xc9s4YDMVed9BUv+Gf0yg@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] vduse: Update the vq_info in ioctl VDUSE_VQ_GET_INFO
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 4:35=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Once the reconnect memory pages are mapped to userspace, the userspace
> application will update the "reconnected" bit in the
> "struct vduse_dev_reconnect_data".
> The kernel will then check this bit. If it is not set to
> "VDUSE_NOT_RECONNECT", it means that the application has been
> reconnected, and the kernel will synchronize the vq information.

Can you explain why we need such a flag?

>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index f55f415629de..422f1aedebac 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1193,6 +1193,9 @@ static long vduse_dev_ioctl(struct file *file, unsi=
gned int cmd,
>                 struct vduse_vq_info vq_info;
>                 struct vduse_virtqueue *vq;
>                 u32 index;
> +               unsigned long vaddr;
> +               struct vduse_vq_state *vq_reconnect;
> +               struct vduse_dev_reconnect_data *dev_reconnect;
>
>                 ret =3D -EFAULT;
>                 if (copy_from_user(&vq_info, argp, sizeof(vq_info)))
> @@ -1209,6 +1212,12 @@ static long vduse_dev_ioctl(struct file *file, uns=
igned int cmd,
>                 vq_info.device_addr =3D vq->device_addr;
>                 vq_info.num =3D vq->num;
>
> +               vaddr =3D dev->vdpa_reconnect_vaddr;
> +               dev_reconnect =3D (struct vduse_dev_reconnect_data *)vadd=
r;
> +
> +               vaddr =3D vq->vdpa_reconnect_vaddr;
> +               vq_reconnect =3D (struct vduse_vq_state *)vaddr;
> +
>                 if (dev->driver_features & BIT_ULL(VIRTIO_F_RING_PACKED))=
 {
>                         vq_info.packed.last_avail_counter =3D
>                                 vq->state.packed.last_avail_counter;
> @@ -1218,9 +1227,22 @@ static long vduse_dev_ioctl(struct file *file, uns=
igned int cmd,
>                                 vq->state.packed.last_used_counter;
>                         vq_info.packed.last_used_idx =3D
>                                 vq->state.packed.last_used_idx;
> -               } else
> +                       /*check if the vq is reconnect, if yes then updat=
e the info*/
> +                       if (dev_reconnect->reconnected !=3D VDUSE_NOT_REC=
ONNECT) {

So the dev_reconnect is shared, how to synchronize between them?

> +                               vq_info.packed.last_avail_idx =3D
> +                                       vq_reconnect->packed.last_avail_i=
dx;
> +                               vq_info.packed.last_avail_counter =3D
> +                                       vq_reconnect->packed.last_avail_c=
ounter;
> +                       }
> +               } else {
>                         vq_info.split.avail_index =3D
>                                 vq->state.split.avail_index;
> +                       /*check if the vq is reconnect, if yes then updat=
e the info*/
> +                       if (dev_reconnect->reconnected !=3D VDUSE_NOT_REC=
ONNECT) {

If this only check is !=3D, I'd define it as VDUSE_RECONNECT to ease the
code logic.

> +                               vq_info.split.avail_index =3D
> +                                       vq_reconnect->split.avail_index;
> +                       }
> +               }

It looks like I miss something here

If I read the code correctly, vq_reconnect is written by userspace, so
userspace query it again via the get_vq_info()? If this is true,
userspace can just ignore the index via GET_VQ_INFO() or is it just
for consistency?

Thanks


>
>                 vq_info.ready =3D vq->ready;
>
> --
> 2.34.3
>

