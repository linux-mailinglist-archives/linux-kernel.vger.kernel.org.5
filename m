Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510997CD275
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 04:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjJRC5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 22:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJRC5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 22:57:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930CCAB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 19:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697597817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/mNYKp7C3qNom1DU5UHpkV9T8V+sAecGzxKfmcsk89w=;
        b=QLrN1Xvjg3PcbXzVXTXgYOT2nHMzTFgq25fYCRYEqEZkVv8CzI7SuDCei+nnGGI1i3kz5F
        9wLVtPs7x8kZa1TZlucSDAwRYZo1V8FRumkimYb8XX2dMBIfztWLLCcIAe4VMSaU2Dm7HA
        C8Lve6RCdY0MyNOvBZgqW5vUInAg464=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-n7mckJ2jO92haaXAJY62Cw-1; Tue, 17 Oct 2023 22:56:56 -0400
X-MC-Unique: n7mckJ2jO92haaXAJY62Cw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507a3ae32b2so3558722e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 19:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697597814; x=1698202614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mNYKp7C3qNom1DU5UHpkV9T8V+sAecGzxKfmcsk89w=;
        b=TJDbiN417PBjTNjQ7B/eIaIGqmPORih7k5ZJUKURxRD6nwlQRkhe3DRJAJt/V8QUPK
         mSoRW265vqv9yi5faCVbYuHZrcFTTwInlMEDQofpZnmvIuHOFqcjBjpZYGLIjI8aZLMB
         D4i0y2sYOKFILhplMcuilVcmbGGBfu5k/yi4tCt1+/q/mniWyfLaIDTCLytIpn71vZxU
         08ET6DqeiQpZHPrDw3Rbq1yeAF4Oe9faIrkSnP5CxjpD5k5PV82uOvPausID0Y3azf/4
         1u63m/9qe/3dexNytHUNkdJ/TpcF/i4HhL/cDYYYhoT4jLX8lRiAJcFQDWanjCLhs9o5
         9TUQ==
X-Gm-Message-State: AOJu0YzlRckOokgJHzzcmQ5wI2zyvpfdx7SzfttA2LVR6gJayyxDg7X1
        d9K7HrzuK8kQdqj9XP3aqaalGpPHT+ZMJy/PkKvb1eX6/GhnMp9CCtB8OmpJOXagX6QGzcCzlNJ
        obQ9t69qYv0J4KvebRqP29WfYFChxBM/6F4DSGDHH
X-Received: by 2002:a05:6512:3c95:b0:507:9803:ff8b with SMTP id h21-20020a0565123c9500b005079803ff8bmr3296287lfv.44.1697597814655;
        Tue, 17 Oct 2023 19:56:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGonCGzeZSd/aL/CcxyZXHqoNVJD00xpe2c6AImYeeI6TCSq08BNO/4H3NTOBaoQRTIIp985M7wGsIAZblwcYQ=
X-Received: by 2002:a05:6512:3c95:b0:507:9803:ff8b with SMTP id
 h21-20020a0565123c9500b005079803ff8bmr3296276lfv.44.1697597814315; Tue, 17
 Oct 2023 19:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231011064208.2143245-1-lulu@redhat.com> <20231011064208.2143245-2-lulu@redhat.com>
In-Reply-To: <20231011064208.2143245-2-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 18 Oct 2023 10:56:43 +0800
Message-ID: <CACGkMEupWg6v2Kp1QFDE1qsc4SeZ220jo0XJ=07h5HJPLSC_Qw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] vduse: Add function to get/free the pages for reconnection
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 2:42=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function vduse_alloc_reconnnect_info_mem
> and vduse_alloc_reconnnect_info_mem
> In this 2 function, vduse will get/free (vq_num + 1)*page
> Page 0 will be used to save the reconnection information, The
> Userspace App will maintain this. Page 1 ~ vq_num + 1 will save
> the reconnection information for vqs.

I'd align this with the spec. E.g spec starts virtqueue index from 0.

>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 78 ++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 26b7e29cb900..565126a9ab01 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -30,6 +30,10 @@
>  #include <uapi/linux/virtio_blk.h>
>  #include <linux/mod_devicetable.h>
>
> +#ifdef CONFIG_X86
> +#include <asm/set_memory.h>
> +#endif

Why do we need special care for x86?

