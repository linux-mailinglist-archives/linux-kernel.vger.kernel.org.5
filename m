Return-Path: <linux-kernel+bounces-58027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7270884E066
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D021C26133
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709B771B2E;
	Thu,  8 Feb 2024 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/Dt3l7y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB296F535;
	Thu,  8 Feb 2024 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394217; cv=none; b=fLdN3pi+E0lQXVF/TmIxguhypqL+GAqLnOfQmH4e8e6bKme5CM64wHYzNAxz+ka1U8Faswlz7o1pK0KDs3t4i0Lo0lyuuYq/dUTi4rhEoR2702zIYprmPfB7gJOa3kEJKYuA3KmTkvr9Ok9mow/agNG7pdN+pGJvxYdmhoFrGC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394217; c=relaxed/simple;
	bh=X2Muz8pkoRwEhUvH9ti0eknrxae4vqD1PWSyx9/gso0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0LgsBpARegaw3w5NdsEB3RcThdT2maI/LkNn7wqb7Ra6gGHMurjvPosmEkdkTsxjL+Uowye6H4HPjFT0hzzNKwXNgkrkNviTqHmkMtCikbcCz6qTM6/scij+aNwZOljge2OvUZJ7UDqy60WhCqMr/ZCdPvmvjYXjLtmFF5R51c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/Dt3l7y; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707394216; x=1738930216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X2Muz8pkoRwEhUvH9ti0eknrxae4vqD1PWSyx9/gso0=;
  b=H/Dt3l7yGZJ4WCUIGhrvpvs8vgp/fqSdn4/0G2wLaRzkhA3Udoy+RRgu
   SyhLH1Cc/qi3AXZ404Nhgj0Nn8rhvNYCPpPihSVVubUwkLdajcEcIgalS
   xL2CmUUikdwB8YsPXL/Mzw/QnQLao37FPFg2fOFPhjCMYuKUjL/qqLBm8
   p1qFwFYLMJ0eTVkxslFrmD6vbPAFjvnEgDwICpfhdCrIVZ8YqnNk3HbOd
   Tu3KNIt0tmuU3byJR037jSGCTkiCdZSY0NqMVk3KtHqRdkr2OBfyy3h6u
   CorYwTq8cs2HpH2Giz9NhPLjNia4ImT6IhlyWnzyVrhjFDvCfWviqMagv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1341297"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1341297"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 04:10:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1625935"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.52.95])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 04:10:13 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/4] MIPS: lantiq: Remove unused function pointer variables
Date: Thu,  8 Feb 2024 14:09:56 +0200
Message-Id: <20240208120959.2513-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208120959.2513-1-ilpo.jarvinen@linux.intel.com>
References: <20240208120959.2513-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ever since introduction in the commit e47d488935ed ("MIPS: Lantiq: Add
PCI controller support.") ltqpci_plat_dev_init has been unused. In
57c8cb8f2429 ("MIPS: pci: convert lantiq driver to OF") also
ltq_pci_plat_arch_init was introduced.

With those commit being more than 10 years ago, it seem neither is
going to get used anytime soon. Thus, remove both unused function
pointer variables.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/mips/pci/fixup-lantiq.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/mips/pci/fixup-lantiq.c b/arch/mips/pci/fixup-lantiq.c
index 13009666204f..8bcc136976dc 100644
--- a/arch/mips/pci/fixup-lantiq.c
+++ b/arch/mips/pci/fixup-lantiq.c
@@ -7,17 +7,8 @@
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 
-int (*ltq_pci_plat_arch_init)(struct pci_dev *dev) = NULL;
-int (*ltq_pci_plat_dev_init)(struct pci_dev *dev) = NULL;
-
 int pcibios_plat_dev_init(struct pci_dev *dev)
 {
-	if (ltq_pci_plat_arch_init)
-		return ltq_pci_plat_arch_init(dev);
-
-	if (ltq_pci_plat_dev_init)
-		return ltq_pci_plat_dev_init(dev);
-
 	return 0;
 }
 
-- 
2.39.2


