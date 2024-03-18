Return-Path: <linux-kernel+bounces-105623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E174387E1B1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8DC1C21646
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305361E521;
	Mon, 18 Mar 2024 01:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="iJNKrvXy"
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB56620315;
	Mon, 18 Mar 2024 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725344; cv=none; b=svyO/6Fve8TdebYadUzBFVZWDWlvkFx+cyC8JHDg3xJqv82WvttLqsOZMBoPDUgrLG5w30MKppxwFLmMKPuiKon84K54P4ZToSsIIJSoGu/T1qNg1Ko1wckk6fEb6lJ10+49D3WL6nxBxQdL/MGCP4d3TUpUl2owL/DV+kOEEjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725344; c=relaxed/simple;
	bh=sWMzTX+WKIOYjsKJ3pC9JRzU1Tnb4gFE0gGTkrrStlM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jFYBUhLGRaYHqMQQ4qcfqoTicIY6gOujb+SZqum6Cm/y2lARe07guYLvVCeWwcu6WalgeqQHUXO7X77nlxcwoTrZuEDbJzKqORcwwGk8N74mF4if20vGFar2oc+ZrS6zOPAlO5RbvbgSwLOWbnAWCbcT0Fz7/3lzbW+ZZzDtV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=iJNKrvXy; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710725338; x=1742261338;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sWMzTX+WKIOYjsKJ3pC9JRzU1Tnb4gFE0gGTkrrStlM=;
  b=iJNKrvXyWxc5HrdViQBEdVB0XfgBsFumeqRIvw4KckYyKf44thupKyJY
   HzoWbzWQb+VI0wPMMd/JyXn/xWdhsHroprf5JOZz5bP2aD/7S9eyR/pEv
   XoBT5hEnNeWVp4ydfPKLNyXWskArJ/rzintOWS9LpGqqJQ0qlOEbfCsnI
   ToC0cZ7n4a1AWS8kVG8x9DR532+3q1tMCRYh1gmL2TbvPTJaiQfrT+zpB
   8pX6h5vnf8OVBN2Puec+5aoevodo2biJ626+IJneXmhOhkS9ePPISrh0S
   Rynwr/W5s+EBIDNoBGXaToT4wAAR8rwukd7Ed4N90nx78kSiy/mkfsUHO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="131848935"
X-IronPort-AV: E=Sophos;i="6.07,133,1708354800"; 
   d="scan'208";a="131848935"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 10:28:49 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id CEBBF8CAB7;
	Mon, 18 Mar 2024 10:28:48 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 11E8DD7B62;
	Mon, 18 Mar 2024 10:28:48 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 993C820099077;
	Mon, 18 Mar 2024 10:28:47 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id D25FC1A006A;
	Mon, 18 Mar 2024 09:28:46 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	=?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org
Subject: [PATCH v3 1/4] HID: hid-picolcd*: Convert sprintf/scnprintf to sysfs_emit/sysfs_emit_at
Date: Mon, 18 Mar 2024 09:28:16 +0800
Message-Id: <20240318012819.1405003-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28258.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28258.003
X-TMASE-Result: 10--6.761100-10.000000
X-TMASE-MatchedRID: LFhZ4D3QpawbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/0swHSFcVJ6C99T+uJIleRfDo
	fTpsyCK+KztDhRgoFQW4suX2uLJTkj56IjTnLR+m5x7uAXGEprcE5XPQnBzGXq8KsbROd9VSArq
	oIZrVn15fzUkBpc072g7QwQAwSFa5jAM4vu3dHIRVqL8+WwS7mrzl8sNiWClKbKItl61J/yZkw8
	KdMzN86KrauXd3MZDXMVsUCOz7QOSWi+yl7sqIrr8WvsDVNzOZOREIpxgAYfEmK2G5nwn4k
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

scnprintf() will be converted as weel if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: "Bruno Prémont" <bonbons@linux-vserver.org>
CC: Jiri Kosina <jikos@kernel.org>
CC: Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC: linux-input@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3:
   Covert more file(drivers/hid/hid-picolcd_fb.c) as suggested by Bruno

This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/hid/hid-picolcd_core.c | 6 +++---
 drivers/hid/hid-picolcd_fb.c   | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
index bbda231a7ce3..fa46fb6eab3f 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -256,9 +256,9 @@ static ssize_t picolcd_operation_mode_show(struct device *dev,
 	struct picolcd_data *data = dev_get_drvdata(dev);
 
 	if (data->status & PICOLCD_BOOTLOADER)
-		return snprintf(buf, PAGE_SIZE, "[bootloader] lcd\n");
+		return sysfs_emit(buf, "[bootloader] lcd\n");
 	else
-		return snprintf(buf, PAGE_SIZE, "bootloader [lcd]\n");
+		return sysfs_emit(buf, "bootloader [lcd]\n");
 }
 
 static ssize_t picolcd_operation_mode_store(struct device *dev,
@@ -301,7 +301,7 @@ static ssize_t picolcd_operation_mode_delay_show(struct device *dev,
 {
 	struct picolcd_data *data = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%hu\n", data->opmode_delay);
+	return sysfs_emit(buf, "%hu\n", data->opmode_delay);
 }
 
 static ssize_t picolcd_operation_mode_delay_store(struct device *dev,
diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index d7dddd99d325..369c78d70e66 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -424,9 +424,9 @@ static ssize_t picolcd_fb_update_rate_show(struct device *dev,
 		if (ret >= PAGE_SIZE)
 			break;
 		else if (i == fb_update_rate)
-			ret += scnprintf(buf+ret, PAGE_SIZE-ret, "[%u] ", i);
+			ret += sysfs_emit_at(buf, ret, "[%u] ", i);
 		else
-			ret += scnprintf(buf+ret, PAGE_SIZE-ret, "%u ", i);
+			ret += sysfs_emit_at(buf, ret, "%u ", i);
 	if (ret > 0)
 		buf[min(ret, (size_t)PAGE_SIZE)-1] = '\n';
 	return ret;
-- 
2.29.2


