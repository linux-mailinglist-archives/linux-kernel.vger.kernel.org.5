Return-Path: <linux-kernel+bounces-130246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130738975E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420741C27FE2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC34153831;
	Wed,  3 Apr 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lIClcxmU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02722152E1A;
	Wed,  3 Apr 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163794; cv=none; b=TuGe2S7+y4NRxH/Xlp3JMiLyCX/7uyqFixgfJVGi3tb/ArlWSNbs0WGpJVZTPDBYHfNDtg0b+yi7v8+UY6prvtXdEAcwqR2IFe+RZOI10K3p2ycHvVlOW0oJEI4QnYkx5WuevJBpUTyKIMq6ROryu6x1VgD5FeRpoL7eiCN2XPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163794; c=relaxed/simple;
	bh=JG8SKbMJF+yqnv0lRb2lHU2ZQzLtD4bWRdMO6yuf/7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdgDlyt0o0uC27qcFYn/46DIoOdtDgFODtel+5ebh/OQNQMdd2VW0gT/+NwwbZbi056AeAIaWF7olByRAcFeU3rLdynigRFVM3aWHObsIvwPBhxASeCXZ2TrhbwydDzujJwfdp/kXil3f5sCVX4CvIUqVvFv4XBNID0SMfobfTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lIClcxmU; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712163792; x=1743699792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JG8SKbMJF+yqnv0lRb2lHU2ZQzLtD4bWRdMO6yuf/7o=;
  b=lIClcxmUWyvLRyPFv4fDn29Q2AoJWkehORw4jpIoAqdD4Y5tFRT3gcoJ
   ep7YBeLqHcoG62vzCtRpMeKlb3/ZEaW/q9euDTDHl6R9mkI0qkwz3SKj9
   DXbkSckwUHpq6ul3mAnW9NL4S2ozgxSNSCXN0dU92dp/k/IcEngA+rf/B
   R3DY48hx3qBKrbBnAvPXKMHX3Q0v3wm0y2WsO9VjysdkptpY78jtLRzvi
   Vc2QtMtYeqStt/22eCZQkyNq8iUQs7z/2kVvg8Ui5lF5Uwg3BxPnmMIsD
   awf3+GhCpYWKBOiu76KmNW2PeR+h4uR7+meoh7awVVF0QXOmWJZtFz3WO
   Q==;
X-CSE-ConnectionGUID: 01Hl3xy1SIyKFGs0GVKpPA==
X-CSE-MsgGUID: AtLICwNNT7WeXxnUZBmbgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18861495"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18861495"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 10:03:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937085332"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937085332"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 10:03:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 214946F5; Wed,  3 Apr 2024 20:03:05 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhang Rui <rui.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 4/4] ACPI: x86: Move LPSS to x86 folder
Date: Wed,  3 Apr 2024 19:54:38 +0300
Message-ID: <20240403170302.1073841-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240403170302.1073841-1-andriy.shevchenko@linux.intel.com>
References: <20240403170302.1073841-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LPSS is built solely for x86, move it to the respective folder.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/Makefile                    | 1 -
 drivers/acpi/x86/Makefile                | 1 +
 drivers/acpi/{acpi_lpss.c => x86/lpss.c} | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/acpi/{acpi_lpss.c => x86/lpss.c} (99%)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 6f4187a34f41..39ea5cfa8326 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -45,7 +45,6 @@ acpi-y				+= ec.o
 acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
 acpi-$(CONFIG_PCI)		+= pci_root.o pci_link.o pci_irq.o
 obj-$(CONFIG_ACPI_MCFG)		+= pci_mcfg.o
-acpi-$(CONFIG_PCI)		+= acpi_lpss.o
 acpi-y				+= acpi_apd.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= acpi_pnp.o
diff --git a/drivers/acpi/x86/Makefile b/drivers/acpi/x86/Makefile
index 1f3c5fa84f9e..63c99509ed9d 100644
--- a/drivers/acpi/x86/Makefile
+++ b/drivers/acpi/x86/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_ACPI)	+= acpi-x86.o
 acpi-x86-y		+= apple.o
 acpi-x86-y		+= cmos_rtc.o
+acpi-x86-$(CONFIG_PCI)	+= lpss.o
 acpi-x86-y		+= s2idle.o
 acpi-x86-y		+= utils.o
 
diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/x86/lpss.c
similarity index 99%
rename from drivers/acpi/acpi_lpss.c
rename to drivers/acpi/x86/lpss.c
index a3d2d94be5c0..148e29c2c526 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/x86/lpss.c
@@ -25,7 +25,7 @@
 #include <linux/suspend.h>
 #include <linux/delay.h>
 
-#include "internal.h"
+#include "../internal.h"
 
 #ifdef CONFIG_X86_INTEL_LPSS
 
-- 
2.43.0.rc1.1.gbec44491f096


