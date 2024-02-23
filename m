Return-Path: <linux-kernel+bounces-78470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F6C8613D7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66CE1C20B06
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139AF823DD;
	Fri, 23 Feb 2024 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnFOH73S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18451823BC
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697954; cv=none; b=fj6/KiQ6+Ot3oukzwEyZF48z5tfbkNMNSU4Hmi8VjXr4XdPULde5RXDdG4UjRRJoawLU7nuZdO7/yYtU9D7s6rBXwlaSBhp/scMkzyB24lzXtXUzluAQo13iEQZPURobq1luAPoIzoBtxdxyB52ARBcjNrbUBdjw1caDuY+1YwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697954; c=relaxed/simple;
	bh=tYze8IrJ1yAvzoappL3XtvPJ27bpcIPpI0JnZ5rnTDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HsSgjd54vvSPzU1L+VtNNWMtPy/PrWjnrQ91PaKMAH6XXwD478Qh5ocq91hHL7yEEkuhjvlZf0HFZ2BVt7IBlDYryQq1uGA0S2NaVzOr6tQ+LbFSI2cXll8rpUNnZ8YrMy3N+fHbU323P4nneUEJrYU0BVSVrsFMe/ucBmDUdj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnFOH73S; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708697952; x=1740233952;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tYze8IrJ1yAvzoappL3XtvPJ27bpcIPpI0JnZ5rnTDI=;
  b=CnFOH73SCQkUCVDTEHvttHi6GXKCfoEzUSkQVT/4cb1Umh3OwxZcbVvJ
   /btc+4QbR1+JJuykQpjULXmlzSikPGu75iqr+vWGcM0rrysSGJC3yy221
   GNeZxBCBUYKjfi27aYgGi7i8yNJ/EHKnPpeWoMg5ig34K2coPsyPLutaD
   vYAuTTUkndHUMCyl6ik+O6Z0yiGphqp0Cy6taxTAj4XbcZMm4lI+H2eLG
   oAKfFM8Sobfy1aY0OTGKnzZfUei9P5KtYrP/RK6Tm326A9tUjAY3VoAVZ
   fUp7L7sQDQLdUuKrWovpEue117xkRW0Jn6HBU1LpI+quQsLcGXuzLBuCQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="20451886"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="20451886"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 06:19:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6291708"
Received: from awvttdev-05.aw.intel.com ([10.228.212.156])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 06:19:11 -0800
From: "Michael J. Ruhl" <michael.j.ruhl@intel.com>
To: linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: "Michael J. Ruhl" <michael.j.ruhl@intel.com>
Subject: [PATCH] clkdev: Update clkdev id usage to allow for longer names
Date: Fri, 23 Feb 2024 09:18:14 -0500
Message-ID: <20240223141857.3794855-1-michael.j.ruhl@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clkdev ID information is limited to arrays of 20 and 16 bytes
(MAX_DEV_ID/MAX_CON_ID).  It is possible that the IDs could be
longer that.  If so, the lookup will fail because the "real ID"
will not match the copied value.

Increase the size of the IDs to allow for longer names.

Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
---
 drivers/clk/clkdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index ee37d0be6877..38549db691f4 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -144,8 +144,8 @@ void clkdev_add_table(struct clk_lookup *cl, size_t num)
 	mutex_unlock(&clocks_mutex);
 }
 
-#define MAX_DEV_ID	20
-#define MAX_CON_ID	16
+#define MAX_DEV_ID	32
+#define MAX_CON_ID	32
 
 struct clk_lookup_alloc {
 	struct clk_lookup cl;
-- 
2.41.0


