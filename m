Return-Path: <linux-kernel+bounces-103849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 817CB87C5B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB5A1C211D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2144D10798;
	Thu, 14 Mar 2024 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/v5beb2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC02101CF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710457341; cv=none; b=tl/Z8LUKfRuzrCJgtSPecsO9h88alT2UshOJcI9+aTy2J5QHJWou5DFjlfx4Iskeg/qrUK3eJEjLpVNSMwPc4iK92gtAuggRgt1OSsg9uHm5N17MB2DgA29oB4VDtflR9XVo6bU7JbQ0ankFYBoxK1EsHT8AETriwb9R6CjRE5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710457341; c=relaxed/simple;
	bh=FI+T66SlMrJhqbUHPu5MdtDuGqaVFic8LTENAA0CKGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bJZ1L2lXlhd+VPRBIfZWdFeJzFd8mqAcl3uHajUq8hHupVOAjIYge/+tI+omskHgGKjCM5AC0oPE53FHmyR5QJOCe0+qEXJE+7djTpbm0KrWlFnJ1NsW8QUvI66GR9/P4olWLDQN4lfdlrXjJ0wf4XQFghCpOZKh1P+YLRegMWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W/v5beb2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710457338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Dqwb47UeVJyL553VVL1dBsJV2eAxwYIP4Vg/2iB2LDI=;
	b=W/v5beb2cMEJ/jSsjrjnUVQOsJpVI7pFJ0gfaWPHd3mhmlMZ9fwLGWhWYr1fd+ZWpX04Oj
	msLFjD/cGutWTCFh57j+vNji/2AORHa38Bowm3in7q48HSshlZSwPiLKtBaQyMI7kt75i0
	PRK4CUowANTXhEWwqh9DcKhI637wWJY=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-HhHWPdgGN_WGDzMGVlNWTg-1; Thu, 14 Mar 2024 19:02:00 -0400
X-MC-Unique: HhHWPdgGN_WGDzMGVlNWTg-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3662fd7ae59so15451715ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710457319; x=1711062119;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dqwb47UeVJyL553VVL1dBsJV2eAxwYIP4Vg/2iB2LDI=;
        b=GI6pBeubBjOQGxn28Dqe41xSzhXJSeJWwmkmFhDLYFRMrLasOcIfSKwp7GAXz4pPiu
         g1WR3lX35TUYTxYRWX9WGvGDyA2OkpTPGp/rIvfe6lfEnrpIKIvtq/LGLHWi66m4lz3J
         yeBxb3lTTWlj4u9l3N7Z8NrOiXMrRI3SqxSMux2VH+S1gkluSjxqlJIAnKNV1vDk0Yb/
         MAOytKn0TFuxmgB+vi2wLfu0jxsp/2pDiPUtFoWeClODzuqFGzYZ5+y/+oG39cIZjch+
         dpgw8iouQg6txEidVpYevTJGt8U/YdKS1ii6iDjHKEGQyCrinWkcfKGehaj6/LVob7W5
         YJAA==
X-Gm-Message-State: AOJu0YxMwbouELZA8hinAAJmT9VMqfiqeJnTChWTKo7Q9B0hrI9k/pBa
	gtUL/LL/2XxteRFWc5p+nnbH0iPu9nl6Xpsi+k3+nCTkGfqWxyQ9rmAyhmFYmKlPbMH+YBxH5i1
	tCSsyK+Rf8Hze9Osp1tikGt3nATYjzkg1p8hUfVscQ1NbOhPo8FU33ctMLIbYp73rf5ACxg==
X-Received: by 2002:a05:6e02:c65:b0:365:117c:c957 with SMTP id f5-20020a056e020c6500b00365117cc957mr3254982ilj.16.1710457319571;
        Thu, 14 Mar 2024 16:01:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8fBmK539XOlclZZHxaGKs7h1sip4vSTTOsD3OfJttYhQtVXGNLs7ZFYovWxCtEZMeRBoC0A==
X-Received: by 2002:a05:6e02:c65:b0:365:117c:c957 with SMTP id f5-20020a056e020c6500b00365117cc957mr3254964ilj.16.1710457319218;
        Thu, 14 Mar 2024 16:01:59 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 5-20020a920d05000000b00363797f6b00sm389521iln.8.2024.03.14.16.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 16:01:58 -0700 (PDT)
Date: Thu, 14 Mar 2024 17:01:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO updates for v6.9-rc1
Message-ID: <20240314170157.0a6bdd52.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v6.9-rc1

