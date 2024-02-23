Return-Path: <linux-kernel+bounces-78251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8A68610CC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D0BAB24AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5437AE71;
	Fri, 23 Feb 2024 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kv74LwEM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C537A71E;
	Fri, 23 Feb 2024 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689049; cv=none; b=Kraqg2fzLIEenRj2kw+QDxyA6nsrQX5H0lm8Ao1ROqyN1VfZD+Ar23IR2yvP3eGis/kBzMDngGLG9cKe8l9J1qcoMuN9d0BJfvxj0pUm0yVAJo6Qu5evmjxdSkuybfleqa9rC9HRiOririxYgOS5cmsumnbAgAkQZD7Rh/iDOoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689049; c=relaxed/simple;
	bh=w6qT2LiU2ag3cn1TULdm+kq1WVmzxUh3rh8IbQLvE6M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dyZSzcn/p6mMO2oUeBxx4llsYqh/vzGYra5L6RVzK+2+kn1DGX0zO2fxt7lCQyLGKAKh9XItcJesWict6fshz6M48ofUxr3mK2lX6TScvktsv/EyFwfegKwh5fsnZ5jwUAaeOLoGH4zjAzlEF0dwns1jHgwlGYFNLKZC9lL5bl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kv74LwEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388A5C433F1;
	Fri, 23 Feb 2024 11:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708689048;
	bh=w6qT2LiU2ag3cn1TULdm+kq1WVmzxUh3rh8IbQLvE6M=;
	h=Date:From:To:Cc:Subject:From;
	b=Kv74LwEMVGf3Toz6Feh2ACfSSwcj2nd8HgmEutjUYKViJzjvsAYSB2pNoRNHBXFG+
	 1jxcF2RqQTSiZ9NdAzF8cOBQEuplKFX1KxPhbH8BoE9A2qGnIbz77wWZAZ6VkkTaMl
	 XePBsdb9c3ur2HTVKqMHCg4yh1748wWYZSggQ5Pe0bK5bm7GEedox7p8w9E+aNLR/J
	 AZP47c+c1Z4OzmFlu8nY6tvERPJ6pMw5Ys8km3vW7DTWoKTMOl+OVzPvzst/iJ2riX
	 nKVUpTC8lSI0zDfeoRI+5nQdfzamaY/KUVJnB6EDX3ccngPCbiiDjUt4H3VVrpu46Y
	 3jW8sTcs17AYg==
Date: Fri, 23 Feb 2024 11:50:43 +0000
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 6.8-rc
Message-ID: <20240223115043.GA10608@willie-the-truck>
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

Please can you pull these two Arm SMMU fixes for 6.8-rc? I appreciate
it's getting late in the cycle, but it took us a little while to fix the
SVA allocation problem properly. The summary is in the tag.

I'll send you my 6.9 queue next week and it will be based on these
fixes.

Cheers,

Will

--->8

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-fixes

for you to fetch changes up to b5bf7778b722105d7a04b1d51e884497b542638b:

  iommu/arm-smmu-v3: Do not use GFP_KERNEL under as spinlock (2024-02-22 12:34:11 +0000)

----------------------------------------------------------------
Arm SMMU fixes for 6.8

- Fix CD allocation from atomic context when using SVA with SMMUv3

- Revert the conversion of SMMUv2 to domain_alloc_paging(), as it
  breaks the boot for Qualcomm MSM8996 devices

----------------------------------------------------------------
Dmitry Baryshkov (1):
      Revert "iommu/arm-smmu: Convert to domain_alloc_paging()"

Jason Gunthorpe (1):
      iommu/arm-smmu-v3: Do not use GFP_KERNEL under as spinlock

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 38 ++++++++-----------------
 drivers/iommu/arm/arm-smmu/arm-smmu.c           | 17 ++++-------
 2 files changed, 18 insertions(+), 37 deletions(-)

