Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5A17E35E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjKGH1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjKGH1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:27:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CDD91
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 23:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699342026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDCw88Fjqq+w3NA1yEpTB8ryPGBt63OS4V+KIPX+uWw=;
        b=V/Ms+IdUCl0j5yfQB5nSzO0woNwV55HxjNPCS/aGwZNH00svaJRpvAaxzGNAk4oeDp3KF9
        44MhAte5bHDcUzGVNxd+xT/4fDaqSEs5iCW5mRkFaXOr4rjeKsKA6XpHiII4nlyi9eZlJ6
        nsPZBDm2fpFvlfMznA0UNpmIpevUPJA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-b-9n5pBDMLe4B5icRZQ9ww-1; Tue, 07 Nov 2023 02:27:05 -0500
X-MC-Unique: b-9n5pBDMLe4B5icRZQ9ww-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-54045f31f49so4248264a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 23:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699342024; x=1699946824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDCw88Fjqq+w3NA1yEpTB8ryPGBt63OS4V+KIPX+uWw=;
        b=W6Y78sldPTTPGX1L4eOo0v8bcRxXSHgzTI7ZgAUjIYPX7WOvoE37U5mouRDpt0xhv1
         u6qG1mk74SwEwpoR7ZYGa3XGNM64P68rxIukKDlaIdlX19C8nZDddyzhCN/nHwdMGAP8
         Nky4k3TW44pIhvnqXHYuxMQSCfIAvmjs0Cck6unxAICwkJllcieXcNnYBFsCQLDp9vhW
         jbnIyE433wmeyxtnDMiWX5vL2aTOsqZRsQxa4MOJQhDAXfH8663i5O7p4MNtkCJgXpoa
         U5axEi6IzGEc9S2SD8Jt3C+aVP/NEXtf41J8RcFoebmoFt7GqkL81PaI7W95/gQNxdxm
         i/sw==
X-Gm-Message-State: AOJu0YwP/yIW3i+cm7nsaeAW7FYdY91/6ziev4ksVPV+K88d0AdC5bd8
        PyS/FNntWar58oswvzhiGvb9ImTMJ35yh4NbS5GSyKTaIfHU29js2EKCVNG3UpK4xrnbbFBJrec
        t6rQjfxSZc+lVfiS851ZcOkWb1AhCreMKHMqhBrAW
X-Received: by 2002:a17:907:70a:b0:9bd:9bfe:e410 with SMTP id xb10-20020a170907070a00b009bd9bfee410mr16117651ejb.72.1699342024152;
        Mon, 06 Nov 2023 23:27:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5+yRpBmfTRnlaxNXvzDfocBZ4ywJd6596kKtv2p9TAhmhjJPeY6JLS7/qaCqZKkEGgZSYI0EwrVRKxKfE7Fc=
X-Received: by 2002:a17:907:70a:b0:9bd:9bfe:e410 with SMTP id
 xb10-20020a170907070a00b009bd9bfee410mr16117637ejb.72.1699342023866; Mon, 06
 Nov 2023 23:27:03 -0800 (PST)
MIME-Version: 1.0
References: <20231011064208.2143245-1-lulu@redhat.com> <20231011064208.2143245-2-lulu@redhat.com>
 <CACGkMEupWg6v2Kp1QFDE1qsc4SeZ220jo0XJ=07h5HJPLSC_Qw@mail.gmail.com>
