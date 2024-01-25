Return-Path: <linux-kernel+bounces-39416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 870C283D0CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B10DB24A91
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B77B134D1;
	Thu, 25 Jan 2024 23:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfn7Cm28"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358EB134A3;
	Thu, 25 Jan 2024 23:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706225846; cv=none; b=b0x3KvVNKmkjWx4nGZUZ0xWJWI7TXVWiw2ZwNpwwGb/AjQy4lCzBkBgZTv/qSq+34LcEI+zRkVQCex/vLH/z2gqNaRCYXWmMAU+nt4Ug8OUNi3uju2aX4IBtGCdPqRgXC+gxshBtCHoOrCZeRQxx+9Eaioa4TEaB2Pv3g5LDj00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706225846; c=relaxed/simple;
	bh=5fg1PyjF1qY+gL8AMkkGVfAPj1wrcLCzNxUgqTuKi+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sN7EfKgxJQ4MrjDhOtchR1t3iHfC2m4nDXoSF2imXsRzpGJXCjjYfdADNL6Xicag/SDHk81M8bKqAFAQcDePoPGttyc13H7TiAdBMCFTvlcjF6zkMZKSDYOcpn0HGcumLkK+XGWyBkpvLiJ3aZNToFyqa9LVrFVlt/dNrkGr0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfn7Cm28; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706225844; x=1737761844;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5fg1PyjF1qY+gL8AMkkGVfAPj1wrcLCzNxUgqTuKi+8=;
  b=gfn7Cm28IkprGcCl2EFC+lIY+Mhbsx4UtgISI+EoF8usHXTLA65tTT1c
   v/Y5BUolCSP29Sg3qrTIeRxJAnULWQbywg0+WieMDSukJQJ4R8M8EU+X7
   b609I9WN6wQW9P1CVJJ5eTw+KZ8npzkv8aqSuJph6pPjUCyvUZuzxQ05/
   G1JKYBf73YJ1TSPkwJ5oyag7P0gU84RbjaktTBPP6kthu6qxg6KJMEsWA
   /9cfo/eeexb2MJ1dls7PX4EbTgPZAnGxzI1pf2DZa/frxh2/PWULD8OKn
   ln8d38iDwNDlOTLL5zrk4wvIM4StZHEH60dNepMosgVeR9T0TrhXEdv95
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9452709"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9452709"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 15:37:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="877210628"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="877210628"
Received: from sj-2308-osc3.sj.intel.com ([10.233.115.64])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 15:37:22 -0800
From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
To: hao.wu@intel.com,
	trix@redhat.com,
	mdf@kernel.org,
	yilun.xu@intel.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v2] fpga: dfl: afu: support Rev 2 of DFL Port feature
Date: Thu, 25 Jan 2024 15:37:15 -0800
Message-Id: <20240125233715.861883-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revision 2 of the Device Feature List (DFL) Port feature
adds support for connecting the contents of the port to
multiple PCIe Physical Functions (PF).

This new functionality requires changing the port reset
behavior during FPGA and software initialization from
revision 1 of the port feature. With revision 1, the initial
state of the logic inside the port was not guaranteed to
be valid until a port reset was performed by software during
driver initialization. With revision 2, the initial state
of the logic inside the port is guaranteed to be valid,
and a port reset is not required during driver initialization.

This change in port reset behavior avoids a potential race
condition during PCI enumeration when a port is connected to
multiple PFs. Problems can occur if the driver attached to
the PF managing the port asserts reset in its probe function
when a driver attached to another PF accesses the port in its
own probe function. The potential problems include failed or hung
transaction layer packet (TLP) transactions and invalid data
being returned.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

---
v2:
- Update commit message for clarity
- Remove potentially confusing dev_info message.
---
 drivers/fpga/dfl-afu-main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index c0a75ca360d6..42fe27660ab7 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -417,7 +417,15 @@ static const struct attribute_group port_hdr_group = {
 static int port_hdr_init(struct platform_device *pdev,
 			 struct dfl_feature *feature)
 {
-	port_reset(pdev);
+	void __iomem *base;
+	u8 rev;
+
+	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
+
+	rev = dfl_feature_revision(base);
+
+	if (rev < 2)
+		port_reset(pdev);
 
 	return 0;
 }
-- 
2.34.1


