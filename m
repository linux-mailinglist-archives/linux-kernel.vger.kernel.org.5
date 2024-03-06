Return-Path: <linux-kernel+bounces-93758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE0F873434
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12AD1C20A31
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DF76025A;
	Wed,  6 Mar 2024 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="rAs/UTvt"
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5415F875;
	Wed,  6 Mar 2024 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720957; cv=none; b=KRntji8LtN93TTIHrBwK4Yu8BzGCs2dlKKQoYOpJNfU1RprruJx91bQ+WL8rbhaYjKD83UUECoh2ft9c9S+avbu05ETPUTan5XvEEs/ohA94syZpz78FpbfhlLxQ8YHR6O839670PTSFanQOunqzgiDuWYU/McVNuOWy9UXe0e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720957; c=relaxed/simple;
	bh=qPTXg1j60dmCKgrUxhmFd4z9be0Rjp54MJE3FLxdEQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ASgwX8xLQ5MfPzaynZbnKYHoCxdbu+ItAPj0cwxpA3PontLamlbDfCGx7R1Fqo4hJ5Wl67oy42Qt/ToG7nYydWBYiFB1mhhhU9IvJjZ4XG7Wx5L/CxhWrWowg2lJ4VCKGlCk8jUg+Qr+ODUJ7ax/sJHoHVpSCS3x2QpJMsZWVns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=rAs/UTvt; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709720954; x=1741256954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qPTXg1j60dmCKgrUxhmFd4z9be0Rjp54MJE3FLxdEQM=;
  b=rAs/UTvtVtevHStPZqS/hThfRsybHUjXma0pC78BDFINNhebZIlrPoZL
   +PcnyrHNx6Um3ww2tV+uf1paGze/kb6YMj/jjcBiHBtbmDHNtZjy2FZZf
   RQqH+5Ph2k2I+lKZNqwD6xsgHkq+Orqwot3ViXIf/t5bgR8CdRIleRYfl
   aRjAaJlEONXcpm1Fs2Ut+No96KD8HJU4NpzBWrPbzVJzj4NnivU25OKqZ
   HbEMOK0bDFm+8F+Sr9+4aWzle9Jk2TWSYidEoSxofsLLhLYfZx7zR4Xl3
   ZzSS6vPKIcCqf96z6vCcqh4DkAVrtrAOEwkXLyjjPH9XKAuRyM4D5HrsH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="153205386"
X-IronPort-AV: E=Sophos;i="6.06,208,1705330800"; 
   d="scan'208";a="153205386"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 19:29:11 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3D3AEC68A0;
	Wed,  6 Mar 2024 19:29:09 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7DCD642613;
	Wed,  6 Mar 2024 19:29:08 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id EE62B6BED0;
	Wed,  6 Mar 2024 19:29:07 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 08E3D1A006A;
	Wed,  6 Mar 2024 18:29:06 +0800 (CST)
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
Subject: [PATCH v3 2/7] mm: memremap: add pgmap_parent_resource() helper
Date: Wed,  6 Mar 2024 18:28:41 +0800
Message-Id: <20240306102846.1020868-3-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10-1.178600-10.000000
X-TMASE-MatchedRID: a4Q7dosAlP6Po+6vQMop+ikMR2LAnMRpCZa9cSpBObnAuQ0xDMaXkH4q
	tYI9sRE/7qN2AY1LBYfX/4cXJB77G82IoAvAG8Cytw+xHnsmQjMRKrbwgeEU4psoi2XrUn/Jn6K
	dMrRsL14qtq5d3cxkNePDdA+sPJoJpIWVq2FPrVRC8PbPp9VJvAwE3szHrU0AtN2HcZBPqwdFSR
	N53IQttjRtl6ZG50f040PXgYNLw2sECcFYp/ZlI4xrU96OxkmsFcUQf3Yp/ridO0/GUi4gFb0fO
	PzpgdcEKeJ/HkAZ8Is=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

It's a helper to set the parent resource for the altmap of a given pgmap

CC: Andrew Morton <akpm@linux-foundation.org>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Baoquan He <bhe@redhat.com>
CC: linux-mm@kvack.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 include/linux/memremap.h | 1 +
 mm/memremap.c            | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index ca1f12353008..1e8b25352f7c 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -193,6 +193,7 @@ static inline bool folio_is_device_coherent(const struct folio *folio)
 void zone_device_page_init(struct page *page);
 void *memremap_pages(struct dev_pagemap *pgmap, int nid);
 void memunmap_pages(struct dev_pagemap *pgmap);
+void pgmap_parent_resource(struct dev_pagemap *pgmap, struct resource *res);
 void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
 void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
 struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
diff --git a/mm/memremap.c b/mm/memremap.c
index 78047157b0ee..0bbf163d4817 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -390,6 +390,13 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 }
 EXPORT_SYMBOL_GPL(memremap_pages);
 
+void pgmap_parent_resource(struct dev_pagemap *pgmap, struct resource *res)
+{
+	if (pgmap && res)
+		pgmap->altmap.parent = res;
+}
+EXPORT_SYMBOL_GPL(pgmap_parent_resource);
+
 /**
  * devm_memremap_pages - remap and provide memmap backing for the given resource
  * @dev: hosting device for @res
-- 
2.29.2


