Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04CA7F8B2A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 14:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjKYNq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 08:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKYNq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 08:46:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62506FB
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700920021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s4xnvjR6dkeo3Zbav1iU/yYZv9xD2F8SSNLEeJJPVrw=;
        b=guRmdcS0k3kJqENOoslNplsZ3+LMu7RkUEa2slepefkm3O3hlQp5cFNw4KS0uSfO3FQ8yt
        VEI6lwa2TQmk/nlNvxoGekQsT+yW5fSBg5UzCqKFnf/LTDbrkXdzdYxKRnJV6QgYySTyaH
        IfQmImIesILzxJi98Z6cfVfWk/KXNBU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-sspEsL4rOk-CgVR5xK4IFQ-1; Sat, 25 Nov 2023 08:46:59 -0500
X-MC-Unique: sspEsL4rOk-CgVR5xK4IFQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9fd0a58549bso318956066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700920018; x=1701524818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4xnvjR6dkeo3Zbav1iU/yYZv9xD2F8SSNLEeJJPVrw=;
        b=vFgT+PjEv5RLQMtodBQF1pnhnWmvd8Mxo4qxuxuOwCdXPxtUhY/Y2MbeRFpXDjf74+
         b1UccM88xUnJ0MtChtuzjyH6tJTCUbssOjJBjDQWFMmadc8ACVX6dXB8lDOB0sv/zo4J
         C3rGG1WGx9l3LtMaE01AG6h05vysQCisOYkPfC0Hw+oqjTP6Tfi77ZtUZLyNMjOFrw3u
         zmUJ0Li4zup2CWfgAdSnLe2qB6E0C/lYS/frzssaNJc1Z2YepPcEaqkKExIJzWcOJJ2F
         +a0tsxil7yeF3c2z9LRdrBb9pX09XVMN/MZhzHN8xjJgQRG7bkr6S/h913d1TWFeJdrX
         0QPA==
X-Gm-Message-State: AOJu0YzCRdFexq5CjULgTAankkiAZxvla5X4EbmGJ3jP7B/RaNHoqgFy
        CXaq87YXHgP1MzFU4ZJrwVktVJt8NpZvnV+84j9TQg+yALNyv4XJRF5TGW9L2DebD+YZsw+wzAa
        DwpwAOOzeLcIK9m0meCqr4Yn6rzAyQ0OKqUmIqxID
X-Received: by 2002:a17:906:19c8:b0:9fd:79b3:e2b3 with SMTP id h8-20020a17090619c800b009fd79b3e2b3mr9028518ejd.9.1700920018638;
        Sat, 25 Nov 2023 05:46:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/a5i5Oa90E6oNSsiwCrdryOVUB+CFfkgXuJm/I9a/VnwZnhghDYE4DMAbI6PcKnuu/pFR8GSQi4nZzaFTAKc=
X-Received: by 2002:a17:906:19c8:b0:9fd:79b3:e2b3 with SMTP id
 h8-20020a17090619c800b009fd79b3e2b3mr9028508ejd.9.1700920018353; Sat, 25 Nov
 2023 05:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20231121073050.287080-1-lulu@redhat.com> <20231121073050.287080-3-lulu@redhat.com>
 <CACGkMEtkrqnahGQ2n==5CXWJzaSiNx9W-25FU3tk1EYzgcoFWA@mail.gmail.com>
In-Reply-To: <CACGkMEtkrqnahGQ2n==5CXWJzaSiNx9W-25FU3tk1EYzgcoFWA@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Sat, 25 Nov 2023 21:46:21 +0800
Message-ID: <CACLfguX-b4JCAKoD0FHjRRj6Kh13LzW2Z4HK5t-bXqczLBJBbg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] vduse: Add file operation for mmap
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

