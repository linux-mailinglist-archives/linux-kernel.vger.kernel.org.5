Return-Path: <linux-kernel+bounces-26997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DFE82E8EF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9993284DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0F211CA9;
	Tue, 16 Jan 2024 04:53:34 +0000 (UTC)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26071171E;
	Tue, 16 Jan 2024 04:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="125645468"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="125645468"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:20 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 85CBDC14A5;
	Tue, 16 Jan 2024 13:52:17 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id AEBB4BF3FC;
	Tue, 16 Jan 2024 13:52:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4BFBC6B4C7;
	Tue, 16 Jan 2024 13:52:16 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id D68F01A0161;
	Tue, 16 Jan 2024 12:52:15 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org
Subject: [PATCH 09/42] drivers/hid/hid-lenovo: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:18 +0800
Message-Id: <20240116045151.3940401-7-lizhijian@fujitsu.com>
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
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.005
X-TMASE-Result: 10--8.440000-10.000000
X-TMASE-MatchedRID: R1u6Jncx2x04ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4TBF7stuNMMxTuctSpiuWyUUi4Ehat0546MQi364g884JmV
	7j1WQqoeX81JAaXNO9negIXkiA/apHxPMjOKY7A8LbigRnpKlKSPzRlrdFGDwJh5lryUC0+jUrH
	d8FT6b0HReObJMOgmzR5gvrzvL35ST76aKysvrqA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/hid/hid-lenovo.c:558:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-lenovo.c:602:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-lenovo.c:792:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-lenovo.c:822:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-lenovo.c:852:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-lenovo.c:882:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-lenovo.c:912:8-16: WARNING: please use sysfs_emit
> ./drivers/hid/hid-lenovo.c:941:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Jiri Kosina <jikos@kernel.org>
CC: Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC: linux-input@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/hid/hid-lenovo.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 149a3c74346b..26768c319361 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -555,7 +555,7 @@ static ssize_t attr_fn_lock_show(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data->fn_lock);
+	return sysfs_emit(buf, "%u\n", data->fn_lock);
 }
 
 static ssize_t attr_fn_lock_store(struct device *dev,
@@ -599,8 +599,7 @@ static ssize_t attr_sensitivity_show_cptkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-		cptkbd_data->sensitivity);
+	return sysfs_emit(buf, "%u\n", cptkbd_data->sensitivity);
 }
 
 static ssize_t attr_sensitivity_store_cptkbd(struct device *dev,
@@ -789,7 +788,7 @@ static ssize_t attr_press_to_select_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->press_to_select);
+	return sysfs_emit(buf, "%u\n", data_pointer->press_to_select);
 }
 
 static ssize_t attr_press_to_select_store_tpkbd(struct device *dev,
@@ -819,7 +818,7 @@ static ssize_t attr_dragging_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->dragging);
+	return sysfs_emit(buf, "%u\n", data_pointer->dragging);
 }
 
 static ssize_t attr_dragging_store_tpkbd(struct device *dev,
@@ -849,7 +848,7 @@ static ssize_t attr_release_to_select_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->release_to_select);
+	return sysfs_emit(buf, "%u\n", data_pointer->release_to_select);
 }
 
 static ssize_t attr_release_to_select_store_tpkbd(struct device *dev,
@@ -879,7 +878,7 @@ static ssize_t attr_select_right_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->select_right);
+	return sysfs_emit(buf, "%u\n", data_pointer->select_right);
 }
 
 static ssize_t attr_select_right_store_tpkbd(struct device *dev,
@@ -909,8 +908,7 @@ static ssize_t attr_sensitivity_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-		data_pointer->sensitivity);
+	return sysfs_emit(buf, "%u\n", data_pointer->sensitivity);
 }
 
 static ssize_t attr_sensitivity_store_tpkbd(struct device *dev,
@@ -938,8 +936,7 @@ static ssize_t attr_press_speed_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-		data_pointer->press_speed);
+	return sysfs_emit(buf, "%u\n", data_pointer->press_speed);
 }
 
 static ssize_t attr_press_speed_store_tpkbd(struct device *dev,
-- 
2.29.2


