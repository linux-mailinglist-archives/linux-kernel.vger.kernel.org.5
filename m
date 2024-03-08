Return-Path: <linux-kernel+bounces-96545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC499875DE4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434AF1F21F39
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D640137171;
	Fri,  8 Mar 2024 06:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUcKz672"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716EF36AF6
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709878087; cv=none; b=Iw5ethL4xBrCgU8MTM12wqvsZt2VLu35iMtaT9O19ajjkvO7s1roUuDKNPNs0EGc0NVrTjDWCzSdy4XJZV+JTC7DeBjJ/Bhg641L07u0TzXgF0yW8t8eNBJEv7k2sWZiFZORZSCz4kqUCHDe60uWUJDhKiClCzSTQ9MuAWX42Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709878087; c=relaxed/simple;
	bh=7YpWVmYrVOMjZckwudUYybYbYai5gA/IrYHPE9vb9FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcljPqJqAZm3fG2oVfxrKj+j07+rV9eGyV9/kl/+ICXhsGQeR2npLyn6APs9UpNCRX8mBzwsxLPoUdvHrb1Mf8lptzVSvcrCpvZprO+z4UX6qprSYWUwI2ZjmWaT8wt2HTOmB+hLOZDpvFSr9XC7z8234Caab7vRfc/MUBKBIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUcKz672; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709878084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjazJGVZFwL3e1aTvOllZYDkxJStlgpfJkIakcQd+oY=;
	b=XUcKz672bkNd3hKJ2dqeg9nuKJdrH1G68RKYf+pltmOq6ZerTRTJca4iyjpg67X0sdP0fX
	v8bhXDZnwl4HXEncau8eKAlD7OpQfn2H2Y2TuUxQCceUm2TGLcdzyXvUYjm6KIXr9Rdy2F
	3+G1Xt92ClOmqOqRiVMczfme6tVHurA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-h0f0n-A8MiOohtSxsJZF2w-1; Fri, 08 Mar 2024 01:08:02 -0500
X-MC-Unique: h0f0n-A8MiOohtSxsJZF2w-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29ba3ccfd2bso865955a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 22:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709878082; x=1710482882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjazJGVZFwL3e1aTvOllZYDkxJStlgpfJkIakcQd+oY=;
        b=Vx/LQ/ki7F4oNHHX9WwDqqJVjLxqM7FQDxmpfygyQR/V+eTmAcu6GLwcLglsl3vVas
         SWDrT1hSdl7K/5gDzXjewBpM+36H8nDDshwz/An/o70Tps5mylEcUmEP7657t6kXfwdF
         1gskJuuAN9aPPvDzKckSlNFz5CQKZWvDzLpzKz+w+hfLAFbAiyqKli6t9T2FbwGzYp+3
         Yu0ktJ/PDkNewE0XsZix//hirQ74ADUeum2o3Cf9dJvm672vIeXkUFL8iKo1kAVT05DL
         idhbE5F6lcQi3Xvs4XDzFn+RUVk4F81/zs4llvF/LrmRnemVmW+TcoQzHGkQywM9i/tr
         riuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwCE0DvSjag2sHofNpwr5qs9brbJ9T7td1sOp0exH20CX71ZmZcspOTd/FK8J7nw2Qu1v6XnRruOTlWbuwO9rPXIk8aG263LHG9gtR
X-Gm-Message-State: AOJu0YzoD2qJNluqvw/Hra+Lzs4lfLfRwid4jLocJ2IDwv1HvVmN9Eek
	e8Fke1o5ZPDCTOQoNDa2XHCx8f8RiOjBHBS2Zv38lky46CvDO6veEppg699MmCxvNaApfu6ai67
	+Ih0RYCZZ6P57r2RDU1bCkcxr9H3UplAgheuMRP+j/SKb7Z4AWBDYY3b07JKDQDDEBREiAry5/9
	qsMpRwM1c61fboXap2QdsNlgVk2yK8g1LZII79
X-Received: by 2002:a17:90a:c68b:b0:29b:a4d9:b125 with SMTP id n11-20020a17090ac68b00b0029ba4d9b125mr2417698pjt.30.1709878081821;
        Thu, 07 Mar 2024 22:08:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvEj2tOepvmG03U/MUNAmrjPdcXZh96RC0TrnhACLptMRmO7ZzwpBAd7IskD0wwv1wLvIzWPUW8NnimBj2Kf8=
X-Received: by 2002:a17:90a:c68b:b0:29b:a4d9:b125 with SMTP id
 n11-20020a17090ac68b00b0029ba4d9b125mr2417687pjt.30.1709878081537; Thu, 07
 Mar 2024 22:08:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207054701.616094-1-lulu@redhat.com> <20240207054701.616094-5-lulu@redhat.com>
In-Reply-To: <20240207054701.616094-5-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Mar 2024 14:07:50 +0800
Message-ID: <CACGkMEuVnib2-m_J-wQuNny_1QZFaxi6OmDxHkFCC=Z-TY_qTQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] vduse: Add file operation for mmap
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, xieyongji@bytedance.com, linux-kernel@vger.kernel.org, 
	maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 1:47=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the operation for mmap, This function  will be used by the user space
> application to map the pages to the user space.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 57 ++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 2da659d5f4a8..083fe0047677 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1465,6 +1465,61 @@ static struct vduse_dev *vduse_dev_get_from_minor(=
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
> +       /* index 1+vq_number page reserved for virtqueue state*/

This comment seem wrong?

THanks


> +       vq =3D dev->vqs[index];
> +       vaddr =3D vq->vdpa_reconnect_vaddr;
> +       if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
> +                           PFN_DOWN(virt_to_phys((void *)vaddr)), PAGE_S=
IZE,
> +                           vma->vm_page_prot))
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
> +       if (index > dev->vq_num)
> +               return -EINVAL;
> +
> +       vq =3D dev->vqs[index];
> +       vaddr =3D vq->vdpa_reconnect_vaddr;
> +       if (vaddr =3D=3D 0)
> +               return -EOPNOTSUPP;
> +
> +       if (virt_to_phys((void *)vaddr) & (PAGE_SIZE - 1))
> +               return -EINVAL;
> +
> +       /* Check if the Userspace App mapped the correct size */
> +       if (vma->vm_end - vma->vm_start !=3D PAGE_SIZE)
> +               return -EOPNOTSUPP;
> +
> +       vm_flags_set(vma, VM_DONTEXPAND);
> +       vma->vm_ops =3D &vduse_vm_ops;
> +
> +       return 0;
> +}
> +
>  static int vduse_dev_open(struct inode *inode, struct file *file)
>  {
>         int ret;
> @@ -1497,6 +1552,8 @@ static const struct file_operations vduse_dev_fops =
=3D {
>         .unlocked_ioctl =3D vduse_dev_ioctl,
>         .compat_ioctl   =3D compat_ptr_ioctl,
>         .llseek         =3D noop_llseek,
> +       .mmap           =3D vduse_dev_mmap,
> +
>  };
>
>  static ssize_t irq_cb_affinity_show(struct vduse_virtqueue *vq, char *bu=
f)
> --
> 2.43.0
>