In-Reply-To: <CACGkMEupWg6v2Kp1QFDE1qsc4SeZ220jo0XJ=07h5HJPLSC_Qw@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Tue, 7 Nov 2023 15:26:27 +0800
Message-ID: <CACLfguU7+Lx_qM-8DePdja63mW2MZC1fhVf0zP=7yzx_+Wehpw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] vduse: Add function to get/free the pages for reconnection
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:57=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Wed, Oct 11, 2023 at 2:42=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add the function vduse_alloc_reconnnect_info_mem
> > and vduse_alloc_reconnnect_info_mem
> > In this 2 function, vduse will get/free (vq_num + 1)*page
> > Page 0 will be used to save the reconnection information, The
> > Userspace App will maintain this. Page 1 ~ vq_num + 1 will save
> > the reconnection information for vqs.
>
> I'd align this with the spec. E.g spec starts virtqueue index from 0.
>
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 78 ++++++++++++++++++++++++++++++
> >  1 file changed, 78 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 26b7e29cb900..565126a9ab01 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -30,6 +30,10 @@
> >  #include <uapi/linux/virtio_blk.h>
> >  #include <linux/mod_devicetable.h>
> >
> > +#ifdef CONFIG_X86
> > +#include <asm/set_memory.h>
> > +#endif
>
> Why do we need special care for x86?
>
> > +
> >  #include "iova_domain.h"
> >
> >  #define DRV_AUTHOR   "Yongji Xie <xieyongji@bytedance.com>"
> > @@ -41,6 +45,19 @@
> >  #define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
> >  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
> >
> > +/* struct vdpa_reconnect_info saved the alloc pages info
> > + * these pages will mmaped to userspace for reconnection
> > + */
> > +struct vdpa_reconnect_info {
> > +       /* Offset (within vm_file) in PAGE_SIZE
> > +        */
> > +       u32 index;
> > +       /* virtual address for this page*/
> > +       unsigned long vaddr;
> > +       /* allocated memory size, */
> > +       phys_addr_t size;
>
> Anything wrong with using "unsigned long" here.
>
> Btw, what is "allocated memory size" since I think we can use up to
> PAGE_SIZE here?
>
sure=EF=BC=8C will remove this here
Thanks
Cindy
> > +};
> > +
> >  struct vduse_virtqueue {
> >         u16 index;
> >         u16 num_max;
> > @@ -57,6 +74,7 @@ struct vduse_virtqueue {
> >         struct vdpa_callback cb;
> >         struct work_struct inject;
> >         struct work_struct kick;
> > +       struct vdpa_reconnect_info reconnect_info;
> >  };
> >
> >  struct vduse_dev;
> > @@ -106,6 +124,7 @@ struct vduse_dev {
> >         u32 vq_align;
> >         struct vduse_umem *umem;
> >         struct mutex mem_lock;
> > +       struct vdpa_reconnect_info reconnect_status;
> >  };
> >
> >  struct vduse_dev_msg {
> > @@ -1030,6 +1049,61 @@ static int vduse_dev_reg_umem(struct vduse_dev *=
dev,
> >         return ret;
> >  }
> >
> > +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> > +{
> > +       struct vdpa_reconnect_info *info;
> > +       struct vduse_virtqueue *vq;
> > +       void *addr;
> > +
> > +       /*page 0 is use to save status,dpdk will use this to save the i=
nformation
> > +        *needed in reconnection,kernel don't need to maintain this
> > +        */
>
> Let's avoid mentioning any specific userspace like DPDK in the kernel
> source. A good uAPI should not be designed for a specific userspace.
>
will change this
> > +       info =3D &dev->reconnect_status;
> > +       addr =3D (void *)get_zeroed_page(GFP_KERNEL);
> > +       if (!addr)
> > +               return -1;
>
> Let's don't use magic number here but something like -ENOMEM.
>
> > +
> > +       info->vaddr =3D (unsigned long)(addr);
> > +       info->size =3D PAGE_SIZE;
> > +       /* index is vm Offset in PAGE_SIZE */
> > +       info->index =3D 0;
> > +
> > +       /*page 1~ vq_num + 1 save the reconnect info for vqs*/
>
> There's no need to explain what the code does.
>
will change this

> > +       for (int i =3D 0; i < dev->vq_num + 1; i++) {
> > +               vq =3D &dev->vqs[i];
> > +               info =3D &vq->reconnect_info;
> > +               addr =3D (void *)get_zeroed_page(GFP_KERNEL);
> > +               if (!addr)
> > +                       return -1;
> > +
> > +               info->vaddr =3D (unsigned long)(addr);
> > +               info->size =3D PAGE_SIZE;
> > +               info->index =3D i + 1;
>
> Btw, I don't see an obvious difference in the page for virtqueue and
> device. Could we unify the logic there? So did the free.
>
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int vduse_free_reconnnect_info_mem(struct vduse_dev *dev)
> > +{
> > +       struct vdpa_reconnect_info *info;
> > +       struct vduse_virtqueue *vq;
> > +
> > +       info =3D &dev->reconnect_status;
> > +       free_page(info->vaddr);
> > +       info->size =3D 0;
> > +       info->vaddr =3D 0;
> > +       for (int i =3D 0; i < dev->vq_num + 1; i++) {
> > +               vq =3D &dev->vqs[i];
> > +               info =3D &vq->reconnect_info;
> > +               free_page(info->vaddr);
> > +               info->size =3D 0;
> > +               info->vaddr =3D 0;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> >                             unsigned long arg)
> >  {
> > @@ -1390,6 +1464,8 @@ static int vduse_destroy_dev(char *name)
> >                 mutex_unlock(&dev->lock);
> >                 return -EBUSY;
> >         }
> > +       vduse_free_reconnnect_info_mem(dev);
> > +
> >         dev->connected =3D true;
> >         mutex_unlock(&dev->lock);
> >
> > @@ -1542,6 +1618,8 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >                 ret =3D PTR_ERR(dev->dev);
> >                 goto err_dev;
> >         }
> > +
> > +       vduse_alloc_reconnnect_info_mem(dev);
>
> The errors were ignored here.
>
> Thanks
>
sure will add the check here

Thanks
cindy

> >         __module_get(THIS_MODULE);
> >
> >         return 0;
> > --
> > 2.34.3
> >
>

