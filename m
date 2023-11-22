Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F847F3DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjKVGOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVGOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:14:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F3AB9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700633669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KKPwlXoRdvHrL4acKoT0cg1bZmzPR4xO2fjyzcEhua0=;
        b=MVgkMmnijAYWAy2A8U+sqxDJBacaTD2FavmBLDqsnjhoonhkm8Uap+y5ZlzOsfU0XpeVPG
        B3Sh6eLJ6tLUi51Obw1SYNgKMz0RTYaLoiVqlJZnNso+avSvHnnbADy5FL0xJPxun1WYvE
        nrdIsl6CnBSQQdb1q7O3CP7jlXzXPHM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-tmY0LH7JNEiCRnAg8E81sg-1; Wed, 22 Nov 2023 01:14:27 -0500
X-MC-Unique: tmY0LH7JNEiCRnAg8E81sg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507b0270b7fso6256901e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700633666; x=1701238466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKPwlXoRdvHrL4acKoT0cg1bZmzPR4xO2fjyzcEhua0=;
        b=wITBqRYRgPtOKPToIuynHXS53N0XQWgQ2YcRoSgOEyXUs9TbjgJRLHmhhFYt0AWDOT
         o/flUaD4Y6WTb4PRzJcuQ+Br/sXmY+H9GaS0vodwaCnBOH52FglnSoI0QG066tlm3XWC
         SGdScpyMWmpZGvcxTIbxMT7WaVCq+Lu5PMld+/3gAKkjc829Un+GxseVpldIrw/7J67m
         9q9Gpa2GcxD0+qggluOmBaJmPnm4VRDf0iH/9JAc63SkcVjzKFfw8rwc1CkW2bPvFrxE
         mK9izLqWqyiphcPk/wRe7psjvT+76Ow8dw84CICAN8VDJoLFn0XzWDNWD+a1lxcq43N1
         jgOw==
X-Gm-Message-State: AOJu0Yz/Bnka8BlV6AemMfoofcvHe7Yi4uNGNCyVWz7H461CF/gAbGRx
        Z05m4Cz0j6kZPi1zyuEOWag+ISkmYQuAvRwKzdoB/G5x803C2ctsmp6hdX7Shio3dvC77ejVyDP
        UmYHJqlIyncPFBHxviCcgwjoBozKwi/y4R0wgjDgO
X-Received: by 2002:ac2:554d:0:b0:507:9787:6776 with SMTP id l13-20020ac2554d000000b0050797876776mr836972lfk.5.1700633666134;
        Tue, 21 Nov 2023 22:14:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwPXWugvFSNDBWE2kG2dtlfCOVXcgR/4hPMYPgrXtXBkHguuIf+yR9dKh3UBHkTdpv6+g3Ouc58AGcf26YLCQ=
X-Received: by 2002:ac2:554d:0:b0:507:9787:6776 with SMTP id
 l13-20020ac2554d000000b0050797876776mr836963lfk.5.1700633665803; Tue, 21 Nov
 2023 22:14:25 -0800 (PST)
MIME-Version: 1.0
References: <20231121073050.287080-1-lulu@redhat.com> <20231121073050.287080-3-lulu@redhat.com>
In-Reply-To: <20231121073050.287080-3-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 22 Nov 2023 14:14:14 +0800
Message-ID: <CACGkMEtkrqnahGQ2n==5CXWJzaSiNx9W-25FU3tk1EYzgcoFWA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] vduse: Add file operation for mmap
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 3:31=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the operation for mmap, The user space APP will
> use this function to map the pages to userspace
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 79 ++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 6209e2f00278..ccb30e98bab5 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1376,6 +1376,83 @@ static struct vduse_dev *vduse_dev_get_from_minor(=
int minor)
>         return dev;
>  }
>
> +static vm_fault_t vduse_vm_fault(struct vm_fault *vmf)
> +{
> +       struct vduse_dev *dev =3D vmf->vma->vm_file->private_data;
> +       struct vm_area_struct *vma =3D vmf->vma;
> +       u16 index =3D vma->vm_pgoff;
> +       struct vduse_virtqueue *vq;
> +       struct vdpa_reconnect_info *info;
> +
> +       /* index 0  page reserved for vduse status*/
> +       if (index =3D=3D 0) {

I'd avoid using magic numbers but a well defined uAPI for 0.

> +               info =3D &dev->reconnect_info;
> +       } else {
> +               /* index 1+vq_number page reserved for vduse vqs*/
> +               vq =3D &dev->vqs[index - 1];
> +               info =3D &vq->reconnect_info;
> +       }
> +       if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
> +                           PFN_DOWN(virt_to_phys((void *)info->vaddr)),
> +                           PAGE_SIZE, vma->vm_page_prot))
> +               return VM_FAULT_SIGBUS;
> +       return VM_FAULT_NOPAGE;
> +}
> +
> +static const struct vm_operations_struct vduse_vm_ops =3D {
> +       .fault =3D vduse_vm_fault,
> +};
> +
> +static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +       struct vduse_dev *dev =3D file->private_data;
> +       struct vdpa_reconnect_info *info;
> +       unsigned long index =3D vma->vm_pgoff;
> +       struct vduse_virtqueue *vq;
> +
> +       if (vma->vm_end - vma->vm_start !=3D PAGE_SIZE)
> +               return -EINVAL;
> +       if ((vma->vm_flags & VM_SHARED) =3D=3D 0)
> +               return -EINVAL;
> +
> +       /*check if Userspace App map the page number larger than kernel a=
llocated*/

Code explains themselves, such comment is not necessary.

> +       if (index > dev->vq_num + 1)
> +               return -EINVAL;
> +
> +       /* index 0  page reserved for vduse status*/
> +       if (index =3D=3D 0) {
> +               info =3D &dev->reconnect_info;
> +       } else {
> +               /* index 1+vq_number page reserved for vduse vqs*/
> +               vq =3D &dev->vqs[index - 1];
> +               info =3D &vq->reconnect_info;
> +       }
> +       /*check if map pages was allocated and inited by kernel */

Typo above.

> +       if (info->vaddr =3D=3D 0)
> +               return -EOPNOTSUPP;

Under which condition can we reach here?

> +
> +       /* check if the address is page aligned, if not,
> +        * this address maybe damaged
> +        */
> +       if (virt_to_phys((void *)info->vaddr) & (PAGE_SIZE - 1))
> +               return -EINVAL;

And here?

Thanks

> +
> +       /* check if Userspace App mapped the correct size
> +        * the userspace App should map one page each time
> +        */
> +       if (vma->vm_end - vma->vm_start !=3D PAGE_SIZE)
> +               return -EOPNOTSUPP;
> +       /* VM_IO: set as a memory-mapped I/O region,This will for vq info=
rmation
> +        * VM_PFNMAP: only need  the pure PFN
> +        * VM_DONTEXPAND: do not need to use mremap() in this function
> +        * VM_DONTDUMP:Do not include in the core dump
> +        */
> +       vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP=
);
> +       vma->vm_ops =3D &vduse_vm_ops;
> +
> +       return 0;
> +}
> +
>  static int vduse_dev_open(struct inode *inode, struct file *file)
>  {
>         int ret;
> @@ -1408,6 +1485,8 @@ static const struct file_operations vduse_dev_fops =
=3D {
>         .unlocked_ioctl =3D vduse_dev_ioctl,
>         .compat_ioctl   =3D compat_ptr_ioctl,
>         .llseek         =3D noop_llseek,
> +       .mmap           =3D vduse_dev_mmap,
> +
>  };
>
>  static struct vduse_dev *vduse_dev_create(void)
> --
> 2.34.3
>

