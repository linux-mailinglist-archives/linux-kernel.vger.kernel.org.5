Return-Path: <linux-kernel+bounces-161234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E830C8B494C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5FE2820B6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 03:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097BF23A6;
	Sun, 28 Apr 2024 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="cg8K9yxO"
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0455915A4;
	Sun, 28 Apr 2024 03:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714273759; cv=none; b=gAhbbDijK84faMtnWcotkZ9fR/FwiX3f41ZPQBIW5jRyLvG1SBcYI+Wj3Tko4QrjL/VZiXpsT3ELDT/gUsXRzvCgUhtzGYTAlJlisXPg3HRq2CW1a4+FJPVUzlIj+V6mP8Ae494Ehbrmi91ysJDORHWDU99idXt4igGfsQvEcts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714273759; c=relaxed/simple;
	bh=k6OWLn97dyPXiojG9nCjtXAuHyNojQdpkS9sgnConzM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bHJZuOF89MeOgWKKx98EX5GYSBR31COOK5L7nMDcDJizewvyo1gQTfj6N0ZddxQ+vkF1zFfpdbfM4AWTRpEySRyzH4ToC/d9rJrAwCMNYMvFMZr8XZbUeqHhDA1C6+VLSKA/HHKUXFMflhK4K6W5ekBwBJqQeQVI6mBjyQPROVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=cg8K9yxO; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1714273757; x=1745809757;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k6OWLn97dyPXiojG9nCjtXAuHyNojQdpkS9sgnConzM=;
  b=cg8K9yxO6DZ8R19DEvAGbxxVFwAcASjXeIxD8LWOe9TU1t7jsefKFpyr
   BPiJxB9qBGN84jPHp8thLk78pgEA1MJicr37n0fjKyABiCDHJc8hFmxjI
   geIwVNUSASNYNiWtNMllpWGbHyhAMb52a0ktMas6dRY5aOaQFw1xl89Yx
   J1UnmALLpWo2/DtawJ3lhdkMIn0/g2j0DBCQg3chUlOmZgFsMOO68wfrJ
   ih3rhA+7uAdWPNTH+IFITxY7l5xZxP3O/3SDiPXov5TpmQ4Dx14vmL6QL
   YG+xRYLXBnoDis/xm7aFaki/Kk1bnq+LPhQ5Dru58gH67A5NWvOcoco0y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="156389211"
X-IronPort-AV: E=Sophos;i="6.07,236,1708354800"; 
   d="scan'208";a="156389211"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 12:08:03 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id A12D1E8F86;
	Sun, 28 Apr 2024 12:08:00 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id C7D60BF4AF;
	Sun, 28 Apr 2024 12:07:59 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 539BD34789;
	Sun, 28 Apr 2024 12:07:59 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 61EF31A0002;
	Sun, 28 Apr 2024 11:07:58 +0800 (CST)
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
Subject: [PATCH] cxl/region: Fix cxlr_pmem leaks
Date: Sun, 28 Apr 2024 11:07:48 +0800
Message-Id: <20240428030748.318985-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28348.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28348.004
X-TMASE-Result: 10-0.891900-10.000000
X-TMASE-MatchedRID: rWcK0WiM0yxUfypZw6S0pSQLXCPUFARrTFQnI+epPIakob0Y35+HFL8F
	Hrw7frluf146W0iUu2v46qOd1x1zqpcFdomgH0lnFEUknJ/kEl5jFT88f69nG/oLR4+zsDTtjoc
	zmuoPCq2BlDQq+LQ0B9zCG0GDXnSbHq67pWYcGwtU1RsVEEJA/I8pk/SmUpRHjZEDJ+dycfNkeF
	KCrXUpHp8Roq8b+01TGnrijSn3hCQVwbf5lERMgI/2RRfVn5u4Tcu6aRtCI3BUKpNI+7y1VHsDE
	gQ63iHZ
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Before this error path, cxlr_pmem pointed to a kzalloc() memory, free
it to avoid this memory leaking.

Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/cxl/core/region.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5c186e0a39b9..812b2948b6c6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2719,6 +2719,7 @@ static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
 		if (i == 0) {
 			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd);
 			if (!cxl_nvb) {
+				kfree(cxlr_pmem);
 				cxlr_pmem = ERR_PTR(-ENODEV);
 				goto out;
 			}
-- 
2.29.2


