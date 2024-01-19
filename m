Return-Path: <linux-kernel+bounces-30808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A823983248B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E610B20BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A32D527;
	Fri, 19 Jan 2024 06:21:14 +0000 (UTC)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56A4CA4A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705645273; cv=none; b=CkpF20GcSPQ92eULSicbHrfljCXyKhB+B9NPjHmysBB6V6GerruGeazJyb780a/njRi1vLfa13vjUGN6ZnvARNjVscBrOS9CZJpSzF/hRJCfQoLmtvFwynOT7AQ046TZqUW5+DsXmqBi+agVFuXY+NWQ+vBMk8nRFKUnNZVXMvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705645273; c=relaxed/simple;
	bh=2dXpWaC/gA+rQCGSdigv19bRkfr4cEkbCln5JNbcfiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mjZOJGdJ96nNG8HLWC+bnqbPU0FZyO/wliWX/cRpNsGbhgsG+N1sa1o8VsgZF5XWlQHEeCr/QVYlr352pnkWl0HCx6/VZx1KKd13gG9OYzdchWWT8+R5zhwsc/X+wblPfzw9nAo2kp2LGeCwvLG7YzRPBS+uxeXDVTbgXvq/p8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="148292404"
X-IronPort-AV: E=Sophos;i="6.05,204,1701097200"; 
   d="scan'208";a="148292404"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 15:21:07 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0E961D64B1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:21:05 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 41F56AA47D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:21:04 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id BF915200968EC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:21:03 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1946F1A015E;
	Fri, 19 Jan 2024 14:21:03 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr
Subject: [PATCH v2] coccinelle: device_attr_show: Adapt to the latest Documentation/filesystems/sysfs.rst
Date: Fri, 19 Jan 2024 14:20:57 +0800
Message-Id: <20240119062057.4026888-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28128.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28128.005
X-TMASE-Result: 10--8.997200-10.000000
X-TMASE-MatchedRID: VFz6FHT9KvIRC3tpysE8AO9kW9mxCQvttOtXYgbXjde+f7ap9DJaDSxz
	RYsJiUav/17ljwcNaRm5hiunv4GcSziJuiRnf5DQKiJEqUFWRggFeeAjqMW+l8ZgSaBgziUc2d8
	mtRIRsUMkfu0SYDUi3tk+AWND1SQ/1s1AHJ9E8eDfSQNpZkETVFLiJI6ntczPeGHkpR2WBaKp7E
	+IyeS1Xt9azz0zRbyE1mLuCemy7OOnhintEWTpJ65bb5QEYSkdLYdywTHl7nvZCDeKLir288tMy
	hlcs3zJTLP4m7if3GSdqC2fLtk9xB8TzIzimOwPC24oEZ6SpSkj80Za3RRg8JU8c6O2cgtdKkXm
	cQlIhgRkwIxiFgO1Jve1LKdTmTjePJuGM8tMGsU=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Adapt description, warning message and MODE=patch according to the latest
Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.

After this patch:
When MODE=report,
 $ make coccicheck COCCI=scripts/coccinelle/api/device_attr_show.cocci M=drivers/hid/hid-picolcd_core.c MODE=report
 <...snip...>
 drivers/hid/hid-picolcd_core.c:304:8-16: WARNING: please use sysfs_emit or sysfs_emit_at
 drivers/hid/hid-picolcd_core.c:259:9-17: WARNING: please use sysfs_emit or sysfs_emit_at

When MODE=patch,
 $ make coccicheck COCCI=scripts/coccinelle/api/device_attr_show.cocci M=drivers/hid/hid-picolcd_core.c MODE=patch
 <...snip...>
 diff -u -p a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
 --- a/drivers/hid/hid-picolcd_core.c
 +++ b/drivers/hid/hid-picolcd_core.c
 @@ -255,10 +255,12 @@ static ssize_t picolcd_operation_mode_sh
  {
         struct picolcd_data *data = dev_get_drvdata(dev);

 -       if (data->status & PICOLCD_BOOTLOADER)
 -               return snprintf(buf, PAGE_SIZE, "[bootloader] lcd\n");
 -       else
 -               return snprintf(buf, PAGE_SIZE, "bootloader [lcd]\n");
 +       if (data->status & PICOLCD_BOOTLOADER) {
 +               return sysfs_emit(buf, "[bootloader] lcd\n");
 +       }
 +       else {
 +               return sysfs_emit(buf, "bootloader [lcd]\n");
 +       }
  }

  static ssize_t picolcd_operation_mode_store(struct device *dev,
 @@ -301,7 +303,7 @@ static ssize_t picolcd_operation_mode_de
  {
         struct picolcd_data *data = dev_get_drvdata(dev);

 -       return snprintf(buf, PAGE_SIZE, "hello world\n");
 +       return sysfs_emit(buf, "hello world\n");
  }

  static ssize_t picolcd_operation_mode_delay_store(struct device *dev,

CC: Julia Lawall <Julia.Lawall@inria.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>
CC: cocci@inria.fr
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2:
- changed title from coccinelle: device_attr_show.cocci: update description and warning message
- Fix MODE=patch
- Extract patch from the patch set[1] so that maintainer can accept it separately.
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 scripts/coccinelle/api/device_attr_show.cocci | 22 +++++++++++--------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
index a28dc061653a..634514937e63 100644
--- a/scripts/coccinelle/api/device_attr_show.cocci
+++ b/scripts/coccinelle/api/device_attr_show.cocci
@@ -1,10 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 ///
 /// From Documentation/filesystems/sysfs.rst:
-///  show() must not use snprintf() when formatting the value to be
-///  returned to user space. If you can guarantee that an overflow
-///  will never happen you can use sprintf() otherwise you must use
-///  scnprintf().
+///  show() should only use sysfs_emit() or sysfs_emit_at() when formatting
+///  the value to be returned to user space.
 ///
 // Confidence: High
 // Copyright: (C) 2020 Denis Efremov ISPRAS
@@ -30,15 +28,21 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
 
 @rp depends on patch@
 identifier show, dev, attr, buf;
+expression BUF, SZ, FORMAT, STR;
 @@
 
 ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	<...
+(
 	return
--		snprintf
-+		scnprintf
-			(...);
+-		snprintf(BUF, SZ, FORMAT, STR);
++		sysfs_emit(BUF, FORMAT, STR);
+|
+	return
+-		snprintf(BUF, SZ, STR);
++		sysfs_emit(BUF, STR);
+)
 	...>
 }
 
@@ -46,10 +50,10 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
 p << r.p;
 @@
 
-coccilib.report.print_report(p[0], "WARNING: use scnprintf or sprintf")
+coccilib.report.print_report(p[0], "WARNING: please use sysfs_emit or sysfs_emit_at")
 
 @script: python depends on org@
 p << r.p;
 @@
 
-coccilib.org.print_todo(p[0], "WARNING: use scnprintf or sprintf")
+coccilib.org.print_todo(p[0], "WARNING: please use sysfs_emit or sysfs_emit_at")
-- 
2.29.2


