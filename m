Return-Path: <linux-kernel+bounces-151785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A498AB3D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246DF28240E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70D2139D05;
	Fri, 19 Apr 2024 16:55:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C511386D5;
	Fri, 19 Apr 2024 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545710; cv=none; b=FQiMmMAugQS72mr68fyTO3m/J2E+Ro1WHi6Vy3mNHNWvEVHAlg9GYVJD0CykkiGWUzgq4CPh0ghKCI27fvx+bn6iuiHDqHviGG2UPWYS2fAtEfFENK0JGAMpVgtCbwMdyRO46kfDRbP4rKrShvMaNx5dvhOBxlRnk0TFBIIVc2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545710; c=relaxed/simple;
	bh=78sazIr90PfD2p3pMcVPhdyFlfiEISIeaG+WW9mJPWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qe4XuGvtR8MrVTl7jCUOSmf7jt7YREVaLN/I9sG7FT6WIyXO16joRHOVz7mXM0ypfZJbNmM5Pk7nrxBSk4Q9rwjEHu7nKXF9qoQc0aJaRuR7VClgMZErekDAXhkJ5Gp2J6n38/KX1P+8c6lbjdjdeMg+kjFSm3Afo/BFV2K5EnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1CC7339;
	Fri, 19 Apr 2024 09:55:36 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB1F03F8A4;
	Fri, 19 Apr 2024 09:55:03 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: Joerg Roedel <joro@8bytes.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/7] OF: Retire dma-ranges mask workaround
Date: Fri, 19 Apr 2024 17:54:40 +0100
Message-Id: <26620039901fdae52079ec1c8a4b2b324964a13e.1713523152.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1713523152.git.robin.murphy@arm.com>
References: <cover.1713523152.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fixup adding 1 to the dma-ranges size may have been for the benefit
of some early AMD Seattle DTs, or may have merely been a just-in-case,
but either way anyone who might have deserved to get the message has
hopefully seen the warning in the 9 years we've had it there. The modern
dma_range_map mechanism should happily handle odd-sized ranges with no
ill effect, so there's little need to care anyway now. Clean it up.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
v2: Tweak commit message
---
 drivers/of/device.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index de89f9906375..a988bee2ee5a 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -129,22 +129,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 				dma_end = r->dma_start + r->size;
 		}
 		size = dma_end - dma_start;
-
-		/*
-		 * Add a work around to treat the size as mask + 1 in case
-		 * it is defined in DT as a mask.
-		 */
-		if (size & 1) {
-			dev_warn(dev, "Invalid size 0x%llx for dma-range(s)\n",
-				 size);
-			size = size + 1;
-		}
-
-		if (!size) {
-			dev_err(dev, "Adjusted size 0x%llx invalid\n", size);
-			kfree(map);
-			return -EINVAL;
-		}
 	}
 
 	/*
-- 
2.39.2.101.g768bb238c484.dirty


