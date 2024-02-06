Return-Path: <linux-kernel+bounces-55577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EF484BE67
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F77B24B7E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9450C1B7FB;
	Tue,  6 Feb 2024 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8/nwTvK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BFB1AACF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707249996; cv=none; b=rmHxnnz8R8xn0mFY9Zb+bovNrmcgis4bDXHnIhDTBpYmApyMSCDfR5PZywZr1hPIb3FK4zMOBBNyuQiIexfvazhaDkKb/kwjgw2dI1S0FVge6USs8HtD1yzR0NDQTtLJK5gG7LQFxNCpkM9YpI6N5cixtmSZPFLLNM+KoIngIDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707249996; c=relaxed/simple;
	bh=PlwzN8x3eCddfNLwl0tQFZUsWaNW3CGdFeSD9FE45xU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MR65o67hf0JTwfyyEPrHrUO1+a2J0t6kugtALc5qzS3o5OYDZ5lITTH1tASu/InrQPZPO9e33X5xK4dHqiF22ZuRKDg2nOEDgAfbJwdT9AdiPUeVDKaPEok9evvHu0/dgxqcXhf1P6JEB1msDpREMgZkl8vyTihQ4fm5C4R6kt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8/nwTvK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707249993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/cd++jXszRXmfjXBwbNRqBwPxegiEkXzkrYtiCv0c8=;
	b=U8/nwTvKJsfMtqE9DdVM4mDRtMuivNQg2jfo2G/cHpK1RbI1COhuvw/RxuuqPFex5P6eFv
	vv/X9pdbysl+OBi18aXTPVEjjOjBcA97JyPUdiWTIVUzZRDwHWIk1qnVgW2IJWaDKCXBj4
	IKaota8H0uM5CBErSTBQ59JJ32ITGTc=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-81yFMApzN42ovSBljtKFkQ-1; Tue, 06 Feb 2024 15:06:31 -0500
X-MC-Unique: 81yFMApzN42ovSBljtKFkQ-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-59a8297ee8dso5517464eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 12:06:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707249991; x=1707854791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/cd++jXszRXmfjXBwbNRqBwPxegiEkXzkrYtiCv0c8=;
        b=u18ZA3QGYSVHQDHGWwICk8+rK5srX7ggrWH5ELRu+zJ3CR3A1EMa9ClIQOjCqAyv99
         lKCQK9abon3smWeYEqJ/IyPf7cJqLbfDQPsg+5mB/1n2pHCB7ISWN1cpjsLVDWM33Thv
         0tfoIJoDzgk0UXjq0QcwATMBXHrbtl5zCUXq7Cj+tHMbpVni4wybwcQlIoydQTr6SCLb
         OHJZmbB12kUtQfYQwPzf08PzDcTcYipZ0JrYLTzrInuGcOHnBm0LpfqBVDnhimQeKZUR
         i6WXEAIBoWWnmUw4QoDOdWhtXwzVF/6z40WV/s0ZqdEALBS6Zow1m+C0shcrofFo8bnz
         RMHA==
X-Gm-Message-State: AOJu0YzmmHD6B1Yf1QoS5TpXnCGWqHkdX4Gsj9zlcCGwDiXfRbV+h8iL
	9pVDhF/327E+YLYmcbIL16gmUSOZaPHLTOEX9W0bXywMvts2HZ/ZiZahw7Zmn5jLJ9DpzT54NW5
	792DCxBM6PtQc8oMtmx3E47BlkYvc+jb/DPt0cJIzTiKjEOQ2iAbpZppUN/mU5g==
X-Received: by 2002:a4a:8112:0:b0:59c:8b80:fe3e with SMTP id b18-20020a4a8112000000b0059c8b80fe3emr3080590oog.7.1707249991154;
        Tue, 06 Feb 2024 12:06:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJwnWL1LGz3lFyVKe1dlWAr2U11D5Zjkj6P8Frn4x+0vRY5zeaZeq+tu6iHoegpEk7pc/9Bg==
X-Received: by 2002:a4a:8112:0:b0:59c:8b80:fe3e with SMTP id b18-20020a4a8112000000b0059c8b80fe3emr3080568oog.7.1707249990851;
        Tue, 06 Feb 2024 12:06:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXTlxv9RzqLCQNh9HJ7dSEM6u9dfW+aPvwY4ta3GiTxq7u4+IR4p/bnaJcGc57IteapASuaQESeyIaa2RM2mFIzrI/znQlTiv6yqgA2ckgbIoRE98/kvZAK5X3Rt9+nXNOjaN4IzNMNTzulBSnALH/JACVxliCZLGNHU9vphCiIsWNRmKyFOFkv83DwTzOsxnD5JdtO8NnVAn5ThS61u6+jU2pzf0aFR3EP/pFLOCckE7lbI2CZdG69P13Byh78UP5WRUa4cze+bTeQXp436I+w7qHOdPcAN6TtjPZIVmvdtq9bl1DL6y0U/4pcUifCDS5AxdynY5yGWWC3zmt3Ex8NSyhauqfLa/BuEd38oeI=
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id h1-20020a4a6f01000000b0059a975f3b8esm433475ooc.33.2024.02.06.12.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 12:06:30 -0800 (PST)
Date: Tue, 6 Feb 2024 13:06:27 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Liu, Monk" <Monk.Liu@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, "Deng, Emily" <Emily.Deng@amd.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "Jiang, Jerry (SW)" <Jerry.Jiang@amd.com>, "Zhang,
 Andy" <Andy.Zhang@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>, "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>
