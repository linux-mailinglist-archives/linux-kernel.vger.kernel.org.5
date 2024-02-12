Return-Path: <linux-kernel+bounces-62097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55358851B63
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A31A1C20B58
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659B93FB10;
	Mon, 12 Feb 2024 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZN/1ogg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C483F9E0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758846; cv=none; b=sd14puZOhSZ3aOXxLZ7w5KDNdX2D3UokDZgo8DJyTDxUVCWQaofxaf7bsqes05Azz7lSokxgxKLDJQmaGmh2u2cA5/ps0L6KDOaSvCNopie9ep3fHBdThE+ll37eQWTXj9vYxdagNepYKwmkdfWEvXDQBgU7tFXOFTaaOolKMcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758846; c=relaxed/simple;
	bh=wEdVhvQP/NUUeYlSu3pJTpXyuOMN+TEwhBkWhBXqEqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGie6ijtFtwTnm6Px4ZlTZXlg/oqylbtrP+8pBKBt4jySjlkNv+9slI+PESuigaeC97T7gj9plBMJklEzuZicWV8mv9y9XEiyzOCn6f0K5mQ5fBT0PHRjBVb8y2C/ZpoRdiGvhwgFoyEcEcF7wfsROL8UvuTdB+90ONBD1IIh1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZN/1ogg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707758843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPBeyL2QKeNnZrcFyNehWyHmkNTBExacfmNTQafQrSc=;
	b=PZN/1oggvS4H05nRWlKRPSJkNVc6byBHef7SkIHQ4VToyIEyTs6G3SRhoT1eRoWm3VYX9q
	QRmb9sKjE2cVKWFpzKtckSDJLz4g/sR1GipGvllRQLO9hPrqS+uCSVNAVp/EQcPV0lyEjA
	yUFhJb+IwmSayJDJAxdLvXpKdJa3wRw=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-69TO-R5FP_-Mu60SXbQhpA-1; Mon, 12 Feb 2024 12:27:22 -0500
X-MC-Unique: 69TO-R5FP_-Mu60SXbQhpA-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bf36117dfbso440817139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:27:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707758841; x=1708363641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPBeyL2QKeNnZrcFyNehWyHmkNTBExacfmNTQafQrSc=;
        b=u6mZyUIBO16ah/uBLVjsvnkl7pxXVg8JRhfURFZV3VUdFwKfjFWCyWvkOtW5pweDmJ
         Jpfb/w/my6o9L+4EL0bmVZ+HS4d6sieItAKo0nGeLSMoE9O6s1f3ZLrk4DA/EZ1J1BWP
         RPQmtbc/XDiX1VvRTud843qGaaLFy9D0qdIWHwg0tcJ78e9+JDhxOTVFfYyf4NbWGdUu
         ojF2AR0wPvfyKcPT4c09cMVsmrJGw9IUd7D7PjiTf88rgvgt1dYvPeAEsrbPsx3oP3Tt
         iZfnEX0nL3fM3XUuhpZXgJiCPmLGlhD1LnWhvpv704FOHjSIR40/+ZB7UACBmw7qLDRX
         fp+Q==
X-Gm-Message-State: AOJu0Yzhr2735Ds/JzWhb/4hVP5GpCy/dmxvwhV5JideAhoeeE8rxWCj
	o1MmoPB7f79Cf0ObIFMU43Hroo/keCkR6k/F51ZYECyLnm7KftezD+lJT6rRxWAz61CwQXFCQOw
	sPT+esUGt5gmte9I7GqSOUsH9fz9N8PsE6POAgNKIyDR8Vc+pVpqBdYBHKX62tQ==
X-Received: by 2002:a6b:5b12:0:b0:7c3:f849:dd5c with SMTP id v18-20020a6b5b12000000b007c3f849dd5cmr9697193ioh.8.1707758841346;
        Mon, 12 Feb 2024 09:27:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpYYcqJOkfeHRl4fhQijxO0vEvLM718vOT5KP64FP3TvMwqB68vh4X69PRRTLaI4f1WfmXrA==
