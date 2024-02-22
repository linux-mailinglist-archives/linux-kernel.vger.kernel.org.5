Return-Path: <linux-kernel+bounces-77416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF6B8604F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADD51C24C8D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE6E13BAC9;
	Thu, 22 Feb 2024 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ayti1kB9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03503137919
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637852; cv=none; b=RWVd9IHObioNwec/ron5HsafGvwnCAHDiGlhJFL4HiFNB89HO7dSM1SMY86ErZziMrN6a9ZhzG94rU5ceHRh+CYckVW/vOc2DilYucORZibYQmOFqJqtfIv+endVWWXSzqSJ5PFbxKLbsbMyUsGADQyOT0biFvh8VYdLTxsAfPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637852; c=relaxed/simple;
	bh=xWwioHVDwbHTc+OI3/Gswfk0tD97TSSGQGhCXErhCwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FY0iNriILtemFSuKi9ZEJ96Nr0atM3r5Mmp6FKHKPXD3Iufcn7r1Biq3piBvoQjJSdjousYP8Rxa4/sHc8fN9DabbgsG1lRtdVccsNmuq0cP4KEaw5zWVTH1Si1Sy187AcGoCTMIlHZq9VxX8vdTm8EBYem4hZBNe3BGoylSSNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ayti1kB9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708637849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vy/IsHmgfibIskC9o5GhvChyYxHecmg+0M1j8k6YQRw=;
	b=Ayti1kB9pbOwIg8QuoXQco8Y5iz3416A2xpvUYvV29jVO4Og1XnzIcB552+pZFIzAeLW3x
	XKep682VlPn/H4LK2sO6GqCWKTbMdhWeb6KvugqNsTOEvAM9TPgi45ky63ghcf00f/1JHA
	seMzrNOufJ5MsbuQFRD8XA7TQ+0rAkM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-HlqR08ZqNHeN3tO8oQBJaw-1; Thu, 22 Feb 2024 16:37:26 -0500
X-MC-Unique: HlqR08ZqNHeN3tO8oQBJaw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c00a1374ecso14227739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708637845; x=1709242645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vy/IsHmgfibIskC9o5GhvChyYxHecmg+0M1j8k6YQRw=;
        b=mQB0xAR8cRRaxC9YIKZ21bzgcXJwyjPZfAdJK9/WcmUKw1ymiozzDYhdTxr90z3EfG
         xPlzk+v65s0Ouipy84NO0fhW2iHbWG8kP0o3RCC1BtVXVsaRHdHdB6BA9aFpfsJQOutd
         AfAchspm7aI/1O8sUfc6Atuwo0ZVGCsXR0IhW5klprR6hQ3MXKU8Y8J3tWeL6X2FU7hA
         Hee9GWDNcBcd8FZPF9YGUDk4OK8CeGbCPYY1QE9ZtTFK0jriPZe+D+rb3Tu64w6wLCjM
         RFb0TQfkkI1fDmOqa4rb98+WvTltm50Zdm/HXJINw1PhXsJwRIzMI3WZsHzFGhM8VEtp
         AZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXo/spCNmDeXSWmyRaZqMQUD9YAlL0OzK2YarwPC+sayNRa9aG0+SlCTPVLOn9A3pcZQ/RzDDxjBoiE5ML0iZ9V6H2GT+KZpnGgIMsn
X-Gm-Message-State: AOJu0YwiwXlnCCaydDC+oWLNKFB5ncwpvZy7ZHKb9Hq8KOTxVGhrHWtf
	V9VHwP5/I625m+nQWx8xKvqcutsfxexo0VIsSHCCaZAmEL3utyqwec0Bt/WierBWb8DfrGy7ImS
	0UcT8FnA2XHp/axrGdVnsOpfK3NP0cDLlXOg6Di30XKps4YjXA0HNjeYaKfySFQ==
X-Received: by 2002:a92:7302:0:b0:365:27e7:4b60 with SMTP id o2-20020a927302000000b0036527e74b60mr171082ilc.21.1708637845463;
        Thu, 22 Feb 2024 13:37:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPX34jII0Yt6uqFCb9WcJyWIRWElIzoQhb5wUnjuZKOZrMpbgJAwbijtoG8hqMcca1YN8LBQ==
