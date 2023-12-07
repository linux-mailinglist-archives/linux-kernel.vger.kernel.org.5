Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BF8808379
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378382AbjLGIq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjLGIqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:46:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F54C6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701938787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdtFh8RVeKzHOaKhM9KvrZ9dXcN/A0fKoNgjzoMFQLI=;
        b=dlz8V8W8PqbnzLiiOQV47M7c7gbaPgCHAWaeVP0lID/i7dPr4K2u/rYwoQidSP31cc0T59
        MmQbdOnlEqzE/Y5XfP4cr+v9evsSMvzZI6Pwve7jg8sHCYZ/KQhnW5VoGCD8PLkOaVjOOE
        r23AIGW+QBbtBQ7oamDiJNlVyve8jAo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-Ivgk4BBuOdms3sjwnuDIMg-1; Thu, 07 Dec 2023 03:46:26 -0500
X-MC-Unique: Ivgk4BBuOdms3sjwnuDIMg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28643b4cef5so996925a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 00:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701938785; x=1702543585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdtFh8RVeKzHOaKhM9KvrZ9dXcN/A0fKoNgjzoMFQLI=;
        b=Ryxrz1dEnr5BeUDPnrnZ3O4vBvn0qY0BJ0JHaSNNyzRy0fmBRzG8d1GkSz2ZivhTR3
         mf0i8cYboWjqAXMXC4XuYw95c5pLXp58iAjDC1rLx7GaATrkAfmchR7Q5t46oYKAQAg5
         pp8otAk0svwYqn2Y1mBb9wYdvgMLBJd59mubZHn2Me0/TdLmKfw8uQD5jmF8VWfSExYf
         J9Ugls+8e0wxcie6bf5MPsdbDxJfSlASS4BjgB8bCGj9jnSJW+Ip8SjWMOQULT5vqNEg
         1VGcMXtLqGHLjqZw3eWS87YdARLKC5GpWA7Vf4IHrX0tjK2sTnD818Z0Z9rqaLXWdeWh
         UL1A==
X-Gm-Message-State: AOJu0Yx5vFD9+4AZt+q0jOPHKjQ12GliVStNA6mdECS98+I4+RKm6DOz
        r2uekXMqRkoRMxJQCnerCcMxPEM9pCMcG7hgE5gGcLwpaz2cJD8J6BGIP1DOu61FAUIJmqLE65S
        tcf4q2H7N+eRO9JP1mExPY3zbccMqcyd1v40BsbLI
X-Received: by 2002:a17:90a:bb83:b0:286:6cc1:3f29 with SMTP id v3-20020a17090abb8300b002866cc13f29mr1974845pjr.96.1701938785134;
        Thu, 07 Dec 2023 00:46:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCJW3pmA57tPqJVhtXEE1h/B3rf4vYNfq/rIoKKvlVER2mSQg6Dqvf9s6MJWsg2f75b2B5Px+OkAWsHjMFPOY=
X-Received: by 2002:a17:90a:bb83:b0:286:6cc1:3f29 with SMTP id
 v3-20020a17090abb8300b002866cc13f29mr1974837pjr.96.1701938784837; Thu, 07 Dec
 2023 00:46:24 -0800 (PST)
MIME-Version: 1.0
References: <20231205083444.3029239-1-lulu@redhat.com> <20231205083444.3029239-6-lulu@redhat.com>
In-Reply-To: <20231205083444.3029239-6-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 7 Dec 2023 16:46:12 +0800
Message-ID: <CACGkMEv+myMJ1MXNz5RAfggkYy-0Q-VVyZKkpg_DD+_wfMxFQQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] vduse: Add file operation for mmap
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
> Add the operation for mmap, This function  will be used by the user space
> application to map the pages to the user space.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 75 ++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 52ccde636406..f55f415629de 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1381,6 +1381,79 @@ static struct vduse_dev *vduse_dev_get_from_minor(=
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
> +       unsigned long vaddr;
> +
> +       /* index 0  page reserved for vduse status*/

I'd suggest to tweak it as "reserved for device state"

> +       if (index =3D=3D 0) {
> +               vaddr =3D dev->vdpa_reconnect_vaddr;
> +       } else {
> +               /* index 1+vq_number page reserved for vduse vqs*/

And "reserved for virtqueue state"

> +               vq =3D &dev->vqs[index - 1];
> +               vaddr =3D vq->vdpa_reconnect_vaddr;
> +       }
> +       if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
> +                           PFN_DOWN(virt_to_phys((void *)vaddr)),
> +                           VDUSE_RECONNCT_MMAP_SIZE, vma->vm_page_prot))

If there's no chance for VDUSE_RECONNCT_MMAP_SIZE to differ from
PAGE_SIZE. Let's just use PAGE_SIZE here.

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
> +       unsigned long vaddr =3D 0;
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

Code explains itself, let's just drop the comment please.

> +       if (index > dev->vq_num + 1)
> +               return -EINVAL;
> +
> +       /* index 0  page reserved for vduse status*/

This comment duplicates the one in fault. I'd suggest to move it to uAPI.

> +       if (index =3D=3D 0) {
> +               vaddr =3D dev->vdpa_reconnect_vaddr;
> +       } else {
> +               /* index 1+vq_number page reserved for vduse vqs*/
> +               vq =3D &dev->vqs[index - 1];
> +               vaddr =3D vq->vdpa_reconnect_vaddr;
> +       }
> +       /* Check whether the memory for the mmap was allocated by the ker=
nel.
> +        * If not, this device may not have been created/destroyed correc=
tly.
> +        */

Code explains, so let's drop the comment.

> +       if (vaddr =3D=3D 0)
> +               return -EOPNOTSUPP;
> +
> +       /* check if the address is page aligned, if not,
> +        * this address maybe damaged
> +        */

And this comment.

Thanks

