Return-Path: <linux-kernel+bounces-63290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13044852D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C281F2884F6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E682BB08;
	Tue, 13 Feb 2024 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szljOOS0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86D42BB01;
	Tue, 13 Feb 2024 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818319; cv=none; b=as3HTdFl/C5+Kku1WksYsb6t7M66PgzNB1zrluky5rdP7EkwhsaHgYLfuGj7CCDAEDQmgkqPR58A88NqbqKITRKA1d8vflfFNQ0Ex46nTU/LiCAFNqyArjAFQtnsNhGBg+o26w1gaeoL48wjGIXODRV/GKk0+Ertq4ucjV5I0hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818319; c=relaxed/simple;
	bh=zRzb7KQv3xRBZo9WYphp8IEg9VdrU4vqON6031OOSn0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=THw1qx+0ACLbCG2ZKKzV1S50hfBDyiRsmV3RBH3/DHV+mmHn/82SngqEmcPyyKZxUdbJp4DrAguYv5Me+r0Zx6QpVFtfumAMi0ZCVw3QE2evhaUIxntIPfQhDFkXcrBROF6JiMWAApktMbT7jWoTJZnpbXtz/R+FyoVmiOFu1qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szljOOS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF023C433C7;
	Tue, 13 Feb 2024 09:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707818319;
	bh=zRzb7KQv3xRBZo9WYphp8IEg9VdrU4vqON6031OOSn0=;
	h=From:To:Cc:Subject:Date:From;
	b=szljOOS0X5reBC/rEedA3Pp3GuGD4SQq7ebT+rhQK6CV0qKApjF0nrIt7hVDh42mv
	 t3NOycP/SJhpr9wfFtjQcbzaMYE51opx1y56z0RLNyt0Z4U7HN0ndRt/FN5x+y2ORN
	 UzHqEE8V0ejjXSLZ7C4JkeGM/4m+1AzEZnTvFAMTZGOe3luBtOeFPBrhyFO4LtnA9a
	 RxrBis7RD+0EFrCTQsVevCGgs2PyqM53/46X+j1X9wlqeq66uhtVEh/MrszBBR+bzW
	 HEuRulOJ3NDV22pnID7xB9KDaeQpVIbTY3KWvIoo82UA94AIKDBR7WjXJ+9AONr8Yf
	 /8wBUR0r4oOQA==
From: Arnd Bergmann <arnd@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] iommu/vt-d: fix constant-out-of-range warning
Date: Tue, 13 Feb 2024 10:58:20 +0100
Message-Id: <20240213095832.455245-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

On 32-bit builds, the vt-d driver causes a warning with clang:

drivers/iommu/intel/nested.c:112:13: error: result of comparison of constant 18446744073709551615 with expression of type 'unsigned long' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
  112 |         if (npages == U64_MAX)
      |             ~~~~~~ ^  ~~~~~~~

This can be easily avoided by making the variable a 64-bit type, which matches
both the caller and the use anyway.

Fixes: f6f3721244a8 ("iommu/vt-d: Add iotlb flush for nested domain")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/intel/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index f26c7f1c46cc..77a09c982979 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -95,7 +95,7 @@ static void nested_flush_dev_iotlb(struct dmar_domain *domain, u64 addr,
 }
 
 static void intel_nested_flush_cache(struct dmar_domain *domain, u64 addr,
-				     unsigned long npages, bool ih)
+				     u64 npages, bool ih)
 {
 	struct iommu_domain_info *info;
 	unsigned int mask;
-- 
2.39.2


