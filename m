Return-Path: <linux-kernel+bounces-77340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA479860406
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1CF285D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D510E7175A;
	Thu, 22 Feb 2024 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNRr/EWw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEF614B81E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635171; cv=none; b=K6r2Le8JuxY3V/B4GB59Sj2logxBmmQ51iGxZnK1ikelknXjitvfDUV5BUiosMofShVsDko43G70+5JS5Gl5NRr5Q22EYKxbWXeInU2qZofTLdVyPklId5RukZaDczwRnIkuU/Fd/zTvNaVdiYcjBmlm+dg26WwMSN3OsEJibaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635171; c=relaxed/simple;
	bh=GhL7YM18DcEtfbq8lBqUnF8deaVqdKA2j+PviWMXDM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bz1cq5XMArJNRdzz5n4T+XZ19mK4SRU7fHtGQiOJIKj14kuoIb5yzFiPSitd5cFvD5Je6JWnpesXf7Uvml1oIW3wmm43Lik1+qbV5s37dCOgERbhojZDt+iSIF34sGu2Cju72Cfu1c0dct5N8BO8QN2nehqYdEOnAJ4aji2Hnsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNRr/EWw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708635168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UcO6Jui6DKtatymkIK1WWSMn6J5ECJZL7QtFar2I6wY=;
	b=LNRr/EWw/ssEAuzHOD72Dn4FnDEWf/CNDwcqwYnGAfUSLJGX2CkMsI4L5XtlkAY5fRKx/F
	qjOuabhhYruFVWKPn9zDahDQNyDwCGL/Gd++iCZaQA2W3inj8qd+ewOiOhp4BAsY6nyMRD
	i52XtG8KyAUovwS4zNRD6RRaaGam5DA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-kKcPwSWhMSauC5W7sU5mlQ-1; Thu, 22 Feb 2024 15:52:45 -0500
X-MC-Unique: kKcPwSWhMSauC5W7sU5mlQ-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c032b61db5so173422b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708635165; x=1709239965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcO6Jui6DKtatymkIK1WWSMn6J5ECJZL7QtFar2I6wY=;
        b=tF8h8ek10wAXuzpv/mGmeBooA+YC7ICd+IVQPqZeDJARdmfBpJ5PzbkcCrwo9y/Yn6
         3JexSp5siiTmM0Wn1NQXWMppThXDPontajx9nXxcA7L6sigqoSOEsvIahd7JAkJafFCb
         zQb8FgzVh7h8gchIt3WCE4wAwXqj5v7xCJ6sVF/l+mAF9nR/Z/PGvmhIWwp1v2sBMHvf
         7lU3uE2UDHuUjU9lsIG/w1McYzBRKxjuZ/fnn6qZnauzT0WtuZ8NLTw0FEKPt+12j7zA
         r9ywzBFOsmVKljrutpl8pAljmCo88SlJZkvfoF0uQ4v+xqRlES9sGoA9miEK0AA7k79t
         rTLQ==
X-Forwarded-Encrypted: i=1; AJvYcCULCc6DEsW5VA7wtCin9dw7TwfnTyftA3EQHbM9lah84+KWIX90elAb6iFb6wct3BxXhCYIW8N16eBB1bwne++fT1s1AwDbMvT6ELva
X-Gm-Message-State: AOJu0YwWSJbLRZCvwvi+WPL3lW/v7fUmp2hZ/PZDNNwQTW8RRZw8vExn
	QKDN3uTqMWORBoJB4HFOEcMUSCpOPTrZiYhW9cqR8zt5g0n2uLdIpaiP4GtD0ytYvzwF2emGtVU
	hS9asrqwQwSHbzWdtH9QGhyiVoawvJaNtpVdjAMtzRhqvqFjSiH6SDYPilEJIwg==
X-Received: by 2002:a05:6808:316:b0:3be:b5f6:f355 with SMTP id i22-20020a056808031600b003beb5f6f355mr66161oie.15.1708635165237;
        Thu, 22 Feb 2024 12:52:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHphM2AEgwOFKuEkCG9cWu5dpOQyfI2E3tisVZLDiLPsoH3PowBIUeuTZNvzTCWg2+WwuAc+Q==
