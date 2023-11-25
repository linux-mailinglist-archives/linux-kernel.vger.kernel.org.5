Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A717F8C2E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjKYPxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjKYPxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:53:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70CBE0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700927589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q1msXKMg4h7A5UUQpj5HQxClJk5im0b0zixsCXmFQv4=;
        b=cetZpZrFQ0mp9GU3FHg2rRtGkSB6DyrvQDvxjElhqzii8gDZRh59qRmppLtnwepz5jWIh7
        XRaRluo0cPdUfgbk6zA3HPhxLjIeoqpFBmQpzeZQ4vA786LZe2V64lH+sO4bLR6TpwJ/UK
        Wl0Tjjfbha6hcUOewngZwN/fCh2mZDs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-fLUmxB7ZMqG9ie6YApoMkQ-1; Sat, 25 Nov 2023 10:53:06 -0500
X-MC-Unique: fLUmxB7ZMqG9ie6YApoMkQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-54918e2fe9eso3470147a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700927585; x=1701532385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1msXKMg4h7A5UUQpj5HQxClJk5im0b0zixsCXmFQv4=;
        b=QxQDkXbv2tH8zwtPQR5lO5KJJbzG3cSPV7RBmTNz+kyXMjaJNFvAJehXSl4TZW/7SP
         oUZkZ4SDHBXLCzjD23QNiSjJoqBkKqMowRkQ55hansvlqXUcKYBf4vZi3HgNQQocCvQd
         beeKBFMfVKRZfe1k76OhJgPDbUjuF4Ecw1PZyxbD3yNq6vQbKcIOLjXuWJzodHTiK94Q
         L83zh9gwzAIL5piOCEER8J0h5fYnocJWGXDrVz6XlPoFCRJ++bqQu4DyKAXAOQ90+xRx
         6NAhlOf7cvG1U5Oq8MFjru2UNDS6MqxMe+hntc+PpAV1+8+m77hrK56G31ae4DlAFiKy
         gUjg==
X-Gm-Message-State: AOJu0YwmNBFi8rU+83pDcFEXWzysMS1rf/4ppANJEUGg1cMYrPKfhMft
        m3JzB1JEQ4q1Zip1R4FcL6G6gxGqAbqt8FU9fI8HvtE+zowyJCDhv0gY6ycA9c3YcDcKlsXPs16
        fZdfQIlLBg6FTsYaA1j6j2/00iuUMr/koqx9oV05x
X-Received: by 2002:aa7:d7d2:0:b0:54b:1d34:2905 with SMTP id e18-20020aa7d7d2000000b0054b1d342905mr1906904eds.10.1700927584907;
        Sat, 25 Nov 2023 07:53:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGZS7DldMEVEhV96tQdoNYEHxUU10AnnlUynnSfBhyXkAfKbHh3rgvhlKJcOrrez2s8nIuyKL274sd+7Cj72k=
X-Received: by 2002:aa7:d7d2:0:b0:54b:1d34:2905 with SMTP id
 e18-20020aa7d7d2000000b0054b1d342905mr1906895eds.10.1700927584622; Sat, 25
 Nov 2023 07:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20231121073050.287080-1-lulu@redhat.com> <20231121073050.287080-4-lulu@redhat.com>
 <CACGkMEtzXS8GwRN_anprGEEJhoGxSbj8pBCTF22RPVL484fhYA@mail.gmail.com>
