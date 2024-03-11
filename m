Return-Path: <linux-kernel+bounces-98979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BD58781D3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D771F22A91
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6302C4087D;
	Mon, 11 Mar 2024 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCrSOVK0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2ED3FBAD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168048; cv=none; b=hudTJSh9WB57Wit/HyLnXcPHFOVuk9L4yUWJe0zCym/mkuZk37bQ4ASCWUsuWcesh9m57fjZXNQjZNq8oP8zfUroNXRtV/4DT1XkJr6DbXmDwgx3ZQLz/GOk+WHNqYFuXQ3v2D4CYQmh5+Ac8GA7cQBGmGdq+ChVA7gZtg71cLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168048; c=relaxed/simple;
	bh=Wn3xO+rDkvy90KSBOdwgvLS73TNoU6ZFfpMBDk7zRfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujPQA1w/A0NTFsX/uIbgYTGFEpIvuNIAOKQ0VllRjbiflcku+RJVu3n+uRdvEdO/gFnONXiITbjCKh0m5uegen+5LVtg9n0oTN7tZQTLv/INbhiqYmyji/AXFMMPFicE7A1ZpzgSrTM3aTADes/M5Uzj6AzuuPHTvZzyH4/v1nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCrSOVK0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710168045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqitDpmr1fCRHRdWH7mB5wNlPTd1FwNOj8yeieg8etw=;
	b=XCrSOVK0ZK+y1PlA9cuXUsMV8c5GIG+5GIU6iI/ZrjfNmeu58aY1C5vCpWJJ9AAoSCD1xQ
	2aPmcZIwQ/qmVGoHdYhNp+N1P7KHNjQbcfMVonMNZJhTYVLKYcutWDpDTKSwXBdnpvgWkw
	i3HtnzrP/t9NSPHG/SoOXyDmiKKKUtI=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-W9bVEozqPqKb37AFH0mcyg-1; Mon, 11 Mar 2024 10:40:43 -0400
X-MC-Unique: W9bVEozqPqKb37AFH0mcyg-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-366586f2796so9090835ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 07:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710168042; x=1710772842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqitDpmr1fCRHRdWH7mB5wNlPTd1FwNOj8yeieg8etw=;
        b=ZAmp+X9r5U0ifeTEznVtuYodhjZRAxYjIHXbgOUPR4ECIy5z9ZkqtkZsfN3f0TN38q
         p1x+TUPu3hOmJifndKM1Qu/o6+pvMy2xqEr+DK7txVsvqDkOcpGL75nLfyCFQOyI8YrC
         /VTmmX5zyjQtbvB/WQiqJrAN1vPDbjIVy4PIwSKweBM4XWkrEcTbiw/0rRGuc5pSWjy+
         UZ0rSOr5PvIk/TEucA9AD+7eAyknfU3erS8q/ERUPx5PXOzAlPjioXM2E3AlaXlukEKi
         JD0XaMdY5RC9+R0WtFF4gDLXs4mguqUc9BL9Q+gBUAAPHFZqs75vMBVLnqQTz3OZmIi5
         7lOw==
X-Forwarded-Encrypted: i=1; AJvYcCUBa/CwMZvlkeMe21nlJqPN1NcIv6eErhw39c9RYRSpEzIqK26wuYioLrtE3d9Nyk1bsv7Ya3zJYdH691exOQDeF9+BL9BtUWg/LMCU
X-Gm-Message-State: AOJu0YzDU8d83l3Fykr88Mit2wvtKHX4KmUC/mo5x1x9mJcVpXfQSVNK
	qRLbhjx6U+kjp9rkwKwGK2WnHXAJ/E+M71YHnZoDbDJrIvizLbFrI8Ml7NDpAyUIFf/7A7ekKAI
	9aCjNiGFZnfQT/ASHqRAy6EQ+rMTVOzFudsQ0ztbxzZau+EdZ/V9D6dyoSyQPZA==
X-Received: by 2002:a05:6e02:214c:b0:365:3a69:1e1a with SMTP id d12-20020a056e02214c00b003653a691e1amr9463902ilv.0.1710168042502;
        Mon, 11 Mar 2024 07:40:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzn/KqxHnMWSFyQHXvkIcmDWG5JedPe1AmAWvtpZ4KFi0ZaJEX8WsuA3+z/GqEHZRvadyzQw==