X-Received: by 2002:a6b:5b12:0:b0:7c3:f849:dd5c with SMTP id v18-20020a6b5b12000000b007c3f849dd5cmr9697129ioh.8.1707758840805;
        Mon, 12 Feb 2024 09:27:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmnLq4zNu+kjrxiOGmAXK9/5LLfQ78OvG6YnIBwLiYCyCo1Xtkqr/9oMISGzxLYkr0A+ejIwpR/gbAoX+v/JyfQzYZXyQdxN1KsGTT4mC/KTlJXmznk+JNbroyEHl3vvbz8bRnGPJ4ogKMx0s39GnfptsncvTQ6Y7bEjnure1aN+xnnUmmzp0o+wGw3WceawgtQIgSnpTfRx0eAJmiW3nzAL6Oo2YbxvPPOeZkAGsZqdM2hYTjcmHrhLFwJO8nbUieENJcuxrpk1y5rNYnzVvCmuC5EA7bMrU0ycZE391uLlxdq7/1dRxWDyx2bfDLE3uqTjc79iGu2KBcJpK5bNjOVqPnj5FO2+9P6yjA3rZ8X4f7WrJ0WJX0dkPvbe94hCRXZSwPeFevevVDqq91foF+rAfWSvIdzmEnObrEbTmNeNeBLd/x9EJtKMZecoCFsZb6OSuHD1BPbC0In09PBJs94anGJ1pLN33zFG2BnLDKzqfn/Qx2w2Fkwwwpp0bAH6pnIKoq6013B1kV9uyH0d2whagym8f/H+yJXJlvLN9gmGy+65ettXWoK4qvl/+e04Mo9J5PIB3G3FnjoO/TA1pXU+deYz0+O58ZN/exYcOxqVAHfSIz8XPWMvpOVnnxUX1Vzts5rY+Uou76eAJLojZNNFGWvJPMBrpBgnwybhiwQGp1TMNyIq9kx/kJ9Q9xEtZzhAXyTzU7diAjY9WNFpwI4AE+hHDNYmudp4zGN4X9CPc3St/QyHcX3LOn/uRY/cUPe/pxTvORUCaqk4mN9F3sJS5R3dJo2cHpwY8/HGkE+69zrNErj7C9kFclGlAYbmQ9mpHPnWVfNcEqpCRNeYPwHWjBbzAk+Aok9jpVG+CzVoU/0AZVt22W0+4eiH4gN88QMDYORqdmtxiLCZVCV4/ExIppiR22wEHuQmHR4mWPvYiSwG407sN3vFVDbJ/xzyKbjj
 vzrtzJqY5EHLwJz8xxdMOrcVSsTelZOKzTX8o/c3skfY6DfLbu65OBjYJZ2c34OVqqm9E82mJVEMhnlGYxRHgYzW5YSf7M8bqus9Mqx1Rbj/qwz6yQbgszHivSRMKpP+8ld9oj781P7czCHOZCwhHWm6s5e1Xy+Y4b2MroNq5jtAdlPr/ITd7kWNQsJnwtCH5J/gJC+v16pdTh7vK6wSfpNgGaFPacJMXezN8gNEo6GMIMhWLGJKkfjxI2KuXsfFSS1qAe3EtbnOAqOJMRPLNDVUn7PopRoPZ+dJkq90VJwH1f/Ctv+rKZwt2V6btrA3iQgiwn
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id hl18-20020a0566020f1200b007c3f4c29570sm1591895iob.39.2024.02.12.09.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:27:19 -0800 (PST)
Date: Mon, 12 Feb 2024 10:27:18 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: ankita@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
 james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 reinette.chatre@intel.com, surenb@google.com, stefanha@redhat.com,
 brauner@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 mark.rutland@arm.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 ardb@kernel.org, akpm@linux-foundation.org, andreyknvl@gmail.com,
 wangjinchao@xfusion.com, gshan@redhat.com, shahuang@redhat.com,
 ricarkol@google.com, linux-mm@kvack.org, lpieralisi@kernel.org,
 rananta@google.com, ryan.roberts@arm.com, david@redhat.com,
 linus.walleij@linaro.org, bhe@redhat.com, aniketa@nvidia.com,
 cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
 jhubbard@nvidia.com, danw@nvidia.com, kvmarm@lists.linux.dev,
 mochs@nvidia.com, zhiw@nvidia.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 4/4] vfio: convey kvm that the vfio-pci device is wc
 safe
