Return-Path: <linux-kernel+bounces-79100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B87861D94
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D91F289053
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEF8146E74;
	Fri, 23 Feb 2024 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/UpwaZc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6D6EAD2;
	Fri, 23 Feb 2024 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719969; cv=none; b=Fa45nRif6qycAmaqHHJcIRGh11HzDHRlQnh0epDfvSuuqDY8lrbg5iMg9MwxvJ5ZMBXLOdk+yVHKjHlXyACP2IcEHPQi8AngbpLmwyDktuChKZ6xhoZj0JWwGWRPoG69xFHu8+A5kaNHMISDPsbBM/+IFVop+erfmr2oVTFPTBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719969; c=relaxed/simple;
	bh=otrj2HG0uwGiWEAyJmF5JytS/AtQRVWKEWaHEN3Z8Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/M4bvvGIlCV+ZP2ozeypjNzmEL+RFhSHLJLyHjzSnhhwQzn/tBR5nGDfqSiRHU14TebuMv7/hcSJ2qepOHXjQNlYe5SJMUw/YQuOytr9yu00eRTsiKAw0TpEpmwxOvXYvJDuzDCXur6kw1DQGY3t8rpM1HxhFUWpyybFDqkVQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/UpwaZc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708719965; x=1740255965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=otrj2HG0uwGiWEAyJmF5JytS/AtQRVWKEWaHEN3Z8Sk=;
  b=J/UpwaZc9BJUd+NettQn7aaxKj0MF2DHZ5OehaLTktr7YM/b6MM3ww9j
   gML0SqcZ/zFz17FIbxeVStPqKHNIK9hpngrxGGmWCmZFlH1fw8rdE8Fij
   WFTz6x0Bv1bpbDfv4Ep2HqNC7p6buHsvT4K4K/kll5VEBFqm1O7mYK0l0
   +9SpcTnb3ta16EUSkljAV6ShOjg/jOUMVeQ7Aktw9nk83HMLX3TELv9OJ
   zqOipgmg/auP/sz4Pwm+k4KOMjL1viBM5mHuFTW5h/n2yBktB6IjNHUCh
   khDbHTroo3vcpMzA2WKWH2ZYkxmJlRQhk7mFAf7uxDFvXs+IKTxgRlJks
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="14487209"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="14487209"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 12:26:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="10713422"
Received: from awvttdev-05.aw.intel.com ([10.228.212.156])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 12:26:03 -0800
From: "Michael J. Ruhl" <michael.j.ruhl@intel.com>
To: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	andriy.shevchenko@linux.intel.com,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v3] clkdev: Update clkdev id usage to allow for longer names
Date: Fri, 23 Feb 2024 15:25:56 -0500
Message-ID: <20240223202556.2194021-1-michael.j.ruhl@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clkdev DEV ID information is limited to an array of 20 bytes
(MAX_DEV_ID).  It is possible that the ID could be longer than
that.  If so, the lookup will fail because the "real ID" will
not match the copied value.

For instance, generating a device name for the I2C Designware
module using the PCI ID can result in a name of:

i2c_designware.39424

clkdev_create() will store:

i2c_designware.3942

The stored name is one off and will not match correctly during probe.

Increase the size of the ID to allow for a longer name.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
---

v2: Removed CON_ID update and added example to commit
V3: Add r-b and move version info

 drivers/clk/clkdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index ee37d0be6877..9cd80522ca2d 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -144,7 +144,7 @@ void clkdev_add_table(struct clk_lookup *cl, size_t num)
 	mutex_unlock(&clocks_mutex);
 }
 
-#define MAX_DEV_ID	20
+#define MAX_DEV_ID	24
 #define MAX_CON_ID	16
 
 struct clk_lookup_alloc {
-- 
2.41.0


