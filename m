Return-Path: <linux-kernel+bounces-159313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB228B2CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417B61C2188D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5C4155A5B;
	Thu, 25 Apr 2024 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jzkz4lYO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35781155A4F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082999; cv=none; b=WQauRuD17rtcgLB6vpx6WSQw9Jz1BQjJPdfO64CMxk61yxfWjJDlCYa8Ud8iymbcTIrX5d4D3GYuZ49xScWKIhOheGbkfFEcgQPrBiyKdCis+vw67r9Fk1qMPt9Kb0cmw0riZ0LM0FcQJ7NTbqc5YSi0D/10rjLbhoIJy95aR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082999; c=relaxed/simple;
	bh=s6dvv+wZO+gtD7SAPcutRGVa3yA5bdoa6wKt9PgHyok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfDu+ZrgZriuwGFzrKo3s3NHK9zVTTb9V3bRPa46RIrhZcupl8nKQSZy9vW5MtUqgZeh6YfI3QPgznQxxYARuh9RusbVSpcqvlJ70CQIibVycFvLyc8+5Td887HCeKtvUGJkd08CFP/qUit43/Z7Lt4KfVIkhDChcQp1gzjppyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jzkz4lYO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714082996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KSx9kDEzNAz8Jj0BPkb9tkkGWv5xnSIMDUuY70cD3Y=;
	b=Jzkz4lYOhsmOFK0Flky2+UlU4sS60OUSdWc+4UE6lURy073KkWvFBSiIjRvpv5vAByb42c
	+bJvZZJBEcYW2eUHsgdtpb3UfACHbFfL2+GN27xAdUIweuA3v2GHc/udPx1F8va6RxooV6
	9JSd621qmN6KQYhVRmjJADBSww1+Kwg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-Ntxt8shtNUaplnX_msp12w-1; Thu, 25 Apr 2024 18:09:54 -0400
X-MC-Unique: Ntxt8shtNUaplnX_msp12w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4167351545cso10117875e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082993; x=1714687793;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4KSx9kDEzNAz8Jj0BPkb9tkkGWv5xnSIMDUuY70cD3Y=;
        b=MBamtj4hnYQcAlbr0rUQCzfUJxEg4V6ioFcUfuEUeTK5e7xqasWUSNWY18q73JgFi6
         PErEQwnKfnR4NWj3VpwoOxef12EaHPBPxTaoB7Kit+8ap7ZkoS27S28zzPa27+VwOHNI
         tGPnyEgzEtprBol+uyU1d7E+YPvDE2NnU8+h31zwNSA06KzPWqTB114nufKIKzx4FWt8
         LeS1oXYbfzqAGNZLNwS7UoNvJRsHkzIOCKHHyr2BSz6rYBuyiXBOog5Vl66sUp3gHriC
         mSmym9ATqjgwjRogUCTGA4tQuMNWRKbSbelfaRabOm7056mi6b7zdOO97JCSLSh/hcjn
         AluQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeLmGZYJS3xk9HFjZYGEXNp7BSE0kNyUnBMIWZ9NEX3VoWG/kbHDt+tsrtVDelg1xzD8bNajclMtvHXipwiLDCOFgNNADLuBPVA5fE
X-Gm-Message-State: AOJu0YwMVDCcaxTHf34ez3KsU0QEG5vLmSx9DtsLJdu3/k4gJ8veYv1s
	+9RmG2jlYzI51TjMrVjpMQraQRZv8BjEv6T4TSu2zUzy5iDryx7DOutTqZBozVht2rJleZyMyPH
	zn87L1pP7r/Piyr9dTX3rg7lQXhOsmL97ieuJBX6oVYiVpwh9y4v8qh45VSKC6Q==
X-Received: by 2002:a05:600c:34ce:b0:417:f993:c614 with SMTP id d14-20020a05600c34ce00b00417f993c614mr683081wmq.22.1714082993466;
        Thu, 25 Apr 2024 15:09:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEau0iWvwN02hFGlCCga/0pnPpseToD1MCrYM7ZP9oxas3QaR+fyvLX6Gpl3uihNGGHmpl/Lw==
