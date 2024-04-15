Return-Path: <linux-kernel+bounces-144724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17C58A49BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3C8285962
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175E337719;
	Mon, 15 Apr 2024 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="LeEyAzdY"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABE937142
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168265; cv=none; b=dzOFF8qOKdy9UWE6Bixxe5R+WuTHCxSVj9h8tlxnDvfC1xOcHizmCCWPZuZ32kb159JvtNxedHhTrTkFxjglxWTt4hw+r5zrvyczszz4Sm8JzO2zq7tfWWfKTeT8c0ltXh1sfc8aocUNiiSKdp1tBG/5YKSb9wt2nP8dXr8FDeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168265; c=relaxed/simple;
	bh=+MLwVfz9rwOIvL4WZTuJ04Fbom+ZhHool4fp3bvKc7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLt+uJmwAghUAYRBO+zSwh+WncJ3ZOhRi/lDoSdqWisC9Dw4QIFFnCtVcMtR+OHpWMehNe8HgaA7BvYu3+M9kvwvKMUALIdyztYFRVVA3EX5Gl/HbPEFyh9maXVGLCL7gTzHA/ZIas0ex9CGm2mVLcyg7JOwfMtkOGWxJyoMlLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=LeEyAzdY; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 53B381C6467;
	Mon, 15 Apr 2024 10:04:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1713168254;
	bh=+MLwVfz9rwOIvL4WZTuJ04Fbom+ZhHool4fp3bvKc7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LeEyAzdYwcq13HRMYuqXIIyo9/ut460vfm8roz0F/7rfRnwTWxQvRp0dhWHcb3I8d
	 eamrRXPMFtjbMGiMyBSN2eO0uqNSDE1zcpRcGCiSaQ4ylYFbgh/w8DE4tqr6UYZ/qa
	 owo9e8tiJUi8yJjpxZQxG1UI+D9ZzVn+mUmhyMrVOwuHb5JPLKv8BuzXgAxG12IgdG
	 XlYD8h50fPB00iwvMbFyNsyViyYR+EHauP6cjJ76BHGXFGPyPAIvzKceDY2FeLKzyq
	 qQ2YKYWgDzdK5xvlJ9f3/QODFaJ62YwJWx/gMQ/t3a6pHhCBbYQ775DNXKRLQH5sa7
	 naM62itJcs1gg==
Date: Mon, 15 Apr 2024 10:04:13 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Eric Wagner <ewagner12@gmail.com>
Cc: Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
Message-ID: <ZhzffQM5YA7HxzSX@8bytes.org>
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>

Also adding Vasant.
On Sat, Apr 13, 2024 at 06:04:12PM -0400, Eric Wagner wrote:
> On my Thinkpad T14s G3 AMD (Ryzen 7 6850U) laptop connected to an AMD RX 580 in
> Akitio Node Thunderbolt 3 eGPU. Booting with the eGPU connected hangs on
> kernels 6.7 and 6.8, but worked on 6.6. For debugging, I find that adding the
> kernel parameter amd_iommu=off seems to fix the issue and allows booting with
> the eGPU on 6.7.

Do you have any way of getting the boot log of the hang? It is hard to
debug this without further data on where it hang and what happens
before.

Regards,

	Joerg

