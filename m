Return-Path: <linux-kernel+bounces-103004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F96B87B9A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA40D1F21EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E526D1D2;
	Thu, 14 Mar 2024 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="NsZXi7gh"
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45DE6D1BA;
	Thu, 14 Mar 2024 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406114; cv=none; b=IwF5G+xa6yxCQEAedu9qUqa/VuQ1I4dWyzub7RtUi0n8dKMCgcZrzFHIkZD8V9J+V9fl/b5jMZDZ/TJs+DX2+isQKWZsUWRyXbXUkHtBRmURGy5werzKPl68Upoaf673KOR90dUGDiNB2oQIHzjPVmDHAxA9pJC9Q94mGwzT5mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406114; c=relaxed/simple;
	bh=YOAEyGIpIolggEIaKy09TZkyAs0fEy1LJ/3JBy7PUmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CCdpxJxLolG4ks6HfECbv4tBW5WKXueNT3S/HqsdHYy07V/c3oUrFBTepD12Usq3G6G7GpL2yMotEWd+6VGXpA2BgiQAvprOc7xECh4dhscj5dLn3Sgou99TCpI9oeWTpZ9qrM0WpmSJZGIGxRVdV9t1B3HJN11O2HDZRr/7/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=NsZXi7gh; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710406112; x=1741942112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YOAEyGIpIolggEIaKy09TZkyAs0fEy1LJ/3JBy7PUmc=;
  b=NsZXi7ghJRa0giMm4o4v9ajv46GvcPzfq5iC7lpuoNSAoCV+aeqoe109
   CddpfRihADhc/AetukugVyFGYGQGNeCqAmpN1GTr7DC9xd3LzkwmN/Xz3
   cPLWRI41bSKOovC2/RQEncoGEcPSvFB/Jo5ycFrhOmmHke3vizXQeYYf7
   P2zYU/02UWXfmRg5tKz6SLxVpukERAzrKyILidag8a8+51U/2ro0hmVJZ
   oSPyrVPQf3H+vk9Jq5cFbyXTaJxzEbdKaTToxvpkBF9eGwtr8sTDpazfS
   fNO46Mv1Tj3FVTR+RMvd/NuWGP/OBcJxcAgxXneCIjMh2FP5pcDwB7lXw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="152123891"
X-IronPort-AV: E=Sophos;i="6.07,124,1708354800"; 
   d="scan'208";a="152123891"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 17:48:29 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id B4A32D4804;
	Thu, 14 Mar 2024 17:48:26 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id B1AA4D41A2;
	Thu, 14 Mar 2024 17:48:25 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 444DB6B4C3;
	Thu, 14 Mar 2024 17:48:25 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id CEF071A006D;
	Thu, 14 Mar 2024 16:48:24 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org
Subject: [PATCH v2 4/4] HID: corsair/lenovo: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 16:47:53 +0800
Message-Id: <20240314084753.1322110-4-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240314084753.1322110-1-lizhijian@fujitsu.com>
References: <20240314084753.1322110-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--5.330400-10.000000
X-TMASE-MatchedRID: e6WPXQD7Ri84ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbSrMZ+BqQt2NpBHuVYxc8DW3hh5KUdlgWiKqF
	q1hn3Eb3d+/nM3Koh0iaTw03n/wYORY1tl9vG/AZO5y1KmK5bJRSLgSFq3Tnj31GU/N5W5BDIvl
	CZY6Ax8PdcQ4/ZOO0Rnagtny7ZPcQfE8yM4pjsDwtuKBGekqUpI/NGWt0UYPCz9x0dfDco3PrWb
	+TbRs25Nc1rvvLL57qtLEbAXwJJsibONta81gX5
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

CC: Jiri Kosina <jikos@kernel.org>
CC: Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC: linux-input@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/hid/hid-corsair.c |  4 ++--
 drivers/hid/hid-lenovo.c  | 22 +++++++++++-----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 8c895c820b67..702f50e9841d 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -298,7 +298,7 @@ static ssize_t k90_show_macro_mode(struct device *dev,
 		goto out;
 	}
 
-	ret = snprintf(buf, PAGE_SIZE, "%s\n", macro_mode);
+	ret = sysfs_emit(buf, "%s\n", macro_mode);
 out:
 	kfree(data);
 
@@ -367,7 +367,7 @@ static ssize_t k90_show_current_profile(struct device *dev,
 		goto out;
 	}
 
-	ret = snprintf(buf, PAGE_SIZE, "%d\n", current_profile);
+	ret = sysfs_emit(buf, "%d\n", current_profile);
 out:
 	kfree(data);
 
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 149a3c74346b..97f8d01cadcd 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -555,7 +555,7 @@ static ssize_t attr_fn_lock_show(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data->fn_lock);
+	return sysfs_emit(buf, "%u\n", data->fn_lock);
 }
 
 static ssize_t attr_fn_lock_store(struct device *dev,
@@ -599,8 +599,8 @@ static ssize_t attr_sensitivity_show_cptkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-		cptkbd_data->sensitivity);
+	return sysfs_emit(buf, "%u\n",
+			  cptkbd_data->sensitivity);
 }
 
 static ssize_t attr_sensitivity_store_cptkbd(struct device *dev,
@@ -789,7 +789,7 @@ static ssize_t attr_press_to_select_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->press_to_select);
+	return sysfs_emit(buf, "%u\n", data_pointer->press_to_select);
 }
 
 static ssize_t attr_press_to_select_store_tpkbd(struct device *dev,
@@ -819,7 +819,7 @@ static ssize_t attr_dragging_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->dragging);
+	return sysfs_emit(buf, "%u\n", data_pointer->dragging);
 }
 
 static ssize_t attr_dragging_store_tpkbd(struct device *dev,
@@ -849,7 +849,7 @@ static ssize_t attr_release_to_select_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->release_to_select);
+	return sysfs_emit(buf, "%u\n", data_pointer->release_to_select);
 }
 
 static ssize_t attr_release_to_select_store_tpkbd(struct device *dev,
@@ -879,7 +879,7 @@ static ssize_t attr_select_right_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->select_right);
+	return sysfs_emit(buf, "%u\n", data_pointer->select_right);
 }
 
 static ssize_t attr_select_right_store_tpkbd(struct device *dev,
@@ -909,8 +909,8 @@ static ssize_t attr_sensitivity_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-		data_pointer->sensitivity);
+	return sysfs_emit(buf, "%u\n",
+			  data_pointer->sensitivity);
 }
 
 static ssize_t attr_sensitivity_store_tpkbd(struct device *dev,
@@ -938,8 +938,8 @@ static ssize_t attr_press_speed_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-		data_pointer->press_speed);
+	return sysfs_emit(buf, "%u\n",
+			  data_pointer->press_speed);
 }
 
 static ssize_t attr_press_speed_store_tpkbd(struct device *dev,
-- 
2.29.2


