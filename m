Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3C37CD360
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 07:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjJRFKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 01:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJRFKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 01:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB014FF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 22:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697605751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VcPdKM8uYkLVUKoUuJjzNVL1zYdC0PuI2Th2U1kqDQE=;
        b=Cp/Lbz7utRn57W40knFtQq/BEnGLlpCwML0aPFzxFx9GWhQFy8LrKEBzVR9kLJBHffglEL
        oMy44slCSK3d3s9ZViVkEpa2peXJqSFGec8L/Iw0gjGPP6TYpDELOgaQMJuYntKvTGCefE
        VPTJcQpH0uC7G/RTxXcO4xUzEsiG8kQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-votzd8tVMkWljKvwg-0LYA-1; Wed, 18 Oct 2023 01:09:09 -0400
X-MC-Unique: votzd8tVMkWljKvwg-0LYA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50483ed1172so6270573e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 22:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697605747; x=1698210547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcPdKM8uYkLVUKoUuJjzNVL1zYdC0PuI2Th2U1kqDQE=;
        b=OYyZsDY6BDZ3wEaTl2zRMwE9aApO3xngqbu1f2SmScaGqhtjoBCq+oMrqtlNQFM5KW
         xNFJj+lpS5DehF2rV3KZUW5n3h94kSiZMGaqKS8aeSSS0/WkDloHduuh+CT8fCRSjiZd
         QjTqwvSHr6QzJAwXqQtgqNrY9cRJbBuyVdBx2aWLEBCOI/TZw40BaV915dB32JJqi7Mh
         KndNYE00WgoQOXIpmDHgWSk/GYQGfkAyQkZNUx86A07lk8GeCdw7yhjrbmIkaTMvct0k
         AyNsy5nbSs198FDjksUAZ/G80VvKjSxdO+sDVKq05kyqWuONSf4NHpKVBP+jW1q++Bnu
         3dNw==
X-Gm-Message-State: AOJu0YwgaPrFG0yXIcrCLpaalIKbk4AcdWbVFcrTvdHbc1EdPlaX7nkX
        nTNIY68ocsMzpMgyeXpB1Lt2NhhS1yuVzs4eGNJJctrY7aerde3lap3ylX4yd8PBFMTSqON/4Xa
        kOFkw0urYedoXVS9hqjiwuVbOT80BNrBAkb6U4o2Gqar9I9PSY9Q=
X-Received: by 2002:a05:6512:3ce:b0:507:9a00:c169 with SMTP id w14-20020a05651203ce00b005079a00c169mr2865109lfp.5.1697605747207;
        Tue, 17 Oct 2023 22:09:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzvKblRLkV+YilbxKEKfXLR3mQSflvqfYYuN3VActYUxIRD5Cp4URx3Vjo38dhKQJyRYnivFnOtTidw3J2NNg=
X-Received: by 2002:a05:6512:3ce:b0:507:9a00:c169 with SMTP id
 w14-20020a05651203ce00b005079a00c169mr2865098lfp.5.1697605746893; Tue, 17 Oct
 2023 22:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231011064208.2143245-1-lulu@redhat.com> <20231011064208.2143245-5-lulu@redhat.com>
In-Reply-To: <20231011064208.2143245-5-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 18 Oct 2023 13:08:55 +0800
Message-ID: <CACGkMEtF+dLbWPvYjmGL2RZssK6uo1Lg-hQd=R_-McYA1pMSCg@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] vduse: update the vq_info in ioctl
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 2:42=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> In VDUSE_VQ_GET_INFO, the driver will sync the last_avail_idx
> with reconnect info, After mapping the reconnect pages to userspace
> The userspace App will update the reconnect_time in
> struct vhost_reconnect_vring, If this is not 0 then it means this
> vq is reconnected and will update the last_avail_idx
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 0f15e7ac716b..42e7a90ab74c 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1213,6 +1213,9 @@ static long vduse_dev_ioctl(struct file *file, unsi=
gned int cmd,
>                 struct vduse_vq_info vq_info;
>                 struct vduse_virtqueue *vq;
>                 u32 index;
> +               struct vdpa_reconnect_info *area;
> +               struct vhost_reconnect_vring *vq_reconnect;
> +               struct vhost_reconnect_data *dev_reconnect;
>
>                 ret =3D -EFAULT;
>                 if (copy_from_user(&vq_info, argp, sizeof(vq_info)))
> @@ -1244,6 +1247,19 @@ static long vduse_dev_ioctl(struct file *file, uns=
igned int cmd,
>
>                 vq_info.ready =3D vq->ready;
>
> +               area =3D &dev->reconnect_status;
> +               dev_reconnect =3D (struct vhost_reconnect_data *)area->va=
ddr;
> +
> +               area =3D &vq->reconnect_info;
> +               vq_reconnect =3D (struct vhost_reconnect_vring *)area->va=
ddr;
> +               /*check if the vq is reconnect, if yes then update the la=
st_avail_idx*/
> +               if ((vq_reconnect->last_avail_idx !=3D
> +                    vq_info.split.avail_index) &&
> +                   (dev_reconnect->reconnect_time !=3D 0)) {
> +                       vq_info.split.avail_index =3D
> +                               vq_reconnect->last_avail_idx;
> +               }

This may work only for split, how about packed? And I wonder when such
synchronization is not done at set_vq_state() but get_vq_info()?

Thanks

> +
>                 ret =3D -EFAULT;
>                 if (copy_to_user(argp, &vq_info, sizeof(vq_info)))
>                         break;
> --
> 2.34.3
>

