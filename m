Return-Path: <linux-kernel+bounces-26998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E4C82E8F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4221C22C46
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38A0125AE;
	Tue, 16 Jan 2024 04:53:34 +0000 (UTC)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4432D11720;
	Tue, 16 Jan 2024 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="133883811"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="133883811"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:19 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id BD51DC14A5;
	Tue, 16 Jan 2024 13:52:16 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 00802BF3E1;
	Tue, 16 Jan 2024 13:52:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9C27A200A7685;
	Tue, 16 Jan 2024 13:52:15 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 215F01A0160;
	Tue, 16 Jan 2024 12:52:15 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org
Subject: [PATCH 07/42] drivers/edac: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:16 +0800
Message-Id: <20240116045151.3940401-5-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240116045151.3940401-1-lizhijian@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.004
X-TMASE-Result: 10--8.447500-10.000000
X-TMASE-MatchedRID: CncXHiplHCc4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4RhtSayvMWoxbUakYaHXHZz0swHSFcVJ6MC5DTEMxpeQfiq
	1gj2xET8vYRhsicUjm84WYLmQfXYmSSOWVJeuO1AURSScn+QSXt0H8LFZNFG7bkV4e2xSge5Xcs
	c0MSekXi8N5a2VIb4Zbp46s/2fryZpi6pPdppleOulxyHOcPoH
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/edac/edac_mc_sysfs.c:210:8-16: WARNING: please use sysfs_emit
> ./drivers/edac/edac_mc_sysfs.c:518:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Borislav Petkov <bp@alien8.de>
CC: Tony Luck <tony.luck@intel.com>
CC: James Morse <james.morse@arm.com>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Robert Richter <rric@kernel.org>
CC: linux-edac@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/edac/edac_mc_sysfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 5116873c3330..6ee5030c7207 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -207,8 +207,7 @@ static ssize_t channel_dimm_label_show(struct device *dev,
 	if (!rank->dimm->label[0])
 		return 0;
 
-	return snprintf(data, sizeof(rank->dimm->label) + 1, "%s\n",
-			rank->dimm->label);
+	return sysfs_emit(data, "%s\n", rank->dimm->label);
 }
 
 static ssize_t channel_dimm_label_store(struct device *dev,
@@ -515,7 +514,7 @@ static ssize_t dimmdev_label_show(struct device *dev,
 	if (!dimm->label[0])
 		return 0;
 
-	return snprintf(data, sizeof(dimm->label) + 1, "%s\n", dimm->label);
+	return sysfs_emit(data, "%s\n", dimm->label);
 }
 
 static ssize_t dimmdev_label_store(struct device *dev,
-- 
2.29.2


