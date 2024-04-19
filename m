Return-Path: <linux-kernel+bounces-151456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5218AAF2F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B1C1B21FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AD91272BF;
	Fri, 19 Apr 2024 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzFFSNMr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DD819E;
	Fri, 19 Apr 2024 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713532765; cv=none; b=P4ukoye+EhIKYq9L0NYyiOVShWwdf7YbqQHyFGQRJIbL1/TsCp2LCr4GeVAON2Ke9oNJ9IywFoTBD1b4L3loYhswXNt3cT0SkXyPQKNbexieFPjF9EknOzQN3Yo1o3Wek8UhXgfTC9SwqBWYVBDR0TC4vdK9FiCNfePh+yB7Tvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713532765; c=relaxed/simple;
	bh=p3HPJQwWcyZ7B2SY6HxVwgy8v+dxZ9osW5JvMnfCh50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dlkzeriD4lYtV45D7ui0DESYNCLA3tAZc6rc8YlqVNqaK/5v1WAWHyxjHlAal9DQkgEiKCLDmEeb3Pj2gFLsddLmSyxjTJVlexRZmK1p2UX0p8JmlNngQBdrAhYJOeP+CDgLaZhaWwWPKrKz6vA3o5bGrzcC8rK1BcUU/NygP7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzFFSNMr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713532764; x=1745068764;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p3HPJQwWcyZ7B2SY6HxVwgy8v+dxZ9osW5JvMnfCh50=;
  b=PzFFSNMrGufGIouMFMxKQjS6ekGm+YvX2QcPhlOe/TmVkJ4nT/RTC4rg
   wG73RoZ04yDJeZ3/E/nfNTawA2S9hbFu2KNpjYBYlMIaJrvAK/AVbgmqy
   GoGSoSi52oauA9L+u10LpWhkeGWSAjAta0yzFpVkFf7BnDt/lIYlj30jP
   QSv/Fpn7XI9y55UnxcNt8Ulx/AGgUD7hqnKAEGKz2llkjxcMOUlElYxRE
   KLG7UTy8rYZgbAU1Jwl3B3kQqd1NTuoGoWpeJKsdEmZK3c5D2IEkFrGap
   gFRktqT8g7/+mG8ihzb7o0gLsSsXCuezqiBZXkE6N0Cd7pVt2zE1ZQFnj
   A==;
X-CSE-ConnectionGUID: UVvtZLy4QJuQDPnBmvjH1A==
X-CSE-MsgGUID: TDUDaObgRYuAHor7ZNT++Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="34530774"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="34530774"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:19:23 -0700
X-CSE-ConnectionGUID: dTlQtpxeSkmjmf/mh5Dtdg==
X-CSE-MsgGUID: 8YFrbZTRTiKX9R6KB+JFTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23194608"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 19 Apr 2024 06:19:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 33E34FD; Fri, 19 Apr 2024 16:19:19 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Niklas Neronin <niklas.neronin@intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] xhci: pci: Use PCI_VENDOR_ID_RENESAS
Date: Fri, 19 Apr 2024 16:19:18 +0300
Message-ID: <20240419131918.3854243-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of plain hexadecimal, use already defined PCI_VENDOR_ID_RENESAS.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 332c5843ada5..c3696daab9a9 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -891,10 +891,10 @@ static const struct xhci_driver_data reneses_data = {
 
 /* PCI driver selection metadata; PCI hotplugging uses this */
 static const struct pci_device_id pci_ids[] = {
-	{ PCI_DEVICE(0x1912, 0x0014),
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0014),
 		.driver_data =  (unsigned long)&reneses_data,
 	},
-	{ PCI_DEVICE(0x1912, 0x0015),
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0015),
 		.driver_data =  (unsigned long)&reneses_data,
 	},
 	/* handle any USB 3.0 xHCI controller */
-- 
2.43.0.rc1.1336.g36b5255a03ac