> +
>  #include "iova_domain.h"
>
>  #define DRV_AUTHOR   "Yongji Xie <xieyongji@bytedance.com>"
> @@ -41,6 +45,19 @@
>  #define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
>  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
>
> +/* struct vdpa_reconnect_info saved the alloc pages info
> + * these pages will mmaped to userspace for reconnection
> + */
> +struct vdpa_reconnect_info {
> +       /* Offset (within vm_file) in PAGE_SIZE
> +        */
> +       u32 index;
> +       /* virtual address for this page*/
> +       unsigned long vaddr;
> +       /* allocated memory size, */
> +       phys_addr_t size;

Anything wrong with using "unsigned long" here.

Btw, what is "allocated memory size" since I think we can use up to
PAGE_SIZE here?

> +};
> +
>  struct vduse_virtqueue {
>         u16 index;
>         u16 num_max;
> @@ -57,6 +74,7 @@ struct vduse_virtqueue {
>         struct vdpa_callback cb;
>         struct work_struct inject;
>         struct work_struct kick;
> +       struct vdpa_reconnect_info reconnect_info;
>  };
>
>  struct vduse_dev;
> @@ -106,6 +124,7 @@ struct vduse_dev {
>         u32 vq_align;
>         struct vduse_umem *umem;
>         struct mutex mem_lock;
> +       struct vdpa_reconnect_info reconnect_status;
>  };
>
>  struct vduse_dev_msg {
> @@ -1030,6 +1049,61 @@ static int vduse_dev_reg_umem(struct vduse_dev *de=
v,
>         return ret;
>  }
>
> +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> +{
> +       struct vdpa_reconnect_info *info;
> +       struct vduse_virtqueue *vq;
> +       void *addr;
> +
> +       /*page 0 is use to save status,dpdk will use this to save the inf=
ormation
> +        *needed in reconnection,kernel don't need to maintain this
> +        */

Let's avoid mentioning any specific userspace like DPDK in the kernel
source. A good uAPI should not be designed for a specific userspace.

> +       info =3D &dev->reconnect_status;
> +       addr =3D (void *)get_zeroed_page(GFP_KERNEL);
> +       if (!addr)
> +               return -1;

Let's don't use magic number here but something like -ENOMEM.

> +
> +       info->vaddr =3D (unsigned long)(addr);
> +       info->size =3D PAGE_SIZE;
> +       /* index is vm Offset in PAGE_SIZE */
> +       info->index =3D 0;
> +
> +       /*page 1~ vq_num + 1 save the reconnect info for vqs*/

There's no need to explain what the code does.

> +       for (int i =3D 0; i < dev->vq_num + 1; i++) {
> +               vq =3D &dev->vqs[i];
> +               info =3D &vq->reconnect_info;
> +               addr =3D (void *)get_zeroed_page(GFP_KERNEL);
> +               if (!addr)
> +                       return -1;
> +
> +               info->vaddr =3D (unsigned long)(addr);
> +               info->size =3D PAGE_SIZE;
> +               info->index =3D i + 1;

Btw, I don't see an obvious difference in the page for virtqueue and
device. Could we unify the logic there? So did the free.

> +       }
> +
> +       return 0;
> +}
> +
> +static int vduse_free_reconnnect_info_mem(struct vduse_dev *dev)
> +{
> +       struct vdpa_reconnect_info *info;
> +       struct vduse_virtqueue *vq;
> +
> +       info =3D &dev->reconnect_status;
> +       free_page(info->vaddr);
> +       info->size =3D 0;
> +       info->vaddr =3D 0;
> +       for (int i =3D 0; i < dev->vq_num + 1; i++) {
> +               vq =3D &dev->vqs[i];
> +               info =3D &vq->reconnect_info;
> +               free_page(info->vaddr);
> +               info->size =3D 0;
> +               info->vaddr =3D 0;
> +       }
> +
> +       return 0;
> +}
> +
>  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                             unsigned long arg)
>  {
> @@ -1390,6 +1464,8 @@ static int vduse_destroy_dev(char *name)
>                 mutex_unlock(&dev->lock);
>                 return -EBUSY;
>         }
> +       vduse_free_reconnnect_info_mem(dev);
> +
>         dev->connected =3D true;
>         mutex_unlock(&dev->lock);
>
> @@ -1542,6 +1618,8 @@ static int vduse_create_dev(struct vduse_dev_config=
 *config,
>                 ret =3D PTR_ERR(dev->dev);
>                 goto err_dev;
>         }
> +
> +       vduse_alloc_reconnnect_info_mem(dev);

The errors were ignored here.

Thanks

>         __module_get(THIS_MODULE);
>
>         return 0;
> --
> 2.34.3
>