Message-ID: <20240212102718.07543659.alex.williamson@redhat.com>
In-Reply-To: <20240212172001.GE4048826@nvidia.com>
References: <20240211174705.31992-1-ankita@nvidia.com>
	<20240211174705.31992-5-ankita@nvidia.com>
	<20240212100502.2b5009e4.alex.williamson@redhat.com>
	<20240212172001.GE4048826@nvidia.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 13:20:01 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Feb 12, 2024 at 10:05:02AM -0700, Alex Williamson wrote:
> 
> > > --- a/drivers/vfio/pci/vfio_pci_core.c
> > > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > > @@ -1862,8 +1862,12 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
> > >  	/*
> > >  	 * See remap_pfn_range(), called from vfio_pci_fault() but we can't
> > >  	 * change vm_flags within the fault handler.  Set them now.
> > > +	 *
> > > +	 * Set an additional flag VM_ALLOW_ANY_UNCACHED to convey kvm that
> > > +	 * the device is wc safe.
> > >  	 */  
> > 
> > That's a pretty superficial comment.  Check that this is accurate, but
> > maybe something like:
> > 
> > 	The VM_ALLOW_ANY_UNCACHED flag is implemented for ARM64,
> > 	allowing stage 2 device mapping attributes to use Normal-NC  
>                ^^^^ 
> 
> > 	rather than DEVICE_nGnRE, which allows guest mappings
> > 	supporting combining attributes (WC).  This attribute has
> > 	potential risks with the GICv2 VCPU interface, but is expected
> > 	to be safe for vfio-pci use cases.  
> 
> Sure, if you want to elaborate more
> 
>   The VM_ALLOW_ANY_UNCACHED flag is implemented for ARM64,
>   allowing KVM stage 2 device mapping attributes to use Normal-NC
>   rather than DEVICE_nGnRE, which allows guest mappings
>   supporting combining attributes (WC). ARM does not architecturally
>   guarentee this is safe, and indeed some MMIO regions like the GICv2
>   VCPU interface can trigger uncontained faults if Normal-NC is used.
> 
>   Even worse we expect there are platforms where even DEVICE_nGnRE can
>   allow uncontained faults in conercases. Unfortunately existing ARM
                                ^^^^^^^^^^

*corner cases


>   IP requires platform integration to take responsibility to prevent
>   this.
> 
>   To safely use VFIO in KVM the platform must guarantee full safety
>   in the guest where no action taken against a MMIO mapping can
>   trigger an uncontainer failure. We belive that most VFIO PCI
>   platforms support this for both mapping types, at least in common
>   flows, based on some expectations of how PCI IP is integrated. This
>   can be enabled more broadly, for instance into vfio-platform
>   drivers, but only after the platform vendor completes auditing for
>   safety.

I like it, please incorporate into the next version.
  
> > And specifically, I think these other devices that may be problematic
> > as described in the cover letter is a warning against use for
> > vfio-platform, is that correct?  
> 
> Maybe more like "we have a general consensus that vfio-pci is likely
> safe due to how PCI IP is typically integrated, but it is much less
> obvious for other VFIO bus types. As there is no known WC user for
> vfio-platform drivers be conservative and do not enable it."

Ok.  Thanks for the clarification.

Alex


