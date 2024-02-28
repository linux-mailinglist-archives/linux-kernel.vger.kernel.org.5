Return-Path: <linux-kernel+bounces-85627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4503586B86C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707551C25351
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5018B163A80;
	Wed, 28 Feb 2024 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKGfXarC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A500C15F316
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149097; cv=none; b=Mry57ydAbOYMLoBXxzFTZZU6wm/uL8YEiNI66wadJ+2hQ5biMAp/nYVKGE2WoSqF+DB9pSTrdzYa3C99fs9belI1EW0QuqiBrAtywpOj/LGLpRAaB9U5hnLV5NWyB2BuPvoYhkmFeshKdq63bnmTPzku5M1EDkkFN5mdNi361uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149097; c=relaxed/simple;
	bh=CXacfLZxd/QfNk37caUzTH5lHopeOn500HrfDvKWa+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsN1pz6OH5YehdajcyT1KrrdraCFelpTdKARP/pf1HZHfeRb1ngY6onod/UPnDwF+2GjkYRFnO/f4YJoq4odQJHq/BO1Cy0y1aHaQUbzXH4ersg1oqGsGh4Ps0G9LHqBR40afr1IXc53MGUOZstyv9RTgfedSbmVfP0TBEb/MfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKGfXarC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709149094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uA20CDAKsgM4Tx3YYjgPKLshZVqnm4Ew1QkRNRKLdZo=;
	b=UKGfXarCbhjUiw8A6FNfr9s/+beoA2N4i0ENGV759ABFU4BgXxeXit4ESFhIWdwRszpbSo
	b4rEtyZBJmGILtflQxg75QiKD9yayn8Dy8RMNlUcfOm5ThRco6n3vUi1DPD+FclT0wWH8w
	bPZXbASSFaROdHPTBkSIaM/eK2Ds5KY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-_vsUusOxM7y_yqFT012Peg-1; Wed, 28 Feb 2024 14:38:12 -0500
X-MC-Unique: _vsUusOxM7y_yqFT012Peg-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c78505a39eso5175239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709149092; x=1709753892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uA20CDAKsgM4Tx3YYjgPKLshZVqnm4Ew1QkRNRKLdZo=;
        b=l3UiEBoM1t4ulFez+sJOOjzpciOzlWGTSnB5h7R5xouB5r4aStKZ2f5huEUNjmsnqD
         J9gxDD87yToHVoQN6qSVjySSSOLWZLDCYFuYNwQoWns9pTM/PLuZBDYObslWr79rjNE4
         S5mxDNNQP7iAehQeJcTT/jTdFU4Q54juSnEa4ePPF/ilNfwa22/b3OU6EjWpjmrslfRM
         w74yBNggSV/vCaHkJ0X/URxtVcdEGzVYaCqLqwRnY3R73tJ5UgUs7ureLZHghuCtk6+l
         QBDcp1fsCY+/SFmz1BZahUidQ/SPUFaYdeFbKTbLoPxW6PtLL0KwO7ujhaXd2fj1autg
         RPrA==
X-Forwarded-Encrypted: i=1; AJvYcCXPTNdVpkhO31eDpIKlEHBaFSfZNXy6gkNUTkmHD+2hSiOL63PKXMwRG42Y82NHnbtSvbQsjG0omlCi5c1uslTvcihX/aiJAe0X3qjy
X-Gm-Message-State: AOJu0YyjcBXKJoLxpjjvVllHYY/BevFZrQVci3BOYFxMp61gQou+hIQI
	ty0FZdWBl6hhGaHqj5wmG/nhfzvxh8e3Fx38RapO5BfFFp+RNiDPMHcycOSnURHLX2meAB22HQ8
	wHGH4DLN+5m8uYScYDzrdXsF5ncbUKNNAYT/txSdEp6tXGZclSdFk205DW0/6wA==
X-Received: by 2002:a05:6602:734:b0:7c7:687e:41ba with SMTP id g20-20020a056602073400b007c7687e41bamr163491iox.9.1709149092236;
        Wed, 28 Feb 2024 11:38:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLbkc9moMLuoOGq7o7bm+s7c1gRZdMUmGNufsCw5nAB2hYAZNgiuYz111J6g0/Tgm8/E8rCg==
X-Received: by 2002:a05:6602:734:b0:7c7:687e:41ba with SMTP id g20-20020a056602073400b007c7687e41bamr163467iox.9.1709149091853;
        Wed, 28 Feb 2024 11:38:11 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id cl10-20020a0566383d0a00b004741d55e66asm7810jab.84.2024.02.28.11.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 11:38:11 -0800 (PST)
Date: Wed, 28 Feb 2024 12:38:10 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Delevoryas <peter@pjd.dev>
Cc: qemu-devel <qemu-devel@nongnu.org>, suravee.suthikulpanit@amd.com,
 iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [q&a] Status of IOMMU virtualization for nested virtualization
 (userspace PCI drivers in VMs)
Message-ID: <20240228123810.70663da2.alex.williamson@redhat.com>
In-Reply-To: <3D96D76D-85D2-47B5-B4C1-D6F95061D7D6@pjd.dev>
References: <3D96D76D-85D2-47B5-B4C1-D6F95061D7D6@pjd.dev>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Feb 2024 10:29:32 -0800
Peter Delevoryas <peter@pjd.dev> wrote:

> Hey guys,
>=20
> I=E2=80=99m having a little trouble reading between the lines on various
> docs, mailing list threads, KVM presentations, github forks, etc, so
> I figured I=E2=80=99d just ask:
>=20
> What is the status of IOMMU virtualization, like in the case where I
> want a VM guest to have a virtual IOMMU?

It works fine for simply nested assignment scenarios, ie. guest
userspace drivers or nested VMs.
=20
> I found this great presentation from KVM Forum 2021: [1]
>=20
> 1. I=E2=80=99m using -device intel-iommu right now. This has performance
> implications and large DMA transfers hit the vfio_iommu_type1
> dma_entry_limit on the host because of how the mappings are made.

Hugepages for the guest and mappings within the guest should help both
the mapping performance and DMA entry limit.  In general the type1 vfio
IOMMU backend is not optimized for dynamic mapping, so performance-wise
your best bet is still to design the userspace driver for static DMA
buffers.
=20
> 2. -device virtio-iommu is an improvement, but it doesn=E2=80=99t seem
> compatible with -device vfio-pci? I was only able to test this with
> cloud-hypervisor, and it has a better vfio mapping pattern (avoids
> hitting dma_entry_limit).

AFAIK it's just growing pains, it should work but it's working through
bugs.

> 3. -object iommufd [2] I haven=E2=80=99t tried this quite yet, planning t=
o:
> if it=E2=80=99s using iommufd, and I have all the right kernel features in
> the guest and host, I assume it=E2=80=99s implementing the passthrough mo=
de
> that AMD has described in their talk? Because I imagine that would be
> the best solution for me, I=E2=80=99m just having trouble understanding if
> it=E2=80=99s actually related or orthogonal.

For now iommufd provides a similar DMA mapping interface to type1, but
it does remove the DMA entry limit and improves locked page accounting.

To really see a performance improvement relative to dynamic mappings,
you'll need nesting support in the IOMMU, which is under active
development.  From this aspect you will want iommufd since similar
features will not be provided by type1.  Thanks,

Alex


