Return-Path: <linux-kernel+bounces-127423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E3C894B24
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A512E1C20FCF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCBB18E29;
	Tue,  2 Apr 2024 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWxpWaRF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6398BCA6F;
	Tue,  2 Apr 2024 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712038225; cv=none; b=Qm5SWjVfJyfurR3L3rqLMTvwTbBmfAMoVt+FFeN6hGk853HozONgHY8kPn4ife1uo1BhFgRjLfPi9TKeWtbDTBRs2ccwqQRJhg151R1FEdBViH/Wg1iI+jRra3AmCiMJypBKJHqZCbw47N2MNOToBK9Vx6kYWy7PEYi2VlSmdGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712038225; c=relaxed/simple;
	bh=b/DPYR9P4aCHE4Z2mW+p4/L2UuwNobuxuPthVbCAXNk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VHh0KWf+vKxttbJRgdHiB0UdweNVrYlJLcXQSpOpkChLIYrfPQNpcicMPjZXic+T2cLdvmvECeJZQhHFti4QyB7lzRDq+jd8cHJXAbOr+/VcRZkWmxgymJJ2XpdFqw+J7qAoqhzLsZBWynVRkfH6P1JM5vdy64fI8sTMGDN/qsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWxpWaRF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712038223; x=1743574223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b/DPYR9P4aCHE4Z2mW+p4/L2UuwNobuxuPthVbCAXNk=;
  b=XWxpWaRF8XhOWSa3AIK0h+VS87dxHBcjjaIepWqAuWEv5AE8Z8/RRiXm
   /UOUB7/MCGyU7ed1deOCTFovjF/yb70WqMruRSd9qjqMLq/ZLQnTkGZs2
   2q4fe2kJOL1dtYDAQzwcYyr9m7vCT5URVb5grQCa9TOcYfgbw5JOS2NtC
   pxj6Z/oYUpHxc68PJ7wTa3k63iuQK5+R5sbwWjQUh9QxF3l7y+Nydxrhz
   kEnmuFaV4jCQBN8oapKTwNVJw+YlMxHi6EeKRBggni4zlVjOUrpJbjo5C
   TnUnZh0Y+ls3WrsYyDAUR0EAcVhPmJ9BOmZqEHMQtx3OndKEnmk1Tfv01
   g==;
X-CSE-ConnectionGUID: 2Z8fKOThRfuICWvTo2vhRQ==
X-CSE-MsgGUID: Sl0PtdkfSUC3FeyoGcF15Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="10972856"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="10972856"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 23:10:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="17976324"
Received: from ruizheli-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.29.42])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 23:10:21 -0700
From: Huang Ying <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>
Subject: [PATCH] cxl/hdm: Add debug message for invalid interleave granularity
Date: Tue,  2 Apr 2024 14:10:16 +0800
Message-Id: <20240402061016.388408-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no debug message for invalid interleave granularity.  This
makes it hard to debug related bugs.  So, this is added in this patch.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
---
 drivers/cxl/core/hdm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7d97790b893d..973a27543ed5 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -888,8 +888,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	}
 	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
 				 &cxld->interleave_granularity);
-	if (rc)
+	if (rc) {
+		dev_warn(&port->dev,
+			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
+			 port->id, cxld->id, ctrl);
 		return rc;
+	}
 
 	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
 		port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
-- 
2.39.2


