Return-Path: <linux-kernel+bounces-95692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F351875151
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E413EB28077
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8C612DD96;
	Thu,  7 Mar 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L92Thyse"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10D712D779;
	Thu,  7 Mar 2024 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820354; cv=none; b=qRm6jKiLCpfF4j9Yu/eIHXUOjmT/9enuWgGPbcaFldSyo/Niw/mh6Dfd+Ga3JEJuhsU1AycZNwTCx60HIS9m8RsZJEz5+FIzHP+1q5OYIXbxRu7ndlzG2BjQeUv6LhzA4K5PkiwCKEtWRA+Muwti+bfcau6LU53HRekXMDvUy3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820354; c=relaxed/simple;
	bh=QmvXP9Hu5nQMu8timRycLMV4yMHoH9xYQ1ojjxc7l1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AfiwMH3dI+xOp73ITAZIHlfd/4YCo/UuUVDyz2RcRublH5QDC51mEmWIQfTjX5y6Vt5fXrl92vrv1PGMjuwb0D1AjH7F8yddwtUS6nV9vxhm4RmGqMDRXIkeKidsQ10noY/LdAacFWOpEaCEz8nEu2EI+4Em4Bz9xNTwJ24V/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L92Thyse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42183C433C7;
	Thu,  7 Mar 2024 14:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709820354;
	bh=QmvXP9Hu5nQMu8timRycLMV4yMHoH9xYQ1ojjxc7l1A=;
	h=From:To:Cc:Subject:Date:From;
	b=L92ThysecXPrRaTl+8PMNg6Y3rkUPTupoHok7Cvv28fFRlpeIbAFQ7tD6GMEaH7JM
	 9pY2yWdLxPv9GQySFPJcjGo8oqjwAuzwrQMlpHbZWjGNjGV8rlK7VGbjDp2G61lwCo
	 UYYI0pP4PaPe3ZeAvu134qePEIffPnGxQlCzUthWIumNhsHFEbqsCA3phrMHODR94l
	 B9wFf+/kZdV+WeFIHbWHq5pH2GOaQiUfRCglCU6D907fYkxojXfA6iROv/XCoFysRl
	 lnH/Ck0ijnFDRkmOKb68pLEJQs4Ez9BlsgFbLJHgdLV9Rce+R8aVUvPnzJrrpoy9mK
	 O6rrTjPXllfbA==
From: Arnd Bergmann <arnd@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ethan Zhao <haifeng.zhao@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: always select INTEL_IOMMU for IRQ_REMAP
Date: Thu,  7 Mar 2024 15:05:15 +0100
Message-Id: <20240307140547.2201713-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

CONFIG_INTR_REMAP was originally split out of the intel iommu code to be
shared by IRQ_REMAP. This recently broke again because the IRQ_REMAP
code calls the global device_rbtree_find() function that is unavailable
for builds without INTEL_IOMMU:

x86_64-linux-ld: vmlinux.o: in function `qi_submit_sync':
(.text+0x10771e0): undefined reference to `device_rbtree_find'

It seems that the intel iommu code now contains a lot of generic helper
functions that are not specific to intel, such as alloc_pgtable_page(),
iommu_flush_write_buffer(), domain_attach_iommu() etc, so presumably
it is not x86 specific any more.

Fix the build failure for now by just selectin INTEL_IOMMU by the
code that relies on it. It might be helpful to split out all the
functions without an intel_iommu_* prefix into a helper library
to avoid including the x86 specific bits on non-x86, but that could
be a follow-up.

Fixes: d3f138106b4b ("iommu: Rename the DMAR and INTR_REMAP config options")
Fixes: 80a9b50c0b9e ("iommu/vt-d: Improve ITE fault handling if target device isn't present")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Not sure about this one, I just ran across the build regression and
wasn't sure if the intel-iommu functions are meant to be generic
or just misnamed. The patch description assumes the former, if that
is wrong, it needs a different explanation or a different fix.
---
 drivers/iommu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index df156f0a1a17..da5339bdb7e7 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -196,6 +196,7 @@ config IRQ_REMAP
 	bool "Support for Interrupt Remapping"
 	depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
 	select DMAR_TABLE
+	select INTEL_IOMMU
 	help
 	  Supports Interrupt remapping for IO-APIC and MSI devices.
 	  To use x2apic mode in the CPU's which support x2APIC enhancements or
-- 
2.39.2


