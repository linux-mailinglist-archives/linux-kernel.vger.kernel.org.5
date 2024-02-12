Return-Path: <linux-kernel+bounces-61686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68F885155C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224F51F240C3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CA346450;
	Mon, 12 Feb 2024 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lln+eQfr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C144C84
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744431; cv=none; b=ka4GK68xz6rlPpV5jF/l+KotJtZ+KoGUo2LHTXDxDReKlfSmF/UJfa4MYOG3sne5iO8+e9BPJiIOPk2KN2Jp0XfeguhxBzApAPEFAlRnQldLGUWpoA7qPwjzCu9aJ2PzFWD9ZR2kaZA0+s5/cU2rUOprtTm2bZ+Jk1T1RBkSMJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744431; c=relaxed/simple;
	bh=VuDnIGVkzj7HEWBCDuA7TJeyRNBPvvYvSCvgX9nukwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JU6Z/W31MI/+jaQNs/e2HUXIbmiaSntuCz2yFcK7/fePvE2TwdM60lAfluJGzrHXBFedSKL1M2gdiA0vj2ygPaNmd82iONMrN5HAFofcKJXOnuZFbDUjNkwbd32nmQ2cjZ9gZkfq0fKB1pjlYmUx9TthWrXIducUfn5Bx2KgOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lln+eQfr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707744430; x=1739280430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VuDnIGVkzj7HEWBCDuA7TJeyRNBPvvYvSCvgX9nukwc=;
  b=lln+eQfrXl1iptBaNFX10C2GLm+iJfSzIH9WunU0UaMlwUNy1Qsh+HVK
   vShpZzperRfOJBMSGnjhEVwcr2Q2O77nbXts1NP9tawC+6/2kb9F0EY0z
   oiZ2uQyStwGZEHHDmMwWaTTbH92rPyanazENYV7Jhc+TWvGfpzzLs+hpB
   gVmFtl1khuTlgzJs/qXHC0RAxInsuYfL0OuHNnCfH+Hkd/xpgEUMktJb7
   pORNkg+nPeeu8FLNYA0PLa80NVbIH3aeUXtYVkacLHRfUGnC9r/epJg7s
   ezBXoO9jRBH80fVD13GfA+7aXuMWfILMMU5x56DI6sAJHaPuy4cxIEFYu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="5496476"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="5496476"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:26:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="935067321"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935067321"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 05:26:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6FB1B11D; Mon, 12 Feb 2024 15:26:16 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 2/3] auxdisplay: Move cfag12864b.h to the subsystem folder
Date: Mon, 12 Feb 2024 15:23:54 +0200
Message-ID: <20240212132515.2660837-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no users outside of auxdisplay subsystem for the cfag12864b.h.
Move include/linux/cfag12864b.h to drivers/auxdisplay.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS                                        | 3 ---
 drivers/auxdisplay/cfag12864b.c                    | 2 +-
 {include/linux => drivers/auxdisplay}/cfag12864b.h | 0
 drivers/auxdisplay/cfag12864bfb.c                  | 3 ++-
 4 files changed, 3 insertions(+), 5 deletions(-)
 rename {include/linux => drivers/auxdisplay}/cfag12864b.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index e2a804e22c3b..e981d7274756 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3412,7 +3412,6 @@ S:	Odd Fixes
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git
 F:	Documentation/devicetree/bindings/auxdisplay/
 F:	drivers/auxdisplay/
-F:	include/linux/cfag12864b.h
 
 AVIA HX711 ANALOG DIGITAL CONVERTER IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
@@ -4900,13 +4899,11 @@ CFAG12864B LCD DRIVER
 M:	Miguel Ojeda <ojeda@kernel.org>
 S:	Maintained
 F:	drivers/auxdisplay/cfag12864b.c
-F:	include/linux/cfag12864b.h
 
 CFAG12864BFB LCD FRAMEBUFFER DRIVER
 M:	Miguel Ojeda <ojeda@kernel.org>
 S:	Maintained
 F:	drivers/auxdisplay/cfag12864bfb.c
-F:	include/linux/cfag12864b.h
 
 CHAR and MISC DRIVERS
 M:	Arnd Bergmann <arnd@arndb.de>
diff --git a/drivers/auxdisplay/cfag12864b.c b/drivers/auxdisplay/cfag12864b.c
index 6526aa51fb1d..6a8368a37121 100644
--- a/drivers/auxdisplay/cfag12864b.c
+++ b/drivers/auxdisplay/cfag12864b.c
@@ -23,8 +23,8 @@
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 #include <linux/ks0108.h>
-#include <linux/cfag12864b.h>
 
+#include "cfag12864b.h"
 
 #define CFAG12864B_NAME "cfag12864b"
 
diff --git a/include/linux/cfag12864b.h b/drivers/auxdisplay/cfag12864b.h
similarity index 100%
rename from include/linux/cfag12864b.h
rename to drivers/auxdisplay/cfag12864b.h
diff --git a/drivers/auxdisplay/cfag12864bfb.c b/drivers/auxdisplay/cfag12864bfb.c
index 5ba19c339f08..19ba3977ad7d 100644
--- a/drivers/auxdisplay/cfag12864bfb.c
+++ b/drivers/auxdisplay/cfag12864bfb.c
@@ -16,7 +16,8 @@
 #include <linux/fb.h>
 #include <linux/mm.h>
 #include <linux/platform_device.h>
-#include <linux/cfag12864b.h>
+
+#include "cfag12864b.h"
 
 #define CFAG12864BFB_NAME "cfag12864bfb"
 
-- 
2.43.0.rc1.1.gbec44491f096