On Wed, Nov 22, 2023 at 2:14=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Nov 21, 2023 at 3:31=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add the operation for mmap, The user space APP will
> > use this function to map the pages to userspace
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 79 ++++++++++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 6209e2f00278..ccb30e98bab5 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1376,6 +1376,83 @@ static struct vduse_dev *vduse_dev_get_from_mino=
r(int minor)
> >         return dev;
> >  }
> >
> > +static vm_fault_t vduse_vm_fault(struct vm_fault *vmf)
> > +{
> > +       struct vduse_dev *dev =3D vmf->vma->vm_file->private_data;
> > +       struct vm_area_struct *vma =3D vmf->vma;
> > +       u16 index =3D vma->vm_pgoff;
> > +       struct vduse_virtqueue *vq;
> > +       struct vdpa_reconnect_info *info;
> > +
> > +       /* index 0  page reserved for vduse status*/
> > +       if (index =3D=3D 0) {
>
> I'd avoid using magic numbers but a well defined uAPI for 0.
>
sure will Add this

> > +               info =3D &dev->reconnect_info;
> > +       } else {
> > +               /* index 1+vq_number page reserved for vduse vqs*/
> > +               vq =3D &dev->vqs[index - 1];
> > +               info =3D &vq->reconnect_info;
> > +       }
> > +       if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
> > +                           PFN_DOWN(virt_to_phys((void *)info->vaddr))=
,
> > +                           PAGE_SIZE, vma->vm_page_prot))
> > +               return VM_FAULT_SIGBUS;
> > +       return VM_FAULT_NOPAGE;
> > +}
> > +
> > +static const struct vm_operations_struct vduse_vm_ops =3D {
> > +       .fault =3D vduse_vm_fault,
> > +};
> > +
> > +static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vm=
a)
> > +{
> > +       struct vduse_dev *dev =3D file->private_data;
> > +       struct vdpa_reconnect_info *info;
> > +       unsigned long index =3D vma->vm_pgoff;
> > +       struct vduse_virtqueue *vq;
> > +
> > +       if (vma->vm_end - vma->vm_start !=3D PAGE_SIZE)
> > +               return -EINVAL;
> > +       if ((vma->vm_flags & VM_SHARED) =3D=3D 0)
> > +               return -EINVAL;
> > +
> > +       /*check if Userspace App map the page number larger than kernel=
 allocated*/
>
> Code explains themselves, such comment is not necessary.
>
sure will remove this
> > +       if (index > dev->vq_num + 1)
> > +               return -EINVAL;
> > +
> > +       /* index 0  page reserved for vduse status*/
> > +       if (index =3D=3D 0) {
> > +               info =3D &dev->reconnect_info;
> > +       } else {
> > +               /* index 1+vq_number page reserved for vduse vqs*/
> > +               vq =3D &dev->vqs[index - 1];
> > +               info =3D &vq->reconnect_info;
> > +       }
> > +       /*check if map pages was allocated and inited by kernel */
>
> Typo above.
>
> > +       if (info->vaddr =3D=3D 0)
> > +               return -EOPNOTSUPP;
>
> Under which condition can we reach here?
>
if the userApp call this mmap without call the dev_create,may
cause this problem, So Add the check here
thanks
Cindy
> > +
> > +       /* check if the address is page aligned, if not,
> > +        * this address maybe damaged
> > +        */
> > +       if (virt_to_phys((void *)info->vaddr) & (PAGE_SIZE - 1))
> > +               return -EINVAL;
>
> And here?
>
if the address is not page-aligned, this information may be damaged
So add the check here
> Thanks
>
> > +
> > +       /* check if Userspace App mapped the correct size
> > +        * the userspace App should map one page each time
> > +        */
> > +       if (vma->vm_end - vma->vm_start !=3D PAGE_SIZE)
> > +               return -EOPNOTSUPP;
> > +       /* VM_IO: set as a memory-mapped I/O region,This will for vq in=
formation
> > +        * VM_PFNMAP: only need  the pure PFN
> > +        * VM_DONTEXPAND: do not need to use mremap() in this function
> > +        * VM_DONTDUMP:Do not include in the core dump
> > +        */
> > +       vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDU=
MP);
> > +       vma->vm_ops =3D &vduse_vm_ops;
> > +
> > +       return 0;
> > +}
> > +
> >  static int vduse_dev_open(struct inode *inode, struct file *file)
> >  {
> >         int ret;
> > @@ -1408,6 +1485,8 @@ static const struct file_operations vduse_dev_fop=
s =3D {
> >         .unlocked_ioctl =3D vduse_dev_ioctl,
> >         .compat_ioctl   =3D compat_ptr_ioctl,
> >         .llseek         =3D noop_llseek,
> > +       .mmap           =3D vduse_dev_mmap,
> > +
> >  };
> >
> >  static struct vduse_dev *vduse_dev_create(void)
> > --
> > 2.34.3
> >
>