X-Received: by 2002:a05:6808:316:b0:3be:b5f6:f355 with SMTP id i22-20020a056808031600b003beb5f6f355mr66138oie.15.1708635164973;
        Thu, 22 Feb 2024 12:52:44 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id a14-20020a05680802ce00b003c15d61ec3fsm1461018oid.37.2024.02.22.12.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:52:44 -0800 (PST)
Date: Thu, 22 Feb 2024 13:52:40 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: <ankita@nvidia.com>
Cc: <jgg@nvidia.com>, <maz@kernel.org>, <oliver.upton@linux.dev>,
 <james.morse@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
 <reinette.chatre@intel.com>, <surenb@google.com>, <stefanha@redhat.com>,
 <brauner@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
 <mark.rutland@arm.com>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
 <ardb@kernel.org>, <akpm@linux-foundation.org>, <andreyknvl@gmail.com>,
 <wangjinchao@xfusion.com>, <gshan@redhat.com>, <shahuang@redhat.com>,
 <ricarkol@google.com>, <linux-mm@kvack.org>, <lpieralisi@kernel.org>,
 <rananta@google.com>, <ryan.roberts@arm.com>, <david@redhat.com>,
 <linus.walleij@linaro.org>, <bhe@redhat.com>, <aniketa@nvidia.com>,
 <cjia@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <vsethi@nvidia.com>, <acurrid@nvidia.com>, <apopple@nvidia.com>,
 <jhubbard@nvidia.com>, <danw@nvidia.com>, <kvmarm@lists.linux.dev>,
 <mochs@nvidia.com>, <zhiw@nvidia.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 4/4] vfio: convey kvm that the vfio-pci device is wc
 safe
Message-ID: <20240222135240.46682bed.alex.williamson@redhat.com>
In-Reply-To: <20240220072926.6466-5-ankita@nvidia.com>
References: <20240220072926.6466-1-ankita@nvidia.com>
	<20240220072926.6466-5-ankita@nvidia.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 12:59:26 +0530
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
> 
> The VM_ALLOW_ANY_UNCACHED flag is implemented for ARM64,
> allowing KVM stage 2 device mapping attributes to use Normal-NC
> rather than DEVICE_nGnRE, which allows guest mappings
> supporting combining attributes (WC). ARM does not architecturally
> guarantee this is safe, and indeed some MMIO regions like the GICv2
> VCPU interface can trigger uncontained faults if Normal-NC is used.
> 
> To safely use VFIO in KVM the platform must guarantee full safety
> in the guest where no action taken against a MMIO mapping can
> trigger an uncontained failure. We belive that most VFIO PCI
> platforms support this for both mapping types, at least in common
> flows, based on some expectations of how PCI IP is integrated. So
> make vfio-pci set the VM_ALLOW_ANY_UNCACHED flag.
> 
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 1cbc990d42e0..c93bea18fc4b 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1862,8 +1862,24 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
>  	/*
>  	 * See remap_pfn_range(), called from vfio_pci_fault() but we can't
>  	 * change vm_flags within the fault handler.  Set them now.
> +	 *
> +	 * VM_ALLOW_ANY_UNCACHED: The VMA flag is implemented for ARM64,
> +	 * allowing KVM stage 2 device mapping attributes to use Normal-NC
> +	 * rather than DEVICE_nGnRE, which allows guest mappings
> +	 * supporting combining attributes (WC). ARM does not
> +	 * architecturally guarantee this is safe, and indeed some MMIO
> +	 * regions like the GICv2 VCPU interface can trigger uncontained
> +	 * faults if Normal-NC is used.
> +	 *
> +	 * To safely use VFIO in KVM the platform must guarantee full
> +	 * safety in the guest where no action taken against a MMIO
> +	 * mapping can trigger an uncontained failure. We belive that
> +	 * most VFIO PCI platforms support this for both mapping types,
> +	 * at least in common flows, based on some expectations of how
> +	 * PCI IP is integrated. So set VM_ALLOW_ANY_UNCACHED in VMA flags.
>  	 */
> -	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> +	vm_flags_set(vma, VM_ALLOW_ANY_UNCACHED | VM_IO | VM_PFNMAP |
> +			VM_DONTEXPAND | VM_DONTDUMP);
>  	vma->vm_ops = &vfio_pci_mmap_ops;
>  
>  	return 0;

Acked-by: Alex Williamson <alex.williamson@redhat.com>


