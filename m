Return-Path: <linux-kernel+bounces-96580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89C0875E75
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECC61F22A29
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADF14F5ED;
	Fri,  8 Mar 2024 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XD4uKjJt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E002E3E4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709882871; cv=none; b=XMTYRe85+zj+fF+MaVEZ2o2JrrVx+th0S8/qYopooT/rvgMrJwNbjL7S+/KfBbPUwYjIgAzqSdG6rr7W79N9DQWmQjvRFf2BHXR5KcuKMeIrvFJ/3WoBJFhDrgHJhbnfPWHTFtYetsWBOn8EgUBA5rWUVqLabLrnyWch2Ijnrag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709882871; c=relaxed/simple;
	bh=TaVRYX6mTTcIDmJzvOhB9jofGIKklYC0TeLJNtczWr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfTolWvvWKpugKWO84mA3reSIIhhAwtV3cDtLc/p5IB6E8nnXQ5b66u95s26ddDfCPUVvm4jfSqUWl/siltBP9DzqQYSIv225TCGAMZYo376+jSOHlhpbTHqOxErPNtU0h57pDuhVjBz5cVkCROPty1YPo86be1kPozbDQeamB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XD4uKjJt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709882868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KGSQtmcvwhx9FAHU646F16RyelIqAirbEons+/dHzTo=;
	b=XD4uKjJtLOvp41NTbXgXKGRxcQy3X+I5u0cak+EY9KradqoXzZMftwfZnfGnJLOPA2EZez
	p21ZB7piXoWBNDxo5vRd2HBFVqFWtSjnFPkG2sXai+Rb4wBY28R90ZfZpJ9aNrf0CR8hWO
	+LouzWKeEkddK9nwXtYetAAB9WD0vvs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-Kty9rfgUNLu-DsdXNHKrGA-1; Fri, 08 Mar 2024 02:27:46 -0500
X-MC-Unique: Kty9rfgUNLu-DsdXNHKrGA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5681e23b052so834893a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 23:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709882865; x=1710487665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGSQtmcvwhx9FAHU646F16RyelIqAirbEons+/dHzTo=;
        b=cC3PLcWzYkYnkr+VkCmaYUKOP12F6qaI/hx0+vmMmxbVMZmhU64r+2SARuCFb4qQzM
         doSWDprjfPoSZ/tdFmPLsnuJt/1Nqlis57cX3RVA8BrGNZCFogRtnDVjbGLYpWJQu6Gi
         8MXz8joOQFesDEMWAvL8gFde7ycfsxkZkv4RAIwqRsupNxc6HxBhSmnypiR2GVad3GgU
         /6owE42tseGovdV/+bEvrTcw0xKkrmwH+PDjoc/6AeCvr6TR/VqPHkwSBbnh9WHoMGEA
         YahDVYMeYC/FfF9zwWd0xwcb9GiA02I0Un5jPFO3V6Qk6rvE+gavp4+BjKv4jO1LN4WA
         w+tg==
X-Forwarded-Encrypted: i=1; AJvYcCUGWk0Dne+XQZo/8nTnbaR2IeoSh4/TXd8D7illST6mt9wdz2WlKrX6t0JJS/RTyer7w9XZtykOTEWvSQFr129u3gG/8CRhgp0lpVlF
X-Gm-Message-State: AOJu0YwMXQ2EPx6j7uaa1bk3yOue31a3aaSc6DPjX4StiblkM5xQT2Zy
	bwSkWuuaXbrXHvHj2gSfWUNnghzZdZj3xqlr2HyUG9ty88W4u7Wr5+XV4G3WIBuvCbkuoKb6EWX
	ph5jWe4pxVtRp0jlAiy9BC33Q+GaGghBk1ZbTperaCy403OvCNjnfm/94ALt0XuIUcsWfcqnUtF
	5sA6PM3YSCYb9I0hziK3PJWjkcYBZs+d5o2PFa