> 
> I tried bisecting the issue between 6.6 and 6.7 and ended up with:
> "e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2 is the first bad commit" in the
> attached. This seems to indicate an amd iommu issue.
> 
> Two others also reported the same issue on AMD Ryzen 7 7840 with AMD RX 6000
> connected as eGPU (https://gitlab.freedesktop.org/drm/amd/-/issues/3182).
> 
> Let me know if you need more information.

> Bisecting: 366 revisions left to test after this (roughly 9 steps)
> [74e9347ebc5be452935fe4f3eddb150aa5a6f4fe] Merge tag 'loongarch-fixes-6.6-3' of git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson
> Bisecting: 182 revisions left to test after this (roughly 8 steps)
> [f6176471542d991137543af2ef1c18dae3286079] Merge tag 'mtd/fixes-for-6.6-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
> Bisecting: 87 revisions left to test after this (roughly 7 steps)
> [fe3cfe869d5e0453754cf2b4c75110276b5e8527] Merge tag 'phy-fixes-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy
> Bisecting: 43 revisions left to test after this (roughly 6 steps)
> [c76c067e488ccd55734c3e750799caf2c5956db6] s390/pci: Use dma-iommu layer
> Bisecting: 27 revisions left to test after this (roughly 5 steps)
> [aa5cabc4ce8e6b45d170d162dc54b1bac1767c47] Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
> Bisecting: 14 revisions left to test after this (roughly 4 steps)
> [bbc70e0aec287e164344b1a071bd46466a4f29b3] iommu/dart: Remove the force_bypass variable
> Bisecting: 9 revisions left to test after this (roughly 3 steps)
> [e82c175e63229ea495a0a0b5305a98b5b6ee5346] Revert "iommu/vt-d: Remove unused function"
> Bisecting: 5 revisions left to test after this (roughly 2 steps)
> [92bce97f0c341d3037b0f364b6839483f6a41cae] s390/pci: Fix reset of IOMMU software counters
> Bisecting: 3 revisions left to test after this (roughly 2 steps)
> [3613047280ec42a4e1350fdc1a6dd161ff4008cc] Merge tag 'v6.6-rc7' into core
> Bisecting: 2 revisions left to test after this (roughly 1 step)
> [f7da9c081517daba70f9f9342e09d7a6322ba323] iommu/tegra-smmu: Drop unnecessary error check for for debugfs_create_dir()
> Bisecting: 1 revision left to test after this (roughly 1 step)
> [9e13ec61de2a51195b122a79461431d8cb99d7b5] iommu/virtio: Add __counted_by for struct viommu_request and use struct_size()
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3] iommu: Avoid unnecessary cache invalidations
> e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2 is the first bad commit
> commit e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2
> Merge: 6e6c6d6bc6 f7da9c0815 aa5cabc4ce 9e13ec61de e82c175e63 cedc811c76 3613047280 92bce97f0c
> Author: Joerg Roedel <jroedel@suse.de>
> Date:   Fri Oct 27 09:13:40 2023 +0200
> 
>     Merge branches 'iommu/fixes', 'arm/tegra', 'arm/smmu', 'virtio', 'x86/vt-d', 'x86/amd', 'core' and 's390' into next
> 
>  Documentation/admin-guide/kernel-parameters.txt    |   9 +-
>  .../devicetree/bindings/iommu/arm,smmu.yaml        |   2 +
>  arch/arm/configs/multi_v7_defconfig                |   1 -
>  arch/arm/configs/tegra_defconfig                   |   1 -
>  arch/powerpc/kernel/iommu.c                        |  53 +-
>  arch/s390/include/asm/pci.h                        |  11 -
>  arch/s390/include/asm/pci_clp.h                    |   3 +
>  arch/s390/include/asm/pci_dma.h                    | 121 +--
>  arch/s390/pci/Makefile                             |   2 +-
>  arch/s390/pci/pci.c                                |  35 +-
>  arch/s390/pci/pci_bus.c                            |   5 -
>  arch/s390/pci/pci_debug.c                          |  12 +-
>  arch/s390/pci/pci_dma.c                            | 746 ---------------
>  arch/s390/pci/pci_event.c                          |  17 +-
>  arch/s390/pci/pci_sysfs.c                          |  19 +-
>  drivers/iommu/Kconfig                              |  15 +-
>  drivers/iommu/Makefile                             |   1 -
>  drivers/iommu/amd/Kconfig                          |   9 -
>  drivers/iommu/amd/Makefile                         |   1 -
>  drivers/iommu/amd/amd_iommu.h                      |  35 +-
>  drivers/iommu/amd/amd_iommu_types.h                |  52 +-
>  drivers/iommu/amd/init.c                           | 117 +--
>  drivers/iommu/amd/io_pgtable_v2.c                  |   8 +-
>  drivers/iommu/amd/iommu.c                          | 577 +++++-------
>  drivers/iommu/amd/iommu_v2.c                       | 996 ---------------------
>  drivers/iommu/apple-dart.c                         | 138 +--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  71 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 251 +++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  17 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   2 +
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c            |  45 +-
>  drivers/iommu/dma-iommu.c                          | 200 ++++-
>  drivers/iommu/exynos-iommu.c                       |  83 +-
>  drivers/iommu/fsl_pamu_domain.c                    |  41 +-
>  drivers/iommu/intel/debugfs.c                      | 215 ++++-
>  drivers/iommu/intel/iommu.c                        |  19 +-
>  drivers/iommu/intel/iommu.h                        |  14 +
>  drivers/iommu/iommu.c                              | 455 +++++-----
>  drivers/iommu/iommufd/selftest.c                   |  30 +-
>  drivers/iommu/iova.c                               |  95 +-
>  drivers/iommu/ipmmu-vmsa.c                         |  72 +-
>  drivers/iommu/msm_iommu.c                          |  35 +-
>  drivers/iommu/mtk_iommu.c                          |  35 +-
>  drivers/iommu/mtk_iommu_v1.c                       |  28 +-
>  drivers/iommu/omap-iommu.c                         |  69 +-
>  drivers/iommu/omap-iommu.h                         |   2 +-
>  drivers/iommu/rockchip-iommu.c                     |  59 +-
>  drivers/iommu/s390-iommu.c                         | 424 ++++++++-
>  drivers/iommu/sprd-iommu.c                         |  36 +-
>  drivers/iommu/sun50i-iommu.c                       |  80 +-
>  drivers/iommu/tegra-gart.c                         | 371 --------
>  drivers/iommu/tegra-smmu.c                         |  58 +-
>  drivers/iommu/virtio-iommu.c                       |   4 +-
>  drivers/memory/tegra/mc.c                          |  34 -
>  drivers/memory/tegra/tegra20.c                     |  28 -
>  include/linux/amd-iommu.h                          | 120 ---
>  include/linux/iommu.h                              |  38 +-
>  include/soc/tegra/mc.h                             |  26 -
>  58 files changed, 2138 insertions(+), 3905 deletions(-)
>  delete mode 100644 arch/s390/pci/pci_dma.c
>  delete mode 100644 drivers/iommu/amd/iommu_v2.c
>  delete mode 100644 drivers/iommu/tegra-gart.c


