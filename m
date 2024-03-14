Return-Path: <linux-kernel+bounces-102986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C6787B97A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0533BB23665
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6756F6BFA8;
	Thu, 14 Mar 2024 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="dqgQCVju"
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB43C6BFA4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405947; cv=none; b=g8i55qqdnArHFFKjUCrr60X04502iYtzLjsVchgjvMgGmXZH1TSXKeUCQavuDdfHbHpNqt8h0fRr4mO+Ttd7rucT4k7wmK/LNrjeSMzZClHd3AX8efcOv7FHxx0vY+V1zcTJ0Z/GIJ0FedURW8D47RpM4GKT66wayrso+4SIDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405947; c=relaxed/simple;
	bh=9WQAz3rD2IyXPBujVpJTYZ17EvpN0LwlrHiLqyPln+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LzJxJTY7FAh+WxfbkdAZSJPd0ztwqU9ueakpfTuTXoC87oAwCqbuN9vPCtdnT3nKZFFN3Rn7tLfG/RLLnPJZ2fSd2/mePLMgCABhiTUKl+S0RYa2Nc+PGqKBeWps9OFQNCYxqF0A3cLoxtJUu+8IKIQSMmUHFztCyYrj/qQ9B8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=dqgQCVju; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710405944; x=1741941944;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9WQAz3rD2IyXPBujVpJTYZ17EvpN0LwlrHiLqyPln+8=;
  b=dqgQCVjuhDABiTzwwposmMaZG4+9DY8c5eI+1bZs7CtAEbPDRTu7yKML
   frze/S+z0eIq2JAMOfMauGfP6bohARs+/Auo00Delrttacsn7mzOU/t/s
   kPtPttcOCnhe3qozniDu9LoB2fFUnc6fKEwVddUh4q5wZ6ICVaQiyjg3q
   32y7PnQCIFEE2FYdDYeFPAgzSsTwjgq6yZ+sPd2zuSS3O+kHs8Pw6yxBZ
   AdIYHEY5rJSgZvIj3jTLPOZ9tii4kXyTmmKyRjn/gPfHBrLpk/iYGCJCw
   rUFsWaQJTxkLtkc1nk6UUNNb1WB43w0jtui2d7SJo77t15n5lSsRXaQf2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="152526830"
X-IronPort-AV: E=Sophos;i="6.07,124,1708354800"; 
   d="scan'208";a="152526830"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 17:45:36 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id A6DADE95F8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:45:34 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id E2B39E67B0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:45:33 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 784C3200932DD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:45:33 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 067F11A006B;
	Thu, 14 Mar 2024 16:45:32 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2] bus: fsl-mc: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 16:45:26 +0800
Message-Id: <20240314084526.1321901-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28250.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28250.005
X-TMASE-Result: 10--7.832300-10.000000
X-TMASE-MatchedRID: st9CF01730Y4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbS/sUSFaCjTLxN8rmPQRlvK7oFQ8GRC1Prs1w
	waYBQLgs9/vFVBxxqgB0XJlVTsEsboYY7KoErjW8ReM8i8p3vgEyQ5fRSh265uBsk5njfgGzYJp
	3mzrbmsPdcQ4/ZOO0Rnagtny7ZPcQfE8yM4pjsD7q9UFRTJ0kKxEHRux+uk8h+ICquNi0WJMTY8
	NuM7QdJigMwZENcOYsaKlkW7ZMJIAbe2YnZmb6EftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() will be converted as weel if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: Stuart Yoder <stuyoder@gmail.com>
CC: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 78b96cd63de9..a91bd714f24c 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -175,7 +175,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 
-	return sprintf(buf, "fsl-mc:v%08Xd%s\n", mc_dev->obj_desc.vendor,
+	return sysfs_emit(buf, "fsl-mc:v%08Xd%s\n", mc_dev->obj_desc.vendor,
 		       mc_dev->obj_desc.type);
 }
 static DEVICE_ATTR_RO(modalias);
@@ -202,7 +202,7 @@ static ssize_t driver_override_show(struct device *dev,
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", mc_dev->driver_override);
+	return sysfs_emit(buf, "%s\n", mc_dev->driver_override);
 }
 static DEVICE_ATTR_RW(driver_override);
 
-- 
2.29.2


