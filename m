Return-Path: <linux-kernel+bounces-93761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1075987343B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B6128A16F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1368605BD;
	Wed,  6 Mar 2024 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="CJxeW3SQ"
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC5604C5;
	Wed,  6 Mar 2024 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720967; cv=none; b=ujL9mGF61/sUSdD2b+cgLZTSJSq3rld3fTyg6Eh0A05/o2bjN7LkR53ZGoekzqHC6WD3t1YSkdW3PuFfTzRHsQ0Qeyph3v4sA89LPkrtfxw5q9LTfE6YgdBG69FlkA8yKjogbcDbSHxuEAJPX14GSNUxa8SNT0Mv9RDmM9tBJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720967; c=relaxed/simple;
	bh=8m938ej88oP8CU4LRmFGqeZ2eI8zznrXHFjHuzUAi80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kEiY1pyPc1IpLkrZrv9sLZ2DQCa72ay7nGpSTuq7/PYI2i07nPAKO98E7VC+YI6dmien3dcde0O6I/+hS1LvsSQ3X1TxtuqU8ymh/gcVuCeT0KPhfIjhMhGVVRS0yoIeWelSdFMW99dJ/cgQnqU86PxqDgjW0n5+BCaKJud9jO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=CJxeW3SQ; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709720965; x=1741256965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8m938ej88oP8CU4LRmFGqeZ2eI8zznrXHFjHuzUAi80=;
  b=CJxeW3SQNa0MAFqvZuu+siIYO1wx7FE+itbOPaeNf+8jkPGH5GmUPS/E
   SvfVOiUyrI/C2IebW1Uv777CuWKsBdzMOcOmsp9RzzO456TeVZLfvRC44
   jeHFMqOk/c8eMTghEot5sWqVkHMGk+lyPM6CDgObytK3jlfJUID0lkKBt
   +4iSK2Qsf/ABF5Xd78KtbnTdQJk1gG2Q701lbunUG4QlaKZOdHKAEAtV2
   t423y561TRLfKo6Ir2KHCuGiQeYHrkRf3rTyhv8Fofapvk0THoyiSIt3r
   7uf/BTV0KWuz8oU0ANQfXQgZckeWa3+cW9QQv0VPTMh7mF8bGzqhJuMSv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="151260039"
X-IronPort-AV: E=Sophos;i="6.06,208,1705330800"; 
   d="scan'208";a="151260039"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 19:29:15 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 130605EA65;
	Wed,  6 Mar 2024 19:29:10 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 52A3ED561A;
	Wed,  6 Mar 2024 19:29:09 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C51992030C7E2;
	Wed,  6 Mar 2024 19:29:08 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id D32BA1A006D;
	Wed,  6 Mar 2024 18:29:07 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: y-goto@fujitsu.com,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	hpa@zytor.com,
	Ingo Molnar <mingo@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	x86@kernel.org,
	kexec@lists.infradead.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 3/7] nvdimm: pmem: assign a parent resource for vmemmap region for the fsdax
Date: Wed,  6 Mar 2024 18:28:42 +0800
Message-Id: <20240306102846.1020868-4-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240306102846.1020868-1-lizhijian@fujitsu.com>
References: <20240306102846.1020868-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28234.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28234.006
X-TMASE-Result: 10--1.564400-10.000000
X-TMASE-MatchedRID: BlFNdihulaZXk4HjwySOxykMR2LAnMRpFInyGi5rPwK4GyTmeN+AbL8F
	Hrw7frluf146W0iUu2tDc4lSgrowpWptPhjDCRug9k5nZzZVBSBULRRq00o2mZsoi2XrUn/Jn6K
	dMrRsL14qtq5d3cxkNU8XOMKR+RhSziRYTTEaxycNH0kK2Y6lBnFLca4Td9YkovbRRC+8RtSqnf
	dPSmIOZvdj0cn+WGO3HBgXAGNBpen5KWrl6H4maf8jyjqYHnMRFcUQf3Yp/ridO0/GUi4gFb0fO
	PzpgdcEKeJ/HkAZ8Is=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

When the pmem is configured as fsdax, set the vmemmap region as a child
of the namespace region so that it can be registered as a separate
resource later.

CC: Dan Williams <dan.j.williams@intel.com>
CC: Vishal Verma <vishal.l.verma@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>
CC: Baoquan He <bhe@redhat.com>
CC: nvdimm@lists.linux.dev
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/nvdimm/pmem.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4e8fdcb3f1c8..b2640a3fb693 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -452,7 +452,7 @@ static int pmem_attach_disk(struct device *dev,
 	struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	int nid = dev_to_node(dev), fua;
-	struct resource *res = &nsio->res;
+	struct resource *res = &nsio->res, *parent;
 	struct range bb_range;
 	struct nd_pfn *nd_pfn = NULL;
 	struct dax_device *dax_dev;
@@ -491,12 +491,15 @@ static int pmem_attach_disk(struct device *dev,
 		fua = 0;
 	}
 
-	if (!devm_request_mem_region(dev, res->start, resource_size(res),
-				dev_name(&ndns->dev))) {
+	parent = devm_request_mem_region(dev, res->start, resource_size(res),
+				dev_name(&ndns->dev));
+	if (!res) {
 		dev_warn(dev, "could not reserve region %pR\n", res);
 		return -EBUSY;
 	}
 
+	pgmap_parent_resource(&pmem->pgmap, parent);
+
 	disk = blk_alloc_disk(nid);
 	if (!disk)
 		return -ENOMEM;
-- 
2.29.2


