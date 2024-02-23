Return-Path: <linux-kernel+bounces-78735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A369F861806
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBF728484B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A409B8662B;
	Fri, 23 Feb 2024 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UL1yHmJr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41E25B1E0
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706126; cv=none; b=a0aZT5ZW+MM+oCaseRs+WrwkgNu0f8Knk1FY9Z/ZsTLadzeEkeHFipXHDpnrlPHvVP/fjPXkDXUKbWg5g3lmsQubGBSHxVRzqBWj0MCq0lLEYFGWQivM0ONowtu4iLbeMvubcytWx/xERmjqH+9+rVk0dlB7FRMmiZcn8P/I/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706126; c=relaxed/simple;
	bh=N+xBnxQ1ExC9SLflSQYfvZ+wQb7LNsdhHsn3A2kmeH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eje+ElIZEJtPERYrSJJ5T0X5KNhpPPZFGqcnF5MGxSEiibs8AojQh7vfjHJG0ysVhaV42F+3wuT9SuRYm/EqVKqeOq8SqLuwFkhxv0himVqwdCyQvzr+8Fp9Sl2I8kaEMVjfsi15G+UtrJZlPPMNFYk0gtxV5Xcf+6iu0IODrlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UL1yHmJr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708706125; x=1740242125;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N+xBnxQ1ExC9SLflSQYfvZ+wQb7LNsdhHsn3A2kmeH4=;
  b=UL1yHmJrnqyf98Sw1S+5kMUlW3k4HOxnQA8TKUmqq0k+LbEs2EnxZsWh
   q58JV8KHfcmXLRyFFL2eQChvgcf1h0bJbE2mYDwiF6xvyQxAnPvcwnFZU
   1ywJvP257yTU+kzdtwSTQFVyV+0bLCGpuqDJHQV6mjy9AXhnl3trtWvwG
   /n9qojuA/fAx1cN2q311mvzkjKttxHHIxfuXww7TfZwrbfen5HETXZcT0
   pWsDhFTUdhj+1xDrMDBrsUSFzsIG1qvucqY2QbjIGDErjSixiL6uo74j0
   SmQByJUOvxqdNvc32mRUq9eEasj1wcRDpmHxnYrhAoSXUTnmM4e7WsFYc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3189535"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3189535"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 08:35:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6168351"
Received: from awvttdev-05.aw.intel.com ([10.228.212.156])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 08:35:23 -0800
From: "Michael J. Ruhl" <michael.j.ruhl@intel.com>
To: linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: "Michael J. Ruhl" <michael.j.ruhl@intel.com>
Subject: [PATCH v2] clkdev: Update clkdev id usage to allow for longer names
Date: Fri, 23 Feb 2024 11:35:16 -0500
Message-ID: <20240223163516.796606-1-michael.j.ruhl@intel.com>
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

v2: Removed CON_ID update and added example to commit

Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
---
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