X-Received: by 2002:a05:600c:34ce:b0:417:f993:c614 with SMTP id d14-20020a05600c34ce00b00417f993c614mr683068wmq.22.1714082993028;
        Thu, 25 Apr 2024 15:09:53 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:ffa:7b40:24cf:6484:4af6])
        by smtp.gmail.com with ESMTPSA id je1-20020a05600c1f8100b0041adf358058sm8938820wmb.27.2024.04.25.15.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:09:52 -0700 (PDT)
Date: Thu, 25 Apr 2024 18:09:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Cc: Gavin Liu <gavin.liu@jaguarmicro.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH v5] vp_vdpa: don't
 allocate unused msix vectors
Message-ID: <20240423053232-mutt-send-email-mst@kernel.org>
References: <ffab38f0-2ec6-4ed2-b0f8-398f2829b71d@linux.alibaba.com>
 <20240410033020.1310-1-yuxue.liu@jaguarmicro.com>
 <20240422080729-mutt-send-email-mst@kernel.org>
 <SEYPR06MB6756E87AE40D93704A0614A9EC112@SEYPR06MB6756.apcprd06.prod.outlook.com>
 <20240423043424-mutt-send-email-mst@kernel.org>
 <TY0PR06MB49841D4FD3D85C6C18C3186985112@TY0PR06MB4984.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY0PR06MB49841D4FD3D85C6C18C3186985112@TY0PR06MB4984.apcprd06.prod.outlook.com>

On Tue, Apr 23, 2024 at 08:42:57AM +0000, Angus Chen wrote:
> Hi mst.
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, April 23, 2024 4:35 PM
> > To: Gavin Liu <gavin.liu@jaguarmicro.com>
> > Cc: jasowang@redhat.com; Angus Chen <angus.chen@jaguarmicro.com>;
> > virtualization@lists.linux.dev; xuanzhuo@linux.alibaba.com;
> > linux-kernel@vger.kernel.org; Heng Qi <hengqi@linux.alibaba.com>
> > Subject: Re: 回复: [PATCH v5] vp_vdpa: don't allocate unused msix vectors
> > 
> > On Tue, Apr 23, 2024 at 01:39:17AM +0000, Gavin Liu wrote:
> > > On Wed, Apr 10, 2024 at 11:30:20AM +0800, lyx634449800 wrote:
> > > > From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> > > >
> > > > When there is a ctlq and it doesn't require interrupt callbacks,the
> > > > original method of calculating vectors wastes hardware msi or msix
> > > > resources as well as system IRQ resources.
> > > >
> > > > When conducting performance testing using testpmd in the guest os, it
> > > > was found that the performance was lower compared to directly using
> > > > vfio-pci to passthrough the device
> > > >
> > > > In scenarios where the virtio device in the guest os does not utilize
> > > > interrupts, the vdpa driver still configures the hardware's msix
> > > > vector. Therefore, the hardware still sends interrupts to the host os.
> > >
> > > >I just have a question on this part. How come hardware sends interrupts does
> > not guest driver disable them?
> > >
> > >    1：Assuming the guest OS's Virtio device is using PMD mode, QEMU sets
> > the call fd to -1
> > >    2：On the host side, the vhost_vdpa program will set
> > vp_vdpa->vring[i].cb.callback to invalid
> > >    3：Before the modification, the vp_vdpa_request_irq function does not
> > check whether
> > >       vp_vdpa->vring[i].cb.callback is valid. Instead, it enables the
> > hardware's MSIX
> > > 	  interrupts based on the number of queues of the device
> > >
> > 
> > So MSIX is enabled but why would it trigger? virtio PMD in poll mode
> > presumably suppresses interrupts after all.
> Virtio pmd is in the guest,but in host side,the msix is enabled,then the device will triger 
> Interrupt normally. I analysed this bug before,and I think gavin is right.
> Did I make it clear?

