Return-Path: <linux-kernel+bounces-35035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE6F838ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14E628B7E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B7E5D912;
	Tue, 23 Jan 2024 09:46:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2115D904;
	Tue, 23 Jan 2024 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003202; cv=none; b=YKTn0yocqvW1Q01+RbK4NMO8SNCKOpNf9N9vyxKR+9Owwndkggh1VNO4JbK/pIfHw8PlTugqgOWgVvnp7/KT6OmqF+4nyCJnNjifQ2xvAGubU3k3po35vPH2ksYhOFWmyhYdt6qjxdOQWmSyckOsJHcR2ki2EpVZZSqRwpJP3p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003202; c=relaxed/simple;
	bh=Xz5yCHNx8CJHFlmKFK8Vb+xsWX06h3/wC41N3TUgGoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEMSABVnUFocAb35VOk1RpchEE/7l8klhZTR4KOtEL4TdvED+7yBszJTqN19cZum1AtaVEEJvApYrdw4lhopREmM6mrWZRHY6a8hzRWwrerL2Kk1X0f1O7HE8IN4cYgcO68O86NhjwZ8loHVJbVtaWd07hZw1Q/oqQMFZZqMRUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 531941FB;
	Tue, 23 Jan 2024 01:47:25 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.48.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDB753F5A1;
	Tue, 23 Jan 2024 01:46:38 -0800 (PST)
Date: Tue, 23 Jan 2024 09:46:35 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/82] overflow: Refactor open-coded arithmetic
 wrap-around
Message-ID: <Za-K-3aSBULf4NWE@FVFF77S0Q05N>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122235208.work.748-kees@kernel.org>

On Mon, Jan 22, 2024 at 04:26:35PM -0800, Kees Cook wrote:
> Hi,

Hi Kees,

> In our continuing effort to eliminate root causes of flaws in the kernel,
> this series is the start to providing a way to have sensible coverage
> for catching unexpected arithmetic wrap-around.
> 
> A quick word on language: while discussing[1] the finer details of
> the C standard's view on arithmetic, I was disabused of using the term
> "overflow" when what I really mean is "wrap-around". When describing
> security vulnerabilities, "overflow" is the common term and often used
> interchangeably with "wrap-around". Strictly speaking, though, "overflow"
> applies only to signed[2] and pointer[3] types, and "wrap-around" is for
> unsigned[4]. An arithmetic "overflow" is considered undefined behavior,
> which has caused our builds pain in the past, since "impossible"
> conditions might get elided by the compiler. As a result, we build
> with -fno-strict-overflow which coverts all "overflow" conditions into
> "wrap-around" (i.e. 2s complement), regardless of type.
> 
> All this is to say I am discussing arithmetic wrap-around, which is
> the condition where the value exceeds a type's maximum value (or goes
> below its minimum value) and wraps around. I'm not interested in the
> narrow definition of "undefined behavior" -- we need to stamp out the
> _unexpected_ behavior, where the kernel operates on a pathological value
> that wrapped around without the code author's intent.

With that in mind, I note that this patch primarily modifies addition
operations, but leaves subtraction operations unchanged (even though those
permit the value to go below the minimum, or above the maximum if a negative
value is used as the subtrahend).

Shouldn't we address both at the same time? I'll note that in many places the
same logic is used for both the add and sub, and can legitimately overflow or
underflow; I hope that whatever we use to suppress overflow warnings also
ignores underflow.

[...]

Looking at the diffstat, I think you've missed a few places:

