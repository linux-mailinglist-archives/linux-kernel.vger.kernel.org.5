Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16417CD284
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 05:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjJRDHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 23:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjJRDHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 23:07:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D56C4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 20:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697598404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=knu+qQQjDBUA/dZ6kO4FeP9AA06fDcHj999eqRawHPY=;
        b=Xf9iS3scmp0hz/cackDxlJ2bWumkIw/pjvrToFAIBW6ViUj83kMFnAGqaxVUu/ZzZJUMVx
        m4Sf7bdDKsKMR9Rne3voSZyXX9RARVJPmpiYlpI+Grh1P4p3Jwe/d23eBjmPBe0WPaxKZz
        cVyAjTgdKrugPB1VZMgqxRWjSy3YW4U=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-gmczabRdOh2AlJj2Qi8xZw-1; Tue, 17 Oct 2023 23:06:31 -0400
X-MC-Unique: gmczabRdOh2AlJj2Qi8xZw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5079630993dso5213770e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 20:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697598357; x=1698203157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knu+qQQjDBUA/dZ6kO4FeP9AA06fDcHj999eqRawHPY=;
        b=DWVRjdv2l73QCeC4NSMq2UTeMYxv5x+TWjGgsl8FdFfhTajwa/3JhC/JZkq6Ws0Go8
         jgwzwd8YgBuLMG3Xf2RYNyhShBR8NLdsGoTKf1HQpi2KElMf1El8KJla+md/MeQy3noJ
         gWuex6AAsz4KFT3reN4PwXIBZqiWXmkOGgm0JXDJo+oVFCU6eAUVpA15ZHWBOvzg2Fd1
         kcCxKvlY7UmekfYAY21uN9Wn1D6XfY2CEx3B+cnZTIFvI110JITBR1pyQ/4txfPzwBdN
         uWbdiTCq1FVH2/P8uEc0FO7Ra67yPgkiOz8Y6W1M2BBEoBySnu2FtdwU+fmZ1mf6KH5r
         DSjQ==
X-Gm-Message-State: AOJu0YwYly6SxttyG0jTkm+TKQsbBapeAPXMaFQojE2CiNgS64enGVkQ
        83Tla8BTXXcTq9SRkX/IJB+eDmOyjABf9CCnaMrXeJxKaZaJfZaDYkaaToCjRTO/jytmfBuFUJT
        ZNXiFAIrEMn8KU4x3OujmfhebZvwn9Amdgaawj1w6
X-Received: by 2002:a05:6512:1105:b0:507:b9db:61dc with SMTP id l5-20020a056512110500b00507b9db61dcmr3655319lfg.48.1697598357542;
        Tue, 17 Oct 2023 20:05:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGk7e1IUFxFXB+4B7upxTBrV0V3iVFKuU4YTGZ9fxkdtOBiLQUjeuyaervERwSDdigTO1NSURoIruLuKk1YLs=
X-Received: by 2002:a05:6512:1105:b0:507:b9db:61dc with SMTP id
 l5-20020a056512110500b00507b9db61dcmr3655312lfg.48.1697598357169; Tue, 17 Oct
 2023 20:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231011064208.2143245-1-lulu@redhat.com> <20231011064208.2143245-3-lulu@redhat.com>
In-Reply-To: <20231011064208.2143245-3-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 18 Oct 2023 11:05:46 +0800
Message-ID: <CACGkMEuyG=Nh6eD3Vv4NHYkhLWmKSXD6au1epoWBHnJCwtjuGQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] vduse: Add file operation for mmap
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
> Add the operation for mmap, The user space APP will
> use this function to map the pages to userspace
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 66 ++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 565126a9ab01..05e72d752fb6 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1380,6 +1380,70 @@ static struct vduse_dev *vduse_dev_get_from_minor(=
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
> +               info =3D &dev->reconnect_status;
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
> +       if (index > dev->vq_num + 1)
> +               return -EINVAL;
> +
> +       /* index 0  page reserved for vduse status*/
> +       if (index =3D=3D 0) {
> +               info =3D &dev->reconnect_status;
> +       } else {
> +               /* index 1+vq_number page reserved for vduse vqs*/
> +               vq =3D &dev->vqs[index - 1];
> +               info =3D &vq->reconnect_info;
> +       }
> +       if (info->vaddr =3D=3D 0)
> +               return -ENOTSUPP;

Under which condition could we meet this?

> +
> +       if (virt_to_phys((void *)info->vaddr) & (PAGE_SIZE - 1))
> +               return -EINVAL;

And this?

> +       if (vma->vm_end - vma->vm_start !=3D info->size)
> +               return -EOPNOTSUPP;
> +
> +       vm_flags_set(vma, VM_IO | VM_DONTDUMP);

I still don't understand the flags here. Or at least it requires some
comment to explain why they are needed here.

Please refer to the kernel sources which explains their use cases.

Thanks

> +       vma->vm_ops =3D &vduse_vm_ops;
> +
> +       return 0;
> +}
> +
>  static int vduse_dev_open(struct inode *inode, struct file *file)
>  {
>         int ret;
> @@ -1412,6 +1476,8 @@ static const struct file_operations vduse_dev_fops =
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