Not really. Guest disables interrupts presumably (it's polling)
why does device still send them?


> > 
> > >
> > >
> > > ----- Original Message -----
> > > From: Michael S. Tsirkin mst@redhat.com
> > > Sent: April 22, 2024 20:09
> > > To: Gavin Liu gavin.liu@jaguarmicro.com
> > > Cc: jasowang@redhat.com; Angus Chen angus.chen@jaguarmicro.com;
> > virtualization@lists.linux.dev; xuanzhuo@linux.alibaba.com;
> > linux-kernel@vger.kernel.org; Heng Qi hengqi@linux.alibaba.com
> > > Subject: Re: [PATCH v5] vp_vdpa: don't allocate unused msix vectors
> > >
> > >
> > >
> > > External Mail: This email originated from OUTSIDE of the organization!
> > > Do not click links, open attachments or provide ANY information unless you
> > recognize the sender and know the content is safe.
> > >
> > >
> > > On Wed, Apr 10, 2024 at 11:30:20AM +0800, lyx634449800 wrote:
> > > > From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> > > >
> > > > When there is a ctlq and it doesn't require interrupt callbacks,the
> > > > original method of calculating vectors wastes hardware msi or msix
> > > > resources as well as system IRQ resources.
> > > >
> > > > When conducting performance testing using testpmd in the guest os, it
> > > > was found that the performance was lower compared to directly using
> > > > vfio-pci to passthrough the device
> > > >
> > > > In scenarios where the virtio device in the guest os does not utilize
> > > > interrupts, the vdpa driver still configures the hardware's msix
> > > > vector. Therefore, the hardware still sends interrupts to the host os.
> > >
> > > I just have a question on this part. How come hardware sends interrupts does
> > not guest driver disable them?
> > >
> > > > Because of this unnecessary
> > > > action by the hardware, hardware performance decreases, and it also
> > > > affects the performance of the host os.
> > > >
> > > > Before modification:(interrupt mode)
> > > >  32:  0   0  0  0 PCI-MSI 32768-edge    vp-vdpa[0000:00:02.0]-0
> > > >  33:  0   0  0  0 PCI-MSI 32769-edge    vp-vdpa[0000:00:02.0]-1
> > > >  34:  0   0  0  0 PCI-MSI 32770-edge    vp-vdpa[0000:00:02.0]-2
> > > >  35:  0   0  0  0 PCI-MSI 32771-edge    vp-vdpa[0000:00:02.0]-config
> > > >
> > > > After modification:(interrupt mode)
> > > >  32:  0  0  1  7   PCI-MSI 32768-edge  vp-vdpa[0000:00:02.0]-0
> > > >  33: 36  0  3  0   PCI-MSI 32769-edge  vp-vdpa[0000:00:02.0]-1
> > > >  34:  0  0  0  0   PCI-MSI 32770-edge  vp-vdpa[0000:00:02.0]-config
> > > >
> > > > Before modification:(virtio pmd mode for guest os)
> > > >  32:  0   0  0  0 PCI-MSI 32768-edge    vp-vdpa[0000:00:02.0]-0
> > > >  33:  0   0  0  0 PCI-MSI 32769-edge    vp-vdpa[0000:00:02.0]-1
> > > >  34:  0   0  0  0 PCI-MSI 32770-edge    vp-vdpa[0000:00:02.0]-2
> > > >  35:  0   0  0  0 PCI-MSI 32771-edge    vp-vdpa[0000:00:02.0]-config
> > > >
> > > > After modification:(virtio pmd mode for guest os)
> > > >  32: 0  0  0   0   PCI-MSI 32768-edge   vp-vdpa[0000:00:02.0]-config
> > > >
> > > > To verify the use of the virtio PMD mode in the guest operating
> > > > system, the following patch needs to be applied to QEMU:
> > > > https://lore.kernel.org/all/20240408073311.2049-1-yuxue.liu@jaguarmicr
> > > > o.com
> > > >
> > > > Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > ---
> > > > V5: modify the description of the printout when an exception occurs
> > > > V4: update the title and assign values to uninitialized variables
> > > > V3: delete unused variables and add validation records
> > > > V2: fix when allocating IRQs, scan all queues
> > > >
> > > >  drivers/vdpa/virtio_pci/vp_vdpa.c | 22 ++++++++++++++++------
> > > >  1 file changed, 16 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > > b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > > index df5f4a3bccb5..8de0224e9ec2 100644
> > > > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > > @@ -160,7 +160,13 @@ static int vp_vdpa_request_irq(struct vp_vdpa
> > *vp_vdpa)
> > > >       struct pci_dev *pdev = mdev->pci_dev;
> > > >       int i, ret, irq;
> > > >       int queues = vp_vdpa->queues;
> > > > -     int vectors = queues + 1;
> > > > +     int vectors = 1;
> > > > +     int msix_vec = 0;
> > > > +
> > > > +     for (i = 0; i < queues; i++) {
> > > > +             if (vp_vdpa->vring[i].cb.callback)
> > > > +                     vectors++;
> > > > +     }
> > > >
> > > >       ret = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
> > > >       if (ret != vectors) {
> > > > @@ -173,9 +179,12 @@ static int vp_vdpa_request_irq(struct vp_vdpa
> > *vp_vdpa)
> > > >       vp_vdpa->vectors = vectors;
> > > >
> > > >       for (i = 0; i < queues; i++) {
> > > > +             if (!vp_vdpa->vring[i].cb.callback)
> > > > +                     continue;
> > > > +
> > > >               snprintf(vp_vdpa->vring[i].msix_name,
> > VP_VDPA_NAME_SIZE,
> > > >                       "vp-vdpa[%s]-%d\n", pci_name(pdev), i);
> > > > -             irq = pci_irq_vector(pdev, i);
> > > > +             irq = pci_irq_vector(pdev, msix_vec);
> > > >               ret = devm_request_irq(&pdev->dev, irq,
> > > >                                      vp_vdpa_vq_handler,
> > > >                                      0,
> > vp_vdpa->vring[i].msix_name,
> > > > @@ -185,21 +194,22 @@ static int vp_vdpa_request_irq(struct vp_vdpa
> > *vp_vdpa)
> > > >                               "vp_vdpa: fail to request irq for
> > vq %d\n", i);
> > > >                       goto err;
> > > >               }
> > > > -             vp_modern_queue_vector(mdev, i, i);
> > > > +             vp_modern_queue_vector(mdev, i, msix_vec);
> > > >               vp_vdpa->vring[i].irq = irq;
> > > > +             msix_vec++;
> > > >       }
> > > >
> > > >       snprintf(vp_vdpa->msix_name, VP_VDPA_NAME_SIZE,
> > "vp-vdpa[%s]-config\n",
> > > >                pci_name(pdev));
> > > > -     irq = pci_irq_vector(pdev, queues);
> > > > +     irq = pci_irq_vector(pdev, msix_vec);
> > > >       ret = devm_request_irq(&pdev->dev, irq, vp_vdpa_config_handler,
> > 0,
> > > >                              vp_vdpa->msix_name, vp_vdpa);
> > > >       if (ret) {
> > > >               dev_err(&pdev->dev,
> > > > -                     "vp_vdpa: fail to request irq for vq %d\n", i);
> > > > +                     "vp_vdpa: fail to request irq for config: %d\n",
> > > > + ret);
> > > >                       goto err;
> > > >       }
> > > > -     vp_modern_config_vector(mdev, queues);
> > > > +     vp_modern_config_vector(mdev, msix_vec);
> > > >       vp_vdpa->config_irq = irq;
> > > >
> > > >       return 0;
> > > > --
> > > > 2.43.0
> > >
> 