Subject: Re: [PATCH 1/2] PCI: Add VF reset notification to PF's VFIO user
 mode driver
Message-ID: <20240206130627.5c10fec7.alex.williamson@redhat.com>
In-Reply-To: <BL1PR12MB526972B4E7CF6B2C993A2E6984462@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20240205071538.2665628-1-Emily.Deng@amd.com>
	<20240205090438.GB6294@unreal>
	<BL1PR12MB526972B4E7CF6B2C993A2E6984462@BL1PR12MB5269.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Feb 2024 04:08:18 +0000
"Liu, Monk" <Monk.Liu@amd.com> wrote:

> [AMD Official Use Only - General]
>=20
> Hi Leon
>=20
> The thing is when qemu reset a VM it calls vfio=E2=80=99s reset ioctl to =
the
> given VF device, and in kernel the VFIO-pci module will do the reset
> to that VF device via its PCI config space register, but
> unfortunately our VF GPU isnot designed to support those
> =E2=80=9Creset=E2=80=9D/=E2=80=9Dflr=E2=80=9D commands =E2=80=A6 not supp=
orted by the VF, (and even many PF
> cannot handle those commands well)

PFs are not required to implement FLR, VFs are.

SR-IOV spec, rev. 1.1:

	2.2.2. FLR That Targets a VF

	VFs must support Function Level Reset (FLR).

>=20
> So the idea we can cook up is to move those Vf=E2=80=99s reset notificati=
on
> to our PF driver (which is a user mode driver running on PF=E2=80=99s VFIO
> arch), and our user mode driver can program HW and do the reset for
> that VF.

The PF driver being able to arbitrarily reset a VF device provided to
another userspace process doesn't sound like separate, isolated
devices.  What else can the PF access?

As noted in my other reply, vf-tokens should not be normalized and
users of VFs provided by third party userspace PF drivers should
consider the device no less tainted than if it were provided by an
out-of-tree kernel driver.

The idea to virtualize FLR on the VF to resolve the hardware defect is a
good one, but it should be done in the context of a vfio-pci variant
driver.  Thanks,

Alex


> From: Leon Romanovsky <leon@kernel.org>
> Date: Monday, February 5, 2024 at 17:04
> To: Deng, Emily <Emily.Deng@amd.com>
> Cc: bhelgaas@google.com <bhelgaas@google.com>,
> alex.williamson@redhat.com <alex.williamson@redhat.com>,
> linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>,
> linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>,
> kvm@vger.kernel.org <kvm@vger.kernel.org>, Jiang, Jerry (SW)
> <Jerry.Jiang@amd.com>, Zhang, Andy <Andy.Zhang@amd.com>, Chang,
> HaiJun <HaiJun.Chang@amd.com>, Liu, Monk <Monk.Liu@amd.com>, Chen,
> Horace <Horace.Chen@amd.com>, Yin, ZhenGuo (Chris)
> <ZhenGuo.Yin@amd.com> Subject: Re: [PATCH 1/2] PCI: Add VF reset
> notification to PF's VFIO user mode driver On Mon, Feb 05, 2024 at
> 03:15:37PM +0800, Emily Deng wrote:
> > VF doesn't have the ability to reset itself completely which will
> > cause the hardware in unstable state. So notify PF driver when the
> > VF has been reset to let the PF resets the VF completely, and
> > remove the VF out of schedule. =20
>=20
>=20
> I'm sorry but this explanation is not different from the previous
> version. Please provide a better explanation of the problem, why it is
> needed, which VFs need and can't reset themselves, how and why it
> worked before e.t.c.
>=20
> In addition, please follow kernel submission guidelines, write
> changelong, add versions, cover letter e.t.c.
>=20
> Thanks
>=20
> >
> > How to implement this?
> > Add the reset callback function in pci_driver
> >
> > Implement the callback functin in VFIO_PCI driver.
> >
> > Add the VF RESET IRQ for user mode driver to let the user mode
> > driver know the VF has been reset.
> >
> > Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> > ---
> >  drivers/pci/pci.c   | 8 ++++++++
> >  include/linux/pci.h | 1 +
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 60230da957e0..aca937b05531 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4780,6 +4780,14 @@ EXPORT_SYMBOL_GPL(pcie_flr);
> >   */
> >  int pcie_reset_flr(struct pci_dev *dev, bool probe)
> >  {
> > +     struct pci_dev *pf_dev;
> > +
> > +     if (dev->is_virtfn) {
> > +             pf_dev =3D dev->physfn;
> > +             if (pf_dev->driver->sriov_vf_reset_notification)
> > +
> > pf_dev->driver->sriov_vf_reset_notification(pf_dev, dev);
> > +     }
> > +
> >        if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> >                return -ENOTTY;
> >
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index c69a2cc1f412..4fa31d9b0aa7 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -926,6 +926,7 @@ struct pci_driver {
> >        int  (*sriov_configure)(struct pci_dev *dev, int num_vfs);
> > /* On PF */ int  (*sriov_set_msix_vec_count)(struct pci_dev *vf,
> > int msix_vec_count); /* On PF */ u32
> > (*sriov_get_vf_total_msix)(struct pci_dev *pf);
> > +     void  (*sriov_vf_reset_notification)(struct pci_dev *pf,
> > struct pci_dev *vf); const struct pci_error_handlers *err_handler;
> >        const struct attribute_group **groups;
> >        const struct attribute_group **dev_groups;
> > --
> > 2.36.1
> >
> > =20


