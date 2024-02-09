Return-Path: <linux-kernel+bounces-59563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9796484F8F6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F1A1C21178
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985947604C;
	Fri,  9 Feb 2024 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxRHsfQb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B083A74E28
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494145; cv=none; b=k3vIYbO7JTZXQ+fPd7MklBiDKmMblDupIKcdMs9qf0McnqlXZV9WArs4NLjqg10bv8y6cJzcmI2p8VAQhQy8+1nqzaLlabp/mWcGbTpbsB+8Jk2eUt5C4UqalsePRUl+HpTekTko6EqjPTLKod4T+NU5InwYaVgkJ/R2ZgHveJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494145; c=relaxed/simple;
	bh=auNKb8QiR0FC/OPip6F8+NaNY7g5b1FisUqmCjFFaNY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMimeYlgdcCHqReiFmUOKxTp13U+eTbF+F+hOt4zgvjmEbSxSfdYWFJP9NyoIwqJOQpIlHP7iW2tarC8KOR/f22z0YkbDtIDQZEpqqaCmKjNPrQBZkOD/BRGYMDdPMgpmELbpMWLKfqdYXNCekXvkQZCQmANpZ9Fnk5o7//+eYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxRHsfQb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707494141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLAke4enBWD9cShjIdQ04k0ebmXM4X5P2eL0xWUYSe4=;
	b=RxRHsfQbSTiYnPWn2Er+HKhB2EPnhZxphhV9atXAJXhH2YexoTe1bG9UMfsVKncrX6+kkj
	8J2z+JIyrAXQvYKkYAmHyVWh5vus7ymI/J225rta6EbKf4BwnFeJOhnvztj/Y695IrrBOr
	N/1KHhNHQVjuFJxyZ6FtUrE5yf6CE3Y=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-hB9LHxijPKujPy6fuWzU7g-1; Fri, 09 Feb 2024 10:55:40 -0500
X-MC-Unique: hB9LHxijPKujPy6fuWzU7g-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7baa6cc3af2so123317339f.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 07:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707494139; x=1708098939;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLAke4enBWD9cShjIdQ04k0ebmXM4X5P2eL0xWUYSe4=;
        b=eoG3IRQgIWBqzLFMgjG6FMc4f5MAXNmv9Pq/855uNjJiNIWdVh27LSpk+VxvMVYzcd
         q/xg92IjAdHID56puHbZslsjEqb9SaPLeGG+Nz4Lddxr+05nnF44K66mhDo1a5d3kYEW
         7eNhsckXw+nW80R599bUFodDuJkbuk8hokq7HPISgWHpJNrdveOdw2IbjyIZf151u2Oz
         Gquu2jG5NtIX4SWA3f/SNNxH7ls6nG5l5uiSYx9k0jQug09vdXiOHJ63cTTuRhYmlWgP
         60y2CbRYBmd8PcllnfmsKfd0WQ8ibn3ivVEAvYTxaMkcU1GekBcrk5riJGJ+RUxyN2G3
         GMpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3DrooNB+/YhO8NIP7Y6DA83+MLccJ9nqr9CDcRHhP6Y41KKhQjT+x0UdGv1bOv90Ke/oD2xo4WvAafSprcov/W4dHIdBKESkwxANc
X-Gm-Message-State: AOJu0Yz18mluBv2P1nf7srYkB3JxWGVt94MhL6jkU/mLCtp/5e3ZvVuK
	4p+rhzdUi+pqtAbH5B9wyaSsW/wXtiRSzsH+RL5SFoVYDzcgtmxOwnkC7fu2xhM0qVuVpMhMUI6
	YNzqzEiYVmp4bUwv3idZNJkdPaT/sgOOfeC71tEjusUS1lHdOe+BC3SKDDMF9Aw==
X-Received: by 2002:a6b:5009:0:b0:7c3:f37b:f9d1 with SMTP id e9-20020a6b5009000000b007c3f37bf9d1mr2581420iob.19.1707494139199;
        Fri, 09 Feb 2024 07:55:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuKtDGKA2w8SA1rf3RiG7basQBgawwUIswn0ZL+C23tTlQM8nYLb615AN9TOxLy08OqXKASw==