In-Reply-To: <CACGkMEtzXS8GwRN_anprGEEJhoGxSbj8pBCTF22RPVL484fhYA@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Sat, 25 Nov 2023 23:52:27 +0800
Message-ID: <CACLfguV8MF+JO0QkHZ+zJV3ceZvhTqiBz0kAU6AQQHPc3jL_vA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 2:29=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Nov 21, 2023 at 3:31=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > In VDUSE_GET_RECONNECT_INFO, the Userspace App can get the map size
> > and The number of mapping memory pages from the kernel. The userspace
> > App can use this information to map the pages.
> >
> > Add struct vhost_reconnect_data/vhost_reconnect_vring for sync the
> > information in reconnection
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++
> >  include/uapi/linux/vduse.h         | 50 ++++++++++++++++++++++++++++++
> >  2 files changed, 65 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index ccb30e98bab5..d0fe9a7e86ab 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1343,6 +1343,21 @@ static long vduse_dev_ioctl(struct file *file, u=
nsigned int cmd,
> >                 ret =3D 0;
> >                 break;
> >         }
> > +       case VDUSE_GET_RECONNECT_INFO: {
> > +               struct vduse_reconnect_mmap_info info;
> > +
> > +               ret =3D -EFAULT;
> > +               if (copy_from_user(&info, argp, sizeof(info)))
> > +                       break;
> > +
> > +               info.size =3D PAGE_SIZE;
> > +               info.max_index =3D dev->vq_num + 1;
>
> It looks to be both PAGE_SIZE and vq_num is the well knowledge that
> doesn't require a query?
sure we can remove this IOCTL
>
> > +
> > +               if (copy_to_user(argp, &info, sizeof(info)))
> > +                       break;
> > +               ret =3D 0;
> > +               break;
> > +       }
> >         default:
> >                 ret =3D -ENOIOCTLCMD;
> >                 break;
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index 11bd48c72c6c..c0b7133aebfd 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -3,6 +3,7 @@
> >  #define _UAPI_VDUSE_H_
> >
> >  #include <linux/types.h>
> > +#include <linux/virtio_net.h>
> >
> >  #define VDUSE_BASE     0x81
> >
> > @@ -350,4 +351,53 @@ struct vduse_dev_response {
> >         };
> >  };
> >
> > +/**
> > + * struct vhost_reconnect_data - saved the reconnect info for device
> > + * @version; version for userspace APP
> > + * @reconnected: indetify if this is reconnected. userspace APP needs =
set this bit to 1
> > + *               while reconnecting.kernel will use this bit to indeti=
fy if this is
> > + *               reconnect
>
> Typos.
>
will fix this
> > + * @features; Device features negotiated in the last connect.
> > + * @status; Device status in last reconnect
> > + * @nr_vrings; number of active vqs in last connect
>
> What's the meaning of "active vqs"? Is it the #active_queue_pairs? If
> yes, couldn't we get it from the virtio_net_config?
>

> > + * @struct virtio_net_config config; the config in last connect
> > + */
> > +
> > +struct vhost_reconnect_data {
> > +       __u32 version;
> > +       __u32 reconnected;
> > +       __u64 features;
> > +       __u8 status;
> > +       __u32 nr_vrings;
> > +       struct virtio_net_config config;
>
> This seems like a layer violation. The fields here needs to be type
> agnostic or we should introduce a new device specific area with a
> union.
>
> Or can we simply invent VDUSE_DEV_GET_CONFIG() to do this?
>
will remove virtio_net_config here
> her
> > +
> > +/**
> > + * struct vhost_reconnect_vring -saved the reconnect info for vqs
> > + * when use split mode will only use last_avail_idx
> > + * when use packed mode will use both last_avail_idx and avail_wrap_co=
unter
>
> How about last_used_idx and last_used_wrap_counter.
>
> Btw, vDPA or vhost-vDPA has a good uAPI for this, can we reuse that?
>
I didn't get here, Do you mean set_vq_state/get_vq_state ?
Thanks
Cindy
> Thanks
>
> > + * userspace App
> > + * @last_avail_idx: device last available index
> > + * @avail_wrap_counter: Driver ring wrap counter
> > + */
> > +struct vhost_reconnect_vring {
> > +       __u16 last_avail_idx;
> > +       __u16 avail_wrap_counter;
> > +};
> > +
> > +/**
> > + * struct vduse_reconnect_mmap_info
> > + * @size: mapping memory size, here we use page_size
> > + * @max_index: the number of pages allocated in kernel,just
> > + * use for sanity check
> > + */
> > +
> > +struct vduse_reconnect_mmap_info {
> > +       __u32 size;
> > +       __u32 max_index;
> > +};
> > +
> > +#define VDUSE_GET_RECONNECT_INFO \
> > +       _IOWR(VDUSE_BASE, 0x1b, struct vduse_reconnect_mmap_info)
> > +
> >  #endif /* _UAPI_VDUSE_H_ */
> > --
> > 2.34.3
> >
>

