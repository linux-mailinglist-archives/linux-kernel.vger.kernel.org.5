Return-Path: <linux-kernel+bounces-121810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901AB88EE01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22AC1C33248
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97E315216D;
	Wed, 27 Mar 2024 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlHQ0Wea"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2168F14F132;
	Wed, 27 Mar 2024 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563197; cv=none; b=hGH6iDmCQr637V3eIBGn5sCucyN5Ed5K2Wsagy3AC0gHVHjczJqhaBQvIZR7zpAgQqHOxjQRlK7ZyXen2eRNifpYAGnn++uOdTkq873zcKZJprPN81An64FQ+8M+uRuemUJHWLqNqVGFxlzhSn6BoHa12e79Q9VwK6k1y4vHCaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563197; c=relaxed/simple;
	bh=1oQauAsz2Xnr3w+55kHK8a6MSov9FoxCkKWlD/KJt/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RC2BfuPlsJoloVZ38RhIusxuLLKcaLvR1t4ixQSz8NQ6t+rRPxYaDumSr4ZlSutE9MeTBtT/j0XnLIuFPlrRPWcBo5MXfj7s+qGkvtUN/CNuJXH3wiRICVmsO1VRWtBY1woBYmH2T8giyoioouJomDXIw7syKbhtHJAcWh3lCG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlHQ0Wea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F7EC433F1;
	Wed, 27 Mar 2024 18:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711563197;
	bh=1oQauAsz2Xnr3w+55kHK8a6MSov9FoxCkKWlD/KJt/Y=;
	h=Date:From:To:Cc:Subject:From;
	b=BlHQ0WeaUMZj7c9CYmyin7Wd8hz3FnAgd/M3AzUluMPD/i8QOQXMmSCUNbhdilCi9
	 EU4PX3mRl+TqILqySRznATsIXOkadNT8oonXNG57PG1i7bkDcjTnso0hS//0vkZjuj
	 YIdm2lyKaH8EAt/p86jqgAUIAejF1OJJK2AocBTDaiTdKOG2fMbSCMS/ThTm0j68/y
	 /ANnI8IcyloULiB9cKvz9tFzfG7NePIRgpedZJnR4NxTEoB2zLk8aGQP/4cVlDM5G9
	 SvUpHbZ12ANYHvSw5GCuI2QQD1/oxtG3NMqWs8nKU4lOgCQ6J01kyxpI4GM8ZB0Dqg
	 wyIK9r1xHXDGA==
Date: Wed, 27 Mar 2024 18:13:11 +0000
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 6.9-rc
Message-ID: <20240327181310.GA11801@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Joerg,

Please can you pull these two Arm SMMUv3 fixes for an upcoming 6.9 -rc?
One of them fixes a regression on big-endian machines that was
introduced during the recent merge window, whereas the other fixes a
longer standing bug for hardware that doesn't implement attribute
overrides.

Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-fixes

for you to fetch changes up to ec9098d6bffea6e82d63640134c123a3d96e0781:

  iommu/arm-smmu-v3: Fix access for STE.SHCFG (2024-03-26 10:47:39 +0000)

----------------------------------------------------------------
Arm SMMU fixes for 6.9

- Fix swabbing of the STE fields in the unlikely event of running on a
  big-endian machine.

- Fix setting of STE.SHCFG on hardware that doesn't implement support
  for attribute overrides.

----------------------------------------------------------------
Jason Gunthorpe (1):
      iommu/arm-smmu-v3: Add cpu_to_le64() around STRTAB_STE_0_V

Mostafa Saleh (1):
      iommu/arm-smmu-v3: Fix access for STE.SHCFG

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 38 +++++++++++++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
 2 files changed, 27 insertions(+), 13 deletions(-)

