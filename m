Return-Path: <linux-kernel+bounces-100552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCDE87997A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAA41C21AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBFC137C37;
	Tue, 12 Mar 2024 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IcXOK8Sl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CFE137C22
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262753; cv=none; b=RkaGTGAjvPznfheP8rFaXxMti4NkHutq++CFY2q0CcgJ/DTtIzzMeu+5kTbjDw8q+Egq6oIq9PIngZYo/IZxXG7keim7U4sk0UbmR0hMu0jHA17FWyaWTf9u7J0bmsSrLt2x5PS2MQ1iWnxXVYhT3K31/OEOldZNYeaJQOluac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262753; c=relaxed/simple;
	bh=ANzxv6EllV4scwYblQzES3W/sVjTusnEFuIXW77dw5E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LjZXTKvE1yCCJRGKVscLY2nIG9ezXQlWqBOr6grM0MPjdiT0+rxrhIp9bhyNhWZilJwuN48vLscKDqv6q5ZyDYdRP5HP3u7CjC1hwhCQ39AdBWEA0k89ozzHGox0HmAf3bNVqG8PSiT6WsfAUZsWVuD4AMPS93gx3idULpwIxPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IcXOK8Sl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710262751; x=1741798751;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ANzxv6EllV4scwYblQzES3W/sVjTusnEFuIXW77dw5E=;
  b=IcXOK8Slcn/z7/E+nHnkhdHJHS8RL0SAyrVDqrK5dDqT4guDfaTRp9CL
   j7wTZBXoRsovcdvg53S/eXnkVYjWqBo/O5aJn1vg7ABOlWVYZN69F3YnD
   89M3ngwtE3dUzmgEvA1FDr9f9H5cEEcSnT6V6xJiXxNI+GakvQRYYtl8i
   Kbc0U+rb2fyq9Jf9l5rEJW+z+SI9jcCO7B9fDyQXQ15tpMnppDEJSw1mS
   1ncCaO6Z/01+f4h2AcZVCGy2fIepS7vHCKncN4YG8anRZ8li3UXua0VGi
   7g0ZfQlKQPRaFALQNhvVtEeyO5bRxhss7bRleUAFxrbrLFmrYhlSUNtZH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4854688"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4854688"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 09:59:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="937051996"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="937051996"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Mar 2024 09:59:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 07A382B7; Tue, 12 Mar 2024 18:59:07 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] mfd: intel-lpss: Switch over to MSI interrupts
Date: Tue, 12 Mar 2024 18:59:05 +0200
Message-ID: <20240312165905.1764507-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices support MSI interrupts. Let's at least try to use them in
platforms that provide MSI capability.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 8c00e0c695c5..c36a101df7be 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -54,7 +54,7 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (ret < 0)
 		return ret;
 
-- 
2.43.0.rc1.1.gbec44491f096


