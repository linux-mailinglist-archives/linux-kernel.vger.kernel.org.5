Return-Path: <linux-kernel+bounces-93763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3362687343D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0031C2146C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A596087C;
	Wed,  6 Mar 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="iPICOJf1"
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1D460884;
	Wed,  6 Mar 2024 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721027; cv=none; b=O1SuDqs3FGC1wblVnvsezjRJlYNX+W4XoKMhtFXaK9Z2yUI6HL1ehUE4NWkRBoaYqcT/oUjO66m+/pdPxMSsodnR++kXGDUkvRZ33ImzQ28Y4Dbx0lBnw0Pa+laW/EwRGHLH+3+bfCFE/EZCXXSJ7uq7ye7WE6bTH7nIk26oW6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721027; c=relaxed/simple;
	bh=cfFr9yDzIDYGuhO0ed+4EUdT/tYXSwMTNGM6ftOGOr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KiHnaRAvmceLB8lQ7r6w0VqCPLYmLOlOa3Ew8zZLsen3wIXhsNtOAtbpQ444tWWfqUME/qzdkN0u2FyhgGgrYVggk8Vqgi5dFHOtCosJJERRfP+7wUCXf3tWc71MbB93IvyD77aXx4Z7xdTU4pBxt1j1aOBBe7hpjynFF4SFPeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=iPICOJf1; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709721026; x=1741257026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cfFr9yDzIDYGuhO0ed+4EUdT/tYXSwMTNGM6ftOGOr0=;
  b=iPICOJf1fqp4Wfpct96UMCXzc8EOcm2ntWhK3uNMb5/CTf0R8orAGyCZ
   Wy5z3B7TvEVSha5jD1jPhwH75Ei6e72IGhUT/6H38+iIPBu7qNI+ur+ip
   aNWcrGigNH7elrIcEya5Gz3WvSR6h03a5xKFyC9mn+YQvvARQDEhjCG7W
   Dd8K9bHohlbl+hdP66IGYxAM6nkCm8Qh88SDnnkmk+b9LH7GbMp3BftLJ
   Q57/giUxjdIbe16sNsncpMyC07Zg18coRq2BX5Ji4c05Uzux7p7VcTEQ5
   Q/dkqn9bjL2daeNRD0tVr1l9PXfDJb8Dh5BOv8lob4JxkDLVwyfK82pqN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="151395784"
X-IronPort-AV: E=Sophos;i="6.06,208,1705330800"; 
   d="scan'208";a="151395784"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 19:29:16 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 56AE2C691A;
	Wed,  6 Mar 2024 19:29:13 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 802A8575BF;
	Wed,  6 Mar 2024 19:29:12 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1676D2030C7E9;
	Wed,  6 Mar 2024 19:29:12 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1E80D1A006D;
	Wed,  6 Mar 2024 18:29:11 +0800 (CST)
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
Subject: [PATCH v3 7/7] nvdimm: set force_raw=1 in kdump kernel
Date: Wed,  6 Mar 2024 18:28:46 +0800
Message-Id: <20240306102846.1020868-8-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10-2.938000-10.000000
X-TMASE-MatchedRID: MGSvkkc+rOj7w6uw5pqYnoOlbll4OMtk9LMB0hXFSeg6Zx3YUNQTG+Wh
	NKYuM7eN4QRvjxz49tHS7j6TEIEt1D3TQfUpAv1sPkILbTHNp5vYUDvAr2Y/17fYIuZsOQ0sOXB
	2cqV0mCIre4xpX839SBGJgBWjZYF4x7Pq8adLcfrum6Nvy6t3NlK6+0HOVoSowLkNMQzGl5B+Kr
	WCPbERP80Age9hS2jaRMoI0qlZNIJF28kU6TjvF869emDs42ddfS0Ip2eEHnz3IzXlXlpamPoLR
	4+zsDTtqrM46JQnL8hECPUxiiiZOrOyZvt4D+xsOs3xt1PQttJyHuAILm2j36P9W6TbIoRbP/Sq
	eQCjGYXssHsZ3G5ixlOiTS2pFc4fpGuqGtYITgaGk+xUaqdMDwHEKwHwYevbwUSxXh+jiUgkww/
	gwY7hMA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

The virtually mapped memory map allows storing struct page objects for
persistent memory devices in pre-allocated storage on those devices.
These 'struct page objects' on devices are also known as metadata.

During libnvdimm/nd_pmem are loading, the previous metadata will
be re-constructed to fit the current running kernel. For kdump purpose,
these metadata should not be touched until the dumping is done so that
the metadata is identical.

To achieve this, we have some options
1. Don't provide libnvdimm driver in kdump kernel rootfs/initramfs
2. Disable libnvdimm driver by specific comline parameters:
   (initcall_blacklist=libnvdimm_init libnvdimm.blacklist=1 rd.driver.blacklist=libnvdimm)
3. Enforce force_raw=1 for nvdimm namespace, because when force_raw=1,
   metadata will not be re-constructed again. This may also result in
   the pmem doesn't work before a few extra configurations.

Here apply the 3rd option.

CC: Dan Williams <dan.j.williams@intel.com>
CC: Vishal Verma <vishal.l.verma@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>
CC: nvdimm@lists.linux.dev
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/nvdimm/namespace_devs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index d6d558f94d6b..04f855c7f0b1 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/nd.h>
+#include <linux/crash_dump.h>
 #include "nd-core.h"
 #include "pmem.h"
 #include "pfn.h"
@@ -1513,6 +1514,8 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 			return ERR_PTR(-ENODEV);
 	}
 
+	if (is_kdump_kernel())
+		ndns->force_raw = true;
 	return ndns;
 }
 EXPORT_SYMBOL(nvdimm_namespace_common_probe);
-- 
2.29.2