X-Received: by 2002:a17:907:a70a:b0:a45:f352:73b2 with SMTP id vw10-20020a170907a70a00b00a45f35273b2mr351523ejc.31.1709882865588;
        Thu, 07 Mar 2024 23:27:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEG2sFbnOgh0T2oH6RPoo2yQg5Js5bRiQrpQPjCMB+sGEP+Dvwut8HXd3ECU7SxtAQsACbk7OT2KmBL5WW3FMw=
X-Received: by 2002:a17:907:a70a:b0:a45:f352:73b2 with SMTP id
 vw10-20020a170907a70a00b00a45f35273b2mr351517ejc.31.1709882865282; Thu, 07
 Mar 2024 23:27:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207054701.616094-1-lulu@redhat.com> <20240207054701.616094-5-lulu@redhat.com>
 <CACGkMEuVnib2-m_J-wQuNny_1QZFaxi6OmDxHkFCC=Z-TY_qTQ@mail.gmail.com>
In-Reply-To: <CACGkMEuVnib2-m_J-wQuNny_1QZFaxi6OmDxHkFCC=Z-TY_qTQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 8 Mar 2024 15:27:07 +0800
Message-ID: <CACLfguWPpM1PNB6NP8r7ZUk9tk2b=CAJaCX3hRCaFCFNnoC3Pg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] vduse: Add file operation for mmap
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xieyongji@bytedance.com, linux-kernel@vger.kernel.org, 
	maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 2:08=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Wed, Feb 7, 2024 at 1:47=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add the operation for mmap, This function  will be used by the user spa=
ce
> > application to map the pages to the user space.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 57 ++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 2da659d5f4a8..083fe0047677 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1465,6 +1465,61 @@ static struct vduse_dev *vduse_dev_get_from_mino=
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
> > +       unsigned long vaddr;
> > +
> > +       /* index 1+vq_number page reserved for virtqueue state*/
>
> This comment seem wrong?
>
> THanks
>
sure,will fix this
thanks
cindy
>
> > +       vq =3D dev->vqs[index];
> > +       vaddr =3D vq->vdpa_reconnect_vaddr;
> > +       if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
> > +                           PFN_DOWN(virt_to_phys((void *)vaddr)), PAGE=
_SIZE,
> > +                           vma->vm_page_prot))
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
> > +       unsigned long vaddr =3D 0;
> > +       unsigned long index =3D vma->vm_pgoff;
> > +       struct vduse_virtqueue *vq;
> > +
> > +       if (vma->vm_end - vma->vm_start !=3D PAGE_SIZE)
> > +               return -EINVAL;
> > +       if ((vma->vm_flags & VM_SHARED) =3D=3D 0)
> > +               return -EINVAL;
> > +
> > +       if (index > dev->vq_num)
> > +               return -EINVAL;
> > +
> > +       vq =3D dev->vqs[index];
> > +       vaddr =3D vq->vdpa_reconnect_vaddr;
> > +       if (vaddr =3D=3D 0)
> > +               return -EOPNOTSUPP;
> > +
> > +       if (virt_to_phys((void *)vaddr) & (PAGE_SIZE - 1))
> > +               return -EINVAL;
> > +
> > +       /* Check if the Userspace App mapped the correct size */
> > +       if (vma->vm_end - vma->vm_start !=3D PAGE_SIZE)
> > +               return -EOPNOTSUPP;
> > +
> > +       vm_flags_set(vma, VM_DONTEXPAND);
> > +       vma->vm_ops =3D &vduse_vm_ops;
> > +
> > +       return 0;
> > +}
> > +
> >  static int vduse_dev_open(struct inode *inode, struct file *file)
> >  {
> >         int ret;
> > @@ -1497,6 +1552,8 @@ static const struct file_operations vduse_dev_fop=
s =3D {
> >         .unlocked_ioctl =3D vduse_dev_ioctl,
> >         .compat_ioctl   =3D compat_ptr_ioctl,
> >         .llseek         =3D noop_llseek,
> > +       .mmap           =3D vduse_dev_mmap,
> > +
> >  };
> >
> >  static ssize_t irq_cb_affinity_show(struct vduse_virtqueue *vq, char *=
buf)
> > --
> > 2.43.0
> >
>


