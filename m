Return-Path: <linux-kernel+bounces-33806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28525836EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20871F2EDFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B71D61678;
	Mon, 22 Jan 2024 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVwJlG54"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5841612FE;
	Mon, 22 Jan 2024 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944291; cv=none; b=ISbi4beL71C3q6xTOOmE7RNb2XReoHyzHoa4v8eaxJFY0brX8zBS8p92G0erK5XTK/dBo8PEaYEdwC5Wkj7gsShBYHnFiMyXD2yVvfuoq/IG1vDfwwKRtrNLIdqjzZfjUxBiLQUpMBR9Hqpvza4ZzvQw2KyyWkdFYAf9BZRnhmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944291; c=relaxed/simple;
	bh=NPdtl0n426XRja32Jxqcz/56e80Ebxi5CwNkSRmx1Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=STcdt+5KNPNXEyjsYHpl1amxBvm9LolurrskT8wlNCyVZhxvrAjDZhCJFJndURHfokqADYgAZqr1U6wWC0mkWaYAk0MWg+ABfeMm4vvCmYLpmHNVht+C6B1Bk2zJoWtODlnOdij9db+MLzn1gPb/xLJjj6qzGRKWQm2tKqSYGZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVwJlG54; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705944290; x=1737480290;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NPdtl0n426XRja32Jxqcz/56e80Ebxi5CwNkSRmx1Zk=;
  b=mVwJlG543WZag8bwwyjTtnkcvC+0fE3F2BBjU2dBSxnSFQBFD6f+p4JA
   w3szMwh24AmgNrd6n3ARBgfnAygXk05pqXjOJj/hXwxeQQRi2XNLPLoSm
   3bQkfT4TmivPI8BGk/1pbUAFTgvmoFtop4eGUU1f/phbC9BDWBBlzj0Ds
   gj4QtJ5JiNBkCWhfXLYM2ux8I4vkm8xCsPz7kFxRtDOa5ceta8OFZ8tbl
   1ia7TU4N2qt1TtWY/Eo//YC6YNnvz8FWy2CWRQV7UiA2dNEvOXsjqEUuM
   5dpPvw1eRO8Yxv+OYAVpv7VGPeptzd0nY1BAV4Is7Zt3z5hFSXqzMYoTC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="1150981"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1150981"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 09:24:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1263457"
Received: from sj-2308-osc3.sj.intel.com ([10.233.115.64])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 09:24:49 -0800
From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
To: hao.wu@intel.com,
	trix@redhat.com,
	mdf@kernel.org,
	yilun.xu@intel.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH] fpga: dfl: afu: update initialization of port_hdr driver
Date: Mon, 22 Jan 2024 09:24:33 -0800
Message-Id: <20240122172433.537525-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revision 2 of the Device Feature List (DFL) Port feature has
slightly different requirements than revision 1. Revision 2
does not need the port to reset at driver startup. In fact,
performing a port reset during driver initialization can cause
driver race conditions when the port is connected to a different
PCIe Physical Function (PF) than the management PF performing
the actual port reset.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 drivers/fpga/dfl-afu-main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index c0a75ca360d6..7d7f80cd264f 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -417,7 +417,18 @@ static const struct attribute_group port_hdr_group = {
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
+
+	if (rev > 2)
+		dev_info(&pdev->dev, "unexpected port feature revision, %u\n", rev);
 
 	return 0;
 }
-- 
2.34.1


