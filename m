Return-Path: <linux-kernel+bounces-136216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D2589D153
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33DAAB24BCA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F64155C36;
	Tue,  9 Apr 2024 03:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtCLh8Wq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE6548E9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712634797; cv=none; b=sFJcFyIzqvAeTZw4Ehc1vpsL8e96eHWb2zLONVEYIeEu16tlKHThwUbi1ErXiCzFxn0eH+ABlT08XTUgI7Xxsx3Ir1GyG7JbrRXySNPc0cDTJ9FE90YEPkPJ2sy7FYBsPtk4Z/a+U4AwTnOFfoLEdYQAvrcTVRh5cWiRSASTjGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712634797; c=relaxed/simple;
	bh=lxzSNvzrD+krJO3vw/t/cixNwL8tYRktEc4XuvGlHUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAKGRxmXxCRCtk++2m8SCOA3BrpHkZ7HDX1aUsKR7tSOoK5ydN7BbXJnajHNmZFUjwsyadRLgkZCJ8PiPy65cZE0EueA4+FmbEtwmvVuikFdd+CnAF5eCDXWEBe5Nxxcb8LF8J+pqSnZJYIRaheS8yLZbk/fRsnXEooxJX5Op+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtCLh8Wq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712634794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2KD7aI3KUIy6s54+Dn2xAAh6YXCvrhcr6E3iGFb/IXk=;
	b=YtCLh8Wqd91+7LobRz6fPmghm/fKRYuB5yRCeuUKrJ0gdW3ComvGMIc6niXQW83uzB1utE
	UXhMg7VZIuOUsdQvsaRN1fnD/V1uQ8UPlsHZuy5p1K9pzmzu5p9WYiLB1BtXlxtnSkMcgc
	xY8EgGE9MynNUW6OU+piQeHjiyH116k=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-0pqnSjFNPmKeIJ_U68YGlg-1; Mon, 08 Apr 2024 23:53:13 -0400
X-MC-Unique: 0pqnSjFNPmKeIJ_U68YGlg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5f034b4db5bso2693661a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 20:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712634792; x=1713239592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KD7aI3KUIy6s54+Dn2xAAh6YXCvrhcr6E3iGFb/IXk=;
        b=UF0ucODNa6uv98CUlznrRysh6vUIuRnW8vSavv346bDqs8ZjmhS/Ki5sbcU8zEEn5x
         okJ6OSVhpbIyZlUk5f6ydZZMh5bKtDl/HxLGp23cHLZVaqLfbMBaM0Zh1fkFDM0xZtFa
         ixGyU5NmoM+W2SkS43S7SHe3YkhJOk4SEn+l89aR/J4nypbCBZXiV2IvjHPfibWN+Rk3
         KayzMaJts0GRhmoZ4uTR5H5GSSTZRGLItJ33WbgvCDBMx/vB4nczLlHZ16AOi7hg6PDw
         AJD4Ng9AgFH4oiF1UpEIatrvb+CLTBFG37j6zrrGjwCekc8FbKWAj2bHkVaMI3U2yG3C
         dx8g==
X-Forwarded-Encrypted: i=1; AJvYcCXz3VCKjTL2dx7aiX5h07dC93B7IKax48yJL+IQjbSnjt4QkbD138t7r09n+ntnq591ZeDlgkRHkFOPZ+6tTZ5wuymt6XabmaVj3/WE
X-Gm-Message-State: AOJu0Yz7vD6ff1y9GcnEobJzYWwzngqwmAuGTsOO3UBWFnb6D2BBa8pw
	Kl+BAQS3T+6QYVnDUO4hkyKRJFMzExOZh3N+X4HTz/uBckQFBfv8wfnlzgyegdiLLDf7VPozL38
	7GiANrcuTkHE05T9UYd9kd53Q0Sr0N/pmS2BsiblBPGN0JtaY8G4Mg2zSYWcsM6vJS43ZaCAw1f
	vVc9gz9bF7adHlJs7fuVnrj0e0qn3C4NlkuYd8CT6WOWTusm+RXg==
