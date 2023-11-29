Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603A27FDE97
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjK2RnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2RnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:43:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF0B5112;
        Wed, 29 Nov 2023 09:43:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC0E9143D;
        Wed, 29 Nov 2023 09:44:07 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC2023F73F;
        Wed, 29 Nov 2023 09:43:16 -0800 (PST)
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
Subject: [PATCH 1/7] OF: Retire dma-ranges mask workaround
Date:   Wed, 29 Nov 2023 17:42:58 +0000
Message-Id: <950378c6f39270a255452733ff2305e56fb05cc5.1701268753.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1701268753.git.robin.murphy@arm.com>
References: <cover.1701268753.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From what I remember, the fixup adding 1 to the dma-ranges size was for
the benefit of some early AMD Seattle DTs. Those are likely extinct by
now, and anyone else who might have deserved to get the message has
hopefully seen the warning in the 9 years we've had it there. The modern
dma_range_map mechanism should happily handle odd-sized ranges with no
ill effect, so there's little need to care anyway now. Clean it up.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/of/device.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 1ca42ad9dd15..526a42cdf66e 100644
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