X-Received: by 2002:a92:7302:0:b0:365:27e7:4b60 with SMTP id o2-20020a927302000000b0036527e74b60mr171066ilc.21.1708637845159;
        Thu, 22 Feb 2024 13:37:25 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id l14-20020a056638220e00b004743021012asm2117827jas.2.2024.02.22.13.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 13:37:24 -0800 (PST)
Date: Thu, 22 Feb 2024 14:36:54 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: <ankita@nvidia.com>
Cc: <jgg@nvidia.com>, <yishaih@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
 <mst@redhat.com>, <eric.auger@redhat.com>, <jgg@ziepe.ca>,
 <oleksandr@natalenko.name>, <clg@redhat.com>,
 <satyanarayana.k.v.p@intel.com>, <brett.creeley@amd.com>,
 <horms@kernel.org>, <shannon.nelson@amd.com>, <rrameshbabu@nvidia.com>,
 <zhiw@nvidia.com>, <aniketa@nvidia.com>, <cjia@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <vsethi@nvidia.com>,
 <acurrid@nvidia.com>, <apopple@nvidia.com>, <jhubbard@nvidia.com>,
 <danw@nvidia.com>, <anuaggarwal@nvidia.com>, <mochs@nvidia.com>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v19 0/3] vfio/nvgrace-gpu: Add vfio pci variant module
 for grace hopper
