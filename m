Return-Path: <linux-kernel+bounces-97350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCA2876945
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012341F24513
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B34725577;
	Fri,  8 Mar 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhQvD5mZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BED33CC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709917408; cv=none; b=VxHopbWb53JuvEEPYLf+O0L0Ptjr+s0DX13HE0rvN/7eYztX+FMQ1+gC8CDGW8gwGkj0aKpHSk97S3UPnTXQTVBg2xZwlKU8Sje5Vbtmg07mq1aN0v/a9/CjJnz4CrTa5NP8yKhdmWshroPUrXh+6kpgesPnAiSWs041fVgxbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709917408; c=relaxed/simple;
	bh=9o4nZMfiF5m3PN48FoxnPM8zda5E9vwoK8CgRygIp9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWhFUlpF/i+rDOTpw6ONPKwwqGDJlWKvnscqt/tKjrnKxmxSEvcoCq/8H2yWwVm0yJ/Nbg9PffM0UEgr89J7EmSQEnBLSLOAKfN0Dib/IbsNIyYShPydkKEhRE+QdJdBprqhlqspquTZ6sf1z2C/015GwADiNvZ/zVqw7CAfNpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhQvD5mZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709917406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0t8lZDXK/Q+Ew6d4a5Ak8Cmmg3FTPVKzcfM3TVR9H9g=;
	b=NhQvD5mZtt1i+29Rjhyg79nGPxVRthYC6r+66ZN+cUT+h9nVvjCrbdr5BGfTMA8GKv8zG+
	k2e/kDgvE9qZOJL5QcrujGqqT4XMCHQrr3g1wAPtVgvx3IoZH76BHlotclUnm7DfxEh++v
	pqhto2mbsHiJ4mDEJ4fvEFkxIreajEQ=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-wcQS-Ij_PZuUgb1YLUciwg-1; Fri, 08 Mar 2024 12:03:22 -0500
X-MC-Unique: wcQS-Ij_PZuUgb1YLUciwg-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c835b36ee2so103654039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 09:03:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709917402; x=1710522202;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0t8lZDXK/Q+Ew6d4a5Ak8Cmmg3FTPVKzcfM3TVR9H9g=;
        b=wWHN5ILcDitA68tcm5pGpZ1lf0NKg7Z+YfdJ1bqfFDhUjeSaOsjFNjNedflwDMpcXa
         QiV82jQTxljv8MHlAcddEKT9RflYDpchWZmuvIWFBnJ3wWAwDV9ZRrGvHxjVvd5bWPTn
         ycniHLh4Syv+LSfqd0NoZbe4WZsFrIY1/W5XIZ/hBM+KthrJOF6izXcZq1MaUNhtBoD6
         APpnWpmKs3fG4F67C/6tH5ZCH1UCkI2G3+ISxTSC+YtKmnZLhhvF/ibu3r9JVvKATogP
         tk9MFYj4fJIxG630hLo8mGw79Rb0UlTVYlocNHjcyh+HDqtaxdsNACSwZdtBM0PPLFmJ
         GnHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb/CCxZjWOk7KKTTqE3p/4soLubyQGBBdb8ou50lpioOTLYwXgXnQpA9Hbmf/IlYqIi3pzo+YR43crb9EZxEF7Rv3rPWrhPPjeLBGU
X-Gm-Message-State: AOJu0Yzyt11zN3uauEJZMJ8grFQ8/A2WYVBGGVupUqFQzYwS4mwPqTfn
	Pbw9j/G/ieJ301qm5NgBLPVYgyr7tkhSP6CpLkt1CtSBXxfp9w8AMrHDWtOQF559Rtt/ccVTlnl
	hkGDXOjPUKuJy/40Gj4qV7rzt+zQYuRp5/1dtTFEsvsvCTl7pzjL4xW4dW/9f+A==
X-Received: by 2002:a05:6e02:218c:b0:365:4b91:7cf9 with SMTP id j12-20020a056e02218c00b003654b917cf9mr27359745ila.26.1709917402019;
        Fri, 08 Mar 2024 09:03:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJAjtnPLKpEVq7+6yKBXjDWb/D3zaCEqh9nOflsX7LqSElSm/ct2ufYbJRUyjZbrxlyuV7Dg==
X-Received: by 2002:a05:6e02:218c:b0:365:4b91:7cf9 with SMTP id j12-20020a056e02218c00b003654b917cf9mr27359721ila.26.1709917401783;
        Fri, 08 Mar 2024 09:03:21 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id f22-20020a056638023600b00474506c900esm4525713jaq.145.2024.03.08.09.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:03:21 -0800 (PST)
Date: Fri, 8 Mar 2024 10:03:18 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "clg@redhat.com" <clg@redhat.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] vfio/pci: Disable auto-enable of exclusive INTx IRQ
Message-ID: <20240308100318.0794f51a.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5276DBB5FBC36939EB39A3CA8C272@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240306211445.1856768-1-alex.williamson@redhat.com>
	<20240306211445.1856768-2-alex.williamson@redhat.com>
	<BL1PR11MB527189373E8756AA8697E8D78C202@BL1PR11MB5271.namprd11.prod.outlook.com>
	<20240307132348.5dbc57dc.alex.williamson@redhat.com>
	<BN9PR11MB5276DBB5FBC36939EB39A3CA8C272@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Mar 2024 07:23:21 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Friday, March 8, 2024 4:24 AM
> >=20
> > On Thu, 7 Mar 2024 08:39:16 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >  =20
> > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > Sent: Thursday, March 7, 2024 5:15 AM
> > > >
> > > > Currently for devices requiring masking at the irqchip for INTx, ie.
> > > > devices without DisINTx support, the IRQ is enabled in request_irq()
> > > > and subsequently disabled as necessary to align with the masked sta=
tus
> > > > flag.  This presents a window where the interrupt could fire between
> > > > these events, resulting in the IRQ incrementing the disable depth t=
wice.
> > > > This would be unrecoverable for a user since the masked flag preven=
ts
> > > > nested enables through vfio.
> > > >
> > > > Instead, invert the logic using IRQF_NO_AUTOEN such that exclusive =
INTx
> > > > is never auto-enabled, then unmask as required.
> > > >
> > > > Fixes: 89e1f7d4c66d ("vfio: Add PCI device driver")
> > > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com> =20
> > >
> > > CC stable? =20
> >=20
> > I've always found that having a Fixes: tag is sufficient to get picked
> > up for stable, so I typically don't do both.  If it helps out someone's
> > process I'd be happy to though.  Thanks,
> >  =20
>=20
> According to "Documentation/process/submitting-patches.rst":
>=20
>   Note: Attaching a Fixes: tag does not subvert the stable kernel rules
>   process nor the requirement to Cc: stable@vger.kernel.org on all stable
>   patch candidates. For more information, please read
>   Documentation/process/stable-kernel-rules.rst.
>=20
> Probably it's fine as long as the stable kernel maintainers don't complai=
n. =F0=9F=98=8A

I think the stable maintainers are far more aggressive than the
documentation would suggest, but it doesn't hurt to include the Cc,
I'll add it next version.  Thanks,

Alex


