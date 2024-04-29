Return-Path: <linux-kernel+bounces-162127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BFC8B5650
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6F11F221A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6882F3FB84;
	Mon, 29 Apr 2024 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfdCmGUm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E28D200D5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389436; cv=none; b=E/6/4B9pDAgkR7IZCBSjzKxvkUq+ZDj9s77nkoJ9Fqvl7jpv+It8Zz2gc65BGethtoZePVVX8k12vlYq7GUfsMcF2XX1H+HGjb+8jDCXbtn/8VzAxbfme3m5KvUULy0alRH16liIu7Colt1GftmB/+rq16QVxqzKz6xty/xwZHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389436; c=relaxed/simple;
	bh=1Eo88DNt750jucwhczOVgMrfucx591HLz2m0Oln95J0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GfO8sj/yMj+XbyTCllri2NQDyF3aerqWAFVB5Ladr+NiG8abaLR7V0qdabhgt2jVwGPPU97FlsjUk8ObYwdescEmUjUVn9u04TSvCpsf8VjaEgDHJVpz2HtS9Wkpq2m0pIo34eEfqo3zfRuVy36+bPYkiJj9jhNGVekTVF1z2QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfdCmGUm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714389435; x=1745925435;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1Eo88DNt750jucwhczOVgMrfucx591HLz2m0Oln95J0=;
  b=nfdCmGUmm9dvlieviyBpO0G8CeGb9YE/+JSClCrB4aRuaoRy+Zzmjwsz
   gk4Ajgv762RAIykKhw7SFNp7jvpd9foy/Xb2W2k5VovahwiFC5STvedYU
   AYqjxTpW6LV2ER9e2msYT3vz3vabuJSCkeapgo2LmHjS4DaipQkEjrntN
   UcqkU7cLrxrAmZgqJTWB6E3nbLNDpli9c39Tpqn6QbEDIMBIDANXjciSG
   Bnv9HDYcLfzTeRyi0Y5bnZVvhu88zdtzk1YDN+AYrcIyv/ph/XJh8682A
   WQNB218OyzbMpeu9B5UQjKIIchCmYg8tzW+lk2nr7T+PzaDUlkokoAC+x
   A==;
X-CSE-ConnectionGUID: ouWKRboGQrSD/+DcvADGFw==
X-CSE-MsgGUID: QAtTAfAQScSD2H2ud/KSXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="21459151"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="21459151"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 04:17:15 -0700
X-CSE-ConnectionGUID: jMiiwx0kSpu99QpjyGYENQ==
X-CSE-MsgGUID: PqfT1Ps6QFKeiwxu/lFwVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26701015"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 29 Apr 2024 04:17:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 041C215B; Mon, 29 Apr 2024 14:17:09 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Vasant Hegde <vasant.hegde@amd.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iommu/amd: Fix compilation error
Date: Mon, 29 Apr 2024 14:17:07 +0300
Message-ID: <20240429111707.2795194-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With WERROR=y, which is default, clang is not happy:

../amd/pasid.c:168:3: error: call to undeclared function 'mmu_notifier_unregister'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
../amd/pasid.c:191:8: error: call to undeclared function 'mmu_notifier_register'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
2 errors generated.

Select missed dependency.

Fixes: a5a91e54846d ("iommu/amd: Add SVA domain support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/amd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index 68d8fc107cb9..994063e5586f 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -7,6 +7,7 @@ config AMD_IOMMU
 	select PCI_ATS
 	select PCI_PRI
 	select PCI_PASID
+	select MMU_NOTIFIER
 	select IOMMU_API
 	select IOMMU_IOVA
 	select IOMMU_IO_PGTABLE
-- 
2.43.0.rc1.1336.g36b5255a03ac