Message-ID: <20240222143654.0ed77f85.alex.williamson@redhat.com>
In-Reply-To: <20240220115055.23546-1-ankita@nvidia.com>
References: <20240220115055.23546-1-ankita@nvidia.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 17:20:52 +0530
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
> 
> NVIDIA's upcoming Grace Hopper Superchip provides a PCI-like device
> for the on-chip GPU that is the logical OS representation of the
> internal proprietary chip-to-chip cache coherent interconnect.
> 
> The device is peculiar compared to a real PCI device in that whilst
> there is a real 64b PCI BAR1 (comprising region 2 & region 3) on the
> device, it is not used to access device memory once the faster
> chip-to-chip interconnect is initialized (occurs at the time of host
> system boot). The device memory is accessed instead using the
> chip-to-chip interconnect that is exposed as a contiguous physically
> addressable region on the host. Since the device memory is cache
> coherent with the CPU, it can be mmaped into the user VMA with a
> cacheable mapping and used like a regular RAM. The device memory is
> not added to the host kernel, but mapped directly as this reduces
> memory wastage due to struct pages.
> 
> There is also a requirement of a minimum reserved 1G uncached region
> (termed as resmem) to support the Multi-Instance GPU (MIG) feature [1].
> This is to work around a HW defect. Based on [2], the requisite properties
> (uncached, unaligned access) can be achieved through a VM mapping (S1)
> of NORMAL_NC and host (S2) mapping with MemAttr[2:0]=0b101. To provide
> a different non-cached property to the reserved 1G region, it needs to
> be carved out from the device memory and mapped as a separate region
> in Qemu VMA with pgprot_writecombine(). pgprot_writecombine() sets
> the Qemu VMA page properties (pgprot) as NORMAL_NC.
> 
> Provide a VFIO PCI variant driver that adapts the unique device memory
> representation into a more standard PCI representation facing userspace.
> 
> The variant driver exposes these two regions - the non-cached reserved
> (resmem) and the cached rest of the device memory (termed as usemem) as
> separate VFIO 64b BAR regions. This is divergent from the baremetal
> approach, where the device memory is exposed as a device memory region.
> The decision for a different approach was taken in view of the fact that
> it would necessiate additional code in Qemu to discover and insert those
> regions in the VM IPA, along with the additional VM ACPI DSDT changes to
> communiate the device memory region IPA to the VM workloads. Moreover,
> this behavior would have to be added to a variety of emulators (beyond
> top of tree Qemu) out there desiring grace hopper support.
> 
> Since the device implements 64-bit BAR0, the VFIO PCI variant driver
> maps the uncached carved out region to the next available PCI BAR (i.e.
> comprising of region 2 and 3). The cached device memory aperture is
> assigned BAR region 4 and 5. Qemu will then naturally generate a PCI
> device in the VM with the uncached aperture reported as BAR2 region,
> the cacheable as BAR4. The variant driver provides emulation for these
> fake BARs' PCI config space offset registers.
> 
> The hardware ensures that the system does not crash when the memory
> is accessed with the memory enable turned off. It synthesis ~0 reads
> and dropped writes on such access. So there is no need to support the
> disablement/enablement of BAR through PCI_COMMAND config space register.
> 
> The memory layout on the host looks like the following:
>                devmem (memlength)
> |--------------------------------------------------|
> |-------------cached------------------------|--NC--|
> |                                           |
> usemem.memphys                              resmem.memphys
> 
> PCI BARs need to be aligned to the power-of-2, but the actual memory on the
> device may not. A read or write access to the physical address from the
> last device PFN up to the next power-of-2 aligned physical address
> results in reading ~0 and dropped writes. Note that the GPU device
> driver [6] is capable of knowing the exact device memory size through
> separate means. The device memory size is primarily kept in the system
> ACPI tables for use by the VFIO PCI variant module.
> 
> Note that the usemem memory is added by the VM Nvidia device driver [5]
> to the VM kernel as memblocks. Hence make the usable memory size memblock
> (MEMBLK_SIZE) aligned. This is a hardwired ABI value between the GPU FW and
> VFIO driver. The VM device driver make use of the same value for its
> calculation to determine USEMEM size.
> 
> Currently there is no provision in KVM for a S2 mapping with
> MemAttr[2:0]=0b101, but there is an ongoing effort to provide the same [3].
> As previously mentioned, resmem is mapped pgprot_writecombine(), that
> sets the Qemu VMA page properties (pgprot) as NORMAL_NC. Using the
> proposed changes in [3] and [4], KVM marks the region with
> MemAttr[2:0]=0b101 in S2.
> 
> If the device memory properties are not present, the driver registers the
> vfio-pci-core function pointers. Since there are no ACPI memory properties
> generated for the VM, the variant driver inside the VM will only use
> the vfio-pci-core ops and hence try to map the BARs as non cached. This
> is not a problem as the CPUs have FWB enabled which blocks the VM
> mapping's ability to override the cacheability set by the host mapping.
> 
> This goes along with a qemu series [6] to provides the necessary
> implementation of the Grace Hopper Superchip firmware specification so
> that the guest operating system can see the correct ACPI modeling for
> the coherent GPU device. Verified with the CUDA workload in the VM.
> 
> [1] https://www.nvidia.com/en-in/technologies/multi-instance-gpu/
> [2] section D8.5.5 of https://developer.arm.com/documentation/ddi0487/latest/
> [3] https://lore.kernel.org/all/20240211174705.31992-1-ankita@nvidia.com/
> [4] https://lore.kernel.org/all/20230907181459.18145-2-ankita@nvidia.com/
> [5] https://github.com/NVIDIA/open-gpu-kernel-modules
> [6] https://lore.kernel.org/all/20231203060245.31593-1-ankita@nvidia.com/
> 
> Applied over v6.8-rc5.
> 
> Signed-off-by: Aniket Agashe <aniketa@nvidia.com>
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
[snip]
> Ankit Agrawal (3):
>   vfio/pci: rename and export do_io_rw()
>   vfio/pci: rename and export range_intersect_range
>   vfio/nvgrace-gpu: Add vfio pci variant module for grace hopper
> 
>  MAINTAINERS                           |  16 +-
>  drivers/vfio/pci/Kconfig              |   2 +
>  drivers/vfio/pci/Makefile             |   2 +
>  drivers/vfio/pci/nvgrace-gpu/Kconfig  |  10 +
>  drivers/vfio/pci/nvgrace-gpu/Makefile |   3 +
>  drivers/vfio/pci/nvgrace-gpu/main.c   | 879 ++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_config.c    |  42 ++
>  drivers/vfio/pci/vfio_pci_rdwr.c      |  16 +-
>  drivers/vfio/pci/virtio/main.c        |  72 +--
>  include/linux/vfio_pci_core.h         |  10 +-
>  10 files changed, 993 insertions(+), 59 deletions(-)
>  create mode 100644 drivers/vfio/pci/nvgrace-gpu/Kconfig
>  create mode 100644 drivers/vfio/pci/nvgrace-gpu/Makefile
>  create mode 100644 drivers/vfio/pci/nvgrace-gpu/main.c
> 

Applied to vfio next branch for v6.9.  Thanks,

Alex