for you to fetch changes up to 7447d911af699a15f8d050dfcb7c680a86f87012:

  vfio/fsl-mc: Block calling interrupt handler without trigger (2024-03-11 =
13:08:52 -0600)

A couple minor additional notes, first you'll see a trivial conflict in
MAINTAINERS as reported and properly resolved by Stephen here:

https://lore.kernel.org/all/20240223140325.345a9cdb@canb.auug.org.au/

Second, just for awareness, this includes a merge from the kvmarm tree
for a dependency on the new vma VM_ALLOW_ANY_UNCACHED flag which is
further described in Oliver's merge (and of course the individual
commits):

https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git/commit/?h=
=3Dkvmarm-6.9&id=3D9bd8d7df1971c2ebdcaf4526cf7a3f4ea38d0ede

Thanks,
Alex

----------------------------------------------------------------
VFIO updates for v6.9-rc1

 - Add warning in unlikely case that device is not captured with
   driver_override. (Kunwu Chan)

 - Error handling improvements in mlx5-vfio-pci to detect firmware
   tracking object error states, logging of firmware error syndrom,
   and releasing of firmware resources in aborted migration sequence.
   (Yishai Hadas)

 - Correct an un-alphabetized VFIO MAINTAINERS entry.
   (Alex Williamson)

 - Make the mdev_bus_type const and also make the class struct const
   for a couple of the vfio-mdev sample drivers. (Ricardo B. Marliere)

 - Addition of a new vfio-pci variant driver for the GPU of NVIDIA's
   Grace-Hopper superchip.  During initialization of the chip-to-chip
   interconnect in this hardware module, the PCI BARs of the device
   become unused in favor of a faster, coherent mechanism for exposing
   device memory.  This driver primarily changes the VFIO
   representation of the device to masquerade this coherent aperture
   to replace the physical PCI BARs for userspace drivers.  This also
   incorporates use of a new vma flag allowing KVM to use write
   combining attributes for uncached device memory.  (Ankit Agrawal)

 - Reset fixes and cleanups for the pds-vfio-pci driver.  Save and
   restore files were previously leaked if the device didn't pass
   through an error state, this is resolved and later re-fixed to
   prevent access to the now freed files.  Reset handling is also
   refactored to remove the complicated deferred reset mechanism.
   (Brett Creeley)

 - Remove some references to pl330 in the vfio-platform amba
   driver. (Geert Uytterhoeven)

 - Remove twice redundant and ugly code to unpin incidental pins
   of the zero-page. (Alex Williamson)

 - Deferred reset logic is also removed from the hisi-acc-vfio-pci
   driver as a simplification. (Shameer Kolothum)

 - Enforce that mlx5-vfio-pci devices must support PRE_COPY and
   remove resulting unnecessary code.  There is no device firmware
   that has been available publicly without this support.
   (Yishai Hadas)

 - Switch over to using the .remove_new callback for vfio-platform
   in support of the broader transition for a void remove function.
   (Uwe Kleine-K=C3=B6nig)

 - Resolve multiple issues in interrupt code for VFIO bus drivers
   that allow calling eventfd_signal() on a NULL context.  This
   also remove a potential race in INTx setup on certain hardware
   for vfio-pci, races with various mechanisms to mask INTx, and
   leaked virqfds in vfio-platform. (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (10):
      MAINTAINERS: Re-alphabetize VFIO
      Merge branch 'kvm-arm64/vfio-normal-nc' of https://git.kernel.org/pub=
/scm/linux/kernel/git/oupton/linux into v6.9/vfio/next
      Revert "vfio/type1: Unpin zero pages"
      vfio/pci: Disable auto-enable of exclusive INTx IRQ
      vfio/pci: Lock external INTx masking ops
      vfio: Introduce interface to flush virqfd inject workqueue
      vfio/pci: Create persistent INTx handler
      vfio/platform: Disable virqfds on cleanup
      vfio/platform: Create persistent IRQ handlers
      vfio/fsl-mc: Block calling interrupt handler without trigger

Ankit Agrawal (8):
      vfio/pci: rename and export do_io_rw()
      vfio/pci: rename and export range_intersect_range
      vfio/nvgrace-gpu: Add vfio pci variant module for grace hopper
      KVM: arm64: Introduce new flag for non-cacheable IO memory
      mm: Introduce new flag to indicate wc safe
      KVM: arm64: Set io memory s2 pte as normalnc for vfio pci device
      vfio: Convey kvm that the vfio-pci device is wc safe
      vfio/nvgrace-gpu: Convey kvm to map device memory region as noncached

Brett Creeley (3):
      vfio/pds: Always clear the save/restore FDs on reset
      vfio/pds: Make sure migration file isn't accessed after reset
      vfio/pds: Refactor/simplify reset logic

Geert Uytterhoeven (1):
      vfio: amba: Rename pl330_ids[] to vfio_amba_ids[]

Kunwu Chan (1):
      vfio/pci: WARN_ON driver_override kasprintf failure

Ricardo B. Marliere (3):
      vfio: mdev: make mdev_bus_type const
      vfio/mdpy: make mdpy_class constant
      vfio/mbochs: make mbochs_class constant

Shameer Kolothum (1):
      hisi_acc_vfio_pci: Remove the deferred_reset logic

Uwe Kleine-K=C3=B6nig (1):
      vfio/platform: Convert to platform remove callback returning void

Yishai Hadas (6):
      net/mlx5: Add the IFC related bits for query tracker
      vfio/mlx5: Add support for tracker object change event
      vfio/mlx5: Handle the EREMOTEIO error upon the SAVE command
      vfio/mlx5: Block incremental query upon migf state error
      vfio/mlx5: Let firmware knows upon leaving PRE_COPY back to RUNNING
      vfio/mlx5: Enforce PRE_COPY support

 MAINTAINERS                                    |  16 +-
 arch/arm64/include/asm/kvm_pgtable.h           |   2 +
 arch/arm64/include/asm/memory.h                |   2 +
 arch/arm64/kvm/hyp/pgtable.c                   |  24 +-
 arch/arm64/kvm/mmu.c                           |  14 +-
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c         |   7 +-
 drivers/vfio/mdev/mdev_driver.c                |   2 +-
 drivers/vfio/mdev/mdev_private.h               |   2 +-
 drivers/vfio/pci/Kconfig                       |   2 +
 drivers/vfio/pci/Makefile                      |   2 +
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c |  48 +-
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h |   6 +-
 drivers/vfio/pci/mlx5/cmd.c                    | 157 ++++-
 drivers/vfio/pci/mlx5/cmd.h                    |  11 +-
 drivers/vfio/pci/mlx5/main.c                   | 148 ++---
 drivers/vfio/pci/nvgrace-gpu/Kconfig           |  10 +
 drivers/vfio/pci/nvgrace-gpu/Makefile          |   3 +
 drivers/vfio/pci/nvgrace-gpu/main.c            | 888 +++++++++++++++++++++=
++++
 drivers/vfio/pci/pds/dirty.c                   |   6 +-
 drivers/vfio/pci/pds/lm.c                      |  13 +
 drivers/vfio/pci/pds/lm.h                      |   1 +
 drivers/vfio/pci/pds/pci_drv.c                 |  27 +-
 drivers/vfio/pci/pds/vfio_dev.c                |  45 +-
 drivers/vfio/pci/pds/vfio_dev.h                |   8 +-
 drivers/vfio/pci/vfio_pci_config.c             |  42 ++
 drivers/vfio/pci/vfio_pci_core.c               |  20 +-
 drivers/vfio/pci/vfio_pci_intrs.c              | 176 +++--
 drivers/vfio/pci/vfio_pci_rdwr.c               |  16 +-
 drivers/vfio/pci/virtio/main.c                 |  72 +-
 drivers/vfio/platform/vfio_amba.c              |   6 +-
 drivers/vfio/platform/vfio_platform.c          |   5 +-
 drivers/vfio/platform/vfio_platform_irq.c      | 105 ++-
 drivers/vfio/vfio_iommu_type1.c                |  12 -
 drivers/vfio/virqfd.c                          |  21 +
 include/linux/mlx5/mlx5_ifc.h                  |   5 +
 include/linux/mm.h                             |  14 +
 include/linux/vfio.h                           |   2 +
 include/linux/vfio_pci_core.h                  |  10 +-
 samples/vfio-mdev/mbochs.c                     |  18 +-
 samples/vfio-mdev/mdpy.c                       |  18 +-
 40 files changed, 1524 insertions(+), 462 deletions(-)
 create mode 100644 drivers/vfio/pci/nvgrace-gpu/Kconfig
 create mode 100644 drivers/vfio/pci/nvgrace-gpu/Makefile
 create mode 100644 drivers/vfio/pci/nvgrace-gpu/main.c


