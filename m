Return-Path: <linux-kernel+bounces-66266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A68855980
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0521C249E0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C28C7475;
	Thu, 15 Feb 2024 03:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="otG5x9Uy"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9818610E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 03:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707968030; cv=none; b=RulnQpyg5EcQpyCWpfL9R9guA2yPS8m7h4I6w8ZqCmu3N3DdLMTBfqs9m/lvX6C9HQ6Gdq3q1npijehKWP89N76/QDLFiS3TYoqOBof2wBwon/UVLV1yuvTDEGRX/9sUeYmVDYvc8an/kh7sglmclQCIC0/pZYIJjx1Dy2m2J9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707968030; c=relaxed/simple;
	bh=TCZSJ/XNJaPFnnPAuJVmZMNZx3dUX1ubTXjBc6BND2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulKdOIUNIPW2RS9cWg+TtfPE6w27TvzQ+MLj6GQct+1nH4HDaf1X1Eb+8vJI6vl1If45XUuvjTrsMvddsOdHhGMW488/jPR9wzgyQIq5TOSPLK8Eh1cKR1Ll3O8lyEpH2IFNt+2p+UgyvyDMuwGixVNrehCzpl8s/4eafNT4VWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=otG5x9Uy; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4b978e5e240so208546e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707968027; x=1708572827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVf6gZc4QGYJ3h+idoxj2vV7qjkpHx1O2OfEs7P0+bE=;
        b=otG5x9UynCg5gs+Wy/WT5KolqXus+YVTIVO/958347m8vtdMqVsf8GxD2GuREMPcbO
         ZaYsdB7a8ZZFTaOhTN2uRt6l2nL3TMOGOQ56twT5yAcDl+1OqSXUTnpaQl19wmm9rF/I
         UviBa1GwsA4ixaic4vDh5yPerK9nxFGnDUYIp/NjCfx8P1IWDMxNWdL8PI0vDNTopR2P
         4Xmwdg9EYALuOzib5IUM2pRDxA9NjQ2YB9iL0w+eODpO923HIm4ECP/JhcroeadziO7L
         YuqVapRE/hpSLzhSNiRtQ6yb/QvE4ayncVm7NwaEr6KbSRUE7/QmBPCUYC62qFZKOZFg
         1EIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707968027; x=1708572827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVf6gZc4QGYJ3h+idoxj2vV7qjkpHx1O2OfEs7P0+bE=;
        b=ugdttMbWvjxG8e+J8Ur50BIeb9rg5dzAqWzDd6T8SY6xO+h+UaRrmuHG9F2JVIyGP2
         5KhFqxxkbS8gnL41RaJdMfE4BDk0nokLZxKloz2PLcBCA3ALIl2unw6u2jWScmJ5NuI1
         SWYo28BHLP5iJxcyN7DWjRL1TBnBPvhi6a9bchlXyUBHXks5OOOGydmBxwptabgFL22e
         wZkKohN9USm2vd70FD0xXFBK3h7phc9Y4JJmL4AoRuiRWGPn1nje1klsmg40BZBNL6ZJ
         qcQVTE6c1NvFVwLk3wYarqVq4m1A55W4gsZUUE3gKenoyVAwWpt1KlexP9RihbtCGu7A
         p/iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUbCqHsxSZIgsSVNNQbh9Kgaa6pWS/L6MVsUdm+JY8+xNBB3ZmUJSYaJtmpIiFfut7m5nkm+9c6EWPlGH/Vi4C+czCJcbm+8lVaz3Z
X-Gm-Message-State: AOJu0YylbGcR5mpW2TU5V3IQZPNLeXS7h1z4QDcdfA9W0qykuCQoXbOT
	mQaCKgmmsdlyfvxGp9U4BzcnnZHpelXABZ6xDLcGJzaWrhaZFzm6koyarESMlYc8ASZthETWdWd
	pF3VPf1vnFawhhe0MfAxoU4UJwyAW42cu6lOf
X-Google-Smtp-Source: AGHT+IFRu6qWXK6iKFa30lwovzXRFsLYhJ1iV7RGR1j8fU1/0lchFPKaCqnUKJtNUxrh1UZmYKHIncUqE3mKqQUY+K8=
X-Received: by 2002:a1f:db01:0:b0:4c0:8ec:2331 with SMTP id
 s1-20020a1fdb01000000b004c008ec2331mr423435vkg.2.1707968027271; Wed, 14 Feb
 2024 19:33:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com> <20240112055251.36101-2-vannapurve@google.com>
 <etvf2mon464whscbxqktdd7bputnqmmwmoeg7ssixsk4kljfek@4wngbgzbbmck>
In-Reply-To: <etvf2mon464whscbxqktdd7bputnqmmwmoeg7ssixsk4kljfek@4wngbgzbbmck>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 15 Feb 2024 09:03:33 +0530
Message-ID: <CAGtprH-95FEUzpc-yxQMo87gpqgMxyz9W8tiWtu_ZHhMW-jjuA@mail.gmail.com>
Subject: Re: [RFC V1 1/5] swiotlb: Support allocating DMA memory from SWIOTLB
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	rientjes@google.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com, 
	pgonda@google.com, michael.roth@amd.com, thomas.lendacky@amd.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, andrew.jones@linux.dev, 
	corbet@lwn.net, hch@lst.de, m.szyprowski@samsung.com, rostedt@goodmis.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 8:20=E2=80=AFPM Kirill A. Shutemov <kirill@shutemov=
name> wrote:
>
> On Fri, Jan 12, 2024 at 05:52:47AM +0000, Vishal Annapurve wrote:
> > Modify SWIOTLB framework to allocate DMA memory always from SWIOTLB.
> >
> > CVMs use SWIOTLB buffers for bouncing memory when using dma_map_* APIs
> > to setup memory for IO operations. SWIOTLB buffers are marked as shared
> > once during early boot.
> >
> > Buffers allocated using dma_alloc_* APIs are allocated from kernel memo=
ry
> > and then converted to shared during each API invocation. This patch ens=
ures
> > that such buffers are also allocated from already shared SWIOTLB
> > regions. This allows enforcing alignment requirements on regions marked
> > as shared.
>
> But does it work in practice?
>
> Some devices (like GPUs) require a lot of DMA memory. So with this approa=
ch
> we would need to have huge SWIOTLB buffer that is unused in most VMs.
>

Current implementation limits the size of statically allocated SWIOTLB
memory pool to 1G. I was proposing to enable dynamic SWIOTLB for CVMs
in addition to aligning the memory allocations to hugepage sizes, so
that the SWIOTLB pool can be scaled up on demand.

The issue with aligning the pool areas to hugepages is that hugepage
allocation at runtime is not guaranteed. Guaranteeing the hugepage
allocation might need calculating the upper bound in advance, which
defeats the purpose of enabling dynamic SWIOTLB. I am open to
suggestions here.

> --
>   Kiryl Shutsemau / Kirill A. Shutemov