>  Documentation/process/deprecated.rst          | 36 ++++++++
>  arch/arc/kernel/unwind.c                      |  7 +-
>  arch/arm/nwfpe/softfloat.c                    |  2 +-
>  arch/arm64/include/asm/atomic_lse.h           |  8 +-
>  arch/arm64/include/asm/stacktrace/common.h    |  2 +-
>  arch/arm64/kvm/vgic/vgic-kvm-device.c         |  6 +-
>  arch/arm64/kvm/vgic/vgic-mmio-v3.c            |  2 +-
>  arch/arm64/kvm/vgic/vgic-v2.c                 | 10 ++-
>  arch/m68k/kernel/sys_m68k.c                   |  5 +-
>  arch/nios2/kernel/sys_nios2.c                 |  2 +-
>  arch/powerpc/platforms/powernv/opal-prd.c     |  2 +-
>  arch/powerpc/xmon/xmon.c                      |  2 +-
>  arch/s390/include/asm/stacktrace.h            |  6 +-
>  arch/s390/kernel/machine_kexec_file.c         |  5 +-
>  arch/s390/mm/gmap.c                           |  4 +-
>  arch/s390/mm/vmem.c                           |  2 +-
>  arch/sh/kernel/sys_sh.c                       |  2 +-
>  arch/x86/include/asm/atomic.h                 |  2 +-
>  arch/x86/kernel/cpu/sgx/ioctl.c               |  6 +-
>  arch/x86/kvm/svm/sev.c                        |  5 +-
>  crypto/adiantum.c                             |  2 +-
>  drivers/acpi/custom_method.c                  |  2 +-
>  drivers/char/agp/generic.c                    |  2 +-
>  drivers/crypto/amcc/crypto4xx_alg.c           |  2 +-
>  drivers/crypto/axis/artpec6_crypto.c          |  2 +-
>  drivers/dma-buf/dma-buf.c                     |  7 +-
>  drivers/fpga/dfl.c                            |  5 +-
>  drivers/fsi/fsi-core.c                        |  6 +-
>  drivers/gpu/drm/i915/i915_vma.c               |  2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c |  8 +-
>  drivers/gpu/drm/vc4/vc4_validate.c            |  7 +-
>  drivers/md/dm-switch.c                        |  2 +-
>  drivers/md/dm-verity-target.c                 |  2 +-
>  drivers/md/dm-writecache.c                    |  2 +-
>  drivers/net/ethernet/sun/niu.c                |  5 +-
>  drivers/net/wireless/ath/wil6210/wmi.c        |  2 +-
>  drivers/net/wireless/marvell/mwifiex/pcie.c   |  6 +-
>  drivers/net/xen-netback/hash.c                |  2 +-
>  drivers/pci/pci.c                             |  2 +-
>  drivers/remoteproc/pru_rproc.c                |  2 +-
>  drivers/remoteproc/remoteproc_elf_loader.c    |  2 +-
>  drivers/remoteproc/remoteproc_virtio.c        |  4 +-
>  drivers/scsi/mpt3sas/mpt3sas_ctl.c            |  2 +-
>  drivers/scsi/sd_zbc.c                         |  2 +-
>  drivers/staging/vme_user/vme.c                |  2 +-
>  drivers/vhost/vringh.c                        |  8 +-
>  drivers/virtio/virtio_pci_modern_dev.c        |  4 +-
>  fs/aio.c                                      |  2 +-
>  fs/bcachefs/bkey.c                            |  4 +-
>  fs/bcachefs/fs.c                              |  2 +-
>  fs/bcachefs/quota.c                           |  2 +-
>  fs/bcachefs/util.c                            |  2 +-
>  fs/btrfs/extent_map.c                         |  6 +-
>  fs/btrfs/extent_map.h                         |  6 +-
>  fs/btrfs/ordered-data.c                       |  2 +-
>  fs/ext4/block_validity.c                      |  2 +-
>  fs/ext4/extents.c                             |  5 +-
>  fs/ext4/resize.c                              |  2 +-
>  fs/f2fs/file.c                                |  2 +-
>  fs/f2fs/verity.c                              |  2 +-
>  fs/hpfs/alloc.c                               |  2 +-
>  fs/ntfs3/record.c                             |  4 +-
>  fs/ocfs2/resize.c                             |  2 +-
>  fs/read_write.c                               |  8 +-
>  fs/remap_range.c                              |  2 +-
>  fs/select.c                                   | 13 +--
>  fs/smb/client/readdir.c                       |  5 +-
>  fs/smb/client/smb2pdu.c                       |  4 +-
>  fs/udf/balloc.c                               |  4 +-
>  include/linux/compiler_types.h                | 29 +++++-

This misses the include/asm-generic/{atomic,atomic64}.h implementations.

This also misses the include/linux/atomic/atomic-arch-fallback.h
implementations. Those are generated from the scripts/atomic/fallbacks/*
templates, and you'll need to adjust at least fetch_add_unless and
inc_unless_negative. As noted on other patches, my preference is to use
add_wrap() in those.

>  include/linux/overflow.h                      | 76 +++++++++++++++-
>  ipc/mqueue.c                                  |  2 +-
>  ipc/shm.c                                     |  6 +-
>  kernel/bpf/verifier.c                         | 12 +--
>  kernel/time/timekeeping.c                     |  2 +-
>  lib/Kconfig.ubsan                             | 27 ++++++

This misses lib/atomic64.c.

Thanks,
Mark.

