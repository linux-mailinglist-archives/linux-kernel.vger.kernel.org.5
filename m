Return-Path: <linux-kernel+bounces-91051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F878708F6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED861F24388
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FAC61694;
	Mon,  4 Mar 2024 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjrWCCiH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F5E4D133;
	Mon,  4 Mar 2024 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575360; cv=none; b=SbtfQJ/11L6+4crUWmXGPxRKWQlo8VHyQGinZ4Maf1heQF8GW3gaF5BtYXhACDysE0cV22Jqvr2wJOOkdlcSxVbvmJZx180Ay0DXy9GSeJiSNjUm7m/lRiIv0G1FifB4RsQrAz9T5G/6ealiWrSZ+iQhked06bca7KWVxFfUTeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575360; c=relaxed/simple;
	bh=tlIhMHTizLNC65AXHckznsluJndzNEY1esD/Fuv7JEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=usCtcVDaowMve0h9jRhm6tmNKX9m/tg7T5p6mxbUcQ4kaa+NBehqKufG54ndYIOm8v07wcYtiGg9OHVnlRUfx2La25gZPfdjXnsD12HhO+KeXyjGIQlJDIyF+YuaYzHxcmdawsxZQi5GAGiecfb4D5E58slzWw1H0d1n8rC9PsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjrWCCiH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709575359; x=1741111359;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tlIhMHTizLNC65AXHckznsluJndzNEY1esD/Fuv7JEI=;
  b=bjrWCCiH+CCNlhH0lq9q/snw2ktr5hAcW1VOCRuhTM+FrE2FPzjlJOtI
   r4PaQUhCNO3HJ+NpaadfudloGdeWcsX0ooxrNVCblO67A/JGeSM17XQNb
   U72GDYii0EMKEeHkBq9HppCCVUsi0ek3fk0ttJPSq2yal0yi6XRmwTIGq
   HpqF2440pv5/gR5dWJXqnB1GgSd8+3OP7N2l4tEYJZ1QRvyNqkQPfqhaO
   gZWGaNyt2ZtP5S0K1FfAyosT6CQEx2xJ6iZyUzD9JltFGDUix2jqhbkkz
   r2AR8rwKmxyRoD+6/pqQwGA5CvYX2s03FCYfs2hON4X+HP7nwTT1aWW/3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7854606"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="7854606"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 10:02:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937040914"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="937040914"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 10:02:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 019E915C; Mon,  4 Mar 2024 20:02:34 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] media: c8sectpfe: Remove unused of_gpio.h
Date: Mon,  4 Mar 2024 20:02:33 +0200
Message-ID: <20240304180233.1200649-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
index e4cf27b5a072..0df2a1b4974b 100644
--- a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
@@ -24,7 +24,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinctrl.h>
-- 
2.43.0.rc1.1.gbec44491f096