X-Received: by 2002:a05:6e02:214c:b0:365:3a69:1e1a with SMTP id d12-20020a056e02214c00b003653a691e1amr9463877ilv.0.1710168042198;
        Mon, 11 Mar 2024 07:40:42 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id t1-20020a92c0c1000000b003662f9bfd51sm1741908ilf.12.2024.03.11.07.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 07:40:41 -0700 (PDT)
Date: Mon, 11 Mar 2024 08:40:40 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: kvm@vger.kernel.org, clg@redhat.com, reinette.chatre@intel.com,
 linux-kernel@vger.kernel.org, kevin.tian@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] vfio/pci: Disable auto-enable of exclusive INTx
 IRQ
Message-ID: <20240311084040.5b2aaada.alex.williamson@redhat.com>
In-Reply-To: <d57f0df4-b155-4805-9121-53a9a1c23cee@redhat.com>
References: <20240308230557.805580-1-alex.williamson@redhat.com>
	<20240308230557.805580-2-alex.williamson@redhat.com>
	<d57f0df4-b155-4805-9121-53a9a1c23cee@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Mar 2024 08:36:07 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> Hi Alex,
>=20
> On 3/9/24 00:05, Alex Williamson wrote:
> > Currently for devices requiring masking at the irqchip for INTx, ie.
> > devices without DisINTx support, the IRQ is enabled in request_irq()
> > and subsequently disabled as necessary to align with the masked status
> > flag.  This presents a window where the interrupt could fire between
> > these events, resulting in the IRQ incrementing the disable depth twice.
> > This would be unrecoverable for a user since the masked flag prevents
> > nested enables through vfio.
> >
> > Instead, invert the logic using IRQF_NO_AUTOEN such that exclusive INTx
> > is never auto-enabled, then unmask as required.
> > Cc: stable@vger.kernel.org
> > Fixes: 89e1f7d4c66d ("vfio: Add PCI device driver")
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_intrs.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_=
pci_intrs.c
> > index 237beac83809..136101179fcb 100644
> > --- a/drivers/vfio/pci/vfio_pci_intrs.c
> > +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> > @@ -296,8 +296,15 @@ static int vfio_intx_set_signal(struct vfio_pci_co=
re_device *vdev, int fd)
> > =20
> >  	ctx->trigger =3D trigger;
> > =20
> > +	/*
> > +	 * Devices without DisINTx support require an exclusive interrupt,
> > +	 * IRQ masking is performed at the IRQ chip.  The masked status is
> > +	 * protected by vdev->irqlock. Setup the IRQ without auto-enable and
> > +	 * unmask as necessary below under lock.  DisINTx is unmodified by
> > +	 * the IRQ configuration and may therefore use auto-enable. =20
> If I remember correctly the main reason why the
>=20
> vdev->pci_2_3 path is left unchanged is due to the fact the irq may not b=
e exclusive
> and setting IRQF_NO_AUTOEN could be wrong in that case. May be worth to
> precise in the commit msg or here? Besides Reviewed-by: Eric Auger
> <eric.auger@redhat.com> Eric =C2=A0=C2=A0

IRQF_SHARED and IRQF_NO_AUTOEN are in fact mutually exclusive.  Even if
we could disable auto-enable, the driver sharing the interrupt could
independently enable it.  But really the basis for using IRQF_SHARED is
that we have device level INTx detection and masking.  The comment here
is only to note that request_irq() doesn't gratuitously clear DisINTx,
so the mask state previously applied through config space of the device
is persistent.  Thanks,

Alex
=20
> > +	 */
> >  	if (!vdev->pci_2_3)
> > -		irqflags =3D 0;
> > +		irqflags =3D IRQF_NO_AUTOEN;
> > =20
> >  	ret =3D request_irq(pdev->irq, vfio_intx_handler,
> >  			  irqflags, ctx->name, vdev);
> > @@ -308,13 +315,9 @@ static int vfio_intx_set_signal(struct vfio_pci_co=
re_device *vdev, int fd)
> >  		return ret;
> >  	}
> > =20
> > -	/*
> > -	 * INTx disable will stick across the new irq setup,
> > -	 * disable_irq won't.
> > -	 */
> >  	spin_lock_irqsave(&vdev->irqlock, flags);
> > -	if (!vdev->pci_2_3 && ctx->masked)
> > -		disable_irq_nosync(pdev->irq);
> > +	if (!vdev->pci_2_3 && !ctx->masked)
> > +		enable_irq(pdev->irq);
> >  	spin_unlock_irqrestore(&vdev->irqlock, flags);
> > =20
> >  	return 0; =20
>=20


