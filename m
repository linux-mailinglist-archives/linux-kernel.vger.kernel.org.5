Return-Path: <linux-kernel+bounces-151792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C915F8AB3EB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8721B281D5B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36D5137920;
	Fri, 19 Apr 2024 16:56:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01A6138483;
	Fri, 19 Apr 2024 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545783; cv=none; b=J+gk5/Itk7AF4HeYi+6HPikALHhpaTzj25lDLq1I+VCbfhBfaLsjA1fqUOvIYNovQoBg5eVccw/EucEo3+Ro4c2tre3woNuxr7fFqaHzYCLmEWalDbFuMB9WL0DQhsEbdBvMdeLIf6DxLXiP9uxY66ejvTiuRy6xoBj1+CUFZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545783; c=relaxed/simple;
	bh=6H9tNs5Z0RVvieO0Y7v9eYCru6tnL57CLmPNvVcHMu4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eAqdqIMSZAbPxxsP/45MjYq4fvwbLkvHs0U2FYxuVgBqeXC1xXHfXY3cJkDOh4JkdfBktMyy3z7DdUWJRuf9SsBYfp3ECRLiT6uGQ5eJWgWtqYCknhDfC5CGs0+FVNMScjK4kR59/JcFnM3ZJXd3ERenOV4hpQkxPI3dH06LwQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D3F1339;
	Fri, 19 Apr 2024 09:56:49 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1EA7A3F792;
	Fri, 19 Apr 2024 09:56:18 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 0/4] iommu: Remove iommu_fwspec ops
Date: Fri, 19 Apr 2024 17:55:58 +0100
Message-Id: <cover.1713523251.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

Building on top of the arch_setup_dma_ops() cleanup[1], the next step
down the chain is {acpi,of}_dma_configure()... There's plenty to do
here, but it may as well start with this fairly self-contained little
cleanup, pruning yet more redundancy and exposed API surface.

Thanks,
Robin.

[1] https://lore.kernel.org/linux-iommu/cover.1713523152.git.robin.murphy@arm.com


Robin Murphy (4):
  iommu: Resolve fwspec ops automatically
  ACPI: Retire acpi_iommu_fwspec_ops()
  OF: Simplify of_iommu_configure()
  iommu: Remove iommu_fwspec ops

 drivers/acpi/arm64/iort.c             | 19 +++-------
 drivers/acpi/scan.c                   | 38 +++++---------------
 drivers/acpi/viot.c                   | 11 ++----
 drivers/iommu/arm/arm-smmu/arm-smmu.c |  3 +-
 drivers/iommu/iommu-priv.h            |  7 ++++
 drivers/iommu/iommu.c                 | 20 +++++------
 drivers/iommu/mtk_iommu_v1.c          |  2 +-
 drivers/iommu/of_iommu.c              | 50 ++++++++++-----------------
 drivers/iommu/tegra-smmu.c            |  2 +-
 drivers/of/device.c                   | 30 ++++++----------
 include/acpi/acpi_bus.h               |  3 +-
 include/linux/iommu.h                 | 15 ++------
 12 files changed, 66 insertions(+), 134 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty


