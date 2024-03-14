Return-Path: <linux-kernel+bounces-103082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850F887BACD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07DD72830A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119A26D1BB;
	Thu, 14 Mar 2024 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Vi30s2Rb"
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D34316C;
	Thu, 14 Mar 2024 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410322; cv=none; b=r0l5y0lRl+lWALzvZ8OoITCL12RKk3lY08xOteik84Blt+f1GaVWKhYSOIz0I5+cQbBn0s9uvX0FfaT7k58zqdUVMDg/RSBMJEeti6uqsA2Gb0IeqhavUC/HOzjmfQgwEFEFjor2e7A6vBPFiKLE9wrfdWjrE7n8FZenHokviWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410322; c=relaxed/simple;
	bh=sfMWZ8DddWL1BUlbNGcxm5ArLRc2O1z6QCNIA8SoAxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MOP729tjEYEY69DfL3vRf3dA7uwIX85eTCzseH8l1KcdDMDpyfIY6W91WloRn/VtXn0mfC2GJcido36S34gFklgpSOx0lxHW9EgteyVagrjIhDpJ1hsN5nSXucytG7USaMzdVnWVz06OIBm+tXmaoBk7uvEWhL+p7zduly1qkDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Vi30s2Rb; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710410319; x=1741946319;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sfMWZ8DddWL1BUlbNGcxm5ArLRc2O1z6QCNIA8SoAxU=;
  b=Vi30s2RblH4+b2FsXtU0GS9pIsUry3Hzq2xHHpAA5tDKLMbhYpUjPuWn
   JabN+QxRdye/OSRVVRje7oaXLANq0N/GHGy30ah4PCFJNjKFYcURm4a1n
   d/r8V/VP2ZEU83gJyN1bFXLIHaJhLmfhhcXlQhKniGHwEc0+sWM3zO9NU
   NMD/9M511tQ0yj9IQHpCTqFBUobvQSez5EdYBerHKaWsmT6TRvZCzkXPG
   VEQojZQtw4QNcZx6MIe4rJ8ezvSgbSSTL0iFLm/xXIH4kWLyj04pEw1Dh
   AKurprgbLbijwX8qwnkEJXNo+u3o/Rw0Qng/qRW/BW2V6OKyabkZBUTJV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="140719042"
X-IronPort-AV: E=Sophos;i="6.07,125,1708354800"; 
   d="scan'208";a="140719042"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:58:29 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0407ED772B;
	Thu, 14 Mar 2024 18:58:28 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3F0FCD3F01;
	Thu, 14 Mar 2024 18:58:27 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C4F8F20099547;
	Thu, 14 Mar 2024 18:58:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 087CE1A006B;
	Thu, 14 Mar 2024 17:58:26 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2] fbdev: uvesafb: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 17:58:13 +0800
Message-Id: <20240314095813.1326057-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28250.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28250.006
X-TMASE-Result: 10--7.635400-10.000000
X-TMASE-MatchedRID: /mcjwogdDrk4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbSrMZ+BqQt2NoUifIaLms/Ai99T+uJIleRfDo
	fTpsyCK+KztDhRgoFQW4suX2uLJTkj56IjTnLR+lO5y1KmK5bJRSLgSFq3Tnj31GU/N5W5BDIvl
	CZY6Ax8M4b571oAikePJ5LkgpVFu/+0jQufZU6FHaNJ/iTxXCafS0Ip2eEHnwj/1Rbkzl1E2nuo
	SGaY+DLjoczmuoPCq3KpKCvtpEvkcjF1BMed4zx9dOhdW325xZyoiRfQZLwqQ5tS3rRqe7L
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

CC: Helge Deller <deller@gmx.de>
CC: linux-fbdev@vger.kernel.org
CC: dri-devel@lists.freedesktop.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/video/fbdev/uvesafb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index e1f421e91b4f..73f00c079a94 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1546,7 +1546,7 @@ static ssize_t uvesafb_show_vbe_ver(struct device *dev,
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;
 
-	return snprintf(buf, PAGE_SIZE, "%.4x\n", par->vbe_ib.vbe_version);
+	return sysfs_emit(buf, "%.4x\n", par->vbe_ib.vbe_version);
 }
 
 static DEVICE_ATTR(vbe_version, S_IRUGO, uvesafb_show_vbe_ver, NULL);
-- 
2.29.2


