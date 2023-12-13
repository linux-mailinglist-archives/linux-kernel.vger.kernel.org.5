Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BD6811AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378885AbjLMRSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMRSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:18:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8AFCD0;
        Wed, 13 Dec 2023 09:18:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94D6AC15;
        Wed, 13 Dec 2023 09:19:07 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A331C3F762;
        Wed, 13 Dec 2023 09:18:17 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>
Cc:     Vineet Gupta <vgupta@kernel.org>,
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
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
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
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: [PATCH v2 0/7] dma-mapping: Simplify arch_setup_dma_ops()
Date:   Wed, 13 Dec 2023 17:17:53 +0000
Message-Id: <cover.1702486837.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1: https://lore.kernel.org/linux-iommu/cover.1701268753.git.robin.murphy@arm.com/

Hi all,

Here's v2 with a few tweaks and fixes to address review comments, a
couple of major issues fixed in the last two patches that I really
should have spotted initially, plus a bit more code deletion that I
realised could fit in this step. I've left it tagged as a dma-mapping
series since spiritually it still is, but it looks like it will want
to go via the IOMMU tree.

Thanks,
Robin.


Robin Murphy (7):
  OF: Retire dma-ranges mask workaround
  OF: Simplify DMA range calculations
  ACPI/IORT: Handle memory address size limits as limits
  dma-mapping: Add helpers for dma_range_map bounds
  iommu/dma: Make limit checks self-contained
  iommu/dma: Centralise iommu_setup_dma_ops()
  dma-mapping: Simplify arch_setup_dma_ops()

 arch/arc/mm/dma.c               |  3 +--
 arch/arm/mm/dma-mapping-nommu.c |  3 +--
 arch/arm/mm/dma-mapping.c       | 18 +++++++-------
 arch/arm64/mm/dma-mapping.c     |  5 +---
 arch/loongarch/kernel/dma.c     |  9 ++-----
 arch/mips/mm/dma-noncoherent.c  |  3 +--
 arch/riscv/mm/dma-noncoherent.c |  3 +--
 drivers/acpi/arm64/dma.c        | 17 ++++---------
 drivers/acpi/arm64/iort.c       | 20 ++++++++--------
 drivers/acpi/scan.c             |  3 +--
 drivers/hv/hv_common.c          |  6 +----
 drivers/iommu/amd/iommu.c       |  8 -------
 drivers/iommu/dma-iommu.c       | 39 ++++++++++++------------------
 drivers/iommu/dma-iommu.h       | 14 +++++------
 drivers/iommu/intel/iommu.c     |  7 ------
 drivers/iommu/iommu.c           |  6 ++---
 drivers/iommu/s390-iommu.c      |  6 -----
 drivers/iommu/virtio-iommu.c    | 10 --------
 drivers/of/device.c             | 42 ++++++---------------------------
 include/linux/acpi_iort.h       |  4 ++--
 include/linux/dma-direct.h      | 18 ++++++++++++++
 include/linux/dma-map-ops.h     |  6 ++---
 include/linux/iommu.h           |  7 ------
 23 files changed, 86 insertions(+), 171 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