X-Received: by 2002:a05:6a21:3391:b0:1a7:9812:3680 with SMTP id yy17-20020a056a21339100b001a798123680mr2441707pzb.40.1712634791937;
        Mon, 08 Apr 2024 20:53:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvsmXztrk7ncCJXSQ+W7uLtHwec4zNCzG/3012Rb3DaDvqvhgpT4f0P6PGoY4v5efkwwjDwdn/8sAvc4Tg7dM=
X-Received: by 2002:a05:6a21:3391:b0:1a7:9812:3680 with SMTP id
 yy17-20020a056a21339100b001a798123680mr2441690pzb.40.1712634791606; Mon, 08
 Apr 2024 20:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408035346-mutt-send-email-mst@kernel.org> <20240409014935.944-1-yuxue.liu@jaguarmicro.com>
In-Reply-To: <20240409014935.944-1-yuxue.liu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Apr 2024 11:53:00 +0800
Message-ID: <CACGkMEsvva4xWJpBLOzxmst=BzE7HRWuTpERVEt78oSGG_=5RQ@mail.gmail.com>
Subject: Re: [PATCH v3] vp_vdpa: fix the method of calculating vectors
To: lyx634449800 <yuxue.liu@jaguarmicro.com>
Cc: mst@redhat.com, angus.chen@jaguarmicro.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 9:49=E2=80=AFAM lyx634449800 <yuxue.liu@jaguarmicro.=
com> wrote:
>
> When there is a ctlq and it doesn't require interrupt
> callbacks,the original method of calculating vectors
> wastes hardware msi or msix resources as well as system
> IRQ resources.
>
> When conducting performance testing using testpmd in the
> guest os, it was found that the performance was lower compared
> to directly using vfio-pci to passthrough the device
>
> In scenarios where the virtio device in the guest os does
> not utilize interrupts, the vdpa driver still configures
> the hardware's msix vector. Therefore, the hardware still
> sends interrupts to the host os. Because of this unnecessary
> action by the hardware, hardware performance decreases, and
> it also affects the performance of the host os.
>
> Before modification:(interrupt mode)
>  32:  0   0  0  0 PCI-MSI 32768-edge    vp-vdpa[0000:00:02.0]-0
>  33:  0   0  0  0 PCI-MSI 32769-edge    vp-vdpa[0000:00:02.0]-1
>  34:  0   0  0  0 PCI-MSI 32770-edge    vp-vdpa[0000:00:02.0]-2
>  35:  0   0  0  0 PCI-MSI 32771-edge    vp-vdpa[0000:00:02.0]-config
>
> After modification:(interrupt mode)
>  32:  0  0  1  7   PCI-MSI 32768-edge  vp-vdpa[0000:00:02.0]-0
>  33: 36  0  3  0   PCI-MSI 32769-edge  vp-vdpa[0000:00:02.0]-1
>  34:  0  0  0  0   PCI-MSI 32770-edge  vp-vdpa[0000:00:02.0]-config
>
> Before modification:(virtio pmd mode for guest os)
>  32:  0   0  0  0 PCI-MSI 32768-edge    vp-vdpa[0000:00:02.0]-0
>  33:  0   0  0  0 PCI-MSI 32769-edge    vp-vdpa[0000:00:02.0]-1
>  34:  0   0  0  0 PCI-MSI 32770-edge    vp-vdpa[0000:00:02.0]-2
>  35:  0   0  0  0 PCI-MSI 32771-edge    vp-vdpa[0000:00:02.0]-config
>
> After modification:(virtio pmd mode for guest os)
>  32: 0  0  0   0   PCI-MSI 32768-edge   vp-vdpa[0000:00:02.0]-config
>
> To verify the use of the virtio PMD mode in the guest operating
> system, the following patch needs to be applied to QEMU:
> https://lore.kernel.org/all/20240408073311.2049-1-yuxue.liu@jaguarmicro.c=
om
>
> Signed-off-by: lyx634449800 <yuxue.liu@jaguarmicro.com>
> ---
>
> V3: delete unused variables and add validation records
> V2: fix when allocating IRQs, scan all queues
>
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 35 +++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/=
vp_vdpa.c
> index df5f4a3bccb5..cd3aeb3b8f21 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -160,22 +160,31 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_v=
dpa)
>         struct pci_dev *pdev =3D mdev->pci_dev;
>         int i, ret, irq;
>         int queues =3D vp_vdpa->queues;
> -       int vectors =3D queues + 1;
> +       int msix_vec, allocated_vectors =3D 0;
>
> -       ret =3D pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSI=
X);
> -       if (ret !=3D vectors) {
> +       for (i =3D 0; i < queues; i++) {
> +               if (vp_vdpa->vring[i].cb.callback)
> +                       allocated_vectors++;
> +       }
> +       allocated_vectors =3D allocated_vectors + 1;
> +
> +       ret =3D pci_alloc_irq_vectors(pdev, allocated_vectors, allocated_=
vectors,
> +                                                               PCI_IRQ_M=
SIX);
> +       if (ret !=3D allocated_vectors) {
>                 dev_err(&pdev->dev,
>                         "vp_vdpa: fail to allocate irq vectors want %d bu=
t %d\n",
> -                       vectors, ret);
> +                       allocated_vectors, ret);
>                 return ret;
>         }
> -
> -       vp_vdpa->vectors =3D vectors;
> +       vp_vdpa->vectors =3D allocated_vectors;
>
>         for (i =3D 0; i < queues; i++) {
> +               if (!vp_vdpa->vring[i].cb.callback)
> +                       continue;
> +
>                 snprintf(vp_vdpa->vring[i].msix_name, VP_VDPA_NAME_SIZE,
>                         "vp-vdpa[%s]-%d\n", pci_name(pdev), i);
> -               irq =3D pci_irq_vector(pdev, i);
> +               irq =3D pci_irq_vector(pdev, msix_vec);
>                 ret =3D devm_request_irq(&pdev->dev, irq,
>                                        vp_vdpa_vq_handler,
>                                        0, vp_vdpa->vring[i].msix_name,
> @@ -185,23 +194,23 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_v=
dpa)
>                                 "vp_vdpa: fail to request irq for vq %d\n=
", i);
>                         goto err;
>                 }
> -               vp_modern_queue_vector(mdev, i, i);
> +               vp_modern_queue_vector(mdev, i, msix_vec);
>                 vp_vdpa->vring[i].irq =3D irq;
> +               msix_vec++;
>         }
>
>         snprintf(vp_vdpa->msix_name, VP_VDPA_NAME_SIZE, "vp-vdpa[%s]-conf=
ig\n",
> -                pci_name(pdev));
> -       irq =3D pci_irq_vector(pdev, queues);
> +                       pci_name(pdev));
> +       irq =3D pci_irq_vector(pdev, msix_vec);
>         ret =3D devm_request_irq(&pdev->dev, irq, vp_vdpa_config_handler,=
 0,
>                                vp_vdpa->msix_name, vp_vdpa);
>         if (ret) {
>                 dev_err(&pdev->dev,
> -                       "vp_vdpa: fail to request irq for vq %d\n", i);
> +                       "vp_vdpa: fail to request irq for config\n");
>                         goto err;
>         }
> -       vp_modern_config_vector(mdev, queues);
> +       vp_modern_config_vector(mdev, msix_vec);
>         vp_vdpa->config_irq =3D irq;
> -

Unnecessary changes.

Others look good.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>         return 0;
>  err:
>         vp_vdpa_free_irq(vp_vdpa);
> --
> 2.43.0
>


