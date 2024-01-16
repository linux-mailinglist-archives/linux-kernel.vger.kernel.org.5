Return-Path: <linux-kernel+bounces-26978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5522C82E8C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98001C22534
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2BD1BDF4;
	Tue, 16 Jan 2024 04:52:34 +0000 (UTC)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F198493;
	Tue, 16 Jan 2024 04:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="125018765"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="125018765"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:20 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3F2F1D9D93;
	Tue, 16 Jan 2024 13:52:18 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6C420D4C3D;
	Tue, 16 Jan 2024 13:52:17 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 035646B4C5;
	Tue, 16 Jan 2024 13:52:17 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 7A3B11A0160;
	Tue, 16 Jan 2024 12:52:16 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	=?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-input@vger.kernel.org
Subject: [PATCH 11/42] drivers/hid: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:20 +0800
Message-Id: <20240116045151.3940401-9-lizhijian@fujitsu.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.005
X-TMASE-Result: 10--9.191800-10.000000
X-TMASE-MatchedRID: TWQD+6s80gM4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4TBF7stuNMMxuce7gFxhKa3BOVz0Jwcxl6vCrG0TnfVUilv
	Ab18i4hNTeKr01gQwdM4WYLmQfXYmpoPHQXywp1eeAiCmPx4NwHJnzNw42kCxxEHRux+uk8h+IC
	quNi0WJEL8FCMwqM38FrY9ClHoB7aesdE5CwuBX7I5/zNfZniYftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per Documentation/filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/hid/hid-picolcd_core.c:259:9-17: WARNING: please use sysfs_emit
> ./drivers/hid/hid-picolcd_core.c:304:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-sensor-custom.c:375:10-18: WARNING: please use sysfs_emi

No functional change intended

CC: "Bruno Prémont" <bonbons@linux-vserver.org>
CC: Jiri Kosina <jikos@kernel.org>
CC: Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC: Jonathan Cameron <jic23@kernel.org>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-input@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/hid/hid-picolcd_core.c  | 6 +++---
 drivers/hid/hid-sensor-custom.c | 3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)

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
diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index d85398721659..4fe8dccf671d 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -372,8 +372,7 @@ static ssize_t show_value(struct device *dev, struct device_attribute *attr,
 				     sizeof(struct hid_custom_usage_desc),
 				     usage_id_cmp);
 		if (usage_desc)
-			return snprintf(buf, PAGE_SIZE, "%s\n",
-					usage_desc->desc);
+			return sysfs_emit(buf, "%s\n", usage_desc->desc);
 		else
 			return sprintf(buf, "not-specified\n");
 	 } else
-- 
2.29.2


