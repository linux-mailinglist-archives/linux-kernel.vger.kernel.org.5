Return-Path: <linux-kernel+bounces-161666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA2C8B4F36
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED331C212BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C1317F3;
	Mon, 29 Apr 2024 01:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="o4xCp3nd"
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF627F;
	Mon, 29 Apr 2024 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714354397; cv=none; b=ok/goOB6IevYrDqfB3Rkv9wKTeC6Hdw4r79J/CR+I4qyOQrEl0GdEGCZOVA6R2P/QF/kBkvGL10n+8lB89uWn41wXFmj3Mz0kXR0Ymv1R/uluKksuDhl9/MA2WomwieHPXHI5A1kPS8YPiKO/vx0cNNnY9i3UlMIvCSBRwnnW+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714354397; c=relaxed/simple;
	bh=xYYPaO+3oD5S6eHCxslEejj4KvT9R5R/OeS0jsKc+28=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nHKJy4Dh8o3joaA+TnbRM6tcYaeq1G9J0/49D0aNn/Y6J5ktKseohdmjcCm4uPMA/YN8UjkgsMzdw/XXE2QgpnXBMsDUxlb3eX7UzFd0EnLK0hwO/OUTXv6M9qPCuC0+Nysgr51B+IBZSyu4c/vUZDoo85kv+992P7clpCS9zLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=o4xCp3nd; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1714354394; x=1745890394;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xYYPaO+3oD5S6eHCxslEejj4KvT9R5R/OeS0jsKc+28=;
  b=o4xCp3ndGn2LeG0UeENwu8HQ3SzwHHSVfKb3a8Vxfo6AErEiMoNdvdoE
   XcJRsWd3kFkDkrDlo+9ZoU8FQkKJH1X/aSlneQ/i6d/Pex4PAXtral4gk
   2h5Euem0q1ccRpUAEfB4fn7K6ydLZ/bMD1k1JdWnKIv/FJiyPeDfFzyVq
   FgRpwjSdAZ5IC6/WcsRTsVLkcCha7B/PASDuy6vPTRIr9J8YfVVD90dms
   a4mjieim5KExWzlSqJf94DZ4vO3mJm3fmPd+uh84Hq8f1VDf3c+yNveGK
   E2vlc9vS78MDnjjYuQXOODIXd8fZ3YhzEUrxyf27ce2qQkVaPOiPed1Xt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="145456651"
X-IronPort-AV: E=Sophos;i="6.07,238,1708354800"; 
   d="scan'208";a="145456651"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 10:32:02 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 38684D6F63;
	Mon, 29 Apr 2024 10:32:00 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 752776415F;
	Mon, 29 Apr 2024 10:31:59 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 03FC32008FF88;
	Mon, 29 Apr 2024 10:31:59 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 250CF1A0002;
	Mon, 29 Apr 2024 09:31:58 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 1/2] cxl/region: Fix potential invalid pointer dereference
Date: Mon, 29 Apr 2024 09:31:53 +0800
Message-Id: <20240429013154.368118-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28350.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28350.004
X-TMASE-Result: 10--1.576700-10.000000
X-TMASE-MatchedRID: 3VliZ9l/ZIYx4g+7LKrJbIL5ja7E+OhyF4r8H5YrEqzAuQ0xDMaXkH4q
	tYI9sRE/1rH4Rg0AOT3cD62qv4l2/hBxp8+zDVac8Jb881FGn9l9LQinZ4QefCP/VFuTOXUTae6
	hIZpj4MuOhzOa6g8KrTBgI4CUkwyDjkYeOjePVdvqjr57M0aj7YHbQeJzNVtSrjbGgk2bYvq/I2
	a5OjosMHYCPDeb9md5Ta0JRSB0l2IiWX6BBdcrqBXBt/mUREyAj/ZFF9Wfm7hNy7ppG0IjcFQqk
	0j7vLVUewMSBDreIdk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

construct_region() could return a PTR_ERR() which cannot be derefernced.
Moving the dereference behind the error checking to make sure the
pointer is valid.

Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/cxl/core/region.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8535718a20f0..3c80aa263a65 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3086,10 +3086,9 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 	mutex_lock(&cxlrd->range_lock);
 	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
 				       match_region_by_range);
-	if (!region_dev) {
+	if (!region_dev)
 		cxlr = construct_region(cxlrd, cxled);
-		region_dev = &cxlr->dev;
-	} else
+	else
 		cxlr = to_cxl_region(region_dev);
 	mutex_unlock(&cxlrd->range_lock);
 
@@ -3097,6 +3096,9 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 	if (rc)
 		goto out;
 
+	if (!region_dev)
+		region_dev = &cxlr->dev;
+
 	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
 
 	down_read(&cxl_region_rwsem);
-- 
2.29.2