X-Received: by 2002:a6b:5009:0:b0:7c3:f37b:f9d1 with SMTP id e9-20020a6b5009000000b007c3f37bf9d1mr2581389iob.19.1707494138899;
        Fri, 09 Feb 2024 07:55:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYNsFpnn69MaPwPnU4wCvtfxiu0gkTlYRqlU98kNLpCHBAeUilHtpwkORaC1un1ZYcW6/RfFH8q0j5jwe3Ly8/itj0snpLB/a7S6o1/6FgorPsmCWh1D5ZHF2kdF3Gg5UrgV48nCI0DvwGNXnj5vCH9M78Zonb/AKFYBcFEEt9j5Fe76UFQSwxi4/Lnpry8pOPPP+asd6JE7iAmwzNrDYX5hsxVV6CB33Oa62OGIVlN7FkSjqx+RuhLexgankQpvPSrTkeCYPUcgeUO4P58oS4x2jwEyfaW+xFgKeRR/XKVo8tgAINCy6b0YrYm9EnWbWSPHE8XJkZq3r+kVFBUsnPP0LKWmIE9F+xMRIoYDrb42BXXOrf5YRj9wExgD4tk+AMmwE3qkYN7TpHAgNJl4nKNV5XXlZsWEv/HqpNM+On6S79tcxZF+32r2crD4lwpSuET6gHj74CrKvKbikZ/hO7Vb4rnr5zcUx15NDGG7W6egOjvB4ZELWz9aiGT2AOHF/r9pS+6bgVO3z6EJhzalo+7wBhR+9EsF1kqnrSvg3o+hbWI71zUgL7CpMZIdhgF1cSVKunhTzaI2xY0Yc0r8Ra+PBML2vGXdfUlGB0ef++A2bBKKMechdNjTZIaeWiJPF+uM/dP71a2rWGCUIYBgaxodVJfzaI5WazHORJwVon5ZkX41ekBcW1Ywx/mxGDASqIqc11YPmKRogs/6DpPwwcWqDsDfaUA3hCsvgBaEyl7aAvdxwypjOrkMIHc94zgAiFQ/srltINL3rsIaC86nalan7WTu13u9VVt/Pllkfb4YWi
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id f8-20020a056602070800b007c447471187sm193809iox.11.2024.02.09.07.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 07:55:35 -0800 (PST)
Date: Fri, 9 Feb 2024 08:55:31 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "clg@redhat.com" <clg@redhat.com>,
 "oleksandr@natalenko.name" <oleksandr@natalenko.name>, "K V P,
 Satyanarayana" <satyanarayana.k.v.p@intel.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "brett.creeley@amd.com" <brett.creeley@amd.com>,
 "horms@kernel.org" <horms@kernel.org>, Rahul Rameshbabu
 <rrameshbabu@nvidia.com>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Andy
 Currid <acurrid@nvidia.com>, Alistair Popple <apopple@nvidia.com>, John
 Hubbard <jhubbard@nvidia.com>, Dan Williams <danw@nvidia.com>, "Anuj
 Aggarwal (SW-GPU)" <anuaggarwal@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v17 3/3] vfio/nvgrace-gpu: Add vfio pci variant module
 for grace hopper
Message-ID: <20240209085531.73f25a98.alex.williamson@redhat.com>
In-Reply-To: <SA1PR12MB71996EBCA4142458E8BEE367B04B2@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240205230123.18981-1-ankita@nvidia.com>
	<20240205230123.18981-4-ankita@nvidia.com>
	<BN9PR11MB527666B48A975B7F4304837C8C442@BN9PR11MB5276.namprd11.prod.outlook.com>
	<SA1PR12MB71996EBCA4142458E8BEE367B04B2@SA1PR12MB7199.namprd12.prod.outlook.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Feb 2024 09:20:22 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> Thanks Kevin for the review. Comments inline.
> 
> >>
> >> Note that the usemem memory is added by the VM Nvidia device driver [5]
> >> to the VM kernel as memblocks. Hence make the usable memory size
> >> memblock
> >> aligned.  
> >
> > Is memblock size defined in spec or purely a guest implementation choice?  
> 
> The MEMBLOCK value is a hardwired and a constant ABI value between the GPU
> FW and VFIO driver.
> 
> >>
> >> If the bare metal properties are not present, the driver registers the
> >> vfio-pci-core function pointers.  
> >
> > so if qemu doesn't generate such property the variant driver running
> > inside guest will always go to use core functions and guest vfio userspace
> > will observe both resmem and usemem bars. But then there is nothing
> > in field to prohibit mapping resmem bar as cacheable.
> >
> > should this driver check the presence of either ACPI property or
> > resmem/usemem bars to enable variant function pointers?  
> 
> Maybe I am missing something here; but if the ACPI property is absent,
> the real physical BARs present on the device will be exposed by the
> vfio-pci-core functions to the VM. So I think if the variant driver is ran
> within the VM, it should not see the fake usemem and resmem BARs.

There are two possibilities here, either we're assigning the pure
physical device from a host that does not have the ACPI properties or
we're performing a nested assignment.  In the former case we're simply
passing along the unmodified physical BARs.  In the latter case we're
actually passing through the fake BARs, the virtualization of the
device has already happened in the level 1 assignment.

I think Kevin's point is also relative to this latter scenario, in the
L1 instance of the nvgrace-gpu driver the mmap of the usemem BAR is
cachable, but in the L2 instance of the driver where we only use the
vfio-pci-core ops nothing maintains that cachable mapping.  Is that a
problem?  An uncached mapping on top of a cachable mapping is often
prone to problems.  Thanks,

Alex


