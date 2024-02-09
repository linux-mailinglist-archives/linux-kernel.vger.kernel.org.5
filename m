Return-Path: <linux-kernel+bounces-59673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB9984FA36
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8407528EC09
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5971D80C1D;
	Fri,  9 Feb 2024 16:50:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C89B80BF6;
	Fri,  9 Feb 2024 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497429; cv=none; b=lNPfiRL9YA0mAN9VSOrb2pgvGAA9QwQUeJwfdkRSXYoiJnxhDG2COqIgacr50vaXw7a2k/rwm7rcivDB+H+gJtE2tG4e79JADmwg9KcdXE+bMuXizEuE+84OC3/CscvWifvzZn3+X+METq2cT9GNZOie9uStF3swImGYiHmfiVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497429; c=relaxed/simple;
	bh=78sazIr90PfD2p3pMcVPhdyFlfiEISIeaG+WW9mJPWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K2WZeKe83pXGBZ7MtnW/o91asr+8l4CXVtnv4xMNS1VZXNKtBFIq05eiGdKHykBaFqrtaBJ0SCoMbAukssgNJ8YGXy+fK2056kOgqHxxth1ly4AZ1lhOo57QW0cXGKzjSQL+LID9+YkdX7NIW8OJfrxDP4+hBIP+MnHEP1WTtMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A64EFFEC;
	Fri,  9 Feb 2024 08:51:08 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D0E8C3F64C;
	Fri,  9 Feb 2024 08:50:22 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: 
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
Subject: [PATCH v3 1/7] OF: Retire dma-ranges mask workaround
Date: Fri,  9 Feb 2024 16:49:58 +0000
Message-Id: <3d759722a5bd898dc5736048b4a5f30689c33888.1707493264.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1707493264.git.robin.murphy@arm.com>
References: <cover.1707493264.git.robin.murphy@arm.com>
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


