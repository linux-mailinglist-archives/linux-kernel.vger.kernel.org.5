Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04D97CD2A4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 05:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjJRDYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 23:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJRDYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 23:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BBAFA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 20:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697599400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKR//S/Acjk3o0KFFJkbSVfvx3GYFsq6xoKI/2su8aA=;
        b=fJx7NRX+49Xedm1geLpbYXWvMauIN2Pe2vIuKd6t9GkZOdyxM96YBGeQulwEpEYp4TYA+l
        6Z8Mc2P2zTLfwfeWCBBV5ZzfUNPxEMHAEhbxhg9CWSmoxoeDw33u/yw3flRnknh93Oibcr
        Wdzg8vzJJhfxC6Q+qgeqdoDO3k42Zxc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-Jzx_-AHKMoa76bh9Zuj1yA-1; Tue, 17 Oct 2023 23:23:19 -0400
X-MC-Unique: Jzx_-AHKMoa76bh9Zuj1yA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c520e0a9a7so27763731fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 20:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697599397; x=1698204197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKR//S/Acjk3o0KFFJkbSVfvx3GYFsq6xoKI/2su8aA=;
        b=VSEiRmAoaYVw9Drlzt+0YC0r3roATa9el0D9KTez4h25C5LS5s+Xvq887pym3OIOWD
         N5W6wyZhKQ9iz6zH04zIoCHP2wJ/oxgeZKFNCRIMKB25TKVphWqriJyVbOfbgU07+1IQ
         +r6Mrnxf1OGHO0WUPnFvYzSlBXyfkEk7YZ4/pfoc5eG7/sd//OUHUUnXULf0AlPuJH5p
         NH3CzRCtE2h1nwAU5GexYX5/ZBJ/WXcMB3CjkT0RYJp4TgyhdLGl7k2gufdESBoUQ5KL
         XAoDz8PH/bk0d1ymRNz2l1FAMvdEYLMgrnjZLzJ0EBAtcXBuVVaBp8VGAr5P0dlyb21g
         E/HA==
X-Gm-Message-State: AOJu0YxPHFrbase/FYBlix9DinQBiy+t480LV6Aid663U6rob/q3BS1B
        OQdeMAbIKMrAJv799UfcspnD9aF8ycYScf0lGAmA6FeQnXlaPqUZAxpisM6YEO4UfKY7vZx0q2x
        fluV7mVVTVV10Ies02JE6CUY7rrvknIXv5o9E0P6/iaTNyg3oCWM=
X-Received: by 2002:a2e:9d94:0:b0:2c5:14d1:a303 with SMTP id c20-20020a2e9d94000000b002c514d1a303mr2865700ljj.25.1697599397501;
        Tue, 17 Oct 2023 20:23:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOJPWb8XqH9o7qXCKcERteG+iRPCM6DWKJB5A6WLrI3Sb+SNOwYxHwkmPLhr8gWoHxxVlxIHMVDj4+kTbMkVU=
X-Received: by 2002:a2e:9d94:0:b0:2c5:14d1:a303 with SMTP id
 c20-20020a2e9d94000000b002c514d1a303mr2865690ljj.25.1697599397095; Tue, 17
 Oct 2023 20:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231011064208.2143245-1-lulu@redhat.com> <20231011064208.2143245-4-lulu@redhat.com>
In-Reply-To: <20231011064208.2143245-4-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 18 Oct 2023 11:23:06 +0800
Message-ID: <CACGkMEtuavpV=D0CPad2EhaQ_Xkr6TNa2jgFer-JO2SwSvyoeg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
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
> In VDUSE_GET_RECONNECT_INFO, the Userspace App can get the map size

I'm not sure why this is needed, the structure that mmaped to
userspace should belong to uAPI then userspace can do versions there?

> and The number of mapping memory pages from the kernel.

Userspace knows how many vq at most, why is this still needed?

> The userspace
> App can use this information to map the pages.
>
> Add struct vhost_reconnect_data/vhost_reconnect_vring for sync the
> information in reconnection
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++
>  include/uapi/linux/vduse.h         | 43 ++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 05e72d752fb6..0f15e7ac716b 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1347,6 +1347,21 @@ static long vduse_dev_ioctl(struct file *file, uns=
igned int cmd,
>                 ret =3D 0;
>                 break;
>         }
> +       case VDUSE_GET_RECONNECT_INFO: {
> +               struct vduse_reconnect_mmap_info info;
> +
> +               ret =3D -EFAULT;
> +               if (copy_from_user(&info, argp, sizeof(info)))
> +                       break;
> +
> +               info.size =3D PAGE_SIZE;
> +               info.max_index =3D dev->vq_num + 1;
> +
> +               if (copy_to_user(argp, &info, sizeof(info)))
> +                       break;
> +               ret =3D 0;
> +               break;
> +       }
>         default:
>                 ret =3D -ENOIOCTLCMD;
>                 break;
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 11bd48c72c6c..5ccac535fba6 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -350,4 +350,47 @@ struct vduse_dev_response {
>         };
>  };
>
> +/**
> + * struct vhost_reconnect_data - saved the reconnect info for device
> + * @reconnect_time: reconnect time for this device. userspace APP needs =
to do ++
> + *                  while reconnecting

This commnet needs tweaking as I don't think "++" is good English. And
you need to explain why we need this.

> + * @version; version for userspace APP

It's the version of uAPI not the userspace APP. And in order to be
able for a correct bootstrap, this needs to be the first field instead
of the second.

> + * @features; Device features negotiated in the last reconnect.
> + * @status; Device status in last reconnect

I wonder if we need just more than this, for example the number of
active queues, or this is what does @nr_vrings mean?

> + * @nr_vrings; number of vqs
> + */
> +
> +struct vhost_reconnect_data {
> +       __u32 reconnect_time;
> +       __u32 version;
> +       __u64 features;
> +       __u8 status;
> +       __u32 nr_vrings;
> +};
> +
> +/**
> + * struct vhost_reconnect_vring -saved the reconnect info for vqs
> + * @last_avail_idx: device available index
> + * @avail_wrap_counter: Driver ring wrap counter
> + */
> +struct vhost_reconnect_vring {
> +       __u16 last_avail_idx;
> +       __u16 avail_wrap_counter;
> +};

Do we need the last_used_idx and last_used_wrap_counter? If not,
please document why.

> +
> +/**
> + * struct vduse_reconnect_mmap_info
> + * @size: mapping memory size, here we use page_size
> + * @max_index: the number of pages allocated in kernel,just
> + * use for check

Did you mean "sanity check"?

Thanks

> + */
> +
> +struct vduse_reconnect_mmap_info {
> +       __u32 size;
> +       __u32 max_index;
> +};
> +
> +#define VDUSE_GET_RECONNECT_INFO \
> +       _IOWR(VDUSE_BASE, 0x1b, struct vduse_reconnect_mmap_info)
> +
>  #endif /* _UAPI_VDUSE_H_ */
> --
> 2.34.3
>

