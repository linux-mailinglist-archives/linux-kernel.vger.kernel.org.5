Return-Path: <linux-kernel+bounces-101571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B19787A8D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 795EAB22A21
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F44D43AD1;
	Wed, 13 Mar 2024 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yfj5z0VT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07954205A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338212; cv=none; b=smGZ6TCX+8S6E1U6TQfSzBLXXUuiogWXi37Tp1HJErE/fmWJjXr2qfA+/EbWcM+lcIfxSsx09sX6pfGfbukWDipZLD0wU2IPOMzqlmEmzguBhYeEkQnXDvXvDIN5pds9Gco3Te0lHMDxi1rWpLDR2M6vbjyodBeJXWslCwBWGkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338212; c=relaxed/simple;
	bh=GB0XhLkoXhj91tZjk/utBUz3p/nRmxqnPNcYk6PNq9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TgdUfvFILOHzN9uFIbfvCYUf3Zs0l3S2X5TsN6pcjbPxmTH4l8TbbMlNXTziUIZA5sQVT6mwMZh8OiiYUqmXGxL9WYDmWYh8iCtN3siz0r3mfsPLMALx0VH50BCaUOBrYbGMNOHTi/52iDzoIpNBv0aTx77WjpMnnoxdCVM7nYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yfj5z0VT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710338211; x=1741874211;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GB0XhLkoXhj91tZjk/utBUz3p/nRmxqnPNcYk6PNq9w=;
  b=Yfj5z0VTMHRdnU7CXHiQ+qzP/KFiweU0vrN8eb/y4+ez0dEjCEN7JMAZ
   9MemtGPQ4OgVTwWo+E7V4f6HkgFX13TNdtIO3RgsgMUL8SdOZJ6HkROvN
   7cQ4YuE7yiHAPgOkK4oqdjWkgOOF5cAna1N3HOGX1qRAxfh5XmhtBOhOF
   2QBuZCB+MlIVfNT0yS+ZdilXSbnyLR81ez2eW4UePIZif93SmKmG1B9i/
   K/tVe2MVNcU0iJBxk12HPQ9f1LjFcT4CgSyX5VsFVcMSqwdICfU5afQMy
   J9YbLO2KRWPveHbZMd1GUa3C8Qc2XPIG1z0e0jQNM+tptizGUDM2A8XKS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5710550"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="5710550"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 06:56:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="937054151"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="937054151"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2024 06:56:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 95C2A4EB; Wed, 13 Mar 2024 15:56:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rob Herring <robh@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Anatolij Gustschin <agust@denx.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] powerpc/52xx: Replace of_gpio.h by proper one
Date: Wed, 13 Mar 2024 15:56:45 +0200
Message-ID: <20240313135645.2066362-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it directly, replace it
with what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/powerpc/platforms/52xx/mpc52xx_common.c | 2 --
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c    | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index b4938e344f71..253421ffb4e5 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -12,12 +12,10 @@
 
 #undef DEBUG
 
-#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
-#include <linux/of_gpio.h>
 #include <linux/export.h>
 #include <asm/io.h>
 #include <asm/mpc52xx.h>
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index 581059527c36..2bd6abcdc113 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -48,6 +48,7 @@
  * the output mode.  This driver does not change the output mode setting.
  */
 
+#include <linux/gpio/driver.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -56,7 +57,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/kernel.h>
 #include <linux/property.h>
-- 
2.43.0.rc1.1.gbec44491f096


