Return-Path: <linux-kernel+bounces-93764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E68B87343F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A0A28AFA8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8564760B97;
	Wed,  6 Mar 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="T2B9GnSe"
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1B26086E;
	Wed,  6 Mar 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721028; cv=none; b=VfxgMsqLeYTuUT+S3YWUi3rH7zgRxVZQIdsTXvrpOF2J8H6KT+ASKBkMVzWL6WUq4jKa2aYJOIU93+XOqT6+Qx2MxRT84RekScPazdiMO6NtGu86Il1ePnDPvLlC8FootHC1pwxS58cM+9mZzOQVUtmMqFUu6CFYHHKuolTaEsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721028; c=relaxed/simple;
	bh=ZZY/OmJnWGlv4sXJ9ctR7zLIBkL6jlFxWOynKDfrnCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B8+1lryIPDqSL5mClX5lNhuprzmp0Y0nfRo3Uqrlk62U58d58/Uuge5qxVTgO4GUKAQAiU3FTzcxrKtqDqFQ/2lrjeHz4VFTXuHjwhcllRjgW/1MmBgRu5VQ13+VxWl3/RxtoLDhkAeDA79oJTqqDgNwTj8bivgb97nGAKOXILs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=T2B9GnSe; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709721026; x=1741257026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZZY/OmJnWGlv4sXJ9ctR7zLIBkL6jlFxWOynKDfrnCI=;
  b=T2B9GnSeb85UdGtzWKDyox6Dtkl+rX8uFeJKgr9LtGFandWmQzdRG2PW
   vv/1C7vCqx5cXXfifQi4FXmnsheFdCJL4qRdgVGC883DKvJJmsaN70QlU
   VnzCq8z3nq3oYoAWCXg6mr7M3smvrAYZ0YsanQ0L8qHDKCSgrRPq75Jj9
   M8ObLQ8gjOPe0yDrGukkhDZ/012StW7yjU3e6oOI4rlrhyazbJTasXfXj
   WWprqB9yA/z+en5Du5dYS9TfbrkFWk7DkBy9JiRyM/nY6eJyYrrqecbrA
   r2irn/0XHnaIe8JxFE45UatpG0yGlgWKd3yURHyLbdVh7lLk4Mz39wvjH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="151690186"
X-IronPort-AV: E=Sophos;i="6.06,208,1705330800"; 
   d="scan'208";a="151690186"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 19:29:14 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 111A5EB462;
	Wed,  6 Mar 2024 19:29:11 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3D8F5BF3C9;
	Wed,  6 Mar 2024 19:29:10 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9BBCD2030C7E9;
	Wed,  6 Mar 2024 19:29:09 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id A5E001A006A;
	Wed,  6 Mar 2024 18:29:08 +0800 (CST)
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
Subject: [PATCH v3 4/7] dax: pmem: assign a parent resource for vmemmap region for the devdax
Date: Wed,  6 Mar 2024 18:28:43 +0800
Message-Id: <20240306102846.1020868-5-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--5.083400-10.000000
X-TMASE-MatchedRID: Q3OJUoK6MKVXk4HjwySOxykMR2LAnMRpFInyGi5rPwK4GyTmeN+AbD13
	GoPFA1HFIvrftAIhWmLy9zcRSkKatS9AD6DbcToHEVuC0eNRYvKZIt4iAQN6P6oDeu6wu7bqj26
	lKB/EzKHoHOpl9ZcDR4Ay6p60ZV62fJ5/bZ6npdg7AFczfjr/7Cf8pL7Z+mamZiZ008tHBX0M7U
	m3uTFNcAFzvFI3lI92rZlDJo+ExYU=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

When the pmem is configured as devdax, set the vmemmap region as a child
of the namespace region so that it can be registered as a separate
resource later.

CC: Dan Williams <dan.j.williams@intel.com>
CC: Vishal Verma <vishal.l.verma@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>
CC: Baoquan He <bhe@redhat.com>
CC: nvdimm@lists.linux.dev
CC: linux-cxl@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/dax/pmem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index f3c6c67b8412..6ffeb81e6c7c 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -21,6 +21,7 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 	struct nd_dax *nd_dax = to_nd_dax(dev);
 	struct nd_pfn *nd_pfn = &nd_dax->nd_pfn;
 	struct nd_region *nd_region = to_nd_region(dev->parent);
+	struct resource *parent;
 
 	ndns = nvdimm_namespace_common_probe(dev);
 	if (IS_ERR(ndns))
@@ -39,8 +40,9 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 	pfn_sb = nd_pfn->pfn_sb;
 	offset = le64_to_cpu(pfn_sb->dataoff);
 	nsio = to_nd_namespace_io(&ndns->dev);
-	if (!devm_request_mem_region(dev, nsio->res.start, offset,
-				dev_name(&ndns->dev))) {
+	parent = devm_request_mem_region(dev, nsio->res.start, offset,
+				dev_name(&ndns->dev));
+	if (!parent) {
 		dev_warn(dev, "could not reserve metadata\n");
 		return ERR_PTR(-EBUSY);
 	}
@@ -66,6 +68,8 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 		.memmap_on_memory = false,
 	};
 
+	pgmap_parent_resource(&pgmap, parent);
+
 	return devm_create_dev_dax(&data);
 }
 
-- 
2.29.2


